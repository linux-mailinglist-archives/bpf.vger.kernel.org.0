Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3439178861
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 03:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387600AbgCDCd3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 21:33:29 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44855 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387591AbgCDCd3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 21:33:29 -0500
Received: by mail-io1-f65.google.com with SMTP id u17so656254iog.11
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 18:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z8i39F29uItXrQ0Vm+/tnYAlpVrh5Zrfz37MFCt4wqg=;
        b=YA+26ZyPPsXhtvsAfcQdDGKF76soF525p7XOyeC2g3fWKaRu7Nchx0JivsPHU9+mVx
         L2n+BpbDPm4VZ0rdcng/wCTI7pmzhvs1BTt5zoXCYUBmigd7w6CB7jsBLqS/tRZ3sBra
         ttxpQ4mYrMFxanwRq3ExFUcoGdLn+TstWEZGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z8i39F29uItXrQ0Vm+/tnYAlpVrh5Zrfz37MFCt4wqg=;
        b=UtPGDa5lvkus3OIaIY/YTiFH+xFNm4OlsZVRb08mpjVsP7fZRQmurXMvdsU4WB7nDW
         Dl7asZd4EmLg+4HgsUu3vE8C8p/M03ABajxabtlLL0YVBXr9Z/ik/iEx3OvjURemT0ep
         ryU0O+TmZbQLcEtGEidRbRzv+vv68rOj2YjTxEiyxEHjMaOBDQB5ustehJLVl9KgRrtA
         95mW72kUQi5zT+tNg+Z/J2em1aeQnC/UVVCXszn4ZY3HJDjaApCbEpAp+dS+/Vu82oVS
         o5dJj7UuIUhjiRg4jt4RdFvz3m7fPHVqAsmwK7Hdro4906C5k8Ci9ATYjE+bO9e9NrF0
         kUGA==
X-Gm-Message-State: ANhLgQ3I5DoftAUCcfKnvfLjAr6KKdjEyBTh3AKvJ9Z/v796rQOvQXrj
        HspHM7nYTOPUHy80j5tHA3mVnmNT+mJHtgWcPWMgZA==
X-Google-Smtp-Source: ADFU+vtdbhJTXt1bRm93LupwhvNWTGVMBaqbP4QMYe4hxwp7dnVdENhAaLm/Y73xWVIRUbZJWq6Ns+B//0CejhYYfa0=
X-Received: by 2002:a6b:e310:: with SMTP id u16mr451066ioc.43.1583289208493;
 Tue, 03 Mar 2020 18:33:28 -0800 (PST)
MIME-Version: 1.0
References: <20200303005035.13814-1-luke.r.nels@gmail.com> <20200303005035.13814-5-luke.r.nels@gmail.com>
 <20200303100228.GJ1224808@smile.fi.intel.com>
In-Reply-To: <20200303100228.GJ1224808@smile.fi.intel.com>
From:   Luke Nelson <lukenels@cs.washington.edu>
Date:   Tue, 3 Mar 2020 18:33:17 -0800
Message-ID: <CADasFoCq7S2KRYg+ghAKt1e+hELzEMJaNH74sGdjM7E=z3KcnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/4] MAINTAINERS: Add entry for RV32G BPF JIT
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 3, 2020 at 2:02 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> > -BPF JIT for RISC-V (RV64G)
> > +BPF JIT for 32-bit RISC-V (RV32G)
> > +M:   Luke Nelson <luke.r.nels@gmail.com>
> > +M:   Xi Wang <xi.wang@gmail.com>
> > +L:   bpf@vger.kernel.org
> > +S:   Maintained
> > +F:   arch/riscv/net/
> > +X:   arch/riscv/net/bpf_jit_comp.c
> > +
> > +BPF JIT for 64-bit RISC-V (RV64G)
> >  M:   Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com>
> > -L:   netdev@vger.kernel.org
> > +L:   bpf@vger.kernel.org
> >  S:   Maintained
> >  F:   arch/riscv/net/
> > +X:   arch/riscv/net/bpf_jit_comp32.c
>
> Obviously this breaks an order. Please, fix.
> Hint: run parse-maintainers.pl after the change.

Hi,

Thanks for the comment!

I'll change the entry names in v5 to be "BPF JIT for RISC-V (32-bit)"
and "BPF JIT for RISC-V (64-bit)", similar to the x86 JIT entries.
This will pass parse-maintainers.pl and the entries are still in
order.

Thanks again,

Luke
