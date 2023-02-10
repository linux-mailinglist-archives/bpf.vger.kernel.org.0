Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ACB692470
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 18:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjBJRak (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 12:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjBJRaj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 12:30:39 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F73749B4
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 09:30:38 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so6196270pjp.0
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 09:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wDBqco4G0IbzXNBbfcfeUFwc6+8wABeRDA0cnfcvNTk=;
        b=BfWPGX4MAKbzQtxYM4sPbvwAEz9kBiXmpaq9d2aJsWWMj04OSrgnUr1zAG2jwNtNXa
         zzx8wSdRLsYpRdKL77zIptLyEzLSuLYiI3LQHaWJUwp+vkOxJtlSzQ6zrrWzng8HSi//
         hWKAfsWQ8MrsTbAM8OUhTkBKISGSSZPMLftGfQoUbJjnl9y57/rrcMj7B6q9+drRui1L
         +kpleHjKTjLHi0h7TuTWCsvf6nf87OuOaoCpicW7IO9Y/URdhkAnvuJ1F5O8R1ko9nSm
         ftIIB8CPBnhCTbIi3R+N44KVeB884Exoq8TATtSicYT+qsMfwu9BKchmVgSTMD05peim
         7NXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDBqco4G0IbzXNBbfcfeUFwc6+8wABeRDA0cnfcvNTk=;
        b=Cl9J9brgcamv5N/7v0uCtZqtp3rEvTzF/ok8F0IncsAyF3sbhQUsdRd0RFbk5ON9e+
         bkHPIFvmx+3GekFKRXlZ9Q5b6Unp3lLUU4qHkorsRl8L27CQWeOmT16pieHooH96VFS1
         HvMmK5tOXpU2FiaLOf4AdB06riVqwqT/BUHtmJfr7PlY+tB88W6FMdAp0nYJ3bBwDg8n
         7853/iOgZgJKr90KZKyYky4V7lwEFjV4O/nQ29YzuLvtYLtSz9Jv+4p8Ljm4wtQLq7CG
         eJOZN6JRno8etUy/hW7dzaw75boLjztD/uRenPZ6/JETh3JmI4648dDTzqLhAb+/659y
         WNDQ==
X-Gm-Message-State: AO0yUKVduqxHLS8swbVUmILYrcp9FJaYJt79I8lxRv2LNsjvrkBkcmnD
        LdQfnSXcXX9Fvf14cV3DhYc=
X-Google-Smtp-Source: AK7set8ut0QzIABwI+8oLURKG/47ORbC93lEvl6b9Epspj0DpVLnmsGVljYDUo5vHCsXJQnHvRQxag==
X-Received: by 2002:a17:902:dac9:b0:199:4934:9d31 with SMTP id q9-20020a170902dac900b0019949349d31mr11805739plx.20.1676050237574;
        Fri, 10 Feb 2023 09:30:37 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:c6db])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902b71100b001990028c0c9sm3622961pls.68.2023.02.10.09.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 09:30:37 -0800 (PST)
Date:   Fri, 10 Feb 2023 09:30:34 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 bpf-next 08/11] bpf: Special verifier handling for
 bpf_rbtree_{remove, first}
Message-ID: <20230210173034.s26rciroliea4tgq@MacBook-Pro-6.local>
References: <20230209174144.3280955-1-davemarchevsky@fb.com>
 <20230209174144.3280955-9-davemarchevsky@fb.com>
 <20230210031125.ckngdktylhslsxwd@MacBook-Pro-6.local>
 <87fff67e-6f94-e516-28d0-0fe973f61f0e@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fff67e-6f94-e516-28d0-0fe973f61f0e@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 10, 2023 at 03:22:43AM -0500, Dave Marchevsky wrote:
