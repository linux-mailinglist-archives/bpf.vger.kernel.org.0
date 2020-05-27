Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4992B1E378F
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 06:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgE0Eyf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 00:54:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22215 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725294AbgE0Eyf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 May 2020 00:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590555273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iFl8g3dc9q37gq/Cvwdn+nFepBG2RmoBZdraLlkzq9M=;
        b=MseWrVAaMlUu737Z+JdQNgwq0eteC8vJaiYlCIK/62ogdd9nnfHKGPs1ox4PwvYUvGeNZO
        juJfTAz5y3HUK3Mz33XdfW5P+EuARuaM7GX6ngtG1VH8Fym/QgIT90azv6JNRr5HSaANgo
        roXxXDZ5BbAdztwrjO1EmfdL1MVkj9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-BZX02gc_PLSWyYKI18VPZQ-1; Wed, 27 May 2020 00:54:29 -0400
X-MC-Unique: BZX02gc_PLSWyYKI18VPZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 447BF460;
        Wed, 27 May 2020 04:54:28 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9803F79C3F;
        Wed, 27 May 2020 04:54:26 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 2/8] selftests/bpf: build bench.o for any $(OUTPUT)
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
        <20200522041310.233185-3-yauheni.kaliuta@redhat.com>
        <CAEf4BzZb021L2Dyvp_6HN_rRqt6tOj4Tjpq4J7Nd8FpPV28rGQ@mail.gmail.com>
Date:   Wed, 27 May 2020 07:54:24 +0300
In-Reply-To: <CAEf4BzZb021L2Dyvp_6HN_rRqt6tOj4Tjpq4J7Nd8FpPV28rGQ@mail.gmail.com>
        (Andrii Nakryiko's message of "Tue, 26 May 2020 15:13:36 -0700")
Message-ID: <xunyr1v6ou4f.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Andrii!

>>>>> On Tue, 26 May 2020 15:13:36 -0700, Andrii Nakryiko  wrote:

 > On Thu, May 21, 2020 at 9:14 PM Yauheni Kaliuta
 > <yauheni.kaliuta@redhat.com> wrote:
 >> 
 >> bench.o is produced by implicit rule only if it's built in the same
 >> directory where bench.c is located. If OUTPUT points somewhere else,
 >> build fails.
 >> 
 >> Make an explicit rule for it (factor out common part).
 >> Add bench.c as a dependency to make it source for CC.

 > If that's the case, then the similar problem would happen to
 > test_l4lb_noinline.o, test_xdp_noinline.o, and
 > flow_dissector_load.o, at least. Let's fix the implicit rule
 > (or define our own, but generic one), instead of ad-hoc fixing
 > it for bench.o only.

I'll check why they did not cause problems.


 >> 
 >> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
 >> ---
 >> tools/testing/selftests/bpf/Makefile | 11 ++++++++---
 >> 1 file changed, 8 insertions(+), 3 deletions(-)
 >> 
 >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
 >> index 09700db35c2d..f0b7d41ed6dd 100644
 >> --- a/tools/testing/selftests/bpf/Makefile
 >> +++ b/tools/testing/selftests/bpf/Makefile
 >> @@ -243,6 +243,11 @@ define GCC_BPF_BUILD_RULE
 >> $(BPF_GCC) $3 $4 -O2 -c $1 -o $2
 >> endef
 >> 
 >> +define COMPILE_C_RULE
 >> +       $(call msg,CC,,$@)
 >> +       $(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
 >> +endef
 >> +
 >> SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
 >> 
 >> # Set up extra TRUNNER_XXX "temporary" variables in the environment (relies on
 >> @@ -409,11 +414,11 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 >> 
 >> # Benchmark runner
 >> $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h
 >> -       $(call msg,CC,,$@)
 >> -       $(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
 >> +       $(COMPILE_C_RULE)
 >> $(OUTPUT)/bench_rename.o: $(OUTPUT)/test_overhead.skel.h
 >> $(OUTPUT)/bench_trigger.o: $(OUTPUT)/trigger_bench.skel.h
 >> -$(OUTPUT)/bench.o: bench.h testing_helpers.h
 >> +$(OUTPUT)/bench.o: bench.c bench.h testing_helpers.h
 >> +       $(COMPILE_C_RULE)
 >> $(OUTPUT)/bench: LDLIBS += -lm
 >> $(OUTPUT)/bench: $(OUTPUT)/bench.o $(OUTPUT)/testing_helpers.o \
 >> $(OUTPUT)/bench_count.o \
 >> --
 >> 2.26.2
 >> 


-- 
WBR,
Yauheni Kaliuta

