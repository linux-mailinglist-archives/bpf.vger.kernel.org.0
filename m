Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2533A35415D
	for <lists+bpf@lfdr.de>; Mon,  5 Apr 2021 13:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbhDELE7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Apr 2021 07:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbhDELE6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Apr 2021 07:04:58 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4850C061756;
        Mon,  5 Apr 2021 04:04:52 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id k25so4674396iob.6;
        Mon, 05 Apr 2021 04:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=LKcfQyq8DPp4UgPqwpH5DMSMhYuKQItgNTo3FX2vdOY=;
        b=gCSw90ZXGnQqI20WMRreQs6bbXrW9bRIxSvGs+QuwMlc6NC8DTfVoVOcT/aV+um2X7
         4OmfbX69V3vAgzgERim11R5o2DWuE3jVPhHVotc9JClwXYV4auMLBcB53QuV727bMRmb
         54MNgcFBrZgi8Xaxx4EOGU0EwVvlbn5F8f48PIT9gOy772SpIv7xaQFnaSkLS2lXr0XR
         LFfTdssyiTqUo6u/uX2bzIkvnHacNYbYY9Spr6bxr/BDS52ebhYFDggciyU/0ts046Sv
         m1Tdo34Vo+mHhyg91tDa6Pfib12Jg7EChajDroMyVivIH79cdI56gWhJw8qTaa8ojvZN
         HGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=LKcfQyq8DPp4UgPqwpH5DMSMhYuKQItgNTo3FX2vdOY=;
        b=nyDyowJ5xLJvOSnGShJewnRoAshOKcVYZyBVNrj2lKrrVqI2kQB0wenL2PO8G6Q1as
         o/nxwD6xC+oBJS5YimdjDd29nHab+3H7Rq1jHKfnfv5YdDktQq3Yd39VviS1TGl6tAoP
         fICQFOFrhgep4mekN/J3cuD0mYjDAdIyha10YXxA9p8U8Y1CA8Giqth3+M8MNNV7xmAU
         TKImFFHDb+QY5ZAbBXRJqEJGJRDCaY3vmRwStIc4n6pyG/yA4I71Hcthy1NkgDuSp2ys
         25tCeGHWtQkxQ8vrTPVu8XaOH59hGIuYFajK7rkP+q3LvE/vAQ1NU94eTR0kETovpcZ5
         58Hg==
X-Gm-Message-State: AOAM533M+7FijlhO3WdzOd2t+qOuF+aukN7itmwwjItcvQjgeiuJ4PCy
        RA+cf2VGi5laAG2ASqVkjVUqqo+S7YZxhisU+cM=
X-Google-Smtp-Source: ABdhPJzQAaSVM4Gm8crkWmB0TSJ+JxZgmzcvPzYESrybZb8Nf7KMEfiP5l9hp3lZL+dwjCh63mgmQINTlAp6MwIkMXw=
X-Received: by 2002:a02:b890:: with SMTP id p16mr23003486jam.138.1617620692349;
 Mon, 05 Apr 2021 04:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210403184158.2834387-1-yhs@fb.com> <CA+icZUWLf4W_1u_p4-Rx1OD7h_ydP4Xzv12tMA2HZqj9CCOH0Q@mail.gmail.com>
 <6c67f02a-3bc2-625a-3b05-7eb3533044bb@fb.com> <CA+icZUV4fw5GNXFnyOjvajkVFdPhkOrhr3rn5OrAKGujpSrmgQ@mail.gmail.com>
 <CA+icZUWh6YOkCKG72SndqUbQNwG+iottO4=cPyRRVjaHD2=0qw@mail.gmail.com>
 <f706e8b9-77ca-6341-db13-e2a74549576b@fb.com> <CA+icZUVb_J95Gk2Kf0i8waL6TDfJ2n9JrGbNK_dsN1n8HdcoXQ@mail.gmail.com>
 <458faf4c-7681-13eb-023d-c51f582bfec6@fb.com> <CA+icZUVcQ+vQjc0VavetA3s6jzNhC20dU4Sa9ApBLNXbY=w5wA@mail.gmail.com>
