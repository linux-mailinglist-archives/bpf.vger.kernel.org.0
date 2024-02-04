Return-Path: <bpf+bounces-21167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43654849024
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 20:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4BA1F23686
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 19:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3895E250F8;
	Sun,  4 Feb 2024 19:45:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C791D24A08
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707075911; cv=none; b=PBor6kZjhMwEAT7TfoU/y6h1gfYXNeO7kdXKUHbEg4Yk61nirqyS4amXm3yMh2PcMkT+47ReMsoCbDxVOT5AJuWll1OcbBadbEsqfOYp0GJ+iLpa7T4GYjCBdUd6cw4hMhYKARs2RA1oHm/1oe6eu4mYABhl37l75EAiW/eys1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707075911; c=relaxed/simple;
	bh=R2oxl2QQesQ1Lx54dSQ9jvXgTuEth0TqpIzoaXqDQtA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FXxS6wM35UUGzng3zaVS01kOzdIIMGcRilwQ5QC41zjtIWHAyAbAgreoFyHIrLHNJOq0+wDzvKsQ6ikj1mCoY2LyboZyzjRH/SIpCiEutIPYuBq+qKaSV71VCYxf1L/mhHdEXdVHj2RiNxolkVBrCR9szgUWkVG/FxxfaxJvlMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id BCB0E2D5A2C0A; Sun,  4 Feb 2024 11:44:52 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix flaky test ptr_untrusted
Date: Sun,  4 Feb 2024 11:44:52 -0800
Message-Id: <20240204194452.2785936-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Somehow recently I frequently hit the following test failure
with either ./test_progs or ./test_progs-cpuv4:
  serial_test_ptr_untrusted:PASS:skel_open 0 nsec
  serial_test_ptr_untrusted:PASS:lsm_attach 0 nsec
  serial_test_ptr_untrusted:PASS:raw_tp_attach 0 nsec
  serial_test_ptr_untrusted:FAIL:cmp_tp_name unexpected cmp_tp_name: actu=
al -115 !=3D expected 0
  #182     ptr_untrusted:FAIL

Further investigation found the failure is due to
  bpf_probe_read_user_str()
where reading user-level string attr->raw_tracepoint.name
is not successfully, most likely due to the
string itself still in disk and not populated into memory yet.

One solution is do a printf() call of the string before doing bpf
syscall which will force the raw_tracepoint.name into memory.
But I think a more robust solution is to use bpf_copy_from_user()
which is used in sleepable program and can tolerate page fault,
and the fix here used the latter approach.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/test_ptr_untrusted.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c b/too=
ls/testing/selftests/bpf/progs/test_ptr_untrusted.c
index 4bdd65b5aa2d..2fdc44e76624 100644
--- a/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
@@ -6,13 +6,13 @@
=20
 char tp_name[128];
=20
-SEC("lsm/bpf")
+SEC("lsm.s/bpf")
 int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
 {
 	switch (cmd) {
 	case BPF_RAW_TRACEPOINT_OPEN:
-		bpf_probe_read_user_str(tp_name, sizeof(tp_name) - 1,
-					(void *)attr->raw_tracepoint.name);
+		bpf_copy_from_user(tp_name, sizeof(tp_name) - 1,
+				   (void *)attr->raw_tracepoint.name);
 		break;
 	default:
 		break;
--=20
2.34.1


