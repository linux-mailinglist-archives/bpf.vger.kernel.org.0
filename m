Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4009630C03
	for <lists+bpf@lfdr.de>; Sat, 19 Nov 2022 06:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiKSFOF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Nov 2022 00:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiKSFOE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Nov 2022 00:14:04 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DE688184;
        Fri, 18 Nov 2022 21:14:02 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id w4so4486517qts.0;
        Fri, 18 Nov 2022 21:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRHihy13K5GNv/bMBCa35FdszKm54GaMpNFGxP54xdE=;
        b=RPFDJ7Bo1ZcuFT80F4B5DodohfluZFqPHfP3N07ITBAS3pHL6wVbwqEyUr1nuy2cDg
         kZTr/SX91iQPGHeRoZHYFUy3J6DP4knvH9umPeG0zn+aWwyl1c7/zTzGkf77KXyoefoX
         FG32HW9sS+Q3/VWDRcOEF9aHPn20Z6O94nEokpaJ85rwU15HnBX9zCDURoVVx3qSHLHZ
         4OmMwQwZdmk0iF5zR84xWA3voPaEdh70+j7iQYnpeaV+t2VMwtz+1+/kPJzg9FOU47xz
         nBIWbUuYRt6AW0T6Kje2dyb26tAYxfpVloIkxSaV10RUa/bWgMuPN0F25uEs45TyYKpW
         lZAQ==
X-Gm-Message-State: ANoB5pl1b9XWyDz3q3g0d6Vm9eVCc45EvQJ07v/3GRb+2mL+TcRim7+S
        hViLXIuKPk3sw4hcuiQ0grQ=
X-Google-Smtp-Source: AA0mqf51scXJ18FwDrtP9BJWE2O9uqJY8nzzG2ys6QKba5yug1QhP2u6wRJ4Ssnfwp57IYgrITZjkw==
X-Received: by 2002:a05:622a:1b14:b0:3a5:ff6e:d446 with SMTP id bb20-20020a05622a1b1400b003a5ff6ed446mr9630502qtb.5.1668834841494;
        Fri, 18 Nov 2022 21:14:01 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:cf15])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a254700b006fba44843a5sm4003951qko.52.2022.11.18.21.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 21:14:00 -0800 (PST)
Date:   Fri, 18 Nov 2022 23:14:03 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
        yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        haoluo@google.com, tj@kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 1/3] bpf: Allow trusted pointers to be passed
 to KF_TRUSTED_ARGS kfuncs
Message-ID: <Y3hmGzncGocT7BuB@maniforge.lan>
References: <20221117032402.2356776-1-void@manifault.com>
 <20221117032402.2356776-2-void@manifault.com>
 <20221118022640.borhn6iy4v2fhl7g@MacBook-Pro-5.local>
 <Y3eamIVUVb6V47LF@maniforge.lan>
 <Y3e2sdqL1E0SKJ5/@maniforge.lan>
 <20221118184500.yshwvcrx2a34xkmc@MacBook-Pro-5.local>
 <Y3f8yqhRRBIzrDvH@maniforge.lan>
 <20221119041337.eejp2dfe6w5xqplo@macbook-pro-5.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119041337.eejp2dfe6w5xqplo@macbook-pro-5.dhcp.thefacebook.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 08:13:37PM -0800, Alexei Starovoitov wrote:
> On Fri, Nov 18, 2022 at 03:44:42PM -0600, David Vernet wrote:
> > > > if it's a release arg it should always have a refcount on it.
> > > > PTR_UNTRUSTED | PTR_TRUSTED would also make no sense. MEM_FIXED_SIZE
> > > > though seems fine? In general, I thought it was prudent for us to take
> > > > the most conservative possible approach here, which is that PTR_TRUSTED
> > > > only applies when no other modifiers are present, and it applies for all
> > > > obj_ptr types (other than PTR_TO_CTX which does its own thing).
> > > 
> > > Probably worth refining when PTR_TRUSTED is cleared.
> > > For example adding PTR_UNTRUSTED should definitely clear it.



> > 
> > That makes sense for PTR_UNTRUSTED, what about the other type modifiers
> > like PTR_MAYBE_NULL? We set and unset if a ptr is NULL throughout a
> > function, so we'd have to record if it was previously trusted in order
> > to properly re-OR after a NULL check.
> 
> PTR_MAYBE_NULL is another bit and I don't think it conflicts with PTR_TRUSTED.
> PTR_TO_BTF_ID | PTR_TRUSTED is a valid pointer.
> PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL is a valid pointer or NULL.
> 
> PTR_TO_BTF_ID | PTR_MAYBE_NULL is a legacy "valid pointer" or NULL.
> That legacy pointer cannot be passed to KF_TRUSTED_ARGS kfuncs.
> 
> KF_TRUSTED_ARGS kfuncs should not accept PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL.

