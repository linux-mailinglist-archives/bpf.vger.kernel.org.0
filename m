Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A908344EED4
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 22:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhKLVtx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 16:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbhKLVtv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 16:49:51 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A95C06127A
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 13:47:00 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so8243550pja.1
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 13:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PxJNAM+TSJFFf2ZSXMoRuCHlQyVUMJVxesPPWiMLcWI=;
        b=ek72KKNOK499A+Cc3aTVT3N7GdOLZAv/SQWmU+lOSYl9aFnUm+2gkhCNkgsf05W5He
         VR0iXNrmmwuOes3p9LZoe9aWzdoY8smwWKVrh9obGunlWeR7TLYR/tlbWyBG+b7eecV1
         RdFM+UQGK+jds5wq9dMtWF2BTj+VIZpbmbvwPmcT1QO/yinyKuhYbzcMpRr3R1gGBLVB
         oZFN4QqfDFjlF8zzBM4VrZQAZhLLEzdK6Zc2oKLHn+PfW/kaDLuoyB91LKOxVH0APoWV
         YAzbJFzqa0AXjT3XDO1vaQR1Ul73w0v3R8wPKb63rzLZ5/WYZlFCoSLUHI90YZbH8Ru1
         3p0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PxJNAM+TSJFFf2ZSXMoRuCHlQyVUMJVxesPPWiMLcWI=;
        b=Iioff4Tk+bPpy3GJ4gDheJfxPAAg8bRPSKxET6QTivHaQFUKygCISupphquuKJEpKb
         hF/8hFxJXLlnMjhArXa/UDG2RjzLTj7rMY1ZycVOSmTcsP0CY3ovJXGF/8QX636vPb9L
         xGLMgd9+kNavQpuaIYztDLGzkOx219pQMDSsTmSG/KEEgYWADo+wViWJBRC6Vtn5b5gZ
         3l4Scpar3iurXxmdkIWP7yEGFPofJxqwtk6CM2A1pmVSnWXjV3YFD7ML1IKSFmZnUSIf
         n8OUUp98GCDVZMNJ++hUw+UR4bdMIdA/alY56z3Pzw6HGBu6v0qrqT544cC1Mljuqh/5
         miwA==
X-Gm-Message-State: AOAM530JN6A7eRXG51RCctU1Ff2u7vx6YAScikLzVqHhNT8CbaN3pTX9
        zkXgKLbcYnSnd/0BAAlmmvw=
X-Google-Smtp-Source: ABdhPJyy0+rFQlC043A9UaMdqDUog7x/CRHy145i3BGIVzXgEvgNjiZkQNQ8zXg0LE5IcEHXshRDoQ==
X-Received: by 2002:a17:90b:350b:: with SMTP id ls11mr39468376pjb.227.1636753620054;
        Fri, 12 Nov 2021 13:47:00 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id cv1sm11563340pjb.48.2021.11.12.13.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:46:59 -0800 (PST)
Date:   Sat, 13 Nov 2021 03:16:56 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf] libbpf: Perform map fd cleanup for gen_loader in
 case of error
Message-ID: <20211112214656.dvcm2cikjxq4r6ta@apollo.localdomain>
References: <20211112202421.720179-1-memxor@gmail.com>
 <20211112213411.m3uxisnzkzkyf2os@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112213411.m3uxisnzkzkyf2os@ast-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 13, 2021 at 03:04:11AM IST, Alexei Starovoitov wrote:
> On Sat, Nov 13, 2021 at 01:54:21AM +0530, Kumar Kartikeya Dwivedi wrote:
> >
> > diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> > index 7b73f97b1fa1..558479c13c77 100644
> > --- a/tools/lib/bpf/gen_loader.c
> > +++ b/tools/lib/bpf/gen_loader.c
> > @@ -18,7 +18,7 @@
> >  #define MAX_USED_MAPS	64
> >  #define MAX_USED_PROGS	32
> >  #define MAX_KFUNC_DESCS 256
> > -#define MAX_FD_ARRAY_SZ (MAX_USED_PROGS + MAX_KFUNC_DESCS)
> > +#define MAX_FD_ARRAY_SZ (MAX_USED_MAPS + MAX_KFUNC_DESCS)
>
> Lol. Not sure how I missed it during code review :)
>
> >  void bpf_gen__init(struct bpf_gen *gen, int log_level)
> >  {
> >  	size_t stack_sz = sizeof(struct loader_stack);
> > @@ -120,8 +146,12 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level)
> >
> >  	/* jump over cleanup code */
> >  	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0,
> > -			      /* size of cleanup code below */
> > -			      (stack_sz / 4) * 3 + 2));
> > +			      /* size of cleanup code below (including map fd cleanup) */
> > +			      (stack_sz / 4) * 3 + 2 + (MAX_USED_MAPS *
> > +			      /* 6 insns for emit_sys_close_blob,
> > +			       * 6 insns for debug_regs in emit_sys_close_blob
> > +			       */
> > +			      (6 + (gen->log_level ? 6 : 0)))));
> >
> >  	/* remember the label where all error branches will jump to */
> >  	gen->cleanup_label = gen->insn_cur - gen->insn_start;
> > @@ -131,37 +161,19 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level)
> >  		emit(gen, BPF_JMP_IMM(BPF_JSLE, BPF_REG_1, 0, 1));
> >  		emit(gen, BPF_EMIT_CALL(BPF_FUNC_sys_close));
> >  	}
> > +	gen->fd_array = add_data(gen, NULL, MAX_FD_ARRAY_SZ * sizeof(int));
>
> could you move this line to be the first thing in bpf_gen__init() ?
> Otherwise it looks like that fd_array is only used in cleanup part while
> it's actually needed everywhere.
>

