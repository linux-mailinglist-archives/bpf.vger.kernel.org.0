Return-Path: <bpf+bounces-34335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0145592C7AA
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 02:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC2D1C224E7
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 00:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507EF15D1;
	Wed, 10 Jul 2024 00:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsQwcZxD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC85A32
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 00:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720571669; cv=none; b=tXArscpbLOMHwxkMU0Pyswc1Kp+rj/NKLsNMc+t727bEbiruT0qZbcN3iTIRL2TFnvp8oFawNLFYPbGeyTyapN14347VHtA8l6lTlOQOXxaKwmmBjAJgLauC16SFjGR/0nchPihYZ6gZf9RJ1nNeHCDKLWFK4qgr6vgnotUc6hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720571669; c=relaxed/simple;
	bh=VgAym6yFcGZF1oUWSNY7NxP5ht3WP6EP850Mvbbnepg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qxlbc0AP47H5IzVeLHNGdBwT6BV6pHqjlShGxTuM4POgxszmo4W5ZBF1i+vXB799ZcwrgxAfYF7N9k9Nhpklj81jlWHKvEp3cAI2w8urWnX28Z0GmGj7R5vGlyXABY+u1zMZXXkjkFMDFpKUkSBxWR2uiTisVzdhlhsuV8t4c1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsQwcZxD; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7669d62b5bfso2846093a12.1
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 17:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720571667; x=1721176467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4F8DJD3TXSjpURb0xKec4bn+CtKsDmYSOyMShwKN6dU=;
        b=PsQwcZxDJZ6usxbEsyMFSTbOGYsjynZCyVw7ubB3juu0Q0xqThCn5jLugktB5SSfe0
         xeIRCAywVXfM9XPZDKLa7UV5yR0bCAScBv9c8s5oRZCsVLfUktEQN+PVPpTtMgw4i7X/
         wiO1T4Ls09iSmf9UeYDOaIfYMXu/zmjCCWbq53RA5y4j+VhjBb6oFCH55LUyM+9XU2zL
         ZNJiSXGxS8/mOrNMjB7FHd8nvV6xp4APRFMu6VGQrv81QCkEtPPJlKAhcL2ITSsAuFHL
         ZkcysM7R7f3qAJhtU/G29FslkC2Pa00E1KX8vtDHq3AktNVldou+XlnOY69cYyEvLgeo
         x+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720571667; x=1721176467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4F8DJD3TXSjpURb0xKec4bn+CtKsDmYSOyMShwKN6dU=;
        b=d4JtlmHqT7IOYda2vDGntxbDQYe27UvBWDB8WXxl96lfJ+RkQ7PUSl3UEkE5/+MTuJ
         k6f+T8Yk1AbMlSy2vzCsvnD6INiOqmE1L4FGiAO/FuO2tBHO3jSOvgmhzqG4t7B/rdFA
         3RkanI/BJh3ADkpU4Royyx/7W5hIkuC5DeMFDHZu79LQBMhn7iS2pwdogVnoar2siey4
         7U1wwzu7fKAKdKAVKJCzieY9EewHujuE2hwg2EZYMUj8lsZDytx0TO5owXtJkHXbod2q
         imHK/3EJzISME9cr4l+BLm434IMX4hVLcS41HTxSIXk9xCz5jcJnW15soLL61Rh7UGqH
         3UgA==
X-Gm-Message-State: AOJu0YwLzIOS7RneCatlh5CGKl/csM8bdO/4aehtI4ks76sgom+t1JqO
	CgYoVX+9UIuYX6N/B2TmGxQQUbj5MA5od0kHs462yttbvSfBv2r8xJxV+kQ2mhTOrPLuIWyJcvP
	5EovgsZLType7x1OoAcS1LUd2ZlU=
X-Google-Smtp-Source: AGHT+IEbZESLGik733GvO/LvXszYEY95hiDlOKa5OQjFoHkGY8wGEPPepEpBNBKBwalDbONErcvJUfTxJJT4mDHzaC4=
X-Received: by 2002:a05:6a20:9187:b0:1c0:ee6f:232e with SMTP id
 adf61e73a8af0-1c29824d135mr4519942637.32.1720571667281; Tue, 09 Jul 2024
 17:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705205851.2635794-1-eddyz87@gmail.com> <20240705205851.2635794-2-eddyz87@gmail.com>
