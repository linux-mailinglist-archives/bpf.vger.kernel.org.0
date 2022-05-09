Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6403C5207E2
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 00:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiEIWlm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 18:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiEIWll (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 18:41:41 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9001FE1CC
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 15:37:45 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i22so10288224ila.1
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 15:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QwlPube6EoIFmwvdjmjP1etQpKQn6B3CAfjL6plHCRU=;
        b=LVEGZHMO1gPD+nNye+OKdqGFey5JCjIsEHmt2Ie5SgnC4BV+mC8g2Qv6uzKa+7ruQ4
         lVB7SPURUcrPe9aTgLDy9zrOA4C8CBIcN8JMPM2Av1HnyfvYHakBubaNcs3IL4XHAIa6
         sN1ckR4Gg+GVVkSYGWdRkyUwfO7QsdeQIwbrK+5bkNwLA2i/2E6X4h2l6WTzJbrmB9xi
         yAl3wrJ/SqW4eG5pVI4AedkrcOmfs07HwFtmb0bu4/y7iHCDYYd0hVgcBL5GSKiMx74I
         ccy1xfij38q2ljPrjSF1Sh2sAwP3OaDjk531Qznq9wf+FqATDoavYSjSRCOLE73gcGOl
         WQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QwlPube6EoIFmwvdjmjP1etQpKQn6B3CAfjL6plHCRU=;
        b=2eqfwBBeFwSeUKisIbBDcmFstdjgY0+/7jFr+6FEXS+Xy7vwzN5djzzbEWNMWzD3Ni
         QKfBgEksja3az/wPoDuai9Cu3Utx63YSUi+HHcBP1/zqznLWp3y2wudbzs887HKsa72i
         hrRxzszmb9RYV+uTLJ2qdQMbBpx8v5gsn8jUW++Vu4JJcPP3LFMZkSfMqVQ04Aqy+lFJ
         5uLIvG8maaB34Y1vGd74SYm2GOwnKTaxCsUL4Osn+3l1UeNBHBGoh1J730VJCaUioBKw
         upWQIhxCuqxW3B6/RuT0TKDv40JdYJAmKvXrvLcaxWpK06ueQVD20ksNU69b5Zdbt4GH
         CE8g==
X-Gm-Message-State: AOAM533EP1cbnArpiU7T5C1xjB2q+2HFEsqVnX2WE+C2uWNTBt3exzgM
        sPVfq+zKDtgxKo5Vt1AYuRTJgweuEceYWg8C6m8yvmh5
X-Google-Smtp-Source: ABdhPJw8huLfQu7IkiGUb/o0YdsIi6Kr+9sp4SPl3pgK/uc9196WAtSOioF0yPc7DNjEjbuEa+zPU8JatuvqwFYQfR8=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr7740372ilb.305.1652135864944; Mon, 09
 May 2022 15:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220501190002.2576452-1-yhs@fb.com> <20220501190012.2577087-1-yhs@fb.com>
In-Reply-To: <20220501190012.2577087-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 15:37:33 -0700
Message-ID: <CAEf4BzYyUUjVYEcDJ75DWyg4HoOm4YbFSy84OY01WgENdWrh8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/12] libbpf: Permit 64bit relocation value
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
>
> Currently, the libbpf limits the relocation value to be 32bit
> since all current relocations have such a limit. But with
> BTF_KIND_ENUM64 support, the enum value could be 64bit.
> So let us permit 64bit relocation value in libbpf.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/relo_core.c | 24 ++++++++++++------------
>  tools/lib/bpf/relo_core.h |  4 ++--
>  2 files changed, 14 insertions(+), 14 deletions(-)
>

[...]

> @@ -929,7 +929,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>                         int insn_idx, const struct bpf_core_relo *relo,
>                         int relo_idx, const struct bpf_core_relo_res *res)
>  {
> -       __u32 orig_val, new_val;
> +       __u64 orig_val, new_val;
>         __u8 class;
>
>         class = BPF_CLASS(insn->code);
> @@ -954,14 +954,14 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>                 if (BPF_SRC(insn->code) != BPF_K)
>                         return -EINVAL;
>                 if (res->validate && insn->imm != orig_val) {
> -                       pr_warn("prog '%s': relo #%d: unexpected insn #%d (ALU/ALU64) value: got %u, exp %u -> %u\n",
> +                       pr_warn("prog '%s': relo #%d: unexpected insn #%d (ALU/ALU64) value: got %u, exp %llu -> %llu\n",
>                                 prog_name, relo_idx,
>                                 insn_idx, insn->imm, orig_val, new_val);

%llu is not valid formatter for __u64 on all architectures, please add
explicit (unsigned long long) cast

but also in general for non-ldimm64 instructions we need to check that
new value fits in 32 bits

[...]

> @@ -1026,7 +1026,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>
>                 imm = insn[0].imm + ((__u64)insn[1].imm << 32);
>                 if (res->validate && imm != orig_val) {
> -                       pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDIMM64) value: got %llu, exp %u -> %u\n",
> +                       pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDIMM64) value: got %llu, exp %llu -> %llu\n",
>                                 prog_name, relo_idx,
>                                 insn_idx, (unsigned long long)imm,
>                                 orig_val, new_val);
> @@ -1035,7 +1035,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>
>                 insn[0].imm = new_val;
>                 insn[1].imm = 0; /* currently only 32-bit values are supported */

as Dave mentioned, not anymore, so this should take higher 32-bit of new_val


> -               pr_debug("prog '%s': relo #%d: patched insn #%d (LDIMM64) imm64 %llu -> %u\n",
> +               pr_debug("prog '%s': relo #%d: patched insn #%d (LDIMM64) imm64 %llu -> %llu\n",
>                          prog_name, relo_idx, insn_idx,
>                          (unsigned long long)imm, new_val);
>                 break;
> @@ -1261,7 +1261,7 @@ int bpf_core_calc_relo_insn(const char *prog_name,
>                          * decision and value, otherwise it's dangerous to
>                          * proceed due to ambiguity
>                          */
> -                       pr_warn("prog '%s': relo #%d: relocation decision ambiguity: %s %u != %s %u\n",
> +                       pr_warn("prog '%s': relo #%d: relocation decision ambiguity: %s %llu != %s %llu\n",
>                                 prog_name, relo_idx,
>                                 cand_res.poison ? "failure" : "success", cand_res.new_val,
>                                 targ_res->poison ? "failure" : "success", targ_res->new_val);
> diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
> index 073039d8ca4f..7df0da082f2c 100644
> --- a/tools/lib/bpf/relo_core.h
> +++ b/tools/lib/bpf/relo_core.h
> @@ -46,9 +46,9 @@ struct bpf_core_spec {
>
>  struct bpf_core_relo_res {
>         /* expected value in the instruction, unless validate == false */
> -       __u32 orig_val;
> +       __u64 orig_val;
>         /* new value that needs to be patched up to */
> -       __u32 new_val;
> +       __u64 new_val;
>         /* relocation unsuccessful, poison instruction, but don't fail load */
>         bool poison;
>         /* some relocations can't be validated against orig_val */
> --
> 2.30.2
>
