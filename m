Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F641E37A7
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 07:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgE0FH2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 01:07:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60645 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbgE0FH2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 May 2020 01:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590556046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C4wehBb1GlxqyGlXaILxzqLReCZFEr/OWUp5RERrwdk=;
        b=b8rixlYFEtG1fu07spgCAG5kP7TJti/g0mg3XET6pOvwN84Zuq5J04chlrdSzNzHNwX2O/
        G0Jlvy9/PsE/R4SirvMyH57p6x8nhXk1CN7orUw4hmxMnId8d7B3FIY/7l6xRoy/hck+7m
        2NGw0v5nwgOxmd/9bd375p8hMWKyjRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-SzHRvJI6P0KJQ0YVljzkLA-1; Wed, 27 May 2020 01:07:24 -0400
X-MC-Unique: SzHRvJI6P0KJQ0YVljzkLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89CD9460;
        Wed, 27 May 2020 05:07:23 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4003C6C77F;
        Wed, 27 May 2020 05:07:20 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 8/8] selftests/bpf: factor out MKDIR rule
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
        <20200522041310.233185-9-yauheni.kaliuta@redhat.com>
        <CAEf4BzYoXB8OmnAu59L5Xr6=CpAcxxSJQrEfkuWgg0XT-EeP4w@mail.gmail.com>
Date:   Wed, 27 May 2020 08:07:18 +0300
In-Reply-To: <CAEf4BzYoXB8OmnAu59L5Xr6=CpAcxxSJQrEfkuWgg0XT-EeP4w@mail.gmail.com>
        (Andrii Nakryiko's message of "Tue, 26 May 2020 15:29:04 -0700")
Message-ID: <xunyimgiotix.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Andrii!

>>>>> On Tue, 26 May 2020 15:29:04 -0700, Andrii Nakryiko  wrote:

 > On Thu, May 21, 2020 at 9:14 PM Yauheni Kaliuta
 > <yauheni.kaliuta@redhat.com> wrote:
 >> 
 >> Do not repeat youself, move common mkdir code (message and action)
 >> to a variable.
 >> 
 >> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
 >> ---
 >> tools/testing/selftests/bpf/Makefile | 14 ++++++++------
 >> 1 file changed, 8 insertions(+), 6 deletions(-)
 >> 
 >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
 >> index bade24e29a1a..26497d8869ea 100644
 >> --- a/tools/testing/selftests/bpf/Makefile
 >> +++ b/tools/testing/selftests/bpf/Makefile
 >> @@ -252,6 +252,11 @@ define COMPILE_C_RULE
 >> $(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
 >> endef
 >> 
 >> +define MKDIR_RULE
 >> +       $(call msg,MKDIR,,$@)
 >> +       mkdir -p $@
 >> +endef

 > I don't think you save much with this, especially by combining
 > dir creation rules together. Let's not do this, just adds
 > extra level of "rule nestedness", if I may say so...

Ok

 >> +
 >> SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
 >> 
 >> # Set up extra TRUNNER_XXX "temporary" variables in the environment (relies on
 >> @@ -294,8 +299,7 @@ define DEFINE_TEST_RUNNER_RULES
 >> ifeq ($($(TRUNNER_OUTPUT)-dir),)
 >> $(TRUNNER_OUTPUT)-dir := y
 >> $(TRUNNER_OUTPUT):
 >> -       $$(call msg,MKDIR,,$$@)
 >> -       mkdir -p $$@
 >> +       $$(MKDIR_RULE)
 >> 
 >> ifneq ($2,)
 >> EXTRA_CLEAN +=$(TRUNNER_OUTPUT)
 >> @@ -337,8 +341,7 @@ $(TRUNNER_TESTS_HDR): $(TRUNNER_TESTS_DIR)/*.c |
 >> $(dir $(TRUNNER_TESTS_HDR))
 >> EXTRA_CLEAN += $(TRUNNER_TESTS_HDR)
 >> 
 >> $(dir $(TRUNNER_TESTS_HDR)):

 > combine this rule with $(TRUNNER_OUTPUT) above?

 >> -       $$(call msg,MKDIR,,$$@)
 >> -       mkdir -p $$@
 >> +       $$(MKDIR_RULE)
 >> endif
 >> 
 >> # compile individual test files
 >> @@ -425,8 +428,7 @@ $(OUTPUT)/verifier/tests.h: verifier/*.c | $(OUTPUT)/verifier
 >> EXTRA_CLEAN += $(OUTPUT)/verifier/tests.h
 >> 
 >> $(OUTPUT)/verifier:
 >> -       $(call msg,MKDIR,,$@)
 >> -       mkdir -p $@
 >> +       $(MKDIR_RULE)

 > This should go together with libbpf, bpftool and $(INCLUDE_DIR) rule
 > at line 176.

 >> 
 >> $(OUTPUT)/test_verifier: CFLAGS += -I$(abspath verifier)
 >> $(OUTPUT)/test_verifier: test_verifier.c $(OUTPUT)/verifier/tests.h $(BPFOBJ) \
 >> --
 >> 2.26.2
 >> 


-- 
WBR,
Yauheni Kaliuta

