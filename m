Return-Path: <bpf+bounces-79588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A92D3C4A0
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 11:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF929505F31
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 09:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1D73BC4EF;
	Tue, 20 Jan 2026 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3sjtQ1x9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFDC331A52
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903013; cv=pass; b=s6m6C5dDDAeyY58Gc81fkXPhJytRy21N84UrZE4+0oVvNE2/A+6i1Vm3RFiOQ8pp1XMCklVk+EqrVtsbhU4ZTawl2RdzNtQFpyPWqT+CP+SJKjkP20Cf8FpeK5F+65h9XImQF2cWtzJhe2Vx++damiviGvx+by+DRG67iNuq4Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903013; c=relaxed/simple;
	bh=DCIjvxqnB0B7Gd0SJ6C+JyGFfo1rtrAw0nwrgUxl/bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDAPYI6sYR3mamL4Bu5E+y1M5o3eoIIdQsXY+PVdUuAJMg/dsrGkC5o+z+JrmoNE3aOxeGtPuaCUZBw4x5J14+LZAs6vYheOwZd/RYkaOtJz/h/iFX+CWa+W8Chn5tUcA65GIqNAMc+KwblxshOmq39CniEAXo8CuB4Q5IZHR9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3sjtQ1x9; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5029fb0b977so36511891cf.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:56:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768903011; cv=none;
        d=google.com; s=arc-20240605;
        b=OXTAgVG8XOAl1aFC+wr1OyzsP53aJyS4e1pcp3QYL4bjJrZsT290ILUcKsUeTKDNU6
         aw635FjnCEZHOM7Vh6CPQQ7YV780EQLMwOk3H5zwBwVA6IX2LqvopZ+aE6z0ccI8QTyt
         RYf3p3VZvNJdgfC1bPJiedsUz/Jyh8IGWwG0Yy+qXjxFacPRZbDBj6h6r9O5YfQQbZt7
         A05Mo4q6s5t+U6QWc7IhO+dXXsihcjdVg0odiWp0KB7EVZo8E+86qitUgbuo1160Tv9n
         eWakLHq2PWaa0Muj3EUE42uQUe7ZfEVSDWyCmKlbxEvUtlikNXPwyrhWV1P6atKBvxi+
         pQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DCIjvxqnB0B7Gd0SJ6C+JyGFfo1rtrAw0nwrgUxl/bU=;
        fh=ROOoSaTRx2372UvRVampJl4BuKJ0SM/Nh4AplaPNbyQ=;
        b=iXqAuaUXEtdoYEyFgtkUfxVO1z+eYdhHdaYydW2KHV4mjWu/rYHX5DCfP7f/h4wqEA
         wmyn+aC/z/NgWQdTqHtU8TNt33LS0bvIA8grboozEH/FJn6V+5NPvUtQelw3jzBdQS5F
         TOnciCgdcfuXEKczrwh3EsGOlNT1UNrWWZkY+4lt44yYN8EkuNQpOn7zc9IquBWRtlKb
         nxZ1dCHfA8W+OCsWEdauGHOdsUeTxUgONy+hLXosfetn5v5udrBBbwFaHBl8k4mK/VF/
         mAl+lS1fKUuk6+fVnSf2m3OTmxMB2W5KTWCnVDj2AECWzq+WLV1coXonqta3VIG3oNXU
         jD/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768903011; x=1769507811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCIjvxqnB0B7Gd0SJ6C+JyGFfo1rtrAw0nwrgUxl/bU=;
        b=3sjtQ1x9WmRvbdYB06aePiearuKrghc0l2W/2s0AEik+5hKq6QlTBKAsMVRl9/LRT0
         i2i+q7iKvKng2K621u7/hzupoRZquXkthX6XaBBR6N2yNmJU2VDfovpnJiPACbZSPyn0
         32bUBEZn3E5RqZYd5Olxu4G40D1/6zK+qnBo1XEBKsq+8flch6FDQ54uALk8dyBkrES/
         l3Z0xK1WGGesc4V2W78cUG9JKAWtmFfSTt0KXrEbRE2y1DJxfze2do4uujC7BrEShkpO
         fVBCYHHrIAmjPyV7HJm8Sf9j6AcYQqin+sgBrYW6y2RsnwW4aJh9GAeknshdsrFdqclp
         /z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903011; x=1769507811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DCIjvxqnB0B7Gd0SJ6C+JyGFfo1rtrAw0nwrgUxl/bU=;
        b=CwMc/pATqpPcn391I0BT0KzgDZGiitCs1h6z4XAONAdD7z8pC7zsNfkDiT8jlBEWv5
         x/vLtVZ8NE41vlB4RGI7MV0wkHmKYm453z8oqlP3fyUDgqiPHJcK5xPYq1blGWNUndi0
         Qn44w6QBnWJA9f2qrW78SSn9nf5ZbcZekVhb+BCrL84jR0rixjuQ0fB32T/nMLmBytcd
         4IBePfrjRrFZWPox/O7aAVdpH7Cccw99Uwfb3ZE9ZNqetJlgIU9URjyV31Sm6aBNaYJW
         T9MOyFv3det1NhbdEf/ffv1tcNINOuavbBG10DsAf2bCpBTLh9vdpvF69d2t5bD8K+KG
         /Hxw==
