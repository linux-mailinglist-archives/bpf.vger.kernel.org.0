Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF89817884F
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 03:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387476AbgCDCbX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 21:31:23 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41464 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387411AbgCDCbX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 21:31:23 -0500
Received: by mail-il1-f195.google.com with SMTP id q13so495476ile.8
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 18:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iDh/enhDaAA8PUFA/sO33m/8w76mEhVPC2n0905OieU=;
        b=S8jgdom0wODh397o+u6x7vdYMOxPd/sn1jhl7jFTzqmZwArA/RGIOqXd1Lfk54/0Vl
         OnuKtqPJi4jEGtECkwc5BXE+qT27/RonNFdTLx9kPE210O+Z5T2l6hPG58KWXs+eDdf1
         pHa2aWWb75igheHNKaBH3PpojCyHVsQH0TMYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iDh/enhDaAA8PUFA/sO33m/8w76mEhVPC2n0905OieU=;
        b=kSeC4JAtOwTCq7gc6udZ/kofpU4+p6w3rChvSB1gC6nIWFxLY+Kyxy4fjk0YrXGmSZ
         XgnZVOy0XtkcxqGwTVYhmYQic/KLO9J+HyfyxBr2kLDEJZoOk0XuXHMoeJa3oybv11oB
         09swaDNa9Efj3u/tDeVq4MEHKAVE2pswyxwkTi+J2JP1UohI3XEJIDhF/p0DTY8AzR7f
         MjxjI9OAk1ds7SxdQLuj5l5aiiwNY3qiYQEXqi5EI+fqZVGVeEXeDhdZMpU7MImQlyz9
         FW2S10IfX1ZiJXJ8ZdIfFUeJiMhSFESgAxLEo2t8Zwp0jEBLT9Ejg2N56rbOGeROHJ5f
         A5+w==
X-Gm-Message-State: ANhLgQ2U2ZNjEtYeZR9Kvq7/ySdhPWjCJz5kOMXrgVXDkaeBYHjXDXux
        NbF92pDL6Lfp16aBEeyjuqlp3zjW6HFYVQWsbE2LPw==
X-Google-Smtp-Source: ADFU+vtpJ/AVr87l3sVJ8pp3Eu7HomjQQiORzxtMTMauDedmgqcfPEE0GdUhImRuEnjWdcebpvzP0Zzi0Nqw6HfYP3A=
X-Received: by 2002:a92:860a:: with SMTP id g10mr674584ild.280.1583289081991;
 Tue, 03 Mar 2020 18:31:21 -0800 (PST)
MIME-Version: 1.0
References: <20200303005035.13814-1-luke.r.nels@gmail.com> <20200303005035.13814-2-luke.r.nels@gmail.com>
 <CAJ+HfNhSj9ycgh8Y44b_ZruW1A=+W_53fXnCDc488WXSESJ3dw@mail.gmail.com>
In-Reply-To: <CAJ+HfNhSj9ycgh8Y44b_ZruW1A=+W_53fXnCDc488WXSESJ3dw@mail.gmail.com>
From:   Luke Nelson <lukenels@cs.washington.edu>
Date:   Tue, 3 Mar 2020 18:31:11 -0800
Message-ID: <CADasFoC5EEXdq43waj9pQDb9HtpG2bWE2yMVySBZ4rpopYbROQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/4] riscv, bpf: move common riscv JIT code to header
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Luke Nelson <luke.r.nels@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Xi Wang <xi.wang@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Bj=C3=B6rn,

Thanks for the comments! Inlined responses below:

On Mon, Mar 2, 2020 at 11:50 PM Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.co=
m> wrote:
>
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Common functionality for RV32 and RV64 BPF JIT compilers
> > + *
> > + * Copyright (c) 2019 Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com>
> > + * Copyright (c) 2020 Luke Nelson <luke.r.nels@gmail.com>
> > + * Copyright (c) 2020 Xi Wang <xi.wang@gmail.com>
>
> I'm no lawyer, so this is more of a question; You've pulled out code
> into a header, and renamed two functions. Does that warrant copyright
> line additions? Should my line be removed?

This header also includes new code for emitting instructions required
for the RV32 JIT (e.g., sltu) and some additional pseudoinstructions
(e.g., bgtu and similar). I'm also no lawyer, so I don't know either
if this rises to the level of adding copyright lines. I'm happy to
do the following in v5 if it looks better:

+ * Copyright (c) 2019 Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com>
+ *
+ * Modified by ...

> > +#if __riscv_xlen =3D=3D 64
>
> Please remove this. If the inlined functions are not used, they're not
> part of the binary. This adds complexity to the code, and without it
> we can catch build errors early on!

I agree in general we should avoid #if. The reason for using it
here is to cause build errors if the RV32 JIT ever tries to emit
an RV64-only instruction by mistake. Otherwise, what is now a build
error would be delayed to an illegal instruction trap when the JITed
code is executed, which is much harder to find and diagnose.

We could use separate files, bpf_jit_32.h and bpf_jit_64.h (the
latter will include the former), if we want to avoid #if. Though
this adds another form of complexity.

So the options here are 1) using no #if, with the risk of hiding
subtle bugs in the RV32 JIT; 2) using #if as is; and 3) using
separate headers. What do you think?

Thanks!

Luke
