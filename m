Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEE662A207
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 20:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiKOThu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 14:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiKOTht (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 14:37:49 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8EF2DAA3
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 11:37:48 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id b21so14077836plc.9
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 11:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4HTRVItWd90xJ5p1Oe/xhcCR2B9/YgdPRkXYZuBV4k8=;
        b=K1dMg8vwZfydtw5jsRRJgwXC6dUlUHe4KaHOK4vMCBzXYK+2jLG7fhACehpFZ719cN
         1txBrW4V8ZM96w++tCBDR67P6mJ7X+ohrvvB7tkl19r60IhR7hVEl32L1eSGpvfQNeGr
         qsu3kn3NYDK/SUWQxIjGHrEYzeotQ+u/g5GgUQSJi7m2Ebamzl+w7sXQ4PsuTAm6DkEX
         LtvHOf/Y3xosLco3d2znH0C5Mdr5LVh+qjrOawEYY8i+1TMFgFHFxS/yB906xFL0qhN7
         rQa75tTASiWUtG4vRlMD39DeXOeRJ/2+hunvKN/FSegcW+CKeJEpq9UQNPdqHAO9lY5B
         Jxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HTRVItWd90xJ5p1Oe/xhcCR2B9/YgdPRkXYZuBV4k8=;
        b=6px7yqesucuuqwoH5nSih0A8ebqFSE89XrZ6cgY3jXahq60lttcMyMwd1oXCQkDJcK
         0pSb0dDsxabQ3AfjDp85Od3Sf+sPteMtLhfHjSeARDUzEr4esQ3fBYXhs0Yyh8Srr61x
         pQ5Qb83UQB0cwiwtu1OkBghmLi9Qz7Vpao3fDaDdwo+TFEEPd8pjGVAQuJG/UuE+vibH
         EENitMFBPcPOj9MSK5J6kCH9peWbctKuzXDNghtyqvIhj7IXUAB0CMQk3cpGMQTjd6g0
         z0WOM4tOb1TognFl2qYUWZmr/HN3Vu/WEQcgDvHBngiIhoIy06rqFR4Htrc0t6IQrtew
         NX2g==
X-Gm-Message-State: ANoB5pl+D9uFb5bjm28NROLj1no9HH6f49h/2dXSvr77fkPxSSuiKtPs
        o5v36zCn0hxxeyxBDyq1dPA=
X-Google-Smtp-Source: AA0mqf6uDbZrrFgG4QgSK6ZvTvdSMpuHHnTsQk0OxeSaWQAzakHmJOXDeYNmppWqkw6PcIUZoV6XWA==
X-Received: by 2002:a17:902:6b02:b0:188:62b9:a6ef with SMTP id o2-20020a1709026b0200b0018862b9a6efmr5583758plk.4.1668541067503;
        Tue, 15 Nov 2022 11:37:47 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a71c800b00213d08fa459sm8902222pjs.17.2022.11.15.11.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 11:37:47 -0800 (PST)
Date:   Wed, 16 Nov 2022 01:07:42 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v7 12/26] bpf: Allow locking bpf_spin_lock
 global variables
Message-ID: <20221115193742.i5gtaopg7ux7lp7t@apollo>
References: <20221114191547.1694267-1-memxor@gmail.com>
 <20221114191547.1694267-13-memxor@gmail.com>
 <3e726a4f-5e26-47c7-ddfe-0cd73778f4b5@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e726a4f-5e26-47c7-ddfe-0cd73778f4b5@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 11:03:02PM IST, Dave Marchevsky wrote:
