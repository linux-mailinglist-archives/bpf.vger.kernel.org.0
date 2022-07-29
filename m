Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521F558547D
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 19:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbiG2R3X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 13:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbiG2R3U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 13:29:20 -0400
Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D9D2ED64
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 10:29:14 -0700 (PDT)
Received: from SPMA-04.tubit.win.tu-berlin.de (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 8B8959721BE_2E418E8B;
        Fri, 29 Jul 2022 17:29:12 +0000 (GMT)
Received: from mail.tu-berlin.de (postcard.tu-berlin.de [141.23.12.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "exchange.tu-berlin.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by SPMA-04.tubit.win.tu-berlin.de (Sophos Email Appliance) with ESMTPS id 6D6E8970B50_2E418E7F;
        Fri, 29 Jul 2022 17:29:11 +0000 (GMT)
Message-ID: <019ea70d45ba155775a82e3648eab38007b8dc60.camel@mailbox.tu-berlin.de>
Subject: Re: [RFC PATCH bpf-next] bpftool: Mark generated skeleton headers
 as system headers
From:   =?ISO-8859-1?Q?J=F6rn-Thorben?= Hinz <jthinz@mailbox.tu-berlin.de>
To:     Yonghong Song <yhs@fb.com>, <bpf@vger.kernel.org>
CC:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 29 Jul 2022 19:29:09 +0200
In-Reply-To: <7d4af6b4-f4da-f004-48a1-e408d8615ee8@fb.com>
References: <20220728165644.660530-1-jthinz@mailbox.tu-berlin.de>
         <7d4af6b4-f4da-f004-48a1-e408d8615ee8@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SASI-RCODE: 200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=campus.tu-berlin.de; h=message-id:subject:from:to:cc:date:in-reply-to:references:content-type:mime-version:content-transfer-encoding; s=dkim-tub; bh=xUdQtH19TS413XTXupndbNNf+juPRRXSFdePbx9NzHQ=; b=Um4+4DAk0LNVYdO8eQinrnAJX0yJOeTIxg6LglnYCmUSftF5yoHpTvaotXMxR6tGRnzi7LphyKQmYolHnpmtOkcyIZopOlP+mArigBVKbhbP/n2hHInD3OJZO/TsWZwkBqIK7h/Ze7OAixsOfVhkad62pfZtI/8rkevtUoMDlfQ=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2022-07-28 at 11:25 -0700, Yonghong Song wrote:
> 
> 
> On 7/28/22 9:56 AM, Jörn-Thorben Hinz wrote:
> > Hi,
> > 
> > after compiling a skeleton-using program with -pedantic once and
> > stumbling across a tiniest incorrectness in skeletons with it[1], I
> > was
> > debating whether it makes sense to suppress warnings from skeleton
> > headers.
> > 
> > Happy about comments about this. This change might be too
> > suppressive
> > towards warnings and maybe ignoring only -Woverlength-strings
> > directly
> > in OBJ_NAME__elf_bytes() be a better idea. Or keep all warnings
> > from
> > skeletons available as-is to have them more visible in and around
> > bpftool’s development.
> 
> This is my 2cents.
Thanks for the comment, Yonghong.

> As you mentioned, skeleton file are per program
> and not in system header file directory. I would like not to mark
> these header files as system files. Since different program will
> generate different skeleton headers, suppressing warnings
> will prevent from catching potential issues in certain cases.
I admittedly didn’t take a full detailed look at it. But isn’t the
general skeleton structure rather static, with only small differences
depending on e.g. the sections, maps present in a BPF object?

> 
> Also, since the warning is triggered by extra user flags like -
> pedantic
> when building bpftool, user can also add -Wno-overlength-strings
> in the extra user flags.
Maybe I should have worded it more clearly. This was not about somebody
adding flags to the build of bpftool itself. But rather about later
using bpftool (prebuilt by your distribution, maybe) to generate a
skeleton for some foreign BPF object/program.

That foreign program could use various compiler flags, which are
outside of the reach of bpftool. But that foreign program also does not
have any influence on the content on the skeleton header. Unless
somebody wants to patch it after generating it (very unlikely).

So I looked at it mostly as a non-kernel-developer user of bpftool.
From that view, I feel like a skeleton header should behave like any
library header and not produce unnecessary warnings in a program
including it. Like e.g header files from /usr/include, which are, well,
usually implicitly identified as system headers :-)

In the build of bpftool, I explicitly skipped the pragmas. So any
warning caused by the two skeletons generated and used during bpftool’s
build process (pid_iter.skel.h and profiler.skel.h) will still be
visible.

Would it be an idea to by default apply this patch (or a similar one),
but build the bpftool in selftests/bpf with a flag that keeps all
warnings available? — like the -DBPFTOOL_BOOTSTRAP below already
achieves, that flag could be renamed. bpftool is apparently already
built with slightly different CFLAGS for the selftests.

To add that: I’m aware this patch is probably nit-picky and the
warnings, if even, a very minor issue.

> 
> > 
> > [1] 
> > https://lore.kernel.org/r/20220726133203.514087-1-jthinz@mailbox.tu-berlin.de/
> > 
> > Commit message:
> > 
> > A userspace program including a skeleton generated by bpftool might
> > use
> > an arbitrary set of compiler flags, including enabling various
> > warnings.
> > 
> > For example, with -Woverlength-strings the string constant in
> > OBJ_NAME__elf_bytes() causes a warning due to its usually huge
> > length.
> > This string length is not an actual problem with GCC and clang,
> > though,
> > it’s “just” not required by the C standard to be supported.
> > 
> > Skeleton headers are likely not placed in a system include path. To
> > avoid the above warning and similar noise for the *user* of a
> > skeleton,
> > explicitly mark the header as a system header which disables almost
> > all
> > warnings for it when included.
> > 
> > Skeleton headers generated during the build of bpftool are not
> > marked to
> > keep potential warnings available to bpftool’s developers.
> > 
> > Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
> > ---
> >   tools/bpf/bpftool/Makefile |  2 ++
> >   tools/bpf/bpftool/gen.c    | 30 +++++++++++++++++++++++++++---
> >   2 files changed, 29 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/bpf/bpftool/Makefile
> > b/tools/bpf/bpftool/Makefile
> > index 6b5b3a99f79d..5f484d7929db 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -196,6 +196,8 @@ endif
> >   
> >   CFLAGS += $(if $(BUILD_BPF_SKELS),,-DBPFTOOL_WITHOUT_SKELETONS)
> >   
> > +$(BOOTSTRAP_OUTPUT)%.o: CFLAGS += -DBPFTOOL_BOOTSTRAP
> > +
> >   $(BOOTSTRAP_OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
> >         $(QUIET_CC)$(HOSTCC) $(HOST_CFLAGS) -c -MMD $< -o $@
> >   
> > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > index 1cf53bb01936..82053aceec78 100644
> > --- a/tools/bpf/bpftool/gen.c
> > +++ b/tools/bpf/bpftool/gen.c
> > @@ -1006,7 +1006,15 @@ static int do_skeleton(int argc, char
> > **argv)
> >                 /* THIS FILE IS AUTOGENERATED BY BPFTOOL!
> > */                \n\
> >                 #ifndef
> > %2$s                                                \n\
> >                 #define
> > %2$s                                                \n\
> > -
> >                                                                     
> >        \n\
> > +               "
> > +#ifndef BPFTOOL_BOOTSTRAP
> > +               "\
> > +               \n\
> > +               _Pragma(\"GCC
> > system_header\")                              \n\
> > +               "
> > +#endif
> > +               "\
> > +               \n\
> >                 #include
> > <bpf/skel_internal.h>                              \n\
> >                                                                    
> >          \n\
> >                 struct %1$s
> > {                                               \n\
> > @@ -1022,7 +1030,15 @@ static int do_skeleton(int argc, char
> > **argv)
> >                 /* THIS FILE IS AUTOGENERATED BY BPFTOOL!
> > */                \n\
> >                 #ifndef
> > %2$s                                                \n\
> >                 #define
> > %2$s                                                \n\
> > -
> >                                                                     
> >        \n\
> > +               "
> > +#ifndef BPFTOOL_BOOTSTRAP
> > +               "\
> > +               \n\
> > +               _Pragma(\"GCC
> > system_header\")                              \n\
> > +               "
> > +#endif
> > +               "\
> > +               \n\
> >                 #include
> > <errno.h>                                          \n\
> >                 #include
> > <stdlib.h>                                         \n\
> >                 #include
> > <bpf/libbpf.h>                                     \n\
> > @@ -1415,7 +1431,15 @@ static int do_subskeleton(int argc, char
> > **argv)
> >         /* THIS FILE IS AUTOGENERATED!
> > */                                   \n\
> >         #ifndef
> > %2$s                                                        \n\
> >         #define
> > %2$s                                                        \n\
> > -
> >                                                                     
> >        \n\
> > +               "
> > +#ifndef BPFTOOL_BOOTSTRAP
> > +       "\
> > +       \n\
> > +       _Pragma(\"GCC
> > system_header\")                                      \n\
> > +       "
> > +#endif
> > +       "\
> > +       \n\
> >         #include
> > <errno.h>                                                  \n\
> >         #include
> > <stdlib.h>                                                 \n\
> >         #include
> > <bpf/libbpf.h>                                             \n\


