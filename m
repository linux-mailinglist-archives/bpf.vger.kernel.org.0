Return-Path: <bpf+bounces-58410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A00DABA0AB
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 18:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7FF50598D
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 16:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9B21B4F09;
	Fri, 16 May 2025 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBz8BaMU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11A71A256B
	for <bpf@vger.kernel.org>; Fri, 16 May 2025 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747412095; cv=none; b=Ts80RhmiBHSRtux5l1E6sowWvoaiU3Nwh6eSKJ5vUHPCktzcZC0cnYXQ3e0LIgvTYgEubFgGHp/o2W4svve4xyf9CRUd3MwI4zf0SG4iyvrB/kJJ7GtKlgmybO0nzgepEZesFaba6zV3BjUE+gM5b+pL/c2ebdih+9woYlionZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747412095; c=relaxed/simple;
	bh=+BYXkxwODUOTP10QR0wTuSD2n6QrEh0kTRMcQNforbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrX4OVvh0K7xCfNZ37WFxX4FhzUn2tO9poQo+AS+OuvuEcmaF8QPh5Nzajtx+tM1O8Qp6VSiWFlG3CYVaHg8KbNitwSfoI+lEzY+9hqR8uFsK74OTVNRFfPrELFs4/uQq2qrZn6Pl1WlwAE1sSYEk/YdWRZM1RJ1z5+laLXvClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBz8BaMU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30e87549254so1001067a91.2
        for <bpf@vger.kernel.org>; Fri, 16 May 2025 09:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747412093; x=1748016893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWbx0Fzljb9TCYekopCAaSV4fJtfHKMhnSVSkBlnki8=;
        b=UBz8BaMUGzWLBAiUJzkplTOo53EKtOi/mrZMwWkEebWviM3MVgDMJqAnTZxeVA+P5D
         e85tJWfgjvo1oe0FSUHfC1y7BuwMvAYXPrSUeVb6FcGkqgmWOEGigA6zJNxpgGmSAnlx
         rjz7BzG1kMGuPy+V4C+pdk39QDWgWtGFTJXbnYfFWjXmC3bbPY9hucE2jkR4GbPcDPkq
         6ulA72fzyc9mx+6yhfNUYLJOJTFQkjPIjeH/l/4a/+ZGp2ca+JvLtkGCh1u/3DDSiYE8
         YYffW7PHzCiMW6oAUImS/V+Z/FGhcRECRQA7O6HldqALDXZUibTmwlb7W20bsQF2VX4D
         SplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747412093; x=1748016893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWbx0Fzljb9TCYekopCAaSV4fJtfHKMhnSVSkBlnki8=;
        b=wHPx4WSVrdaNLAzYz/CzpqAoGzbN6hBp+UufBW+VKPNIlk8hPjyAH8/m7GWocalMp2
         DmKj4uUwKTD9UOo5x1COwUIHZB98b91adACl/+NaM/e+C9qa2CuoyO+WMb5m/erSgQL9
         s6wYv2ycW8+um9vhOvH8aSufsUAP/jQB15vG3SmKu1ao29SIHlCJvgCyClQCRh9qJrRi
         tUEgcvr639cC0oTV2iTovWiZPnaxqYkFqHTV3uQ4OyMRK5EuGlZqBcPCK8fMfS5nLX8h
         xCf1TbSvzkR1J+JAfX5KnGrk4zWfhodOIOx95V2AFDBO2ctJ3pE+d5ufsSYKN9tch9R6
         at/Q==
X-Gm-Message-State: AOJu0Yz6fsQjEZLl052RIwBt9EWqOfYVZPS3R89KiOkIFvWJ8igpRbkw
	lzdaFr+ARHyXtZRr/s4TvVkl+SXI3vdoirzSCs/cVf1sV3VU0r3m/dkt4ipx+f2+7qo4nC44hu2
	5Eb/SFeQSN4ivwb6HgVQyvbwYLIS8GKlaST38C54=
X-Gm-Gg: ASbGncuD4TaBVCiySeXgoS5dCMHv2IwhN2Rr6OyknH2sHV01ZtjGqhWpuOtyKfVOTRO
	soV4uNh0bYncb75qs9pjnmHGaXBFRbRvpLIujzVE0U6j4FIEp3oIsvZ/+QPfoDIZoOLw+kPEsBw
	xTQ0cdOcQ0gOVKBrvQl2/e75f7Ix2Rwi6XpmdUdECvG9iub7mh
