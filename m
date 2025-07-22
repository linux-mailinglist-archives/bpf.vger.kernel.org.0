Return-Path: <bpf+bounces-63969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268C9B0CE97
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 02:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667296C2D58
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 00:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918B6EC5;
	Tue, 22 Jul 2025 00:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFhGHIsB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D06372
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 00:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753142890; cv=none; b=XWvp5eFAfsXmKphT8e/e5ItOWTeuXaCBhplw5WlIovvxmHWY/pCiweBfHpcEYgJ6WC77y+icWShJkMZ69TZIOU1qrZrzk3EXQbHKEhgIYKJcIEU/fiqDa5fzdsbJTSYGpYf6U/9pSFKTteeXkPpL70M9bL4miULIz609i5u0Xcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753142890; c=relaxed/simple;
	bh=bhTGvUUs3xGGwylsYFAzYIp6gbNaitX15DbCRgHKqKk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZYyZwmrEvukBnBcIHL6zDvJw0yry20Eno33y46YzmlgPY/w6K6zuheHM3grXTtdpd9ZkmUcBaTRbHpjpGF1+dNNTZ7uMgbL2CKH1y3fCoeFw6SxAeF4HttKzFGDtZJMajnpkzoWs3jJARBZ3ASl7Xa+yTvDw6qyPalQ5/cO8iUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFhGHIsB; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-747c2cc3419so3811655b3a.2
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 17:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753142888; x=1753747688; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H/jyylsHXgFL4R6R+jSh3zDKt5gAxE608wQckUPPF90=;
        b=BFhGHIsBi9hQ2RdCOezZcA1vpUZzKlZ4HIP/al1d+GpDaZkQMfakEDS/sVaGdrRO1C
         eb24pjP0bZeCKNXZVASzaD+MCvxqjCzuL5woxOCrc9QzwrxUoXDzSZ7IeVwhoGzzV4/n
         rJrx+SQO5Ih/7wVL1z8d1qwMNBi/CjSaNsIQh/KlCQ4o/oLn+NuaSUy9UwqaB08TJkRe
         eQOGR/vW9E5VLUTmtYCUf/nv1T4edta2T8i4v6q3NLdDrsFJRfvhLxTEE5sp/IGINg0e
         vr1/vUoLvo0wZcfzYPBZXc553LjhdVk59TqjuUohFKusyipeI9es0rpe+pHdibxH2q8i
         WPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753142888; x=1753747688;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H/jyylsHXgFL4R6R+jSh3zDKt5gAxE608wQckUPPF90=;
        b=v5Chaqx0ZMcf7+HMbSsnuj+hylu00jE5NYdG38JfbSM7pGAkZcm5Gyo7vIpfbGHFlF
         tscHigiq7Ymf0UoM6ytvAcGsMUcUOfEOTtEPbPEPai/692+gyiV4quy4susLnN7lzGZw
         PnuYrrbayHoTF/OtjQJ5Tc62mJPQ7TCfgUYnty7UZyCCqo2Z+RtxgvyH1F383cPGWGUX
         U3YF0kxQKCxtcLVlw5uN5MgjzdOYydUuDUGcsJ2z5R2hb98RDO05q/UxASZahRE8s2TJ
         tcncw+yqJcUgMt9+msE6z8crs5w0XMyjzRIJ+dGJ+pqsODQR+cuzLKgWnZfqJYw0pHlB
         l0Ug==
X-Forwarded-Encrypted: i=1; AJvYcCU+nkfqqVSJf9CV8At3TmtkstAsyWl7e//T2M1n7hF5myinZmZMrX1v0TuucuHpoRTI8gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqZOboNCVmYqdiZBHMtSKn/J3dw9+CYVALZuMqHJ9WcKWgIPlN
	geZdt0rdzBbkrMeDVObUjgQJRnw7XqaCCNas3q+uQTsEGrWs7+cNY/ad
X-Gm-Gg: ASbGnctG7Wx4pyHhp7rDY8F/LDcmMzZTtVv8OZjlXXj4Ee2rQ97+yr1gh8lAaId6j8K
	TDo2irTtXdsOdhzP8FvTFFJU+VY2rwLAPhCWuzw4OOwzCdGZGv+9Vl0Ws7CfgEQDPjCgEPEbhRF
	9tRlkDZ+5E5NKTZHCwavss4xPtXrCqzjgcdizP82678V07/EgcfR7y7vcdQ5FKKvgkzgNA7VCGa
	B/Ou6iBQIeg6kR0zemV+u1xvWZdv+kG+hi3otdPrdbvxe5unDKDxXb96dpRrKNbsHMk/oqTsdx3
	IUthELvWlvqfoQbVKXgDepVs2EPg2W/DP4P70GkygNFo7aGJ8xzPPiC/gMLd8hlyWsQ2VOnC/mT
	XCpE3MNevo7XWjRqljbybVn4D1Exe
X-Google-Smtp-Source: AGHT+IGeddbPd0824bhdLIMORShuImxJLSICDmVpRKEeHNaZOevtuA0yfv5Zb+RcFUFbx620hLhXiA==
X-Received: by 2002:a05:6a00:4f89:b0:74d:247f:fae4 with SMTP id d2e1a72fcca58-759ab639673mr20965385b3a.4.1753142886809;
        Mon, 21 Jul 2025 17:08:06 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:7203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ff63090sm5910776a12.42.2025.07.21.17.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 17:08:06 -0700 (PDT)
