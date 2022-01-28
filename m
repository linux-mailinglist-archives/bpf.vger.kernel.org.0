Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774CC4A0182
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 21:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351172AbiA1UJE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jan 2022 15:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351158AbiA1UJB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jan 2022 15:09:01 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F27CC061714;
        Fri, 28 Jan 2022 12:09:01 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id g20so6100549pgn.10;
        Fri, 28 Jan 2022 12:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItmyUeFlJF2ukP6dmtzj5DFTHsPNEXlvRiFYHGt7LTY=;
        b=pYWbuf7Ugj9LHzCqhRZTfv4gKyTjGV8TaqnZHdv3TDd5Z3qjKo91qmkAXvPiizZ/Ss
         +NKCuSmCAUK7HeKBlyjCxV1VO11z0d86krj7iAwTaUqdgoACWforSCaO7OO8RBTrDZAQ
         1iwiPmvKLXpJcmFpiQCYjVLVHDi4zD1KQsbNZYlu6YM0c7yxhbXxtz0OtCveq94bgmuI
         fi3fzYZLlMwYMZENq29b9tgtLSjWjFCZL7GbfgZ67xGT1/sEs2Rq4Hh4GOECydQLGbKf
         E1TBUC0EK5oLu9r7s7qmvQocsEH1I2z4WTORB4LyGyIhBhHsKpCY/Ys2c17hzECVaIH3
         2a/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItmyUeFlJF2ukP6dmtzj5DFTHsPNEXlvRiFYHGt7LTY=;
        b=Go0Lir4jGXVmAQ1TGcUQGrlOE1wR3p0tJMEFm3+7hJ/GmuY6ZBv5TF1auXNh6ScLNr
         q4/p0hMbC9lKdfbs8HoNA8M6H0OcM2ZkDdelKohSPsaCUk0kg3ksQv0PpbbmnX3eCufH
         l7SUcVX8tdMWXSsjMwVz2qp9r6aG9IXm/Namamr/+xakUpbgarW/9nXKg/MaXEu5jdHa
         tcBAtQN+r7yw7Zw6T2ZX8mN86g9pkqKTGBA77N1Y/flIoheuPw7OhKIJd34l+dTfQ/tu
         OkJPpqCvl91xiTeEli11Fvhvrz9fpoKhuiCr7aKXh/aa1jWSUgX/y3Vbn2VAYNHe4hSh
         rIew==
X-Gm-Message-State: AOAM531G43Qt5wkOnJLovfYBildkgSKrYS3zpfttas3h9c//9mmPgJbp
        /kcDMKBIlyFtw+51FTVYkbKrUI26BMZH14RVGaLt4oLdqgk=
X-Google-Smtp-Source: ABdhPJy4VXiKGbt20/7Qt2ACZyavtHPmXbdWrmwU1bxV5X1DwNcxgv2hUBGKF1RlgplRm4XLUIbcXem34VHes21nJzc=
X-Received: by 2002:a65:6182:: with SMTP id c2mr7917724pgv.95.1643400540997;
 Fri, 28 Jan 2022 12:09:00 -0800 (PST)
MIME-Version: 1.0
References: <20211210172034.13614-1-mcroce@linux.microsoft.com>
 <CAADnVQJRVpL0HL=Lz8_e-ZU5y0WrQ_Z0KvQXF2w8rE660Jr62g@mail.gmail.com>
 <CAFnufp33Dm_5gffiFYQ+Maf4Bj9fE3WLMpFf3cJ=F5mm71mTEQ@mail.gmail.com>
 <CAADnVQ+OeO=f1rzv_F9HFQmJCcJ7=FojkOuZWvx7cT-XLjVDcQ@mail.gmail.com>
 <CAFnufp3c3pdxu=hse4_TdFU_UZPeQySGH16ie13uTT=3w-TFjA@mail.gmail.com>
 <CAFnufp35YbxhbQR7stq39WOhAZm4LYHu6FfYBeHJ8-xRSo7TnQ@mail.gmail.com>
 <177da568-8410-36d6-5f95-c5792ba47d62@fb.com> <CAADnVQJZvgpo-VjUCBL8YZy8J+s7O0mv5FW+5sx8NK84Lm6FUQ@mail.gmail.com>
 <CAFnufp3ybOFMY=ObZFvbmr+c70CPUrL2uYp1oZQmffQBTyVy_A@mail.gmail.com>
In-Reply-To: <CAFnufp3ybOFMY=ObZFvbmr+c70CPUrL2uYp1oZQmffQBTyVy_A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 28 Jan 2022 12:08:49 -0800
Message-ID: <CAADnVQ+cvD2rwa-hRQP8agj8=SXuun3dv-PZpK5=kJ2Ea_0KCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: limit bpf_core_types_are_compat() recursion
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 28, 2022 at 10:51 AM Matteo Croce
<mcroce@linux.microsoft.com> wrote:
>
> On Fri, Jan 28, 2022 at 6:31 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Dec 20, 2021 at 10:34 PM Yonghong Song <yhs@fb.com> wrote:
> > >
> > >
> > > https://reviews.llvm.org/D116063 improved the error message as below
> > > to make it a little bit more evident what is the problem:
> > >
> > > $ clang -target bpf -O2 -g -c bug.c
> > >
> > > fatal error: error in backend: SubroutineType not supported for
> > > BTF_TYPE_ID_REMOTE reloc
> >
> > Hi Matteo,
> >
> > Are you still working on a test?
> > What's a timeline to repost the patch set?
> >
> > Thanks!
>
> Hi Alexei,
>
> The change itself is ready, I'm just stuck at writing a test which
> will effectively calls __bpf_core_types_are_compat() with some
> recursion.
> I guess that I have to generate a BTF_KIND_FUNC_PROTO type somehow, so
> __bpf_core_types_are_compat() is called again to check the prototipe
> arguments type.
> I tried with these two, with no luck:
>
> // 1
> typedef int (*func_proto_typedef)(struct sk_buff *);
> bpf_core_type_exists(func_proto_typedef);
>
> // 2
> void func_proto(int, unsigned int);
> bpf_core_type_id_kernel(func_proto);
>
> Which is a simple way to generate a BTF_KIND_FUNC_PROTO BTF field?

What do you mean 'no luck'?
Have you tried what progs/test_core_reloc_type_id.c is doing?
typedef int (*func_proto_typedef)(long);
bpf_core_type_id_kernel(func_proto_typedef);

Without macros:
typedef int (*func_proto_typedef)(long);

int test() {
   return __builtin_btf_type_id(*(typeof(func_proto_typedef) *)0, 1);
}
int test2() {
   return __builtin_preserve_type_info(*(typeof(func_proto_typedef) *)0, 0);
}


compiles fine and generates relos.
