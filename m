Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBC235F4AA
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 15:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351237AbhDNNSp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 09:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351238AbhDNNSo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Apr 2021 09:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618406302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=acWkfu4Z7CO7GGUcaU6n4Bm8bQWjjgP+uqLjmsxyrxA=;
        b=a2ZUTKj0slLi0dEXqq0N8wmqDx59gCZEROJkDYCKrSAR8UK/UCChl7KJTWPuGjX+3l/eGt
        jtJg/eGvSYym6vPuEUvABPal7yeL4qgqBU3SC5arHLduJfF0/uBRw3rHn05aX2A2XvT/4l
        IOCjsngboFGC8eqjRmvZyMCM7tkLWdA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-bWWaGIYTPiqy5RVwNAzlBA-1; Wed, 14 Apr 2021 09:18:18 -0400
X-MC-Unique: bWWaGIYTPiqy5RVwNAzlBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25DB1188E3D3;
        Wed, 14 Apr 2021 13:18:17 +0000 (UTC)
Received: from krava (unknown [10.40.196.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id 58E8B60C9B;
        Wed, 14 Apr 2021 13:18:15 +0000 (UTC)
Date:   Wed, 14 Apr 2021 15:18:14 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kernel-team@fb.com, Sedat Dilek <sedat.dilek@gmail.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next v2 0/5] bpf: tools: support build selftests/bpf
 with clang
Message-ID: <YHbrlsN8UZPWwrzi@krava>
References: <20210412142905.266942-1-yhs@fb.com>
 <CAKwvOdkTUFUwq0Uwi4D9-Z9nbg1FfaP1P2oiBsxNn3+ikT9MwA@mail.gmail.com>
 <CAKwvOdkFWe76ggKrLeckS+mzmyQeq6eJBnkQM1bKgEGQBCspSA@mail.gmail.com>
 <e5f5f6b3-64e6-7068-ca72-9f06f3ffda54@fb.com>
 <CAKwvOdnJsQ-XDcjq=tbXL_iBeJYNk2h8VGwx-sSLWw_LRef6Qg@mail.gmail.com>
 <CAKwvOdkhJgCyEFpXUaMZP4NDho-2YWcNfmF+4P_MprcipB7Ycw@mail.gmail.com>
 <YHYApbcaa1faflw3@krava>
 <CAKwvOd=GfdEd_FZXY+yr9e1xzLaGFkvD4QLNb_52wTVFECHaKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=GfdEd_FZXY+yr9e1xzLaGFkvD4QLNb_52wTVFECHaKQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 13, 2021 at 01:45:39PM -0700, Nick Desaulniers wrote:

SNIP

> > > >
> > > > So I'm not sure precisely what's going on here.  I probably have to go
> > > > digging around to understand tools/build/feature/ anyways.  With your
> > > > v3 applied, I consistently see:
> > > > No zlib found
> > > > and yet, I certainly do have zlib on my host.
> > > > https://stackoverflow.com/a/54558861
> > >
> > > Jiri, any tips on how to debug feature detection in
> > > tools/build/feature/Makefile?
> >
> > for quick check, there's output file for each test, like:
> >
> >         [jolsa@krava feature]$ ls -l *.make.output
> >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-all.make.output
> >         -rw-rw-r--. 1 jolsa jolsa 182 Apr  9 15:52 test-bionic.make.output
> >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-cplus-demangle.make.output
> >         -rw-rw-r--. 1 jolsa jolsa 145 Apr  9 15:52 test-jvmti.make.output
> >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-libbabeltrace.make.output
> >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-libbpf.make.output
> >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-libdebuginfod.make.output
> >         -rw-rw-r--. 1 jolsa jolsa 193 Apr  9 15:52 test-libunwind-aarch64.make.output
> >         -rw-rw-r--. 1 jolsa jolsa 177 Apr  9 15:52 test-libunwind-x86.make.output
> >         [jolsa@krava feature]$ cat test-libunwind-aarch64.make.output
> >         test-libunwind-aarch64.c:2:10: fatal error: libunwind-aarch64.h: No such file or directory
> >             2 | #include <libunwind-aarch64.h>
> >               |          ^~~~~~~~~~~~~~~~~~~~~
> >         compilation terminated.
> >         [jolsa@krava feature]$ cat test-libunwind-x86.make.output
> >         test-libunwind-x86.c:2:10: fatal error: libunwind-x86.h: No such file or directory
> >             2 | #include <libunwind-x86.h>
> >               |          ^~~~~~~~~~~~~~~~~
> >
> > zlib should be done by:
> >         [jolsa@krava feature]$ make test-zlib.bin
> >         gcc  -MD -Wall -Werror -o test-zlib.bin test-zlib.c  > test-zlib.make.output 2>&1 -lz
> >
> >
> > I can try to recreate, how do you build?
> 
> See note above, I'm similarly running precisely:
> $ make LLVM=1 LLVM_IAS=1 -j72 defconfig
> $ make LLVM=1 LLVM_IAS=1 -j72 clean
> $ make LLVM=1 LLVM_IAS=1 -j72 -C tools/testing/selftests/bpf

for some reason I'm stuck with this error on latest bpf-next/master

$ make LLVM=1 LLVM_IAS=1 -C tools/testing/selftests/bpf

make[1]: Nothing to be done for 'docs'.
  CLNG-BPF [test_maps] test_lwt_ip_encap.o
  CLNG-BPF [test_maps] test_tc_edt.o
  CLNG-BPF [test_maps] local_storage.o
progs/local_storage.c:41:15: error: use of undeclared identifier 'BPF_MAP_TYPE_TASK_STORAGE'; did you mean 'BPF_MAP_TYPE_SK_STORAGE'?
        __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
                     ^~~~~~~~~~~~~~~~~~~~~~~~~
                     BPF_MAP_TYPE_SK_STORAGE
/home/jolsa/linux/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:13:39: note: expanded from macro '__uint'
#define __uint(name, val) int (*name)[val]
                                      ^
/home/jolsa/linux/tools/testing/selftests/bpf/tools/include/vmlinux.h:10317:2: note: 'BPF_MAP_TYPE_SK_STORAGE' declared here
        BPF_MAP_TYPE_SK_STORAGE = 24,
        ^
1 error generated.
make: *** [Makefile:448: /home/jolsa/linux/tools/testing/selftests/bpf/local_storage.o] Error 1
make: Leaving directory '/home/jolsa/linux/tools/testing/selftests/bpf'


jirka

