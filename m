Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8B86AFE0E
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 06:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjCHFCE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 00:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCHFCD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 00:02:03 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13154A3343
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 21:02:02 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id a32so15403677ljr.9
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 21:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678251720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pqxlruv5nrIKoZY4qAU0vIilCuxKmBRmGMZ+tvVpapA=;
        b=fHgIYARpBxAvjJBAQtWwSP5SrmarcAhYkOc6VXY1nA2dKG3eCGqdeUuTzt7EvWigjY
         MmotdGp84yD3YvEco0i7H/AEDlemfHVMHWE4zCO4Tv+IP3QZdXkBrgVOwvXkfDJWgr+G
         u3LIGccwdZrJizuYMti8VJPSQzbevb62I082OqKtnAUfN18qGLXz+4+RNZ5kDXtqaMsM
         aXeMIcbZS9NyQ27bWX7R+j23DgggLcA3CTGyE/rZ+fRYP6OBAJJTBdD3KNrHRY8RXSiT
         1zBzCpu/GqXYb8jfRa0FrGSevtdJmktLXPztNj8pzctKNBd1IQFPsX1TOxEcwNCzkWBW
         jp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678251720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pqxlruv5nrIKoZY4qAU0vIilCuxKmBRmGMZ+tvVpapA=;
        b=a9Ka/DstRLoCb8MsqlbSgtnfctUvzXquFqpk1GZjk3dj77E18lDH20tzW6qUbXi1m9
         XLuZog2YBLydZWWPokDAQe2tBHnoHe6jPlGMKQ/l6YNqm+4M4K3Nt4ty01f92bO6FJ8A
         Srl/ncf9oZ877wQZu9SeyhP8DWuVjba3sZ6OomKxej2E3wpnk48HxgKIvo6chhw108E+
         8nfNipLo7uWYvfj9yUaOC2pXO6J2bPeEi58ybK4Adq5EUELnp92H4eWOSuXbORsjwieq
         eFQU6JHMmxLn/PaqqSms7VAhEpN7P8KJPL31S+C2WrEnpdseQ2xUtwu6FlhN++YIjCYa
         TjFg==
X-Gm-Message-State: AO0yUKV4uLXsvpUkHFsU4jARHVjoSPTsgDESeUJl5kBHPh5mVwKcfGIU
        xwi/kCK8hMTAjkNnOdUF1iFI/gX1hspme7pEitejzrRJsMhx0/0D7q8=
X-Google-Smtp-Source: AK7set9I1d8uRyVioFJRPbBmDSk2LsLZpUi9iKBm8nSBLDlxufxRPQbiebfj7bIAz5PHgMwVdY3HJGnm8hST24QHolU=
X-Received: by 2002:a05:651c:11cb:b0:295:b2f0:a857 with SMTP id
 z11-20020a05651c11cb00b00295b2f0a857mr5190255ljo.10.1678251720012; Tue, 07
 Mar 2023 21:02:00 -0800 (PST)
MIME-Version: 1.0
References: <20230307120440.25941-1-puranjay12@gmail.com> <20230307120440.25941-3-puranjay12@gmail.com>
 <CAEf4BzZ0N3t47VQBA7=6VC_6g677De1Dxs7QO6WjNZ3ak-dwSA@mail.gmail.com>
In-Reply-To: <CAEf4BzZ0N3t47VQBA7=6VC_6g677De1Dxs7QO6WjNZ3ak-dwSA@mail.gmail.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Wed, 8 Mar 2023 06:01:48 +0100
Message-ID: <CANk7y0j_aGN6Z4UHPO31_sRO6BwAdocu-+w=coCrqSjcRS23Kw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] libbpf: usdt arm arg parsing support
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        bpf@vger.kernel.org, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
Thanks for applying the series.

