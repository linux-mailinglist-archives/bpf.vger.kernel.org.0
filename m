Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24804F2020
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 01:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiDDXRJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 19:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243417AbiDDXPe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 19:15:34 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5E3381BF
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 15:59:23 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id x9so7995544ilc.3
        for <bpf@vger.kernel.org>; Mon, 04 Apr 2022 15:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=foldQ45vuGLFGh2y+r8GSF40QhlSi7+5DvnUY8uaOn0=;
        b=SAYoyYRC16z8feazYHZ6eGJ9a7PLPhDbqdRlcbswSZzZ+ZZOPjdmw01SrbYosJvAWj
         Bm3KkrBKCqZVrcJUHHiCRXAyfFqjjpLEc9ntuJ/topOFFBkNaQaz62fuXK5gQPmt79ij
         kJe591ozfty4fcfkXlwzBHYaz1Ayp/Sk6w4+G3deHdFJC31lkrxbPo36epEw7uFnewph
         YxOiXtkq8+033C0pwT0LzRsjk0b5VqTWhRHWuTr2y6Y/1fwLKz4OOujqUXwWeqFQwsyz
         1jRTjZnt9Nol2MfPJ+IGtwLwsz9r5ePJcIdy2DMOVzMoYIdPzPi0hXQ5v9MabJevYuWk
         Taig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=foldQ45vuGLFGh2y+r8GSF40QhlSi7+5DvnUY8uaOn0=;
        b=QAup5EqZBJfZ/Up7pBj/vV4O/+GzTFUnepjhB8Qrf06anaiUmk/NsIr72NBbK26xmQ
         5r5rr5hjEu9ETGU62HdO720PIlxLFcWBmy9rFxREWiPjyMxCxVN64DOQVazJA56VNzTK
         CtlNiacfiO/yy1T+pGMx+cgqLvQSBwkQK+AVHGZXkYuZP89I6XE4bAYKEco6plTc69GW
         LPv1Cl6XjLpUdiq2cdplfAGTi97VoHx3Ytu/msTJba9etbf6XZufgGrJXLhazoaPzMEk
         wWUgz9GNuFDUNvGTAPZ0Aw5ja+bB1Y37i5h08WSy26wkWlcHQKESZqrK9FC1MMzM9Jeg
         UWKw==
X-Gm-Message-State: AOAM533wyNe6sx89Vuem2nEetgsEj971p3iV57pO27q+qXPTHm3FwfIw
        0/8cql7ATb0+Nz6gZg0+lmrYo48aWKxdJfjRt40=
X-Google-Smtp-Source: ABdhPJxhAWTSV0b1dy8gYSlip5cx67cjK/fXdxJ/XDyOBLCGnJkIGHw++q4ooacVIwDS/F7kTLKbgfOnFBeGzncsMrQ=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr270970ilb.305.1649113162484; Mon, 04 Apr
 2022 15:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220404102908.14688-1-iii@linux.ibm.com> <CAEf4BzZfSUTNAXQM6BcXF6rQGe6LaSfpgiA9uQXu8Fvb3Kk-KQ@mail.gmail.com>
 <94ea750cd20efa203a5253b4d6f40a7c7661c87e.camel@linux.ibm.com>
In-Reply-To: <94ea750cd20efa203a5253b4d6f40a7c7661c87e.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 4 Apr 2022 15:59:11 -0700
Message-ID: <CAEf4BzYowuNdOz3M96wM=dxGXUkexfAo8G8KAktOCXgcT7OKpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Support Debian in resolve_full_path()
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>
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

On Mon, Apr 4, 2022 at 3:22 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Mon, 2022-04-04 at 14:58 -0700, Andrii Nakryiko wrote:
> > On Mon, Apr 4, 2022 at 3:29 AM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > attach_probe selftest fails on Debian-based distros with `failed to
> > > resolve full path for 'libc.so.6'`. The reason is that these
> > > distros
> > > embraced multiarch to the point where even for the "main"
> > > architecture
> > > they store libc in /lib/<triple>.
> > >
> > > This is configured in /etc/ld.so.conf and in theory it's possible
> > > to
> > > replicate the loader's parsing and processing logic in libbpf,
> > > however
> > > a much simpler solution is to just enumerate the known library
> > > paths.
> > >
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 54 ++++++++++++++++++++++++++++++++++++--
> > > ----
> > >  1 file changed, 47 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 6d2be53e4ba9..4f616b11564f 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -10707,21 +10707,61 @@ static long elf_find_func_offset(const
> > > char *binary_path, const char *name)
> > >         return ret;
> > >  }
> > >
> > > +static void add_debian_library_paths(const char **search_paths,
> > > int *n)
> > > +{
> > > +       /*
> > > +        * Based on https://packages.debian.org/sid/libc6.
> > > +        *
> > > +        * Assume that the traced program is built for the same
> > > architecture
> > > +        * as libbpf, which should cover the vast majority of
> > > cases.
> > > +        */
> > > +#if defined(__x86_64__)
> >
> > can you please also drop defined() where possible, it looks cleaner
> > to me:
> >
> > #if __x86_64__
> >
> > vs
> >
> > #if defined(__x86_64__)
>
> The consensus in the existing kernel and tools code (including libbpf
> itself) seems to be to use #if defined() or #ifdef for such macros:
>
> $ git grep __x86_64__ | wc -l
> 306
>
> $ git grep __x86_64__ | grep -v \
>     -e '#\s*ifdef __x86_64__' \
>     -e 'defined\s*(__x86_64__)' \
>     -e '#\s*ifndef __x86_64__' \
>     -e '#\s*else' \
>     -e '#\s*endif'
> arch/x86/Makefile:        CHECKFLAGS += -D__x86_64__
> arch/x86/Makefile.um:CHECKFLAGS  += -m64 -D__x86_64__
> tools/lib/bpf/libbpf.c:#if __x86_64__
> tools/testing/selftests/ipc/Makefile:   CFLAGS := -DCONFIG_X86_64 -
> D__x86_64__
> tools/testing/selftests/rcutorture/bin/mkinitrd.sh:if echo -e "#if
> __x86_64__||__i386__||__i486__||__i586__||__i686__" \
> tools/testing/selftests/x86/mov_ss_trap.c:#if __x86_64__
>
> I think `#if __x86_64__` should work in most cases, but I'd rather
> stick with the existing style if you don't mind.

Yeah, that's fine. I felt like #if defined() is unnecessarily verbose,
#ifdef would be totally fine. But looking at latest version, I think
it's fine, mostly due to more linear structure, so it's all good.
