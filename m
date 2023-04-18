Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E1E6E6BDD
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 20:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjDRSOv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 14:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDRSOu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 14:14:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C2030E0
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 11:14:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so25279214a12.1
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 11:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681841688; x=1684433688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0j1peCnlQf5SGlTvODgXxelybdiV2D9/E3s8Qs+6Cw=;
        b=gfKyutPxFQLlvL2IeSrRgCZXW3IOWh32qDVyHLXEEMI7eX9Vn/6BvBWGtZwlTl57ta
         AMOAqzSJS8qFGSvoQBDO87ZwsVpgvK6SrHMqEcChOa5ZdekRGNxYfdULKtF7MUHhB6K7
         K4GDyeb3iF3Dqjwnhef2JNvfIBSxAHUU6Fv+mz03n9Gxs0zJNXC4/g0AOUcEaIpQsCoP
         x2+GLQUhdi2lj6WazQOdLF5NYuySLmVsuiHTRX2dLUUFnDKvVp5I0skyj6JKzsbLfajI
         5DTEz45kb7svfp4Xh03ttfRrm7ACyF0IAibXxFIOoz7Cwku3mETqrE3DvRNRNXtQTNnC
         i2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681841688; x=1684433688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0j1peCnlQf5SGlTvODgXxelybdiV2D9/E3s8Qs+6Cw=;
        b=IXncWf2pwRrGU1wAEYtSYGz/X9mJ7L8PwtHU+ruOxxzcpJoPpj0ERVbqKcROk7sCuL
         RZ0dZgaz1ckEh2K+Hn2nP0GjfJCQIUGeBa1cZqNKVHVZftcc9+Ug5/jKM1AVWjZxRhF2
         LVPY0zQOL7P6TeBBgrxxuk2L06xynuGX3Rc4NslWhiOhfbofyRbrnMHi9HwxO3UuBz6k
         tP7P4wibvdyKuXA/DJBsQTk61UYyFBLGxVt6x+/9+3A4WNCltONkQmg6YQmKbH3yQEP8
         7Is/2W9Rzwjf076QJ1WaPnFJDoLNTKI/MLvg2AOb0x+S2Cks/zdVs4wvaP5mVeEZF1m4
         qmiw==
X-Gm-Message-State: AAQBX9elWJbr1cZAbZmaJ/hcL49dyiadrQhGtBAx7FZTLO8q/zG03g90
        V3uGu+mJ2uzXXeCfIBg/CICn7oTEAaeiliOeO23L+XT4
X-Google-Smtp-Source: AKy350Y4ubUKwvdoOyRr/fuE/xulaEodlccTejkxnYp4VHxs+oSJ8lcRYk6ooVVa74ta4GQqqzyeZ63IHQit28RZA50=
X-Received: by 2002:a05:6402:1e96:b0:506:bdbc:e59f with SMTP id
 f22-20020a0564021e9600b00506bdbce59fmr1799340edf.3.1681841687848; Tue, 18 Apr
 2023 11:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230418002148.3255690-1-andrii@kernel.org> <20230418002148.3255690-4-andrii@kernel.org>
 <CAADnVQK-JjutrU-TMCh6f9qfcY_9T2mr59+Lzcw5us8KwDEmug@mail.gmail.com> <CAEf4BzaGEhszZ-VxB=0YdF989LQNZA-rnuZasEF_BB-Qy_hdNQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaGEhszZ-VxB=0YdF989LQNZA-rnuZasEF_BB-Qy_hdNQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 18 Apr 2023 11:14:36 -0700
Message-ID: <CAADnVQ+xJ0sFR1E2rqPDVMd3Cf8MxJTHk+q3_65BEYG5_5BZ+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] libbpf: improve handling of unresolved kfuncs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 18, 2023 at 11:10=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Apr 17, 2023 at 6:10=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Apr 17, 2023 at 5:22=E2=80=AFPM Andrii Nakryiko <andrii@kernel.=
org> wrote:
> > >                                 insn[0].imm =3D ext->ksym.kernel_btf_=
id;
> > >                                 insn[0].off =3D ext->ksym.btf_fd_idx;
> > > -                       } else { /* unresolved weak kfunc */
> > > -                               insn[0].imm =3D 0;
> > > -                               insn[0].off =3D 0;
> > > +                       } else { /* unresolved weak kfunc call */
> > > +                               poison_kfunc_call(prog, i, relo->insn=
_idx, insn,
> > > +                                                 relo->ext_idx, ext)=
;
> >
> > With that done should we remove:
> >     /* skip for now, but return error when we find this in fixup_kfunc_=
call */
> >     if (!insn->imm)
> >           return 0;
> > in check_kfunc_call()...
> >
> > and  if (!func_id && !offset) in add_kfunc_call() ?
> >
> > That was added in commit a5d827275241 ("bpf: Be conservative while
> > processing invalid kfunc calls")
>
> I guess?.. I don't know if there was any other situation that this fix
> was handling, but if it's only due to unresolved kfuncs by libbpf,
> then yep.

It was specifically to support weak kfunc with imm=3D=3D0 off=3D=3D0.
With libbpf doing poisoning and converting call kfunc into call
unknown helper that code is no longer needed.
The question is whether we should try to support new kernel plus old
libbpf combination.
