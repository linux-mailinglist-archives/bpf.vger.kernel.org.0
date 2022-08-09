Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912CB58DCB8
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 19:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244959AbiHIRD3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 13:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244597AbiHIRDF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 13:03:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE7323F
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 10:03:03 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id qn6so11492227ejc.11
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mRHykDDdPXEUKTN7X42YKosL9BoN0z+JwMR33KtE41o=;
        b=autCxdIthMzjmwJynR6r0SAues+TAnIw0UHcHPsRH8/LC9WIuafiIQgU/+n3MasMxY
         dIH30for1ZY7ydg4P0TgNvgQXOghCLxOgUKvBbvtL0IiTYTdDkpx30FpDWwGiWfVhknS
         gMeENh+TwOzFvEU6FAQuTxWCSwJSS/uWPkAAJ05N18dIGLoY+oHF2gIZ/92g71VdcsOa
         YZYiLbW5RuA5ImICiIe/ZIbhiy/Tl0R0KAdm58Gwtn+agFxA3AF+frTORUoogaR4oi4b
         3fl89nYl+EbDoddq4AsZgCOrkLejYmxzdxhuMZmHlQGZeZGl0hNYMJ69qmevapXZK87v
         PfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mRHykDDdPXEUKTN7X42YKosL9BoN0z+JwMR33KtE41o=;
        b=taN3+HqBGytXdQVYDjqcNw3Fo7qERY1KVlxhD8zPVEgVkvN1pLGPRlfWoCNamCPOAw
         EBvPVp6ffT1O06hnp9NNrde1sTcKVJBY7PfYxce3Tk32yakqauZ528TqvlHxHQ3FkW7C
         qXc9ucJWb/IETD8zgSpz9jGl2UAO7G65dbjFhsKdjm2TAWPD7Aru1736YrzpjRJkoAqA
         wPfFYdRuFiB/yBf+vD9F8fw94Zlp9YwvNnRYHRt4nRCyfJnirmTSbjYSNMuE1stIy41X
         yx4ldBpUELy0lOIy7tWs8L6Qb9FKo7/7kEFS+ToO1Ajz1evHM+6DcXGuAYjLSfRyC6E5
         xvlA==
X-Gm-Message-State: ACgBeo0YZ7Lh3JnsgawryRrHAoXUv/pktXTpcYjMhKWPXXLCaZw2QiSp
        zkdDWUZcUP8wxStUJUe9FqeN0wrUqONKLur+dC4FC7XM
X-Google-Smtp-Source: AA6agR76UOjVxFPiI+lyiY4BXo3aPyAVfZZ5ibBDoaVuyTYJkhy+0BmycSv5O6e/H16kzVj/Q+aMGH3yknl0DVOt+ao=
X-Received: by 2002:a17:906:ef90:b0:730:9cd8:56d7 with SMTP id
 ze16-20020a170906ef9000b007309cd856d7mr16695025ejb.94.1660064581738; Tue, 09
 Aug 2022 10:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220807175111.4178812-1-yhs@fb.com> <20220807175121.4179410-1-yhs@fb.com>
In-Reply-To: <20220807175121.4179410-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Aug 2022 10:02:50 -0700
Message-ID: <CAADnVQK__BPkmgsjuLmBxZ3a=kDTA_cGR8oWLCvjLVDYYW6hfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Perform necessary sign/zero extension
 for kfunc return values
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
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

