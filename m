Return-Path: <bpf+bounces-68716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B099B8219B
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 00:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0930E466725
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 22:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A86630AAB6;
	Wed, 17 Sep 2025 22:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6eZOaAx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD442628C
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 22:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146804; cv=none; b=JS6pSptuiLeZgteQD3emdRht5I/KuN7Qweyadh7B08EqoOLB+eizD9VdRpdl8VnuvQD4Zrp6Q5C4/tolzt/Za65NvtUhvWS8fqOR6JZRlhhtilKRpsh7VT2r13b06sbVl2Pjd5qZhFIJhKhL909POnLY0rOaA1SEXheDUqw7TLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146804; c=relaxed/simple;
	bh=3mBetsxio1XBPZe/oFCFr7jrBa3V1UcM+i+SrqUqxus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z43x9U66lRMh2eU23HtBjfcfnsG7q9brLG7DCP3b8hWaVxmmUe4w3Iz50pV308iC0rJnYcsoGq8eZnWXIDRE7b0/tplMcjYr7u7oeHdKBeMRtgHH7E3N8cMzFh2fP0kq7CaC4uOASpcI8r3iCYHuzHPSYizxz7PlJ2V/a4D1kXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6eZOaAx; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3e9042021faso148941f8f.3
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 15:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758146801; x=1758751601; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oFiODDRVmKuNZuh7PY7KGkp6fKOrpXwS/3fJJg2GSkI=;
        b=i6eZOaAxp/9XawD8uOGAQpZ0XvKn6wnSptmzlnn4PzPBQ7Kwtw09cM+bvzTGnVg+Sy
         GBx9Tzyxbt4U56NU/Esp6EhdkcVl3/QTtT+lrwL4A0mxNlz3rRT7lypVPtRXEUQVSPtR
         Hk9sZ2N3oiqDz+CDJMNirVY6Oj//2+hLLsKxalD0D4CrlowPMLVznCSaE18+Y76WYLFd
         j0RDSRiAH27bkG5jK29YqgdCufea11OSz8TK3LqflFLElL0ia4qPTp2vxUxyXPO/YWcx
         joS/L/ID3sip/Akel30GBcgFWFXFWIJ0T4yFH3IpVj7uGPvHpI69GtF9D9x2pc0SQUbz
         3sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758146801; x=1758751601;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFiODDRVmKuNZuh7PY7KGkp6fKOrpXwS/3fJJg2GSkI=;
        b=tTfMyRntHT+5Se2KqLvaEmwl0k+7/s/acWnRdzuMstdJus89CcLnxh0ZOe6Tofneoe
         02wJql721/I1RZjL4QzHbIjDme32SGH3T8sSYFvWypAltwxBtqK713lyWR4EdoCTmzmV
         0zbMeLWrwpkCrf4OPtH4kJ7c6yedQCgwHheSTIzhtNqoaN6rGfyv6NFT2UaAYOCChjFD
         WR6qWzVJdaEnR1y403ltC11h0L2CuTKC+M0laKutEsYqMODGZ1+qqVrnf9BthhKWPXCN
         fxXTE9yaAqghe02OzYATjJf4vQBZT8JbwZfp0xA6PfgV7CaxfjKdIPnzS0UchQPRqjyC
         gChg==
X-Gm-Message-State: AOJu0YwstOIFi/Gr2/W+WRhCCyG7AirwFV0AjtgFYqfzO/JanJtxGcpe
	Zzr/BkBex9BfQxDp8jefqisHmfCcVtK+17XwyBMZH8C8iMCmqOJ3PyXP
X-Gm-Gg: ASbGncvlQ3EbkQdBHWWOW0e4E83FkRhjaszFrQdG73/Ha0DTuolZR4CsPXkvbipbs0T
	RQWoxgghaimj7fS3nccFtbwlSUWE6RJaVyZD7KT2VEuUTGbvNB28LJVCEf9LwRYhsuB7c/14Vlx
	kkynzZ8d0dHVYaE9b4s/1c5MTPcpt1LWvWtrxKAlqfuvsY97nKRj1oga7mbBIFbipV3KUKfK16k
	OeyVjaHVi7Bp2yLBZJMxUTZtAezpL3UAtvgVaJS0aETY5iErG+sJdatS141zVi8r3higRIInczF
	9Mu6uyzqMgth8d34F5pS+Lp7NYcIFZi+KEFEwm+0/QLw3digKCsa+MzNfTrMEyE91VYbnA5Ttzg
	HsgYGS4jat43QI2CDpzNbAsrcw9byoodPq5nAIHlZ+vkHhAxBBlw4vJCUp4dnoyGGG6Tr2gQn/9
	oDHtcH4Bavkg/1Jf1UTDyMICR82OV4ScWzYn6Ka5UJwIbifqGK7g==
X-Google-Smtp-Source: AGHT+IEsxqIL5arOZ4CQJ0np9CB7TWHD3+WP1UrASJ5NkCH0Wz/PFCUZ/xQYwYn0G1bues8pJFPpJw==
X-Received: by 2002:a05:6000:4305:b0:3d7:38a7:35d0 with SMTP id ffacd0b85a97d-3ecdfa43b0emr3576014f8f.62.1758146801288;
        Wed, 17 Sep 2025 15:06:41 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b7aaaaec2e06fd58.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b7aa:aaec:2e06:fd58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f5387sm879872f8f.1.2025.09.17.15.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:06:40 -0700 (PDT)
