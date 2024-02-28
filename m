Return-Path: <bpf+bounces-22917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7AC86B8B3
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 20:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B7B28575C
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 19:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7995E082;
	Wed, 28 Feb 2024 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/Nvqbg4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93685E069
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150298; cv=none; b=k2XgD2MTavEUd0plcvwhvKKFPRchFS/TK86bHRrxK/Bg5nBPM87T9FykILRMOLN1slkcqBHB4oQo2371pylp4K0SuIgIrMlyywX28n6h4a+KxHnzxwhKx75UUCzI5EqoNkrxjuWfRA0dMP9hzxDz7ivwjZwmks+QGSnwlYFsOJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150298; c=relaxed/simple;
	bh=OocYS+9vs4pKNM0I28coYsszbkzVnHpxPKBt6ibf/uU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIzNpKCF7lKA/NAA2oMbqTu5yx3iWNtTPZyQoQ59Cp35eQRhrYBQoupV5FszxbJEwHwEK6s4df1lCNNYh+h298BX+m6srWGTzzF7FgEzyuij8t8KSzSubj9hLLJKCJjJWHkqnmcJAj9mIgx4C7yMoh4m7PjVnWpx7Hp8KySqtac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/Nvqbg4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso1691525ad.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 11:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709150296; x=1709755096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exWwX52tv6CEF2b223iRbeRvo6vB+7odNuCO2E+0Pp4=;
        b=e/Nvqbg4L/DPYN2UzJ0c+HRR//O31a9yTpoqZzKQ75fgXNJT2xNADGBQz/ouYEX4SO
         ywQLQnCTGCs/9er8k4zecB5ErEXvzH6mJkwI24tcRhkLg5If0eY47o0Ar4hlVI+z7PJQ
         Rjt9KzQGHNqE6EVI8iTEbWMc9n1HbJ8NGWwEbCWHgTz/1WEsOe5fn1Im7hIhEZ838WqR
         5D4kFwSYfYeYDglA4ehCTqvTP7jpQ67Vy4bbWTtDZnB477a2uv9Zq2anL4OxZOUkxduv
         NRpYA8H2pwLwjampJIM2P7mY/sxqfDhAcNgM6JdDIhbi4G6z651G6elyoMqf/vGTaR3I
         JYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709150296; x=1709755096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exWwX52tv6CEF2b223iRbeRvo6vB+7odNuCO2E+0Pp4=;
        b=CxmM10orqTAaprVEBmzjOb97xb8ntNayCq+aDFuXxkVmgkhLUd+BSLy0pXLAY92Xhy
         PtZi7CHG/vcRkc813V8JOSzqTAvt8rJLsPCvL9e4rm4GkCV0Ahv0f/uUfQxFcbIJ42eJ
         GyNpXu65ihrXLpgcu7yfzk8EI3C1vsVIf/Pt75HHPRYYNk6tj9tF5Z3kbEthInG1jhfe
         9puWsvvjQwURIRq8a8Mr58FU+kc7eW1NTHmPbXXR1xItJE4dPV8eupIHm88kfx8C+yPI
         UuAaJ2sBO3XQydSmjD8lGqC8sue1qT+/r0YUyz4dAoKYN1wpRS0j88IPyof3r6g5ohX8
         to7g==
X-Gm-Message-State: AOJu0YyhEtaCIIQ1WdYqPvJmpUDic7pmIQeVUpHPe/uh030M19M7Ly/+
	nztjtEyuTZrmbVtsB+a0AJ7DsFJTzjFAYHES7P2PJtysDx6K0k2AAPxB4lCPZcshRK1O8J1l0YH
	Mtz6xznc3Y3bjD3yerh4ZVUBOIdbISN0c4yU=
X-Google-Smtp-Source: AGHT+IHVZPtwOeF3kLmmxGJ4bq+Tox0S1b/qyOlpIFyoM/D3xOcjyoZBNq2+UVegnLYwNpBlrkUYRbRFK1Woj6W8F0Q=
X-Received: by 2002:a17:902:b7ca:b0:1db:5b41:c5ac with SMTP id
 v10-20020a170902b7ca00b001db5b41c5acmr449762plz.68.1709150296212; Wed, 28 Feb
 2024 11:58:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222005005.31784-1-eddyz87@gmail.com> <20240222005005.31784-3-eddyz87@gmail.com>
