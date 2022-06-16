Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B61A54EB5D
	for <lists+bpf@lfdr.de>; Thu, 16 Jun 2022 22:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378721AbiFPUjB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jun 2022 16:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378367AbiFPUi7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jun 2022 16:38:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12335DD25
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 13:38:53 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eo8so3764587edb.0
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XJARqM/NqasEvhC9Y89kwlEP8NLgr7BQ25Jz1zgF72k=;
        b=NBOMhgsHCOlL+j7HXkTorTG1fSnHRY2uPaAbXGUsW/pmvppzeBfSErFIPsEwZ/hzZg
         WsOECi98i+KaU4sH+DbNAbaETd6C+o5hxAPGLOjgVD/mryOxmcSYuVle3skR8wMPw0T8
         4VEjotZFHgLHhUawLbNrOW9gcC7lFz1GCAQEryUe1RcJ8KlCo7FeItH74Yqf2cuhv3t8
         UMV4xRmPAMye6d3L9GzAFiP5j1ePICK7WyXifk6cGAgYg4ff7GDFVd9+z11n3EA9xocg
         Mad1BzonyUHYpRRPKw2kDpet1BVWYS4FJC/R98gQIEzd4axKfVzsfstWD063IOENF3Ip
         FFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XJARqM/NqasEvhC9Y89kwlEP8NLgr7BQ25Jz1zgF72k=;
        b=Kv5X40xHxV4lTzi8Q6OxRb1gn/OnfHrqH6a5HQ4uQmi2AFMyDrgoXpQUNZiT68Php4
         keZBAU/WU5jvbHmxl2sE7yVw5ufzQCEUBo6k+/IJJ8NjO1COPgKtCKzPjKf7ChVovXsT
         R5qevVFVUaWHho4fQzxJ4kuYU9VaEbzMWmSKcbkhrKEB5XI95eVDrR4E5xcAmq7lDfVW
         9ATjKnVKfSFYQm1NTrgN8rrCY9WJPZOKX2oedNb9WfvTteZ6b6esdoUgO9v2WJSqlKMw
         BKNZEnnE4MdinfcTK0MlhS4nqEOUc41l9WxSNkqHOvQMLmH4RxoxzZYaOgLT5MP8rlEZ
         ZnSw==
X-Gm-Message-State: AJIora/kKcxjRwu5WdGhh+njonazPPdKbq0FV/sN5DzH+YaixV9zBPqN
        bJBGL3dusy3AuCrBZYMfM5tS3hP4orVqiKans+M=
X-Google-Smtp-Source: AGRyM1suwOgBiDBGttf+RCyj5s0/c1kI1Goks0zkjmyrjJdXH83rsh4JKFr8Nz6G0E29DFDuS75x9GZKpXSwr2IzWOg=
X-Received: by 2002:aa7:c450:0:b0:431:55c6:29f9 with SMTP id
 n16-20020aa7c450000000b0043155c629f9mr8720596edr.14.1655411932176; Thu, 16
 Jun 2022 13:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220616055543.3285835-1-andrii@kernel.org> <CAADnVQ+OXAk8=FoyHP0pt5o_9sB7Qj=nm7xLZJYpLEczMt8i2g@mail.gmail.com>
In-Reply-To: <CAADnVQ+OXAk8=FoyHP0pt5o_9sB7Qj=nm7xLZJYpLEczMt8i2g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Jun 2022 13:38:40 -0700
Message-ID: <CAEf4BzaOOig5m+M5EbNDnBi=rPL1DcbSF-GrOkZvSNFxLymOCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix internal USDT address translation
 logic for shared libraries
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 16, 2022 at 1:00 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 15, 2022 at 10:56 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Perform the same virtual address to file offset translation that libbpf
> > is doing for executable ELF binaries also for shared libraries.
> > Currently libbpf is making a simplifying and sometimes wrong assumption
> > that for shared libraries relative virtual addresses inside ELF are
> > always equal to file offsets.
> >
> > Unfortunately, this is not always the case with LLVM's lld linker, which
> > now by default generates quite more complicated ELF segments layout.
> > E.g., for liburandom_read.so from selftests/bpf, here's an excerpt from
> > readelf output listing ELF segments (a.k.a. program headers):
> >
> >   Type           Offset   VirtAddr           PhysAddr           FileSiz  MemSiz   Flg Align
> >   PHDR           0x000040 0x0000000000000040 0x0000000000000040 0x0001f8 0x0001f8 R   0x8
> >   LOAD           0x000000 0x0000000000000000 0x0000000000000000 0x0005e4 0x0005e4 R   0x1000
> >   LOAD           0x0005f0 0x00000000000015f0 0x00000000000015f0 0x000160 0x000160 R E 0x1000
> >   LOAD           0x000750 0x0000000000002750 0x0000000000002750 0x000210 0x000210 RW  0x1000
> >   LOAD           0x000960 0x0000000000003960 0x0000000000003960 0x000028 0x000029 RW  0x1000
> >
> > Compare that to what is generated by GNU ld (or LLVM lld's with extra
> > -znoseparate-code argument which disables this cleverness in the name of
> > file size reduction):
> >
> >   Type           Offset   VirtAddr           PhysAddr           FileSiz  MemSiz   Flg Align
> >   LOAD           0x000000 0x0000000000000000 0x0000000000000000 0x000550 0x000550 R   0x1000
> >   LOAD           0x001000 0x0000000000001000 0x0000000000001000 0x000131 0x000131 R E 0x1000
> >   LOAD           0x002000 0x0000000000002000 0x0000000000002000 0x0000ac 0x0000ac R   0x1000
> >   LOAD           0x002dc0 0x0000000000003dc0 0x0000000000003dc0 0x000262 0x000268 RW  0x1000
> >
> > You can see from the first example above that for executable (Flg == "R E")
> > PT_LOAD segment (LOAD #2), Offset doesn't match VirtAddr columns.
> > And it does in the second case (GNU ld output).
> >
> > This is important because all the addresses, including USDT specs,
> > operate in a virtual address space, while kernel is expecting file
> > offsets when performing uprobe attach. So such mismatches have to be
> > properly taken care of and compensated by libbpf, which is what this
> > patch is fixing.
> >
> > Also patch clarifies few function and variable names, as well as updates
> > comments to reflect this important distinction (virtaddr vs file offset)
> > and to ephasize that shared libraries are not all that different from
> > executables in this regard.
> >
> > This patch also changes selftests/bpf Makefile to force urand_read and
> > liburand_read.so to be built with Clang and LLVM's lld (and explicitly
> > request this ELF file size optimization through -znoseparate-code linker
> > parameter) to validate libbpf logic and ensure regressions don't happen
> > in the future. I've bundled these selftests changes together with libbpf
> > changes to keep the above description tied with both libbpf and
> > selftests changes.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/usdt.c                 | 123 ++++++++++++++-------------
>
> What should be the Fixes tag here?
> Back to the beginning of this usdt.c file?

Oh, sorry, forgot about the Fixes tag. Yeah, it's pretty much never
worked properly for such fancy ELF shared libraries.

Fixes: 74cc6311cec9 ("libbpf: Add USDT notes parsing and resolution logic")
