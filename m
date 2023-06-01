Return-Path: <bpf+bounces-1565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0B571944B
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 09:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB99B1C20F84
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 07:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0A6BA34;
	Thu,  1 Jun 2023 07:30:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84989539B
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 07:30:36 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10C69F
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 00:30:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f4f3ac389eso505630e87.1
        for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 00:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1685604630; x=1688196630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RBXWQrNsUvn7bO38rEocaEUCzOOC4zB4k5XMvtYX7Ig=;
        b=LS5GTHcxDcdIRdiPtppW6lpEn1RQyi9o2BZtY2BEx8A8BYdAQyNFTZebongewIebVV
         5vYBXeTw/dVbkdMQqArNLxVeoNyyWOphZtwfoDr92aC6Cn6Ym2G6Sg/5ZP4JZmphsrSZ
         ICcjJ6AAihhKWDbRkcjTlu9Gg1vy7zjdM2TXVXNZjyDjpyOBc+QgS81mLOSGS33GSrtO
         S0e/wB/Si4opWbT2D2MCmuF6vUVktMTKXfG9G1OsHQ0ysqSbBC7xYYTXawJUjmhuzlYw
         vjWlBx7JDIQZZXAtlyr74cbJmA12arc9XTNMnaQCCw2DVjb3biKdKBhskt6WACsTMb4/
         xqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685604630; x=1688196630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBXWQrNsUvn7bO38rEocaEUCzOOC4zB4k5XMvtYX7Ig=;
        b=TepOCV8eOybwLMFIkiptWeXD9dzPGmZ4V+2SCEI+hroEGloXoE6nofwNo1tisHwQKi
         SVy9FMEaAMN3SDT2laI5CHhjjS6Ay+H+7/BhO0JGfrrNOAAAKPdg8U9tplRzxxNtcwgR
         QI35Dg0VLp79J7ig5QchQ6ulB5jPNryVX9/Ol6iAry6gZB4eph4w1ZhtblvzODsV8HCZ
         wxKYjjYLcQ9FSShvCk08G+ruLDB+NNvjjsau15kbHrqACSvV8LaL97p1OJx9JgX+tfSv
         27i4N0qRHdJ5CYlF/Iyg5bKRpCbSuooUSXMbXUjdwy42GDa6wz/DBSGAXhfFDA3CxVRG
         TENQ==
X-Gm-Message-State: AC+VfDzO0Zx0ZxmiN/XdRXKOkskIZZiXF7C/jyzg+nSek6U82LRO7RW0
	lojne9uulkRF867o6E/UGrGUMA==
X-Google-Smtp-Source: ACHHUZ7wMsutgkZ5ug/A8ZSKigscKOCi183935o90gR6wFHZYKr3DrBD2YGzYikQVkJ6XGzu6tq/NA==
X-Received: by 2002:a19:f614:0:b0:4f3:a63f:6a96 with SMTP id x20-20020a19f614000000b004f3a63f6a96mr773317lfe.22.1685604629736;
        Thu, 01 Jun 2023 00:30:29 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id q15-20020a7bce8f000000b003f508115b25sm1287928wmj.4.2023.06.01.00.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:30:28 -0700 (PDT)
Date: Thu, 1 Jun 2023 07:31:28 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Joe Stringer <joe@isovalent.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new map ops ->map_pressure
Message-ID: <ZHhJUN7kQuScZW2e@zh-lab-node-5>
References: <20230531110511.64612-1-aspsk@isovalent.com>
 <20230531110511.64612-2-aspsk@isovalent.com>
 <20230531182429.wb5kti4fvze34qiz@MacBook-Pro-8.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531182429.wb5kti4fvze34qiz@MacBook-Pro-8.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 31, 2023 at 11:24:29AM -0700, Alexei Starovoitov wrote:
> On Wed, May 31, 2023 at 11:05:10AM +0000, Anton Protopopov wrote:
> >  static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
> >  {
> >  	htab_put_fd_value(htab, l);
> >  
> > +	dec_elem_count(htab);
> > +
> >  	if (htab_is_prealloc(htab)) {
> >  		check_and_free_fields(htab, l);
> >  		__pcpu_freelist_push(&htab->freelist, &l->fnode);
> >  	} else {
> > -		dec_elem_count(htab);
> >  		htab_elem_free(htab, l);
> >  	}
> >  }
> > @@ -1006,6 +1024,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
> >  			if (!l)
> >  				return ERR_PTR(-E2BIG);
> >  			l_new = container_of(l, struct htab_elem, fnode);
> > +			inc_elem_count(htab);
> 
> The current use_percpu_counter heuristic is far from perfect. It works for some cases,
> but will surely get bad as the comment next to PERCPU_COUNTER_BATCH is trying to say.
> Hence, there is a big performance risk doing inc/dec everywhere.
> Hence, this is a nack: we cannot decrease performance of various maps for few folks
> who want to see map stats.

This patch adds some inc/dec only for preallocated hashtabs and doesn't change
code for BPF_F_NO_PREALLOC (they already do incs/decs where needed). And for
preallocated hashtabs we don't need to compare counters, so a raw (non-batch)
percpu counter may be used for this case.

> If you want to see "pressure", please switch cilium to use bpf_mem_alloc htab and
> use tracing style direct 'struct bpf_htab' access like progs/map_ptr_kern.c is demonstrating.
> No kernel patches needed.
> Then bpf_prog_run such tracing prog and read all internal map info.
> It's less convenient that exposing things in uapi, but not being uapi is the point.

Thanks for the pointers, this makes sense. However, this doesn't work for LRU
which is always pre-allocated. Would it be ok if we add non-batch percpu
counter for !BPF_F_NO_PREALLOC case and won't expose it directly to userspace?

