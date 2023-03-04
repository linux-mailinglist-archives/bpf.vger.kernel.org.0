Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D1F6AA7FD
	for <lists+bpf@lfdr.de>; Sat,  4 Mar 2023 05:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjCDEWp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 23:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCDEWo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 23:22:44 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2CA18AAE
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 20:22:42 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a25so18253965edb.0
        for <bpf@vger.kernel.org>; Fri, 03 Mar 2023 20:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677903761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyRZRjIx8Qtqpo/S6dwgznNRHMB/WUf8NsWSPR07kQk=;
        b=FyNP/MhG2KqlU2OdWYANGW83nvxPvVEoh5g4fun2oG3WmBUZj0UueQBh41oM3DM2rv
         owhCjoneLtwLSoO7gLGknLLkVF54bY6dLNAkNVhX4bA3m7R2dCKwGyzaRexq4YE50SBa
         moKiWqDHEgpfuRIllZdpYl2vn5So3HrnMAwBl5NzSPXT8aY4vF6lWPIAhlCJdJA7maUV
         8jVqWkm4hElOsGXPIbmaZMqMVPlkj8UrIcn1bK02VvDKW0ptnuGQZ5EYWzIUc4NK4Dsj
         S+JunqPYtq5BbupMLgnUiVH71U6D8u0EAznmRShk07Enm0401BWgp/446GfzdlLi56IJ
         +Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677903761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyRZRjIx8Qtqpo/S6dwgznNRHMB/WUf8NsWSPR07kQk=;
        b=2n6ATwcGKts0IhtYI1iLwqY/Phogt5n6O3i3YJm/Z9xUd5+OyE5XEJlqcszgO+sqmp
         4AmZquJbI6q5245Db/dumiLtpl+Yam8m38K8hrhzyuBkpIphoBc6+UM3PCQqe6uCDk6S
         kwfyvjN8FGBCXj5RB2w8tU9DLtI0DwDaCAGgezM3c5Vz4nCIRBxg2/7v+KjFuczgnHsG
         XlG0J+GHsVkeXcCvhU1ZR0SEiDYlTDfx87g6sgfYC/VJhlH7TmjFlDgSNTAssiWzNdkD
         I1P9yns+To3TDJw7XNtMC5YzcRpvxg69mxFSVRJwtiqUJ9FcdAsEZjtRsQ8OKo7Nomkk
         OQaA==
X-Gm-Message-State: AO0yUKVlvQZKB/vjESGXQWSCsImlj/KP8fmgJGWn6nHcZeytgWKRRClA
        PJuchX000VAcKB12yWmF/2pekoRgMMuoKBLogTc=
X-Google-Smtp-Source: AK7set8A4CP3vnOvU62q26xJZpXy3w9eh5m+WV8JqDgrQTP6xcY5qUmnFfbdFAxR80CP+YG4eVcwZXLUvmYUT58IGZU=
X-Received: by 2002:a17:907:33c1:b0:8b0:fbd5:2145 with SMTP id
 zk1-20020a17090733c100b008b0fbd52145mr1952145ejb.15.1677903761039; Fri, 03
 Mar 2023 20:22:41 -0800 (PST)
MIME-Version: 1.0
References: <20230303083706.3597-1-puranjay12@gmail.com>
In-Reply-To: <20230303083706.3597-1-puranjay12@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 3 Mar 2023 20:22:29 -0800
Message-ID: <CAEf4BzYKokYubGxMS=CchDVVhxLbGwUmCptJQ9U6CQ0LYc0HkA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: usdt arm arg parsing support
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        bpf@vger.kernel.org, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 3, 2023 at 12:37=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> Parsing of USDT arguments is architecture-specific; on arm it is
> relatively easy since registers used are r[0-10], fp, ip, sp, lr,
> pc. Format is slightly different compared to aarch64; forms are
>
> - "size @ [ reg, #offset ]" for dereferences, for example
>   "-8 @ [ sp, #76 ]" ; " -4 @ [ sp ]"
> - "size @ reg" for register values; for example
>   "-4@r0"
> - "size @ #value" for raw values; for example
>   "-8@#1"
>
> Add support for parsing USDT arguments for ARM architecture.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---

You don't mention that in the commit message, but how did you test
these changes?

