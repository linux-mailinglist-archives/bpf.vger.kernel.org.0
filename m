Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7051E37A6
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 07:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgE0FG1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 01:06:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23163 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbgE0FG0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 May 2020 01:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590555985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UTF80IIgEz3jD5AkRRbLtC7BJpfX/F43Srogwh5DvO4=;
        b=DfB5bHzZQMSPscEUumc+WWqrRE6BTCOejt8IcKaFcOINRhD+g23sd3eavkIJlDQpbkwBwR
        /FEb1pyD793C2Stf5w6VWW51ofrMpUAfCo8rAmqAdLRgdb4hA6/rYb2/Jcq8FTJsmPwNQ8
        7uB03hWKdYtw7LapX0E9nSOeFIt0khU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-7wxbYGGCOkSzTfL7Gx33sw-1; Wed, 27 May 2020 01:06:18 -0400
X-MC-Unique: 7wxbYGGCOkSzTfL7Gx33sw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65BD6894C07;
        Wed, 27 May 2020 05:06:17 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8548C10016E8;
        Wed, 27 May 2020 05:06:15 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 7/8] selftests/bpf: fix test.h placing for out of tree build
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
        <20200522041310.233185-8-yauheni.kaliuta@redhat.com>
        <CAEf4BzaJtf-B66Srjk+2H-Ey8KYUutYFaOQX86ETAEizaXV1zA@mail.gmail.com>
Date:   Wed, 27 May 2020 08:06:13 +0300
In-Reply-To: <CAEf4BzaJtf-B66Srjk+2H-Ey8KYUutYFaOQX86ETAEizaXV1zA@mail.gmail.com>
        (Andrii Nakryiko's message of "Tue, 26 May 2020 15:26:43 -0700")
Message-ID: <xunymu5uotkq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Andrii!

>>>>> On Tue, 26 May 2020 15:26:43 -0700, Andrii Nakryiko  wrote:

 > On Thu, May 21, 2020 at 9:14 PM Yauheni Kaliuta
 > <yauheni.kaliuta@redhat.com> wrote:
 >> 
 >> Flavors of test.h are generated in tree even for out of tree
 >> build. Use OUTPUT directory for that.
 >> 
 >> It requires rules to make sure the directories exist.
 >> 
 >> Split EXTRA_CLEAN generation since existance of test.h files depends
 >> of dynamic makefile generation.
 >> 
 >> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
 >> ---
 >> tools/testing/selftests/bpf/Makefile | 38 +++++++++++++++++++++-------
 >> 1 file changed, 29 insertions(+), 9 deletions(-)
 >> 
 >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
 >> index 31598ca2d396..bade24e29a1a 100644
 >> --- a/tools/testing/selftests/bpf/Makefile
 >> +++ b/tools/testing/selftests/bpf/Makefile
 >> @@ -83,6 +83,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 >> test_lirc_mode2_user xdping test_cpp runqslower bench
 >> 
 >> TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
 >> +EXTRA_CLEAN += $(TEST_CUSTOM_PROGS)

 > why += instead of := here?

Well, in this particular case there is no difference, but in
general it looks better for me

1) unified +=, no need to track which is first;
2) for first time it makes the variable deffered evaluated which
sound more appropriate (if TEST_CUSTOM_PROGS was constructed);

