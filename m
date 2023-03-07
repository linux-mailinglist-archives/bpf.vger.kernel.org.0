Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBBE6AFAA3
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 00:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCGXlb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 18:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjCGXl2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 18:41:28 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2128191B55
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 15:41:23 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o12so59041224edb.9
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 15:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678232481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEFr7E/wYqKWIVxDUdsQlBwqjxVQLQO/Z0maRYFibJc=;
        b=IMouCfLICPMbCh3iXV6pZO4aBSKBztu1dBaTThY+mEORDg+eB92pxbRHmCEjQT5QU8
         NAC8YxynngEB7PjkM66HbzOubz5sTXbZX2hv0SMlVS71kBbjEf6cXIwjWMOvpXXmct9L
         n0TeJQ/O+fI3an8SrNmUtUndQCofKd8AQE/oYjQpMJmOkJXCyDVwonRwaib7f3m4PNg2
         pbgc6xsIB9fwRFZt0bL2vFbHo/fPWIfkG6QC2TLdQcXHCZZpXWb6tgrsd+oV3rOo2v+8
         GRQTsv85b1ReKBaiYduDJOB3x+5175hd3ocF8Rqm7Bb7Nrk4KjP8IT2m9+VRQnG480iL
         CQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678232481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEFr7E/wYqKWIVxDUdsQlBwqjxVQLQO/Z0maRYFibJc=;
        b=2SiFWlFkc+NstOzoBv0f5uTnWkjKITKMk9VfQdrc3rZy77wNOlgdoIp+hY5Xvdx9fo
         ogdl+V8yD1zymmlOQ07B8OqZeoYk5VX3QUw1sJ/LIifw3hOD2KxuyjHmaeOvz4gUUCgp
         0VJHW7p41juq4WElQ7DGOF5IgXMvJOc1oYNzvsDDNSkxXFmOl1Fz5YOXO40pVpybflR2
         gURc5Eh4nzpZEq81JBsnK3kHvYPgXzfZbk7gUCv7fIcjKCmReXwrFlpseLyc8bT6aJ16
         LTGuWHHCei+5YZUYY8lMRbSfKsDi/SNeGoj45Dv360VBsbNTJ2//+ylUmSaEqsoT1LsI
         7IUg==
X-Gm-Message-State: AO0yUKVQYazzZEkQzyQwas5QONPCNILnIVlfu4UQYiFeY3cmJQqAew+0
        45epRdXTMf5VIFNj0bFB5MEndaXtrwHIqM5h4CU=
X-Google-Smtp-Source: AK7set8Jm7jFINOC79Gz/BuSgy4nStTzMxmZ4TRiwBV1Er6ckuEWx9Xo+b6Ebde1GZ43T9Ut3RXv+UATcVYzyRMNJzc=
X-Received: by 2002:a17:906:1643:b0:8af:4963:fb08 with SMTP id
 n3-20020a170906164300b008af4963fb08mr8196538ejd.15.1678232481531; Tue, 07 Mar
 2023 15:41:21 -0800 (PST)
