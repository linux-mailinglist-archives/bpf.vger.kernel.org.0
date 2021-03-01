Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC53327CC4
	for <lists+bpf@lfdr.de>; Mon,  1 Mar 2021 12:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhCALDZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Mar 2021 06:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbhCALCz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Mar 2021 06:02:55 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC270C06174A
        for <bpf@vger.kernel.org>; Mon,  1 Mar 2021 03:02:14 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id f20so17220193ioo.10
        for <bpf@vger.kernel.org>; Mon, 01 Mar 2021 03:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwaYxYCc7fPCb8K/VvzfQuPMuYxIusoHE/J+Wmt3ZPM=;
        b=Uys4If7/4GK/t4XvhK3ih7pCIKuTxjv01bx7pUgKsd6NcLWaRJ1qrxyGbeGZ9ICqta
         ekoD9kg5zZv4Ex5mzx0hnjfX4w0BT6EvCik39MgewfPCaCszBhHnQmofuX2j9nL3vWU+
         pqzNRMueXsjr2rwulWSLhTLJCOQhX33He01Wto0SQjNFZsY+PkRJV/8+nYEFyEdi2Jnv
         mbMXvNMjhlY5m+cY/gEjGGz4M2W6Edn+VNJcy0ucWdG3m+ynDEY4uB4AoNNB0KaAGBBY
         uhoy90zg3tRTPbrMaPEwSOAVPzvBm5TG/r+QtlDDlXrUddyJtF+H1vBq8Wtaiart71cf
         obpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwaYxYCc7fPCb8K/VvzfQuPMuYxIusoHE/J+Wmt3ZPM=;
        b=RMvmVqHfSf4m9QR1mhB5u8+NfTSVYm6ecNydQfKaptzlyanWBAAs4jhn9jB+h8inMk
         81pwtDaAeUdcNROzx/woLYxi4JHwO0B1vWdpXGtiJ80ISB8rOO5W7F1+F/drHw9eNsSf
         tnMLjW+QP27OpKwbuFJyPJJRUz4VHHRHj0T7kMq3xcutvV+HbqfuJGiW8znodqYhYnDY
         bVwUUBtBCLFR3sFZMYkhJYesLjimpFScEFtJSIy6DTUR81virIRy5sRWkdAXBuD8HDMo
         AQgH7+ayo5jR8dXWb7aLkXMqu2p8qQ/5DOUWqr+DiUIU8n5ooJ5NrXdkZJzCT3ApKblI
         q/Qg==
X-Gm-Message-State: AOAM5324rbtpeuArEVXAqPe579AndYQUpr95TKK8bNajC85XRdakYdea
        ou+BnC+rGGaYvxI5k0vkkKUqwiMUVyhxvYRQZiI0bg==
X-Google-Smtp-Source: ABdhPJz3MfsOjaJpEXKkAaSKsiPaOCYYxNZLErPMqHLH7EEX6X6IlEfz3otJ0c8F+g4aHIJFnsS+H3PuX1JBE1QZpvg=
X-Received: by 2002:a6b:ea08:: with SMTP id m8mr12816032ioc.194.1614596533660;
 Mon, 01 Mar 2021 03:02:13 -0800 (PST)
MIME-Version: 1.0
References: <20210226213131.118173-1-iii@linux.ibm.com>
In-Reply-To: <20210226213131.118173-1-iii@linux.ibm.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Mon, 1 Mar 2021 12:02:02 +0100
Message-ID: <CA+i-1C1DxO+dvmCRWTLhD-XUiCFji=r7LwSgb7yHC5iLneLk9w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] bpf: Account for BPF_FETCH in insn_has_def32()
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, sorry it's been almost a week since I responded - I think I need
to adjust my sense of urgency for this stuff.