In-Reply-To: <CA+icZUVcQ+vQjc0VavetA3s6jzNhC20dU4Sa9ApBLNXbY=w5wA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 5 Apr 2021 13:04:18 +0200
Message-ID: <CA+icZUUa_gad43TeUC8Ufz0kMgXMQoFy9a_hwzPwOPZHNfmNeA@mail.gmail.com>
Subject: Re: [PATCH dwarves] dwarf_loader: handle DWARF5 DW_OP_addrx properly
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
        David Blaikie <dblaikie@gmail.com>, kernel-team@fb.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I hoped to drop "test_core_extern.skel.h"
tools/testing/selftests/bpf/Makefile as test_cpp.cpp includes it:

$ git grep include tools/testing/selftests/bpf/test_cpp.cpp
tools/testing/selftests/bpf/test_cpp.cpp:#include "test_core_extern.skel.h"

$ git diff
diff --git a/tools/testing/selftests/bpf/Makefile
b/tools/testing/selftests/bpf/Makefile
index 044bfdcf5b74..a93e4d6ff93c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -450,7 +450,7 @@ $(OUTPUT)/test_verifier: test_verifier.c
verifier/tests.h $(BPFOBJ) | $(OUTPUT)
       $(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@

# Make sure we are able to include and link libbpf against c++.
-$(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
+$(OUTPUT)/test_cpp: test_cpp.cpp $(BPFOBJ)
       $(call msg,CXX,,$@)
       $(Q)$(CXX) $(CFLAGS) $^ $(LDLIBS) -o $@

When using g++:

$ llvm-objdump-12 -Dr test_cpp | grep test_core_extern
   77dd: e8 be 01 00 00                callq   0x79a0
<_ZL25test_core_extern__destroyP16test_core_extern>
   7842: e8 59 01 00 00                callq   0x79a0
<_ZL25test_core_extern__destroyP16test_core_extern>
00000000000079a0 <_ZL25test_core_extern__destroyP16test_core_extern>:
   79a3: 74 1a                         je      0x79bf
<_ZL25test_core_extern__destroyP16test_core_extern+0x1f>
   79af: 74 05                         je      0x79b6
<_ZL25test_core_extern__destroyP16test_core_extern+0x16>
   799e: 74 06                         je      0x79a6
<_ZL25test_core_extern__destroyP16test_core_extern+0x6>
   7942: 73 61                         jae     0x79a5
<_ZL25test_core_extern__destroyP16test_core_extern+0x5>
   7945: 70 6c                         jo      0x79b3
<_ZL25test_core_extern__destroyP16test_core_extern+0x13>
   794b: 70 65                         jo      0x79b2
<_ZL25test_core_extern__destroyP16test_core_extern+0x12>
   7954: 73 5f                         jae     0x79b5
<_ZL25test_core_extern__destroyP16test_core_extern+0x15>
   79aa: 79 00                         jns     0x79ac
<_ZL25test_core_extern__destroyP16test_core_extern+0xc>

When using clang++-12:

$ llvm-objdump-12 -Dr test_cpp | grep test_core_extern
[ empty ]

Last I tried:

selftests-bpf-Makefile-EXTRA_CXXFLAGS-x-c-header.diff
diff --git a/tools/testing/selftests/bpf/Makefile
b/tools/testing/selftests/bpf/Makefile
index 044bfdcf5b74..df07fd9325d0 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -27,6 +27,7 @@ CFLAGS += -g -rdynamic -Wall -O2 $(GENFLAGS)
$(SAN_CFLAGS)            \
         -Dbpf_prog_load=bpf_prog_test_load                            \
         -Dbpf_load_program=bpf_test_load_program
LDLIBS += -lcap -lelf -lz -lrt -lpthread
+EXTRA_CXXFLAGS := -x c-header

# Order correspond to 'make run_tests' order
TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map
test_lpm_map test_progs \
@@ -452,7 +453,7 @@ $(OUTPUT)/test_verifier: test_verifier.c
verifier/tests.h $(BPFOBJ) | $(OUTPUT)
# Make sure we are able to include and link libbpf against c++.
$(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
       $(call msg,CXX,,$@)
-       $(Q)$(CXX) $(CFLAGS) $^ $(LDLIBS) -o $@
+       $(Q)$(CXX) $(CFLAGS) $(EXTRA_CXXFLAGS) $^ $(LDLIBS) -o $@

# Benchmark runner
$(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h

NOPE.

- Sedat -
