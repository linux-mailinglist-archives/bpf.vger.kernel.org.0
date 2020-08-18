Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0092C2482D9
	for <lists+bpf@lfdr.de>; Tue, 18 Aug 2020 12:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgHRKUx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Aug 2020 06:20:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43164 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgHRKUw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 18 Aug 2020 06:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597746050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pT1phLHGEAuANaEb5B3e0Ka/xZccNpYnDnuH62QNT9k=;
        b=XhBoK+z1+P573WUY38S/318z75JhO8xrCM3cm7zaBfGz+6YgCMBmXU46ZM1VbrHlpQV1wN
        va49hTpSxe18fRZ2AMK4jvexARBk1lzQMsGZKFBksWeARU3b5UoZzLpebFAyvaRUpQPtJD
        IMLMeqI7sdSk1N9eUKSfB0bu/PXDbww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-V_4vSy4fMn6KdLHUfNulAA-1; Tue, 18 Aug 2020 06:20:48 -0400
X-MC-Unique: V_4vSy4fMn6KdLHUfNulAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6193D100CF6A;
        Tue, 18 Aug 2020 10:20:47 +0000 (UTC)
Received: from carbon (unknown [10.40.208.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C8915C1DC;
        Tue, 18 Aug 2020 10:20:42 +0000 (UTC)
Date:   Tue, 18 Aug 2020 12:20:41 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     brouer@redhat.com, linux-kbuild@vger.kernel.org,
        BPF-dev-list <bpf@vger.kernel.org>
Subject: Tools build error due to "Auto-detecting system features" missing
 cleanup
Message-ID: <20200818122007.2d1cfe2d@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Started as a build error for bpftool. On latest DaveM net-git tree
(06a4ec1d9dc652), I got this build error, when building the bpftool:

 cd tools/bpf/bpftool
 $ make
=20
 Auto-detecting system features:
 ...                        libbfd: [ on  ]
 ...        disassembler-four-args: [ on  ]
 ...                          zlib: [ on  ]
 ...                        libcap: [ on  ]
 ...               clang-bpf-co-re: [ on  ]
=20
   CC       map_perf_ring.o
 In file included from main.h:15,
                  from map_perf_ring.c:27:
 /home/jbrouer/git/kernel/net/tools/include/tools/libc_compat.h:11:21: erro=
r: static declaration of =E2=80=98reallocarray=E2=80=99 follows non-static =
declaration
    11 | static inline void *reallocarray(void *ptr, size_t nmemb, size_t s=
ize)
       |                     ^~~~~~~~~~~~
 In file included from map_perf_ring.c:14:
 /usr/include/stdlib.h:559:14: note: previous declaration of =E2=80=98reall=
ocarray=E2=80=99 was here
   559 | extern void *reallocarray (void *__ptr, size_t __nmemb, size_t __s=
ize)
       |              ^~~~~~~~~~~~
 make: *** [Makefile:177: map_perf_ring.o] Error 1

This were related to tools/build/feature ("Auto-detecting system features")
that had a stalled version of the test-reallocarray.d file:

In /home/jbrouer/git/kernel/net/tools/build/feature:

 $ ll *realloc*
 -rw-rw-r--. 1 jbrouer jbrouer  152 Oct 30  2019 test-reallocarray.c
 -rw-rw-r--. 1 jbrouer jbrouer 1156 Oct 30  2019 test-reallocarray.d
 -rw-rw-r--. 1 jbrouer jbrouer  321 Oct 30  2019 test-reallocarray.make.out=
put

The 'make clean' target doesn't cleanup enough for the feature-test to be
compiled again. (Tested both make clean in tools/build/ and tools/bpf/bpfto=
ol).

If I delete test-reallocarray.d, then the feature-test is recompiled and I =
don't
get the error (as reallocarray is avail on this system). Files avail now:

In /home/jbrouer/git/kernel/net/tools/build/feature:

 $ ll *realloc*
 -rwxrwxr-x. 1 jbrouer jbrouer 21992 Aug 18 11:29 test-reallocarray.bin
 -rw-rw-r--. 1 jbrouer jbrouer   152 Oct 30  2019 test-reallocarray.c
 -rw-rw-r--. 1 jbrouer jbrouer  1398 Aug 18 11:29 test-reallocarray.d
 -rw-rw-r--. 1 jbrouer jbrouer     0 Aug 18 11:29 test-reallocarray.make.ou=
tput

Thus, given test-reallocarray.bin exist the compile test was success. This
indicate that my Fedora system in Oct 2019 didn't support reallocarray and
needed the workaround in tools/include/tools/libc_compat.h. I likely did so=
me
upgrade or install some RPM in the meanwhile that changed the situation.
Regardless of how this got stalled, this needs to be fixed.

I propose that the make clean target should cause the feature tests to be
recompiled. Below change to tools/build/Makefile solves the issue locally in
tools/build/, but this isn't triggered when calling make clean in other too=
ls
directories that use the feature tests.

What is the correct make clean fix?
- -=20
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

diff --git a/tools/build/Makefile b/tools/build/Makefile
index 727050c40f09..a59e60ecf5ad 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -37,6 +37,7 @@ all: $(OUTPUT)fixdep
 clean:
        $(call QUIET_CLEAN, fixdep)
        $(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '=
\.*.cmd' -delete -o -name '\.*.d' -delete
+       $(Q)find $(if $(OUTPUT),$(OUTPUT),.)/feature -name '*.d' -delete -o=
 -name '*.make.output' -delete
        $(Q)rm -f $(OUTPUT)fixdep
=20
 $(OUTPUT)fixdep-in.o: FORCE




My distro:

$ lsb_release  -a
LSB Version:	:core-4.1-amd64:core-4.1-noarch
Distributor ID:	Fedora
Description:	Fedora release 31 (Thirty One)
Release:	31
Codename:	ThirtyOne