But if you insist, I'll change it.

 >> 
 >> # Emit succinct information message describing current building step
 >> # $1 - generic step name (e.g., CC, LINK, etc);
 >> @@ -267,7 +268,7 @@ TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,   \
 >> TRUNNER_EXTRA_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,          \
 >> $$(filter %.c,$(TRUNNER_EXTRA_SOURCES)))
 >> TRUNNER_EXTRA_HDRS := $$(filter %.h,$(TRUNNER_EXTRA_SOURCES))
 >> -TRUNNER_TESTS_HDR := $(TRUNNER_TESTS_DIR)/tests.h
 >> +TRUNNER_TESTS_HDR := $(OUTPUT)/$(TRUNNER_TESTS_DIR)/tests.h
 >> TRUNNER_BPF_SRCS := $$(notdir $$(wildcard $(TRUNNER_BPF_PROGS_DIR)/*.c))
 >> TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o, $$(TRUNNER_BPF_SRCS))
 >> TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,      \
 >> @@ -295,6 +296,11 @@ $(TRUNNER_OUTPUT)-dir := y
 >> $(TRUNNER_OUTPUT):
 >> $$(call msg,MKDIR,,$$@)
 >> mkdir -p $$@
 >> +
 >> +ifneq ($2,)
 >> +EXTRA_CLEAN +=$(TRUNNER_OUTPUT)
 >> +endif
 >> +
 >> endif
 >> 
 >> # ensure we set up BPF objects generation rule just once for a given
 >> @@ -320,13 +326,19 @@ endif
 >> # ensure we set up tests.h header generation rule just once
 >> ifeq ($($(TRUNNER_TESTS_DIR)-tests-hdr),)
 >> $(TRUNNER_TESTS_DIR)-tests-hdr := y
 >> -$(TRUNNER_TESTS_HDR): $(TRUNNER_TESTS_DIR)/*.c
 >> +$(TRUNNER_TESTS_HDR): $(TRUNNER_TESTS_DIR)/*.c | $(dir $(TRUNNER_TESTS_HDR))
 >> $$(call msg,TEST-HDR,$(TRUNNER_BINARY),$$@)
 >> $$(shell ( cd $(TRUNNER_TESTS_DIR);                             \
 >> echo '/* Generated header, do not edit */';           \
 >> ls *.c 2> /dev/null |                                 \
 >> sed -e 's@\([^\.]*\)\.c@DEFINE_TEST(\1)@';      \
 >> ) > $$@)
 >> +
 >> +EXTRA_CLEAN += $(TRUNNER_TESTS_HDR)
 >> +
 >> +$(dir $(TRUNNER_TESTS_HDR)):
 >> +       $$(call msg,MKDIR,,$$@)
 >> +       mkdir -p $$@
 >> endif
 >> 
 >> # compile individual test files
 >> @@ -402,14 +414,23 @@ $(eval $(call DEFINE_TEST_RUNNER,test_maps))
 >> # It is much simpler than test_maps/test_progs and sufficiently different from
 >> # them (e.g., test.h is using completely pattern), that it's worth just
 >> # explicitly defining all the rules explicitly.
 >> -verifier/tests.h: verifier/*.c
 >> +$(OUTPUT)/verifier/tests.h: verifier/*.c | $(OUTPUT)/verifier
 >> $(shell ( cd verifier/; \
 >> echo '/* Generated header, do not edit */'; \
 >> echo '#ifdef FILL_ARRAY'; \
 >> ls *.c 2> /dev/null | sed -e 's@\(.*\)@#include \"\1\"@'; \
 >> echo '#endif' \
 >> -               ) > verifier/tests.h)
 >> -$(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 >> +               ) > $@)
 >> +
 >> +EXTRA_CLEAN += $(OUTPUT)/verifier/tests.h
 >> +
 >> +$(OUTPUT)/verifier:
 >> +       $(call msg,MKDIR,,$@)
 >> +       mkdir -p $@

 > See below, given this directory is well-known and sort of
 > static, can you just add them to the list of pre-created
 > directories at line 176?

Agree.

 >> +
 >> +$(OUTPUT)/test_verifier: CFLAGS += -I$(abspath verifier)
 >> +$(OUTPUT)/test_verifier: test_verifier.c $(OUTPUT)/verifier/tests.h $(BPFOBJ) \
 >> +                       | $(OUTPUT)
 >> $(call msg,BINARY,,$@)
 >> $(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 >> 
 >> @@ -433,7 +454,6 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o
 >> $(OUTPUT)/testing_helpers.o \
 >> $(call msg,BINARY,,$@)
 >> $(CC) $(LDFLAGS) -o $@ $(filter %.a %.o,$^) $(LDLIBS)
 >> 
 >> -EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR)                     \
 >> -       prog_tests/tests.h map_tests/tests.h verifier/tests.h           \

 > Why not just append $(OUTPUT) to these three and keep TRUNNER
 > rules just a bit simpler, they don't need any extra
 > complexity.

 >> -       feature                                                         \
 >> -       $(addprefix $(OUTPUT)/,*.o *.skel.h no_alu32 bpf_gcc)

 > same for no_alu32 and bpf_gcc, just append $(OUTPUT)/ to them?

Well, it's possible, but for me it looks a bit wrong. It sort of
creates 2 points of sync -- the calls to dynamic rule creation
and here (skip/add dynamic call -- change clean rule), and having
it in the place were all the code handling flavors located sounds
a bit more correct for me.

But since there are not a lot of them if you find it nicer, I'll
do that.

 >> +EXTRA_CLEAN += $(SCRATCH_DIR)                  \
 >> +       feature                                 \
 >> +       $(addprefix $(OUTPUT)/,*.o *.skel.h)
 >> --
 >> 2.26.2
 >> 


-- 
WBR,
Yauheni Kaliuta

