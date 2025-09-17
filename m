Return-Path: <bpf+bounces-68604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96589B7EB01
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A313A8A5E
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 02:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F1A2DBF52;
	Wed, 17 Sep 2025 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM0/VJQl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B2E2192F2
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 02:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758075111; cv=none; b=Qf8nkE4QE0T6A84Lr1vvk4PpqFxxK24dxea8jfmsGAmxvXyUqAAFiJdWOpC3LlEtJeKC0wPDV9S65BEx3F9lvxpD3RTRack0Zh/NzMWVmk+OdAmVONXaLEnJOFdzMQuwogaCXI7JCeEQavQPvvL2JZoMtEQmjmuqLifngvOOa34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758075111; c=relaxed/simple;
	bh=v7diegK1gttsbnVe4jb92m58rBx78PEH2o4IzMKVYms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfISs1DiqRTCprMABMy1pd/DgZco45OjG0GVCa3ikkcKk0N4y5Gdjey/j68EUxOu41ZkVOE/zNEx/ian6KAnTxvBoe9nrzzS/el5YvT1aF+GQHHbhEJMP8B6GlMKytT5SM71sB8AjSYkEI3m1a54myQpBsCYR6t7oGeB0Xb/H70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hM0/VJQl; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-62f277546abso6962487a12.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 19:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758075107; x=1758679907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EN0HTfP0OYmpbYBbK2tkU5nZTtDPe3RLIuH36spebr0=;
        b=hM0/VJQle0hGxr9iucLtYmgNcfL4GUyA+znamBa6cSQesqxv0AA6eBx0gG0dJq5phy
         0YQ4pDDh0F46hCwfGjJ0OwRRjjzBIlwMqfwaxQR/LfI4XFlcUa3sZgDzsMqYaKxUQkBu
         ae8pyCezkcQHBfgN+OuT1cSAa932VZul/EGa1oIORinFlYBmBOcKptKc6v3+GfGbTCIx
         bRHlNB0O+3CZlzMQ0joEJVjywArH3qCW5AkAGILOFBqA1AFX3aKDZO7QhfDL2m4I36ET
         fY82y78N5l22Sos0iren3xOdCTpL0xDYz3+uP/8XxJr71CC1L4v0XTiNZWpA/8lRUhHs
         0+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758075107; x=1758679907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EN0HTfP0OYmpbYBbK2tkU5nZTtDPe3RLIuH36spebr0=;
        b=Yxl+G+PBk//EPWDfqq0iR4WpzLCPumAZvCgAPpcOT6mCnaZHx6zrI3QPNHBOatYIZC
         zMkLJw0POdfTx1hmKGZzhlwVt6WKBRwQ2hRWKJ7DV1QMGVxhob29ZxmxxTG5ScWP3I02
         86wA0N+bae6h80R7mm4S0Df2nCY87FlF9Aj2WhinzAMvEQRV+J14ygyevqSbsR+UOAzc
         78CGbZcUXk1GsP3xsVAqfdUjznLMvxwq0K3HpAHYiA27I06vU+q8ervWbTUsX1WaA3ET
         hSiQYvLwp3Efjw8R7fK/hh0NbaQeKRmW/gOrKAxl/FId5STbngEyTR+U1+y0Wd2UduQz
         w7TA==
X-Gm-Message-State: AOJu0YyVRqcULVby0DfaHuU+5xd7+Z90haC12+j/MrnXuSLxqYt9FxL9
	89izP3qNEODnWozlDsAfzfqs93GEr2psfVBbEfsPzwaLj1jWyHZBp3aHKkxZ0roMRiFWocumsKr
	G/Ugvf37I+KCHCDwsTHOQK+vAv7k4Wi0=
X-Gm-Gg: ASbGncuplP580mkb+zHtMx+zLhOsWjfj3ucLesKTKqlvrLvY3FqccodLyDAog+gKMIf
	JqYbhWCCCpWMuVoT4W6m2smOY7WZFI1yH/8WZkRoMI0GoV1X02u0x5SmGvEThXo3fjqWifmKEPJ
	CGEbQvsjVbeWkMAXkLBnaIgGMWKzeu/cDnsEvMNpbXwi60DM90P90KfALxStwG4k5r010EodIdO
	A5NyWYwtg==
X-Google-Smtp-Source: AGHT+IG++9d7CM4H05SdeCuqyp08q9cqXjys5JcTOpa9X2gEEtWRB5lMsRXHhyX7CMvVrOX8u9gtuxMoE8ygMNSZyLk=
X-Received: by 2002:a05:6402:268b:b0:62f:40c7:8543 with SMTP id
 4fb4d7f45d1cf-62f83a06a8dmr827750a12.6.1758075107038; Tue, 16 Sep 2025
 19:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907230415.289327-1-sidchintamaneni@gmail.com> <20250907230415.289327-2-sidchintamaneni@gmail.com>
