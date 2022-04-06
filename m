Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCA04F6A84
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 21:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiDFTyh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 15:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbiDFTxt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 15:53:49 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A74D269A76
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 10:23:39 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id r11so2422683ila.1
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 10:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gE7Ga79qWwEBvc16Of582X+cA59raEi7RH56zIEc1Jg=;
        b=exAZOWKSf2RqV4cfCIVwbzg/bovqaMqbJq9hMtIg8Q2ouSFL0f91kHuwGa/hPy4ruZ
         VUqXEyWIYCEDBkOR6FlWxKmsTnXWFmbSOK0gsShstvnulDaAFDjKwfXMfF/4IDzhGOqM
         ylPsOVpCYZ3ThrJzY4JSoF4JntAgIV1gF5vv4q+kR507z17K4DaGREMNloBaneZomvuE
         FDAwxikQ/5DQv8aj8+flurCs3HINOxs8YgSzhrCQIjME+2NaM0MzEbzfWKlySmBr/Zc/
         IuzZgs/OF90lYc1dEaXsnGumDVfmVkTdFOFq37Krnz8HVOVrM26RYQYLz5eAIh5CZ+db
         t4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gE7Ga79qWwEBvc16Of582X+cA59raEi7RH56zIEc1Jg=;
        b=Z20yemLTsk3hW11N3j6CQZlyzWW4i12EWs80ObC2ZRqJdztiC2ZWRWDMAAMorFK6ge
         VJfOHBjDXLkcXenm9Ok0vRB8sVEroDO5/v4hGQMha73Sm0Auj7GKm4EcMFts2uvhNy6X
         CrgN/5cSErU9WwLvCCY1vthgTNQ80n5joihdXehdyvEE51IZzZRfVKhTikhJT8mjdhLX
         yFSNu9HWa4VmEpcwwSKIq9S33KIb7rmAIyDbYXgh5j9T77f0ebc0+svktyYYZiQvnJfo
         Je55oFJwPk4ilZ7/nxPwoqSxZWmhuQE4vGbVu+UK7HiQ4A+DjActqresdPPQnGd4p8xt
         tAVA==
X-Gm-Message-State: AOAM532U4rwY1l0D1zPNpZ9dmA77zuS3CBV2q5HT2D0VPs0uMEd4C89y
        dslJTMxdSlJC4Wh6jHLsWoKa4lQVLamiAWTtQGs=
X-Google-Smtp-Source: ABdhPJzQsfFKCw64uwoH89zx1t1Egm53i57ekcrMnJhUXKLfvDCTsVnZUrJhRet+z+DyUWnqkK1KaP+yJ3XNoanBHYg=
X-Received: by 2002:a05:6e02:1a8f:b0:2c9:da3d:e970 with SMTP id
 k15-20020a056e021a8f00b002c9da3de970mr4635196ilv.239.1649265818647; Wed, 06
 Apr 2022 10:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220404234202.331384-1-andrii@kernel.org> <20220404234202.331384-6-andrii@kernel.org>
In-Reply-To: <20220404234202.331384-6-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Apr 2022 10:23:27 -0700
Message-ID: <CAEf4BzbETp3S4-HebGBNjFm1fCCAuytSqTp=SNXgXFSqsgCQOQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 5/7] libbpf: add x86-specific USDT arg spec
 parsing logic
To:     Andrii Nakryiko <andrii@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
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

On Mon, Apr 4, 2022 at 4:42 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Add x86/x86_64-specific USDT argument specification parsing. Each
> architecture will require their own logic, as all this is arch-specific
> assembly-based notation. Architectures that libbpf doesn't support for
> USDTs will pr_warn() with specific error and return -ENOTSUP.
>
> We use sscanf() as a very powerful and easy to use string parser. Those
> spaces in sscanf's format string mean "skip any whitespaces", which is
> pretty nifty (and somewhat little known) feature.
>
> All this was tested on little-endian architecture, so bit shifts are
> probably off on big-endian, which our CI will hopefully prove.
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Reviewed-by: Dave Marchevsky <davemarchevsky@fb.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Ilya, would you be interested in implementing at least some limited
support of USDT parameters for s390x? It would be good to have
big-endian platform supported and tested. aarch64 would be nice as
well, but I'm not sure who's the expert on that to help with.

