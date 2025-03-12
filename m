Return-Path: <bpf+bounces-53883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26E1A5D85E
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 09:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224D31896E90
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 08:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B2E2356BF;
	Wed, 12 Mar 2025 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zi8zzkAf"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54AC2356BD
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768760; cv=none; b=OyhJkYOZ4qaeP169/CHG+CYK8CIBZE8Xij/SjIjp0F14bD0YY/G51Uv6moiSb0XYELCMsTArfqoiCClr3UZfAc4MfFk0otPkD1e/Vf2kI4iCgUi1mGxTvRyK4EzI2/Vfnl05Tx7+xg9o2je9J3OKbknkIPfmjJ3rm9hNNVYoZA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768760; c=relaxed/simple;
	bh=3s4tUHimTJr8GGB75XsgGAEHxg2690BmIXdQ93MInPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FkReRJtwlG7GCAaKq3gCvM2Jt1d6UnaqJCMUwgwpEao+fECOwCi0n/8TfCsW+snMGV44/UPpIMSN4w0gEadB/rhihRZzArT4In0C9Eo93ZWAXS2hXVWsSXf1UanP4Pn7CDFIqaojtBBgMI9+StUmVSn4IRn00IGkp4qKXbEnFN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zi8zzkAf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741768757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NZWXEmqiEFh9Mlwpy6gTmVYzhFFpyQQWsPZuKLzg290=;
	b=Zi8zzkAf6bSjlGt7k4YoFJ/l1y28nRDUo4jk7G4J8PyjLbXhiiRUnVhTG6mGtwq2z25Hx2
	GfrBaVyZWTiIVFTv8UsIo7hNHUMRxU5PzZ6TbrBkcxuY32ucSlN5V1ShpfQsYZumYypZgs
	ylIaAL6infTG14omWzvNw/CpZ8QTS30=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-Tha5CuMLOjKBCaE0FzUshg-1; Wed,
 12 Mar 2025 04:39:12 -0400
X-MC-Unique: Tha5CuMLOjKBCaE0FzUshg-1
X-Mimecast-MFC-AGG-ID: Tha5CuMLOjKBCaE0FzUshg_1741768750
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90D5619560A3;
	Wed, 12 Mar 2025 08:39:09 +0000 (UTC)
Received: from vmalik-fedora.brq.redhat.com (unknown [10.43.17.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B847230001A2;
	Wed, 12 Mar 2025 08:39:03 +0000 (UTC)
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
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix string read in strncmp benchmark
Date: Wed, 12 Mar 2025 09:38:59 +0100
Message-ID: <20250312083859.1019635-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The strncmp benchmark uses the bpf_strncmp helper and a hand-written
loop to compare two strings. The values of the strings are filled from
userspace. One of the strings is non-const (in .bss) while the other is
const (in .rodata) since that is the requirement of bpf_strncmp.

The problem is that in the hand-written loop, Clang optimizes the reads
from the const string to always return 0 which breaks the benchmark.

Mark the const string as volatile to avoid that.

The effect can be seen on the strncmp-no-helper variant.

Before this change:

    # ./bench strncmp-no-helper
    Setting up benchmark 'strncmp-no-helper'...
    Benchmark 'strncmp-no-helper' started.
    Iter   0 (8440.107us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
    Iter   1 (73909.374us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
    Iter   2 (-8140.994us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
    Iter   3 (3094.474us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
    Iter   4 (-2828.468us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
    Iter   5 (2635.595us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
    Iter   6 (-306.478us): hits    0.000M/s (  0.000M/prod), drops    0.000M/s, total operations    0.000M/s
    Summary: hits    0.000 ± 0.000M/s (  0.000M/prod), drops    0.000 ± 0.000M/s, total operations    0.000 ± 0.000M/s

After this change:

    # ./bench strncmp-no-helper
    Setting up benchmark 'strncmp-no-helper'...
    Benchmark 'strncmp-no-helper' started.
    Iter   0 (21180.011us): hits    5.320M/s (  5.320M/prod), drops    0.000M/s, total operations    5.320M/s
    Iter   1 (-692.499us): hits    5.246M/s (  5.246M/prod), drops    0.000M/s, total operations    5.246M/s
    Iter   2 (-704.751us): hits    5.332M/s (  5.332M/prod), drops    0.000M/s, total operations    5.332M/s
    Iter   3 (62057.929us): hits    5.299M/s (  5.299M/prod), drops    0.000M/s, total operations    5.299M/s
    Iter   4 (-7981.421us): hits    5.303M/s (  5.303M/prod), drops    0.000M/s, total operations    5.303M/s
    Iter   5 (3500.341us): hits    5.306M/s (  5.306M/prod), drops    0.000M/s, total operations    5.306M/s
    Iter   6 (-3851.046us): hits    5.264M/s (  5.264M/prod), drops    0.000M/s, total operations    5.264M/s
    Summary: hits    5.338 ± 0.147M/s (  5.338M/prod), drops    0.000 ± 0.000M/s, total operations    5.338 ± 0.147M/s

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/testing/selftests/bpf/progs/strncmp_bench.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/strncmp_bench.c b/tools/testing/selftests/bpf/progs/strncmp_bench.c
index 18373a7df76e..92a828a1ebea 100644
--- a/tools/testing/selftests/bpf/progs/strncmp_bench.c
+++ b/tools/testing/selftests/bpf/progs/strncmp_bench.c
@@ -9,7 +9,7 @@
 
 /* Will be updated by benchmark before program loading */
 const volatile unsigned int cmp_str_len = 1;
-const char target[STRNCMP_STR_SZ];
+const volatile char target[STRNCMP_STR_SZ];
 
 long hits = 0;
 char str[STRNCMP_STR_SZ];
@@ -17,7 +17,7 @@ char str[STRNCMP_STR_SZ];
 char _license[] SEC("license") = "GPL";
 
 static __always_inline int local_strncmp(const char *s1, unsigned int sz,
-					 const char *s2)
+					 const volatile char *s2)
 {
 	int ret = 0;
 	unsigned int i;
@@ -43,7 +43,7 @@ int strncmp_no_helper(void *ctx)
 SEC("tp/syscalls/sys_enter_getpgid")
 int strncmp_helper(void *ctx)
 {
-	if (bpf_strncmp(str, cmp_str_len + 1, target) < 0)
+	if (bpf_strncmp(str, cmp_str_len + 1, (const char *)target) < 0)
 		__sync_add_and_fetch(&hits, 1);
 	return 0;
 }
-- 
2.48.1


