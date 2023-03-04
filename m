Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060CE6AAC16
	for <lists+bpf@lfdr.de>; Sat,  4 Mar 2023 20:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCDTSW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Mar 2023 14:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjCDTSW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Mar 2023 14:18:22 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A648CDBF5
        for <bpf@vger.kernel.org>; Sat,  4 Mar 2023 11:18:20 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id s20so7715086lfb.11
        for <bpf@vger.kernel.org>; Sat, 04 Mar 2023 11:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677957498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbOhwFkc4CLkp3DLz0CWhvQX+vA4hs0mb4aYr36y4S0=;
        b=iJF+SjjE+LNdMEPidPT2HWN7L64bx7RfRHzp9ueOjxkkaHxgOeLqsPtr/2Dyu3wvog
         Jo99amNkIEWUgdAsWFqVO1IEG2Zty0FrgMTsnFl+aMOce2QkYSRp6QqzijLZ2RJknvY8
         HvBU7nt1NDMiI5GhytLYGI2jfWsuY0bGFrnetHj1CZOLRUKy/nC24qEfn5Q+iz4vbAiN
         Cd8Cv2M6Bo1of3iEd3gx4TLZWIgAj+pE/7uyf2ARWL5qtbuwqkACdE4A4P4Wc/rB6VS7
         AaWMriuL7/nmf/cNU3HC73Jt4w6II2kgPpUU+Rhh7nVGvkPnP8VwMOsLir+rNky8OkXm
         gsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677957498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbOhwFkc4CLkp3DLz0CWhvQX+vA4hs0mb4aYr36y4S0=;
        b=4ggxF6hVMcfs8HQ1HYnikxCNGNYULhPz0IjiICro+s1VQuOpptefFn6YDFtekoIekh
         8udEcXVOz9J/FT0aM4k6rFegR++cM29U/mFCT9KTWQamxu6MQartc8dEXQi3+l5/hhrH
         VQDhVSh83UFAGWUzVnRK41U+0pJhOBgAuUQFubBfC9QSip3DeFm8qgByLwdlIyFzIRQN
         KTvPrBQCG2Rd8GyoacXF6uPpRmBT1a1qwoaGDfHAOfV3Q7Oa7dn9zEQjiDgVNHGx8dkK
         9fy/5uRNtNILHihDqywnbfydhpc09+Jd9LNZPZHC/bpNkIpNvs0CVVIDuzNlAtY7FwKg
         rLbg==
X-Gm-Message-State: AO0yUKVabu+WXCPN+8Wb26j5kH3FfKv6HwPAKNuHd1eyvr4CbKvTcuXH
        J3f0GKDrJhQdzLpT87oP6oCnoxoCQxRVp9k3Emc=
X-Google-Smtp-Source: AK7set/fqz4u+MHZtauMeDn56I0AO1uy3an19I4VGGdN+GwZuugS84Rypox2nuPsFzV3l9qmXS+zGdL1rZMyQGwI50k=
X-Received: by 2002:a19:750b:0:b0:4de:6514:2ee4 with SMTP id
 y11-20020a19750b000000b004de65142ee4mr1746892lfe.11.1677957498252; Sat, 04
 Mar 2023 11:18:18 -0800 (PST)
MIME-Version: 1.0
References: <20230303083706.3597-1-puranjay12@gmail.com> <CAEf4BzYKokYubGxMS=CchDVVhxLbGwUmCptJQ9U6CQ0LYc0HkA@mail.gmail.com>
In-Reply-To: <CAEf4BzYKokYubGxMS=CchDVVhxLbGwUmCptJQ9U6CQ0LYc0HkA@mail.gmail.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Sun, 5 Mar 2023 00:48:06 +0530
Message-ID: <CANk7y0hB5SoO-6=A0JL9hXaje74bJaK_-0rtywXALbkbtEKTfw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: usdt arm arg parsing support
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        bpf@vger.kernel.org, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

On Sat, Mar 4, 2023 at 9:52=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 3, 2023 at 12:37=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.=
com> wrote:
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
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > ---
>
> You don't mention that in the commit message, but how did you test
> these changes?

I use the  QEMU's virt[1] board with cortex-a15 CPU. I take the
libbpf-bootstrap's usdt example[2] and
modify it to attach it to my custom program with
DTRACE_PROBE1/2/3/4... probes to test different combinations.