In-Reply-To: <20240705205851.2635794-2-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jul 2024 17:34:15 -0700
Message-ID: <CAEf4Bzbq8Lg+n1K=V0RjgKh7+PFU5rrwFPP2s0Z+g_nLbUpcPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: track find_equal_scalars history on
 per-instruction level
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 1:59=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Use bpf_verifier_state->jmp_history to track which registers were
> updated by find_equal_scalars() when conditional jump was verified.
> Use recorded information in backtrack_insn() to propagate precision.
>
> E.g. for the following program:
>
>             while verifying instructions
>   r1 =3D r0              |
>   if r1 < 8  goto ...  | push r0,r1 as equal_scalars in jmp_history
>   if r0 > 16 goto ...  | push r0,r1 as equal_scalars in jmp_history

linked_scalars? especially now that Alexei added offsets between
linked registers

>   r2 =3D r10             |
>   r2 +=3D r0             v mark_chain_precision(r0)
>
>             while doing mark_chain_precision(r0)
>   r1 =3D r0              ^
>   if r1 < 8  goto ...  | mark r0,r1 as precise
>   if r0 > 16 goto ...  | mark r0,r1 as precise
>   r2 =3D r10             |
>   r2 +=3D r0             | mark r0 precise

let's reverse the order here so it's linear in how the algorithm
actually works (backwards)?

>
> Technically, achieve this as follows:
> - Use 10 bits to identify each register that gains range because of
>   find_equal_scalars():

should this be renamed to find_linked_scalars() nowadays?

>   - 3 bits for frame number;
>   - 6 bits for register or stack slot number;
>   - 1 bit to indicate if register is spilled.
> - Use u64 as a vector of 6 such records + 4 bits for vector length.
> - Augment struct bpf_jmp_history_entry with field 'linked_regs'
>   representing such vector.
> - When doing check_cond_jmp_op() remember up to 6 registers that
>   gain range because of find_equal_scalars() in such a vector.
> - Don't propagate range information and reset IDs for registers that
>   don't fit in 6-value vector.
> - Push a pair {instruction index, equal scalars vector}
>   to bpf_verifier_state->jmp_history.
> - When doing backtrack_insn() check if any of recorded linked
>   registers is currently marked precise, if so mark all linked
>   registers as precise.
>
> This also requires fixes for two test_verifier tests:
> - precise: test 1
> - precise: test 2
>
> Both tests contain the following instruction sequence:
>
> 19: (bf) r2 =3D r9                      ; R2=3Dscalar(id=3D3) R9=3Dscalar=
(id=3D3)
> 20: (a5) if r2 < 0x8 goto pc+1        ; R2=3Dscalar(id=3D3,umin=3D8)
> 21: (95) exit
> 22: (07) r2 +=3D 1                      ; R2_w=3Dscalar(id=3D3+1,...)
> 23: (bf) r1 =3D r10                     ; R1_w=3Dfp0 R10=3Dfp0
> 24: (07) r1 +=3D -8                     ; R1_w=3Dfp-8
> 25: (b7) r3 =3D 0                       ; R3_w=3D0
> 26: (85) call bpf_probe_read_kernel#113
>
> The call to bpf_probe_read_kernel() at (26) forces r2 to be precise.
> Previously, this forced all registers with same id to become precise
> immediately when mark_chain_precision() is called.
> After this change, the precision is propagated to registers sharing
> same id only when 'if' instruction is backtracked.
> Hence verification log for both tests is changed:
> regs=3Dr2,r9 -> regs=3Dr2 for instructions 25..20.
>
> Fixes: 904e6ddf4133 ("bpf: Use scalar ids in mark_chain_precision()")
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Closes: https://lore.kernel.org/bpf/CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt=
+_Lf0kcFEut2Mg@mail.gmail.com/
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf_verifier.h                  |   4 +
>  kernel/bpf/verifier.c                         | 231 ++++++++++++++++--
>  .../bpf/progs/verifier_subprog_precision.c    |   2 +-
>  .../testing/selftests/bpf/verifier/precise.c  |  20 +-
>  4 files changed, 232 insertions(+), 25 deletions(-)
>