MIME-Version: 1.0
References: <20230307120440.25941-1-puranjay12@gmail.com> <20230307120440.25941-3-puranjay12@gmail.com>
In-Reply-To: <20230307120440.25941-3-puranjay12@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 15:41:09 -0800
Message-ID: <CAEf4BzZ0N3t47VQBA7=6VC_6g677De1Dxs7QO6WjNZ3ak-dwSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] libbpf: usdt arm arg parsing support
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        bpf@vger.kernel.org, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 7, 2023 at 4:04=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.com=
> wrote:
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
> To test the above changes QEMU's virt[1] board with cortex-a15
> CPU was used. libbpf-bootstrap's usdt example[2] was modified to attach
> to a test program with DTRACE_PROBE1/2/3/4... probes to test different
> combinations.
>
> [1] https://www.qemu.org/docs/master/system/arm/virt.html
> [2] https://github.com/libbpf/libbpf-bootstrap/blob/master/examples/c/usd=
t.bpf.c
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  tools/lib/bpf/usdt.c | 80 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 293b7a37f8a1..27a4589eda1c 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -1466,6 +1466,86 @@ static int parse_usdt_arg(const char *arg_str, int=
 arg_num, struct usdt_arg_spec
>         return len;
>  }
>
> +#elif defined(__arm__)
> +
> +static int calc_pt_regs_off(const char *reg_name)
> +{
> +       static struct {
> +               const char *name;
> +               size_t pt_regs_off;
> +       } reg_map[] =3D {
> +               { "r0", offsetof(struct pt_regs, uregs[0]) },
> +               { "r1", offsetof(struct pt_regs, uregs[1]) },
> +               { "r2", offsetof(struct pt_regs, uregs[2]) },
> +               { "r3", offsetof(struct pt_regs, uregs[3]) },
> +               { "r4", offsetof(struct pt_regs, uregs[4]) },
> +               { "r5", offsetof(struct pt_regs, uregs[5]) },
> +               { "r6", offsetof(struct pt_regs, uregs[6]) },
> +               { "r7", offsetof(struct pt_regs, uregs[7]) },
> +               { "r8", offsetof(struct pt_regs, uregs[8]) },
> +               { "r9", offsetof(struct pt_regs, uregs[9]) },
> +               { "r10", offsetof(struct pt_regs, uregs[10]) },
> +               { "fp", offsetof(struct pt_regs, uregs[11]) },
> +               { "ip", offsetof(struct pt_regs, uregs[12]) },
> +               { "sp", offsetof(struct pt_regs, uregs[13]) },
> +               { "lr", offsetof(struct pt_regs, uregs[14]) },
> +               { "pc", offsetof(struct pt_regs, uregs[15]) },
> +       };
> +       int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(reg_map); i++) {
> +               if (strcmp(reg_name, reg_map[i].name) =3D=3D 0)
> +                       return reg_map[i].pt_regs_off;
> +       }
> +
> +       pr_warn("usdt: unrecognized register '%s'\n", reg_name);
> +       return -ENOENT;
> +}
> +
> +static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_=
arg_spec *arg, int *arg_sz)
> +{
> +       char reg_name[16];
> +       int len, reg_off;
> +       long off;
> +
> +       if (sscanf(arg_str, " %d @ \[ %15[a-z0-9], #%ld ] %n",

I've added space before , and applied to bpf-next.

Thanks, it's a nice clean up and wider architecture support!

BTW, I noticed that we don't support fp, ip, lr, and pc (only sp) for
__aarch64__, why such a difference between 32-bit and 64-bit arms?

> +                  arg_sz, reg_name, &off, &len) =3D=3D 3) {
> +               /* Memory dereference case, e.g., -4@[fp, #96] */
> +               arg->arg_type =3D USDT_ARG_REG_DEREF;
> +               arg->val_off =3D off;
> +               reg_off =3D calc_pt_regs_off(reg_name);
> +               if (reg_off < 0)
> +                       return reg_off;
> +               arg->reg_off =3D reg_off;
> +       } else if (sscanf(arg_str, " %d @ \[ %15[a-z0-9] ] %n", arg_sz, r=
eg_name, &len) =3D=3D 2) {
> +               /* Memory dereference case, e.g., -4@[sp] */
> +               arg->arg_type =3D USDT_ARG_REG_DEREF;
> +               arg->val_off =3D 0;
> +               reg_off =3D calc_pt_regs_off(reg_name);
> +               if (reg_off < 0)
> +                       return reg_off;
> +               arg->reg_off =3D reg_off;
> +       } else if (sscanf(arg_str, " %d @ #%ld %n", arg_sz, &off, &len) =
=3D=3D 2) {
> +               /* Constant value case, e.g., 4@#5 */
> +               arg->arg_type =3D USDT_ARG_CONST;
> +               arg->val_off =3D off;
> +               arg->reg_off =3D 0;
> +       } else if (sscanf(arg_str, " %d @ %15[a-z0-9] %n", arg_sz, reg_na=
me, &len) =3D=3D 2) {
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
> +       return len;
> +}
> +
>  #else
>
>  static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_=
arg_spec *arg, int *arg_sz)
> --
> 2.39.1
>
