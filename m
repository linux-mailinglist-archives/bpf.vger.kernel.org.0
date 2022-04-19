Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6195F506249
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 04:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbiDSCtj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Apr 2022 22:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiDSCti (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 22:49:38 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B5422294
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 19:46:56 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d15so13875630pll.10
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 19:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fkVswsg4IkXVN2FUbN37HAr6OADOTOpuZKsAUQJFnQ8=;
        b=jS97GTmhniE1qWSn67V1UQBbxcISegNO2Qj0YMw6bdW/wKWdZccuDG4CMFVMu9gU5/
         rVRUr4cvzC8g2xzwHGwfiiD4Q6xqMSDJ11kAbK277eoZ4Jbm+nSur/i3zvMXJ481WDDP
         ZGUgbb5MKV+vHM2HC9ZJR5vd3FCezJLtHkv+8Uf/PXIPhi01DrjJEf9bTacUwjB7iQ1w
         R4XlqmmNQhrwV1Jw47OHsYHgWU866T7rmmSIcbcmqUQDwRMtxnpHNDU03Y/8sGU63wED
         RsNO8il/2V3pQYJObzIJJZ2J9mRffLIQ8eUCtRrzYvHZWYuz/0BLAAxwqhcSFvqpB5xk
         cpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fkVswsg4IkXVN2FUbN37HAr6OADOTOpuZKsAUQJFnQ8=;
        b=6CniO/CNtBeI+XblsmGJC79I3AM7LS48+vxE7tj6mQUzcioaKSmATOC35Eu2Ul1l1M
         NqfsXxggCwm+dVD6tyjibWWjDYrN8dWi9RKxLlg08nYbd+fqfbtA5Sdn0upZxCXkbAwW
         sCX0bdxpR8xdxqlbVM6w8kIHMhhu59nSC+8dBapGOScZ4IWzXDKoYrDbIexZCuQPZwbT
         GOFNWTUzgue6VvegMYLlGjozyADoGNNPqMu+P3kNvLeuTTGro0njHHVtszNGWwIODmDi
         jo50IrQdmPS2LhgYNekJMzkalEBJzCpYhvM5fhIqWM7rGFl0pL/GnYEk6tEM7qI2sba0
         1Fww==
X-Gm-Message-State: AOAM533mvc3uw8/dsPwKjBQa3cnAeXpZRNt/aZlOKAwwEkRHAaQV657P
        WaJ/zt+oJv/db7oBUO58u/I=
X-Google-Smtp-Source: ABdhPJyTOr/2mJeD/5lsqPWtJNylb3ulupPAkJD7dN/B02JbgvW7xfy0mkM/8+srdkpJSJnkwMCWbA==
X-Received: by 2002:a17:902:e544:b0:159:572:af5e with SMTP id n4-20020a170902e54400b001590572af5emr5799272plf.107.1650336416294;
        Mon, 18 Apr 2022 19:46:56 -0700 (PDT)
Received: from localhost ([112.79.166.45])
        by smtp.gmail.com with ESMTPSA id nh11-20020a17090b364b00b001cb65949c66sm14411118pjb.37.2022.04.18.19.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 19:46:55 -0700 (PDT)
Date:   Tue, 19 Apr 2022 08:17:03 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v5 06/13] bpf: Prevent escaping of kptr loaded
 from maps
Message-ID: <20220419024703.qyv6n4dfpdf4p3ot@apollo.legion>
References: <20220415160354.1050687-1-memxor@gmail.com>
 <20220415160354.1050687-7-memxor@gmail.com>
 <CAJnrk1YBi+DMZVu3Bpq+74OnFCjkc_fAgv_P-ANgpDrrfGOukQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1YBi+DMZVu3Bpq+74OnFCjkc_fAgv_P-ANgpDrrfGOukQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 19, 2022 at 05:18:38AM IST, Joanne Koong wrote:
> On Fri, Apr 15, 2022 at 9:04 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > While we can guarantee that even for unreferenced kptr, the object
> > pointer points to being freed etc. can be handled by the verifier's
> > exception handling (normal load patching to PROBE_MEM loads), we still
> > cannot allow the user to pass these pointers to BPF helpers and kfunc,
> > because the same exception handling won't be done for accesses inside
> > the kernel. The same is true if a referenced pointer is loaded using
> > normal load instruction. Since the reference is not guaranteed to be
> > held while the pointer is used, it must be marked as untrusted.
> >
> > Hence introduce a new type flag, PTR_UNTRUSTED, which is used to mark
> > all registers loading unreferenced and referenced kptr from BPF maps,
> > and ensure they can never escape the BPF program and into the kernel by
> > way of calling stable/unstable helpers.
> To me, it seems more clear / straightforward if loads are prohibited
> altogether and the only way to get a referenced kptr from a BPF map is
> through the *_kptr_get function, instead of allowing loads but
> prohibiting the loaded value from going to bpf helpers + kfuncs. To me
> it seems like 1) using the kptr in kfuncs / helper funcs will be a
> significant portion of use cases, 2) as a user, I think it's
> non-intuitive that I'm able to retrieve it and get a direct reference
> to it but not be able to use it in a kfunc/helper func, and 3) this
> would simplify this logic in the verifier where we don't need to add
> PTR_UNTRUSTED.
> What are your thoughts?
>