>  tools/lib/bpf/usdt.c | 105 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 2799387c5465..1bce2eab5e89 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -1168,8 +1168,113 @@ static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note,
>         return 0;
>  }
>
> +/* Architecture-specific logic for parsing USDT argument location specs */
> +
> +#if defined(__x86_64__) || defined(__i386__)
> +
> +static int calc_pt_regs_off(const char *reg_name)
> +{
> +       static struct {
> +               const char *names[4];
> +               size_t pt_regs_off;
> +       } reg_map[] = {
> +#if __x86_64__
> +#define reg_off(reg64, reg32) offsetof(struct pt_regs, reg64)
> +#else
> +#define reg_off(reg64, reg32) offsetof(struct pt_regs, reg32)
> +#endif
> +               { {"rip", "eip", "", ""}, reg_off(rip, eip) },
> +               { {"rax", "eax", "ax", "al"}, reg_off(rax, eax) },
> +               { {"rbx", "ebx", "bx", "bl"}, reg_off(rbx, ebx) },
> +               { {"rcx", "ecx", "cx", "cl"}, reg_off(rcx, ecx) },
> +               { {"rdx", "edx", "dx", "dl"}, reg_off(rdx, edx) },
> +               { {"rsi", "esi", "si", "sil"}, reg_off(rsi, esi) },
> +               { {"rdi", "edi", "di", "dil"}, reg_off(rdi, edi) },
> +               { {"rbp", "ebp", "bp", "bpl"}, reg_off(rbp, ebp) },
> +               { {"rsp", "esp", "sp", "spl"}, reg_off(rsp, esp) },
> +#undef reg_off
> +#if __x86_64__
> +               { {"r8", "r8d", "r8w", "r8b"}, offsetof(struct pt_regs, r8) },
> +               { {"r9", "r9d", "r9w", "r9b"}, offsetof(struct pt_regs, r9) },
> +               { {"r10", "r10d", "r10w", "r10b"}, offsetof(struct pt_regs, r10) },
> +               { {"r11", "r11d", "r11w", "r11b"}, offsetof(struct pt_regs, r11) },
> +               { {"r12", "r12d", "r12w", "r12b"}, offsetof(struct pt_regs, r12) },
> +               { {"r13", "r13d", "r13w", "r13b"}, offsetof(struct pt_regs, r13) },
> +               { {"r14", "r14d", "r14w", "r14b"}, offsetof(struct pt_regs, r14) },
> +               { {"r15", "r15d", "r15w", "r15b"}, offsetof(struct pt_regs, r15) },
> +#endif
> +       };
> +       int i, j;
> +
> +       for (i = 0; i < ARRAY_SIZE(reg_map); i++) {
> +               for (j = 0; j < ARRAY_SIZE(reg_map[i].names); j++) {
> +                       if (strcmp(reg_name, reg_map[i].names[j]) == 0)
> +                               return reg_map[i].pt_regs_off;
> +               }
> +       }
> +
> +       pr_warn("usdt: unrecognized register '%s'\n", reg_name);
> +       return -ENOENT;
> +}
> +
> +static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
> +{
> +       char *reg_name = NULL;
> +       int arg_sz, len, reg_off;
> +       long off;
> +
> +       if (sscanf(arg_str, " %d @ %ld ( %%%m[^)] ) %n", &arg_sz, &off, &reg_name, &len) == 3) {
> +               /* Memory dereference case, e.g., -4@-20(%rbp) */
> +               arg->arg_type = USDT_ARG_REG_DEREF;
> +               arg->val_off = off;
> +               reg_off = calc_pt_regs_off(reg_name);
> +               free(reg_name);
> +               if (reg_off < 0)
> +                       return reg_off;
> +               arg->reg_off = reg_off;
> +       } else if (sscanf(arg_str, " %d @ %%%ms %n", &arg_sz, &reg_name, &len) == 2) {
> +               /* Register read case, e.g., -4@%eax */
> +               arg->arg_type = USDT_ARG_REG;
> +               arg->val_off = 0;
> +
> +               reg_off = calc_pt_regs_off(reg_name);
> +               free(reg_name);
> +               if (reg_off < 0)
> +                       return reg_off;
> +               arg->reg_off = reg_off;
> +       } else if (sscanf(arg_str, " %d @ $%ld %n", &arg_sz, &off, &len) == 2) {
> +               /* Constant value case, e.g., 4@$71 */
> +               arg->arg_type = USDT_ARG_CONST;
> +               arg->val_off = off;
> +               arg->reg_off = 0;
> +       } else {
> +               pr_warn("usdt: unrecognized arg #%d spec '%s'\n", arg_num, arg_str);
> +               return -EINVAL;
> +       }
> +
> +       arg->arg_signed = arg_sz < 0;
> +       if (arg_sz < 0)
> +               arg_sz = -arg_sz;
> +
> +       switch (arg_sz) {
> +       case 1: case 2: case 4: case 8:
> +               arg->arg_bitshift = 64 - arg_sz * 8;
> +               break;
> +       default:
> +               pr_warn("usdt: unsupported arg #%d (spec '%s') size: %d\n",
> +                       arg_num, arg_str, arg_sz);
> +               return -EINVAL;
> +       }
> +
> +       return len;
> +}
> +
> +#else
> +
>  static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
>  {
>         pr_warn("usdt: libbpf doesn't support USDTs on current architecture\n");
>         return -ENOTSUP;
>  }
> +
> +#endif
> --
> 2.30.2
>
