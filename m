Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC09167A9FE
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 06:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjAYFgx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 00:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAYFgw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 00:36:52 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800344863A;
        Tue, 24 Jan 2023 21:36:51 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id lp10so13965678pjb.4;
        Tue, 24 Jan 2023 21:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymN2eyp6augZo3R/KSeOQiq6ZFc9iSQ3uGk9w/Giiaw=;
        b=7kaXHWqW56cbt3lW+1BLfldqXioSFRh4wDF6nxJS3wpI01Ag3Df0b31BTC/Slds7lB
         4uaKRtwM630E3tDoQxF4lIiXFcHSckgQMlqQqcO8D/Lt8IhjnPGFTotfAqiKDWCBRCbm
         XCd6ydi3Yor+JbM4cfDM2besJHY1GDDuYCcRyK8HDhVkpAY56Z7ky3RaBivGGdioRh/S
         JV3rEDYqxhCCbbYtzj5oWYvLucj74woscgSrdDf1xdg0X1EATD32T2BCXAGBE0tDVKRD
         0qcLFZkVvw8D4pPZB71R1pLUyHUP0ANHS8R/YF6yfeI2QAvNAaid2QdYpRMcytSxAVNd
         MFTw==
X-Gm-Message-State: AFqh2krinEUypjGtsEctgkH+nMUz48FwHfRoSFZmp6NZd7TC5ktAgaeg
        HdLLIEHVjHdfEqOwKuqkZWQd7Ru+PERlLsK+
X-Google-Smtp-Source: AMrXdXuIbbc4pl/x6kX2I9zLLpprTmPM9W7+iOjaFR0Gb2tay64lIL+D1/tCWJdE7kJE8Et4mGDqiw==
X-Received: by 2002:a05:6a20:6922:b0:b6:99a4:66bd with SMTP id q34-20020a056a20692200b000b699a466bdmr44578574pzj.38.1674625010797;
        Tue, 24 Jan 2023 21:36:50 -0800 (PST)
Received: from maniforge ([2620:10d:c090:400::5:d24a])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c10c00b0016d72804664sm2617135pli.205.2023.01.24.21.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 21:36:50 -0800 (PST)
Date:   Tue, 24 Jan 2023 23:36:45 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org,
        memxor@gmail.com
Subject: Re: [PATCH bpf-next v2 4/9] bpf: Enable cpumasks to be queried and
 used as kptrs
Message-ID: <Y9C/7fxsIPXiG6mr@maniforge>
References: <20230120192523.3650503-1-void@manifault.com>
 <20230120192523.3650503-5-void@manifault.com>
 <20230125043602.gmpi54ixerelmzzx@iphone-mikan.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125043602.gmpi54ixerelmzzx@iphone-mikan.dhcp.thefacebook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 24, 2023 at 08:36:02PM -0800, Alexei Starovoitov wrote:
> On Fri, Jan 20, 2023 at 01:25:18PM -0600, David Vernet wrote:
> > +
> > +/**
> > + * struct bpf_cpumask - refcounted BPF cpumask wrapper structure
> > + * @cpumask:	The actual cpumask embedded in the struct.
> > + * @usage:	Object reference counter. When the refcount goes to 0, the
> > + *		memory is released back to the BPF allocator, which provides
> > + *		RCU safety.
> > + *
> > + * Note that we explicitly embed a cpumask_t rather than a cpumask_var_t.  This
> > + * is done to avoid confusing the verifier due to the typedef of cpumask_var_t
> > + * changing depending on whether CONFIG_CPUMASK_OFFSTACK is defined or not. See
> > + * the details in <linux/cpumask.h>. The consequence is that this structure is
> > + * likely a bit larger than it needs to be when CONFIG_CPUMASK_OFFSTACK is
> > + * defined due to embedding the whole NR_CPUS-size bitmap, but the extra memory
> > + * overhead is minimal. For the more typical case of CONFIG_CPUMASK_OFFSTACK
> > + * not being defined, the structure is the same size regardless.
> > + */
> > +struct bpf_cpumask {
> > +	cpumask_t cpumask;
> > +	refcount_t usage;
> > +};
> > +
> > +static struct bpf_mem_alloc bpf_cpumask_ma;
> > +
> > +static bool cpu_valid(u32 cpu)
> > +{
> > +	return cpu < nr_cpu_ids;
> > +}
> > +
> > +__diag_push();
> > +__diag_ignore_all("-Wmissing-prototypes",
> > +		  "Global kfuncs as their definitions will be in BTF");
> > +
> > +struct bpf_cpumask *bpf_cpumask_create(void)
> > +{
> > +	struct bpf_cpumask *cpumask;
> > +
> > +	cpumask = bpf_mem_alloc(&bpf_cpumask_ma, sizeof(*cpumask));
> > +	if (!cpumask)
> > +		return NULL;
> > +
> > +	memset(cpumask, 0, sizeof(*cpumask));
> > +	refcount_set(&cpumask->usage, 1);
> > +
> > +	return cpumask;
> > +}
> 
> Applied patches 1 and 2. Patch 3 doesn't apply anymore. Pls rebase.