Given this is atleast needed for the unreferenced case, so the flag needs to
stay, but considering just referenced kptr:

1) is true, but in many use cases just reading from the object is also enough,
in those cases imposing the cost of kptr_get is too much, I think. If there are
reasonable gurantees that the object won't go away, or some way to detect that
the pointer changed (e.g. by detecting writer presence [0]), it should be safe
to permit reads from such untrusted pointer without ensuring user holds a
refcount. You can imagine case where you have programs attached to a callchain,
and you stash a ref in a map in an invocation earlier in the chain, then inspect
the data somewhere in the middle, and eventually drop the ref, etc. The fact
that this can be made safe using the exception handling is a great feature IMO.

2) It can certainly be a bit surprising, but I think kptr_ref is already special
enough that the user needs to carefully understand the semantics when making use
of them. Even now, you will have to use kptr_get to be able to get a normal
PTR_TO_BTF_ID they can pass to helpers, the untrusted pointer is for cases where
you know what you are doing (and know that what you'll read is still valid at a
later point, depending on how that data will be used).

3) We already need this flag, for this case and eventually also making this the
default for majority of cases where we cannot prove PTR_TO_BTF_ID is safe (e.g.
in tracing or LSM ctx). See [1] for some background. There are going to be a lot
more cases going forward where dereference is safe (hence allowed) but passing
to helpers or kfunc is not.

 [0]: https://lore.kernel.org/bpf/20220222082129.yivvpm6yo3474dp3@apollo.legion
 [1]: https://lore.kernel.org/bpf/CAADnVQJF8yQgKRQH2CqXuB9JR-p3fQeiGRxB0+N_V7uTH2iOeA@mail.gmail.com

