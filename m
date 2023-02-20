Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E44869D5C5
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 22:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjBTV0W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 16:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBTV0W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 16:26:22 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AAF1C584
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 13:26:20 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id z5so2424167ljc.8
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 13:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eftBBJMaLJht7sZZ/B2LyH/rdPhG0H7uARwgSX+6M/U=;
        b=ALwc78N7cAS4nmzMEd7V3g+H82eCFJzaXWKWJeWknjnhSaHGt6mdcLQrq0ChYAKWP+
         oIAUzpIJ+Lf3G0cuKYtgeBaG6aj55GaZeIlL2Vr4t1I5/VlvQOM+jeBEirpoPJLabZSB
         oBDYBGJnp5g+Hfa1fntVg2rSFJUprbCS7f9vQUI6jEs6X36e4ZbyvcVPcxJopw8uvo/6
         23jF49pSNhlfAmBBMF3b4GOaKod4EeT+VJIXe9hO6NR/Martsyx+5ESM19iNdeOmQ++Z
         /IrS37kTRHOpl/zJ4/CYrnds/V4yGlsK/szV/+l6rXcvke2XlnW3nD0sEaquSJPXdXeL
         1v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eftBBJMaLJht7sZZ/B2LyH/rdPhG0H7uARwgSX+6M/U=;
        b=0wi88w4oCdmsC+SNCFwS7N/hGVkgKqn6WS35EGTpOqh7ujAX7bUpneqfsu1cIMmmRP
         4gna9cCBKp3R9R5+ePq2gybCOnf66PNYtkQ9jrO6oAEtXWwl2ZbPGoyNUHCs4GbJRlJL
         7qxrpOjV6A42T/9D1KGP/Dv2ZU1MfDRiSpfwqeh9JJKhBPDC92VIfK1jA+CpBSY1RFV8
         2cQrs5IFeatBITErKp86A9i63Vr8IBxKNMdQMxyi5DwsGjPoyJeaoRsaGuDEO1JXhB9p
         GzE60JTZsRYzSEgXd4cvOSU5IKO4t+nKgAW8FmWY4rlSDqTgilRN+pjhXVoxy9OEBh88
         QeUQ==
X-Gm-Message-State: AO0yUKU/YjvdFk7HG2S5sW7rwfdxbTGNNaCoINTjg4SAWbbTWE/+RgHL
        wsVch72I5cvMc893Ffc8LWOxN4vislelIe8L8dQ=
X-Google-Smtp-Source: AK7set+IThC5R4icbwapi5YUB2w0Tp0x+ecomPJlrbUkQdIsaWIQ6l16yjYzXZfvPBS3+tKzNd4p3rN1C4upce4mHFk=
X-Received: by 2002:a2e:a268:0:b0:293:505c:28da with SMTP id
 k8-20020a2ea268000000b00293505c28damr1050114ljm.10.1676928378619; Mon, 20 Feb
 2023 13:26:18 -0800 (PST)
MIME-Version: 1.0
References: <20230220212233.13229-1-puranjay12@gmail.com>
In-Reply-To: <20230220212233.13229-1-puranjay12@gmail.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Mon, 20 Feb 2023 22:26:06 +0100
Message-ID: <CANk7y0hF4O8dCrFgoUnt3c1-spwYA5TGR881QLQE9Jj-z+FqMg@mail.gmail.com>
Subject: Re: [PATCH] bbpf: usdt arm arg parsing support
To:     puranjaymohan@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org, iii@linux.ibm.com,
        quentin@isovalent.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 20, 2023 at 10:22 PM Puranjay Mohan <puranjay12@gmail.com> wrote:
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
>  tools/lib/bpf/usdt.c | 82 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 75b411fc2c77..ef097b882a4d 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -1505,6 +1505,88 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
>         return len;
>  }
>
> +#elif defined(__arm__)
> +
> +static int calc_pt_regs_off(const char *reg_name)
> +{
> +       int reg_num;
> +
> +       if (sscanf(reg_name, "r%d", &reg_num) == 1) {
> +               if (reg_num >= 0 && reg_num <= 10)
> +                       return offsetof(struct pt_regs, uregs[reg_num]);
> +       } else if (strcmp(reg_name, "fp") == 0) {
> +               return offsetof(struct pt_regs, ARM_fp);
> +       } else if (strcmp(reg_name, "ip") == 0) {
> +               return offsetof(struct pt_regs, ARM_ip);
> +       } else if (strcmp(reg_name, "sp") == 0) {
> +               return offsetof(struct pt_regs, ARM_sp);
> +       } else if (strcmp(reg_name, "lr") == 0) {
> +               return offsetof(struct pt_regs, ARM_lr);
> +       } else if (strcmp(reg_name, "pc") == 0) {
> +               return offsetof(struct pt_regs, ARM_pc);
> +       }
> +       pr_warn("usdt: unrecognized register '%s'\n", reg_name);
> +       return -ENOENT;
> +}
> +
> +static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
> +{
> +       char reg_name[16];
> +       int arg_sz, len, reg_off;
> +       long off;
> +
> +       if (sscanf(arg_str, " %d @ \[ %15[a-z0-9], #%ld ] %n", &arg_sz, reg_name,
> +                                                               &off, &len) == 3) {
> +               /* Memory dereference case, e.g., -4@[fp, #96] */
> +               arg->arg_type = USDT_ARG_REG_DEREF;
> +               arg->val_off = off;
> +               reg_off = calc_pt_regs_off(reg_name);
> +               if (reg_off < 0)
> +                       return reg_off;
> +               arg->reg_off = reg_off;
> +       } else if (sscanf(arg_str, " %d @ \[ %15[a-z0-9] ] %n", &arg_sz, reg_name, &len) == 2) {
> +               /* Memory dereference case, e.g., -4@[sp] */
> +               arg->arg_type = USDT_ARG_REG_DEREF;
> +               arg->val_off = 0;
> +               reg_off = calc_pt_regs_off(reg_name);
> +               if (reg_off < 0)
> +                       return reg_off;
> +               arg->reg_off = reg_off;
> +       } else if (sscanf(arg_str, " %d @ #%ld %n", &arg_sz, &off, &len) == 2) {
> +               /* Constant value case, e.g., 4@#5 */
> +               arg->arg_type = USDT_ARG_CONST;
> +               arg->val_off = off;
> +               arg->reg_off = 0;
> +       } else if (sscanf(arg_str, " %d @ %15[a-z0-9] %n", &arg_sz, reg_name, &len) == 2) {
> +               /* Register read case, e.g., -8@r4 */
> +               arg->arg_type = USDT_ARG_REG;
> +               arg->val_off = 0;
> +               reg_off = calc_pt_regs_off(reg_name);
> +               if (reg_off < 0)
> +                       return reg_off;
> +               arg->reg_off = reg_off;
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
>  #else
>
>  static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
> --
> 2.39.1
>

Will send again with a fixed subject string.


-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
