Return-Path: <bpf+bounces-53954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D92A5F47D
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 13:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A17189F943
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 12:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E87267727;
	Thu, 13 Mar 2025 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIO3Glmq"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FA3266F15
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868960; cv=none; b=MnboQmJ8wSUEf3UzuQ8yJboPbQojkZfdTyKkYA7s7PbjSK0/INsxamExTAA2d5PflPQ9dvGsUIVzXnTbSfVfRgGG52h3RVxAsYRz9/gHmF2axRtMgD4wPbolT4hSGbFJ7jUjg0fy2smhsTH+VJKvcmdl4RZmV+p0bLDfK6jQfmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868960; c=relaxed/simple;
	bh=XqDBv8O2J+mLNfoM3EzVSGxZwfE1ntWiOKY2pTtoVMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bd0h3I9tu7JIB549EYLsM4AkXeKG8DgjxM8vDTMykaz+aUIJsL8AOmVTFzQRK2d6duJT1Dvd+bf6giMfbJWtVtkgH2XAStjqmAHJxL0y2P+zV8giNhUQw/JEd2wX0Av0oG5BMlrW7B6EOx+cJdGlCzz8q822hqkVLHQaH3MEsY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIO3Glmq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741868954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TUoONANXN8XjSzbFUTnWbbUHRrOhgLMKxIe2husKfzQ=;
	b=JIO3GlmqFO5HnLlDn0iTTC5LCdSB4xU1iue17DCJF4SeIyPN21kkdQb6yK2RGBoddQ5Ngi
	iyw6eVNdHUC3Jgpz2LV2YZ0n4Gfxu9aHN03G2xCTHDlhTK4kQMaLI84H2/47a0XyMciJgR
	vBXWOVFInei+zKfiiWM9M4fqF5hH7ko=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-Unb4zvuHMPOK2AyuBiD8Tg-1; Thu,
 13 Mar 2025 08:29:08 -0400
X-MC-Unique: Unb4zvuHMPOK2AyuBiD8Tg-1
X-Mimecast-MFC-AGG-ID: Unb4zvuHMPOK2AyuBiD8Tg_1741868946
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86BE518001E1;
	Thu, 13 Mar 2025 12:29:05 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.157])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CD1018001EF;
	Thu, 13 Mar 2025 12:28:57 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Viktor Malik <vmalik@redhat.com>,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH bpf-next v2] selftests/bpf: Fix string read in strncmp benchmark
Date: Thu, 13 Mar 2025 13:28:52 +0100
Message-ID: <20250313122852.1365202-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The strncmp benchmark uses the bpf_strncmp helper and a hand-written
loop to compare two strings. The values of the strings are filled from
userspace. One of the strings is non-const (in .bss) while the other is
const (in .rodata) since that is the requirement of bpf_strncmp.

The problem is that in the hand-written loop, Clang optimizes the reads
from the const string to always return 0 which breaks the benchmark.

Use barrier_var to prevent the optimization.

The effect can be seen on the strncmp-no-helper variant.

Before this change:

    # ./bench strncmp-no-helper
    Setting up benchmark 'strncmp-no-helper'...
    Benchmark 'strncmp-no-helper' started.
    Iter   0 (112.309us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
    Iter   1 (-23.238us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
    Iter   2 ( 58.994us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
    Iter   3 (-30.466us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
    Iter   4 ( 29.996us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
    Iter   5 ( 16.949us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
    Iter   6 (-60.035us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
    Summary: hits    0.000 ± 0.000M/s (  0.000M/prod), drops    0.000 ± 0.000M/s, total operations    0.000 ± 0.000M/s

After this change:

    # ./bench strncmp-no-helper
    Setting up benchmark 'strncmp-no-helper'...
    Benchmark 'strncmp-no-helper' started.
    Iter   0 ( 77.711us): hits    5.534M/s (  5.534M/prod), drops    0.000M/s, total operations    5.534M/s
    Iter   1 ( 11.215us): hits    6.006M/s (  6.006M/prod), drops    0.000M/s, total operations    6.006M/s
    Iter   2 (-14.253us): hits    5.931M/s (  5.931M/prod), drops    0.000M/s, total operations    5.931M/s
    Iter   3 ( 59.087us): hits    6.005M/s (  6.005M/prod), drops    0.000M/s, total operations    6.005M/s
    Iter   4 (-21.379us): hits    6.010M/s (  6.010M/prod), drops    0.000M/s, total operations    6.010M/s
    Iter   5 (-20.310us): hits    5.861M/s (  5.861M/prod), drops    0.000M/s, total operations    5.861M/s
    Iter   6 ( 53.937us): hits    6.004M/s (  6.004M/prod), drops    0.000M/s, total operations    6.004M/s
    Summary: hits    5.969 ± 0.061M/s (  5.969M/prod), drops    0.000 ± 0.000M/s, total operations    5.969 ± 0.061M/s

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Fixes: 9c42652f8be3 ("selftests/bpf: Add benchmark for bpf_strncmp() helper")
Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/testing/selftests/bpf/progs/strncmp_bench.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/strncmp_bench.c b/tools/testing/selftests/bpf/progs/strncmp_bench.c
index 18373a7df76e..f47bf88f8d2a 100644
--- a/tools/testing/selftests/bpf/progs/strncmp_bench.c
+++ b/tools/testing/selftests/bpf/progs/strncmp_bench.c
@@ -35,7 +35,10 @@ static __always_inline int local_strncmp(const char *s1, unsigned int sz,
 SEC("tp/syscalls/sys_enter_getpgid")
 int strncmp_no_helper(void *ctx)
 {
-	if (local_strncmp(str, cmp_str_len + 1, target) < 0)
+	const char *target_str = target;
+
+	barrier_var(target_str);
+	if (local_strncmp(str, cmp_str_len + 1, target_str) < 0)
 		__sync_add_and_fetch(&hits, 1);
 	return 0;
 }
-- 
2.48.1