On Fri, 26 Feb 2021 at 22:31, Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> insn_has_def32() returns false for 32-bit BPF_FETCH insns. This makes
> adjust_insn_aux_data() incorrectly set zext_dst, as can be seen in [1].
> This happens because insn_no_def() does not know about the BPF_FETCH
> variants of BPF_STX.
>
> Fix in two steps.
>
> First, replace insn_no_def() with insn_def_regno(), which returns the
> register an insn defines. Normally insn_no_def() calls are followed by
> insn->dst_reg uses; replace those with the insn_def_regno() return
> value.
>
> Second, adjust the BPF_STX special case in is_reg64() to deal with
> queries made from opt_subreg_zext_lo32_rnd_hi32(), where the state
> information is no longer available. Add a comment, since the purpose
> of this special case is not clear at first glance.
>
> [1] https://lore.kernel.org/bpf/20210223150845.1857620-1-jackmanb@google.com/
>
> Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>
> v1: https://lore.kernel.org/bpf/20210224141837.104654-1-iii@linux.ibm.com/
> v1 -> v2: Per Martin's comments: rebase against the bpf branch, fix the
>           Fixes: tag, fix the comment style, replace ?: with the more
>           readable if-else, handle the internal verifier error using
>           WARN_ON_ONCE(), verbose() and -EFAULT.
>
>  kernel/bpf/verifier.c | 70 ++++++++++++++++++++++++-------------------
>  1 file changed, 39 insertions(+), 31 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3d34ba492d46..4730d5628b02 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1703,7 +1703,11 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
>         }
>
>         if (class == BPF_STX) {
> -               if (reg->type != SCALAR_VALUE)
> +               /* BPF_STX (including atomic variants) has multiple source
> +                * operands, one of which is a ptr. Check whether the caller is
> +                * asking about it.
> +                */
> +               if (t == SRC_OP && reg->type != SCALAR_VALUE)
>                         return true;
>                 return BPF_SIZE(code) == BPF_DW;
>         }
> @@ -1735,22 +1739,38 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
>         return true;
>  }
>
> -/* Return TRUE if INSN doesn't have explicit value define. */
> -static bool insn_no_def(struct bpf_insn *insn)
> +/* Return the regno defined by the insn, or -1. */
> +static int insn_def_regno(const struct bpf_insn *insn)
>  {
> -       u8 class = BPF_CLASS(insn->code);
> -
> -       return (class == BPF_JMP || class == BPF_JMP32 ||
> -               class == BPF_STX || class == BPF_ST);
> +       switch (BPF_CLASS(insn->code)) {
> +       case BPF_JMP:
> +       case BPF_JMP32:
> +       case BPF_ST:
> +               return -1;
> +       case BPF_STX:
> +               if (BPF_MODE(insn->code) == BPF_ATOMIC &&
> +                   (insn->imm & BPF_FETCH)) {
> +                       if (insn->imm == BPF_CMPXCHG)
> +                               return BPF_REG_0;
> +                       else
> +                               return insn->src_reg;
> +               } else {
> +                       return -1;
> +               }
> +       default:
> +               return insn->dst_reg;
> +       }
>  }
>
>  /* Return TRUE if INSN has defined any 32-bit value explicitly. */
>  static bool insn_has_def32(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  {
> -       if (insn_no_def(insn))
> +       int dst_reg = insn_def_regno(insn);
> +
> +       if (dst_reg == -1)
>                 return false;
>
> -       return !is_reg64(env, insn, insn->dst_reg, NULL, DST_OP);
> +       return !is_reg64(env, insn, dst_reg, NULL, DST_OP);
>  }
>
>  static void mark_insn_zext(struct bpf_verifier_env *env,
> @@ -11006,9 +11026,10 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>         for (i = 0; i < len; i++) {
>                 int adj_idx = i + delta;
>                 struct bpf_insn insn;
> -               u8 load_reg;
> +               int load_reg;
>
>                 insn = insns[adj_idx];
> +               load_reg = insn_def_regno(&insn);

Nit: Might as well save a line by squashing this into the declaration.

>                 if (!aux[adj_idx].zext_dst) {
>                         u8 code, class;
>                         u32 imm_rnd;
> @@ -11018,14 +11039,14 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>
>                         code = insn.code;
>                         class = BPF_CLASS(code);
> -                       if (insn_no_def(&insn))
> +                       if (load_reg == -1)
>                                 continue;
>
>                         /* NOTE: arg "reg" (the fourth one) is only used for
> -                        *       BPF_STX which has been ruled out in above
> -                        *       check, it is safe to pass NULL here.
> +                        *       BPF_STX + SRC_OP, so it is safe to pass NULL
> +                        *       here.
>                          */
> -                       if (is_reg64(env, &insn, insn.dst_reg, NULL, DST_OP)) {
> +                       if (is_reg64(env, &insn, load_reg, NULL, DST_OP)) {
>                                 if (class == BPF_LD &&
>                                     BPF_MODE(code) == BPF_IMM)
>                                         i++;
> @@ -11040,7 +11061,7 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>                         imm_rnd = get_random_int();
>                         rnd_hi32_patch[0] = insn;
>                         rnd_hi32_patch[1].imm = imm_rnd;
> -                       rnd_hi32_patch[3].dst_reg = insn.dst_reg;
> +                       rnd_hi32_patch[3].dst_reg = load_reg;
>                         patch = rnd_hi32_patch;
>                         patch_len = 4;
>                         goto apply_patch_buffer;
> @@ -11049,22 +11070,9 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>                 if (!bpf_jit_needs_zext())
>                         continue;
>
> -               /* zext_dst means that we want to zero-extend whatever register
> -                * the insn defines, which is dst_reg most of the time, with
> -                * the notable exception of BPF_STX + BPF_ATOMIC + BPF_FETCH.
> -                */
> -               if (BPF_CLASS(insn.code) == BPF_STX &&
> -                   BPF_MODE(insn.code) == BPF_ATOMIC) {
> -                       /* BPF_STX + BPF_ATOMIC insns without BPF_FETCH do not
> -                        * define any registers, therefore zext_dst cannot be
> -                        * set.
> -                        */
> -                       if (WARN_ON(!(insn.imm & BPF_FETCH)))
> -                               return -EINVAL;
> -                       load_reg = insn.imm == BPF_CMPXCHG ? BPF_REG_0
> -                                                          : insn.src_reg;
> -               } else {
> -                       load_reg = insn.dst_reg;
> +               if (WARN_ON_ONCE(load_reg == -1)) {
> +                       verbose(env, "zext_dst is set, but no reg is defined\n");

Let's add the string "verifier bug." to the beginning of this message
(this is done elsewhere too). Hopefully the only person that ever sees
this message would be someone who's hacking on the verifier, but even
for them it could be a significant time-saver.

> +                       return -EFAULT;
>                 }
>
>                 zext_patch[0] = insn;
> --
> 2.29.2

Overall LGTM, thanks. It seems like without this patch, the cmpxchg
test I added in [1] should fail on the s390 JIT, and this patch should
fix it. Is that correct? If so could you add the test to this patch?
(I guess you ought to paste in my Signed-off-by)

[1] https://lore.kernel.org/bpf/44d680a0c40fc9dddf1b2bf4e78bd75b76dc4061.camel@linux.ibm.com/T/#mf6546406db03c6ca473a29cdf3bde7ddeeedf1a1
