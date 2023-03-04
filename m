Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804A96AAD82
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 00:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCDXer (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Mar 2023 18:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDXeq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Mar 2023 18:34:46 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E18D505
        for <bpf@vger.kernel.org>; Sat,  4 Mar 2023 15:34:44 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id j11so4870755edq.4
        for <bpf@vger.kernel.org>; Sat, 04 Mar 2023 15:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677972883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oB1LuOI+9Zb5KhhdliB1LrKzrng5S0hdHZJyqafJLwY=;
        b=NKosBN9IdGB/n9PU+aAYcuccEfYI8u0NhEHDftY2CMDHUWNGaOA9wb4iXFQU63LSab
         OIrQ5fCnrVUa21ZrWtmqsEy5Rb5BReaJYz1Mf+xqzgFCcaV30nkr06vK2x5+ioA+iQaK
         G3xUQ34u+ITuT5PLK2t99x2hhF41z8kTaujXZAc8mWp8mnsRq2dIXxkb14WsP0Us1EKo
         nfZAokGuWpl5lUXRgGOzYgCNUYC2hKC7nyQAmllpC0IDa+OjmO9pz4XpiI3imVw0heUr
         jic8OQrtJSYwA2jcRLJY6556wEC80Cqa4hTiWQ6hwP5m60gGlbY9f541V5/QKuo1OOCb
         6ezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677972883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oB1LuOI+9Zb5KhhdliB1LrKzrng5S0hdHZJyqafJLwY=;
        b=Gl7snYJMMUgR0GIlCzTwPhNlcY6k+fww3Aux+D/FPrj0B7NKdw+EkbVH27sWj1Vsxn
         rvxvlQO7NlezyzdBOQHl1xelxHUqNAR9fH2RNyuNRWKLHRY9EWslXIggYGquF4sf3nto
         M+Gu4VRM8TegTcA1qT3QsU8braSkApYqUUBqF0EdONlZ3OnPD/aXB8BDrL5GwdExXuIS
         mmpkfjZezK9W9D4MYZ/7YcEsCVanZ4Z5UvF1LBcmJVf+Cz+xx/hCQS51DHTqReQkf6nb
         Zo+y0V8oXWz9U562gSZ0nXBYWEyD45476hBdhE7kpgCypYV9bFUe9wJHDbsSeoPX1Q9N
         4CfA==
X-Gm-Message-State: AO0yUKV28hpVNmrCSppAbMi3s6q+oFLjYFhTu+7/4VGnbEwjGBOHVC/d
        5Ev8bpxdj4RBxl5REtbPoxKMeEaCFPKrYUkJ1QI+LlrT
X-Google-Smtp-Source: AK7set/m3GnwIMA+Etra1HJERyzIxQMf1pVXZ/A1ITbX4IWvIJf3ztiHEqKoGZXAyIG8GN43pxSfeWIQh8bQ0Pnnw5A=
X-Received: by 2002:a17:907:33c1:b0:8b0:fbd5:2145 with SMTP id
 zk1-20020a17090733c100b008b0fbd52145mr2955695ejb.15.1677972882762; Sat, 04
 Mar 2023 15:34:42 -0800 (PST)
MIME-Version: 1.0
References: <20230303083706.3597-1-puranjay12@gmail.com> <CAEf4BzYKokYubGxMS=CchDVVhxLbGwUmCptJQ9U6CQ0LYc0HkA@mail.gmail.com>
 <CANk7y0hB5SoO-6=A0JL9hXaje74bJaK_-0rtywXALbkbtEKTfw@mail.gmail.com>
In-Reply-To: <CANk7y0hB5SoO-6=A0JL9hXaje74bJaK_-0rtywXALbkbtEKTfw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 4 Mar 2023 15:34:31 -0800
Message-ID: <CAEf4BzYejtKcJn53fn3zT-HSUCcbr4QD8XWRYC0_+O9E1BaLyg@mail.gmail.com>
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

On Sat, Mar 4, 2023 at 11:18=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> Hi Andrii,
>
> On Sat, Mar 4, 2023 at 9:52=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Mar 3, 2023 at 12:37=E2=80=AFAM Puranjay Mohan <puranjay12@gmai=
l.com> wrote:
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
> > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > > ---
> >
> > You don't mention that in the commit message, but how did you test
> > these changes?
>
> I use the  QEMU's virt[1] board with cortex-a15 CPU. I take the
> libbpf-bootstrap's usdt example[2] and
> modify it to attach it to my custom program with
> DTRACE_PROBE1/2/3/4... probes to test different combinations.
>

Nice, please mention that in the commit message. We don't have 32-bit
arm tests in CI, so explicitly mentioning manual testing is good to
have.

> >
> > > Changes in V1[1] to V2
> > > - Resending as V1 shows up as Superseded in patchwork.
> > >
> > > [1] https://patchwork.kernel.org/project/netdevbpf/patch/202302202127=
41.13515-1-puranjay12@gmail.com/
> > > ---
> > >  tools/lib/bpf/usdt.c | 82 ++++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 82 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > > index 75b411fc2c77..ef097b882a4d 100644
> > > --- a/tools/lib/bpf/usdt.c
> > > +++ b/tools/lib/bpf/usdt.c
> > > @@ -1505,6 +1505,88 @@ static int parse_usdt_arg(const char *arg_str,=
 int arg_num, struct usdt_arg_spec
> > >         return len;
> > >  }
> > >
> > > +#elif defined(__arm__)
> > > +
> > > +static int calc_pt_regs_off(const char *reg_name)
> > > +{
> > > +       int reg_num;
> > > +
> > > +       if (sscanf(reg_name, "r%d", &reg_num) =3D=3D 1) {
> > > +               if (reg_num >=3D 0 && reg_num <=3D 10)
> > > +                       return offsetof(struct pt_regs, uregs[reg_num=
]);
> > > +       } else if (strcmp(reg_name, "fp") =3D=3D 0) {
> > > +               return offsetof(struct pt_regs, ARM_fp);
> > > +       } else if (strcmp(reg_name, "ip") =3D=3D 0) {
> > > +               return offsetof(struct pt_regs, ARM_ip);
> > > +       } else if (strcmp(reg_name, "sp") =3D=3D 0) {
> > > +               return offsetof(struct pt_regs, ARM_sp);
> > > +       } else if (strcmp(reg_name, "lr") =3D=3D 0) {
> > > +               return offsetof(struct pt_regs, ARM_lr);
> > > +       } else if (strcmp(reg_name, "pc") =3D=3D 0) {
> > > +               return offsetof(struct pt_regs, ARM_pc);
> > > +       }
> > > +       pr_warn("usdt: unrecognized register '%s'\n", reg_name);
> > > +       return -ENOENT;
> > > +}
> > > +
> >
> > let's use a more tabular approach, just like, say, riscv does?
>
> As R0-R10 directly map to uregs[0->10], I used sscanf for that, and as
> there are only five named registers
> (FP, IP, SP, LR, PC), I thought that using if-else would be good
> enough. But I can change it if it is necessary.
>

let's go with a table approach, it's consistent with riscv, and I find
it easier to follow (even if it's a bit repetitive)

> >
> > > +static int parse_usdt_arg(const char *arg_str, int arg_num, struct u=
sdt_arg_spec *arg)
> > > +{
> > > +       char reg_name[16];
> > > +       int arg_sz, len, reg_off;
> > > +       long off;
> > > +
> > > +       if (sscanf(arg_str, " %d @ \[ %15[a-z0-9], #%ld ] %n", &arg_s=
z, reg_name,
> > > +                                                               &off,=
 &len) =3D=3D 3) {
> >
> > if long function call is wrapped, argument on new line should be
> > aligned with the first argument on previous line. I'd suggest wrapping
> > right after format string, and start with &arg_sz aligned with arg_str
>
> Will change it in the next version.
>
> >
> > > +               /* Memory dereference case, e.g., -4@[fp, #96] */
> > > +               arg->arg_type =3D USDT_ARG_REG_DEREF;
> > > +               arg->val_off =3D off;
> > > +               reg_off =3D calc_pt_regs_off(reg_name);
> > > +               if (reg_off < 0)
> > > +                       return reg_off;
> > > +               arg->reg_off =3D reg_off;
> > > +       } else if (sscanf(arg_str, " %d @ \[ %15[a-z0-9] ] %n", &arg_=
sz, reg_name, &len) =3D=3D 2) {
> > > +               /* Memory dereference case, e.g., -4@[sp] */
> > > +               arg->arg_type =3D USDT_ARG_REG_DEREF;
> > > +               arg->val_off =3D 0;
> > > +               reg_off =3D calc_pt_regs_off(reg_name);
> > > +               if (reg_off < 0)
> > > +                       return reg_off;
> > > +               arg->reg_off =3D reg_off;
> > > +       } else if (sscanf(arg_str, " %d @ #%ld %n", &arg_sz, &off, &l=
en) =3D=3D 2) {
> >
> > is the '#<num>' value always in decimal or it could be hex sometimes?
>
> I have found all these combinations using trying out different things
> in my test program as I couldn't
> find documentation about this. I could not generate a combination
> where a hex value is returned here.

ok, that's fine, let's stick to decimal for now

>
> >
> > > +               /* Constant value case, e.g., 4@#5 */
> > > +               arg->arg_type =3D USDT_ARG_CONST;
> > > +               arg->val_off =3D off;
> > > +               arg->reg_off =3D 0;
> > > +       } else if (sscanf(arg_str, " %d @ %15[a-z0-9] %n", &arg_sz, r=
eg_name, &len) =3D=3D 2) {
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
> > > +       arg->arg_signed =3D arg_sz < 0;
> > > +       if (arg_sz < 0)
> > > +               arg_sz =3D -arg_sz;
> > > +
> > > +       switch (arg_sz) {
> > > +       case 1: case 2: case 4: case 8:
> > > +               arg->arg_bitshift =3D 64 - arg_sz * 8;
> > > +               break;
> > > +       default:
> > > +               pr_warn("usdt: unsupported arg #%d (spec '%s') size: =
%d\n",
> > > +                       arg_num, arg_str, arg_sz);
> > > +               return -EINVAL;
> > > +       }
> >
> > This part is repeated verbatim for each architecture, perhaps it's
> > better to do this post-processing and checking in parse_usdt_spec().
> > Would you mind adding another patch to your series that refactors
> > parse_usdt_arg() implementation to fill out struct usdt_arg_spec and
> > return arg_sz as out parameter. And then parse_usdt_spec() will check
> > arg_sz, set arg_signed and arg_bitshift parts?
>
> Sure, I will refactor this in the first patch and then add ARM support
> in the second patch.
>

sounds good, thanks!

> >
> > > +
> > > +       return len;
> > > +}
> > > +
> > >  #else
> > >
> > >  static int parse_usdt_arg(const char *arg_str, int arg_num, struct u=
sdt_arg_spec *arg)
> > > --
> > > 2.39.1
> > >
>
> Thanks,
> Puranjay
>
> [1] https://www.qemu.org/docs/master/system/arm/virt.html
> [2] https://github.com/libbpf/libbpf-bootstrap/blob/master/examples/c/usd=
t.bpf.c
