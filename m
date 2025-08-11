Return-Path: <bpf+bounces-65370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6241CB213A4
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 19:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671AF3E4B98
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 17:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1C02D4814;
	Mon, 11 Aug 2025 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am6ljfLt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A072D4800
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934653; cv=none; b=Snfp59Fh9kpOVKSeT1DhGKz9Q+Gdb9BZ52YIicAzWBPRH9mPJxViPwt135dLy9jpYzGpTfMYcQ8oyjK4eq/ajqk25GpEzKisA24fy6JMJaV3ey5t2EMs8U2goKt3Q8HqQpYF78hnBizAxzCr1nMafkLrA9ZO+bzOm7RrVXPxDgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934653; c=relaxed/simple;
	bh=cDNtqelgxRqze5iEaLTrJpibzUN4XiqvLYYHUCJwrDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgaCFgel9sv+RtBgbg5eXKElg/eVKvoZ17EV/PVFWEwJ8CNnIAk6U3g7OygR3aE6YHAii8W9ctGdv0o+NO9KmXDwuHFgs5V7EuCbCkdWmDQWZWxgu0p3q2FgKt0pHggvuuz6+nA9sZfFYrqlt1F9clnUpSoUhHhkuTH4gWYljwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am6ljfLt; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-adfb562266cso637152966b.0
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 10:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754934649; x=1755539449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0DC9QffGFkrYC9IiCsOHYQnz8Xa9O+XiIOugwbZLoE=;
        b=am6ljfLt7F19ntAWh7dJjiJBeo2ipJIK0D1j3p7z3e5Vc4Ea/D4cQB52Zml3Qqi7JU
         mu/9Bh82NW7JcGT8HBXrsocCcNV/pqrbMRcM7h3SM8DWbkDvyuJJs+UfUoykoyX/vREV
         5AFmwOgzGm8u1aBldyL0dLYCIx963/mM9UnQGAv3JMgmwxZAUObhrxlLmmf76rNgpY6N
         4m42DQ0B0L5Qe2txOg0v308Uw6ySyf5Xxh7jq2v7TN0nxCXsgppxyNJi9DkGAOyDVYgf
         iXcVwFh/rDBKo1GoFRhaTOzjSE0ljfZbP6B8mhtfBDN80WL9bUbuo9l/0Vp00UTVgLHq
         Kpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754934649; x=1755539449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0DC9QffGFkrYC9IiCsOHYQnz8Xa9O+XiIOugwbZLoE=;
        b=KzpwAjown1wuEcqYkd2DkZbit0+6cLKajCUXvhIsgBX1pMiwnaMtAMas6TJr0dS3Dy
         LVzPKyN2wU7ZnbQ1gdzuqmtGtuy4F1pyihSEf1B9kkfTrD4UExZdO7wtr47SpfGeHV76
         RK67iaSDP9Cvr6dpZTfp2G/JZi05vTxBGK67nPiGf+38fJFOetB1UcIOrzoJS3CiFgHO
         LO8sVw2sT/Bw66qghshu6pgpswFnUE9XlYwS1POKORqFWLeBICWpoGsNpaPEUrFBTut2
         aGMKs0z3+4gqT7zM9w4G/dIq941u15xcbr9pR0RFUQVZPl0X//RiUt/rH7xCTkyU7p32
         QtPg==
X-Gm-Message-State: AOJu0Ywp0/Lp2tejIsZnPXWXHPhjHbiwogDeYDFrjZetFtZOqSge3b/y
	1fGGxrJlWhxdri4tNpYg+x4F561jvr6S80u9U/YITvOG1P/M/gYso9m23GsoB3loe3s=
X-Gm-Gg: ASbGnctv18/34IqMT00lQVMAKvhMwjeBIHj99O/hM65XJNcPzKRGEN9tk86TqMqlYmO
	XjCKtJaaRGX7Le6IDR9cNfI42ioEA2Zh4etEhcku8UZEjctYo9oi30vq3aQB6MftpCxiF2ZM0Cj
	cFoeHmD/gPIe38u4OAu9n7Eqx3iOveKcPyb5hLVcjrz9QRwBZHsC3LwLHrzA2L0Tr+Kxm47FBLk
	zFPhCDiCLoB1MxZf12b9IguewVALRtGdHrRPzQOVC3itUoh3WbGSJZfxW32emphp+lt141eddal
	hKXOIk3zN36toU4Ft9aOyG/NBiogz4Ow2FJB6D/teeYBEjGO7Bd8fsdK6P9lYbch/TORjXOtRCQ
	9+fLCV+WQsao=
X-Google-Smtp-Source: AGHT+IFRi7TsWgMj2qLh9NOFTNHhXe8Iz19H+pV88c0CS8z4XlsoyfSiQmIZ2b2lxqQiR4igyvlTmQ==
X-Received: by 2002:a17:907:3faa:b0:af9:a53a:6b46 with SMTP id a640c23a62f3a-afa1dff9606mr36015866b.17.1754934649085;
        Mon, 11 Aug 2025 10:50:49 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a39c4sm2071836266b.43.2025.08.11.10.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 10:50:48 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	tj@kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Dan Schatzberg <dschatzberg@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Add a test for bpf_cgroup_from_id lookup in non-root cgns
