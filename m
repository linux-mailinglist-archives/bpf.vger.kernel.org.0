Return-Path: <bpf+bounces-44228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085C69C04EC
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 12:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CE7285EEB
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 11:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA621EE026;
	Thu,  7 Nov 2024 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgveV2GX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631DD199951
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980371; cv=none; b=Z4hcXtPe0i1qHQiy0FSr+RLLIL7LdkSPxewojCZm4oCXpQBZ2QdnXBBh/aPOeNWF1Ybsus8QVHidEeYAiuib9WKZ25kosfPgB4QeXuCoSGbga65xut66nh9mUir2hQHIPyJ8L8poK4BxqP6Adoj5pJHiDt6W1i0hATfO+mrRois=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980371; c=relaxed/simple;
	bh=a83peABtyTMD/ils8Tkk9SJMUz4aW4zfRs5lkYpuAt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BGnCc6wTVd9WsreniT/ZvTztbnuE49YE+FCjPhoZ7wkhpMEiMgOfZiOyk5PasR2SQyjG3lZMfciO3lBFwzHNV86x3iTjM1DMPBjYeEfmOEUUp5FDucNaUKjdo7taIqOmE6FevTmFsILU4n5K6U1g/YcW3/FmP2O6WPZa8GaVuHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgveV2GX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730980369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GKfq9yTXc5uJ5UW8PNDw8epEWDXV67Fpa/AFzBNH6jk=;
	b=QgveV2GXSak4ivhXJ0YZug+Dc1R5df2KaSA4FiYUSDcKXEfCUI+fF+G97+2EOMdOQ5U5Go
	YKorZwm8sk7VOmeMF/EWAQXFKa9uMYSuWqtqxYOjXHUQkASekyFqNRWzWhjLmdMo3R7Qy6
	oXfB78DVyUBIa0IMIvHsIsdp0RWmGI0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-itGjOCGTPLSBt8x7B17PWw-1; Thu,
 07 Nov 2024 06:52:46 -0500
X-MC-Unique: itGjOCGTPLSBt8x7B17PWw-1
X-Mimecast-MFC-AGG-ID: itGjOCGTPLSBt8x7B17PWw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84A4019560A1;
	Thu,  7 Nov 2024 11:52:43 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.76])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 630E41956054;
	Thu,  7 Nov 2024 11:52:37 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next] selftests/bpf: skip the timer_lockup test for single-CPU nodes
Date: Thu,  7 Nov 2024 12:52:31 +0100
Message-ID: <20241107115231.75200-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The timer_lockup test needs 2 CPUs to work, on single-CPU nodes it fails
to set thread affinity to CPU 1 since it doesn't exist:

    # ./test_progs -t test_lockup
    test_timer_lockup:PASS:timer_lockup__open_and_load 0 nsec
    test_timer_lockup:PASS:pthread_create thread1 0 nsec
    test_timer_lockup:PASS:pthread_create thread2 0 nsec
    timer_lockup_thread:PASS:cpu affinity 0 nsec
    timer_lockup_thread:FAIL:cpu affinity unexpected error: 22 (errno 0)
    test_timer_lockup:PASS: 0 nsec
    #406     timer_lockup:FAIL

Skip the test if only 1 CPU is available.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Fixes: 50bd5a0c658d1 ("selftests/bpf: Add timer lockup selftest")
---
 tools/testing/selftests/bpf/prog_tests/timer_lockup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/timer_lockup.c b/tools/testing/selftests/bpf/prog_tests/timer_lockup.c
index 871d16cb95cf..1a2f99596916 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer_lockup.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer_lockup.c
@@ -5,6 +5,7 @@
 #include <test_progs.h>
 #include <pthread.h>
 #include <network_helpers.h>
+#include <sys/sysinfo.h>
 
 #include "timer_lockup.skel.h"
 
@@ -52,6 +53,11 @@ void test_timer_lockup(void)
 	pthread_t thrds[2];
 	void *ret;
 
+	if (get_nprocs() < 2) {
+		test__skip();
+		return;
+	}
+
 	skel = timer_lockup__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "timer_lockup__open_and_load"))
 		return;
-- 
2.47.0