> On 11/14/22 2:15 PM, Kumar Kartikeya Dwivedi wrote:
> > Global variables reside in maps accessible using direct_value_addr
> > callbacks, so giving each load instruction's rewrite a unique reg->id
> > disallows us from holding locks which are global.
> >
> > The reason for preserving reg->id as a unique value for registers that
> > may point to spin lock is that two separate lookups are treated as two
> > separate memory regions, and any possible aliasing is ignored for the
> > purposes of spin lock correctness.
> >
> > This is not great especially for the global variable case, which are
> > served from maps that have max_entries == 1, i.e. they always lead to
> > map values pointing into the same map value.
> >
> > So refactor the active_spin_lock into a 'active_lock' structure which
> > represents the lock identity, and instead of the reg->id, remember two
> > fields, a pointer and the reg->id. The pointer will store reg->map_ptr
> > or reg->btf. It's only necessary to distinguish for the id == 0 case of
> > global variables, but always setting the pointer to a non-NULL value and
> > using the pointer to check whether the lock is held simplifies code in
> > the verifier.
> >
> > This is generic enough to allow it for global variables, map lookups,
> > and allocated objects at the same time.
> >
> > Note that while whether a lock is held can be answered by just comparing
> > active_lock.ptr to NULL, to determine whether the register is pointing
> > to the same held lock requires comparing _both_ ptr and id.
> >
> > Finally, as a result of this refactoring, pseudo load instructions are
> > not given a unique reg->id, as they are doing lookup for the same map
> > value (max_entries is never greater than 1).
> >
> > Essentially, we consider that the tuple of (ptr, id) will always be
> > unique for any kind of argument to bpf_spin_{lock,unlock}.
> >
> > Note that this can be extended in the future to also remember offset
> > used for locking, so that we can introduce multiple bpf_spin_lock fields
> > in the same allocation.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h | 10 ++++++++-
> >  kernel/bpf/verifier.c        | 41 ++++++++++++++++++++++++------------
> >  2 files changed, 37 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 1a32baa78ce2..fa738abea267 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -323,7 +323,15 @@ struct bpf_verifier_state {
> >  	u32 branches;
> >  	u32 insn_idx;
> >  	u32 curframe;
> > -	u32 active_spin_lock;
> > +	struct {
> > +		/* This can either be reg->map_ptr or reg->btf, but it is only
> > +		 * used to check whether the lock is held or not by comparing to
> > +		 * NULL.
> > +		 */
> > +		void *ptr;
> > +		/* This will be reg->id */
> > +		u32 id;
> > +	} active_lock;
>
> I didn't get back to you re: naming here, but I think these names are clear,
> especially with comments elaborating on the details. The first comment can
> be clarified a bit, though. Sounds like "is only used to check whether lock is
> held or not by comparing to NULL" is saying that active_lock.ptr is only
> compared to NULL in this patch, but changes to process_spin_lock check
> which results in verbose(env, "bpf_spin_unlock of different lock\n") are
> comparing it to another ptr.
>
> Maybe you're trying to say "if active_lock.ptr
> is NULL, there's no active lock and other fields in this struct don't hold
> anything valid. If non-NULL, there is an active lock held"?
>

Makes sense, I'll improve the comment.

> Separately, the line in patch summary with "we consider that the tuple of
> (ptr, id) will always be unique" would help with clarity if it was in the
> comments here.
>

Ack.

> >  	bool speculative;
> >
> >  	/* first and last insn idx of this verifier state */
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 070d003a99f0..99b5edb56978 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -1215,7 +1215,8 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
> >  	}
> >  	dst_state->speculative = src->speculative;
> >  	dst_state->curframe = src->curframe;
> > -	dst_state->active_spin_lock = src->active_spin_lock;
> > +	dst_state->active_lock.ptr = src->active_lock.ptr;
> > +	dst_state->active_lock.id = src->active_lock.id;
> >  	dst_state->branches = src->branches;
> >  	dst_state->parent = src->parent;
> >  	dst_state->first_insn_idx = src->first_insn_idx;
> > @@ -5587,7 +5588,7 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
> >   * Since only one bpf_spin_lock is allowed the checks are simpler than
> >   * reg_is_refcounted() logic. The verifier needs to remember only
> >   * one spin_lock instead of array of acquired_refs.
> > - * cur_state->active_spin_lock remembers which map value element got locked
> > + * cur_state->active_lock remembers which map value element got locked
>
> Maybe remove "map value" here? Since previous patch adds support for allocated
> object. "remembers which element got locked" or "remembers which map value
> or allocated object" better reflect current state of spin_lock support after
> these patches.
>

Ack, I should update other discrepancies wrt the previous update in this whole
comment block.

Thanks for the review.
