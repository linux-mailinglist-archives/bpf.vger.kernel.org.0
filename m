Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A5B6B1013
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 18:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjCHRSA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 12:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjCHRRk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 12:17:40 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0DDCCE9C
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 09:16:05 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cy23so68471647edb.12
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 09:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678295736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnGXLPiTeT4RKuUj/SIzOApTPW5nLaqBfR3teSbyWh0=;
        b=dbHPsAkiFqqBufllvcBa4q7WLU3UwsqiKPq9pzYmTl24HU8aqtUlNpgUBq1sqsnwcQ
         PvNO2S93zmUUclZYCLG+89PAygRcO9lcXYI/0c54tmBXrBqAJDX2bl7Y0Jx5waBKPpsI
         c+HbUWs44Ru+XwDzGIZJf3eVDxRJilU4kceZI1qnB23FF0ruFbtZnjx/PlkDtD3xz+VO
         gAW3Hwc0rwuWbJoS4hYUzQ5vtKYxD4DRBrNhlIROPeGhWzfCkLjBtr91q9lyfV341PDV
         TbFmQydf3ipZeLYNaBygDgwTnwjjmkjfgGiugc7zot/oJVt5kOqlIIcgbOY6n2Byhg2C
         RyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678295736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnGXLPiTeT4RKuUj/SIzOApTPW5nLaqBfR3teSbyWh0=;
        b=7w+kOqp7EkE0ytKHc9+RmF48TsiaCr07E3ihrEGPXfeH/0/vsXW1KgSAoM5mGvHQBy
         OOYWU4JnL2oYynf9BY+Hm7zbhr/BWPVJksUm/gEQSoSr2wrbVJYSI5bgs+iKli/8FRrM
         gfLimBJ99ng0fHgi9NHtoCSPjK07ejbJDGIckDLLLTGpt+V9crSjdZ+h0K4XLvM8L/OY
         72TNaVcEH68Yo3Yb4sznygYPbcJ+VU5UlO207/RAi/ZG1BG2hsWEq8GG26L5eTR9x9Ut
         m2yQiH6XJpf05yyEsj5k+4awacUlvJIW3dKYIO9uYiViJygYwPcPkSB5DCcT3i9Yp/7m
         3ABg==
X-Gm-Message-State: AO0yUKV+eEmaaE9oTR8lR1xMnp2aQC5Ooq0pjm6uzNOhDVkE+8ymB2YI
        jYux21TdWrOXPP+7IVULEdXZC3lqnS8TGpGFRGs=
X-Google-Smtp-Source: AK7set/LHnBV90l7EMx5p4niwZph933qTVkQZWxwFRLCJS3sBtXhEaTiO2rrCia9OSGann6CmW3Nm2WQV+PMWS1zt6Q=
X-Received: by 2002:a50:d4c5:0:b0:4c0:71e6:9dc5 with SMTP id
 e5-20020a50d4c5000000b004c071e69dc5mr3364796edj.1.1678295735900; Wed, 08 Mar
 2023 09:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20230307120440.25941-1-puranjay12@gmail.com> <20230307120440.25941-3-puranjay12@gmail.com>
 <CAEf4BzZ0N3t47VQBA7=6VC_6g677De1Dxs7QO6WjNZ3ak-dwSA@mail.gmail.com> <CANk7y0j_aGN6Z4UHPO31_sRO6BwAdocu-+w=coCrqSjcRS23Kw@mail.gmail.com>
In-Reply-To: <CANk7y0j_aGN6Z4UHPO31_sRO6BwAdocu-+w=coCrqSjcRS23Kw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Mar 2023 09:15:23 -0800
Message-ID: <CAEf4BzZFY75uyLtxZZL_WZUfXPrOWz602pE=ZgrvFm1XxTowbw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] libbpf: usdt arm arg parsing support
To:     Puranjay Mohan <puranjay12@gmail.com>,
        Manu Bretelle <chantr4@gmail.com>,
        =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
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

