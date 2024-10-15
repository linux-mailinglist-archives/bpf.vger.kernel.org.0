Return-Path: <bpf+bounces-41994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A45E99E293
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 11:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 293E8B238CB
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 09:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479EA1DACBF;
	Tue, 15 Oct 2024 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zh3p+puk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60631CF2B2
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983582; cv=none; b=hlPBxBGNw7BO3JCYmq/3XO6eVrCcCBX1ZRqscNnBwqBaL9XcCdeErJgk9AdcfT/qjM0n0bz0s4xG3hf+HGBc14D+NZmNRIRPlYvdM58gq2V/318EGx1r76mGM/T7nnC2Y1bQLV2rknsAu34GmbvGHBkrcs4PfUVQC0pgVsmxgrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983582; c=relaxed/simple;
	bh=5RL/n5Qek/9MkjgkUP42e/4QpifIj1MSiLJuLX162Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqPMi7y+1wH9Oe5nV+3UPM7tmg0SEWkiVUyPwnhHWrimR6nRyHFIeByWWH/38yQmmjHfOKGR1BASNAbTEGx8odULrXcSM2tEnf513wNKUk0Z+PW7BNIFxexIv23wC9IIRoUcTFSXo+4MCdkGzY6MTy2iu002kUCH5kMOwMkR5yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zh3p+puk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255FEC4CEC6;
	Tue, 15 Oct 2024 09:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728983582;
	bh=5RL/n5Qek/9MkjgkUP42e/4QpifIj1MSiLJuLX162Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zh3p+pukFT+SzLUE/nAYvDoFxGaUHz+vUpIKAVPxySFzEKVhqpG91TEqQ8HksztLe
	 KmHerYhWwvHXo6o206MsaOs/8xkRfqQFldoT0fNGO5oU9Cc6RECJNZoIgc5Pp9PC30
	 wjOIAaAorBwBPGJnXJsvlrXO9m1NAw3vGEF23dDd2is7mE+/gOBhaAHXPLODWQn0zC
	 fP9+ChEdwOnorKPejhzli56xkV7auXmIBKipoUtHWRIPRRCKZr7aTfddGdsJDL28w2
	 Q98SFGpZOtvkpYcVcHooa+Qp5tX9ajL5aYmzNLqOArRJ5IbRr2sJq4dd1m1JvWAAGE
	 /cJ8KdGmmfe0w==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv7 bpf-next 12/15] selftests/bpf: Add kprobe session verifier test for return value
Date: Tue, 15 Oct 2024 11:10:47 +0200
Message-ID: <20241015091050.3731669-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015091050.3731669-1-jolsa@kernel.org>
References: <20241015091050.3731669-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Making sure kprobe.session program can return only [0,1] values.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/kprobe_multi_test.c        |  2 ++
 .../bpf/progs/kprobe_multi_verifier.c         | 31 +++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 960c9323d1e0..66ab1cae923e 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -6,6 +6,7 @@
 #include "kprobe_multi_override.skel.h"
 #include "kprobe_multi_session.skel.h"
 #include "kprobe_multi_session_cookie.skel.h"
+#include "kprobe_multi_verifier.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
@@ -764,4 +765,5 @@ void test_kprobe_multi_test(void)
 		test_session_skel_api();
 	if (test__start_subtest("session_cookie"))
 		test_session_cookie_skel_api();
+	RUN_TESTS(kprobe_multi_verifier);
 }
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c b/tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c
new file mode 100644
index 000000000000..288577e81deb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_verifier.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/usdt.bpf.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+
+SEC("kprobe.session")
+__success
+int kprobe_session_return_0(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+SEC("kprobe.session")
+__success
+int kprobe_session_return_1(struct pt_regs *ctx)
+{
+	return 1;
+}
+
+SEC("kprobe.session")
+__failure
+__msg("At program exit the register R0 has smin=2 smax=2 should have been in [0, 1]")
+int kprobe_session_return_2(struct pt_regs *ctx)
+{
+	return 2;
+}
-- 
2.46.2


