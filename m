Return-Path: <bpf+bounces-52953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A39A4A7CC
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 03:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17E817193D
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 02:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F55288A2;
	Sat,  1 Mar 2025 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaE6ySGJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF02422066
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 02:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740794520; cv=none; b=i1qlHtNl6Va8oVXX0UEfs8131PqAS85a1vAXBWa9bcKkBcw1XAoieJlyrdX3vHxOPMBL+XkL1W4FjU/18Pb/ja6l8KW/diE6NnO44eeijpqVhH/uPWhWn51wBNEkULVS4r+ij3wxjX70IMVKcZinZt3WfyYZ9q0TYV8nFg6hPpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740794520; c=relaxed/simple;
	bh=HJv6rhrUxnILjPMs/bjXQmQK97k2vGyhZBKtc/Db3ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBHDx6vOW0RXDyZjixQEMoW2IWGt531IJiJorcNffoUCzLStDgBcDcBrkuDKDaqmrRRWszzeTubfKnb3Up3UJu8BL4S/fQ51mwmCsK7MVLsWvCC/OgSWu+i5Bfv0ZldTqi6ICg6iuAf6W2sIPEpL/8tHkGLUrWtATK6w/RoQg3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaE6ySGJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390e3b3d432so1904832f8f.2
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 18:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740794516; x=1741399316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2RzFUoGsBifF8F5sZVNYl/ksMkb9SK2BrMSaN/3Clg=;
        b=JaE6ySGJBv4RHWcP1w2CXjV12barFND2E6q99mwkFIWCD38bGTfHW8rRpO7Y0OQ7aG
         9tqQPnAimSR+zus3BIH7X2y+CEHplEsuDFSlYPNO0lAvudtBg4LIF1y9j0bsjDV4L3g9
         /Dz2PnMumRi4BY/ZfJ9E5tj6jtPUSxDBEs0NeifuRNHuJoG0GXWqX482/YwPTdeFZYaQ
         0a7YsBlm5J4bS5Q2ERAwpnE66OMGA2EwJnE5+Lqx2loBuUJ7jFosC0hJvE+uMYy09PGb
         ctxTnQl+1erDYBAeB6g2xvD6KECwjQs/Q+mhWKu1q5fLpJZoIQI1JtWSilbP00yolIdn
         yqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740794516; x=1741399316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2RzFUoGsBifF8F5sZVNYl/ksMkb9SK2BrMSaN/3Clg=;
        b=Bes1LOWU1x84rsMiLemCeuffmEG4Ntt0L76iaZNuPpAYDno3bYpsVn9iQNkvNnt+eR
         kLH7Lb6g4hRVsLrp03MAKjUhAwtvBJ1LsKIdssN//WHdOkOZFNj9ng55vOmlK0PYOGSv
         kjSrOf0CxqQIEIRxBWOjbAehkpe3wuvjA6ZsAlYn2WCWJ+2fFtPxsAwcx1rAz9F8ZMMW
         HIoBemsNO4PkYOdzwQYf5mBo6jnrDJKP7x1aFBLuarXPnmayVnjveclnzwETObxYOrvO
         SzkrVesn2J8nEHnWkEWnRlYYloTs5CKXAk9JXBirAosNzgPqvFl/NChvMc8E3ordRUnO
         Lz6g==
X-Gm-Message-State: AOJu0YwXsUz0y/One6clHG5iCYW4DVaeobLsfOaM0XEzdjXWUTwd8YkJ
	dgd/bFW5D8HCwX++A9wAfFYndyEDQsrORO5FiYDQ+ATSYOuai3N4/YTYLm7oG1U/sLZf/o7raCW
	bZ+cmMJUraWnz6y7xmeb3D6jOdOA=
X-Gm-Gg: ASbGncv7rXiVD1QDqSR3+KBdYOpYkf+fPRdEEr6dRwcurTJRvnDcvyD8YXaHl5CF+cs
	HM3XnqWe2iv6FZwT8NppFT6hmccArF+B47ZhDJvWE0MPwArA8+R9pLULK1Ve3J+DZ+FQ88T/D2Q
	uea/syq1Bc5YtJGAQmCIb394HuCk5T/YuXvI6fRxtOc0KUA8Is4gP3LWF//Q==