> Changes in V1[1] to V2
> - Resending as V1 shows up as Superseded in patchwork.
>
> [1] https://patchwork.kernel.org/project/netdevbpf/patch/20230220212741.1=
3515-1-puranjay12@gmail.com/
> ---
>  tools/lib/bpf/usdt.c | 82 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 75b411fc2c77..ef097b882a4d 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -1505,6 +1505,88 @@ static int parse_usdt_arg(const char *arg_str, int=
 arg_num, struct usdt_arg_spec
>         return len;
>  }
>
> +#elif defined(__arm__)
> +
> +static int calc_pt_regs_off(const char *reg_name)
> +{
> +       int reg_num;
> +
> +       if (sscanf(reg_name, "r%d", &reg_num) =3D=3D 1) {
> +               if (reg_num >=3D 0 && reg_num <=3D 10)
> +                       return offsetof(struct pt_regs, uregs[reg_num]);
> +       } else if (strcmp(reg_name, "fp") =3D=3D 0) {
> +               return offsetof(struct pt_regs, ARM_fp);
> +       } else if (strcmp(reg_name, "ip") =3D=3D 0) {
> +               return offsetof(struct pt_regs, ARM_ip);
> +       } else if (strcmp(reg_name, "sp") =3D=3D 0) {
> +               return offsetof(struct pt_regs, ARM_sp);
> +       } else if (strcmp(reg_name, "lr") =3D=3D 0) {
> +               return offsetof(struct pt_regs, ARM_lr);
> +       } else if (strcmp(reg_name, "pc") =3D=3D 0) {
> +               return offsetof(struct pt_regs, ARM_pc);
> +       }
> +       pr_warn("usdt: unrecognized register '%s'\n", reg_name);
> +       return -ENOENT;
> +}
> +

let's use a more tabular approach, just like, say, riscv does?

> +static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_=
arg_spec *arg)
> +{
> +       char reg_name[16];
> +       int arg_sz, len, reg_off;
> +       long off;
> +
> +       if (sscanf(arg_str, " %d @ \[ %15[a-z0-9], #%ld ] %n", &arg_sz, r=
eg_name,
> +                                                               &off, &le=
n) =3D=3D 3) {

if long function call is wrapped, argument on new line should be
aligned with the first argument on previous line. I'd suggest wrapping
right after format string, and start with &arg_sz aligned with arg_str

> +               /* Memory dereference case, e.g., -4@[fp, #96] */
> +               arg->arg_type =3D USDT_ARG_REG_DEREF;
> +               arg->val_off =3D off;
> +               reg_off =3D calc_pt_regs_off(reg_name);
> +               if (reg_off < 0)
> +                       return reg_off;
> +               arg->reg_off =3D reg_off;
> +       } else if (sscanf(arg_str, " %d @ \[ %15[a-z0-9] ] %n", &arg_sz, =
reg_name, &len) =3D=3D 2) {
> +               /* Memory dereference case, e.g., -4@[sp] */
> +               arg->arg_type =3D USDT_ARG_REG_DEREF;
> +               arg->val_off =3D 0;
> +               reg_off =3D calc_pt_regs_off(reg_name);
> +               if (reg_off < 0)
> +                       return reg_off;
> +               arg->reg_off =3D reg_off;
> +       } else if (sscanf(arg_str, " %d @ #%ld %n", &arg_sz, &off, &len) =
=3D=3D 2) {

is the '#<num>' value always in decimal or it could be hex sometimes?

> +               /* Constant value case, e.g., 4@#5 */
> +               arg->arg_type =3D USDT_ARG_CONST;
> +               arg->val_off =3D off;
> +               arg->reg_off =3D 0;
> +       } else if (sscanf(arg_str, " %d @ %15[a-z0-9] %n", &arg_sz, reg_n=
ame, &len) =3D=3D 2) {
> +               /* Register read case, e.g., -8@r4 */
> +               arg->arg_type =3D USDT_ARG_REG;
> +               arg->val_off =3D 0;
> +               reg_off =3D calc_pt_regs_off(reg_name);
> +               if (reg_off < 0)
> +                       return reg_off;
> +               arg->reg_off =3D reg_off;
> +       } else {
> +               pr_warn("usdt: unrecognized arg #%d spec '%s'\n", arg_num=
, arg_str);
> +               return -EINVAL;
> +       }
> +
> +       arg->arg_signed =3D arg_sz < 0;
> +       if (arg_sz < 0)
> +               arg_sz =3D -arg_sz;
> +
> +       switch (arg_sz) {
> +       case 1: case 2: case 4: case 8:
> +               arg->arg_bitshift =3D 64 - arg_sz * 8;
> +               break;
> +       default:
> +               pr_warn("usdt: unsupported arg #%d (spec '%s') size: %d\n=
",
> +                       arg_num, arg_str, arg_sz);
> +               return -EINVAL;
> +       }

This part is repeated verbatim for each architecture, perhaps it's
better to do this post-processing and checking in parse_usdt_spec().
Would you mind adding another patch to your series that refactors
parse_usdt_arg() implementation to fill out struct usdt_arg_spec and
return arg_sz as out parameter. And then parse_usdt_spec() will check
arg_sz, set arg_signed and arg_bitshift parts?

> +
> +       return len;
> +}
> +
>  #else
>
>  static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_=
arg_spec *arg)
> --
> 2.39.1
>
