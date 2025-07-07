Return-Path: <bpf+bounces-62491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF7BAFB297
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 13:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676553AEA74
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 11:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148CD29A301;
	Mon,  7 Jul 2025 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifcCbl9w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B75298CD5
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 11:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751889041; cv=none; b=LFh7WmO9fWm2ob4OcL0raVQVQKimcyeJgL/Qyhn8MMs1aQNjaMUZj7la1j6F4iDhiSBVvqr9F9WOEZ0gz0P28p8dJdqEOhALJESN9sTI+FKtKNvViFRAipqMqs9FkzfrVmI2+fNJ67rcIgK/TZsSNXod0Z4XaaGgLYKnW3t+NVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751889041; c=relaxed/simple;
	bh=aXcuWfmyWeS6ESuHwrCffE7KuKPL+CTZNaqyvh7eOhI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kKilgmnW71jx6pZGf8PrKmE6buoFArhGAHpj0OKWEXnNoyLHEpxjH4gAhl9ls7UB3qyXxpRsFl2AnpPHX3vXb15xKn6uKjc6yre0WEZd73AJ9aB+ne4MHcVJvbm82ot7c2weNPXWHesTqWTLaEgPsWis2suFtYozD8Kdj1sJvKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifcCbl9w; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-454aaade1fbso33994675e9.3
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751889038; x=1752493838; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qmydaeLXrKCNGXEWvR1wprnnquitueyo6lhbAwb1b+o=;
        b=ifcCbl9wyRAGRMy8x5oLG6OCyTfvk6k1pji9P0tqJ+j4xACIIOT9ZBPW6c40q0N/Kj
         FsKrHtBDo8JExrxT7GHPmYUkxTqTJaHgwW/kWDLuucECb7g5wta/YaECfLvEGG7uljZr
         56huBc3bMjVjunjuQ2S8PazbFr5LP8nECPgwqnhGtzMBAxG8bAQeKK1kp8Jvio5nc6tv
         xStMZRYEZJ8WDjkEadZn7IlG8MKSNmi/0HWfuBWOQJiUjjmekvAuF8wLtDyexifu8u0h
         8sCJsqphj/wpx7USGSnSTQyZJ4oK6T0s1B+Un2U7BQbn6XPUO2DJ1joxUHHD8m8BsdTp
         7zSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751889038; x=1752493838;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmydaeLXrKCNGXEWvR1wprnnquitueyo6lhbAwb1b+o=;
        b=iB/KU0qk0nPA2LmEMwVcNrB8KaK4QITJsw3kD54WisD3bF+gG9cAe3upFJZCqrE18e
         xtc8AjqJDwReh0mPHLYD8cSSVvyIdg3oe0aYdxQjIEndICeuHX+UBxKbvHBHl0qZUqXY
         I+K8VCPmxEmEXwuWRwER8grDeRF7Ke8SG2BZVVTFVX/lFSBJbyLdLCt1QWzRbvICXLu3
         wOuNmnRohZXje93Y0ysSiYTyx1LmzxchbvVV8oeNEud06M1PSsaST+lI7TqZHOZlEoMN
         j8wRxDkGjDDHZMiiRhZZDZGZ06AcpRjAK9Slf5BwjEvBA7r6QoqawOtBl8aBYWXRt6bS
         AlAQ==
X-Gm-Message-State: AOJu0Ywj8BLaCFxlbjrqmGgK7cvfJ1MLL27Y5PSL+MJMpECUqdwljvik
	DbGrxkNpIG6d/vI85ysCkot9teRY40yxlz5UTJVfzTslNRDcGIvIWl9FI7KcWEGX
X-Gm-Gg: ASbGnct9PbKcG1CwSFv1bbSgUvJPOQiAhQBXxIhnZj7yDm7ArQWZg3uMrDHROkcY0nq
	9Eg0Pm+Ok0ZK2LbHAZk/AX6khQ2A9TcUPVSommbroAHtT64+HKjxN0t/EDM+6gNt33jlZ/7YT0O
	uF0mm7pSQWpJvK8zTG5IpE+7U86O8uEi6/mWJQZl6luFgE4wWkHT/8GXrfEbWnHVPiP/yJYa4A+
	QaKWiMU4OcW3d12mU8YQ6FGk6XTG9V7Ndc0hY+YlgNx+BpeTZAUtlvlh/bgg+ynksjJ+Ojj57Yy
	8qXDoHWENpblLt9f13CGYDTSux8fRtFShQGIocoWx9ffe+kX0Oh2RaAkbJln850OQis6fATCIs1
	qq/jzhWEfWExp+EnepT5UQd40iWTAYA+oixz21q/KPhhiX2JESRkrKV97wxEEldtyA8sY40c=
X-Google-Smtp-Source: AGHT+IEASk5Pep1X8+dbSUtVyRqA7HnIO9XqYCh8G2KGnRAGYV72Cqh4n8EzEa2+uiywriEPonDkGw==
X-Received: by 2002:a05:600c:8b2f:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-454b4ec3e6fmr125148045e9.30.1751889037654;
        Mon, 07 Jul 2025 04:50:37 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f536999e2663c8dd.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f536:999e:2663:c8dd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453a85b3016sm149912615e9.0.2025.07.07.04.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 04:50:37 -0700 (PDT)
Date: Mon, 7 Jul 2025 13:50:35 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v4] selftests/bpf: Negative test case for tail call
 map
Message-ID: <aGu0i1X_jII-3aFa@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch adds a negative test case for the following verifier error.

    expected prog array map for tail call

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Changes in v4:
  - Sent an earlier version as v3 by mistake. Monday is hard...
Changes in v3:
  - Removed BPF_F_ANY_ALIGNMENT flag as suggested by Yonghong.
Changes in v2:
  - Moved the test to prog_tests format as suggested by Eduard.
  - Rebased.
  - v1: https://lore.kernel.org/bpf/7cec754c8d4cc2d93a50e9091d7ccc7f33d454d4.1751578055.git.paul.chaignon@gmail.com/

 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_tailcall.c   | 31 +++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_tailcall.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c9da06741104..77ec95d4ffaa 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -85,6 +85,7 @@
 #include "verifier_store_release.skel.h"
 #include "verifier_subprog_precision.skel.h"
 #include "verifier_subreg.skel.h"
+#include "verifier_tailcall.skel.h"
 #include "verifier_tailcall_jit.skel.h"
 #include "verifier_typedef.skel.h"
 #include "verifier_uninit.skel.h"
@@ -219,6 +220,7 @@ void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
 void test_verifier_store_release(void)        { RUN(verifier_store_release); }
 void test_verifier_subprog_precision(void)    { RUN(verifier_subprog_precision); }
 void test_verifier_subreg(void)               { RUN(verifier_subreg); }
+void test_verifier_tailcall(void)             { RUN(verifier_tailcall); }
 void test_verifier_tailcall_jit(void)         { RUN(verifier_tailcall_jit); }
 void test_verifier_typedef(void)              { RUN(verifier_typedef); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall.c b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
new file mode 100644
index 000000000000..b4acce60fb9b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} map_array SEC(".maps");
+
+SEC("socket")
+__description("invalid map type for tail call")
+__failure __msg("expected prog array map for tail call")
+__failure_unpriv
+__naked void invalid_map_for_tail_call(void)
+{
+	asm volatile ("			\
+	r2 = %[map_array] ll;	\
+	r3 = 0;				\
+	call %[bpf_tail_call];		\
+	exit;				\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(map_array)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