X-Forwarded-Encrypted: i=1; AJvYcCU2GYQ+dtYna1rK69hhuEiggMNSIL8atP9Ie6Y9nYaKUPA5sKlruhqlCUH/8C0ocEhDIQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMPC82VSHjzvfgxCgpptCwlgaTnRdEykhFodddTy/GWluJyvkH
	StAauJQ8525IwOcEGexLiv/kicc2Px+hv5m5XBSY6UpY6P2tDvfcYNTu4DdhkqenVu8lkk+X9ke
	9pfbNyG04cCSBh9fVChL7fI4jfXlE6Q8Ex6qw1K9K
X-Gm-Gg: AY/fxX7cUMJ7XuEEY+d7fkQ4USiaOO1J+mKLAUvChnPA/hDwlBYx18mYxxrfTUHox0i
	qtnIfLXEogKLvKtvgomSDP8UCMBlwljRk5M5XK+Os/4E5oz9Pf+4SmnkWVWqJDVrkScDw/6IYE1
	/MgArV5pArPeRpx5CEch2FbsI5HsUh554Y2JZ3UcKNWs1Utg0Kv9iDd6nGoY/skmX5axyBaJ9HV
	aw+ybUVqoi8+mmJ0cBeL1U/okSxNsYKrMpe8rMAiOYbF5N+lxyL8ZdQ0RinARXXY8rVdkI=
X-Received: by 2002:a05:622a:1794:b0:4e8:b9fd:59f0 with SMTP id
 d75a77b69052e-502a179c31emr197588841cf.61.1768903010232; Tue, 20 Jan 2026
 01:56:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-6-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-6-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 10:56:39 +0100
X-Gm-Features: AZwV_Qi434Atr1gPGVfzbX7Cut4_5_Pnu1U9A-PDsd4oFP08xwfXslULTipllTc
Message-ID: <CANn89i+P_g8XB++mQ-MMXSSaTURLsohqnxHBcVpVrBBBoru91w@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 05/15] tcp: disable RFC3168 fallback
 identifier for CC modules
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
> When AccECN is not successfully negociated for a TCP flow, it defaults
> fallback to classic ECN (RFC3168). However, L4S service will fallback
> to non-ECN.
>
> This patch enables congestion control module to control whether it
> should not fallback to classic ECN after unsuccessful AccECN negotiation.
> A new CA module flag (TCP_CONG_NO_FALLBACK_RFC3168) identifies this
> behavior expected by the CA.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

