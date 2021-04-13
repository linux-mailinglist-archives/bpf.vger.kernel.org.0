Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EEA35E7A3
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 22:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhDMUgm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 16:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229914AbhDMUgm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Apr 2021 16:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618346181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WTY3hhv4d7/Xxm5AZyz+178fLEqQaYg9wqasB6pga1c=;
        b=RU81+piAguUXb59dGJ8CLxyVknevEEj4CS9HRuNH4P4wdOyE5HMUlNm/fJREpyE5NfNVtg
        09PPyEalBg0DT8yqo1axHgemWNt2fIG2Jg4rzyMH0SBXW6gNsZXES83b0USL1wMFN9gn5+
        dSwlgqmtf7eKM0jkbwglFaOKdwERPQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-ZqxKfaZ9MQqIICUGbshbUg-1; Tue, 13 Apr 2021 16:36:17 -0400
X-MC-Unique: ZqxKfaZ9MQqIICUGbshbUg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A04498E6E6F;
        Tue, 13 Apr 2021 20:35:52 +0000 (UTC)
Received: from krava (unknown [10.40.192.129])
        by smtp.corp.redhat.com (Postfix) with SMTP id CC8631084392;
        Tue, 13 Apr 2021 20:35:50 +0000 (UTC)
Date:   Tue, 13 Apr 2021 22:35:49 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kernel-team@fb.com, Sedat Dilek <sedat.dilek@gmail.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next v2 0/5] bpf: tools: support build selftests/bpf
 with clang
Message-ID: <YHYApbcaa1faflw3@krava>
References: <20210412142905.266942-1-yhs@fb.com>
 <CAKwvOdkTUFUwq0Uwi4D9-Z9nbg1FfaP1P2oiBsxNn3+ikT9MwA@mail.gmail.com>
 <CAKwvOdkFWe76ggKrLeckS+mzmyQeq6eJBnkQM1bKgEGQBCspSA@mail.gmail.com>
 <e5f5f6b3-64e6-7068-ca72-9f06f3ffda54@fb.com>
 <CAKwvOdnJsQ-XDcjq=tbXL_iBeJYNk2h8VGwx-sSLWw_LRef6Qg@mail.gmail.com>
 <CAKwvOdkhJgCyEFpXUaMZP4NDho-2YWcNfmF+4P_MprcipB7Ycw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkhJgCyEFpXUaMZP4NDho-2YWcNfmF+4P_MprcipB7Ycw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 13, 2021 at 11:56:33AM -0700, Nick Desaulniers wrote:
