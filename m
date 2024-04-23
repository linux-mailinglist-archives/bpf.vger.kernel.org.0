Return-Path: <bpf+bounces-27504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3FE8ADD6E
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 08:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E3728351F
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 06:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05E828DBC;
	Tue, 23 Apr 2024 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bxr/YZc7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891722261D
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713853170; cv=none; b=dZUxkTx28+Nfw6gDB8efOHczTE7S2IhSoUcjGkoQMMrTJmiC1zAAyk6k+2ueD6Nsyw84d/qkqiSypGGrDcJ5mWtc4yOS0ZJf0lQIJ4dvHnN8Z1ftGRtsa2sVIr11oj9oSG/Unt6KApVy6JzLnX0rwgtyvAQqnixC5dVar2ruV0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713853170; c=relaxed/simple;
	bh=HDE5+hHWHlWfCm8iy48Dj0nkVOJiFe6vGXwgoTEKkoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxXA8pv8L53LYcyXyBHbz3LjzEFO6viDv/tnMV6JDnDv7w3bBKw3A0Jt8UbsF4+RoEsnQHvZzZyvZ59RbOwF3rm8NJCdDXe8kstHy+Q7MiPjhetclmg0+GWmPBSluKoiRCiEh6NC0ltOk8iQP0yWs0j85ewwExcOsNj3FoBD4Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bxr/YZc7; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5708d8beec6so6376867a12.0
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 23:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713853166; x=1714457966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gvo7ihpXj1DoMeXieF+otaBprYP0ZX0YNx+R9kKgZhU=;
        b=Bxr/YZc7ZZmHHLT13L+/Jeb959tgTH1XobtgAu1IAeknFEsUBtPstnvDB0jtzaWQE6
         m0FeDqz6LQbKpF1cVZY/YKzqFdJjtzBC4uUCagSlgRLH25igx2RiMi1rPBb1payjxPcR
         NhXkgUgXg+mJYsPZmemJVN7zthJzNCp5ZCRGBUgBzt9O9W1NFS8/rSj/S+H2s0vknoGo
         hyJVUGPki7iPm5Rk7Ad+UKGNnWl+iDaTumSkGaBEgYVoirgUwD3QadwV09R2qLnbnj4R
         OvDe50EU9FV9+6CtKMjuLD8BjuEYL5VUkwnmuT2xr2pBbfXTb/DSluUaUIvwN9WGk5U6
         qjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713853166; x=1714457966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gvo7ihpXj1DoMeXieF+otaBprYP0ZX0YNx+R9kKgZhU=;
        b=pEOAW4qQcsmHuZOt+zYobn8uK5ngKOY68tczlZJhmSyPo/18w/PVQmvvTi+0tW3vz+
         Ia0ZRZjWJ7eYNckHhHcN2bX1oRcNwcArmTlxdBq6R5Q08TGLmOwgdezCNriI7f3xwbjM
         B963YG1ioR/ZQTh/mhrycQ55lffOs8RtaKTAg6wAQItGYmtBfAEeqWAyS268+JBq+qjJ
         EB6FAp7XeByqi7/IQKbSEWAUQatDvgX4Sp6PplVVIE2I3EXiu9OXA+U/SXuQjwZG8GUD
         w7keorKl59twW4RRRKmlOhsazIyV7Ab3PtsCRz1N68+meSdQH6m48tYNssFTU7JecII5
         rv8g==
X-Gm-Message-State: AOJu0Yzpr1jP3cj8PvQoSz+ZClZLbRADnMydz/A6DKeDswILvegxzf0G
	+aMbHAdOkOPnaspteENz/HWz4bRfgRo0PIHuCqX3PlQpPfziuT3FOLIDVDo+
X-Google-Smtp-Source: AGHT+IFxLX1XtzUR54/N53YojSS/I1wcus7Ep1lFwqTBmSiakOvVzyyKo6x/gsqjUegy0eT00yVT7Q==
X-Received: by 2002:a50:9e05:0:b0:56e:22a1:a9a2 with SMTP id z5-20020a509e05000000b0056e22a1a9a2mr11795427ede.33.1713853166426;
        Mon, 22 Apr 2024 23:19:26 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id dj24-20020a05640231b800b0057009a23d4dsm6275062edb.95.2024.04.22.23.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 23:19:25 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Barret Rhoden <brho@google.com>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Add tests for preempt kfuncs
