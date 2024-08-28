Return-Path: <bpf+bounces-38315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E4A963173
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 22:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207101F22F0D
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 20:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3581ABECB;
	Wed, 28 Aug 2024 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="J1fzUmuH"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19012036.outbound.protection.outlook.com [52.103.32.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25121125BA;
	Wed, 28 Aug 2024 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724875681; cv=fail; b=kGG9eNPmTgCQtdkmYw5uo41qGHVc69sko/j8AVrKqNb46EvEg9KlC5ZD1kVcpFFHD56bFUblsTzNep1vNuwvtqZIPQHoS/fKEgVr5O4BqKdauFIhVszH+XH75hKYTNWu0sZCS3kO5mDlmD6ES0JXPthGYg4jfpU+e4nLjfODT0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724875681; c=relaxed/simple;
	bh=ynam601Yz10iaM+BbWHDjnUW5RO0j8n2ldSYjJUHi4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZpcjEDjscgKFYPyUGqRgTpMtKYx7UjNK8AeCLCqU5ckdGsHhdHWGKmnAO5F2AZ+7kgSAlNkB0wzzPwcZr059HTIXSnt+bfjcTKHvUgVMICj7PIfpW8GqXFIAy09rwBuFaFlq5gYP/CuCfykuraKba2viW5dLuJ3Wb3CHkIuHYS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=J1fzUmuH; arc=fail smtp.client-ip=52.103.32.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynRQb6RjM0MWgVXnn4uZpnXvdrMukad/MUHXhw2GIkxU+vKJGyITMW3ttCeU2qMpu3iB+tLWT5FDkNBnDl9H/9lRgtuQvBjqyGD6sIEM7gctsxRsQV0Wa7LbZuTTaOIKqXh3uqiNRBPSC81Poux7d2SRco9UfLOLGKRPMMr8yZwdhAkDZrFAa/9nhnQrayo0RhvCw9lhRH8SHdY4vDi/AQaB/KwzXj5zBtGTZVQbnEQfZKE6wo3YeG/BITYIAyFc2PrQpjOgFl9E5kBOdmDnEAPVbscndte9xXUwaWh3WJdYBmT3ze5WK0ZUZbCk0k1YyWh7XBPU2qIx8kaAgW9lDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qw99njkeIN1UYtWdHhEZN8LuSyBAna7OqDq1laf0yos=;
 b=fRfCodVdiBoWB42hJ/OamKTfHHnAjRblyVLMoofeZ6ju9XukE5wFaC9gaWRIDOprz0kT0FnKm7Utb8KcI68FpjuKGeZe8Y4Pqm/gLhfObvhrYNOVU3PNRFFvH+n084YM7YeumUlhxqv/JXeu8dDkSrSfYHsbrR190+4Im/q9VBuciIWv9iSpG2gu0zZD38MyTDwobHMtu4O96d37zf30M2d65Ld0Ehffrc/Snmr1iXjbtPv9RpHgqyRwchbqKhfb0/AD1wr8Y0TOkpd3taFFWmsqGhSAX7hOeCs5imy4h5t/5YBIzZm83h/wtZkXqRNRQHW5WX1128efFORIodnmzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qw99njkeIN1UYtWdHhEZN8LuSyBAna7OqDq1laf0yos=;
 b=J1fzUmuHWtGN7JU9oEGrvzL5seRW8rlXlJdsCDLQhlotBeqVs7e1iZQ1onHqHyEqBaz3/b0ynkHn2HsYLNYOEGkJBNLCCb5NjBEeboLeH47oY0hMBr0VSvZ62bIAW1/dBA0i9JA/VsdPnlZWF/oRYXgKFeYsPL+57DeLdASaL6Jcn86BOgNV/VV0XnV1D1iPUTy7Y+mHpe+E7JcKMplJ9wb+fDVA7SONu4RU/R1xf7+oAKy7db6ZgfP9wTvWmzddvncDjnjyHnEWnyUxA/pO7sdT7vIZemETiY7dil8uEJVnonplNxbkP1NUoMi+IZGGAxsT/7gOcnTj/tA4xfJ6GQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by VI0PR03MB10807.eurprd03.prod.outlook.com (2603:10a6:800:26a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 20:07:55 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 20:07:55 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for KF_OBTAIN kfunc
Date: Wed, 28 Aug 2024 21:07:41 +0100
Message-ID:
 <AM6PR03MB58485695AD7D298A08FEE8C599952@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB5848874457E6E3E21635B18999952@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB5848874457E6E3E21635B18999952@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [r+RzXW0+jhgGMZUs2cCFmcrKbBQmVJZA]
X-ClientProxiedBy: LO4P123CA0547.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::16) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240828200741.53189-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|VI0PR03MB10807:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a883b3-2c51-40ea-299f-08dcc79d1afb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|8060799006|461199028|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	M5lHAJrYIMldcXjrbgJpi+fy8EON13pWXceeXjV4aSQ02dZc9foY3H0BqUSnoPmAB26Mrv9xsOHC2bGHxdSF4IHBXCT2CexEhRU3GVDXxMacWTQ5OiAdtKemiPjtF95G5dmclmjR/1nscbiDT+mCvt6TydalT7hkGZDPDAfMhnHxZHx8c0/qRkD8Jbo7pd8wfOrMnLU3Vc7PdbEcR+FWFGXPc/qgw00+6uTOhQ/0fumg3T3fKQaS5VQbvQE0x6AyD0Hk9TFaZs0frOErgEnf33h4b/ECsY469oVLUpMzVGQgp/EBOrBHifkBi7htXumK2CwL9tJxua/5xiXBA1pye4KAH9LkkbEmnFYV0hyPVciml10HhhfLXd9Tf2I/JnusV+36XsIjcmXEhH2mP4/37tvBPvTWJMtLw/JYuIsplkUwb7EGJ3zNPnPu8w++leEV/lkG46g50aRIVF5AsVYd3ep14uukC0d2MW9T78Omac50OC8oxGNMl6claKgjCPqQuoWjs1TA1fzQWefJm5HDTW59rnN+yrXDuJK/J8uPUI1QoMfUBD23YRQUNdW8reDRpZLihUGCjf/0Gpsh20HZwDO7ZaDaCvFFIXOt3AqRzZxyofl2HjJ+ZCkV371cQ4iz6emNMLC2eQzppREpz7qKK0ZayGs7bjpgMRNt8LWb3iVlgTnV5x8pq+fHvqJoJR8WfZ8NrpkR3Og4or8pvezuPw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oJbw4PCp15ShIhoPfPWoiY6NsKCkZwSTfM8HlS//LZaHaPBeYXZ0SOFmcCmY?=
 =?us-ascii?Q?SbKu6TTSNPJ0dWaBwbeyhqDi68HqSRzPJgMgxyrU9AEw7/rBUFCqQWSDL6Nu?=
 =?us-ascii?Q?oLPzWonZ3Tp9HcCQ1SujnmGaPzmwc9byjEbbOR3ha1V1mB0BxuWaoqkeB3Gr?=
 =?us-ascii?Q?JW+uNlKIp7LSNwD3aEVBDoInpUUHyQSHWtEVNmPCXsBvXZpPxo7oD0ohps4L?=
 =?us-ascii?Q?kTIlHFuAoBTzC6YU6fRuh+wp39Kz20PWGWivvpVKy4X3Wvbj2exyN9429eo5?=
 =?us-ascii?Q?8NBHrepnVU1rEdkPg02nM4V1KLtVMvnAzs7aNE8DW5tLU1OB4grFSATJ3D6I?=
 =?us-ascii?Q?DYg5LdURDRe0P8jXBzw+OhrAk79TS7Jfs1vC1e9NrCcVxKRa3vp49Zbeo2oR?=
 =?us-ascii?Q?jlv0WwsIN+58mmfI8i8sdNSaH9f9P6An/TQo3+IqvW8iSyao6CXcodSZJsY0?=
 =?us-ascii?Q?WuFHjTGPX15SWhhGTZeYNxS9e6S674FQqZ2fG3tYy49LuiErIN0KcNkjiwcb?=
 =?us-ascii?Q?cuwGTS2XTHvbpFX6pg4axwqOFmNOcjF5Ngbm4+4mdFNGMJlqGIPBswm6ihi/?=
 =?us-ascii?Q?nX0TJmcsEwenux+BWoHr/RxMEZHf+QBBJFayPDTjtnshROBDRWdJnM9Za1Z5?=
 =?us-ascii?Q?UDLtnnPCaxx4osEerbi3mzWnVgFI8a32QpowZGAA/mFmT6tyTpMsfIMJHyyT?=
 =?us-ascii?Q?X97/ytApGqF0T7bHC1nZ4IS+1GKan1bcyqnDV5IsQdEOc52/cm9wKsX4Q7Hq?=
 =?us-ascii?Q?kdujCWJkZMxovx8cIwhzxdgTSIOlXmw4zTGPZqnk4gstLbGG7NbkWzw6o2ML?=
 =?us-ascii?Q?2IK4JrqjWiBnFOINrXOcPPlTb4LRizskiMePxmXRGUrbbB5Ue148hLXICB8q?=
 =?us-ascii?Q?vqpgD7NRGoxHfn9RTX7sZPkbtzdn9GK92ftCqx175vhZYbGcd4Ow7+QYBM6a?=
 =?us-ascii?Q?r561IA7X7/pQvtLmP1+dT/OKOwcwWnetjde7csNj8rEL3h2qu8fpFf/eiS/G?=
 =?us-ascii?Q?Jv+B8Ntse61X/jujAdc0bkEJhNSq9cLCl3yPac5b1W2ggCoudB9RDo4egSZF?=
 =?us-ascii?Q?2NvRK8zNJzYeFFQ7irJLvHDq7f/veK4gYqfw6caTHFFIx8/uhYMyy5OA+wjK?=
 =?us-ascii?Q?Zi2AP1oe+QX6G0cI39reoIqMYqioHAVJNtgSdoAVODgzIeehQx8SuCtRMnbq?=
 =?us-ascii?Q?Acf8bIMNApfbk/h5kVKLM1CMm/7EaeUR3x/bfTsKOxqdX8UxwqeikA97XfXw?=
 =?us-ascii?Q?Tp681NM7yDIYr+Gl+hxB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a883b3-2c51-40ea-299f-08dcc79d1afb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 20:07:55.8225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10807

This patch adds test cases for KF_OBTAIN kfunc. Note that these test
cases are only used to test KF_OBTAIN and are not related to actual
usage scenarios.

kfunc_obtain_not_trusted is used to test that KF_OBTAIN kfunc only
accepts valid pointers.

kfunc_obtain_use_after_release is used to test that the returned pointer
becomes invalid after the pointer passed to KF_OBTAIN kfunc is released.

kfunc_obtain_trusted is the correct usage, valid pointers must be passed
to KF_OBTAIN kfunc and the returned pointer is only used if the passed
pointer has not been released.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 12 +++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  3 +
 .../bpf/prog_tests/kfunc_obtain_test.c        | 10 +++
 .../selftests/bpf/progs/kfunc_obtain.c        | 74 +++++++++++++++++++
 4 files changed, 99 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_obtain_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/kfunc_obtain.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index bbf9442f0722..9e8a54dc88a2 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -183,6 +183,16 @@ __bpf_kfunc void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr,
 {
 }
 
+struct mm_struct *bpf_kfunc_obtain_test(struct task_struct *task)
+{
+	return task->mm;
+}
+
+struct task_struct *bpf_get_untrusted_task_test(struct task_struct *task)
+{
+	return task;
+}
+
 __bpf_kfunc struct bpf_testmod_ctx *
 bpf_testmod_ctx_create(int *err)
 {
@@ -541,6 +551,8 @@ BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_value)
 BTF_ID_FLAGS(func, bpf_kfunc_common_test)
 BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
+BTF_ID_FLAGS(func, bpf_kfunc_obtain_test, KF_OBTAIN)
+BTF_ID_FLAGS(func, bpf_get_untrusted_task_test)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_create, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index e587a79f2239..cb38a211a9f3 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -144,4 +144,7 @@ void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr, struct bpf_dynptr *ptr__nulla
 struct bpf_testmod_ctx *bpf_testmod_ctx_create(int *err) __ksym;
 void bpf_testmod_ctx_release(struct bpf_testmod_ctx *ctx) __ksym;
 
+struct mm_struct *bpf_kfunc_obtain_test(struct task_struct *task) __ksym;
+struct task_struct *bpf_get_untrusted_task_test(struct task_struct *task) __ksym;
+
 #endif /* _BPF_TESTMOD_KFUNC_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_obtain_test.c b/tools/testing/selftests/bpf/prog_tests/kfunc_obtain_test.c
new file mode 100644
index 000000000000..debc92fc1acc
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_obtain_test.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "kfunc_obtain.skel.h"
+
+void test_kfunc_obtain(void)
+{
+	if (env.has_testmod)
+		RUN_TESTS(kfunc_obtain);
+}
diff --git a/tools/testing/selftests/bpf/progs/kfunc_obtain.c b/tools/testing/selftests/bpf/progs/kfunc_obtain.c
new file mode 100644
index 000000000000..8f0e074928ce
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kfunc_obtain.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
+/* The following test cases are only used to test KF_OBTAIN
+ * and are not related to actual usage scenarios.
+ */
+
+SEC("syscall")
+__failure __msg("must be referenced or trusted")
+int BPF_PROG(kfunc_obtain_not_trusted)
+{
+	struct task_struct *cur_task, *untrusted_task;
+
+	cur_task = bpf_get_current_task_btf();
+	untrusted_task = bpf_get_untrusted_task_test(cur_task);
+
+	bpf_kfunc_obtain_test(untrusted_task);
+
+	return 0;
+}
+
+SEC("syscall")
+__success
+int BPF_PROG(kfunc_obtain_trusted)
+{
+	struct task_struct *cur_task, *trusted_task;
+	struct mm_struct *mm;
+	int map_count = 0;
+
+	cur_task = bpf_get_current_task_btf();
+	trusted_task = bpf_task_from_pid(cur_task->pid);
+	if (trusted_task == NULL)
+		return 0;
+
+	mm = bpf_kfunc_obtain_test(trusted_task);
+
+	map_count = mm->map_count;
+
+	bpf_task_release(trusted_task);
+
+	return map_count;
+}
+
+SEC("syscall")
+__failure __msg("invalid mem access 'scalar'")
+int BPF_PROG(kfunc_obtain_use_after_release)
+{
+	struct task_struct *cur_task, *trusted_task;
+	struct mm_struct *mm;
+	int map_count = 0;
+
+	cur_task = bpf_get_current_task_btf();
+	trusted_task = bpf_task_from_pid(cur_task->pid);
+	if (trusted_task == NULL)
+		return 0;
+
+	mm = bpf_kfunc_obtain_test(trusted_task);
+
+	bpf_task_release(trusted_task);
+
+	map_count = mm->map_count;
+
+	return map_count;
+}
-- 
2.39.2