On Tue, Mar 7, 2023 at 9:02=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.com=
> wrote:
>
> Hi,
> Thanks for applying the series.
>
> On Wed, Mar 8, 2023 at 12:41=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Mar 7, 2023 at 4:04=E2=80=AFAM Puranjay Mohan <puranjay12@gmail=
.com> wrote:
> > >
> > > Parsing of USDT arguments is architecture-specific; on arm it is
> > > relatively easy since registers used are r[0-10], fp, ip, sp, lr,
> > > pc. Format is slightly different compared to aarch64; forms are
> > >
> > > - "size @ [ reg, #offset ]" for dereferences, for example
> > >   "-8 @ [ sp, #76 ]" ; " -4 @ [ sp ]"
> > > - "size @ reg" for register values; for example
> > >   "-4@r0"
> > > - "size @ #value" for raw values; for example
> > >   "-8@#1"
> > >
> > > Add support for parsing USDT arguments for ARM architecture.
> > >
> > > To test the above changes QEMU's virt[1] board with cortex-a15
> > > CPU was used. libbpf-bootstrap's usdt example[2] was modified to atta=
ch
> > > to a test program with DTRACE_PROBE1/2/3/4... probes to test differen=
t
> > > combinations.
> > >
> > > [1] https://www.qemu.org/docs/master/system/arm/virt.html
> > > [2] https://github.com/libbpf/libbpf-bootstrap/blob/master/examples/c=
/usdt.bpf.c
> > >
> > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > > ---
> > >  tools/lib/bpf/usdt.c | 80 ++++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 80 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > > index 293b7a37f8a1..27a4589eda1c 100644
> > > --- a/tools/lib/bpf/usdt.c
> > > +++ b/tools/lib/bpf/usdt.c
> > > @@ -1466,6 +1466,86 @@ static int parse_usdt_arg(const char *arg_str,=
 int arg_num, struct usdt_arg_spec
> > >         return len;
> > >  }
> > >
> > > +#elif defined(__arm__)
> > > +
> > > +static int calc_pt_regs_off(const char *reg_name)
> > > +{
> > > +       static struct {
> > > +               const char *name;
> > > +               size_t pt_regs_off;
> > > +       } reg_map[] =3D {
> > > +               { "r0", offsetof(struct pt_regs, uregs[0]) },
> > > +               { "r1", offsetof(struct pt_regs, uregs[1]) },
> > > +               { "r2", offsetof(struct pt_regs, uregs[2]) },
> > > +               { "r3", offsetof(struct pt_regs, uregs[3]) },
> > > +               { "r4", offsetof(struct pt_regs, uregs[4]) },
> > > +               { "r5", offsetof(struct pt_regs, uregs[5]) },
> > > +               { "r6", offsetof(struct pt_regs, uregs[6]) },
> > > +               { "r7", offsetof(struct pt_regs, uregs[7]) },
> > > +               { "r8", offsetof(struct pt_regs, uregs[8]) },
> > > +               { "r9", offsetof(struct pt_regs, uregs[9]) },
> > > +               { "r10", offsetof(struct pt_regs, uregs[10]) },
> > > +               { "fp", offsetof(struct pt_regs, uregs[11]) },
> > > +               { "ip", offsetof(struct pt_regs, uregs[12]) },
> > > +               { "sp", offsetof(struct pt_regs, uregs[13]) },
> > > +               { "lr", offsetof(struct pt_regs, uregs[14]) },
> > > +               { "pc", offsetof(struct pt_regs, uregs[15]) },
> > > +       };
> > > +       int i;
> > > +
> > > +       for (i =3D 0; i < ARRAY_SIZE(reg_map); i++) {
> > > +               if (strcmp(reg_name, reg_map[i].name) =3D=3D 0)
> > > +                       return reg_map[i].pt_regs_off;
> > > +       }
> > > +
> > > +       pr_warn("usdt: unrecognized register '%s'\n", reg_name);
> > > +       return -ENOENT;
> > > +}
> > > +
> > > +static int parse_usdt_arg(const char *arg_str, int arg_num, struct u=
sdt_arg_spec *arg, int *arg_sz)
> > > +{
> > > +       char reg_name[16];
> > > +       int len, reg_off;
> > > +       long off;
> > > +
> > > +       if (sscanf(arg_str, " %d @ \[ %15[a-z0-9], #%ld ] %n",
> >
> > I've added space before , and applied to bpf-next.
> >
> > Thanks, it's a nice clean up and wider architecture support!
> >
> > BTW, I noticed that we don't support fp, ip, lr, and pc (only sp) for
> > __aarch64__, why such a difference between 32-bit and 64-bit arms?
>
> Actually, it is just a naming convention.
> in AARCH64 R29 is FP and R30 is LR, etc. so, they are decoded with
> that. Only SP is seperate.
> in ARM the register names are explicitly named.

ah, ok, makes sense, thanks for explaining!

>
> For ARM: https://github.com/ARM-software/abi-aa/blob/main/aapcs32/aapcs32=
.rst#machine-registers
> For AARCH64: https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aap=
cs64.rst#machine-registers
>
> P.S.: For adding more BPF features for ARM, I feel the following
> things are remaining:
> 1. Adding CI for ARM:
> - Can you give me the steps needed to do this?

I'm CC'ing Manu and Daniel, who are working on BPF CI. We are (mostly,
with the exception for s390x) using AWS to get runners on native
architecture. I'm not sure if AWS provides arm32 instances, so to
enable ARM32 in CI we'd need to resort to cross-compilation, probably.
But let's see if Manu and Daniel have specific suggestions.


> 2. Implement BPF trampoline for ARM.
> - This should be a little complicated and might need other dependent
> features that might not be available in arm.

trampoline for ARM makes sense. Not sure if anyone else is working on
this or not, so feel free to create a separate email thread to discuss
plans and details.


> 3.???

Assuming we have CI, there probably will be a bunch of clean up work
to make existing test work on 32-bit host architectures properly.


Also please see how much work it is to start supporting kfuncs for
arm32, see bpf_jit_supports_kfunc_call() and related infrastructure.
It should be a smaller undertaking compared to BPF trampoline.

>
> >
> > > +                  arg_sz, reg_name, &off, &len) =3D=3D 3) {
> > > +               /* Memory dereference case, e.g., -4@[fp, #96] */
> > > +               arg->arg_type =3D USDT_ARG_REG_DEREF;
> > > +               arg->val_off =3D off;
> > > +               reg_off =3D calc_pt_regs_off(reg_name);
> > > +               if (reg_off < 0)
> > > +                       return reg_off;
> > > +               arg->reg_off =3D reg_off;
> > > +       } else if (sscanf(arg_str, " %d @ \[ %15[a-z0-9] ] %n", arg_s=
z, reg_name, &len) =3D=3D 2) {
> > > +               /* Memory dereference case, e.g., -4@[sp] */
> > > +               arg->arg_type =3D USDT_ARG_REG_DEREF;
> > > +               arg->val_off =3D 0;
> > > +               reg_off =3D calc_pt_regs_off(reg_name);
> > > +               if (reg_off < 0)
> > > +                       return reg_off;
> > > +               arg->reg_off =3D reg_off;
> > > +       } else if (sscanf(arg_str, " %d @ #%ld %n", arg_sz, &off, &le=
n) =3D=3D 2) {
> > > +               /* Constant value case, e.g., 4@#5 */
> > > +               arg->arg_type =3D USDT_ARG_CONST;
> > > +               arg->val_off =3D off;
> > > +               arg->reg_off =3D 0;
> > > +       } else if (sscanf(arg_str, " %d @ %15[a-z0-9] %n", arg_sz, re=
g_name, &len) =3D=3D 2) {
> > > +               /* Register read case, e.g., -8@r4 */
> > > +               arg->arg_type =3D USDT_ARG_REG;
> > > +               arg->val_off =3D 0;
> > > +               reg_off =3D calc_pt_regs_off(reg_name);
> > > +               if (reg_off < 0)
> > > +                       return reg_off;
> > > +               arg->reg_off =3D reg_off;
> > > +       } else {
> > > +               pr_warn("usdt: unrecognized arg #%d spec '%s'\n", arg=
_num, arg_str);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       return len;
> > > +}
> > > +
> > >  #else
> > >
> > >  static int parse_usdt_arg(const char *arg_str, int arg_num, struct u=
sdt_arg_spec *arg, int *arg_sz)
> > > --
> > > 2.39.1
> > >
>
>
>
> --
> Thanks and Regards
>
> Yours Truly,
>
> Puranjay Mohan
