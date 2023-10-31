Return-Path: <bpf+bounces-13759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 675077DD7F5
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 22:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217D8281953
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 21:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A7A27440;
	Tue, 31 Oct 2023 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SPDO6LT/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0849225AF
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 21:56:42 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92404ED
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 14:56:40 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VH2e9X001067
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 14:56:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=r+rbjdnMyJVPMuR6yJQECVsOcDt0dNvT6G97Bed+iRg=;
 b=SPDO6LT/oqzbURuKLE6lc5MaBheMZUSwJTQ6Hy09TGOKUvOZusjmNCKFShgrkRrEBN0d
 Qy9LFR/Y8tiFrWz/Q+cc9F3XXW6njt7xskVOgHGhtGx7G0q2QbIf67Rg0us/apEwYT1C
 XdY2Sg6KLPsr2vANw7MqEyqjfq/7U4F3s/I= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u2j6s156e-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 14:56:39 -0700
Received: from twshared2737.02.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 14:56:34 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 31AD926957E01; Tue, 31 Oct 2023 14:56:26 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>, <laoar.shao@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 2/2] bpf: Add __bpf_hook_{start,end} macros
Date: Tue, 31 Oct 2023 14:56:25 -0700
Message-ID: <20231031215625.2343848-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031215625.2343848-1-davemarchevsky@fb.com>
References: <20231031215625.2343848-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pyFzszXTMul3wX-LBhxC3wiqk6mkqS74
X-Proofpoint-GUID: pyFzszXTMul3wX-LBhxC3wiqk6mkqS74
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_08,2023-10-31_03,2023-05-22_02

Not all uses of __diag_ignore_all(...) in BPF-related code in order to
suppress warnings are wrapping kfunc definitions. Some "hook point"
definitions - small functions meant to be used as attach points for
fentry and similar BPF progs - need to suppress -Wmissing-declarations.

We could use __bpf_kfunc_{start,end}_defs added in the previous patch in
such cases, but this might be confusing to someone unfamiliar with BPF
internals. Instead, this patch adds __bpf_hook_{start,end} macros,
currently having the same effect as __bpf_kfunc_{start,end}_defs, then
uses them to suppress warnings for two hook points in the kernel itself
and some bpf_testmod hook points as well.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Cc: Yafang Shao <laoar.shao@gmail.com>
---

This patch was added in v2 in response to convo on v1's thread.

 include/linux/btf.h                                   | 2 ++
 kernel/cgroup/rstat.c                                 | 9 +++------
 net/socket.c                                          | 8 ++------
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 6 ++----
 4 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index dc5ce962f600..59d404e22814 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -92,6 +92,8 @@
 			  "Global kfuncs as their definitions will be in BTF")
=20
 #define __bpf_kfunc_end_defs() __diag_pop()
+#define __bpf_hook_start() __bpf_kfunc_start_defs()
+#define __bpf_hook_end() __bpf_kfunc_end_defs()
=20
 /*
  * Return the name of the passed struct, if exists, or halt the build if=
 for
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index d80d7a608141..c0adb7254b45 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -156,19 +156,16 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(=
struct cgroup *pos,
  * optimize away the callsite. Therefore, __weak is needed to ensure tha=
t the
  * call is still emitted, by telling the compiler that we don't know wha=
t the
  * function might eventually be.
- *
- * __diag_* below are needed to dismiss the missing prototype warning.
  */
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "kfuncs which will be used in BPF programs");
+
+__bpf_hook_start();
=20
 __weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
 				     struct cgroup *parent, int cpu)
 {
 }
=20
-__diag_pop();
+__bpf_hook_end();
=20
 /* see cgroup_rstat_flush() */
 static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
diff --git a/net/socket.c b/net/socket.c
index c4a6f5532955..cd4d9ae2144f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1685,20 +1685,16 @@ struct file *__sys_socket_file(int family, int ty=
pe, int protocol)
  *	Therefore, __weak is needed to ensure that the call is still
  *	emitted, by telling the compiler that we don't know what the
  *	function might eventually be.
- *
- *	__diag_* below are needed to dismiss the missing prototype warning.
  */
=20
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "A fmod_ret entry point for BPF programs");
+__bpf_hook_start();
=20
 __weak noinline int update_socket_protocol(int family, int type, int pro=
tocol)
 {
 	return protocol;
 }
=20
-__diag_pop();
+__bpf_hook_end();
=20
 int __sys_socket(int family, int type, int protocol)
 {
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index a5e246f7b202..91907b321f91 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -39,9 +39,7 @@ struct bpf_testmod_struct_arg_4 {
 	int b;
 };
=20
-__diag_push();
-__diag_ignore_all("-Wmissing-prototypes",
-		  "Global functions as their definitions will be in bpf_testmod.ko BTF=
");
+__bpf_hook_start();
=20
 noinline int
 bpf_testmod_test_struct_arg_1(struct bpf_testmod_struct_arg_2 a, int b, =
int c) {
@@ -335,7 +333,7 @@ noinline int bpf_fentry_shadow_test(int a)
 }
 EXPORT_SYMBOL_GPL(bpf_fentry_shadow_test);
=20
-__diag_pop();
+__bpf_hook_end();
=20
 static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init =3D=
 {
 	.attr =3D { .name =3D "bpf_testmod", .mode =3D 0666, },
--=20
2.34.1