Indeed -- my point was that I don't think e.g. clearing PTR_TRUSTED when
we set PTR_UNTRUSTED will work, at least not yet. It's still too tricky
to find all the places where we'd have to &= ~PTR_TRUSTED or |=
PTR_TRUSTED when setting specific type modifiers. As described below, we
first have to clarify the general workflow to enable the presence of
PTR_TRUSTED to be the single source of truth for trust.

> It's a job of the prog to do != NULL check.
> Otherwise all such != NULL checks would need to move inside kfuncs which is not good.
> 
> > > MEM_ALLOC flag is probably equivalent to PTR_TRUSTED.
> > > Maybe the bit:
> > > regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
> > > should set PTR_TRUSTED as well?
> > 
> > We could, but that changes the meaning of PTR_TRUSTED and IMO makes it
> > harder to reason about. Before it was just "the kernel passed this arg
> > to the program and promises the program that it was trusted when it was
> > first passed". Now it's that plus it could mean that it points to an
> > allocated object from bpf_obj_new()". IMO we should keep all of these
> > modifiers separate so that the presence of a modifier has a well-defined
> > meaning that we can interpret in each context as needed.  In this case,
> > we can make trust opt-in, so a KF_TRUSTED_ARGS BTF pointer either of the
> > following:
> > 
> > 1. reg->ref_obj_id > 0
> > 2. Either one of PTR_TRUSTED | MEM_ALLOC type modifiers are set, and no
> >    others.
> 
> I don't think MEM_ALLOC conflicts with PTR_TRUSTED.
> MEM_ALLOC flags means that it came from bpf_obj_new() and that's what
> bpf_spin_lock and bpf_obj_drop() want to see.
> 
> Adding PTR_TRUSTED to MEM_ALLOC looks necessary to me.
> It doesn't have to be done right now, but eventually feels right.

I think I agree. MEM_ALLOC should always imply PTR_TRUSTED. Ideally we
shouldn't have to check MEM_ALLOC for KF_TRUSTED_ARGS at all, and
PTR_TRUSTED should be the only modifier representing if something is
safe. For now I'd prefer to keep them separate until we have a clear
plan, especially with respect to clearing PTR_TRUSTED for when something
unsafe happens like PTR_UNTRUSTED or PTR_MAYBE_NULL. It's all too
muddied still.

> I've been thinking whether reg->ref_obj_id > 0 condition should be converted
> to PTR_TRUSTED too...
> On one side it will simplify the check for KF_TRUSTED_ARGS.
> The only thing check_kfunc_args() would need to do is:
> is_kfunc_trusted_args(meta)
> && type_flag(reg->type) & PTR_TRUSTED
> && !(type_flag(reg->type) & PTR_MAYBE_NULL)
> 
> On the other side fixing all places where we set ref_obj_id
> and adding |= PTR_TRUSTED may be too cumbersome ?

I think it's probably too cumbersome now, but yeah, as mentioned above,
I think it's the right direction. I think it will require a lot of
thought to do it right, though. With the code the way that it is now, I
can't convince myself that we wouldn't do something like |= PTR_TRUSTED
when we observe ref_obj_id > 0, and then later &= ~PTR_TRUSTED when
setting PTR_MAYBE_NULL. I think Kumar's latest patch set is a nice step
towards achieving this clearer state. Hopefully we can continue to
improve.

> Right now we're saying PTR_TO_CTX is implicitly trusted, but we can OR
> PTR_TO_CTX with PTR_TRUSTED to make it explicit and truly generalize the check.

Further agreed, this is the correct longer-term direction.

> > Agreed that after the rebase this would no longer be correct. I think we
> > should make it opt-in, though. PTR_TRUSTED | MEM_ALLOC is fine.
> > PTR_TRUSTED | MEM_ALLOC | PTR_MAYBE_NULL would not be.
> 
> to pass into KF_TRUSTED_ARGS kfunc? Agree.
> I guess we can tighten the check a bit:
> is_kfunc_trusted_args(meta)
> && type_flag(reg->type) & PTR_TRUSTED
> && !(type_flag(reg->type) & ~(PTR_TRUSTED | MEM_ALLOC))
> 
> In english: the pointer should have PTR_TRUSTED flag and
> no other flags other than PTR_TRUSTED and MEM_ALLOC should be set.

Yeah, I think this is the correct way to model this for now. Later on
once we refactor things, the presence of PTR_TRUSTED on its own should
be sufficient. A good north star to aim towards.

I'll send this out as v8 tomorrow.
