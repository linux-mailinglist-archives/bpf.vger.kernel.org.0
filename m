Return-Path: <bpf+bounces-79582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED53DD3C4FD
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 11:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E70766A011B
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 09:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB153D1CDC;
	Tue, 20 Jan 2026 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cfLiBtRU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3CB3C1FF4
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901501; cv=pass; b=gxON2zMJJMp9BOKAanKfBX6ZG06XhNCFRcPFhsZZyHzcUapy0xOMbo4x1poo7T5lHRpK6svskB+jUWJeunVJ9WQO1zkGSQZlhMR8DibB29YIiAng7D3Ka2xYEP72oh88SfsmgtufvuGXst2oFn9MSFy8leetQ+MIkr0KdG7LZew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901501; c=relaxed/simple;
	bh=r2OPr/mJb/5L9shYQDg8Js1LfKdBpkN1T6SX5DgIz24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6zfhRlfJgRcDkMZK0pxEDCxj9W6pb7eilaIFnr8ofYQkEN8I7e04dd7Zamz/mfhA6dRupbXhuAYYMM76L7btzgA1ZleBVm6Z7PJeEakMqgGg4PzX8lFx9fxMp5ssRZBMfmEnFxLBooN0p93DhRvLlOP7o92yZmLtTWk4Xx+fmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cfLiBtRU; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c2c36c10dbso593371085a.2
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:31:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768901498; cv=none;
        d=google.com; s=arc-20240605;
        b=GmN9MnvaBDbomTg8v8sTLNVl1dRt/NeqMnDiehn+4RzSEgmBGRFb91JT/SJgEf83VV
         xqP0D0Hko8MjVY/vfm7uD9qriz9WIQ3a2qLceI0PkRjQTaYzvZEgpxJ+kv04wPj5VSF6
         7HwaQfwjIhept5aKxjvf6DzyBSPb64TzZRFcztknkGpkBfhhcUTv9SByq297ZVj+WCtS
         buZ5cnkJtFIuQ0Vefu2zbh0DX0Y00X92w4YwYlngLpUMIcQaB8iw94xSpgLiebwrMEIW
         a/7IQoseHWNqN0Zu1vEZnLiMO2fvNzq+a/oJsR3Wd4bz/VBAa9EcRODfY+IOXgwSquIk
         0YYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r2OPr/mJb/5L9shYQDg8Js1LfKdBpkN1T6SX5DgIz24=;
        fh=aLyMU94UlsZq07svhRZnRLRBNJzNEffzUcexBYiwfs4=;
        b=aBNSbSM/gW6jsaEKM2B1Wub6MJB5XXwCRyI88sz7lHLcWdg97yAE/fYjz92cJ0I9gY
         GUYHLhsGDEi5ElYVvsg/S09tesuXvWhzMXnx+IP0smFYgeMIxusHpZiXYWYbbZ3GNazn
         2xgnlscW7KbZopj/UBk7Y4yQsXjKpfUczuMBz/5GBICnMwcXe7+lkCOu8FcgQpYDThL+
         lZ0nssKStSUA9jx+sSucAZ2oAvMMnCuGKdUQroDWyAAAEEeI3kW5ylJz3VQ0dSFTi2Wb
         PrR3oAQMX3E1mIg1fjUmI0N1tzIL8IqWNGIyvwDebmJGJ7/NOPNkM5qWc6Zi6NBVh94Y
         Jymg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768901498; x=1769506298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2OPr/mJb/5L9shYQDg8Js1LfKdBpkN1T6SX5DgIz24=;
        b=cfLiBtRUY91o1o/2kdjpF6ig7LYi7EPEZBSDpd6sW+a+YUXfBhjr2fEpeJHr/015Cc
         y3f+JrmBg1mKHTe05WzmWcYGC03H178P2oJgzcw/O9Fm6NRXwFO8u2bWbUpEkHP9mLvp
         t+xAIGzN4zaDvXk1aK93G4QDnyRb3DLhJ73yFixua2wxE32One8eS93fCOLb+uiNxmAy
         BScqEPXqiiXneMfSKZwiWmSonyS3UrrWuGo6aNOAzDakMSUK85syqFqGfWFLiWPXPyVH
         Ze4Q3kxWmFwXuahQBxI7ix6gS2n5U+Jn5xmg1ALoVlYeiXEz5IVEQq/KSULpY1uXg2cQ
         u3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768901498; x=1769506298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r2OPr/mJb/5L9shYQDg8Js1LfKdBpkN1T6SX5DgIz24=;
        b=BabSjsTj7WlD78PkbO6XMb/BIZGZAvYavx0kZ/KAS/u4KC4s4T1xO5jWqBAWROYf21
         aVehHdchznHVPJOXUUksoZuca5cEABnShUZDiq3uWesmgXpVELEGP+3zteOP48rsCTLa
         bceX+zL8c6u0ep5im/9eY2OtVqESgXUB+Ues9WaQAA7X8TAF0w/wC597tZYm5O/2+w82
         icRTSdOuoWQQVhT/qqFKzZpp7brgMRiWuh8nnKcnGmOffwp8JV0KbnlqK0r4dalopYGJ
         oyIrGVSTEXjU5qKYFqcB4qQRziPz6WTknTFccUfYNQORda1CcqFM4U13b3XQJWvnLgMS
         DGFg==
