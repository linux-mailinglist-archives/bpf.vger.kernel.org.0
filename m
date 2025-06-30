Return-Path: <bpf+bounces-61823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F54AEDD76
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B220189555D
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 12:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB3128AB11;
	Mon, 30 Jun 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpQJuctV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888B928AB03
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287712; cv=none; b=VUJTSuXx6k2gtl83N5/9i5dVjTjJ58ZxNNG3sq0A2HHtEeCVouuzK1Lg8uC76HceqepxJ0qToMshYNMssAjzLMAF7hR1F/Q9aAUnysSMOLtDZ5CsVulD/FRviRuDyoDXMSBLyRfF8RL1nN4EeWBzdvbs3Cz0PnCxWnXcQL7zaEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287712; c=relaxed/simple;
	bh=vAtLNV0sLBEW9wHjkl3Wg5bTTHv1AOd+038rFirEzgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h10/iFzD7tXghtvR0TIWPnK0SKN7QUc5QJCeUmMs9bB236vpj7aRPh2SaHD2J6qW0CHOjaTyh/61UcMpUYDMUjf9zCzmN8sFsgDpjyGHPbBgKEVFBxkbmuSqEdD5wEr4feZnyI/9cuM9EFHkywhegJgBOVr5WNs2r6zI5Ouc70M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpQJuctV; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so7749905a12.3
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 05:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751287709; x=1751892509; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtKYPj4stbx1RdagGfB+R3nnNnE1sCJjBO5hVcerRjQ=;
        b=IpQJuctVyG+L0c59NgfRmdOx2Wo9Wdu8drQWVencXVWw0SvA/IHublrSh7gRBkjZC+
         nvOYgoLH0qnnNZW2HulEpdG5NfH4TncEj90LYFk4+iRm1EnaREJzc53c3qqaZqsUpqGc
         NAUbssmiCFh80hYG/SFlGzoWP7CGM3vVi9T7Dhf1lgkYmip7Q6OIyXR4BZ38bQzNvL7e
         MZQ83Z2A/8urHh2qTxlggnAgab8BJoVf/YxfZeWUlq6UyP9JF9OYI37FCDMBdVzqTU54
         z5kkY8ja8M0Pq+THW+YrbJ7rcDfbsHY7herGizAEXYBc3E6KvRPAKG6H7LiHDEMJad7v
         P+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751287709; x=1751892509;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtKYPj4stbx1RdagGfB+R3nnNnE1sCJjBO5hVcerRjQ=;
        b=J+keNRWX+Ln1JLf/wHQaGwAQ+Qn2MQXxTMYkFDq4Nt32bFiSM4wMC0XXG6KDlHWJzs
         cIqEwQe/k3V+noTZ4vp9EASChGEjheseYJHKe/Ir0x0y1UyCZrkARf/fCxsI1L3mlmGi
         cIJKpWbtPrwQX/jmcyZoWbzJ8AfefUlYnF4xrwK/b1KI6FHMDDu+LpDgM0Q72XezVHcy
         pM6f8GGP4yXYeWO1QmJDkmR/EQEv/tE3JfzSkDArn58KFSWtPx9GREp/v6+b5+FEaZWY
         wCO8VOmxxCzCgnjPGZdz6R5cX4D+nKsQ+Z3KeiPm0kpeLhZf2wHicn2v2kRYgyN+PtkG
         qkHQ==
X-Gm-Message-State: AOJu0YwUvk3sMn0gkk880oI4YG3Y2YslGMNpdzak20HumF9qkW8To/Sj
	kZv/0RCrKA+1EUTHp/C/AhtLmkc3MF1zNsyZ5y/W6MKsekB/ko2vNOhwsrpd2yamEc+OlLtjVTE
	IB6MdpvTN/AFDa1N47cg8AVWh0uTj6D8=
X-Gm-Gg: ASbGncszM5SLmxcKaHutNy4ZGuZwHbRQXhx3En9gF6I8Is6I4B7nF3ZQy8QxZbLV6Pn
	m0Vu3i2QsnTHjo7YChRhpDqszvWPpZIWfAxOQx5nSi7fhr0RIQNV6sjiy6K8ZpHyahIOHQREn0h
	fWD3q/n+9L85QRi0W+hpFnUiYxrKZ2JcXUT1RktJ2LV7TtLHcUCXO67V7GWGBm16gW2/l79SQuW
	CCe