The logic looks good (though I had a few small questions), I think.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 2b54e25d2364..da450552c278 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -371,6 +371,10 @@ struct bpf_jmp_history_entry {
>         u32 prev_idx : 22;
>         /* special flags, e.g., whether insn is doing register stack spil=
l/load */
>         u32 flags : 10;
> +       /* additional registers that need precision tracking when this
> +        * jump is backtracked, vector of six 10-bit records
> +        */
> +       u64 linked_regs;
>  };
>
>  /* Maximum number of register states that can exist at once */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e25ad5fb9115..ec493360607e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3335,9 +3335,87 @@ static bool is_jmp_point(struct bpf_verifier_env *=
env, int insn_idx)
>         return env->insn_aux_data[insn_idx].jmp_point;
>  }
>
> +#define ES_FRAMENO_BITS        3
> +#define ES_SPI_BITS    6
> +#define ES_ENTRY_BITS  (ES_SPI_BITS + ES_FRAMENO_BITS + 1)
> +#define ES_SIZE_BITS   4
> +#define ES_FRAMENO_MASK        ((1ul << ES_FRAMENO_BITS) - 1)
> +#define ES_SPI_MASK    ((1ul << ES_SPI_BITS)     - 1)
> +#define ES_SIZE_MASK   ((1ul << ES_SIZE_BITS)    - 1)

ull for 32-bit arches?

> +#define ES_SPI_OFF     ES_FRAMENO_BITS
> +#define ES_IS_REG_OFF  (ES_SPI_BITS + ES_FRAMENO_BITS)

ES makes no sense now, no? LR or LINKREG or something along those lines?

> +#define LINKED_REGS_MAX        6
> +
> +struct reg_or_spill {

reg_or_spill -> linked_reg ?

> +       u8 frameno:3;
> +       union {
> +               u8 spi:6;
> +               u8 regno:6;
> +       };
> +       bool is_reg:1;
> +};

Do we need these bitfields for unpacked representation? It's going to
use 2 bytes for this struct anyways. If you just use u8 for everything
you end up with 3 bytes. Bitfields are a bit slower because the
compiler will need to do more bit manipulations, so is it really worth
it?

> +
> +struct linked_regs {
> +       int cnt;
> +       struct reg_or_spill entries[LINKED_REGS_MAX];
> +};
> +

[...]

> @@ -3615,6 +3739,12 @@ static int backtrack_insn(struct bpf_verifier_env =
*env, int idx, int subseq_idx,
>                 print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
>         }
>
> +       /* If there is a history record that some registers gained range =
at this insn,
> +        * propagate precision marks to those registers, so that bt_is_re=
g_set()
> +        * accounts for these registers.
> +        */
> +       bt_sync_linked_regs(bt, hist);
> +
>         if (class =3D=3D BPF_ALU || class =3D=3D BPF_ALU64) {
>                 if (!bt_is_reg_set(bt, dreg))
>                         return 0;
> @@ -3844,6 +3974,7 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
>                          */
>                         bt_set_reg(bt, dreg);
>                         bt_set_reg(bt, sreg);
> +               } else if (BPF_SRC(insn->code) =3D=3D BPF_K) {
>                          /* else dreg <cond> K

drop "else" from the comment then? I like this change.

>                           * Only dreg still needs precision before
>                           * this insn, so for the K-based conditional
> @@ -3862,6 +3993,10 @@ static int backtrack_insn(struct bpf_verifier_env =
*env, int idx, int subseq_idx,
>                         /* to be analyzed */
>                         return -ENOTSUPP;
>         }
> +       /* Propagate precision marks to linked registers, to account for
> +        * registers marked as precise in this function.
> +        */
> +       bt_sync_linked_regs(bt, hist);

Radical Andrii is fine with this, though I wonder if there is some
place outside of backtrack_insn() where the first
bt_sync_linked_regs() could be called just once?

But regardless, this is only mildly expensive when we do have linked
registers, so unlikely to have any noticeable performance effect.

