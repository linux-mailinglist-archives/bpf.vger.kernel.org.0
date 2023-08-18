Return-Path: <bpf+bounces-8105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 438DC7815CA
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 01:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EA7281944
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 23:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF631B7FB;
	Fri, 18 Aug 2023 23:24:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518E817AC9
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 23:24:37 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED29D4205
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 16:24:35 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bee82fab5aso11952225ad.3
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 16:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692401075; x=1693005875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7G59daYQH5+ujBpl/lrHrH46O57ATplW02l379KYKqQ=;
        b=k4I4Ch9BISL1U+4ZVRl1qgiaHYfEmVWeECcE4MaVPZvsDCvpYtsXCkNDDF6PQmT1UM
         yZYiIylBfSvBOdowqYHWDwczBl4YnfWZAn6MZvqXLnYjS07VLFoi7xcl761xVXfi88KZ
         Snu1ZxA24MdrRzy+3564DWmBurWr/90sYPEm67gDammVoi+qCT6LlyRu0aZtdHdb3Xge
         3Tz1jlCs4cMlKKmCxSd9VZaVF7UY3V3Rd3NVRbWWibuwJIeV2v9gAT890JwD/sr5JXn4
         TvqSF+zNWabqc4GsnvjT6VmnmY8Ysm3NMlsLBxbe/7HL+TkmDygH6CxxfZwgSHDPcI8o
         ix4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692401075; x=1693005875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7G59daYQH5+ujBpl/lrHrH46O57ATplW02l379KYKqQ=;
        b=TvDmt1AVH9/WLGxFKRun9mFtkLstt+c+9CvAAmn1dJlyo31oic6gDvl0jFCZaPphCk
         /0GeWfir3yPOoaFreCdyKPw4YdWtHszbEuJy3ZPeG9RsiEAIaxoxbn9dxe0bhXx272Np
         KyPPhZ/TVUfYNSXFfboqtQp6x0Eji0iuL7d9P3kP3YQHiV6HraKnB8XS/opPbKGBQlwc
         YxSJPxDnA0pkgEOH/SBeNA9zXV3UpUiBInPhfEhBieEI+Odt8sDUCjM/xJN61JdjUiV5
         ryZbJYj88YO90i51Zgwi8/9tZiap2VvLkiTvT55wIxzCwWbI1aYPB/nobSWPiejJdlis
         Q4lA==
X-Gm-Message-State: AOJu0YyfwZlnSR6Yzr235qz+rFKQVDx3By3G8FxZRQHKStJbHiYxU7RE
	eu/ZXTLYf38FjxTUr1xuT9A=
X-Google-Smtp-Source: AGHT+IFFGhvGJyDodiM4gBuRoziXZRF2B3Vknrds9qPPraLr3DxpbB9gcw9cip3HjgjktkyE92rTzw==
X-Received: by 2002:a17:902:e881:b0:1b9:e091:8037 with SMTP id w1-20020a170902e88100b001b9e0918037mr818999plg.30.1692401075302;
        Fri, 18 Aug 2023 16:24:35 -0700 (PDT)
Received: from macbook-pro-8.dhcp.thefacebook.com ([2620:10d:c090:500::5:1ebf])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b001b9ecee459csm2307155plh.34.2023.08.18.16.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 16:24:34 -0700 (PDT)
Date: Fri, 18 Aug 2023 16:24:31 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: David Marchevsky <david.marchevsky@linux.dev>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next 02/15] bpf: Add BPF_KPTR_PERCPU_REF as a field
 type
Message-ID: <20230818232431.oatk3fpeuzzclooo@macbook-pro-8.dhcp.thefacebook.com>
References: <20230814172809.1361446-1-yonghong.song@linux.dev>
 <20230814172820.1362751-1-yonghong.song@linux.dev>
 <ee360b23-9768-9187-4eb0-d43b67bcd07c@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee360b23-9768-9187-4eb0-d43b67bcd07c@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 02:37:41PM -0400, David Marchevsky wrote:
> On 8/14/23 1:28 PM, Yonghong Song wrote:
> > BPF_KPTR_PERCPU_REF represents a percpu field type like below
> > 
> >   struct val_t {
> >     ... fields ...
> >   };
> >   struct t {
> >     ...
> >     struct val_t __percpu *percpu_data_ptr;
> >     ...
> >   };
> > 
> > where
> >   #define __percpu __attribute__((btf_type_tag("percpu")))
> 
> nit: Maybe this should be __percpu_kptr (and similar for the actual tag)?

+1.

I think it might conflict with kernel:
include/linux/compiler_types.h:# define __percpu	BTF_TYPE_TAG(percpu)
It's the same tag name, but the kernel semantics are different from our kptr
semantics inside bpf prog.
I think we have to use a different tag like:
#define __percpu_kptr __attribute__((btf_type_tag("percpu_kptr")))

> > index 60e80e90c37d..e6348fd0a785 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -180,14 +180,15 @@ enum btf_field_type {
> >  	BPF_TIMER      = (1 << 1),
> >  	BPF_KPTR_UNREF = (1 << 2),
> >  	BPF_KPTR_REF   = (1 << 3),
> > -	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
> > -	BPF_LIST_HEAD  = (1 << 4),
> > -	BPF_LIST_NODE  = (1 << 5),
> > -	BPF_RB_ROOT    = (1 << 6),
> > -	BPF_RB_NODE    = (1 << 7),
> > +	BPF_KPTR_PERCPU_REF   = (1 << 4),

I think _REF is redundant here. _UNREF is obsolete. We might remove it and
rename BPF_KPTR_REF to just BPF_KPTR.
BPF_KPTR_PERCPU should be clear enough.