In-Reply-To: <20250907230415.289327-2-sidchintamaneni@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 17 Sep 2025 04:11:10 +0200
X-Gm-Features: AS18NWCKX0YXvcBPxk4163RhdNK3_lpFZCeNgPCbuj4xnyj93Peapi1Ztlz6CGE
Message-ID: <CAP01T74Ag4UnME94mzEQSVEZRbh07gSm+CeoNUSXvEZ0xeFCgQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] bpf: Introduce new structs and struct fields for fast
 path termination
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, djwillia@vt.edu, 
	miloc@vt.edu, ericts@vt.edu, rahult@vt.edu, doniaghazy@vt.edu, 
	quanzhif@vt.edu, jinghao7@illinois.edu, egor@vt.edu, sairoop10@gmail.com, 
	rjsu26@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sept 2025 at 01:04, Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> Introduced the definition of struct bpf_term_aux_states
> required to support fast-path termination of BPF programs.
> Added the memory allocation and free logic for newly added
> term_states feild in struct bpf_prog.

typo: field

>
> Signed-off-by: Raj Sahu <rjsu26@gmail.com>
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---
>  include/linux/bpf.h | 75 +++++++++++++++++++++++++++++----------------
>  kernel/bpf/core.c   | 31 +++++++++++++++++++
>  2 files changed, 79 insertions(+), 27 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8f6e87f0f3a8..caaee33744fc 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1584,6 +1584,25 @@ struct bpf_stream_stage {
>         int len;
>  };
>
> +struct call_aux_states {
> +       int call_bpf_insn_idx;
> +       int jit_call_idx;
> +       u8 is_helper_kfunc;
> +       u8 is_bpf_loop;
> +       u8 is_bpf_loop_cb_inline;
> +};
> +
> +struct bpf_term_patch_call_sites {
> +       u32 call_sites_cnt;
> +       struct call_aux_states *call_states;
> +};
> +
> +struct bpf_term_aux_states {
> +       struct bpf_prog *prog;
> +       struct work_struct work;
> +       struct bpf_term_patch_call_sites *patch_call_sites;
> +};
> +
>  struct bpf_prog_aux {
>         atomic64_t refcnt;
>         u32 used_map_cnt;
> @@ -1618,6 +1637,7 @@ struct bpf_prog_aux {
>         bool tail_call_reachable;
>         bool xdp_has_frags;
>         bool exception_cb;
> +       bool is_bpf_loop_cb_non_inline;
>         bool exception_boundary;
>         bool is_extended; /* true if extended by freplace program */
>         bool jits_use_priv_stack;
> @@ -1696,33 +1716,34 @@ struct bpf_prog_aux {
>  };
>
>  struct bpf_prog {
> -       u16                     pages;          /* Number of allocated pages */
> -       u16                     jited:1,        /* Is our filter JIT'ed? */
> -                               jit_requested:1,/* archs need to JIT the prog */
> -                               gpl_compatible:1, /* Is filter GPL compatible? */
> -                               cb_access:1,    /* Is control block accessed? */
> -                               dst_needed:1,   /* Do we need dst entry? */
> -                               blinding_requested:1, /* needs constant blinding */
> -                               blinded:1,      /* Was blinded */
> -                               is_func:1,      /* program is a bpf function */
> -                               kprobe_override:1, /* Do we override a kprobe? */
> -                               has_callchain_buf:1, /* callchain buffer allocated? */
> -                               enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
> -                               call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
> -                               call_get_func_ip:1, /* Do we call get_func_ip() */
> -                               tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
> -                               sleepable:1;    /* BPF program is sleepable */
> -       enum bpf_prog_type      type;           /* Type of BPF program */
> -       enum bpf_attach_type    expected_attach_type; /* For some prog types */
> -       u32                     len;            /* Number of filter blocks */
> -       u32                     jited_len;      /* Size of jited insns in bytes */
> -       u8                      tag[BPF_TAG_SIZE];
> -       struct bpf_prog_stats __percpu *stats;
> -       int __percpu            *active;
> -       unsigned int            (*bpf_func)(const void *ctx,
> -                                           const struct bpf_insn *insn);
> -       struct bpf_prog_aux     *aux;           /* Auxiliary fields */
> -       struct sock_fprog_kern  *orig_prog;     /* Original BPF program */
> +       u16                             pages;          /* Number of allocated pages */
> +       u16                             jited:1,        /* Is our filter JIT'ed? */
> +                                       jit_requested:1,/* archs need to JIT the prog */
> +                                       gpl_compatible:1, /* Is filter GPL compatible? */
> +                                       cb_access:1,    /* Is control block accessed? */
> +                                       dst_needed:1,   /* Do we need dst entry? */
> +                                       blinding_requested:1, /* needs constant blinding */
> +                                       blinded:1,      /* Was blinded */
> +                                       is_func:1,      /* program is a bpf function */
> +                                       kprobe_override:1, /* Do we override a kprobe? */
> +                                       has_callchain_buf:1, /* callchain buffer allocated? */
> +                                       enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
> +                                       call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
> +                                       call_get_func_ip:1, /* Do we call get_func_ip() */
> +                                       tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
> +                                       sleepable:1;    /* BPF program is sleepable */
> +       enum bpf_prog_type              type;           /* Type of BPF program */
> +       enum bpf_attach_type            expected_attach_type; /* For some prog types */
> +       u32                             len;            /* Number of filter blocks */
> +       u32                             jited_len;      /* Size of jited insns in bytes */
> +       u8                              tag[BPF_TAG_SIZE];
> +       struct bpf_prog_stats __percpu  *stats;
> +       int __percpu                    *active;
> +       unsigned int                    (*bpf_func)(const void *ctx,
> +                                                   const struct bpf_insn *insn);
> +       struct bpf_prog_aux             *aux;           /* Auxiliary fields */
> +       struct sock_fprog_kern          *orig_prog;     /* Original BPF program */
> +       struct bpf_term_aux_states      *term_states;
>         /* Instructions for interpreter */

This hunk looks bad, please only include what you touched, and don't
reformat the rest.


>         union {
>                 DECLARE_FLEX_ARRAY(struct sock_filter, insns);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ef01cc644a96..740b5a3a6b55 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -100,6 +100,8 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
>         gfp_t gfp_flags = bpf_memcg_flags(GFP_KERNEL | __GFP_ZERO | gfp_extra_flags);
>         struct bpf_prog_aux *aux;
>         struct bpf_prog *fp;
> +       struct bpf_term_aux_states *term_states = NULL;
> +       struct bpf_term_patch_call_sites *patch_call_sites = NULL;
>
>         size = round_up(size, __PAGE_SIZE);
>         fp = __vmalloc(size, gfp_flags);
> @@ -118,11 +120,24 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
>                 return NULL;
>         }
>
> +       term_states = kzalloc(sizeof(*term_states), bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
> +       if (!term_states)
> +               goto free_alloc_percpu;
> +
> +       patch_call_sites = kzalloc(sizeof(*patch_call_sites), bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
> +       if (!patch_call_sites)
> +               goto free_bpf_term_states;
> +
>         fp->pages = size / PAGE_SIZE;
>         fp->aux = aux;
>         fp->aux->prog = fp;
>         fp->jit_requested = ebpf_jit_enabled();
>         fp->blinding_requested = bpf_jit_blinding_enabled(fp);
> +       fp->term_states = term_states;
> +       fp->term_states->patch_call_sites = patch_call_sites;
> +       fp->term_states->patch_call_sites->call_sites_cnt = 0;
> +       fp->term_states->prog = fp;
> +
>  #ifdef CONFIG_CGROUP_BPF
>         aux->cgroup_atype = CGROUP_BPF_ATTACH_TYPE_INVALID;
>  #endif
> @@ -140,6 +155,15 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
>  #endif
>
>         return fp;
> +
> +free_bpf_term_states:
> +       kfree(term_states);
> +free_alloc_percpu:
> +       free_percpu(fp->active);
> +       kfree(aux);
> +       vfree(fp);
> +
> +       return NULL;
>  }
>
>  struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
> @@ -266,6 +290,7 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
>                 memcpy(fp, fp_old, fp_old->pages * PAGE_SIZE);
>                 fp->pages = pages;
>                 fp->aux->prog = fp;
> +               fp->term_states->prog = fp;
>
>                 /* We keep fp->aux from fp_old around in the new
>                  * reallocated structure.
> @@ -273,6 +298,7 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
>                 fp_old->aux = NULL;
>                 fp_old->stats = NULL;
>                 fp_old->active = NULL;
> +               fp_old->term_states = NULL;
>                 __bpf_prog_free(fp_old);
>         }
>
> @@ -287,6 +313,11 @@ void __bpf_prog_free(struct bpf_prog *fp)
>                 kfree(fp->aux->poke_tab);
>                 kfree(fp->aux);
>         }
> +       if (fp->term_states) {
> +               if (fp->term_states->patch_call_sites)
> +                       kfree(fp->term_states->patch_call_sites);
> +               kfree(fp->term_states);
> +       }
>         free_percpu(fp->stats);
>         free_percpu(fp->active);
>         vfree(fp);
> --
> 2.43.0
>