>         return 0;
>  }
>
> @@ -4624,7 +4759,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
>         }
>
>         if (insn_flags)
> -               return push_jmp_history(env, env->cur_state, insn_flags);
> +               return push_jmp_history(env, env->cur_state, insn_flags, =
0);
>         return 0;
>  }
>
> @@ -4929,7 +5064,7 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
>                 insn_flags =3D 0; /* we are not restoring spilled registe=
r */
>         }
>         if (insn_flags)
> -               return push_jmp_history(env, env->cur_state, insn_flags);
> +               return push_jmp_history(env, env->cur_state, insn_flags, =
0);
>         return 0;
>  }
>
> @@ -15154,14 +15289,66 @@ static bool try_match_pkt_pointers(const struct=
 bpf_insn *insn,
>         return true;
>  }
>
> -static void find_equal_scalars(struct bpf_verifier_state *vstate,
> -                              struct bpf_reg_state *known_reg)
> +static void __find_equal_scalars(struct linked_regs *reg_set, struct bpf=
_reg_state *reg,
> +                                u32 id, u32 frameno, u32 spi_or_reg, boo=
l is_reg)

we should abandon "equal scalars" terminology, they don't have to be
equal, they are just linked together (potentially with a fixed
difference between them)


how about "collect_linked_regs"?

> +{
> +       struct reg_or_spill *e;
> +
> +       if (reg->type !=3D SCALAR_VALUE || (reg->id & ~BPF_ADD_CONST) !=
=3D id)

THIS is actually the place where I'd use u32 id:31; + bool
is_linked_reg:1; just so that it's not so easy to accidentally forget
about BPF_ADD_CONST flag (but it's unrelated to your patch)

> +               return;
> +
> +       e =3D linked_regs_push(reg_set);
> +       if (e) {
> +               e->frameno =3D frameno;
> +               e->is_reg =3D is_reg;
> +               e->regno =3D spi_or_reg;
> +       } else {
> +               reg->id =3D 0;
> +       }
> +}
> +

[...]

> @@ -15312,6 +15500,21 @@ static int check_cond_jmp_op(struct bpf_verifier=
_env *env,
>                 return 0;
>         }
>
> +       /* Push scalar registers sharing same ID to jump history,
> +        * do this before creating 'other_branch', so that both
> +        * 'this_branch' and 'other_branch' share this history
> +        * if parent state is created.
> +        */
> +       if (BPF_SRC(insn->code) =3D=3D BPF_X && src_reg->type =3D=3D SCAL=
AR_VALUE && src_reg->id)
> +               find_equal_scalars(this_branch, src_reg->id, &linked_regs=
);
> +       if (dst_reg->type =3D=3D SCALAR_VALUE && dst_reg->id)
> +               find_equal_scalars(this_branch, dst_reg->id, &linked_regs=
);
> +       if (linked_regs.cnt > 1) {

if we have just one, should it be even marked as linked?

> +               err =3D push_jmp_history(env, this_branch, 0, linked_regs=
_pack(&linked_regs));
> +               if (err)
> +                       return err;
> +       }
> +
>         other_branch =3D push_stack(env, *insn_idx + insn->off + 1, *insn=
_idx,
>                                   false);
>         if (!other_branch)
> @@ -15336,13 +15539,13 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
>         if (BPF_SRC(insn->code) =3D=3D BPF_X &&
>             src_reg->type =3D=3D SCALAR_VALUE && src_reg->id &&
>             !WARN_ON_ONCE(src_reg->id !=3D other_branch_regs[insn->src_re=
g].id)) {
> -               find_equal_scalars(this_branch, src_reg);
> -               find_equal_scalars(other_branch, &other_branch_regs[insn-=
>src_reg]);
> +               copy_known_reg(this_branch, src_reg, &linked_regs);
> +               copy_known_reg(other_branch, &other_branch_regs[insn->src=
_reg], &linked_regs);

I liked the "sync" terminology you used for bt, so why not call this
"sync_linked_regs" ?

>         }
>         if (dst_reg->type =3D=3D SCALAR_VALUE && dst_reg->id &&
>             !WARN_ON_ONCE(dst_reg->id !=3D other_branch_regs[insn->dst_re=
g].id)) {
> -               find_equal_scalars(this_branch, dst_reg);
> -               find_equal_scalars(other_branch, &other_branch_regs[insn-=
>dst_reg]);
> +               copy_known_reg(this_branch, dst_reg, &linked_regs);
> +               copy_known_reg(other_branch, &other_branch_regs[insn->dst=
_reg], &linked_regs);
>         }
>

[...]

