Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B476318714
	for <lists+bpf@lfdr.de>; Thu, 11 Feb 2021 10:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhBKJ1c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Feb 2021 04:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBKJYm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Feb 2021 04:24:42 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE71EC061756
        for <bpf@vger.kernel.org>; Thu, 11 Feb 2021 01:24:00 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i9so4928040wmq.1
        for <bpf@vger.kernel.org>; Thu, 11 Feb 2021 01:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gdTYb3nojBP4ziNj300pneF3I7DP045P1DVASbGKFOI=;
        b=FdWHUGHCbSUL2D2REA+hdKNGr2PoSVSJJhGK1YYgSSzirdCEbQzgqiD3TbExOSGfnq
         7dpQ4YPRtgjfG0DFu+4Os0P0OlPFU8iJoZPVawlfLwyjGX4JLj9FnlK36dZwtsbi1Uie
         jpgt8xB7l6yzGFDng/sCZWZLJLdtEnpLYgLOQybhSQRObpO5KUuA9GI+hdladiMX0Dxx
         jU00aDEPr+FIPMX1AU2UpceUhiEQnduIY8cJztGioz9oi6t9vIoi3hk87JhQRZP2TawO
         81ZxsHCcEHgEJLVCN+VcNMX9CQO9gkTFUui3OkZoKbdnWGfhWRHKe6mEZoqmo9Qm1TvU
         9FoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gdTYb3nojBP4ziNj300pneF3I7DP045P1DVASbGKFOI=;
        b=DO02LNeoADJmZ0I3+6LgZ9+XbKQIwe5vPOX5nzjTBHUiQ+8687QMRWp+DxnXI2uuad
         X+FGupLal0LB0OFpnWKZkwam9tTIhH6h+gC6Yp6y44CHjY004gX11eaJkgp0UM5GCbkb
         8/jNKt0bA3SU1RNHkABPkIGD+hxAHgp5TUao4H1cGfBSBRvnBuFpCSiqw4m6vH0Jsdbp
         udljHvSdqyUZTUm6P/MC57vkW9Ae+wTVn/Ro3zK8uBsq0MbJdJF3xyVXGJThEZAdF02a
         zIWW2tlwjo+g6yEa474LgmX55D8828ooWp3iaM2O2/ggchLXBJ5D6N4veVdlO2QKByrz
         8FJg==
X-Gm-Message-State: AOAM531SOsSCGVIlcCSfLDYjF7D7l8e8lJQ/zUOKeidICuyME28tDIkI
        Ovkoa1lmOHClEfaMXTp6PY493Q==
X-Google-Smtp-Source: ABdhPJzFZjgMnZzMLl5ywp8H2gM9jT3VxzvKRi3DjO/WHgcVanPJVaSK84cIwyD3C6tga1o5PBzWDQ==
X-Received: by 2002:a1c:43c6:: with SMTP id q189mr4247356wma.119.1613035439578;
        Thu, 11 Feb 2021 01:23:59 -0800 (PST)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id c9sm8770219wmb.33.2021.02.11.01.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 01:23:58 -0800 (PST)
Date:   Thu, 11 Feb 2021 13:23:50 +0400
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Andrey Ignatov <rdna@fb.com>
Subject: Re: [PATCH v2 bpf-next 3/4] bpf: Support pointers in global func args
Message-ID: <20210211092350.tl65kn2v2alu2sbf@amnesia>
References: <20210209064421.15222-1-me@ubique.spb.ru>
 <20210209064421.15222-4-me@ubique.spb.ru>
 <CAEf4BzZ8nYbBTagycWLVA5bCAsPfAZ8s=yFe3uScB8w+rwPZSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ8nYbBTagycWLVA5bCAsPfAZ8s=yFe3uScB8w+rwPZSA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 10, 2021 at 03:32:48PM -0800, Andrii Nakryiko wrote:
> On Mon, Feb 8, 2021 at 10:44 PM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
> >
> > Add an ability to pass a pointer to a type with known size in arguments
> > of a global function. Such pointers may be used to overcome the limit on
> > the maximum number of arguments, avoid expensive and tricky workarounds
> > and to have multiple output arguments.
> >
> > A referenced type may contain pointers but indirect access through them
> > isn't supported.
> >
> > The implementation consists of two parts.  If a global function has an
> > argument that is a pointer to a type with known size then:
> >
> >   1) In btf_check_func_arg_match(): check that the corresponding
> > register points to NULL or to a valid memory region that is large enough
> > to contain the expected argument's type.
> >
> >   2) In btf_prepare_func_args(): set the corresponding register type to
> > PTR_TO_MEM_OR_NULL and its size to the size of the expected type.
> >
> > A call to a global function may change stack's memory slot type(via
> > check_helper_mem_access) similar to a helper function. That is why new
> > pointer arguments are allowed only for functions with global linkage.
> > Consider a case: stack's memory slot type is changed to STACK_MISC from
> > spilled PTR_TO_PACKET(btf_check_func_arg_match() -> check_mem_reg() ->
> > check_helper_mem_access() -> check_stack_boundary()) after a call to a
> > static function and later verifier cannot infer safety of indirect
> > accesses through the stack memory(check_stack_read() ->
> > __mark_reg_unknown ()). This will break existing code.
> 
> Ok, so it took me a while (few attempts and some playing around with
> static subprogs in selftests) to understand what is this paragraph is
> talking about. So let me confirm, and maybe we can use that to
> rephrase this into more clear explanation.
> 
> So the problem with allowing any (<type> *) argument for static
> functions is that in such case static function might get successfully
> validated as if it was global (i.e., based on types of its input
> arguments). And in such case, corresponding stack slots in the caller
> program will be marked with MISC types, because in general case we
> can't know what kind of data is stored in the stack.
> 
> So here, instead of allowing this for static functions and eventually
> optimistically validating it with STACK_MISC slots, we will fail
> upfront and will rely on verifier to fallback to "inline" validation
> of static functions, which will lead to a proper stack slots marking.
> It will be less efficient validation, but would preserve more
> information. For global we don't have the fallback case, so we'll just
> do our best and will live with MISC slots.
> 
> Did I get this right?

