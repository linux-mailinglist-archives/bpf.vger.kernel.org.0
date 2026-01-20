Return-Path: <bpf+bounces-79585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D7DD3C432
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 10:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED0E154A692
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 09:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B983A961D;
	Tue, 20 Jan 2026 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ndOfVqv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9D5345CA3
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901790; cv=pass; b=Hl2DnIAlBmy58WQDBdqhLy9zSGwGzV1pCyq0y/6RYJKgHXFvmXI/roxibrS32HaG4a4jSaNL2it95Z4LPgkn64kk7nM34DKJBAPO2qua2HtjSEZIgkpBc0DyXs6xoPKuFXnifqtFcodBZgVFWseI6e1M+sgrMNk2xKTIFk3z1oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901790; c=relaxed/simple;
	bh=i3I124kDIFRAt475DmJvL319sDurBF9+70I4XBQkzu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzQk7DVgGU0NJRQb6rL73kPHhylZI25ldipUVBIkr9Jg8vtGo8KCkxeX/+drxZ+be0naxlR/mYMREKvzsBbRx/ORwDz9kMax13J/OpXxca9SNlgJlzVy7dOZMsp+ZDAYguWaYZSP0qyoJWOoP9XxYLZnvTPrK/etWEkCEnAisD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ndOfVqv; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-502a407dabaso33486171cf.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:36:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768901787; cv=none;
        d=google.com; s=arc-20240605;
        b=HKOsLxqL6iXYW3x8O+i0iKRaNmHyy5/h/shRC7BxOUeh25cNqmD3D4hjzre1M/mUUd
         mjVkomf7MoWXPgUOIVqMKL4vbFTHFPNbkf0Cut0PuyluKQnMuy8y5U8qK/4az7KLQzTl
         qmBSUnKaGVyUjGwYgF4Qpb/Dv7lvt5cFNtq1/t60E2dbAk8lhZK6iOeijqmeJlF9ue/E
         ld/H4GLbmBNg294v/Z7W8qLIrV6Kyh1VDB7fwV1vwA3sgVtr+0RxqPMhGs7AOHh86WiD
         F7I5JimjXlY+tSEKTtriL5d9DBDNJQ1q7jWyyGZwoCbBflvCDKm5TTiuYUw1XDctEREK
         Ad/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i3I124kDIFRAt475DmJvL319sDurBF9+70I4XBQkzu8=;
        fh=MJ1amfanzj8Ny5U3UbTdeq5Wggbln3cWf7UP47D3coQ=;
        b=JbFaMK7L9p8/+3XskkrP2u2/9v31CFlpmyboLA+3YpbnrUupWokcNA8LeWEOeFwhPB
         JFFW3b+RQPK2ySDgKc+9X2fnRyZwbg30mblw/wd468jlMrDB58maexVIZDLoyGx2vMh9
         LlQ4cdGYkSujh6xPLj/ufIOkjT2vPQYtLOGyYAfCm2XIR6RHxVdTDIDU7/XnB9i2jOt1
         xM6e32beLIPg2GBmB24rXA09dE8o+E2XNdHJdmEYwW7FRXrM5Ys2JLgbmco4YqhHLYTL
         HKyfUOW4JN1qJXwNSgCzg7TxcKFZpt3rWr4zyPUMZ8RsBuLnbM7XYYbHcIee3yEr0s8g
         q8KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768901787; x=1769506587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3I124kDIFRAt475DmJvL319sDurBF9+70I4XBQkzu8=;
        b=2ndOfVqv4fK/TW+z5jKOb/UcajjFo/tOTQT6yvatC5jm5+XPDy7mU6DadDkJT1Mle1
         61ETuJ61zbQwfq5yIwsHyrqHPcjPe8+V3KODtHYyXJeK7QSQBEy0xv2mhXw6c1NqLoLW
         5ysj/VFaP4nI4f5jxQdVKI7EbPI9ly55bpH28cJimcm0czM8U5h/w7GwbwAfTNRtX1k1
         xv/awNwSLU3l5THmZBjVLlHXzwGbUbSN7Fep9X2lqtpPF8L9Y5eupsFQH5K5Ct0uVUnX
         2/xYuRl5usVIcOXiQp66YMwSvx3TDN5nQOV3s2d1QKBTwydj56smrEdi35z7YlEs13gm
         aG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768901787; x=1769506587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i3I124kDIFRAt475DmJvL319sDurBF9+70I4XBQkzu8=;
        b=WlVKFoMqsfSO1PMU5iQQFkfuGnXKj/AawscIKzW+lMnUBkBVxceIQ9cJ/botcfVxva
         7iIwBNJDthC3XYoO5ChRhQD4uAPsRj+uFys3ttcXWzSJm8IXMHo7KGZdwGm9sZKz2ZRl
         QEH3RKR9hvy+ENG5N+W2lpuw1ZkLNLthHKVXZSDP1+4WYUekGdB/oR5bRq5hFjIdwvRQ
         KdWgM6y+elcZWJEhYKwXVA0qbuSkRNSPG3XvO2q9s6ruyeda78Nm6UdzfporwJR9KH4Y
         36pqkqbmwIMbppimulkCv1vK2WV3cv7OHLNA6mfW2ooXURdItEl3JGCKreeZMFIryy6g
         rEwg==
X-Forwarded-Encrypted: i=1; AJvYcCVbpbC5OeIqHD5Ck9pnjaZZXEs1/d4Py02nFqMBEuCCwKo3yWAxBv0btEL7fVT8wjRgq+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/lnP7thSrXhvxtKcQW3keZ85pl7emtNN6aqd6oOCU93kAvC+B
	7bwm8mJwR+481AxPISuH42EaYRPYcRHfRWO2QZyLO2Dk0oSxqTynJszoQMdQqCeEVF7MwuPgkO6
	GKAhmnL9s5dfRLiS+HkbeSB+GVI+foNgu6YyabwjE
X-Gm-Gg: AY/fxX7irGZkFWcrpaS60gXwT0G2GjG3X/mD9TsMdewMAijEx/MJ6MnmiJ1PDebU9f4
	b9H4h3X7tqAgRPBFQQmn9nkUJxhi+k9P+EOISC0N6rlnZKV0cF7D+V7MJ0xiU9NNCQNoB15K/nG
	5bDsOmoizpWvrm42D1s2iBRl6vWKHItPRq5vfjBi0Aux+fIwjPyr+67agEotyoxA4p6d5C+ea7r
	zpn8ZulHeKBv04YySueBQM94a+gfqSZLp8Y8G7WHT0NtbppKmH+c3wNa4YyB2922kMvc/s=
X-Received: by 2002:a05:622a:180e:b0:501:4730:fbe1 with SMTP id
 d75a77b69052e-502a16073e7mr186116891cf.22.1768901786640; Tue, 20 Jan 2026
 01:36:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-4-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-4-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 10:36:15 +0100
X-Gm-Features: AZwV_QiBVALGf5mVTwkAOxxW_7LaEeT-CXPBAq0Ya9GQEa2O6BH9EXhsIb0Qnrc
Message-ID: <CANn89iKNgD9tUqck8xHphqc3iiERFjYcLBa+PTHCqXwT7cxY-w@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 03/15] selftests/net: gro: add self-test for
 TCP CWR flag
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Currently, GRO does not flush packets when the CWR bit is set.
> A corresponding self-test is being added, in which the CWR flag
> is set for two consecutive packets, but the first packet with the
> CWR flag set will not be flushed immediately.

Reviewed-by: Eric Dumazet <edumazet@google.com>

