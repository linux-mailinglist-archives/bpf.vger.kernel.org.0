Return-Path: <bpf+bounces-75520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8B1C87A47
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 02:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C3364E8E9F
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 01:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE6B2F39CD;
	Wed, 26 Nov 2025 01:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGRoUw4w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FF61F9F7A
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 01:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764119313; cv=none; b=YlNVKvJNHUScF8h3WihBGlN/iKUsYeMxVE4LGmZ2lJn8u4oCVIazJwdAYJH9RhUXwTPuYdqn9YVUsDe0S1DdPDDD6JLzBoQPaBd1TNOHmPshQv3Aw4Pgs4SW4x4hXXdvUlBo2SyBrCh4BF/aFRJ/0xKIIbPTyPSjWd0FzLATasE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764119313; c=relaxed/simple;
	bh=qGR5sefQg32LQ3hhTnRZYyhaV7WKbliA5YNanSMxxwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+LfeuZIpRxiyV4Dz14vNg9SmGOoAufgOtB9729mfrnjVAkltYTtxUck5pGtkaGka18GUVVAVDEHft6tFj5g2FJN8VHY0dtTfNtp9chAodS+M29JpPc/MxxUx3BCHUHtZDRj1gE7603rT1yL5ChGneYble6LWGuSUil25K4q6jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGRoUw4w; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5957db5bdedso6400575e87.2
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 17:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764119310; x=1764724110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RPke9ePUWIJpnNLmmVA+cr1L6xKsPBiMVIzyNRr3D9I=;
        b=iGRoUw4wsYljZyVbOJ7ZCdNoF9ngRojwLLXrLdV4niLovcInNsgBEMRXtjUnFHPoBu
         g7TX5ARZBJVtstFyVrapqggeG2LgrCut5rmcEk57/mS1uCrhERO1wh4wonX6mcqiCpOu
         o3+Y9vrPTIBCJ3K6ps2xZdVjiioMC67ZrHLDsW2xue/F1dzhi93D3xSt+QCy90QjvHLq
         zoIPViJoNzWLWYRLHLrA+Vf1ZOTu2kZBNx2qEmZ1wv8cy8vBy3odlztr68cFciasedQ4
         om7YQXGqEfQ0xAV3Gp8Wekss4eJ0PwlG+Pn/U/ssezxbwp6ea/ESJ5LihMThsCHFSlT0
         Vexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764119310; x=1764724110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPke9ePUWIJpnNLmmVA+cr1L6xKsPBiMVIzyNRr3D9I=;
        b=QBq24YQDdmQVAwziRSrhoTVoWxE5Ra9TTWABlBcxCvQfA9yeB5VDdfg4MbgfCBQPlp
         LKSfgZ0H2cYQ0l6aBzwbJnHStN4rySLRaNie1/JWDduh2kfI1NZGSHNyEXgZVEwAACZu
         3rwgWL0LUyKOh9wXrkWHJMqXsZ/zH2CAK622eLkYsWqTNKfozFu9X7fTuptf7ASaq2Rg
         HziJZMbPBM9MH0JDOtU0td09W/9rjanSEhjy969Ab/lg/yzs06Djku+32UgkFHTwh3wN
         XyDdufoPgge8HFwucd0xNuByvEJV97eksmLCIWgoLdHpZivfNV71vbJPgEcv24/Xx5rb
         VnRg==
X-Forwarded-Encrypted: i=1; AJvYcCUbYB2KGgMe2++x+b6cAui8Hom2spif8J9I48RbR/U+bOOZwQb54rakLhlPI1aejn/x6ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+3MTDCYOwnehKxdNwq5+1WLIEePMGmZWHMOzFTBF2q8s4MMQC
	TYnbHZYPcpAWxZ1OzUgfRBFez/NEBzACwR9U1i60Su2gsM0KzEv9694kYstj1SPmG5efJJwzlBT
	94IHOBu5u1Ch8ndt3OKpfxy3aH1iKG2o=
X-Gm-Gg: ASbGnctWahjRNeI9Sl8EESA1VpQaa8lzVZe/fqILrKj/+i3Qp/on4N6yCoaHiZVKnTa
	Aclmef1jmlKgL1KJLGHcKti48BalxEP7s6A1VUlAXc/nF0Qq28zUiwtnEF7K6SYmGpf0VqCShae
	+ygb/5BAljJXFL82N6QQf8etT1k6zBxn05dALS1c1QWkXBwdzFIgcz17tbl5zvJ6B2KvUPeJxUZ
	VOeM44iuWhQbm4y5S7MtW7wQlxK8M9RoY4F8YyYe/7BGjZGgsMkz1lptBoWN9yLmYkx1UTtYHiu
	EE49spc=
X-Google-Smtp-Source: AGHT+IHE/HsOueEOnqyeixj2onqOHgnn9FMVGbhVt/9pSvUtRuiaOaEnwQmonHOEqIinS/NE0/4Api3s+LV3xZ2ZMT8=
X-Received: by 2002:a05:6512:ad0:b0:591:c3f1:474d with SMTP id
 2adb3069b0e04-596a3eac18bmr4863543e87.15.1764119309708; Tue, 25 Nov 2025
 17:08:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015933.3618528-1-maze@google.com> <CANP3RGeK_NE+U9R59QynCr94B7543VLJnF_Sp3eecKCMCC3XRw@mail.gmail.com>
 <20251121064333.3668e50e@kernel.org>
In-Reply-To: <20251121064333.3668e50e@kernel.org>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Tue, 25 Nov 2025 17:08:17 -0800
X-Gm-Features: AWmQ_bkqs5856q_ExMgqNAtj115endk8-jgZ3MeYzOr0ypePgHpZa5Y_Vk-wTQE
Message-ID: <CAHo-OoxLYpbXMZFY+b7Wb8Dh1MNQXb2WEPNnV_+d_MOisipy=A@mail.gmail.com>
Subject: Re: [PATCH net] net: fix propagation of EPERM from tcp_connect()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Neal Cardwell <ncardwell@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> FWIW this breaks the mptcp_join.sh test, too:

What do you mean by 'too', does it break something else as well, or
just the quoted mptcp_join?

> https://netdev-3.bots.linux.dev/vmksft-mptcp/results/394900/1-mptcp-join-sh/stdout

My still very preliminary investigation is that this is actually
correct (though obviously the tests need to be adjusted).

See tools/testing/selftests/net/mptcp/mptcp_join.sh:89

# generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
#                                (ip6 && (ip6[74] & 0xf0) == 0x30)'"
CBPF_MPTCP_SUBOPTION_ADD_ADDR=...

mptcp_join.sh:365
      if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
                      -m tcp --tcp-option 30 \
                      -m bpf --bytecode \
                      "$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
                      -j DROP

So basically this is using iptables -j DROP which presumably
propagates to EPERM and thus results in a faster local failure...

Although this is probably trying to replicate packet loss rather than
a local error...

So I'm not sure if I should:
(a) fix the asserts with new values (presumably easiest by far),
or
(b) change how it does DROP to make it more like network packet loss
(maybe an extra namespace, so the drop is in a diff netns, during
forwarding??? not even sure if that would help though, or maybe add
drop on other netns INPUT instead of OUTPUT).
or
(c) introduce some iptables -j DROP_CN type return... (seems like that
might be worthwhile anyway)

I'll think about it.

