Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD65237FE
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 18:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbiEKQD1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 12:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiEKQD0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 12:03:26 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F15D1957B9;
        Wed, 11 May 2022 09:03:25 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id p4so2291371qtq.12;
        Wed, 11 May 2022 09:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tiYYIPrNfsroaIStl1mY1+mAqifM3btnd6+4riQ+21g=;
        b=QEiYUSeOrsN7Ddqzx0/RdItPxcoY2FCDRypQKbrHt/pSnjxoQREuVSh9oxvn770uCS
         3Pn3HlXhZ8g6rtWB23oM83q1K3IQTd6+5ADiau6X/kmAE+RueTWmlwIR93kCsk5NZGPt
         iCVNyVcSq3CSjC+/dqnWby5kmW4j7eM4eevpSYmQTeWe3PbCj8hqeG4670dCF6RJmTSQ
         U9QJwaofsov9C+KJrWczTegkMNT+8bNxz9Udds1GfHkrBd5CVlazbHpn+tx0c3tcMzJo
         B+8BAO4MOsV3/W7roPcF+Pa102WqZIiNv9LKMiYiXPvs1EBzMUAc/ZaE4NDjGvC71tJU
         R/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tiYYIPrNfsroaIStl1mY1+mAqifM3btnd6+4riQ+21g=;
        b=RaJ8tNr+LrmCujCHSMbSvKJNb/y/0uVXIywlrBIQLns8nYq94ilSzUdPSK42VRQcyO
         E/aQHON6YKf0obCAqrC0RrBlcYP4xe1XkJlNVqJLYpNgZdtsNFcCkF5orL4PlzNphzZg
         12QYTfv99LlBg0Q/keeo8LleXxv3YWCD1i0TxEQ0dqYfsGVA6Ii+4Q7PusvhbegnsqyM
         hy4g0NeyNItZL3NPICSTyVSeAddafm43lOSW/J5g5y1GskZFxJ5lDOWzuDQM36SIF7Y3
         k6rCEekINRXA05ntwNFyl+OBB3SvZ02lFY0sIMP/Q9JdiDijFsl3O8Kri65ZFnRBE3Zm
         i6AA==
X-Gm-Message-State: AOAM533zylD/y1HN3eFgKKjUJukkMDR7tm49WDbnEEs/ljOYoaGU+lkK
        a9vILLt872l/XKRbZ5FHsWV3DWJsWvcLBzgfG5Q=
X-Google-Smtp-Source: ABdhPJwa3rP2S4eeiw9x1SjiKg1G9GaIg9dCplv/xeYNqI01IntL0LJDWh+o5ZrolbftP/S+xnLqr8gJY15ToPwVpvI=
X-Received: by 2002:ac8:5b06:0:b0:2f3:d6c1:e5df with SMTP id
 m6-20020ac85b06000000b002f3d6c1e5dfmr16251030qtw.535.1652285004204; Wed, 11
 May 2022 09:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220509203623.3856965-1-mcgrof@kernel.org> <YnvdOAaYmhNiA5WN@bombadil.infradead.org>
In-Reply-To: <YnvdOAaYmhNiA5WN@bombadil.infradead.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 11 May 2022 09:03:13 -0700
Message-ID: <CAADnVQLCvjqphpJDkz-5bpJLs3k_PRH1JcwehCRLrWYvsA9ENw@mail.gmail.com>
Subject: Re: [PATCH] bpf.h: fix clang compiler warning with unpriv_ebpf_notify()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 11, 2022 at 8:58 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, May 09, 2022 at 01:36:23PM -0700, Luis Chamberlain wrote:
> > The recent commit "bpf: Move BPF sysctls from kernel/sysctl.c to BPF co=
re"
> > triggered 0-day to issue an email for what seems to have been an old
> > clang warning. So this issue should have existed before as well, from
> > what I can tell. The issue is that clang expects a forward declaration
> > for routines declared as weak while gcc does not.
> >
> > This can be reproduced with 0-day's x86_64-randconfig-c007
> > https://download.01.org/0day-ci/archive/20220424/202204240008.JDntM9cU-=
lkp@intel.com/config
> >
> > And using:
> >
> > COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D1 AR=
CH=3Dx86_64 SHELL=3D/bin/bash kernel/bpf/syscall.o
> > Compiler will be installed in /home/mcgrof/0day
> > make --keep-going HOSTCC=3D/home/mcgrof/0day/clang/bin/clang CC=3D/home=
/mcgrof/0day/clang/bin/clang LD=3D/home/mcgrof/0day/clang/bin/ld.lld HOSTLD=
=3D/home/mcgrof/0day/clang/bin/ld.lld AR=3Dllvm-ar NM=3Dllvm-nm STRIP=3Dllv=
m-strip OBJCOPY=3Dllvm-objcopy OBJDUMP=3Dllvm-objdump OBJSIZE=3Dllvm-size R=
EADELF=3Dllvm-readelf HOSTCXX=3Dclang++ HOSTAR=3Dllvm-ar CROSS_COMPILE=3Dx8=
6_64-linux-gnu- --jobs=3D24 W=3D1 ARCH=3Dx86_64 SHELL=3D/bin/bash kernel/bp=
f/syscall.o
> >   DESCEND objtool
> >   CALL    scripts/atomic/check-atomics.sh
> >   CALL    scripts/checksyscalls.sh
> >   CC      kernel/bpf/syscall.o
> > kernel/bpf/syscall.c:4944:13: warning: no previous prototype for functi=
on 'unpriv_ebpf_notify' [-Wmissing-prototypes]
> > void __weak unpriv_ebpf_notify(int new_state)
> >             ^
> > kernel/bpf/syscall.c:4944:1: note: declare 'static' if the function is =
not intended to be used outside of this translation unit
> > void __weak unpriv_ebpf_notify(int new_state)
> > ^
> > static
> >
> > Fixes: 2900005ea287 ("bpf: Move BPF sysctls from kernel/sysctl.c to BPF=
 core")
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >
> > Daniel,
> >
> > Given what we did fore 2900005ea287 ("bpf: Move BPF sysctls from
> > kernel/sysctl.c to BPF core") where I had pulled pr/bpf-sysctl a
> > while ago into sysctl-next and then merged the patch in question,
> > should I just safely carry this patch onto sysctl-next? Let me know
> > how you'd like to proceed.
> >
> > Also, it wasn't clear if putting this forward declaration on
> > bpf.h was your ideal preference.
>
> After testing this on sysctl-testing without issues going to move this
> to sysctl-next now.

Hmm. No.
A similar patch should be in tip already. You have to wait
for it to go through Linus's tree and back to whatever tree you use.

Borislav,
did you ship it yet?