Yes and sorry for the cryptic issue description.

A slot type may be changed due to the fact that after a call to
global or a helper function we don't have a guarantee that the
data won't changed. The only guarantee we have is that it is
still a valid memory and hence we have to change its slot type to
MISC(because possibly it have been overwritten by a helper or a
global function and we cannot rely on the previous type).

Allowing pointers in arguments for static functions breaks
existing code because verifier is no longer able to infer safety
of memory(due to the slot type change). Hence we have to allow it
only for global functions. The verifier continues to use "inline"
validation for static functions (we are not making it worse) and
more types of global functions are supported(we are making it
better).

I will rephrase the commit message in v3.

> 
> >
> > Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> > ---
> 
> So apart from the very confusing bit about special global func
> handling here and some concerns about register ID generation, the
> logic looks good, so:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thank you.
I will address wording, ID generation and typo in v3.

> 
> > v1 -> v2:
> >  - Allow pointers only for global functions
> >  - Add support of any type with known size
> >  - Use conventional way to generate reg id
> >  - Use boolean true/false instead of int 1/0
> >  - Fix formatting
> >
> >  include/linux/bpf_verifier.h |  2 ++
> >  kernel/bpf/btf.c             | 55 +++++++++++++++++++++++++++++-------
> >  kernel/bpf/verifier.c        | 30 ++++++++++++++++++++
> >  3 files changed, 77 insertions(+), 10 deletions(-)
> >
> 
> [...]
> 
> > @@ -5470,9 +5488,26 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
> >                         reg->type = SCALAR_VALUE;
> >                         continue;
> >                 }
> > -               if (btf_type_is_ptr(t) &&
> > -                   btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
> > -                       reg->type = PTR_TO_CTX;
> > +               if (btf_type_is_ptr(t)) {
> > +                       if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
> > +                               reg->type = PTR_TO_CTX;
> > +                               continue;
> > +                       }
> > +
> > +                       t = btf_type_skip_modifiers(btf, t->type, NULL);
> > +
> > +                       ref_t = btf_resolve_size(btf, t, &reg->mem_size);
> > +                       if (IS_ERR(ref_t)) {
> > +                               bpf_log(log,
> > +                                   "arg#%d reference type('%s %s') size cannot be determined: %ld\n",
> > +                                   i, btf_type_str(t), btf_name_by_offset(btf, t->name_off),
> > +                                       PTR_ERR(ref_t));
> > +                               return -EINVAL;
> > +                       }
> > +
> > +                       reg->type = PTR_TO_MEM_OR_NULL;
> > +                       reg->id = i + 1;
> 
> I see that in a bunch of other places we use reg->id = ++env->id_gen;
> to generate register IDs, that looks safer and should avoid any
> accidental ID collision. Is there any reason not to do that here?

Yes, you are right - I somehow lost this while working on the
second version. I will double check that it works as expected in
v3.

> 
> > +
> >                         continue;
> >                 }
> >                 bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index d68ea6eb4f9b..fd423af1cc57 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3942,6 +3942,29 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
> >         }
> >  }
> >
> > +int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > +                  u32 regno, u32 mem_size)
> > +{
> > +       if (register_is_null(reg))
> > +               return 0;
> > +
> > +       if (reg_type_may_be_null(reg->type)) {
> > +               /* Assuming that the register contains a value check if the memory
> > +                * access is safe. Temorarily save and restore the register's state as
> 
> typo: temporarily
> 
> > +                * the conversion shouldn't be visible to a caller.
> > +                */
> > +               const struct bpf_reg_state saved_reg = *reg;
> > +               int rv;
> > +
> > +               mark_ptr_not_null_reg(reg);
> > +               rv = check_helper_mem_access(env, regno, mem_size, true, NULL);
> > +               *reg = saved_reg;
> > +               return rv;
> > +       }
> > +
> > +       return check_helper_mem_access(env, regno, mem_size, true, NULL);
> > +}
> > +
> >  /* Implementation details:
> >   * bpf_map_lookup returns PTR_TO_MAP_VALUE_OR_NULL
> >   * Two bpf_map_lookups (even with the same key) will have different reg->id.
> > @@ -11572,6 +11595,13 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
> >                                 mark_reg_known_zero(env, regs, i);
> >                         else if (regs[i].type == SCALAR_VALUE)
> >                                 mark_reg_unknown(env, regs, i);
> > +                       else if (regs[i].type == PTR_TO_MEM_OR_NULL) {
> > +                               const u32 mem_size = regs[i].mem_size;
> > +
> > +                               mark_reg_known_zero(env, regs, i);
> > +                               regs[i].mem_size = mem_size;
> > +                               regs[i].id = ++env->id_gen;
> > +                       }
> >                 }
> >         } else {
> >                 /* 1st arg to a function */
> > --
> > 2.25.1
> >

-- 

Dmitrii Banshchikov