On Sun, Aug 7, 2022 at 10:51 AM Yonghong Song <yhs@fb.com> wrote:
>
> Tejun reported a bpf program kfunc return value mis-handling which
> may cause incorrect result. The following is an example to show
> the problem.
>   $ cat t.c
>   unsigned char bar();
>   int foo() {
>         if (bar() != 10) return 0; else return 1;
>   }
>   $ clang -target bpf -O2 -c t.c
>   $ llvm-objdump -d t.o
>   ...
>   0000000000000000 <foo>:
>        0:       85 10 00 00 ff ff ff ff call -1
>        1:       bf 01 00 00 00 00 00 00 r1 = r0
>        2:       b7 00 00 00 01 00 00 00 r0 = 1
>        3:       15 01 01 00 0a 00 00 00 if r1 == 10 goto +1 <LBB0_2>
>        4:       b7 00 00 00 00 00 00 00 r0 = 0
>
>   0000000000000028 <LBB0_2>:
>        5:       95 00 00 00 00 00 00 00 exit
>   $
>
> In the above example, the return type for bar() is 'unsigned char'.
> But in the disassembly code, the whole register 'r1' is used to
> compare to 10 without truncating upper 56 bits.
>
> If function bar() is implemented as a bpf function, everything
> should be okay since bpf ABI will make sure the caller do
> proper truncation of upper 56 bits.
>
> But if function bar() is implemented as a non-bpf kfunc,
> there could a mismatch between bar() implementation and bpf program.
> For example, if the host arch is x86_64, the bar() function
> may just put the return value in lower 8-bit subregister and all
> upper 56 bits could contain garbage. This is not a problem
> if bar() is called in x86_64 context as the caller will use
> %al to get the value.
>
> But this could be a problem if bar() is called in bpf context
> and there is a mismatch expectation between bpf and native architecture.
> Currently, bpf programs use the default llvm ABI ([1], function
> isPromotableIntegerTypeForABI()) such that if an integer type size
> is less than int type size, it is assumed proper sign or zero
> extension has been done to the return value. There will be a problem
> if the kfunc return value type is u8/s8/u16/s16.
>
> This patch intends to address this issue by doing proper sign or zero
> extension for the kfunc return value before it is used later.
>
>  [1] https://github.com/llvm/llvm-project/blob/main/clang/lib/CodeGen/TargetInfo.cpp
>
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf.h   |  2 ++
>  kernel/bpf/btf.c      |  9 +++++++++
>  kernel/bpf/verifier.c | 35 +++++++++++++++++++++++++++++++++--
>  3 files changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 20c26aed7896..b6f6bb1b707d 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -727,6 +727,8 @@ enum bpf_cgroup_storage_type {
>  #define MAX_BPF_FUNC_REG_ARGS 5
>
>  struct btf_func_model {
> +       u8 ret_integer:1;
> +       u8 ret_integer_signed:1;
>         u8 ret_size;
>         u8 nr_args;
>         u8 arg_size[MAX_BPF_FUNC_ARGS];
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 8119dc3994db..f30a02018701 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5897,6 +5897,7 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
>         u32 i, nargs;
>         int ret;
>
> +       m->ret_integer = false;
>         if (!func) {
>                 /* BTF function prototype doesn't match the verifier types.
>                  * Fall back to MAX_BPF_FUNC_REG_ARGS u64 args.
> @@ -5923,6 +5924,14 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
>                 return -EINVAL;
>         }
>         m->ret_size = ret;
> +       if (btf_type_is_int(t)) {
> +               m->ret_integer = true;
> +               /* BTF_INT_BOOL is considered as unsigned */
> +               if (BTF_INT_ENCODING(btf_type_int(t)) == BTF_INT_SIGNED)
> +                       m->ret_integer_signed = true;
> +               else
> +                       m->ret_integer_signed = false;
> +       }
>
>         for (i = 0; i < nargs; i++) {
>                 if (i == nargs - 1 && args[i].type == 0) {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 096fdac70165..684f8606f341 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13834,8 +13834,9 @@ static int fixup_call_args(struct bpf_verifier_env *env)
>  }
>
>  static int fixup_kfunc_call(struct bpf_verifier_env *env,
> -                           struct bpf_insn *insn)
> +                           struct bpf_insn *insn, struct bpf_insn *insn_buf, int *cnt)
>  {
> +       u8 ret_size, shift_cnt, rshift_opcode;
>         const struct bpf_kfunc_desc *desc;
>
>         if (!insn->imm) {
> @@ -13855,6 +13856,26 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env,
>
>         insn->imm = desc->imm;
>
> +       *cnt = 0;
> +       ret_size = desc->func_model.ret_size;
> +
> +       /* If the kfunc return type is an integer and the type size is one byte or two
> +        * bytes, currently llvm/bpf assumes proper sign/zero extension has been done
> +        * in the caller. But such an asumption may not hold for non-bpf architectures.
> +        * For example, for x86_64, if the return type is 'u8', it is possible that only
> +        * %al register is set properly and upper 56 bits of %rax register may contain
> +        * garbage. To resolve this case, Let us do a necessary truncation to zero-out
> +        * or properly sign-extend upper 56 bits.
> +        */
> +       if (desc->func_model.ret_integer && ret_size < sizeof(int)) {

Few questions...
Do we really need 'ret_integer' here?
and is it x86 specific?
afaik only x86 has 8 and 16-bit subregisters.
On all other archs the hw cannot write such quantities into
a register and don't touch the upper bits.
At the same time such return values from kfunc are rare.
I don't think we have such a case in the current set of kfuncs.
So being safe than sorry is a reasonable trade off and
gating by x86 only is unnecessary.
So how about just if (ret_size < sizeof(int)) here?

> +               shift_cnt = (sizeof(u64) - ret_size) * 8;
> +               rshift_opcode = desc->func_model.ret_integer_signed ? BPF_ARSH : BPF_RSH;
> +               insn_buf[0] = *insn;
> +               insn_buf[1] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, shift_cnt);
> +               insn_buf[2] = BPF_ALU64_IMM(rshift_opcode, BPF_REG_0, shift_cnt);
> +               *cnt = 3;
> +       }
> +
>         return 0;
>  }
>
> @@ -13996,9 +14017,19 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>                 if (insn->src_reg == BPF_PSEUDO_CALL)
>                         continue;
>                 if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
> -                       ret = fixup_kfunc_call(env, insn);
> +                       ret = fixup_kfunc_call(env, insn, insn_buf, &cnt);
>                         if (ret)
>                                 return ret;
> +                       if (cnt == 0)
> +                               continue;
> +
> +                       new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +                       if (!new_prog)
> +                               return -ENOMEM;
> +
> +                       delta    += cnt - 1;
> +                       env->prog = prog = new_prog;
> +                       insn      = new_prog->insnsi + i + delta;
>                         continue;
>                 }
>
> --
> 2.30.2
>
