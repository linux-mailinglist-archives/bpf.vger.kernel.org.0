Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8571DAA79
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 08:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgETGQf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 02:16:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55336 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726224AbgETGQe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 02:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589955392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OMQ9IJD9O1/jeNpFpeWM7Xv9tCq8zAdhnCdDGCrzgkY=;
        b=bg5G/yUmWCzwHF3U+Ldrp0GDaq5lAC0eGOqH6wIYdPKLBBJc7leFPwCMo+ek/jMLkawluF
        XdMnZD51bLauRJVJtWEG1CO1TJwzK/GWiqrR8UVE+6xoCqu/l+7hcgfXaCfsqTojt0AebQ
        tIkihDJS2QUKfP4I/rShQSliQyH4EGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-w7_Sz8eQMp2dGlHFcSmTHQ-1; Wed, 20 May 2020 02:16:28 -0400
X-MC-Unique: w7_Sz8eQMp2dGlHFcSmTHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EC90835B43;
        Wed, 20 May 2020 06:16:27 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-168.ams2.redhat.com [10.36.112.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E87852E162;
        Wed, 20 May 2020 06:16:25 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] selftests/bpf: install btf .c files
References: <20200519084957.55166-1-yauheni.kaliuta@redhat.com>
        <CAEf4Bzb-FjHtH9dyVtjZf7FYBB2BiPs0mK8ZoqH3B9iU5Hz7Mg@mail.gmail.com>
Date:   Wed, 20 May 2020 09:16:23 +0300
In-Reply-To: <CAEf4Bzb-FjHtH9dyVtjZf7FYBB2BiPs0mK8ZoqH3B9iU5Hz7Mg@mail.gmail.com>
        (Andrii Nakryiko's message of "Tue, 19 May 2020 12:09:36 -0700")
Message-ID: <xuny7dx7nnbc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Andrii!

>>>>> On Tue, 19 May 2020 12:09:36 -0700, Andrii Nakryiko  wrote:

 > On Tue, May 19, 2020 at 1:50 AM Yauheni Kaliuta
 > <yauheni.kaliuta@redhat.com> wrote:
 >> 
 >> Some .c files used by test_progs to check btf and they are missing
 >> from installation after commit 74b5a5968fe8 ("selftests/bpf: Replace
 >> test_progs and test_maps w/ general rule").
 >> 
 >> Take them back.
 >> 
 >> Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and
 >> test_maps w/ general rule")
 >> 
 >> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
 >> ---
 >> tools/testing/selftests/bpf/Makefile | 3 +++
 >> 1 file changed, 3 insertions(+)
 >> 
 >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
 >> index e716e931d0c9..d96440732905 100644
 >> --- a/tools/testing/selftests/bpf/Makefile
 >> +++ b/tools/testing/selftests/bpf/Makefile
 >> @@ -46,6 +46,9 @@ TEST_GEN_FILES =
 >> TEST_FILES = test_lwt_ip_encap.o \
 >> test_tc_edt.o
 >> 
 >> +BTF_C_FILES = $(wildcard progs/btf_dump_test_case_*.c)
 >> +TEST_FILES += $(BTF_C_FILES)

 > Can you please re-use BTF_C_FILES in TRUNNER_EXTRA_FILES :=
 > assignment on line 357?

Do you mean this:

From 45ce4975303de9e0abc733f68583a50478733071 Mon Sep 17 00:00:00 2001
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date: Tue, 19 May 2020 11:35:52 +0300
Subject: [PATCH] selftests/bpf: install btf .c files

Some .c files used by test_progs to check btf and they are missing
from installation after commit 74b5a5968fe8 ("selftests/bpf: Replace
test_progs and test_maps w/ general rule").

Take them back.

Reuse BTF_C_FILES for TRUNNER_EXTRA_FILES.

Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and
test_maps w/ general rule")

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/bpf/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e716e931d0c9..3ab4b6937987 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -46,6 +46,9 @@ TEST_GEN_FILES =
 TEST_FILES = test_lwt_ip_encap.o \
 	test_tc_edt.o
 
+BTF_C_FILES = $(wildcard progs/btf_dump_test_case_*.c)
+TEST_FILES += $(BTF_C_FILES)
+
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
 	test_xdp_redirect.sh \
@@ -357,8 +360,7 @@ TRUNNER_BPF_PROGS_DIR := progs
 TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
 			 network_helpers.c testing_helpers.c		\
 			 flow_dissector_load.h
-TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
-		       $(wildcard progs/btf_dump_test_case_*.c)
+TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(BTF_C_FILES)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
 TRUNNER_BPF_LDFLAGS := -mattr=+alu32
-- 
2.26.2

?

 > See also $(TRUNNER_BINARY)-extras rule. For "flavored"
 > test_progs runners (e.g., test_progs-no_alu32), those files
 > need to be copied into no_alu32 sub-directory (same for BPF .o
 > files, actually). Unless you don't want to run flavored
 > test_progs, of course.

Thanks, I'll have a look.

 >> # Order correspond to 'make run_tests' order
 >> TEST_PROGS := test_kmod.sh \
 >> test_xdp_redirect.sh \
 >> --
 >> 2.26.2
 >> 


-- 
WBR,
Yauheni Kaliuta