> On 2/9/23 10:11 PM, Alexei Starovoitov wrote:
> > On Thu, Feb 09, 2023 at 09:41:41AM -0800, Dave Marchevsky wrote:
> >> @@ -9924,11 +9934,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >>  				   meta.func_id == special_kfunc_list[KF_bpf_list_pop_back]) {
> >>  				struct btf_field *field = meta.arg_list_head.field;
> >>  
> >> -				mark_reg_known_zero(env, regs, BPF_REG_0);
> >> -				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
> >> -				regs[BPF_REG_0].btf = field->graph_root.btf;
> >> -				regs[BPF_REG_0].btf_id = field->graph_root.value_btf_id;
> >> -				regs[BPF_REG_0].off = field->graph_root.node_offset;
> >> +				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
> >> +			} else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
> >> +				   meta.func_id == special_kfunc_list[KF_bpf_rbtree_first]) {
> >> +				struct btf_field *field = meta.arg_rbtree_root.field;
> >> +
> >> +				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
> >>  			} else if (meta.func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
> >>  				mark_reg_known_zero(env, regs, BPF_REG_0);
> >>  				regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_TRUSTED;
> >> @@ -9994,7 +10005,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >>  			if (is_kfunc_ret_null(&meta))
> >>  				regs[BPF_REG_0].id = id;
> >>  			regs[BPF_REG_0].ref_obj_id = id;
> >> +		} else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_first]) {
> >> +			ref_set_non_owning_lock(env, &regs[BPF_REG_0]);
> >>  		}
> > 
> > Looking at the above code where R0 state is set across two different if-s
> > it feels that bool non_owning_ref_lock from patch 2 shouldn't be a bool.
> 
> Re: "set across two different if-s" - I see what you mean, and the fact that
> both are doing 'meta.func_id == whatever' checks doesn't make it clear why
> they're separate. But note that above the else if that the second check
> is adding is "if (is_kfunc_acquire(&meta))" check, acquire_reference_state, etc.

fair enough. let's keep it split.

> "Is function acquire" is a function-level property and, as the kfunc flags I
> tried to add in previous versions of this series indicate, I think that
> "returns a non-owning reference" and "need to invalidate non-owning refs"
> are function-level properties as well.

agree

> As a contrast, the first addition - with mark_reg_graph_node - is more of a
> return-type-level property. Instead of doing meta.func_id checks in that change,
> we could instead assume that any kfunc returning "bpf_rb_node *" is actually
> returning a graph node type w/ bpf_rb_node field. It's certainly a blurry line
> in this case since it's necessary to peek at the bpf_rb_root arg in order to
> provide info about the node type to mark_reg_graph_node. But this is similar
> to RET_PTR_TO_MAP_VALUE logic which requires a bpf_map * to provide info about
> the map value being returned.
> 
> Why does this distinction matter at all? Because I'd like to eventually merge
> helper and kfunc verification as much as possible / reasonable, especially the
> different approaches to func_proto-like logic. Currently, the bpf_func_proto
> approach used by bpf helpers is better at expressing 
> {arg,return}-type level properties. A helper func_proto can do
> 
>   .arg2_type = ARG_PTR_TO_BTF_ID_OR_NULL | OBJ_RELEASE,
> 
> and it's obvious which arg is being released, whereas kfunc equivalent is
> KF_RELEASE flag on the kfunc itself and verifier needs to assume that there's
> a single arg w/ ref_obj_id which is being released. Sure, kfunc annotations
> (e.g. __sz, __alloc) could be extended to support all of this, but that's
> not the current state of things, and such name suffixes wouldn't work for
> retval.
> 
> Similarly, current kfunc definition scheme is better at expressing function-
> level properties:
> 
>   BTF_ID_FLAGS(func, whatever, KF_ACQUIRE)
> 
> There's no func_proto equivalent, the is_acquire_function helper used in
> check_helper_call resorts to "func_id ==" checks. For acquire specifically
> it could be faked with a OBJ_ACQUIRE flag on retval in the proto, but I
> don't know if the same would make sense for "need to invalidate non-owning
> refs" or something like KF_TRUSTED_ARGS.
> 
> Anyways, this was a long-winded way of saying that separating this logic across
> two different if-s was intentional and will help with future refactoring.

Agree with all of the above. We need to address this tech debt and merge
kfunc and helper validation, but this is orthogonal to this patch set.
It's a separate discussion to have with lots of bike shedding ahead.