X-Google-Smtp-Source: AGHT+IGzOqGVoDrQdOaYtIXgdhYp3ladlKd/y046fopnoisT98EOCZswLiXD++jKhpduPpNAfQW7CQdf333h1w0gpWs=
X-Received: by 2002:a5d:6486:0:b0:38f:210b:693f with SMTP id
 ffacd0b85a97d-390eca529c1mr4681779f8f.52.1740794515518; Fri, 28 Feb 2025
 18:01:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228060032.1425870-1-eddyz87@gmail.com> <20250228060032.1425870-2-eddyz87@gmail.com>
In-Reply-To: <20250228060032.1425870-2-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 28 Feb 2025 18:01:44 -0800
X-Gm-Features: AQ5f1JriQCVBthScUm6SX2emb8BIr_oVmbVtJU5sMRpxGSrD_lGc_JHKrpkjsz0
Message-ID: <CAADnVQJRFCn39RMPRydcopX-UY0h_s3AvCMhwcfc7YGQt-JcoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: simple DFA-based live registers analysis
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 10:01=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> Compute may-live registers before each instruction in the program.
> A register is live before instruction I if it is read by I or by some
> instruction S that follows I, provided it is not overwritten between I
> and S.
>
> This information will be used in the next patch as a hint in
> func_states_equal().
>
> Use a simple algorithm described in [1] to compute this information:
> - define the following:
>   - I.use : the set of all registers read by instruction I;
>   - I.def : the set of all registers written by instruction I;
>   - I.in  : the set of all registers that may be alive before I
>             execution;
>   - I.out : the set of all registers that may be alive after I
>             execution;
>   - I.successors : the set of instructions S that might immediately
>                    follow I for some program execution;
> - associate separate empty sets 'I.in' and 'I.out' with each instruction;
> - visit each instruction in a postorder and update the corresponding
>   'I.in' and 'I.out' sets as follows:
>
>       I.out =3D U [S.in for S in I.successors]
>       I.in  =3D (I.out / I.def) U I.use
>
>   (where U stands for set union, / stands for set difference)
> - repeat the computation while I.{in,out} changes for any instruction.
>
> On implementation side keep things as simple, as possible:
> - check_cfg() already marks instructions EXPLORED in post-order,
>   modify it to save the index of each EXPLORED instruction in a vector;
> - represent I.{in,out,use,def} as bitmasks;
> - don't split the program into basic blocks and don't maintain the
>   work queue, instead:
>   - perform fixed-point computation by visiting each instruction;
>   - maintain a simple 'changed' flag to track if I.{in,out} changes
>     for any instruction;
>
>   Measurements show that even this simplistic implementation does not
>   add measurable verification time overhead (at least for selftests).
>
> Note on check_cfg() ex_insn_beg/ex_done change:
> To avoid out of bounds access to env->cfg.insn_postorder array,
> it must be guaranteed that an instruction transitions to the EXPLORED
> state only once. Previously, this was not the case for incorrect
> programs with direct calls to exception callbacks.
>
> The 'align' selftest needs adjustment to skip the computed
> instruction/live registers printout. Otherwise, it matches lines from
> this printout instead of verification log.
>
> [1] https://en.wikipedia.org/wiki/Live-variable_analysis
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf_verifier.h                  |   6 +
>  kernel/bpf/verifier.c                         | 376 ++++++++++++++++--
>  .../testing/selftests/bpf/prog_tests/align.c  |  11 +-
>  3 files changed, 369 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index bbd013c38ff9..8c23958bc471 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -591,6 +591,8 @@ struct bpf_insn_aux_data {
>          * accepts callback function as a parameter.
>          */
>         bool calls_callback;
> +       /* registers alive before this instruction. */
> +       u16 live_regs_before;
>  };
>
>  #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF prog=
ram */
> @@ -747,7 +749,11 @@ struct bpf_verifier_env {
>         struct {
>                 int *insn_state;
>                 int *insn_stack;
> +               /* vector of instruction indexes sorted in post-order */
> +               int *insn_postorder;
>                 int cur_stack;
> +               /* current position in the insn_postorder vector */
> +               int cur_postorder;
>         } cfg;
>         struct backtrack_state bt;
>         struct bpf_insn_hist_entry *insn_hist;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index dcd0da4e62fc..4ac7dc58d9b1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3353,6 +3353,15 @@ static int add_subprog_and_kfunc(struct bpf_verifi=
er_env *env)
>         return 0;
>  }
>
> +static int jmp_offset(struct bpf_insn *insn)
> +{
> +       u8 code =3D insn->code;
> +
> +       if (code =3D=3D (BPF_JMP32 | BPF_JA))
> +               return insn->imm;
> +       return insn->off;
> +}
> +
>  static int check_subprogs(struct bpf_verifier_env *env)
>  {
>         int i, subprog_start, subprog_end, off, cur_subprog =3D 0;
> @@ -3379,10 +3388,7 @@ static int check_subprogs(struct bpf_verifier_env =
*env)
>                         goto next;
>                 if (BPF_OP(code) =3D=3D BPF_EXIT || BPF_OP(code) =3D=3D B=
PF_CALL)
>                         goto next;
> -               if (code =3D=3D (BPF_JMP32 | BPF_JA))
> -                       off =3D i + insn[i].imm + 1;
> -               else
> -                       off =3D i + insn[i].off + 1;
> +               off =3D i + jmp_offset(&insn[i]) + 1;

Nice cleanup, but pls split it into pre-patch,
so that main liveness logic is in the main patch.

>                 if (off < subprog_start || off >=3D subprog_end) {
>                         verbose(env, "jump out of range from insn %d to %=
d\n", i, off);
>                         return -EINVAL;
> @@ -3912,6 +3918,17 @@ static const char *disasm_kfunc_name(void *data, c=
onst struct bpf_insn *insn)
>         return btf_name_by_offset(desc_btf, func->name_off);
>  }
>
> +static void verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *=
insn)
> +{
> +       const struct bpf_insn_cbs cbs =3D {
> +               .cb_call        =3D disasm_kfunc_name,
> +               .cb_print       =3D verbose,
> +               .private_data   =3D env,
> +       };
> +
> +       print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
> +}
> +
>  static inline void bt_init(struct backtrack_state *bt, u32 frame)
>  {
>         bt->frame =3D frame;
> @@ -4112,11 +4129,6 @@ static bool calls_callback(struct bpf_verifier_env=
 *env, int insn_idx);
>  static int backtrack_insn(struct bpf_verifier_env *env, int idx, int sub=
seq_idx,
>                           struct bpf_insn_hist_entry *hist, struct backtr=
ack_state *bt)
>  {
> -       const struct bpf_insn_cbs cbs =3D {
> -               .cb_call        =3D disasm_kfunc_name,
> -               .cb_print       =3D verbose,
> -               .private_data   =3D env,
> -       };
>         struct bpf_insn *insn =3D env->prog->insnsi + idx;
>         u8 class =3D BPF_CLASS(insn->code);
>         u8 opcode =3D BPF_OP(insn->code);
> @@ -4134,7 +4146,7 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
>                 fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stac=
k_mask(bt));
>                 verbose(env, "stack=3D%s before ", env->tmp_str_buf);
>                 verbose(env, "%d: ", idx);
> -               print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
> +               verbose_insn(env, insn);

Same. Nice cleanup, but move it into pre-patch with all cleanups.
No need for separate patches per cleanup.
Just all cleanups into one will do.

>         }
>
>         /* If there is a history record that some registers gained range =
at this insn,
> @@ -11011,6 +11023,9 @@ static int get_helper_proto(struct bpf_verifier_e=
nv *env, int func_id,
>         return *ptr ? 0 : -EINVAL;
>  }
>
> +/* Bitmask with 1s for all caller saved registers */
> +#define ALL_CALLER_SAVED_REGS ((1u << CALLER_SAVED_REGS) - 1)
> +
>  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_in=
sn *insn,
>                              int *insn_idx_p)
>  {
> @@ -17246,9 +17261,8 @@ static int visit_insn(int t, struct bpf_verifier_=
env *env)
>  static int check_cfg(struct bpf_verifier_env *env)
>  {
>         int insn_cnt =3D env->prog->len;
> -       int *insn_stack, *insn_state;
> +       int *insn_stack, *insn_state, *insn_postorder;
>         int ex_insn_beg, i, ret =3D 0;
> -       bool ex_done =3D false;
>
>         insn_state =3D env->cfg.insn_state =3D kvcalloc(insn_cnt, sizeof(=
int), GFP_KERNEL);
>         if (!insn_state)
> @@ -17260,6 +17274,17 @@ static int check_cfg(struct bpf_verifier_env *en=
v)
>                 return -ENOMEM;
>         }
>
> +       insn_postorder =3D env->cfg.insn_postorder =3D kvcalloc(insn_cnt,=
 sizeof(int), GFP_KERNEL);
> +       if (!insn_postorder) {
> +               kvfree(insn_state);
> +               kvfree(insn_stack);
> +               return -ENOMEM;
> +       }
> +
> +       ex_insn_beg =3D env->exception_callback_subprog
> +                     ? env->subprog_info[env->exception_callback_subprog=
].start
> +                     : 0;
> +
>         insn_state[0] =3D DISCOVERED; /* mark 1st insn as discovered */
>         insn_stack[0] =3D 0; /* 0 is the first instruction */
>         env->cfg.cur_stack =3D 1;
> @@ -17273,6 +17298,7 @@ static int check_cfg(struct bpf_verifier_env *env=
)
>                 case DONE_EXPLORING:
>                         insn_state[t] =3D EXPLORED;
>                         env->cfg.cur_stack--;
> +                       insn_postorder[env->cfg.cur_postorder++] =3D t;
>                         break;
>                 case KEEP_EXPLORING:
>                         break;
> @@ -17291,13 +17317,10 @@ static int check_cfg(struct bpf_verifier_env *e=
nv)
>                 goto err_free;
>         }
>
> -       if (env->exception_callback_subprog && !ex_done) {
> -               ex_insn_beg =3D env->subprog_info[env->exception_callback=
_subprog].start;
> -
> +       if (ex_insn_beg && insn_state[ex_insn_beg] !=3D EXPLORED) {
>                 insn_state[ex_insn_beg] =3D DISCOVERED;
>                 insn_stack[0] =3D ex_insn_beg;
>                 env->cfg.cur_stack =3D 1;
> -               ex_done =3D true;
>                 goto walk_cfg;
>         }
>
> @@ -19121,19 +19144,13 @@ static int do_check(struct bpf_verifier_env *en=
v)
>                 }
>
>                 if (env->log.level & BPF_LOG_LEVEL) {
> -                       const struct bpf_insn_cbs cbs =3D {
> -                               .cb_call        =3D disasm_kfunc_name,
> -                               .cb_print       =3D verbose,
> -                               .private_data   =3D env,
> -                       };
> -
>                         if (verifier_state_scratched(env))
>                                 print_insn_state(env, state, state->curfr=
ame);
>
>                         verbose_linfo(env, env->insn_idx, "; ");
>                         env->prev_log_pos =3D env->log.end_pos;
>                         verbose(env, "%d: ", env->insn_idx);
> -                       print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
> +                       verbose_insn(env, insn);
>                         env->prev_insn_print_pos =3D env->log.end_pos - e=
nv->prev_log_pos;
>                         env->prev_log_pos =3D env->log.end_pos;
>                 }
> @@ -23199,6 +23216,312 @@ static int process_fd_array(struct bpf_verifier=
_env *env, union bpf_attr *attr,
>         return 0;
>  }
>
> +static bool can_fallthrough(struct bpf_insn *insn)
> +{
> +       u8 class =3D BPF_CLASS(insn->code);
> +       u8 opcode =3D BPF_OP(insn->code);
> +
> +       if (class !=3D BPF_JMP && class !=3D BPF_JMP32)
> +               return true;
> +
> +       if (opcode =3D=3D BPF_EXIT || opcode =3D=3D BPF_JA)
> +               return false;
> +
> +       return true;
> +}
> +
> +static bool can_jump(struct bpf_insn *insn)
> +{
> +       u8 class =3D BPF_CLASS(insn->code);
> +       u8 opcode =3D BPF_OP(insn->code);
> +
> +       if (class !=3D BPF_JMP && class !=3D BPF_JMP32)
> +               return false;
> +
> +       switch (opcode) {
> +       case BPF_JA:
> +       case BPF_JEQ:
> +       case BPF_JNE:
> +       case BPF_JLT:
> +       case BPF_JLE:
> +       case BPF_JGT:
> +       case BPF_JGE:
> +       case BPF_JSGT:
> +       case BPF_JSGE:
> +       case BPF_JSLT:
> +       case BPF_JSLE:
> +       case BPF_JCOND:
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +static int insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
> +{
> +       struct bpf_insn *insn =3D &prog->insnsi[idx];
> +       int i =3D 0, insn_sz;
> +       u32 dst;
> +
> +       succ[0] =3D prog->len;
> +       succ[1] =3D prog->len;

Why initialize them? They won't be used anyway.

> +
> +       insn_sz =3D bpf_is_ldimm64(insn) ? 2 : 1;
> +       if (can_fallthrough(insn) && idx + 1 < prog->len)
> +               succ[i++] =3D idx + insn_sz;
> +
> +       if (can_jump(insn)) {
> +               dst =3D idx + jmp_offset(insn) + 1;
> +               if (i =3D=3D 0 || succ[0] !=3D dst)
> +                       succ[i++] =3D dst;
> +       }
> +
> +       return i;
> +}
> +
> +/* Each field is a register bitmask */
> +struct insn_live_regs {
> +       u16 use;        /* registers read by instruction */
> +       u16 def;        /* registers written by instruction */
> +       u16 in;         /* registers that may be alive before instruction=
 */
> +       u16 out;        /* registers that may be alive after instruction =
*/
> +};
> +
> +/* Compute *use and *def values for the call instruction */
> +static void compute_call_live_regs(struct bpf_verifier_env *env,
> +                                  struct bpf_insn *insn,
> +                                  u16 *use, u16 *def)
> +{
> +       struct bpf_kfunc_call_arg_meta meta;
> +       const struct bpf_func_proto *fn;
> +       int err, i, nargs;
> +
> +       *def =3D ALL_CALLER_SAVED_REGS;
> +       *use =3D *def & ~BIT(BPF_REG_0);
> +       if (bpf_helper_call(insn)) {
> +               err =3D get_helper_proto(env, insn->imm, &fn);
> +               if (err)
> +                       return;
> +               *use =3D 0;
> +               for (i =3D 1; i < CALLER_SAVED_REGS; i++) {
> +                       if (fn->arg_type[i - 1] =3D=3D ARG_DONTCARE)
> +                               break;
> +                       *use |=3D BIT(i);
> +               }
> +       } else if (bpf_pseudo_kfunc_call(insn)) {
> +               err =3D fetch_kfunc_meta(env, insn, &meta, NULL);
> +               if (err)
> +                       return;
> +               nargs =3D btf_type_vlen(meta.func_proto);
> +               *use =3D 0;
> +               for (i =3D 1; i <=3D nargs; i++)
> +                       *use |=3D BIT(i);
> +       }
> +}

The helper is very close to helper_fastcall_clobber_mask()
and kfunc_fastcall_clobber_mask(),
and the beginning of mark_fastcall_pattern_for_call().
Let's generalize the code and make it a pre-patch 2.
(separate from trivial cleanups).

In generic helper I'd standardize on 'use' word instead
of 'clobber_mask'.

The move of ALL_CALLER_SAVED_REGS can be there as well.

> +
> +/* Compute info->{use,def} fields for the instruction */
> +static void compute_insn_live_regs(struct bpf_verifier_env *env,
> +                                  struct bpf_insn *insn,
> +                                  struct insn_live_regs *info)
> +{
> +       u8 class =3D BPF_CLASS(insn->code);
> +       u8 code =3D BPF_OP(insn->code);
> +       u8 mode =3D BPF_MODE(insn->code);
> +       u16 src =3D BIT(insn->src_reg);
> +       u16 dst =3D BIT(insn->dst_reg);
> +       u16 r0  =3D BIT(0);
> +       u16 def =3D 0;
> +       u16 use =3D 0xffff;
> +
> +       switch (class) {
> +       case BPF_LD:
> +               switch (mode) {
> +               case BPF_IMM:
> +                       if (BPF_SIZE(insn->code) =3D=3D BPF_DW) {
> +                               def =3D dst;
> +                               use =3D 0;
> +                       }
> +                       break;
> +               case BPF_LD | BPF_ABS:
> +               case BPF_LD | BPF_IND:
> +                       /* stick with defaults */
> +                       break;
> +               }
> +               break;
> +       case BPF_LDX:
> +               switch (mode) {
> +               case BPF_MEM:
> +               case BPF_MEMSX:
> +                       def =3D dst;
> +                       use =3D src;
> +                       break;
> +               }
> +               break;
> +       case BPF_ST:
> +               switch (mode) {
> +               case BPF_MEM:
> +                       def =3D 0;
> +                       use =3D dst;
> +                       break;
> +               }
> +               break;
> +       case BPF_STX:
> +               switch (mode) {
> +               case BPF_MEM:
> +                       def =3D 0;
> +                       use =3D dst | src;
> +                       break;
> +               case BPF_ATOMIC:
> +                       use =3D dst | src;
> +                       if (insn->imm & BPF_FETCH) {
> +                               if (insn->imm =3D=3D BPF_CMPXCHG)
> +                                       def =3D r0;
> +                               else
> +                                       def =3D src;
> +                       } else {
> +                               def =3D 0;
> +                       }
> +                       break;
> +               }
> +               break;
> +       case BPF_ALU:
> +       case BPF_ALU64:
> +               switch (code) {
> +               case BPF_END:
> +                       use =3D dst;
> +                       def =3D dst;
> +                       break;
> +               case BPF_MOV:
> +                       def =3D dst;
> +                       if (BPF_SRC(insn->code) =3D=3D BPF_K)
> +                               use =3D 0;
> +                       else
> +                               use =3D src;
> +                       break;
> +               default:
> +                       def =3D dst;
> +                       if (BPF_SRC(insn->code) =3D=3D BPF_K)
> +                               use =3D dst;
> +                       else
> +                               use =3D dst | src;
> +               }
> +               break;
> +       case BPF_JMP:
> +       case BPF_JMP32:
> +               switch (code) {
> +               case BPF_JA:
> +                       def =3D 0;
> +                       use =3D 0;
> +                       break;
> +               case BPF_EXIT:
> +                       def =3D 0;
> +                       use =3D r0;
> +                       break;
> +               case BPF_CALL:
> +                       compute_call_live_regs(env, insn, &use, &def);
> +                       break;
> +               default:
> +                       def =3D 0;
> +                       if (BPF_SRC(insn->code) =3D=3D BPF_K)
> +                               use =3D dst;
> +                       else
> +                               use =3D dst | src;
> +               }
> +               break;
> +       }
> +
> +       info->def =3D def;
> +       info->use =3D use;
> +}
> +
> +/* Compute may-live registers before each instruction in the program.
> + * A register is live before instruction I if it is read by I or by some
> + * instruction S that follows I, provided it is not overwritten between =
I
> + * and S.
> + *
> + * Store result in env->insn_aux_data[i].live_regs.
> + */
> +static int compute_live_registers(struct bpf_verifier_env *env)
> +{
> +       struct bpf_insn_aux_data *insn_aux =3D env->insn_aux_data;
> +       struct bpf_insn *insns =3D env->prog->insnsi;
> +       struct insn_live_regs *state;
> +       int insn_cnt =3D env->prog->len;
> +       int err =3D 0, i, j;
> +       bool changed;
> +
> +       /* Use simple algorithm desribed in:

described

> +        * https://en.wikipedia.org/wiki/Live-variable_analysis

instead of the link let's copy paste definition of
I.use|def from commit log into this comment.

> +        *
> +        * - visit each instruction in a postorder and update
> +        *   state[i].in, state[i].out as follows:
> +        *
> +        *       state[i].out =3D U [state[s].in for S in insn_successors=
(i)]
> +        *       state[i].in  =3D (state[i].out / state[i].def) U state[i=
].use
> +        *
> +        *   (where U stands for set union, / stands for set difference)
> +        * - repeat the computation while {in,out} fields change for
> +        *   any instruction.
> +        */
> +       state =3D kvcalloc(insn_cnt, sizeof(*state), GFP_KERNEL);
> +       if (!state) {
> +               err =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       for (i =3D 0; i < insn_cnt; ++i)
> +               compute_insn_live_regs(env, &insns[i], &state[i]);
> +
> +       changed =3D true;
> +       while (changed) {
> +               changed =3D false;
> +               for (i =3D 0; i < env->cfg.cur_postorder; ++i) {
> +                       int insn_idx =3D env->cfg.insn_postorder[i];
> +                       struct insn_live_regs *live =3D &state[insn_idx];
> +                       int succ_num;
> +                       u32 succ[2];
> +                       u16 new_out =3D 0;
> +                       u16 new_in =3D 0;
> +
> +                       succ_num =3D insn_successors(env->prog, insn_idx,=
 succ);
> +                       for (int s =3D 0; s < succ_num; ++s)
> +                               new_out |=3D state[succ[s]].in;
> +                       new_in =3D (new_out & ~live->def) | live->use;
> +                       if (new_out !=3D live->out || new_in !=3D live->i=
n) {
> +                               live->in =3D new_in;
> +                               live->out =3D new_out;
> +                               changed =3D true;
> +                       }
> +               }
> +       }
> +
> +       for (i =3D 0; i < insn_cnt; ++i)
> +               insn_aux[i].live_regs_before =3D state[i].in;
> +
> +       if (env->log.level & BPF_LOG_LEVEL2) {
> +               verbose(env, "Live regs before insn:\n");
> +               for (i =3D 0; i < insn_cnt; ++i) {
> +                       verbose(env, "%3d: ", i);
> +                       for (j =3D BPF_REG_0; j < BPF_REG_10; ++j)
> +                               if (insn_aux[i].live_regs_before & BIT(j)=
)
> +                                       verbose(env, "%d", j);
> +                               else
> +                                       verbose(env, ".");

I wonder whether we would need to see liveness at log_level=3D2
during the normal verifier output instead of once in a beginning.
I guess it's fine doing it once like you did.

> +                       verbose(env, " ");
> +                       verbose_insn(env, &insns[i]);
> +                       if (bpf_is_ldimm64(&insns[i]))
> +                               i++;
> +               }
> +       }
> +
> +out:
> +       kvfree(state);
> +       kvfree(env->cfg.insn_postorder);
> +       env->cfg.insn_postorder =3D NULL;
> +       env->cfg.cur_postorder =3D 0;
> +       return err;
> +}
> +
>  int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uat=
tr, __u32 uattr_size)
>  {
>         u64 start_time =3D ktime_get_ns();
> @@ -23320,6 +23643,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
>         if (ret)
>                 goto skip_full_check;
>
> +       if (is_priv) {
> +               ret =3D compute_live_registers(env);
> +               if (ret < 0)
> +                       goto skip_full_check;
> +       }
> +
>         ret =3D mark_fastcall_patterns(env);
>         if (ret < 0)
>                 goto skip_full_check;
> @@ -23458,6 +23787,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr, __u3
>         vfree(env->insn_aux_data);
>         kvfree(env->insn_hist);
>  err_free_env:
> +       kvfree(env->cfg.insn_postorder);
>         kvfree(env);
>         return ret;
>  }
> diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testi=
ng/selftests/bpf/prog_tests/align.c
> index 4ebd0da898f5..1d53a8561ee2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/align.c
> +++ b/tools/testing/selftests/bpf/prog_tests/align.c
> @@ -610,9 +610,11 @@ static int do_test_single(struct bpf_align_test *tes=
t)
>                 .log_size =3D sizeof(bpf_vlog),
>                 .log_level =3D 2,
>         );
> +       const char *main_pass_start =3D "0: R1=3Dctx() R10=3Dfp0";
>         const char *line_ptr;
>         int cur_line =3D -1;
>         int prog_len, i;
> +       char *start;
>         int fd_prog;
>         int ret;
>
> @@ -632,7 +634,13 @@ static int do_test_single(struct bpf_align_test *tes=
t)
>                 ret =3D 0;
>                 /* We make a local copy so that we can strtok() it */
>                 strncpy(bpf_vlog_copy, bpf_vlog, sizeof(bpf_vlog_copy));
> -               line_ptr =3D strtok(bpf_vlog_copy, "\n");
> +               start =3D strstr(bpf_vlog_copy, main_pass_start);
> +               if (!start) {
> +                       ret =3D 1;
> +                       printf("Can't find initial line '%s'\n", main_pas=
s_start);
> +                       goto out;
> +               }
> +               line_ptr =3D strtok(start, "\n");
>                 for (i =3D 0; i < MAX_MATCHES; i++) {
>                         struct bpf_reg_match m =3D test->matches[i];
>                         const char *p;
> @@ -682,6 +690,7 @@ static int do_test_single(struct bpf_align_test *test=
)
>                                 break;
>                         }
>                 }
> +out:
>                 if (fd_prog >=3D 0)
>                         close(fd_prog);
>         }
> --
> 2.48.1
>