Ack. Also thinking of not reordering add_data as that pollutes git blame, but
just adding a declaration before use.

> > +	for (i = 0; i < MAX_USED_MAPS; i++)
> > +		emit_sys_close_blob(gen, blob_fd_array_off(gen, i));
>
> I confess that commit 30f51aedabda ("libbpf: Cleanup temp FDs when intermediate sys_bpf fails.")
> wasn't great in terms of redundant code gen for closing all 32 + 64 FDs.
> But can we make it better while we're at it?
> Most bpf files don't have 32 progs and 64 maps while gen_loader emits
> (32 + 64) * 6 = 576 instructions (without debug).
> While debugging/developing gen_loader this large cleanup code is just noise.
>

Yeah, I've been thinking about this for a while, there's also lots of similar
code gen in e.g. test_ksyms_module.o for the relocations. It might make sense to
move to subprog approach and emit a BPF_CALL, but that's a separate issue. I can
look into that too if it sounds good (but maybe you already tried this and ran
into issues).

> I tested the following:
>
> diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
> index 75ca9fb857b2..cc486a77db65 100644
> --- a/tools/lib/bpf/bpf_gen_internal.h
> +++ b/tools/lib/bpf/bpf_gen_internal.h
> @@ -47,8 +47,8 @@ struct bpf_gen {
>         int nr_fd_array;
>  };
>
> -void bpf_gen__init(struct bpf_gen *gen, int log_level);
> -int bpf_gen__finish(struct bpf_gen *gen);
> +void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps);
> +int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps);
>  void bpf_gen__free(struct bpf_gen *gen);
>  void bpf_gen__load_btf(struct bpf_gen *gen, const void *raw_data, __u32 raw_size);
>  void bpf_gen__map_create(struct bpf_gen *gen, struct bpf_create_map_params *map_attr, int map_idx);
> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 7b73f97b1fa1..f7b78478a9d3 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -102,7 +102,7 @@ static void emit2(struct bpf_gen *gen, struct bpf_insn insn1, struct bpf_insn in
>         emit(gen, insn2);
>  }
>
> -void bpf_gen__init(struct bpf_gen *gen, int log_level)
> +void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps)
>  {
>         size_t stack_sz = sizeof(struct loader_stack);
>         int i;
> @@ -359,10 +359,15 @@ static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off)
>         __emit_sys_close(gen);
>  }
>
> -int bpf_gen__finish(struct bpf_gen *gen)
> +int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
>  {
>         int i;
>
> +       if (nr_progs != gen->nr_progs || nr_maps != gen->nr_maps) {
> +               pr_warn("progs/maps mismatch\n");
> +               gen->error = -EFAULT;
> +               return gen->error;
> +       }
>         emit_sys_close_stack(gen, stack_off(btf_fd));
>         for (i = 0; i < gen->nr_progs; i++)
>                 move_stack2ctx(gen,
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index de7e09a6b5ec..f6faa33c80fa 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7263,7 +7263,7 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
>         }
>
>         if (obj->gen_loader)
> -               bpf_gen__init(obj->gen_loader, attr->log_level);
> +               bpf_gen__init(obj->gen_loader, attr->log_level, obj->nr_programs, obj->nr_maps);
>
>         err = bpf_object__probe_loading(obj);
>         err = err ? : bpf_object__load_vmlinux_btf(obj, false);
> @@ -7282,7 +7282,7 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
>                 for (i = 0; i < obj->nr_maps; i++)
>                         obj->maps[i].fd = -1;
>                 if (!err)
> -                       err = bpf_gen__finish(obj->gen_loader);
> +                       err = bpf_gen__finish(obj->gen_loader, obj->nr_programs, obj->nr_maps);
>         }
>
>         /* clean up fd_array */
>
> and it seems to work.
>
> So cleanup code can close only nr_progs + nr_maps FDs.
> gen_loader prog will be much shorter and will be processed by the verifier faster.
> MAX_FD_ARRAY_SZ can stay fixed. Reducing data size is not worth it.
> wdyt?

Looks nice, I'll rework it like this.

--
Kartikeya