In-Reply-To: <20240222005005.31784-3-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 11:58:04 -0800
Message-ID: <CAEf4BzYwoFN8GzdWt+6Avbh1jT5LoybOUVh=C-8=dX8H75J_+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: track find_equal_scalars history on
 per-instruction level
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 4:50=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
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
>   r2 =3D r10             |
>   r2 +=3D r0             v mark_chain_precision(r0)
>
>             while doing mark_chain_precision(r0)
>   r1 =3D r0              ^
>   if r1 < 8  goto ...  | mark r0,r1 as precise
>   if r0 > 16 goto ...  | mark r0,r1 as precise
>   r2 =3D r10             |
>   r2 +=3D r0             | mark r0 precise
>
> Technically achieve this in following steps:
> - Use 10 bits to identify each register that gains range because of
>   find_equal_scalars():
>   - 3 bits for frame number;
>   - 6 bits for register or stack slot number;
>   - 1 bit to indicate if register is spilled.
> - Use u64 as a vector of 6 such records + 4 bits for vector length.
> - Augment struct bpf_jmp_history_entry with field 'equal_scalars'
>   representing such vector.
> - When doing check_cond_jmp_op() for remember up to 6 registers that
>   gain range because of find_equal_scalars() in such a vector.
> - Don't propagate range information and reset IDs for registers that
>   don't fit in 6-value vector.
> - Push collected vector to bpf_verifier_state->jmp_history for
>   instruction index of conditional jump.
> - When doing backtrack_insn() for conditional jumps
>   check if any of recorded equal scalars is currently marked precise,
>   if so mark all equal recorded scalars as precise.
>
> Fixes: 904e6ddf4133 ("bpf: Use scalar ids in mark_chain_precision()")
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Closes: https://lore.kernel.org/bpf/CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt=
+_Lf0kcFEut2Mg@mail.gmail.com/
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf_verifier.h                  |   1 +
>  kernel/bpf/verifier.c                         | 207 ++++++++++++++++--
>  .../bpf/progs/verifier_subprog_precision.c    |   2 +-
>  .../testing/selftests/bpf/verifier/precise.c  |   2 +-
>  4 files changed, 195 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index cbfb235984c8..26e32555711c 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -361,6 +361,7 @@ struct bpf_jmp_history_entry {
>         u32 prev_idx : 22;
>         /* special flags, e.g., whether insn is doing register stack spil=
l/load */
>         u32 flags : 10;
> +       u64 equal_scalars;

nit: should we call this concept as a bit more generic "linked
registers" instead of "equal scalars"?

>  };
>
>  /* Maximum number of register states that can exist at once */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 759ef089b33c..b95b6842703c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3304,6 +3304,76 @@ static bool is_jmp_point(struct bpf_verifier_env *=
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
> +#define ES_SPI_OFF     ES_FRAMENO_BITS
> +#define ES_IS_REG_OFF  (ES_SPI_BITS + ES_FRAMENO_BITS)
> +
> +/* Pack one history entry for equal scalars as 10 bits in the following =
format:
> + * - 3-bits frameno
> + * - 6-bits spi_or_reg
> + * - 1-bit  is_reg
> + */
> +static u64 equal_scalars_pack(u32 frameno, u32 spi_or_reg, bool is_reg)
> +{
> +       u64 val =3D 0;
> +
> +       val |=3D frameno & ES_FRAMENO_MASK;
> +       val |=3D (spi_or_reg & ES_SPI_MASK) << ES_SPI_OFF;
> +       val |=3D (is_reg ? 1 : 0) << ES_IS_REG_OFF;
> +       return val;
> +}
> +
> +static void equal_scalars_unpack(u64 val, u32 *frameno, u32 *spi_or_reg,=
 bool *is_reg)
> +{
> +       *frameno    =3D  val & ES_FRAMENO_MASK;
> +       *spi_or_reg =3D (val >> ES_SPI_OFF) & ES_SPI_MASK;
> +       *is_reg     =3D (val >> ES_IS_REG_OFF) & 0x1;
> +}
> +
> +static u32 equal_scalars_size(u64 equal_scalars)
> +{
> +       return equal_scalars & ES_SIZE_MASK;
> +}
> +
> +/* Use u64 as a stack of 6 10-bit values, use first 4-bits to track
> + * number of elements currently in stack.
> + */
> +static bool equal_scalars_push(u64 *equal_scalars, u32 frameno, u32 spi_=
or_reg, bool is_reg)
> +{
> +       u32 num;
> +
> +       num =3D equal_scalars_size(*equal_scalars);
> +       if (num =3D=3D 6)
> +               return false;
> +       *equal_scalars >>=3D ES_SIZE_BITS;
> +       *equal_scalars <<=3D ES_ENTRY_BITS;
> +       *equal_scalars |=3D equal_scalars_pack(frameno, spi_or_reg, is_re=
g);
> +       *equal_scalars <<=3D ES_SIZE_BITS;
> +       *equal_scalars |=3D num + 1;
> +       return true;
> +}
> +
> +static bool equal_scalars_pop(u64 *equal_scalars, u32 *frameno, u32 *spi=
_or_reg, bool *is_reg)
> +{
> +       u32 num;
> +
> +       num =3D equal_scalars_size(*equal_scalars);
> +       if (num =3D=3D 0)
> +               return false;
> +       *equal_scalars >>=3D ES_SIZE_BITS;
> +       equal_scalars_unpack(*equal_scalars, frameno, spi_or_reg, is_reg)=
;
> +       *equal_scalars >>=3D ES_ENTRY_BITS;
> +       *equal_scalars <<=3D ES_SIZE_BITS;
> +       *equal_scalars |=3D num - 1;
> +       return true;
> +}
> +

I'm wondering if this pop/push set of primitives is the best approach?
What if we had pack/unpack operations, where for various checking
logic we'd be working with "unpacked" representation, e.g., something
like this:

struct linked_reg_set {
    int cnt;
    struct {
        int frameno;
        union {
            int spi;
            int regno;
        };
        bool is_set;
        bool is_reg;
    } reg_set[6];
};

bt_set_equal_scalars() could accept `struct linked_reg_set*` instead
of bitmask itself. Same for find_equal_scalars().

I think even implementation of packing/unpacking would be more
straightforward and we won't even need all those ES_xxx consts (or at
least fewer of them).

WDYT?

>  static struct bpf_jmp_history_entry *get_jmp_hist_entry(struct bpf_verif=
ier_state *st,
>                                                         u32 hist_end, int=
 insn_idx)
>  {

[...]