Date: Tue, 23 Apr 2024 06:19:22 +0000
Message-ID: <20240423061922.2295517-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423061922.2295517-1-memxor@gmail.com>
References: <20240423061922.2295517-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4468; i=memxor@gmail.com; h=from:subject; bh=HDE5+hHWHlWfCm8iy48Dj0nkVOJiFe6vGXwgoTEKkoE=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBmJ1Kgd5oupLCTEgyQSC7MnwYHABYOUfjpxhG+U wO2K2dlMCmJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZidSoAAKCRBM4MiGSL8R ykrJD/kBUvcEjqUs8v26ZtiWQDpxI92h9ZFPyNKbm4cUYTvuRyCoCDyZNoR7VSMUmhIVdvnkzIf 0+SFrsXvloEqJThHMdm7cObbYFZex9QtC87xbctlvXru6k0/4mVwTk2Q3bzJU7YUfmx9Uw4zkD1 UccnUpoZ8eIiDWFZBrxMj1d4MWkhQF6WvNTH7dMqHTUtdCubfZqU69wZMIJVCHTZ/wWAmf93NMn vi7Dn8CFeHppDc0nDNSLgzNL1qM748MN2prw0biNmkzq65JXF2eJSvJieJnRmCN8dEv2n5FbXWI kStaHy48Mt1aKZ6CvexzyIiERcxwBBHwzMV05+TYPsWcwEUngP7uOug5NkVzu5Jfi18iKQTWpJi 5MO7vYIKPkSCMFnzdXnhSRROl/JBvuX5efoFF82aPBD98/v3KAmI6Q5W1ZvBjEGNExSESb70MHv UkPkskMptDnPl42+1ghcrSl9YoSwpQQ+ZWkJHh26h+P6SY430DzAp5q95Ezvvo89IDrHnbdxKf0 PP3pcfmn5XTEFptvA+tXNB/k38skCFhcSHXEFvdZNDegLcnXns0eL1S7r42oyAQfid891UM2bMe yBTbHLtRlz5V0mINtrzJRwI0SFk3dLTRBvI0vnEEYoaCx+e5vpBfIyVlMgJqczzGiTLNu3eKJsm MjK7HfYsi53SDwQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add tests for nested cases, nested count preservation upon different
subprog calls that disable/enable preemption, and test sleepable helper
call in non-preemptible regions.

181/1   preempt_lock/preempt_lock_missing_1:OK
181/2   preempt_lock/preempt_lock_missing_2:OK
181/3   preempt_lock/preempt_lock_missing_3:OK
181/4   preempt_lock/preempt_lock_missing_3_minus_2:OK
181/5   preempt_lock/preempt_lock_missing_1_subprog:OK
181/6   preempt_lock/preempt_lock_missing_2_subprog:OK
181/7   preempt_lock/preempt_lock_missing_2_minus_1_subprog:OK
181/8   preempt_lock/preempt_balance:OK
181/9   preempt_lock/preempt_balance_subprog_test:OK
181/10  preempt_lock/preempt_sleepable_helper:OK
181     preempt_lock:OK
Summary: 1/10 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/preempt_lock.c   |   9 ++
 .../selftests/bpf/progs/preempt_lock.c        | 119 ++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/preempt_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/preempt_lock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/preempt_lock.c b/tools/testing/selftests/bpf/prog_tests/preempt_lock.c
new file mode 100644
index 000000000000..02917c672441
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/preempt_lock.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+#include <preempt_lock.skel.h>
+
+void test_preempt_lock(void)
+{
+	RUN_TESTS(preempt_lock);
+}
diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
new file mode 100644
index 000000000000..53320ea80fa4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+void bpf_preempt_disable(void) __ksym;
+void bpf_preempt_enable(void) __ksym;
+
+SEC("?tc")
+__failure __msg("1 bpf_preempt_enable is missing")
+int preempt_lock_missing_1(struct __sk_buff *ctx)
+{
+	bpf_preempt_disable();
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("2 bpf_preempt_enable(s) are missing")
+int preempt_lock_missing_2(struct __sk_buff *ctx)
+{
+	bpf_preempt_disable();
+	bpf_preempt_disable();
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("3 bpf_preempt_enable(s) are missing")
+int preempt_lock_missing_3(struct __sk_buff *ctx)
+{
+	bpf_preempt_disable();
+	bpf_preempt_disable();
+	bpf_preempt_disable();
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("1 bpf_preempt_enable is missing")
+int preempt_lock_missing_3_minus_2(struct __sk_buff *ctx)
+{
+	bpf_preempt_disable();
+	bpf_preempt_disable();
+	bpf_preempt_disable();
+	bpf_preempt_enable();
+	bpf_preempt_enable();
+	return 0;
+}
+
+static __noinline void preempt_disable(void)
+{
+	bpf_preempt_disable();
+}
+
+static __noinline void preempt_enable(void)
+{
+	bpf_preempt_enable();
+}
+
+SEC("?tc")
+__failure __msg("1 bpf_preempt_enable is missing")
+int preempt_lock_missing_1_subprog(struct __sk_buff *ctx)
+{
+	preempt_disable();
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("2 bpf_preempt_enable(s) are missing")
+int preempt_lock_missing_2_subprog(struct __sk_buff *ctx)
+{
+	preempt_disable();
+	preempt_disable();
+	return 0;
+}
+
+SEC("?tc")
+__failure __msg("1 bpf_preempt_enable is missing")
+int preempt_lock_missing_2_minus_1_subprog(struct __sk_buff *ctx)
+{
+	preempt_disable();
+	preempt_disable();
+	preempt_enable();
+	return 0;
+}
+
+static __noinline void preempt_balance_subprog(void)
+{
+	preempt_disable();
+	preempt_enable();
+}
+
+SEC("?tc")
+__success int preempt_balance(struct __sk_buff *ctx)
+{
+	bpf_preempt_disable();
+	bpf_preempt_enable();
+	return 0;
+}
+
+SEC("?tc")
+__success int preempt_balance_subprog_test(struct __sk_buff *ctx)
+{
+	preempt_balance_subprog();
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("sleepable helper bpf_copy_from_user#")
+int preempt_sleepable_helper(void *ctx)
+{
+	u32 data;
+
+	bpf_preempt_disable();
+	bpf_copy_from_user(&data, sizeof(data), NULL);
+	bpf_preempt_enable();
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