X-Google-Smtp-Source: AGHT+IF9H2Wx/lFsDaphHj6to5OK72FnGHxShaA4Hxx+l9buq6eIcI2oMHe/SMzbshXrXvolTUqI2mIvKRl1tp3V2fE=
X-Received: by 2002:a17:90b:2d4c:b0:301:1c11:aa74 with SMTP id
 98e67ed59e1d1-30e7d5a84a3mr5808717a91.28.1747412092941; Fri, 16 May 2025
 09:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aCcGpxnlfOOiOJ-b@mail.gmail.com>
In-Reply-To: <aCcGpxnlfOOiOJ-b@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 May 2025 09:14:40 -0700
X-Gm-Features: AX0GCFsXMdaCi5pDE22HDfQOrSnW0-s72DWH4kk8BiwhdNtTICtkOPVHchcB_ZA
Message-ID: <CAEf4BzawwGq7A+DGUYmj_xpKJHDnqPWR=nbOzL7Vux1kqMODXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpf: WARN_ONCE on verifier bugs
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 2:34=E2=80=AFAM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> Throughout the verifier's logic, there are multiple checks for
> inconsistent states that should never happen and would indicate a
> verifier bug. These bugs are typically logged in the verifier logs and
> sometimes preceded by a WARN_ONCE.
>
> This patch reworks these checks to consistently emit a verifier log AND
> a warning when CONFIG_DEBUG_KERNEL is enabled. The consistent use of
> WARN_ONCE should help fuzzers (ex. syzkaller) expose any situation
> where they are actually able to reach one of those buggy verifier
> states.
>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
> Changes in v4:
>   - Evaluate condition once and stringify it, as suggested by Alexei.
>   - Use verifier_bug_if instead of verifier_bug where it can help
>     disambiguate the callsite or shorten the message.
>   - Add newline character in verifier_bug_if directly.
> Changes in v3:
>   - Introduce and use verifier_bug_if, as suggested by Andrii.
> Changes in v2:
>   - Introduce a new BPF_WARN_ONCE macro, with WARN_ONCE conditioned on
>     CONFIG_DEBUG_KERNEL, as per reviews.
>   - Use the new helper function for verifier bugs missed in v1,
>     particularly around backtracking.
>
>  include/linux/bpf.h          |   6 ++
>  include/linux/bpf_verifier.h |  11 +++
>  kernel/bpf/btf.c             |   4 +-
>  kernel/bpf/verifier.c        | 140 +++++++++++++++--------------------
>  4 files changed, 77 insertions(+), 84 deletions(-)
>