>
> > Changes in V1[1] to V2
> > - Resending as V1 shows up as Superseded in patchwork.
> >
> > [1] https://patchwork.kernel.org/project/netdevbpf/patch/20230220212741=
.13515-1-puranjay12@gmail.com/
> > ---
> >  tools/lib/bpf/usdt.c | 82 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >
> > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > index 75b411fc2c77..ef097b882a4d 100644
> > --- a/tools/lib/bpf/usdt.c
> > +++ b/tools/lib/bpf/usdt.c
> > @@ -1505,6 +1505,88 @@ static int parse_usdt_arg(const char *arg_str, i=
nt arg_num, struct usdt_arg_spec
> >         return len;
> >  }
> >
> > +#elif defined(__arm__)
> > +
> > +static int calc_pt_regs_off(const char *reg_name)
> > +{
> > +       int reg_num;
> > +
> > +       if (sscanf(reg_name, "r%d", &reg_num) =3D=3D 1) {
> > +               if (reg_num >=3D 0 && reg_num <=3D 10)
> > +                       return offsetof(struct pt_regs, uregs[reg_num])=
;
> > +       } else if (strcmp(reg_name, "fp") =3D=3D 0) {
> > +               return offsetof(struct pt_regs, ARM_fp);
> > +       } else if (strcmp(reg_name, "ip") =3D=3D 0) {
> > +               return offsetof(struct pt_regs, ARM_ip);
> > +       } else if (strcmp(reg_name, "sp") =3D=3D 0) {
> > +               return offsetof(struct pt_regs, ARM_sp);
> > +       } else if (strcmp(reg_name, "lr") =3D=3D 0) {
> > +               return offsetof(struct pt_regs, ARM_lr);
> > +       } else if (strcmp(reg_name, "pc") =3D=3D 0) {
> > +               return offsetof(struct pt_regs, ARM_pc);
> > +       }
> > +       pr_warn("usdt: unrecognized register '%s'\n", reg_name);
> > +       return -ENOENT;
> > +}
> > +
>
> let's use a more tabular approach, just like, say, riscv does?

As R0-R10 directly map to uregs[0->10], I used sscanf for that, and as
there are only five named registers
(FP, IP, SP, LR, PC), I thought that using if-else would be good
enough. But I can change it if it is necessary.

>
> > +static int parse_usdt_arg(const char *arg_str, int arg_num, struct usd=
t_arg_spec *arg)
> > +{
> > +       char reg_name[16];
> > +       int arg_sz, len, reg_off;
> > +       long off;
> > +
> > +       if (sscanf(arg_str, " %d @ \[ %15[a-z0-9], #%ld ] %n", &arg_sz,=
 reg_name,
> > +                                                               &off, &=
len) =3D=3D 3) {
>
> if long function call is wrapped, argument on new line should be
> aligned with the first argument on previous line. I'd suggest wrapping
> right after format string, and start with &arg_sz aligned with arg_str

Will change it in the next version.

>
> > +               /* Memory dereference case, e.g., -4@[fp, #96] */
> > +               arg->arg_type =3D USDT_ARG_REG_DEREF;
> > +               arg->val_off =3D off;
> > +               reg_off =3D calc_pt_regs_off(reg_name);
> > +               if (reg_off < 0)
> > +                       return reg_off;
> > +               arg->reg_off =3D reg_off;
> > +       } else if (sscanf(arg_str, " %d @ \[ %15[a-z0-9] ] %n", &arg_sz=
, reg_name, &len) =3D=3D 2) {
> > +               /* Memory dereference case, e.g., -4@[sp] */
> > +               arg->arg_type =3D USDT_ARG_REG_DEREF;
> > +               arg->val_off =3D 0;
> > +               reg_off =3D calc_pt_regs_off(reg_name);
> > +               if (reg_off < 0)
> > +                       return reg_off;
> > +               arg->reg_off =3D reg_off;
> > +       } else if (sscanf(arg_str, " %d @ #%ld %n", &arg_sz, &off, &len=
) =3D=3D 2) {
>
> is the '#<num>' value always in decimal or it could be hex sometimes?

I have found all these combinations using trying out different things
in my test program as I couldn't
find documentation about this. I could not generate a combination
where a hex value is returned here.

>
> > +               /* Constant value case, e.g., 4@#5 */
> > +               arg->arg_type =3D USDT_ARG_CONST;
> > +               arg->val_off =3D off;
> > +               arg->reg_off =3D 0;
> > +       } else if (sscanf(arg_str, " %d @ %15[a-z0-9] %n", &arg_sz, reg=
_name, &len) =3D=3D 2) {
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
> > +       arg->arg_signed =3D arg_sz < 0;
> > +       if (arg_sz < 0)
> > +               arg_sz =3D -arg_sz;
> > +
> > +       switch (arg_sz) {
> > +       case 1: case 2: case 4: case 8:
> > +               arg->arg_bitshift =3D 64 - arg_sz * 8;
> > +               break;
> > +       default:
> > +               pr_warn("usdt: unsupported arg #%d (spec '%s') size: %d=
\n",
> > +                       arg_num, arg_str, arg_sz);
> > +               return -EINVAL;
> > +       }
>
> This part is repeated verbatim for each architecture, perhaps it's
> better to do this post-processing and checking in parse_usdt_spec().
> Would you mind adding another patch to your series that refactors
> parse_usdt_arg() implementation to fill out struct usdt_arg_spec and
> return arg_sz as out parameter. And then parse_usdt_spec() will check
> arg_sz, set arg_signed and arg_bitshift parts?

Sure, I will refactor this in the first patch and then add ARM support
in the second patch.

>
> > +
> > +       return len;
> > +}
> > +
> >  #else
> >
> >  static int parse_usdt_arg(const char *arg_str, int arg_num, struct usd=
t_arg_spec *arg)
> > --
> > 2.39.1
> >

Thanks,
Puranjay

[1] https://www.qemu.org/docs/master/system/arm/virt.html
[2] https://github.com/libbpf/libbpf-bootstrap/blob/master/examples/c/usdt.=
bpf.c