Date: Thu, 18 Sep 2025 00:06:39 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
Message-ID: <aMsw7z7xNnDfCdaa@mail.gmail.com>
References: <cover.1757862238.git.paul.chaignon@gmail.com>
 <6bed34f91f4624c45fd7f31079246d3b3751a31f.1757862238.git.paul.chaignon@gmail.com>
 <CAMB2axOX-J5fDa8EuB42oHEvXQ+OGpUmEaetCQb4g41imvaYCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB2axOX-J5fDa8EuB42oHEvXQ+OGpUmEaetCQb4g41imvaYCg@mail.gmail.com>

Thanks for the review Amery!

On Mon, Sep 15, 2025 at 05:27:05PM -0700, Amery Hung wrote:
> On Sun, Sep 14, 2025 at 8:10 AM Paul Chaignon <paul.chaignon@gmail.com> wrote:

[...]

> >  static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
> > -                          u32 size, u32 headroom, u32 tailroom)
> > +                          u32 size, u32 headroom, u32 tailroom, bool nonlinear)
> >  {
> >         void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
> > -       void *data;
> > +       void *data, *dst;
> >
> >         if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - tailroom)
> >                 return ERR_PTR(-EINVAL);
> >
> > -       size = SKB_DATA_ALIGN(size);
> > -       data = kzalloc(size + headroom + tailroom, GFP_USER);
> > +       /* In non-linear case, data_in is copied to the paged data */
> > +       if (nonlinear) {
> > +               data = alloc_page(GFP_USER);
> 
> Do we need more pages here for non-linear data larger than a page?

We're limiting user_size above to be at most
PAGE_SIZE-headroom-tailroom, so I don't think we support more than a
page of data. Am I missing something?

> 
> > +       } else {
> > +               size = SKB_DATA_ALIGN(size);
> > +               data = kzalloc(size + headroom + tailroom, GFP_USER);
> > +       }
> >         if (!data)
> >                 return ERR_PTR(-ENOMEM);
> >
> > -       if (copy_from_user(data + headroom, data_in, user_size)) {
> > +       if (nonlinear)
> > +               dst = page_address(data);
> > +       else
> > +               dst = data + headroom;
> > +       if (copy_from_user(dst, data_in, user_size)) {
> >                 kfree(data);
> 
> syzbot reported a bug. It seems like data allocated through
> alloc_page() got freed by kfree() here.

Yep, I've fixed it and it will be in the v3.

[...]

> > @@ -1029,6 +1033,27 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> >                 break;
> >         }
> >
> > +       if (is_nonlinear && !is_l2)
> > +               return -EINVAL;
> > +
> > +       data = bpf_test_init(kattr, kattr->test.data_size_in,
> > +                            size, NET_SKB_PAD + NET_IP_ALIGN,
> > +                            SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
> > +                            is_nonlinear);
> > +       if (IS_ERR(data))
> > +               return PTR_ERR(data);
> > +
> > +       ctx = bpf_ctx_init(kattr, sizeof(struct __sk_buff));
> > +       if (IS_ERR(ctx)) {
> > +               ret = PTR_ERR(ctx);
> > +               ctx = NULL;
> > +               goto out;
> > +       }
> > +
> > +       linear_size = hh_len;
> > +       if (is_nonlinear && ctx && ctx->data_end > linear_size)
> > +               linear_size = ctx->data_end;
> 
> I think BPF_F_TEST_SKB_NON_LINEAR may not be necessary.
> 
> To not break backward compatibility (assuming existing users most
> likely zero initialized ctx), when ctx->data_end == 0 || ctx->data_end
> == data_size_in, allocate a linear skb as it used to be. Then, if
> ctx->data_end < data_size_in, allocate a non-linear skb.
> 
> WDYT?

That makes sense, if only to be consistent with your patchset. It should
be doable by just calling bpf_ctx_init before bpf_test_init. I'll try
that.

> 
> > +
> >         sk = sk_alloc(net, AF_UNSPEC, GFP_USER, &bpf_dummy_proto, 1);
> >         if (!sk) {
> >                 ret = -ENOMEM;
> > @@ -1036,15 +1061,32 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> >         }
> >         sock_init_data(NULL, sk);
> >
> > -       skb = slab_build_skb(data);
> > +       if (is_nonlinear)
> > +               skb = alloc_skb(NET_SKB_PAD + NET_IP_ALIGN + size +
> > +                               SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
> > +                               GFP_USER);
> > +       else
> > +               skb = slab_build_skb(data);
> >         if (!skb) {
> >                 ret = -ENOMEM;
> >                 goto out;
> >         }
> > +
> >         skb->sk = sk;
> >
> >         skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
> > -       __skb_put(skb, size);
> > +
> > +       if (is_nonlinear) {
> > +               skb_fill_page_desc(skb, 0, data, 0, size);
> > +               skb->truesize += PAGE_SIZE;
> > +               skb->data_len = size;
> > +               skb->len = size;
> 
> Do we need to update skb_shared_info?

skb_fill_page_desc() already does, at least the skb_shinfo(skb)->frags[0].
Do you have something else in mind?

[...]


