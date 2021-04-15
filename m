Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0D7361440
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 23:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbhDOVkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 17:40:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58804 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235046AbhDOVkX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Apr 2021 17:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618522800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JBe/BEtXdRbDY34GCFVI0bWyqwQ/WU8q5htZwMBSYZQ=;
        b=MxVfsomPHFYniuPHoB50m8CdNQXeyhUvzw/y9BU9nHnSPqkmvzsUeH88WmP47CSeKRPNXU
        kEMOhb175gMiA8D/OqnRy7k4kAem+P/BiQSk3frujPeTZJP4wf/uXIeJBoQE2fuxxMqzKK
        2qR7nOnpzSlB0IYHPTyHe/bfgFhn7pg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-olacmCUyON-Cd2N79B9Yyg-1; Thu, 15 Apr 2021 17:39:56 -0400
X-MC-Unique: olacmCUyON-Cd2N79B9Yyg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A9F28189C7;
        Thu, 15 Apr 2021 21:39:54 +0000 (UTC)
Received: from krava (unknown [10.40.196.6])
        by smtp.corp.redhat.com (Postfix) with SMTP id AADFD19C93;
        Thu, 15 Apr 2021 21:39:52 +0000 (UTC)
Date:   Thu, 15 Apr 2021 23:39:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Sedat Dilek <sedat.dilek@gmail.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next v2 0/5] bpf: tools: support build selftests/bpf
 with clang
Message-ID: <YHiyp1lAPzosRkez@krava>
References: <e5f5f6b3-64e6-7068-ca72-9f06f3ffda54@fb.com>
 <CAKwvOdnJsQ-XDcjq=tbXL_iBeJYNk2h8VGwx-sSLWw_LRef6Qg@mail.gmail.com>
 <CAKwvOdkhJgCyEFpXUaMZP4NDho-2YWcNfmF+4P_MprcipB7Ycw@mail.gmail.com>
 <YHYApbcaa1faflw3@krava>
 <CAKwvOd=GfdEd_FZXY+yr9e1xzLaGFkvD4QLNb_52wTVFECHaKQ@mail.gmail.com>
 <YHbrlsN8UZPWwrzi@krava>
 <CAEf4Bzb2YcH+dwhMyd5gRsjmzwGjxjjdSbqHn6zkcesF8J7Jwg@mail.gmail.com>
 <YHg+QFL0O5eOHD+7@krava>
 <CAKwvOdmozSv4Zb1F_gn+__OZgRmkCsBfkH3dGzVR+nQr0RrePQ@mail.gmail.com>
 <YHh1Lzl0qS9eniT7@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHh1Lzl0qS9eniT7@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 15, 2021 at 07:17:35PM +0200, Jiri Olsa wrote:
> On Thu, Apr 15, 2021 at 09:55:50AM -0700, Nick Desaulniers wrote:
> > On Thu, Apr 15, 2021 at 6:23 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Wed, Apr 14, 2021 at 05:16:01PM -0700, Andrii Nakryiko wrote:
> > > > On Wed, Apr 14, 2021 at 6:18 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > >
> > > > > On Tue, Apr 13, 2021 at 01:45:39PM -0700, Nick Desaulniers wrote:
> > > > >
> > > > > SNIP
> > > > >
> > > > > > > > >
> > > > > > > > > So I'm not sure precisely what's going on here.  I probably have to go
> > > > > > > > > digging around to understand tools/build/feature/ anyways.  With your
> > > > > > > > > v3 applied, I consistently see:
> > > > > > > > > No zlib found
> > > > > > > > > and yet, I certainly do have zlib on my host.
> > > > > > > > > https://stackoverflow.com/a/54558861
> > > > > > > >
> > > > > > > > Jiri, any tips on how to debug feature detection in
> > > > > > > > tools/build/feature/Makefile?
> > > > > > >
> > > > > > > for quick check, there's output file for each test, like:
> > > > > > >
> > > > > > >         [jolsa@krava feature]$ ls -l *.make.output
> > > > > > >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-all.make.output
> > > > > > >         -rw-rw-r--. 1 jolsa jolsa 182 Apr  9 15:52 test-bionic.make.output
> > > > > > >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-cplus-demangle.make.output
> > > > > > >         -rw-rw-r--. 1 jolsa jolsa 145 Apr  9 15:52 test-jvmti.make.output
> > > > > > >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-libbabeltrace.make.output
> > > > > > >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-libbpf.make.output
> > > > > > >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-libdebuginfod.make.output
> > > > > > >         -rw-rw-r--. 1 jolsa jolsa 193 Apr  9 15:52 test-libunwind-aarch64.make.output
> > > > > > >         -rw-rw-r--. 1 jolsa jolsa 177 Apr  9 15:52 test-libunwind-x86.make.output
> > > > > > >         [jolsa@krava feature]$ cat test-libunwind-aarch64.make.output
> > > > > > >         test-libunwind-aarch64.c:2:10: fatal error: libunwind-aarch64.h: No such file or directory
> > > > > > >             2 | #include <libunwind-aarch64.h>
> > > > > > >               |          ^~~~~~~~~~~~~~~~~~~~~
> > > > > > >         compilation terminated.
> > > > > > >         [jolsa@krava feature]$ cat test-libunwind-x86.make.output
> > > > > > >         test-libunwind-x86.c:2:10: fatal error: libunwind-x86.h: No such file or directory
> > > > > > >             2 | #include <libunwind-x86.h>
> > > > > > >               |          ^~~~~~~~~~~~~~~~~
> > > > > > >
> > > > > > > zlib should be done by:
> > > > > > >         [jolsa@krava feature]$ make test-zlib.bin
> > > > > > >         gcc  -MD -Wall -Werror -o test-zlib.bin test-zlib.c  > test-zlib.make.output 2>&1 -lz
> > > > > > >
> > > > > > >
> > > > > > > I can try to recreate, how do you build?
> > > > > >
> > > > > > See note above, I'm similarly running precisely:
> > > > > > $ make LLVM=1 LLVM_IAS=1 -j72 defconfig
> > > > > > $ make LLVM=1 LLVM_IAS=1 -j72 clean
> > > > > > $ make LLVM=1 LLVM_IAS=1 -j72 -C tools/testing/selftests/bpf
> > > > >
> > > > > for some reason I'm stuck with this error on latest bpf-next/master
> > > >
> > > > did you build vmlinux image before building selftests? those enums
> > > > should come through vmlinux.h from up-to-date vmlinux
> > >
> > > it was there.. but I found the clang/lld I compiled can't link properly,
> > > which is probably unrelated to the error below, but I need to solve it
> > > first ;-)
> > 
> > Do you have more info about what command you're running, or what error
> > you're observing?  The kernel itself is not linking for you?
> 
> I did the commands you sent, but I might have but llvm/clang build,
> I'm rebuilding now, it takes forever.. 

ok, finished all commands finaly.. did not reproduce the issue :-\
any luck with those build make.output files for zlib?

jirka

