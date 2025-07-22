Return-Path: <bpf+bounces-64060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BDCB0DF68
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 16:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B801C862FF
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 14:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298472E091B;
	Tue, 22 Jul 2025 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y82Zmene"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE18270EA4
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195478; cv=none; b=MLMTk4rihK83ejjYCgmXdO+dazX02NwNT9oE67NL6L7DTzaa6/hhA6yk3fb4E5iao5IdBHTeiXuN9JIO4TywmU43SZtlvF4Yw95xFYtl3U8XvMzcbUs/xqfkvgbxI6aS33pzR7sCL/auwzYE8ROyeymX8MSVVL+xVMIncGxXd9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195478; c=relaxed/simple;
	bh=M1U3cbmcKC3UmhkOtLd0d8xnVD6OA5eoD2IFh0BpJWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsmnYncgefvCtNFO4zBfAuqRmixPCosHsECxApDCdCyA6dVHPEIJLyV1bM4xfvPQOtCzy45Gbkw+R0TfUpBKXUcn6WMrBBDklcVBFHCrdzeB6Qw1s34KqqU/Rarm0FGRmpxTolaEWP1oVOgDebCm7dCqT2N9OX/uYPLeq0evNSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y82Zmene; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a582e09144so3035065f8f.1
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753195475; x=1753800275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D2L7H+oKc84VGlNVSFrPWvKGoux4OdsRHwxfDpZRtY4=;
        b=Y82ZmeneK9ryH9L/9nQDYVDL6/oVQ6w7hJ/Ec1yOjPnhtgg+lAkj0ImJ14IzxFi7np
         2Nm7M6I7DZqPea8kGiZOmX1WRrDsCMIvXPLT8jDTTTg3z2LXIm/3lvD8Q/ztVN+7Tq97
         99NHNKDbgr346VB+dYQa1Y3b7/p6CxB2MMSN2gdab2TX8fZyNV5o1LwYAfyuqagZ0DRC
         Ixk0g4oTdIQzl8Az1wIHKy3/EYUSwbxf5j9G4rBgr7HT+Coqk2FEZT6U3yiHyQAb0Aiw
         1FZL8FHHgO58sJFOvuZ1CJA7zKI+g+VCUE/97f7zQpI+s9IqK73HZC3gPHbVtDmcoqrr
         UAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195475; x=1753800275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2L7H+oKc84VGlNVSFrPWvKGoux4OdsRHwxfDpZRtY4=;
        b=C7kMVtIEzdjkWVVPVsVT94m5svjk2qNUCLpDePN3sD0vpxZT9w7eAs2kWJcjGqy8f1
         NQUZao5d/c330fixWH4pmGcPJl8Tcp6MxdTR8TgPDgwzYrC30nFZVPiOGJkVIm4AIjah
         Q1RJvTMiv8/5V9XXMyOSpCXUl86D+BIkz4jbGCyR6yZZHK4u7fk13ejkzH5igxk2Rrvp
         x5aYN16e5jnBQyFIFN+vPWB/B4mccYCoRnkBQTyz6Ye01cHecWk2POAtTKFSWN95zDpD
         bRnxa3n6bB9WRA9S2lb4Z9eCEFUGGL273Sbr4CXNo8HTazrmocEdWxd8UGbKhuGTDsP0
         R9Mg==
X-Gm-Message-State: AOJu0YzSXE3Ug8wjNi/HxdLrk2NeszMSA6RH4f5vW8Q2LJdIguwjbiiK
	ag7sRlmuuVPECTyFf/hjTX91P0COKRLXL8X/ebtRn9joTDnYon5LyXle
X-Gm-Gg: ASbGncu/dh95roelXvhHNkMx5sHkTSdQXiY19tpzpL++4IvUDBGSqxVs6eQIKR/Uty8
	i2sUAA/B/xz3vVt8lk4aEDJwMG+SmtweKqKrlfk/JXbX/kEAF7JlI0UmNMt43DRaJM5ajjk9ShQ
	Hq/aqzSZiQOX8Y2wc6wEKbIGxiOtEr9oIaBa3775+iTlWFFKHtpXFR6itKpio0Gh7hItYBtN1Ch
	su+4lML/d/b5bEzthTcv+CxFXYKzpqbJvFqK/pP405oShGeGn9j5pz8HYK6dqX7rZxopq+qkErs
	F3bsyt5MOCZvWG//mtGU5xnFTSXC/1pAukaT+oD2tlni2R5q8LO4YkvUP3VafwM+7OnQo8jDFlp
	EVv+yy5Sk+46/KQdsVyC5w7ho2liVzQOhdWJZG4zlr2/Fof1LhyB6LkAAspGGxa6A9JMbNKFA99
	eR8mPLiCwbvxGrKrqIw6eA
X-Google-Smtp-Source: AGHT+IFXf5TwFUMc0xS9uAWvfJNvj2Ziq1VMt9cTR6wh4aMzT5YKiwQ8uj4HddGUPqQzdHA/EdxTGQ==
X-Received: by 2002:a05:6000:2285:b0:3a3:7ba5:960e with SMTP id ffacd0b85a97d-3b60e5532b1mr20596373f8f.59.1753195475060;
        Tue, 22 Jul 2025 07:44:35 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e007ae7318c9eecf7c3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:7ae7:318c:9eec:f7c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b75de26sm131962335e9.33.2025.07.22.07.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 07:44:34 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:44:33 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Reject narrower access to pointer ctx
 fields
Message-ID: <aH-j0VZcsdEtnr0S@mail.gmail.com>
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

On Mon, Jul 21, 2025 at 05:08:05PM -0700, Eduard Zingerman wrote:
> On Mon, 2025-07-21 at 14:57 +0200, Paul Chaignon wrote:

Thanks for the review!

[...]

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

Nice catch, thanks! It's fixed and tested in the v2.

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

Yes, this is not necessary; I got carried away. Per John's suggestion, I
still kept it in the v2 and converted data and data_end for consistency.
Hopefully, that'll be less confusing to future readers.

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