X-Google-Smtp-Source: AGHT+IEZcmRgciBQrAJnryQjftDN2IDRm8XEkkh3seEzf+fvYmeAUztmblRMAsrYQk/i0QWDWX4Omrs3gdx0thr/SIw=
X-Received: by 2002:a17:907:9449:b0:ae3:5e70:32fb with SMTP id
 a640c23a62f3a-ae35e703768mr1138810566b.4.1751287708283; Mon, 30 Jun 2025
 05:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614064056.237005-1-sidchintamaneni@gmail.com> <20250614064056.237005-3-sidchintamaneni@gmail.com>
In-Reply-To: <20250614064056.237005-3-sidchintamaneni@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 30 Jun 2025 14:47:52 +0200
X-Gm-Features: Ac12FXzZeg86LaZx2avkuqSzOWmil6hkMS7TA29rPrRzZPRGeP8_jVQKcjK7kyU
Message-ID: <CAP01T74u=EJqDEyB-gEsmRGqMF=TRPY+cb_eUHNVY3hr3OWYvg@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 2/4] bpf: Generating a stubbed version of BPF
 program for termination
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, djwillia@vt.edu, 
	miloc@vt.edu, ericts@vt.edu, rahult@vt.edu, doniaghazy@vt.edu, 
	quanzhif@vt.edu, jinghao7@illinois.edu, egor@vt.edu, sairoop10@gmail.com, 
	Raj Sahu <rjsu26@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Jun 2025 at 08:41, Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> Introduces patch generation which generates patch for each BPF