LGTM overall, left a few comments below, please take a look

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 83c56f40842b..5b25d278409b 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -346,6 +346,12 @@ static inline const char *btf_field_type_name(enum b=
tf_field_type type)
>         }
>  }
>
> +#if IS_ENABLED(CONFIG_DEBUG_KERNEL)
> +#define BPF_WARN_ONCE(cond, format...) WARN_ONCE(cond, format)
> +#else
> +#define BPF_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
> +#endif
> +
>  static inline u32 btf_field_type_size(enum btf_field_type type)
>  {
>         switch (type) {
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index cedd66867ecf..7edb15830132 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -839,6 +839,17 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifie=
r_env *env,
>                                   u32 insn_off,
>                                   const char *prefix_fmt, ...);
>
> +#define verifier_bug_if(cond, env, fmt, args...)                        =
                       \
> +       ({                                                               =
                       \
> +               bool __cond =3D unlikely(cond);                          =
                         \
> +               if (__cond) {                                            =
                       \

this might be equivalent in terms of code generation, but I'd expect
unlikely() to be inside the if()

bool __cond =3D (cond);
if (unlikely(__cond)) { ... }

> +                       BPF_WARN_ONCE(1, "verifier bug: " fmt "(" #cond "=
)\n", ##args);         \
> +                       bpf_log(&env->log, "verifier bug: " fmt "(" #cond=
 ")\n", ##args);       \
> +               }                                                        =
                       \
> +               (__cond);                                                =
                       \
> +       })
> +#define verifier_bug(env, fmt, args...) verifier_bug_if(1, env, fmt, ##a=
rgs)
> +
>  static inline struct bpf_func_state *cur_func(struct bpf_verifier_env *e=
nv)
>  {
>         struct bpf_verifier_state *cur =3D env->cur_state;
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 6b21ca67070c..0f7828380895 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7659,7 +7659,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
>                 return 0;
>
>         if (!prog->aux->func_info) {
> -               bpf_log(log, "Verifier bug\n");
> +               verifier_bug(env, "func_info undefined");
>                 return -EFAULT;
>         }
>
> @@ -7683,7 +7683,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
>         tname =3D btf_name_by_offset(btf, fn_t->name_off);
>
>         if (prog->aux->func_info_aux[subprog].unreliable) {
> -               bpf_log(log, "Verifier bug in function %s()\n", tname);
> +               verifier_bug(env, "unreliable BTF for function %s()", tna=
me);
>                 return -EFAULT;
>         }
>         if (prog_type =3D=3D BPF_PROG_TYPE_EXT)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f6d3655b3a7a..cec35daf2b77 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1924,11 +1924,9 @@ static struct bpf_verifier_state *get_loop_entry(s=
truct bpf_verifier_env *env,
>         u32 steps =3D 0;
>
>         while (topmost && topmost->loop_entry) {
> -               if (steps++ > st->dfs_depth) {
> -                       WARN_ONCE(true, "verifier bug: infinite loop in g=
et_loop_entry\n");
> -                       verbose(env, "verifier bug: infinite loop in get_=
loop_entry()\n");
> +               if (verifier_bug_if(steps++ > st->dfs_depth, env,
> +                                   "infinite loop"))

nit: I'd keep it single-line (it probably fits 100 characters limit)

>                         return ERR_PTR(-EFAULT);
> -               }
>                 topmost =3D topmost->loop_entry;
>         }
>         return topmost;

[...]

> @@ -3999,8 +3995,7 @@ static inline int bt_subprog_enter(struct backtrack=
_state *bt)
>  static inline int bt_subprog_exit(struct backtrack_state *bt)
>  {
>         if (bt->frame =3D=3D 0) {
> -               verbose(bt->env, "BUG subprog exit from frame 0\n");
> -               WARN_ONCE(1, "verifier backtracking bug");
> +               verifier_bug(bt->env, "subprog exit from frame 0");
>                 return -EFAULT;
>         }
>         bt->frame--;
> @@ -4278,14 +4273,15 @@ static int backtrack_insn(struct bpf_verifier_env=
 *env, int idx, int subseq_idx,
>                                  * should be literally next instruction i=
n
>                                  * caller program
>                                  */
> -                               WARN_ONCE(idx + 1 !=3D subseq_idx, "verif=
ier backtracking bug");
> +                               verifier_bug_if(idx + 1 !=3D subseq_idx, =
env,
> +                                               "extra insn from subprog"=
);
>                                 /* r1-r5 are invalidated after subprog ca=
ll,
>                                  * so for global func call it shouldn't b=
e set
>                                  * anymore
>                                  */
>                                 if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
> -                                       verbose(env, "BUG regs %x\n", bt_=
reg_mask(bt));
> -                                       WARN_ONCE(1, "verifier backtracki=
ng bug");
> +                                       verifier_bug(env, "scratch reg se=
t: regs %x",

"global subprog unexpected regs %x"

> +                                                    bt_reg_mask(bt));
>                                         return -EFAULT;
>                                 }
>                                 /* global subprog always sets R0 */
> @@ -4299,16 +4295,16 @@ static int backtrack_insn(struct bpf_verifier_env=
 *env, int idx, int subseq_idx,
>                                  * the current frame should be zero by no=
w
>                                  */
>                                 if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) =
{
> -                                       verbose(env, "BUG regs %x\n", bt_=
reg_mask(bt));
> -                                       WARN_ONCE(1, "verifier backtracki=
ng bug");
> +                                       verifier_bug(env, "unexpected pre=
cise regs %x",

"static subprog unexpected regs %x"

(note, user is not expected to really make sense out of this, it's
just for reporting to us and our debugging, so let's make messages
distinct, but they don't necessarily need to be precise, IMO)

> +                                                    bt_reg_mask(bt));
>                                         return -EFAULT;
>                                 }
>                                 /* we are now tracking register spills co=
rrectly,
>                                  * so any instance of leftover slots is a=
 bug
>                                  */
>                                 if (bt_stack_mask(bt) !=3D 0) {
> -                                       verbose(env, "BUG stack slots %ll=
x\n", bt_stack_mask(bt));
> -                                       WARN_ONCE(1, "verifier backtracki=
ng bug (subprog leftover stack slots)");
> +                                       verifier_bug(env, "subprog leftov=
er stack slots %llx",
> +                                                    bt_stack_mask(bt));

good enough as is, but we can add "static " for consistency with the above

>                                         return -EFAULT;
>                                 }
>                                 /* propagate r1-r5 to the caller */
> @@ -4331,13 +4327,13 @@ static int backtrack_insn(struct bpf_verifier_env=
 *env, int idx, int subseq_idx,
>                          * not actually arguments passed directly to call=
back subprogs
>                          */
>                         if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
> -                               verbose(env, "BUG regs %x\n", bt_reg_mask=
(bt));
> -                               WARN_ONCE(1, "verifier backtracking bug")=
;
> +                               verifier_bug(env, "unexpected precise reg=
s %x",
> +                                            bt_reg_mask(bt));

"callback unexpected regs %x"

>                                 return -EFAULT;
>                         }
>                         if (bt_stack_mask(bt) !=3D 0) {
> -                               verbose(env, "BUG stack slots %llx\n", bt=
_stack_mask(bt));
> -                               WARN_ONCE(1, "verifier backtracking bug (=
callback leftover stack slots)");
> +                               verifier_bug(env, "callback leftover stac=
k slots %llx",
> +                                            bt_stack_mask(bt));
>                                 return -EFAULT;
>                         }
>                         /* clear r1-r5 in callback subprog's mask */
> @@ -4359,8 +4355,7 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
>                                 /* if backtracing was looking for registe=
rs R1-R5

oops, "backtracking" :)

>                                  * they should have been found already.
>                                  */
> -                               verbose(env, "BUG regs %x\n", bt_reg_mask=
(bt));
> -                               WARN_ONCE(1, "verifier backtracking bug")=
;
> +                               verifier_bug(env, "regs not found %x", bt=
_reg_mask(bt));

"call unexpected regs %x"

>                                 return -EFAULT;
>                         }
>                 } else if (opcode =3D=3D BPF_EXIT) {
> @@ -4378,8 +4373,7 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
>                                 for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i=
++)
>                                         bt_clear_reg(bt, i);
>                         if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
> -                               verbose(env, "BUG regs %x\n", bt_reg_mask=
(bt));
> -                               WARN_ONCE(1, "verifier backtracking bug")=
;
> +                               verifier_bug(env, "regs not found %x", bt=
_reg_mask(bt));

for this one and a few above, I'd probably leave the "backtracking"
word in the message, so something like

"backtracking exit unexpected regs %x"

>                                 return -EFAULT;
>                         }
>
> @@ -4720,9 +4714,8 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno)
>                                 return 0;
>                         }
>
> -                       verbose(env, "BUG backtracking func entry subprog=
 %d reg_mask %x stack_mask %llx\n",
> -                               st->frame[0]->subprogno, bt_reg_mask(bt),=
 bt_stack_mask(bt));
> -                       WARN_ONCE(1, "verifier backtracking bug");
> +                       verifier_bug(env, "backtracking func entry subpro=
g %d reg_mask %x stack_mask %llx",
> +                                    st->frame[0]->subprogno, bt_reg_mask=
(bt), bt_stack_mask(bt));
>                         return -EFAULT;
>                 }
>
> @@ -4751,17 +4744,14 @@ static int __mark_chain_precision(struct bpf_veri=
fier_env *env, int regno)
>                         i =3D get_prev_insn_idx(env, st, i, hist_start, &=
hist_end);
>                         if (i =3D=3D -ENOENT)
>                                 break;
> -                       if (i >=3D env->prog->len) {
> +                       if (verifier_bug_if(i >=3D env->prog->len, env, "=
backtracking idx %d", i))

this is the case where I'd leaver verifier_bug_if() inside the if() {}
itself, at least due to that long comment that actually describes the
bug context, but as I said, it's minor

>                                 /* This can happen if backtracking reache=
d insn 0
>                                  * and there are still reg_mask or stack_=
mask
>                                  * to backtrack.
>                                  * It means the backtracking missed the s=
pot where
>                                  * particular register was initialized wi=
th a constant.
>                                  */
> -                               verbose(env, "BUG backtracking idx %d\n",=
 i);
> -                               WARN_ONCE(1, "verifier backtracking bug")=
;
>                                 return -EFAULT;
> -                       }
>                 }
>                 st =3D st->parent;
>                 if (!st)

[...]

> @@ -10286,8 +10268,8 @@ static int setup_func_entry(struct bpf_verifier_e=
nv *env, int subprog, int calls
>         }
>
>         if (state->frame[state->curframe + 1]) {
> -               verbose(env, "verifier bug. Frame %d already allocated\n"=
,
> -                       state->curframe + 1);
> +               verifier_bug(env, "Frame %d already allocated",
> +                            state->curframe + 1);

nit: single line

>                 return -EFAULT;
>         }
>
> @@ -10401,8 +10383,8 @@ static int btf_check_func_arg_match(struct bpf_ve=
rifier_env *env, int subprog,
>                         if (err)
>                                 return err;
>                 } else {
> -                       bpf_log(log, "verifier bug: unrecognized arg#%d t=
ype %d\n",
> -                               i, arg->arg_type);
> +                       verifier_bug(env, "unrecognized arg#%d type %d",
> +                                    i, arg->arg_type);

single line, if possible

>                         return -EFAULT;
>                 }
>         }

[...]