On Wed, Mar 8, 2023 at 12:41=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Mar 7, 2023 at 4:04=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.c=
om> wrote:
> >
> > Parsing of USDT arguments is architecture-specific; on arm it is
> > relatively easy since registers used are r[0-10], fp, ip, sp, lr,
> > pc. Format is slightly different compared to aarch64; forms are
> >
> > - "size @ [ reg, #offset ]" for dereferences, for example
> >   "-8 @ [ sp, #76 ]" ; " -4 @ [ sp ]"
> > - "size @ reg" for register values; for example
> >   "-4@r0"
> > - "size @ #value" for raw values; for example
> >   "-8@#1"
> >
> > Add support for parsing USDT arguments for ARM architecture.
> >
> > To test the above changes QEMU's virt[1] board with cortex-a15
> > CPU was used. libbpf-bootstrap's usdt example[2] was modified to attach
> > to a test program with DTRACE_PROBE1/2/3/4... probes to test different
> > combinations.
> >
> > [1] https://www.qemu.org/docs/master/system/arm/virt.html
> > [2] https://github.com/libbpf/libbpf-bootstrap/blob/master/examples/c/u=
sdt.bpf.c
> >
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > ---
> >  tools/lib/bpf/usdt.c | 80 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >
> > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > index 293b7a37f8a1..27a4589eda1c 100644
> > --- a/tools/lib/bpf/usdt.c
> > +++ b/tools/lib/bpf/usdt.c
> > @@ -1466,6 +1466,86 @@ static int parse_usdt_arg(const char *arg_str, i=
nt arg_num, struct usdt_arg_spec
> >         return len;
> >  }
> >
> > +#elif defined(__arm__)
> > +
> > +static int calc_pt_regs_off(const char *reg_name)
> > +{
> > +       static struct {
> > +               const char *name;
> > +               size_t pt_regs_off;
> > +       } reg_map[] =3D {
> > +               { "r0", offsetof(struct pt_regs, uregs[0]) },
> > +               { "r1", offsetof(struct pt_regs, uregs[1]) },
> > +               { "r2", offsetof(struct pt_regs, uregs[2]) },
> > +               { "r3", offsetof(struct pt_regs, uregs[3]) },
> > +               { "r4", offsetof(struct pt_regs, uregs[4]) },
> > +               { "r5", offsetof(struct pt_regs, uregs[5]) },
> > +               { "r6", offsetof(struct pt_regs, uregs[6]) },
> > +               { "r7", offsetof(struct pt_regs, uregs[7]) },
> > +               { "r8", offsetof(struct pt_regs, uregs[8]) },
> > +               { "r9", offsetof(struct pt_regs, uregs[9]) },
> > +               { "r10", offsetof(struct pt_regs, uregs[10]) },
> > +               { "fp", offsetof(struct pt_regs, uregs[11]) },
> > +               { "ip", offsetof(struct pt_regs, uregs[12]) },
> > +               { "sp", offsetof(struct pt_regs, uregs[13]) },
> > +               { "lr", offsetof(struct pt_regs, uregs[14]) },
> > +               { "pc", offsetof(struct pt_regs, uregs[15]) },
> > +       };
> > +       int i;
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(reg_map); i++) {
> > +               if (strcmp(reg_name, reg_map[i].name) =3D=3D 0)
> > +                       return reg_map[i].pt_regs_off;
> > +       }
> > +
> > +       pr_warn("usdt: unrecognized register '%s'\n", reg_name);
> > +       return -ENOENT;
> > +}
> > +
> > +static int parse_usdt_arg(const char *arg_str, int arg_num, struct usd=
t_arg_spec *arg, int *arg_sz)
> > +{
> > +       char reg_name[16];
> > +       int len, reg_off;
> > +       long off;
> > +
> > +       if (sscanf(arg_str, " %d @ \[ %15[a-z0-9], #%ld ] %n",
>
> I've added space before , and applied to bpf-next.
>
> Thanks, it's a nice clean up and wider architecture support!
>
> BTW, I noticed that we don't support fp, ip, lr, and pc (only sp) for
> __aarch64__, why such a difference between 32-bit and 64-bit arms?

Actually, it is just a naming convention.
in AARCH64 R29 is FP and R30 is LR, etc. so, they are decoded with
that. Only SP is seperate.
in ARM the register names are explicitly named.

For ARM: https://github.com/ARM-software/abi-aa/blob/main/aapcs32/aapcs32.r=
st#machine-registers
For AARCH64: https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs=
64.rst#machine-registers

P.S.: For adding more BPF features for ARM, I feel the following
things are remaining:
1. Adding CI for ARM:
- Can you give me the steps needed to do this?
2. Implement BPF trampoline for ARM.
- This should be a little complicated and might need other dependent
features that might not be available in arm.
3.???

>
> > +                  arg_sz, reg_name, &off, &len) =3D=3D 3) {
> > +               /* Memory dereference case, e.g., -4@[fp, #96] */
> > +               arg->arg_type =3D USDT_ARG_REG_DEREF;
> > +               arg->val_off =3D off;
> > +               reg_off =3D calc_pt_regs_off(reg_name);
> > +               if (reg_off < 0)
> > +                       return reg_off;
> > +               arg->reg_off =3D reg_off;
> > +       } else if (sscanf(arg_str, " %d @ \[ %15[a-z0-9] ] %n", arg_sz,=
 reg_name, &len) =3D=3D 2) {
> > +               /* Memory dereference case, e.g., -4@[sp] */
> > +               arg->arg_type =3D USDT_ARG_REG_DEREF;
> > +               arg->val_off =3D 0;
> > +               reg_off =3D calc_pt_regs_off(reg_name);
> > +               if (reg_off < 0)
> > +                       return reg_off;
> > +               arg->reg_off =3D reg_off;
> > +       } else if (sscanf(arg_str, " %d @ #%ld %n", arg_sz, &off, &len)=
 =3D=3D 2) {
> > +               /* Constant value case, e.g., 4@#5 */
> > +               arg->arg_type =3D USDT_ARG_CONST;
> > +               arg->val_off =3D off;
> > +               arg->reg_off =3D 0;
> > +       } else if (sscanf(arg_str, " %d @ %15[a-z0-9] %n", arg_sz, reg_=
name, &len) =3D=3D 2) {
> > +               /* Register read case, e.g., -8@r4 */
> > +               arg->arg_type =3D USDT_ARG_REG;
> > +               arg->val_off =3D 0;
> > +               reg_off =3D calc_pt_regs_off(reg_name);
> > +               if (reg_off < 0)
> > +                       return reg_off;
> > +               arg->reg_off =3D reg_off;
> > +       } else {
> > +               pr_warn("usdt: unrecognized arg #%d spec '%s'\n", arg_n=
um, arg_str);
> > +               return -EINVAL;
> > +       }
> > +
> > +       return len;
> > +}
> > +
> >  #else
> >
> >  static int parse_usdt_arg(const char *arg_str, int arg_num, struct usd=
t_arg_spec *arg, int *arg_sz)
> > --
> > 2.39.1
> >



--=20
Thanks and Regards

Yours Truly,

Puranjay Mohan
