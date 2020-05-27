Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387FF1E37D3
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 07:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgE0FVR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 01:21:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36292 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725948AbgE0FVR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 May 2020 01:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590556875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9C/C93eQZWVzUqIMpMxLmwOSAWWsaEg5H/GwtSMLP68=;
        b=J3jEwKzEUbFzn3bp+CRI6QOfZzKPjssXxIm9v/Txp4+qxOUI5z+lR6pc2M9DeVG08SXBoF
        E2SsGEK/hdC4mqsBvAfJSG1AFJHHW3Xfv4tXTFXzvbm81M54JaKd/khCet1DlIxyIGlTfp
        y7PqmG5K+gVMP2CU4kP56c27zljOz9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-6eDNHfemNmGnw6r23LkOFg-1; Wed, 27 May 2020 01:21:13 -0400
X-MC-Unique: 6eDNHfemNmGnw6r23LkOFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E71601902EA1;
        Wed, 27 May 2020 05:21:11 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FF3E10013D7;
        Wed, 27 May 2020 05:21:10 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
References: <xuny367so4k3.fsf@redhat.com>
        <20200522081901.238516-1-yauheni.kaliuta@redhat.com>
        <CAEf4BzZaCTDT6DcLYvyFr4RUUm4fFbyb743e1JrEp2DS69cbug@mail.gmail.com>
Date:   Wed, 27 May 2020 08:21:08 +0300
In-Reply-To: <CAEf4BzZaCTDT6DcLYvyFr4RUUm4fFbyb743e1JrEp2DS69cbug@mail.gmail.com>
        (Andrii Nakryiko's message of "Tue, 26 May 2020 17:19:18 -0700")
Message-ID: <xunya71uosvv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Andrii!

>>>>> On Tue, 26 May 2020 17:19:18 -0700, Andrii Nakryiko  wrote:

 > On Fri, May 22, 2020 at 1:19 AM Yauheni Kaliuta
 > <yauheni.kaliuta@redhat.com> wrote:
 >> 
 >> There is difference in depoying static and generated extra resource
 >> files between in/out of tree build and flavors:
 >> 
 >> - in case of unflavored out-of-tree build static files are not
 >> available and must be copied as well as both static and generated
 >> files for flavored build.
 >> 
 >> So split the rules and variables. The name TRUNNER_EXTRA_GEN_FILES
 >> is chosen in analogy to TEST_GEN_* variants.
 >> 

 > Can we keep them together but be smarter about what needs to
 > be copied based on source/target directories? I would really
 > like to not blow up all these rules.

I can try, ok, I just find it a bit more clear. But it's good to
get some input from kselftest about OOT build in general.

 >> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
 >> ---
 >> tools/testing/selftests/bpf/Makefile | 26 ++++++++++++++++++++++----
 >> 1 file changed, 22 insertions(+), 4 deletions(-)
 >> 
 >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
 >> index 26497d8869ea..c80c06272759 100644
 >> --- a/tools/testing/selftests/bpf/Makefile
 >> +++ b/tools/testing/selftests/bpf/Makefile
 >> @@ -363,12 +363,28 @@ $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:                             \
 >> $$(call msg,EXT-OBJ,$(TRUNNER_BINARY),$$@)
 >> $$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
 >> 
 >> -# only copy extra resources if in flavored build
 >> -$(TRUNNER_BINARY)-extras: $(TRUNNER_EXTRA_FILES) | $(TRUNNER_OUTPUT)
 >> -ifneq ($2,)
 >> +# copy extra resources when needed.
 >> +# Static files for both out of tree and flavored (so, not current dir).
 >> +# Generated files for flavored only.
 >> +$(TRUNNER_BINARY)-extras: $(TRUNNER_BINARY)-extras-static \
 >> +                         $(TRUNNER_BINARY)-extras-gen
 >> +
 >> +$(TRUNNER_BINARY)-extras-static: $(TRUNNER_EXTRA_FILES) | $(TRUNNER_OUTPUT)
 >> +ifneq ($(CURDIR)),$(realpath $(TRUNNER_OUTPUT)))
 >> $$(call msg,EXT-COPY,$(TRUNNER_BINARY),$(TRUNNER_EXTRA_FILES))
 >> +ifneq ($(TRUNNER_EXTRA_FILES),)
 >> cp -a $$^ $(TRUNNER_OUTPUT)/
 >> endif
 >> +endif
 >> +
 >> +$(TRUNNER_BINARY)-extras-gen: $(addprefix $(OUTPUT)/,$(TRUNNER_EXTRA_GEN_FILES)) \
 >> +                           | $(TRUNNER_OUTPUT)
 >> +ifneq ($2,)
 >> +       $$(call msg,EXT-COPY,$(TRUNNER_BINARY),$(TRUNNER_EXTRA_GEN_FILES))
 >> +ifneq ($(TRUNNER_EXTRA_GEN_FILES),)
 >> +       cp -a $$^ $(TRUNNER_OUTPUT)/
 >> +endif
 >> +endif
 >> 
 >> $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)                      \
 >> $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)           \
 >> @@ -384,7 +400,8 @@ TRUNNER_BPF_PROGS_DIR := progs
 >> TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c \
 >> network_helpers.c testing_helpers.c            \
 >> flow_dissector_load.h
 >> -TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(BTF_C_FILES)
 >> +TRUNNER_EXTRA_FILES := $(BTF_C_FILES)
 >> +TRUNNER_EXTRA_GEN_FILES := urandom_read
 >> TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
 >> TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
 >> TRUNNER_BPF_LDFLAGS := -mattr=+alu32
 >> @@ -408,6 +425,7 @@ TRUNNER_TESTS_DIR := map_tests
 >> TRUNNER_BPF_PROGS_DIR := progs
 >> TRUNNER_EXTRA_SOURCES := test_maps.c
 >> TRUNNER_EXTRA_FILES :=
 >> +TRUNNER_EXTRA_GEN_FILES :=
 >> TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
 >> TRUNNER_BPF_CFLAGS :=
 >> TRUNNER_BPF_LDFLAGS :=
 >> --
 >> 2.26.2
 >> 


-- 
WBR,
Yauheni Kaliuta

