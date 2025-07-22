Return-Path: <bpf+bounces-63996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46184B0D13C
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 07:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675FF542B59
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 05:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BDA1CF7AF;
	Tue, 22 Jul 2025 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtuJTAnA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2FF139D
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 05:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753162273; cv=none; b=n33u7PMOUF4OUrEZbQBWKWRIZx2zi4v/PCOSFaruX1YJ/cEdFEqskjVIF0LYEr5oG8hYpzWsOp4MR0IPZIgdRXDzgQwb42vu+kwYLWWP19ZEYlfj0IS1UPfgnoKzLJVwJPK96bor0kCul94hB02ZFWs993PnVNEAHshuk2gT5E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753162273; c=relaxed/simple;
	bh=BOGN2PLvs3XG5QM2eURevPsXPnJ51iSDkn3Q8K4I0Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlUAXM6L8AM8UKydJ4Rbq3jvRZJL+pYL+xQ7y+INULzC82wzDc3AVZaXKFb9KlfR13ht/3KQded/ZO1FLIxhXnqWGpPhzu4cLSDmHlSZp5zkXwuOv2nrv7GS8BC4yTbqDzsHEqMsTxN5ZFx4cBfr0CTwG0cUPJFb7LG0cMjaGq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtuJTAnA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23c8f179e1bso51009335ad.1
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 22:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753162270; x=1753767070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/P//A2KZZWxx8b9QZunjDsBGm9xb7tJtbAwMXVUcdNg=;
        b=CtuJTAnAH03NOmabIYyGxUsnu1RFVrz83FwCwZQZl850rqV+e1u6k41XFdN078lJAC
         1bYuADuN22GCjKsPBqQsTIcDlWVciOuVO8VOb6v/5Oc2otItjqKqUEM/rTPa6aP3yIa6
         t30/ZmlOcBuiRrKDkasplkITUMfKk0vNtoK16gbkoV1NoapXICVnly76Fj1bmxmLWPmP
         4i0smuZDL8zAeaLRlX+BY5QxbUUEN11sPPl7x8bpp5uazFSlJXKb3DUhXp+QkBjJwYrQ
         0nrSRAjZvQaSsRRwlXYnIw+UnblHaXA67CAe1XTBJkxmxqo4od1U6k77PZQhW9pLjq6U
         iIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753162270; x=1753767070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/P//A2KZZWxx8b9QZunjDsBGm9xb7tJtbAwMXVUcdNg=;
        b=TGrwlfzEbK/a4NJdiR44WJMMS7Hzc2fX3EuNjLqD0HZQ3oO6CFJ6x7O651oUkFe7L1
         5OxXqS+3PpGukeVaKIO0Lnw3piVK1EytLoULJjW7OzfW2mwIB1Bec0GObACNNbK/81Sc
         zg+liXjnvIJKW5iL/nAC3bwovl2TZZVF0+COiLUfd741goxuH/t8uA0zpFNIMEKDAvpa
         kvRwMwFIb1NK6gQKouIG9uVr782gATeTwADhS+DDtrh35w2QPN+KaWrI+reFOLbqDya3
         pREe4l2ObtqqWFfPYSt0tI0w2rSDK1u0vE0fMgegNNS23TYOlh2rt0nMKy0Mp6/7kmtt
         VvUA==
X-Forwarded-Encrypted: i=1; AJvYcCV6H++0OBBTns9UE2VITlwNz6AK29tkuLS0ACRcupcJiTwzr5oEI7KJYoBqPxPn4t0820M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL7SH84FkNwKJqvP/FdA06mMf/rSS8GrF0pvUnNMzhmBEJ4VwY
	CDqbadK8h/8pdouCB9XxzKLakyP98StG5pPdZy/KMSeY+3Sb6uT/V3BCe4QDzA==
X-Gm-Gg: ASbGncvXaI+N9vy1vQ0zsq1M0gi0ftaXYjGHYYXDu3x/ewQKg37CY93ZeRvjxs91kx8
	J0GPlg9CyTAIiZwWzka7XsTMz0XZxIEHcmhLQelkDWkfTOLPkthYqednQlwwP1DVpoH49OUOzcO
	vCwKEmXDJ5ZxNmMwikT6HcE4C1JXDU92dkdLqa39TcopW163ANE54BkAU/4WO+5Ah5z2E3V/z25
	D3cBwckyW4nZtXJRIboXkSPTMp28RUN3ZYTu5N1AaPQFJLZpPoVH53EDApvTCUhLcdQbLVD7PPF
	EN1jts5Xpq5Duu79Vr80NKh+eXy3waiH5dOmhTYV92HMdP8yYOkxp4VwcvluptIP4Nh4MlDTIK1
	XDT7oc4zq99D81p5k1PbCAnoECE9xyTXq
X-Google-Smtp-Source: AGHT+IFv2z4axmTTMON+kH9wggWvdWl4ElWjDLUKYt3rwsxeTUCDhPEbsBMQz7gaRn7eaRUqbDczCw==
X-Received: by 2002:a17:902:c948:b0:235:f078:473e with SMTP id d9443c01a7336-23e25763d54mr335169445ad.43.1753162269832;
        Mon, 21 Jul 2025 22:31:09 -0700 (PDT)
