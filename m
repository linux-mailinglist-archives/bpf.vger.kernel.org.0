Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20811E37CE
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 07:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgE0FR7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 01:17:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52904 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725948AbgE0FR7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 May 2020 01:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590556677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ryx1jQ7MZt2bZsXF++S4MfB/DK5Ggz7tkkvG0AQxssE=;
        b=G57grEVKsmipkmDAXb678mLu66TZ1zn3nEugN78T+DVm1hT7MjRKHQbRBafbFQkGd9eecF
        zAIp1GxQCWaITi5Y0n8r3tyuMXft8uPnHE48VRudLNq2v0voPPJNUWJO02pCDsf0vp/iCx
        zqJbtIiEahHD7UUVEJVTUwSbJrxqSvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-9rdMebdkMtCmhKwYp5leGQ-1; Wed, 27 May 2020 01:17:53 -0400
X-MC-Unique: 9rdMebdkMtCmhKwYp5leGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 328798F2940;
        Wed, 27 May 2020 05:17:52 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8480560C05;
        Wed, 27 May 2020 05:17:50 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 4/8] selftests/bpf: fix object files installation
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
        <20200522041310.233185-5-yauheni.kaliuta@redhat.com>
        <CAEf4BzZN=cMSFtinNOHMkDhposYPeHqgtJSwnpFSnQ2bX8BfyA@mail.gmail.com>
Date:   Wed, 27 May 2020 08:17:48 +0300
In-Reply-To: <CAEf4BzZN=cMSFtinNOHMkDhposYPeHqgtJSwnpFSnQ2bX8BfyA@mail.gmail.com>
        (Andrii Nakryiko's message of "Tue, 26 May 2020 15:30:19 -0700")
Message-ID: <xunyeer6ot1f.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Andrii!

>>>>> On Tue, 26 May 2020 15:30:19 -0700, Andrii Nakryiko  wrote:

 > On Thu, May 21, 2020 at 9:14 PM Yauheni Kaliuta
 > <yauheni.kaliuta@redhat.com> wrote:
 >> 
 >> There are problems with bpf test programs object files:
 >> 
 >> 1) some of them are build for flavored test runner and should be
 >> installed in the subdirectory;
 >> 2) it's possible that the same file mentioned several times (added
 >> for every different unflavored test runner);
 >> 3) some generated files are not treated properly.
 >> 
 >> Fix 1) by adding subdirectory to the list. rsync -a in the install
 >> target will handle it.
 >> 
 >> Fix 2) by filtering the list. Performance should not matter for such
 >> amount of files.
 >> 
 >> Fix 3) by use proper (TEST_GEN_FILES) variable for the list.
 >> 
 >> Fixes: 309b81f0fdc4 ("selftests/bpf: Install generated test progs")
 >> Fixes: e47a179997ce ("bpf, testing: Add missing object file to
 >> TEST_FILES")
 >> 
 >> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
 >> ---
 >> tools/testing/selftests/bpf/Makefile | 9 ++++++---
 >> 1 file changed, 6 insertions(+), 3 deletions(-)
 >> 
 >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
 >> index 19091dbc8ca4..1ba3d72c3261 100644
 >> --- a/tools/testing/selftests/bpf/Makefile
 >> +++ b/tools/testing/selftests/bpf/Makefile
 >> @@ -42,8 +42,7 @@ ifneq ($(BPF_GCC),)
 >> TEST_GEN_PROGS += test_progs-bpf_gcc
 >> endif
 >> 
 >> -TEST_GEN_FILES =
 >> -TEST_FILES = test_lwt_ip_encap.o \
 >> +TEST_GEN_FILES = test_lwt_ip_encap.o \
 >> test_tc_edt.o
 >> 
 >> BTF_C_FILES = $(wildcard progs/btf_dump_test_case_*.c)
 >> @@ -273,7 +272,11 @@ TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o, $$(TRUNNER_BPF_SRCS)
 >> TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,      \
 >> $$(filter-out $(SKEL_BLACKLIST),       \
 >> $$(TRUNNER_BPF_SRCS)))
 >> -TEST_GEN_FILES += $$(TRUNNER_BPF_OBJS)
 >> +
 >> +TO_ADD := $(if $2,$$(TRUNNER_OUTPUT),$$(TRUNNER_BPF_OBJS))
 >> +$$(foreach i,$$(TO_ADD),\
 >> +       $$(eval \
 >> +               TEST_GEN_FILES += $$(if $$(filter $$i,$$(TEST_GEN_FILES)),,$$i)))

 > This makes me cringe. Can we not have three levels of nested
 > evals, please? I also didn't get exactly what's the problem
 > you are trying to solve, could you give some example, please?

It's sort of `unique` functionality.

With the current approach TEST_GEN_FILES has at least 2 copies of
an object file (for call test_progs and test_maps) which is both
inaccurate and increasing the length of the variable (even if
copying the same file should not cause problems).


(Without sub-directory handling it's even overwritten by
flavoured binaries in between).

BTW, how would you like to change $(call ...) with $(value ...)?
It will get rid of one level of indirection but requires
rule-specific variables for rule generation, since some
evaluations are done in recipies.

 >> 
 >> # Evaluate rules now with extra TRUNNER_XXX variables above already defined
 >> $$(eval $$(call DEFINE_TEST_RUNNER_RULES,$1,$2))
 >> --
 >> 2.26.2
 >> 


-- 
WBR,
Yauheni Kaliuta