X-Forwarded-Encrypted: i=1; AJvYcCXCp0eLrmH7KsiLB1ZWZd1evNBnC4jO5c9iS78U9qQuJIHnBFcsjRSo+5R1INDl3a9b5aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzLLnuv1R3g7aTEUFgseGMjEpJFnvywfNR5HjFToCphtXV+xvn
	O+hNbpGgwxIYza5zrWPp8k4QbIuWGD0YvjeQvoAB7eTz5erh2ur4xnCOE547L25YUMjORPKPiaK
	I0dV7hd4GnKxHJybdyVtLup4PAokxEIhchRNTHf4d
X-Gm-Gg: AY/fxX6cAfFN1YN4+i8QbfTDlyB6bW+PSv7ZdY1k7Cc98At9l4NPgFsFbWgW/lBBqgg
	t040P3ARaKSwgWhPSzTrRlMSUeFWZopQZDyoP4jv5/PbS924uN5BZdEVPm6FFMayLxdaVC65nSX
	uvAPGUIHN9VS0WNk7q0RbSU5hk6HNuU48RyfL5YzYeU+A5zGkPXedcDU0tJrqQcDPNPaApNs0+z
	nq2fI4ggBX9JIwHQVWPgt3YWDsKUEi23JT75eHEmHTELvzxShlbAWTd9kibJdJcEbf+C1c=
X-Received: by 2002:a05:622a:c8:b0:501:51b6:cd3e with SMTP id
 d75a77b69052e-502d84eabe5mr13635181cf.29.1768901497982; Tue, 20 Jan 2026
 01:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-3-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-3-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 10:31:26 +0100
X-Gm-Features: AZwV_Qj1Jnn01ns8cO1Mwqdo9iNbvBF-noKKnseassUVD5Rb4EGhtZz-4l3C_i8
Message-ID: <CANn89i++X8hRu5nc4ChyYxf=J1kT0QF0sMOW8BLkwpNWi+bkiw@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 02/15] gro: flushing when CWR is set
 negatively affects AccECN
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
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> As AccECN may keep CWR bit asserted due to different
> interpretation of the bit, flushing with GRO because of
> CWR may effectively disable GRO until AccECN counter
> field changes such that CWR-bit becomes 0.
>
> There is no harm done from not immediately forwarding the
> CWR'ed segment with RFC3168 ECN.

Reviewed-by: Eric Dumazet <edumazet@google.com>