Ack, will rebase for v3.

> I'm fine with existing bpf_cpumask proposal, but can we do better?
> This is so close to be a bitmap template.

Agreed that they're close, but I'm not a fan of the UX taxes for what we
get out of it. More below.

> Can we generalize it as
> struct bpf_bitmap {
> 	refcount_t refcnt;
>         int num_bits;
>         u64 bits[];
> };
> 
> struct bpf_bitmap *bpf_bitmap_create(int bits)
> {
>   bitmap = bpf_mem_alloc(&bpf_cpumask_ma, sizeof(*bitmap) + BITS_TO_LONGS(bits) * sizeof(u64));
>   bitmap->num_bits = bits;
> }

+1 that having bitmap kfuncs would be nice to expose, and should be
pretty easy to add. Happy to do so in a follow-on patch set.

> 
> and special case few custom kfuncs in the verifier that allow
> type cast from bpf_bitmap with to 'struct cpumask *' ? Like
> struct cpumask *bpf_bitmap_cast_to_cpumask(struct bpf_bitmap *bitmap)
> {
>   if (bitmap->num_bits == nr_cpu_ids)
>      return bitmap->bits;
>   return NULL;
> }
> BTF_ID_FLAGS(func, bpf_bitmap_cast_to_cpumask, KF_TRUSTED_ARGS | KF_RET_NULL)

This I'm not a huge fan of though. It seems like we're removing a useful
abstraction and adding a UX tax just to avoid defining and exporting an
additional small set of kfuncs for allocating, and acquire/releasing a
struct bpf_cpumask. That logic is very minimal, just around 100 lines of
code including doxygen comments.

It's kind of unfortunate that cpumask is so close to bitmap, but that's
nothing new -- <linux/cpumask.h> in the kernel is little more than a
thin wrapper around a bitmap that simply provides some more ergonomic
APIs, along with some magic that makes it safe to access cpumask_var_t
on the stack regardless of NR_CPUS. The latter doesn't apply to BPF, but
the former does.

> The UX will be a bit worse, since bpf prog would need to do !=NULL check
> but with future bpf_assert() we may get rid of !=NULL check.
> 
> We can keep direct cpumask accessors as kfuncs:
> 
> u32 bpf_cpumask_first(const struct cpumask *cpumask);
> u32 bpf_cpumask_first_zero(const struct cpumask *cpumask);
> 
> and add bpf_find_first_bit() and the rest of bit manipulations.

Worth noting as well is that I think struct bpf_bitmap is going to be
treated somewhat differently than struct bpf_cpumask and struct cpumask.
There is no type-safety for bitmaps in the kernel. They're just
represented as unsigned long *, so I don't we'll be able to allow
programs to pass bitmaps allocated elsewhere in the kernel to read-only
bitmap kfuncs like we do for struct cpumask *, as the verifier will just
interpret them as pointers to statically sized scalars.

> Since all of the bpf_cpumask do run-time cpu_valid() check we're not
> sacrificing performance.
> 
> Feels more generic with wider applicability at the expense of little bit worse UX.
> I haven't thought about acq/rel consequences.

The TL;DR from me is that I agree that having bitmap kfuncs is a great
idea, but I don't see the need to tie the two at the hip at the cost of
a worse UX. I'd prefer to push the extra complexity into the BPF backend
in favor of a simpler programming front-end for users.

Thoughts?