> On Tue, Apr 13, 2021 at 11:46 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Mon, Apr 12, 2021 at 5:31 PM Yonghong Song <yhs@fb.com> wrote:
> > >
> > >
> > >
> > > On 4/12/21 5:02 PM, Nick Desaulniers wrote:
> > > > On Mon, Apr 12, 2021 at 4:58 PM Nick Desaulniers
> > > > <ndesaulniers@google.com> wrote:
> > > >>
> > > >> On Mon, Apr 12, 2021 at 7:29 AM Yonghong Song <yhs@fb.com> wrote:
> > > >>>
> > > >>> To build kernel with clang, people typically use
> > > >>>    make -j60 LLVM=1 LLVM_IAS=1
> > > >>> LLVM_IAS=1 is not required for non-LTO build but
> > > >>> is required for LTO build. In my environment,
> > > >>> I am always having LLVM_IAS=1 regardless of
> > > >>> whether LTO is enabled or not.
> > > >>>
> > > >>> After kernel is build with clang, the following command
> > > >>> can be used to build selftests with clang:
> > > >>>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
> > > >>
> > > >> Thank you for the series Yonghong.  When I test the above command with
> > > >> your series applied, I observe:
> > > >> tools/include/tools/libc_compat.h:11:21: error: static declaration of
> > > >> 'reallocarray' follows non-static declaration
> > > >> static inline void *reallocarray(void *ptr, size_t nmemb, size_t size)
> > > >>                      ^
> > > >> /usr/include/stdlib.h:559:14: note: previous declaration is here
> > > >> extern void *reallocarray (void *__ptr, size_t __nmemb, size_t __size)
> > > >>               ^
> > > >> so perhaps the detection of
> > > >> COMPAT_NEED_REALLOCARRAY/feature-reallocarray is incorrect?
> > > >
> > > > Is this related to _DEFAULT_SOURCE vs _GNU_SOURCE.  via man 3 reallocarray:
> > > >         reallocarray():
> > > >             Since glibc 2.29:
> > > >                 _DEFAULT_SOURCE
> > > >             Glibc 2.28 and earlier:
> > > >                 _GNU_SOURCE
> > > >
> > >
> > > You can try the following patch to see whether it works or not.
> > >
> > > diff --git a/tools/build/feature/test-reallocarray.c
> > > b/tools/build/feature/test-reallocarray.c
> > > index 8f6743e31da7..500cdeca07a7 100644
> > > --- a/tools/build/feature/test-reallocarray.c
> > > +++ b/tools/build/feature/test-reallocarray.c
> > > @@ -1,5 +1,5 @@
> > >   // SPDX-License-Identifier: GPL-2.0
> > > -#define _GNU_SOURCE
> > > +#define _DEFAULT_SOURCE
> > >   #include <stdlib.h>
> > >
> > >   int main(void)
> > > @@ -7,4 +7,4 @@ int main(void)
> > >          return !!reallocarray(NULL, 1, 1);
> > >   }
> > >
> > > -#undef _GNU_SOURCE
> > > +#undef _DEFAULT_SOURCE
> >
> > Yeah, I had tried that. No luck though; same error message.  Even:
> >
> > $ cat foo.c
> > #define _DEFAULT_SOURCE
> > #include <stdlib.h>
> > void *reallocarray(void *ptr, size_t nmemb, size_t size) { return (void*)0; };
> > $ clang -c foo.c
> > $ echo $?
> > 0
> >
> > So I'm not sure precisely what's going on here.  I probably have to go
> > digging around to understand tools/build/feature/ anyways.  With your
> > v3 applied, I consistently see:
> > No zlib found
> > and yet, I certainly do have zlib on my host.
> > https://stackoverflow.com/a/54558861
> 
> Jiri, any tips on how to debug feature detection in
> tools/build/feature/Makefile?

for quick check, there's output file for each test, like:

	[jolsa@krava feature]$ ls -l *.make.output
	-rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-all.make.output
	-rw-rw-r--. 1 jolsa jolsa 182 Apr  9 15:52 test-bionic.make.output
	-rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-cplus-demangle.make.output
	-rw-rw-r--. 1 jolsa jolsa 145 Apr  9 15:52 test-jvmti.make.output
	-rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-libbabeltrace.make.output
	-rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-libbpf.make.output
	-rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-libdebuginfod.make.output
	-rw-rw-r--. 1 jolsa jolsa 193 Apr  9 15:52 test-libunwind-aarch64.make.output
	-rw-rw-r--. 1 jolsa jolsa 177 Apr  9 15:52 test-libunwind-x86.make.output
	[jolsa@krava feature]$ cat test-libunwind-aarch64.make.output
	test-libunwind-aarch64.c:2:10: fatal error: libunwind-aarch64.h: No such file or directory
	    2 | #include <libunwind-aarch64.h>
	      |          ^~~~~~~~~~~~~~~~~~~~~
	compilation terminated.
	[jolsa@krava feature]$ cat test-libunwind-x86.make.output
	test-libunwind-x86.c:2:10: fatal error: libunwind-x86.h: No such file or directory
	    2 | #include <libunwind-x86.h>
	      |          ^~~~~~~~~~~~~~~~~

zlib should be done by:
	[jolsa@krava feature]$ make test-zlib.bin
	gcc  -MD -Wall -Werror -o test-zlib.bin test-zlib.c  > test-zlib.make.output 2>&1 -lz


I can try to recreate, how do you build?

jirka