Received: from gmail.com ([98.97.38.28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b5626sm67358335ad.123.2025.07.21.22.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 22:31:09 -0700 (PDT)
Date: Mon, 21 Jul 2025 22:30:57 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Reject narrower access to pointer ctx
 fields
Message-ID: <20250722053057.rj4gx652d5apw563@gmail.com>
References: <e900f2e8c188460284127fe1403728c10c1eb8f4.1753099618.git.paul.chaignon@gmail.com>
 <ee25ac4771732bb09513e48fb2bc86614d3fd045.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee25ac4771732bb09513e48fb2bc86614d3fd045.camel@gmail.com>

On 2025-07-21 17:08:05, Eduard Zingerman wrote:
> On Mon, 2025-07-21 at 14:57 +0200, Paul Chaignon wrote:
> 
> [...]
> 
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index 72c8b50dca0a..3a4ad9f124e1 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -2577,17 +2577,17 @@ static bool cg_sockopt_is_valid_access(int off, int size,
> >  	}
> >  
> >  	switch (off) {
> > -	case offsetof(struct bpf_sockopt, sk):
> > +	case bpf_ctx_range_ptr(struct bpf_sockopt, sk):
> >  		if (size != sizeof(__u64))
> >  			return false;
> >  		info->reg_type = PTR_TO_SOCKET;
> >  		break;
> > -	case offsetof(struct bpf_sockopt, optval):
> > +	case bpf_ctx_range_ptr(struct bpf_sockopt, optval):
> >  		if (size != sizeof(__u64))
> >  			return false;
> >  		info->reg_type = PTR_TO_PACKET;
> >  		break;
> > -	case offsetof(struct bpf_sockopt, optval_end):
> > +	case bpf_ctx_range_ptr(struct bpf_sockopt, optval_end):
> >  		if (size != sizeof(__u64))
> >  			return false;
> >  		info->reg_type = PTR_TO_PACKET_END;
> 
> Nit: I'd also convert `case offsetof(struct bpf_sockopt, retval):`
>      just below.  Otherwise reader would spend some time figuring out
>      why `retval` is special (it's not).
> 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 7a72f766aacf..458908c5f1f4 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -8690,7 +8690,7 @@ static bool bpf_skb_is_valid_access(int off, int size, enum bpf_access_type type
> >  		if (size != sizeof(__u64))
> >  			return false;
> >  		break;
> > -	case offsetof(struct __sk_buff, sk):
> > +	case bpf_ctx_range_ptr(struct __sk_buff, sk):
> >  		if (type == BPF_WRITE || size != sizeof(__u64))
> >  			return false;
> >  		info->reg_type = PTR_TO_SOCK_COMMON_OR_NULL;
> > @@ -9268,7 +9268,7 @@ static bool sock_addr_is_valid_access(int off, int size,
> >  				return false;
> >  		}
> >  		break;
> > -	case offsetof(struct bpf_sock_addr, sk):
> > +	case bpf_ctx_range_ptr(struct bpf_sock_addr, sk):
> >  		if (type != BPF_READ)
> >  			return false;
> >  		if (size != sizeof(__u64))
> > @@ -9318,17 +9318,17 @@ static bool sock_ops_is_valid_access(int off, int size,
> >  			if (size != sizeof(__u64))
> >  				return false;
> >  			break;
> > -		case offsetof(struct bpf_sock_ops, sk):
> > +		case bpf_ctx_range_ptr(struct bpf_sock_ops, sk):
> >  			if (size != sizeof(__u64))
> >  				return false;
> >  			info->reg_type = PTR_TO_SOCKET_OR_NULL;
> >  			break;
> > -		case offsetof(struct bpf_sock_ops, skb_data):
> > +		case bpf_ctx_range_ptr(struct bpf_sock_ops, skb_data):
> >  			if (size != sizeof(__u64))
> >  				return false;
> >  			info->reg_type = PTR_TO_PACKET;
> >  			break;
> > -		case offsetof(struct bpf_sock_ops, skb_data_end):
> > +		case bpf_ctx_range_ptr(struct bpf_sock_ops, skb_data_end):
> >  			if (size != sizeof(__u64))
> >  				return false;
> >  			info->reg_type = PTR_TO_PACKET_END;
> 
> I think this function is buggy for `skb_hwtstamp` as well.
> The skb_hwtstamp field is u64, side_default is sizeof(u32).
> So access at `offsetof(struct bpf_sock_ops, skb_hwtstamp) + 4` would
> be permitted by the default branch. But this range is not handled by
> accompanying sock_ops_convert_ctx_access().


+1 looks that way to me.

> 
> 
> > @@ -9417,7 +9417,7 @@ static bool sk_msg_is_valid_access(int off, int size,
> >  		if (size != sizeof(__u64))
> >  			return false;
> >  		break;
> > -	case offsetof(struct sk_msg_md, sk):
> > +	case bpf_ctx_range_ptr(struct sk_msg_md, sk):
> >  		if (size != sizeof(__u64))
> >  			return false;
> >  		info->reg_type = PTR_TO_SOCKET;
> 
> I don't think this change is necessary, the default branch rejects
> access at any not matched offset. Otherwise `data` and `data_end`
> should be converted for uniformity.

I sort of like it if all the ptr types are referenced with
bpf_ctx_range_ptr seems more consistent to me. So its it
is a bpf-next change I would do data and data_end as well.


> 
> > @@ -11623,7 +11623,7 @@ static bool sk_lookup_is_valid_access(int off, int size,
> >  		return false;
> >  
> >  	switch (off) {
> > -	case offsetof(struct bpf_sk_lookup, sk):
> > +	case bpf_ctx_range_ptr(struct bpf_sk_lookup, sk):
> >  		info->reg_type = PTR_TO_SOCKET_OR_NULL;
> >  		return size == sizeof(__u64);
> >  
> 
> Same here, the default branch would reject access at the wrong offset already.
> 

Other than above patch LGTM.