Message-ID: <ee25ac4771732bb09513e48fb2bc86614d3fd045.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Reject narrower access to pointer ctx
 fields
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>
Date: Mon, 21 Jul 2025 17:08:05 -0700
In-Reply-To: <e900f2e8c188460284127fe1403728c10c1eb8f4.1753099618.git.paul.chaignon@gmail.com>
References: 
	<e900f2e8c188460284127fe1403728c10c1eb8f4.1753099618.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-21 at 14:57 +0200, Paul Chaignon wrote:

[...]

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 72c8b50dca0a..3a4ad9f124e1 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -2577,17 +2577,17 @@ static bool cg_sockopt_is_valid_access(int off, i=
nt size,
>  	}
> =20
>  	switch (off) {
> -	case offsetof(struct bpf_sockopt, sk):
> +	case bpf_ctx_range_ptr(struct bpf_sockopt, sk):
>  		if (size !=3D sizeof(__u64))
>  			return false;
>  		info->reg_type =3D PTR_TO_SOCKET;
>  		break;
> -	case offsetof(struct bpf_sockopt, optval):
> +	case bpf_ctx_range_ptr(struct bpf_sockopt, optval):
>  		if (size !=3D sizeof(__u64))
>  			return false;
>  		info->reg_type =3D PTR_TO_PACKET;
>  		break;
> -	case offsetof(struct bpf_sockopt, optval_end):
> +	case bpf_ctx_range_ptr(struct bpf_sockopt, optval_end):
>  		if (size !=3D sizeof(__u64))
>  			return false;
>  		info->reg_type =3D PTR_TO_PACKET_END;

Nit: I'd also convert `case offsetof(struct bpf_sockopt, retval):`
     just below.  Otherwise reader would spend some time figuring out
     why `retval` is special (it's not).

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 7a72f766aacf..458908c5f1f4 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -8690,7 +8690,7 @@ static bool bpf_skb_is_valid_access(int off, int si=
ze, enum bpf_access_type type
>  		if (size !=3D sizeof(__u64))
>  			return false;
>  		break;
> -	case offsetof(struct __sk_buff, sk):
> +	case bpf_ctx_range_ptr(struct __sk_buff, sk):
>  		if (type =3D=3D BPF_WRITE || size !=3D sizeof(__u64))
>  			return false;
>  		info->reg_type =3D PTR_TO_SOCK_COMMON_OR_NULL;
> @@ -9268,7 +9268,7 @@ static bool sock_addr_is_valid_access(int off, int =
size,
>  				return false;
>  		}
>  		break;
> -	case offsetof(struct bpf_sock_addr, sk):
> +	case bpf_ctx_range_ptr(struct bpf_sock_addr, sk):
>  		if (type !=3D BPF_READ)
>  			return false;
>  		if (size !=3D sizeof(__u64))
> @@ -9318,17 +9318,17 @@ static bool sock_ops_is_valid_access(int off, int=
 size,
>  			if (size !=3D sizeof(__u64))
>  				return false;
>  			break;
> -		case offsetof(struct bpf_sock_ops, sk):
> +		case bpf_ctx_range_ptr(struct bpf_sock_ops, sk):
>  			if (size !=3D sizeof(__u64))
>  				return false;
>  			info->reg_type =3D PTR_TO_SOCKET_OR_NULL;
>  			break;
> -		case offsetof(struct bpf_sock_ops, skb_data):
> +		case bpf_ctx_range_ptr(struct bpf_sock_ops, skb_data):
>  			if (size !=3D sizeof(__u64))
>  				return false;
>  			info->reg_type =3D PTR_TO_PACKET;
>  			break;
> -		case offsetof(struct bpf_sock_ops, skb_data_end):
> +		case bpf_ctx_range_ptr(struct bpf_sock_ops, skb_data_end):
>  			if (size !=3D sizeof(__u64))
>  				return false;
>  			info->reg_type =3D PTR_TO_PACKET_END;

I think this function is buggy for `skb_hwtstamp` as well.
The skb_hwtstamp field is u64, side_default is sizeof(u32).
So access at `offsetof(struct bpf_sock_ops, skb_hwtstamp) + 4` would
be permitted by the default branch. But this range is not handled by
accompanying sock_ops_convert_ctx_access().


> @@ -9417,7 +9417,7 @@ static bool sk_msg_is_valid_access(int off, int siz=
e,
>  		if (size !=3D sizeof(__u64))
>  			return false;
>  		break;
> -	case offsetof(struct sk_msg_md, sk):
> +	case bpf_ctx_range_ptr(struct sk_msg_md, sk):
>  		if (size !=3D sizeof(__u64))
>  			return false;
>  		info->reg_type =3D PTR_TO_SOCKET;

I don't think this change is necessary, the default branch rejects
access at any not matched offset. Otherwise `data` and `data_end`
should be converted for uniformity.

> @@ -11623,7 +11623,7 @@ static bool sk_lookup_is_valid_access(int off, in=
t size,
>  		return false;
> =20
>  	switch (off) {
> -	case offsetof(struct bpf_sk_lookup, sk):
> +	case bpf_ctx_range_ptr(struct bpf_sk_lookup, sk):
>  		info->reg_type =3D PTR_TO_SOCKET_OR_NULL;
>  		return size =3D=3D sizeof(__u64);
> =20

Same here, the default branch would reject access at the wrong offset alrea=
dy.