Date: Mon, 11 Aug 2025 10:50:45 -0700
Message-ID: <20250811175045.1055202-3-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250811175045.1055202-1-memxor@gmail.com>
References: <20250811175045.1055202-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2808; h=from:subject; bh=cDNtqelgxRqze5iEaLTrJpibzUN4XiqvLYYHUCJwrDo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBomizLG/AWOcOX1Chqs6cGXsCcSZzznfoev3fiDsR+ IScGw1mJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaJosywAKCRBM4MiGSL8Ryo0tD/ 45uKjFSHcDhr3tjNqE6RJ/RDzKuCOQesqj4ODQEKFDBLocfxaFgkUw3me9thcAH4B0J4P9Hgf2M75G ObVazS7TJoc0AzZlXTIbP2xQv2UgAvQxweuxF/2oRZ7W4Rhw+AbAFAErrqoYd9ctKKdHveLokyXCV6 mzUWAuOcXniW2ggms4FYgDInlZrYn/yMVTYr4tZ0LvCdVZIz3p42sV52knOlfcUNTSugwP2fr4UWBo Zs8frX0tE73S8t0VYFmIDzGC7sSjSM4aoO0OBNcZ27sMUZRVxWJ0/1+MWHT/EM/gPtIepgA2ECP6Zg Gz6YxQc8Z9ASicGgkpd7nu7Hc/npjqeyBcibOfUeJgyKpISpzGnbyLImGC8gUUtLBF5jImATnU98C7 d+iT9Q5duqlXkN3Ol0Ee+FN/o+9CubdpQTbU0WGE/XeAXl0FENMQTZTpF0qX/Jk8yNZquORclPFhp1 N0c3Ch3DhUl6rOYmykq8tvao+vW+CwhV/+CcJN6vsE205x8RNmrFFpLaMhomrtroXAiRbFUbONyGbf FQx3KhDWepP4aKbh4tzQP+9jtSei/VmgsYHWxfJFJSRC1j9SRXOLCp4Eyu6x9agTCLJAY4RLlgVLJa LIPxUay1Ip3hjF6DNaXCX0TEQzHJLYTdYxHFMWh6apP2I80STr3ZEDy/S07g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/cgrp_kfunc.c     | 48 +++++++++++++++++++
 .../selftests/bpf/progs/cgrp_kfunc_success.c  | 12 +++++
 2 files changed, 60 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
index adda85f97058..cb3a220488c2 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgrp_kfunc.c
@@ -4,6 +4,7 @@
 #define _GNU_SOURCE
 #include <cgroup_helpers.h>
 #include <test_progs.h>
+#include <sched.h>
 
 #include "cgrp_kfunc_failure.skel.h"
 #include "cgrp_kfunc_success.skel.h"
@@ -87,6 +88,50 @@ static const char * const success_tests[] = {
 	"test_cgrp_from_id",
 };
 
+static void test_cgrp_from_id_ns(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct cgrp_kfunc_success *skel;
+	struct bpf_program *prog;
+	int fd, ret;
+
+	skel = open_load_cgrp_kfunc_skel();
+	if (!ASSERT_OK_PTR(skel, "open_load_skel"))
+		return;
+
+	if (!ASSERT_OK(skel->bss->err, "pre_mkdir_err"))
+		goto cleanup;
+
+	prog = bpf_object__find_program_by_name(skel->obj, "test_cgrp_from_id_ns");
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
+
+	fd = create_and_get_cgroup("cgrp_from_id_ns");
+	if (!ASSERT_GE(fd, 0, "cgrp_fd"))
+		goto cleanup;
+
+	if (!ASSERT_OK(join_cgroup("cgrp_from_id_ns"), "join cgrp"))
+		goto fd_cleanup;
+
+	if (!ASSERT_OK(unshare(CLONE_NEWCGROUP), "unshare cgns"))
+		goto fd_cleanup;
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+	if (!ASSERT_OK(ret, "test run ret"))
+		goto fd_cleanup;
+
+	if (!ASSERT_OK(opts.retval, "test run retval"))
+		goto fd_cleanup;
+
+	remove_cgroup("cgrp_from_id_ns");
+
+fd_cleanup:
+	close(fd);
+cleanup:
+	cgrp_kfunc_success__destroy(skel);
+
+}
+
 void test_cgrp_kfunc(void)
 {
 	int i, err;
@@ -102,6 +147,9 @@ void test_cgrp_kfunc(void)
 		run_success_test(success_tests[i]);
 	}
 
+	if (test__start_subtest("test_cgrp_from_id_ns"))
+		test_cgrp_from_id_ns();
+
 	RUN_TESTS(cgrp_kfunc_failure);
 
 cleanup:
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
index 5354455a01be..02d8f160ca0e 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_success.c
@@ -221,3 +221,15 @@ int BPF_PROG(test_cgrp_from_id, struct cgroup *cgrp, const char *path)
 
 	return 0;
 }
+
+SEC("syscall")
+int test_cgrp_from_id_ns(void *ctx)
+{
+	struct cgroup *cg;
+
+	cg = bpf_cgroup_from_id(1);
+	if (!cg)
+		return 42;
+	bpf_cgroup_release(cg);
+	return 0;
+}
-- 
2.47.3