> program, iterate through all helper calls, kfuncs and if the return
> type may return NULL then stub them with a dummy function.
>
> Additional to these helpers/kfuncs the current implementation also
> supports termination of bpf_loop (both inline and non-inline case)
>
> Signed-off-by: Raj Sahu <rjsu26@gmail.com>
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> ---
>  include/linux/bpf_verifier.h |   4 +
>  include/linux/filter.h       |   2 +
>  kernel/bpf/core.c            |  12 ++
>  kernel/bpf/syscall.c         |  19 +++
>  kernel/bpf/verifier.c        | 245 ++++++++++++++++++++++++++++++++++-
>  5 files changed, 276 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 7e459e839f8b..3b4f371684a9 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -844,6 +844,10 @@ struct bpf_verifier_env {
>         /* array of pointers to bpf_scc_info indexed by SCC id */
>         struct bpf_scc_info **scc_info;
>         u32 scc_cnt;
> +       struct {
> +               u32 call_sites_cnt;
> +               int *call_idx;
> +       } bpf_term_patch_call_sites;
>  };
>
>  static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index eca229752cbe..cd9f1c2727ec 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1119,6 +1119,8 @@ int sk_get_filter(struct sock *sk, sockptr_t optval, unsigned int len);
>  bool sk_filter_charge(struct sock *sk, struct sk_filter *fp);
>  void sk_filter_uncharge(struct sock *sk, struct sk_filter *fp);
>
> +int bpf_loop_term_callback(u64 reg_loop_cnt, u64 *reg_loop_ctx);
> +void *bpf_termination_null_func(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
>  u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
>  #define __bpf_call_base_args \
>         ((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 756ed575741e..2a02e9cafd5a 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1571,6 +1571,18 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *prog)
>  }
>  #endif /* CONFIG_BPF_JIT */
>
> +noinline void *bpf_termination_null_func(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5)
> +{
> +       return NULL;
> +}
> +EXPORT_SYMBOL_GPL(bpf_termination_null_func);
> +
> +noinline int bpf_loop_term_callback(u64 reg_loop_cnt, u64 *reg_loop_ctx)
> +{
> +       return 1;
> +}
> +EXPORT_SYMBOL_GPL(bpf_loop_term_callback);
> +
>  /* Base function for offset calculation. Needs to go into .text section,
>   * therefore keeping it non-static as well; will also be used by JITs
>   * anyway later on, so do not let the compiler omit it. This also needs
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 56500381c28a..cd8e7c47e3fe 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2757,6 +2757,16 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
>  /* last field in 'union bpf_attr' used by this command */
>  #define BPF_PROG_LOAD_LAST_FIELD fd_array_cnt
>
> +static int sanity_check_jit_len(struct bpf_prog *prog)
> +{
> +       struct bpf_prog *patch_prog = prog->term_states->patch_prog;
> +
> +       if (prog->jited_len != patch_prog->jited_len)
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
>  static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>  {
>         enum bpf_prog_type type = attr->prog_type;
> @@ -2921,6 +2931,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>
>         prog->orig_prog = NULL;
>         prog->jited = 0;
> +       prog->is_termination_prog = 0;
>
>         atomic64_set(&prog->aux->refcnt, 1);
>
> @@ -2977,6 +2988,14 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>         if (err < 0)
>                 goto free_used_maps;
>
> +       prog->term_states->patch_prog = bpf_prog_select_runtime(prog->term_states->patch_prog, &err);
> +       if (err < 0)
> +               goto free_used_maps;
> +
> +       err = sanity_check_jit_len(prog);
> +       if (err < 0)
> +               goto free_used_maps;
> +
>         err = bpf_prog_alloc_id(prog);
>         if (err)
>                 goto free_used_maps;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c378074516cf..6920a623dde4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21397,6 +21397,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>                         goto out_free;
>                 func[i]->is_func = 1;
>                 func[i]->sleepable = prog->sleepable;
> +               if (prog->is_termination_prog)
> +                       func[i]->is_termination_prog = 1;
>                 func[i]->aux->func_idx = i;
>                 /* Below members will be freed only at prog->aux */
>                 func[i]->aux->btf = prog->aux->btf;
> @@ -21514,8 +21516,10 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>                         goto out_free;
>         }
>
> -       for (i = 1; i < env->subprog_cnt; i++)
> -               bpf_prog_kallsyms_add(func[i]);
> +       if (!prog->is_termination_prog) {
> +               for (i = 1; i < env->subprog_cnt; i++)
> +                       bpf_prog_kallsyms_add(func[i]);
> +       }
>
>         /* Last step: make now unused interpreter insns from main
>          * prog consistent for later dump requests, so they can
> @@ -21693,15 +21697,21 @@ static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
>  }
>
>  static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> -                           struct bpf_insn *insn_buf, int insn_idx, int *cnt)
> +                           struct bpf_insn *insn_buf, int insn_idx, int *cnt, int *kfunc_btf_id)
>  {
>         const struct bpf_kfunc_desc *desc;
> +       struct bpf_kfunc_call_arg_meta meta;
> +       int err;
>
>         if (!insn->imm) {
>                 verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
>                 return -EINVAL;
>         }
>
> +       err = fetch_kfunc_meta(env, insn, &meta, NULL);
> +       if (err)
> +               return err;
> +
>         *cnt = 0;
>
>         /* insn->imm has the btf func_id. Replace it with an offset relative to
> @@ -21715,8 +21725,11 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>                 return -EFAULT;
>         }
>
> -       if (!bpf_jit_supports_far_kfunc_call())
> +       if (!bpf_jit_supports_far_kfunc_call()) {
> +               if (meta.kfunc_flags & KF_RET_NULL)
> +                       *kfunc_btf_id = insn->imm;
>                 insn->imm = BPF_CALL_IMM(desc->addr);
> +       }
>         if (insn->off)
>                 return 0;
>         if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
> @@ -21846,7 +21859,13 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>         struct bpf_subprog_info *subprogs = env->subprog_info;
>         u16 stack_depth = subprogs[cur_subprog].stack_depth;
>         u16 stack_depth_extra = 0;
> +       int call_sites_cnt = 0;
> +       int *call_idx;
> +       env->bpf_term_patch_call_sites.call_idx = NULL;
>
> +       call_idx = vmalloc(sizeof(*call_idx) * prog->len);
> +       if (!call_idx)
> +               return -ENOMEM;
>         if (env->seen_exception && !env->exception_callback_subprog) {
>                 struct bpf_insn patch[] = {
>                         env->prog->insnsi[insn_cnt - 1],
> @@ -22182,11 +22201,12 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>                 if (insn->src_reg == BPF_PSEUDO_CALL)
>                         goto next_insn;
>                 if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
> -                       ret = fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt);
> +                       int kfunc_btf_id = 0;
> +                       ret = fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt, &kfunc_btf_id);
>                         if (ret)
>                                 return ret;
>                         if (cnt == 0)
> -                               goto next_insn;
> +                               goto store_call_indices;
>
>                         new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>                         if (!new_prog)
> @@ -22195,6 +22215,12 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>                         delta    += cnt - 1;
>                         env->prog = prog = new_prog;
>                         insn      = new_prog->insnsi + i + delta;
> +
> +store_call_indices:
> +                       if (kfunc_btf_id != 0) {
> +                               call_idx[call_sites_cnt] = i + delta;
> +                               call_sites_cnt++;
> +                       }
>                         goto next_insn;
>                 }
>
> @@ -22673,6 +22699,10 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>                                 func_id_name(insn->imm), insn->imm);
>                         return -EFAULT;
>                 }
> +               if (fn->ret_type & PTR_MAYBE_NULL) {
> +                       call_idx[call_sites_cnt] = i + delta;
> +                       call_sites_cnt++;
> +               }
>                 insn->imm = fn->func - __bpf_call_base;
>  next_insn:
>                 if (subprogs[cur_subprog + 1].start == i + delta + 1) {
> @@ -22693,6 +22723,8 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>                 insn++;
>         }
>
> +       env->bpf_term_patch_call_sites.call_sites_cnt = call_sites_cnt;
> +       env->bpf_term_patch_call_sites.call_idx = call_idx;
>         env->prog->aux->stack_depth = subprogs[0].stack_depth;
>         for (i = 0; i < env->subprog_cnt; i++) {
>                 int delta = bpf_jit_supports_timed_may_goto() ? 2 : 1;
> @@ -22828,6 +22860,8 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
>         call_insn_offset = position + 12;
>         callback_offset = callback_start - call_insn_offset - 1;
>         new_prog->insnsi[call_insn_offset].imm = callback_offset;
> +       /* marking offset field to identify and patch the patch_prog*/
> +       new_prog->insnsi[call_insn_offset].off = 0x1;
>
>         return new_prog;
>  }
> @@ -24394,6 +24428,194 @@ static int compute_scc(struct bpf_verifier_env *env)
>         return err;
>  }
>
> +static int clone_patch_prog(struct bpf_verifier_env *env)
> +{
> +       gfp_t gfp_flags = bpf_memcg_flags(GFP_KERNEL | __GFP_ZERO | GFP_USER);
> +       unsigned int size, prog_name_len;
> +       struct bpf_prog *patch_prog, *prog = env->prog;
> +       struct bpf_prog_aux *aux;
> +
> +       size = prog->pages * PAGE_SIZE;
> +       patch_prog = __vmalloc(size, gfp_flags);
> +       if (!patch_prog)
> +               return -ENOMEM;
> +
> +       aux = kzalloc(sizeof(*aux), bpf_memcg_flags(GFP_KERNEL | GFP_USER));
> +       if (!aux) {
> +               vfree(patch_prog);
> +               return -ENOMEM;
> +       }
> +
> +       /*
> +        * Copying prog fields
> +        */
> +       patch_prog->pages = prog->pages;
> +       patch_prog->jited = 0;
> +       patch_prog->jit_requested = prog->jit_requested;
> +       patch_prog->gpl_compatible = prog->gpl_compatible;
> +       patch_prog->blinding_requested = prog->blinding_requested;
> +       patch_prog->is_termination_prog = 1;
> +       patch_prog->len = prog->len;
> +       patch_prog->type = prog->type;
> +       patch_prog->aux = aux;
> +
> +       /*
> +        * Copying prog aux fields
> +        */
> +       patch_prog->aux->used_map_cnt = prog->aux->used_map_cnt;
> +       patch_prog->aux->used_btf_cnt = prog->aux->used_btf_cnt;
> +       patch_prog->aux->max_ctx_offset = prog->aux->max_ctx_offset;
> +       patch_prog->aux->stack_depth = prog->aux->stack_depth;
> +       patch_prog->aux->func_cnt = prog->aux->func_cnt; /* will be populated by jit_subprogs */
> +       patch_prog->aux->real_func_cnt = prog->aux->real_func_cnt; /* will be populated by jit_subprogs */
> +       patch_prog->aux->func_idx = prog->aux->func_idx; /* will be populated by jit_subprogs */
> +       patch_prog->aux->attach_btf_id = prog->aux->attach_btf_id;
> +       patch_prog->aux->attach_st_ops_member_off = prog->aux->attach_st_ops_member_off;
> +       patch_prog->aux->ctx_arg_info_size = prog->aux->ctx_arg_info_size;
> +       patch_prog->aux->max_rdonly_access = prog->aux->max_rdonly_access;
> +       patch_prog->aux->max_rdwr_access = prog->aux->max_rdwr_access;
> +       patch_prog->aux->verifier_zext = prog->aux->verifier_zext;
> +       patch_prog->aux->dev_bound = prog->aux->dev_bound;
> +       patch_prog->aux->offload_requested = prog->aux->offload_requested;
> +       patch_prog->aux->attach_btf_trace = prog->aux->attach_btf_trace;
> +       patch_prog->aux->attach_tracing_prog = prog->aux->attach_tracing_prog;
> +       patch_prog->aux->func_proto_unreliable = prog->aux->func_proto_unreliable;
> +       patch_prog->aux->tail_call_reachable = prog->aux->tail_call_reachable;
> +       patch_prog->aux->xdp_has_frags = prog->aux->xdp_has_frags;
> +       patch_prog->aux->exception_cb = prog->aux->exception_cb;
> +       patch_prog->aux->exception_boundary = prog->aux->exception_boundary;
> +       patch_prog->aux->is_extended = prog->aux->is_extended;
> +       patch_prog->aux->jits_use_priv_stack = prog->aux->jits_use_priv_stack;
> +       patch_prog->aux->priv_stack_requested = prog->aux->priv_stack_requested;
> +       patch_prog->aux->changes_pkt_data = prog->aux->changes_pkt_data;
> +       patch_prog->aux->might_sleep = prog->aux->might_sleep;
> +       patch_prog->aux->prog_array_member_cnt = prog->aux->prog_array_member_cnt;
> +       patch_prog->aux->size_poke_tab = prog->aux->size_poke_tab;
> +       patch_prog->aux->cgroup_atype = prog->aux->cgroup_atype;
> +       patch_prog->aux->linfo = prog->aux->linfo;
> +       patch_prog->aux->func_info_cnt = prog->aux->func_info_cnt;
> +       patch_prog->aux->nr_linfo = prog->aux->nr_linfo;
> +       patch_prog->aux->linfo_idx = prog->aux->linfo_idx;
> +       patch_prog->aux->num_exentries = prog->aux->num_exentries;
> +
> +       patch_prog->aux->poke_tab = kmalloc_array(patch_prog->aux->size_poke_tab,
> +                                       sizeof(struct bpf_jit_poke_descriptor), GFP_KERNEL);
> +       if (!patch_prog->aux->poke_tab) {
> +               kfree(patch_prog->aux);
> +               vfree(patch_prog);
> +               return -ENOMEM;
> +       }
> +
> +       for (int i = 0; i < patch_prog->aux->size_poke_tab; i++) {
> +               memcpy(&patch_prog->aux->poke_tab[i], &prog->aux->poke_tab[i],
> +                               sizeof(struct bpf_jit_poke_descriptor));
> +       }
> +
> +       memcpy(patch_prog->insnsi, prog->insnsi, bpf_prog_insn_size(prog));
> +
> +       char *patch_prefix = "patch_";
> +       prog_name_len = strlen(prog->aux->name);
> +       strncpy(patch_prog->aux->name, patch_prefix, strlen(patch_prefix));
> +
> +       if (prog_name_len + strlen(patch_prefix) + 1 > BPF_OBJ_NAME_LEN) {
> +               prog_name_len = BPF_OBJ_NAME_LEN - strlen(patch_prefix) - 1;
> +       }
> +       strncat(patch_prog->aux->name, prog->aux->name, prog_name_len);
> +
> +       prog->term_states->patch_prog = patch_prog;
> +
> +       return 0;
> +}

The parts above this function makes sense, but I don't understand why
we need programs to be cloned separately anymore.
Instead, can't we simply have a table of patch targets for the original program?
They'd need adjustment after jit to reflect the exact correct offset,
but that shouldn't be difficult to compute.
IIUC you're comparing instructions in the patched program and original
program to find out if you need to patch out the original one.
That seems like a very expensive way of tracking which call targets
need to be modified.

> +
> +[...]