> > Patch 7 also has this split initialization of the reg state.
> > First it does mark_reg_graph_node() which sets regs[regno].type = PTR_TO_BTF_ID | MEM_ALLOC
> > and then it does ref_set_non_owning_lock() that sets that bool flag.
> > Setting PTR_TO_BTF_ID | MEM_ALLOC in the helper without setting ref_obj_id > 0
> > at the same time feels error prone.
> 
> It's unfortunate that the reg type isn't really complete for rbtree_first
> until after the second chunk of code, but this was already happening with
> bpf_list_pop_{front,back}, which rely on KF_ACQUIRE flag and
> is_kfunc_acquire check to set ref_obj_id on the popped owning reference.
> 
> Maybe to assuage your 'error prone' concern some check can be added at
> the end of check_kfunc_call which ensures that PTR_TO_BTF_ID | MEM_ALLOC
> types are properly configured, and dies with 'verifier internal error'
> if not. I'm not convinced it's necessary, but regardless it would be
> similar to commit 47e34cb74d37 ("bpf: Add verifier check for BPF_PTR_POISON retval and arg")
> which I added a few months ago.

I think it's a good idea to add such safety check, but let's do it in the follow up.

> > This non_owning_ref_lock bool flag is actually a just flag.
> > I think it would be cleaner to make it similar to MEM_ALLOC and call it
> > NON_OWN_REF = BIT(14 + BPF_BASE_TYPE_BITS).
> > 
> > Then we can set it at once in this patch and in patch 7 and avoid this split init.
> > The check in patch 2 also will become cleaner.
> > Instead of:
> > if (type_is_ptr_alloc_obj(reg->type) && reg->non_owning_ref_lock)
> > it will be
> > if (reg->type == PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF)
> 
> Minor tangent: this is why I like helpers like type_is_ptr_alloc_obj - they make
> it obvious what properties a reg should have to be considered a certain type by
> the verifier, and provide more context as to what specific type check is
> happening vs a raw check.
> 
> IMO the cleanest version of that check would be if(reg_is_non_owning_ref(reg))
> with the newly-added helper doing what you'd expect.

Like
static bool type_is_non_owning_ref(u32 type)
{
        return base_type(type) == PTR_TO_BTF_ID &&  type_flag(type) & (MEM_ALLOC | NON_OWN_REF);
}

?
If so that makes sense.

> > 
> > the transition from owning to non-owning would be easier to follow as well:
> > PTR_TO_BTF_ID | MEM_ALLOC with ref_obj_id > 0
> >  -> 
> >    PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF with ref_obj_id == 0
> > 
> > and it will probably help to avoid bugs where PTR_TO_BTF_ID | MEM_ALLOC is accepted
> > but we forgot to check ref_obj_id. There are no such places now, but it feels
> > less error prone with proper flag instead of bool.
> 
> I'm not strongly opposed to a NON_OWN_REF type flag. It's a more granular
> version of the KF_RELEASE_NON_OWN flag which I tried to add in a previous
> version of this series. But some comments:
> 
> * Such a flag would eliminate the need to change bpf_reg_state in this
>   series, but I think this will be temporary. If we add support for nested
>   locks we'll need to reintroduce some "lock identity" again. If we want
>   to improve UX for non-owning reference invalidation in the case where
>   a list_head and rb_root share the same lock, we'll need to introduce some
>   "datastructure root identity" to allow invalidation of only the list's
>   non-owning refs on list_pop.

As replied to Kumar I prefer to minimize the complexity now and worry about
list_head and rb_root under the same lock later.

> * Sure, we could have both the NON_OWN_REF flag and additional {lock,root}
>   identity structures. But there isn't infinite room for type flags and
>   currently non-owning ref concept is contained to just two data structures.
>   IMO in terms of generality this flag is closer to MEM_RINGBUF than
>   PTR_MAYBE_NULL. If we're going to need {lock,root} identity structs
>   and can use them to disambiguate between owning/non-owning refs quickly,
>   why bother with an extra flag?

Let's cross that bridge when we get there.
Currently NON_OWN_REF flag looks strictly cleaner to me than extra 'bool' in reg_state.
If we need to refactor it later we can certainly do that.
I really want to move this feature forward.
