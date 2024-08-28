Return-Path: <bpf+bounces-38294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072A9962DE3
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 18:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5BC1C227EA
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 16:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A971A2560;
	Wed, 28 Aug 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJUQ/tpW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F571A4F0A
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724863736; cv=none; b=UokMJC1AN2JGvj7lzA9ZIPEjgPIafHZ/QNwqJ4B722v+vAsGZ6v7+mxi1YxBmUnkYEBV/BR8tdh6greK0bMslxk6pUZmOMPeyMGWxHeXIRRt1a3j1WqAp9knjFmXPPMKdY4oXQDd74lV9gHq1NkwYPlGpVfE1BSwjTZ0b4X1sjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724863736; c=relaxed/simple;
	bh=l3Oqw8cBmlB2Z1j2OYQ9jGC+Hk17au/oi3Q47V7ZlI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0vijcbFlAEfa6qAygDb6nPnr9SJazt142YuT15g5ziQWbDwaRqk29S8+c2vjt2D2JUdLkAqSOayoATi2Xnl7GQxgffPZEGfccR6GMO6dU/em/qQCBZjzfwtmNwvN8KRn9hqHUxIMupo33AL5uEFMMelxrJ+P8ocQ56rDUWJdPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJUQ/tpW; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-371ba7e46easo4073879f8f.0
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724863733; x=1725468533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTPMGqxPG6eG+7L+282zRykJSP1bdz4IIwdmSohYxWo=;
        b=QJUQ/tpWpYKdQ7P+K9gOzsBURDCIgFJ94SfPGOUOdCvWldHEZ922q0apISrET8DzgU
         gUsQDw2Yl2JeIw9i3P9RfRJR/kVwt/AUqRxdguH62lGR+XVyufnMJ0vUoQYVNeh30VHT
         uKSlQo6dAA0WaI+yqPD/3iQv+hfTLTSA5XWCohyJTdZwiKl/inq54WS1DOnxk+kzPMNM
         isxMMFmTLGsfF+MAQ1nhaWsgab/SduJxIAE5Tkgeo9jyQKqgFYxcsgU/e30jctsTn3uV
         QXLFUYUKCjkTx/BZnkWB3BzOzqYnLZL7qei5qVV9UMj9IQdf8sEc8j64O+HGuq5FdH7S
         XlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724863733; x=1725468533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTPMGqxPG6eG+7L+282zRykJSP1bdz4IIwdmSohYxWo=;
        b=gHFHjCfOq3O4pPu6CHjt7DeQ6t+0So1B2zUwKfTEYesSRTxUUGaHisAfeaxD0Btyc5
         RROT/VkQVsFFTOC5lkxs3kEnepJWIgP6LGFX7n4XpKYkYBtecto3b8axA76f5IebCBKL
         HTOnv4kNGR+ZqDsoiRzBcTfVBCKVkuxB0IFWeaw5HfQwZZ+IxNknbMETToOAtrlRhfFf
         zalIfQUA0ZIXGCDhJ1qNSgp8Pb5FvOUcUqYaYZ+3fU93DEB4AvEvxpx/VDsw5XSn0wGb
         F7q/o09wD4LqZKXwc//4Oj+ORbmQLiXxgRIVwSLDLJVZM+9TcW6+0QZehAZhcKLPYvoj
         7Zfw==
X-Gm-Message-State: AOJu0YyxRCdjDosWOhGQLLpBEoOa6ZuKb5EK1jX5DACvPxy0hS/OTLIl
	hXan85a0mzbtx+owV590NJyhttmAB3b6Q508djEuMzprnZkq/OJC10kWx1kCTsgM/E1sf2GJb0u
	PkvlI/Xk0qqtzMYRp3CdhAAwpfZ8=
X-Google-Smtp-Source: AGHT+IEjnVGO9WHOBocyCpAtSh7bRvNaGgsseDqBkzOl1jwVHmcSRlAeAl4a030LZVoBWXO8DA7e8X8e1Z8H53/DvDw=
X-Received: by 2002:a5d:4d4d:0:b0:371:8750:419e with SMTP id
 ffacd0b85a97d-3749b57fe7bmr116804f8f.47.1724863733056; Wed, 28 Aug 2024
 09:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827194834.1423815-1-martin.lau@linux.dev> <20240827195208.1435815-1-martin.lau@linux.dev>
In-Reply-To: <20240827195208.1435815-1-martin.lau@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Aug 2024 09:48:41 -0700
Message-ID: <CAADnVQJbGCB5Hjb8NPU7P0ZOwR_EWcREuxsBOvyo7cRggdioDA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/9] bpf: Adjust BPF_JMP that jumps to the 1st
 insn of the prologue
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Amery Hung <ameryhung@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 12:53=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> The next patch will add a ctx ptr saving instruction
> "(r1 =3D *(u64 *)(r10 -8)" at the beginning for the main prog
> when there is an epilogue patch (by the .gen_epilogue() verifier
> ops added in the next patch).
>
> There is one corner case if the bpf prog has a BPF_JMP that jumps
> to the 1st instruction. It needs an adjustment such that
> those BPF_JMP instructions won't jump to the newly added
> ctx saving instruction.
> The commit 5337ac4c9b80 ("bpf: Fix the corner case with may_goto and jump=
 to the 1st insn.")
> has the details on this case.
>
> Note that the jump back to 1st instruction is not limited to the
> ctx ptr saving instruction. The same also applies to the prologue.
> A later test, pro_epilogue_goto_start.c, has a test for the prologue
> only case.
>
> Thus, this patch does one adjustment after gen_prologue and
> the future ctx ptr saving. It is done by
> adjust_jmp_off(env->prog, 0, delta) where delta has the total
> number of instructions in the prologue and
> the future ctx ptr saving instruction.
>
> The adjust_jmp_off(env->prog, 0, delta) assumes that the
> prologue does not have a goto 1st instruction itself.
> To accommodate the prologue might have a goto 1st insn itself,
> adjust_jmp_off() needs to skip the prologue instructions. This patch
> adds a skip_cnt argument to the adjust_jmp_off(). The skip_cnt is the
> number of instructions at the beginning that does not need adjustment.
> adjust_jmp_off(prog, 0, delta, delta) is used in this patch.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  kernel/bpf/verifier.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b408692a12d7..8714b83c5fb8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19277,14 +19277,14 @@ static struct bpf_prog *bpf_patch_insn_data(str=
uct bpf_verifier_env *env, u32 of
>   * For all jmp insns in a given 'prog' that point to 'tgt_idx' insn adju=
st the
>   * jump offset by 'delta'.
>   */
> -static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
> +static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta,=
 u32 skip_cnt)
>  {
> -       struct bpf_insn *insn =3D prog->insnsi;
> +       struct bpf_insn *insn =3D prog->insnsi + skip_cnt;
>         u32 insn_cnt =3D prog->len, i;
>         s32 imm;
>         s16 off;
>
> -       for (i =3D 0; i < insn_cnt; i++, insn++) {
> +       for (i =3D skip_cnt; i < insn_cnt; i++, insn++) {

Do we really need to add this argument?

> -               WARN_ON(adjust_jmp_off(env->prog, subprog_start, 1));
> +               WARN_ON(adjust_jmp_off(env->prog, subprog_start, 1, 0));

We can always do for (i =3D delta; ...

The above case of skip_cnt =3D=3D 0 is lucky to work this way.
It would be less surprising to skip all insns in the patch.
Maybe I'm missing something.