> >
> > In check_ptr_to_btf_access, the !type_may_be_null check to reject type
> > flags is still correct, as apart from PTR_MAYBE_NULL, only MEM_USER,
> > MEM_PERCPU, and PTR_UNTRUSTED may be set for PTR_TO_BTF_ID. The first
> > two are checked inside the function and rejected using a proper error
> > message, but we still want to allow dereference of untrusted case.
> >
> > Also, we make sure to inherit PTR_UNTRUSTED when chain of pointers are
> > walked, so that this flag is never dropped once it has been set on a
> > PTR_TO_BTF_ID (i.e. trusted to untrusted transition can only be in one
> > direction).
> >
> > In convert_ctx_accesses, extend the switch case to consider untrusted
> > PTR_TO_BTF_ID in addition to normal PTR_TO_BTF_ID for PROBE_MEM
> > conversion for BPF_LDX.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h   | 10 +++++++++-
> >  kernel/bpf/verifier.c | 35 ++++++++++++++++++++++++++++-------
> >  2 files changed, 37 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 61f83a23980f..7e2ac2a26bdb 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -375,7 +375,15 @@ enum bpf_type_flag {
> >         /* Indicates that the pointer argument will be released. */
> >         PTR_RELEASE             = BIT(5 + BPF_BASE_TYPE_BITS),
> >
> > -       __BPF_TYPE_LAST_FLAG    = PTR_RELEASE,
> > +       /* PTR is not trusted. This is only used with PTR_TO_BTF_ID, to mark
> > +        * unreferenced and referenced kptr loaded from map value using a load
> > +        * instruction, so that they can only be dereferenced but not escape the
> > +        * BPF program into the kernel (i.e. cannot be passed as arguments to
> > +        * kfunc or bpf helpers).
> > +        */
> > +       PTR_UNTRUSTED           = BIT(6 + BPF_BASE_TYPE_BITS),
> > +
> > +       __BPF_TYPE_LAST_FLAG    = PTR_UNTRUSTED,
> >  };
> >
> >  /* Max number of base types. */
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index aa5c0d1c8495..3b89dc8d41ce 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -567,6 +567,8 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
> >                 strncpy(prefix, "user_", 32);
> >         if (type & MEM_PERCPU)
> >                 strncpy(prefix, "percpu_", 32);
> > +       if (type & PTR_UNTRUSTED)
> > +               strncpy(prefix, "untrusted_", 32);
> >
> >         snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
> >                  prefix, str[base_type(type)], postfix);
> > @@ -3504,9 +3506,14 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
> >                                struct bpf_reg_state *reg, u32 regno)
> >  {
> >         const char *targ_name = kernel_type_name(off_desc->kptr.btf, off_desc->kptr.btf_id);
> > +       int perm_flags = PTR_MAYBE_NULL;
> >         const char *reg_name = "";
> >
> > -       if (base_type(reg->type) != PTR_TO_BTF_ID || type_flag(reg->type) != PTR_MAYBE_NULL)
> > +       /* Only unreferenced case accepts untrusted pointers */
> > +       if (off_desc->type == BPF_MAP_OFF_DESC_TYPE_UNREF_KPTR)
> > +               perm_flags |= PTR_UNTRUSTED;
> > +
> > +       if (base_type(reg->type) != PTR_TO_BTF_ID || (type_flag(reg->type) & ~perm_flags))
> >                 goto bad_type;
> >
> >         if (!btf_is_kernel(reg->btf)) {
> > @@ -3532,7 +3539,12 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
> >  bad_type:
> >         verbose(env, "invalid kptr access, R%d type=%s%s ", regno,
> >                 reg_type_str(env, reg->type), reg_name);
> > -       verbose(env, "expected=%s%s\n", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
> > +       verbose(env, "expected=%s%s", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
> > +       if (off_desc->type == BPF_MAP_OFF_DESC_TYPE_UNREF_KPTR)
> > +               verbose(env, " or %s%s\n", reg_type_str(env, PTR_TO_BTF_ID | PTR_UNTRUSTED),
> > +                       targ_name);
> > +       else
> > +               verbose(env, "\n");
> >         return -EINVAL;
> >  }
> >
> > @@ -3556,9 +3568,11 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
> >                 return -EACCES;
> >         }
> >
> > -       /* We cannot directly access kptr_ref */
> > -       if (off_desc->type == BPF_MAP_OFF_DESC_TYPE_REF_KPTR) {
> > -               verbose(env, "accessing referenced kptr disallowed\n");
> > +       /* We only allow loading referenced kptr, since it will be marked as
> > +        * untrusted, similar to unreferenced kptr.
> > +        */
> > +       if (class != BPF_LDX && off_desc->type == BPF_MAP_OFF_DESC_TYPE_REF_KPTR) {
> > +               verbose(env, "store to referenced kptr disallowed\n");
> >                 return -EACCES;
> >         }
> >
> > @@ -3568,7 +3582,7 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
> >                  * value from map as PTR_TO_BTF_ID, with the correct type.
> >                  */
> >                 mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, off_desc->kptr.btf,
> > -                               off_desc->kptr.btf_id, PTR_MAYBE_NULL);
> > +                               off_desc->kptr.btf_id, PTR_MAYBE_NULL | PTR_UNTRUSTED);
> >                 val_reg->id = ++env->id_gen;
> >         } else if (class == BPF_STX) {
> >                 val_reg = reg_state(env, value_regno);
> > @@ -4336,6 +4350,12 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
> >         if (ret < 0)
> >                 return ret;
> >
> > +       /* If this is an untrusted pointer, all pointers formed by walking it
> > +        * also inherit the untrusted flag.
> > +        */
> > +       if (type_flag(reg->type) & PTR_UNTRUSTED)
> > +               flag |= PTR_UNTRUSTED;
> > +
> >         if (atype == BPF_READ && value_regno >= 0)
> >                 mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
> >
> > @@ -13054,7 +13074,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
> >                 if (!ctx_access)
> >                         continue;
> >
> > -               switch (env->insn_aux_data[i + delta].ptr_type) {
> > +               switch ((int)env->insn_aux_data[i + delta].ptr_type) {
> >                 case PTR_TO_CTX:
> >                         if (!ops->convert_ctx_access)
> >                                 continue;
> > @@ -13071,6 +13091,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
> >                         convert_ctx_access = bpf_xdp_sock_convert_ctx_access;
> >                         break;
> >                 case PTR_TO_BTF_ID:
> > +               case PTR_TO_BTF_ID | PTR_UNTRUSTED:
> >                         if (type == BPF_READ) {
> >                                 insn->code = BPF_LDX | BPF_PROBE_MEM |
> >                                         BPF_SIZE((insn)->code);
> > --
> > 2.35.1
> >

--
Kartikeya
