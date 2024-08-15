Return-Path: <bpf+bounces-37278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1209D95381F
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 18:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F491C23609
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 16:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F171B3F18;
	Thu, 15 Aug 2024 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oC1ZfmDR"
X-Original-To: bpf@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19013010.outbound.protection.outlook.com [52.103.32.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C833A1CD;
	Thu, 15 Aug 2024 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738794; cv=fail; b=WB5R84HlmvvQDe7/rtuDLy+lQYpKfKgiYWKmO9tIxloOZYgnsHvTY6v4V5jk9W3FJ6r6va3sEOeZSndx1XothZ3HfsFkMIo20v+WybFTascbY+A9zetGrBSkdlz/Lu5rJBeEL/SPiM7gHxWt2ieGiyTzfCKX9GoPASe37L0hsQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738794; c=relaxed/simple;
	bh=VwavY4zkRdNul673zJztj0n0LfvkU02YPz8OkklkEXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S8uIGLJY3KyBWGrEWwLEIg+hupSIIn5hsUZtTaFTQIEv9eBJM4i4kwu8tw0tennMuHJ9HA5poc0K0gmZMHl0vN9B6djnQiC7q3HNtzEHq8IA9VDqmeJcbctLWDnc+1u5Ao6gC9acM6cFn3278Wob4EnRdRSSzGg7EfUPqR4yV24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oC1ZfmDR; arc=fail smtp.client-ip=52.103.32.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pi78EK98Rmi8hwiP3IG6wFuoC04u1qnntpcTtY/VG57OHs0B8iF8KCvv7mrLQy+1sMpn/dHWZq888TH1OEIpJUpAtgd44rUpalJp/XLs+5Eo1dihNME2vTgcLSEGX7czjOtnWJR7NTeVDOomNq1WNu5p5BFGiWg4opvH5anZZl0EVldtQpbMYB8ltmC69f5HVOf0sGG/jxws645kFo4ybBebCJ4z33f0UoM0CaSTC65F8fHjOU+7o6jhfsnDYQzorf7wl1wY9gevbZPGk6KRniHun2So41b7TcXt/QkInr9+kIXS9/brJSm4UES9K8q/O1KG37Q/wMkz0fVbIVt58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAOY8wDHshQFbojhsMk/P0eutBN2v9BkCvedpsB5Wps=;
 b=nsvzT/r5mnizMEko9RXiS4K9PbdpzQCykJu/KPEUWmUgA8OxhXMMxevaBEZ/axDKoQjPk/zwCGzu+y1TxdBJLzV+EnYr/Y410eEDowsa1cmt6z8nj8OeJOodGR83JwbuixKIb4cFBKacirqa7IGR7RIWeur8ow7UZEPO6X7Xq0x52NkMCU/HlafQqolcT+EtDn2Ts2pZviHKTrGLAq6wW2FP4C6lj2lU9/6dUFAlJRuFrdtUMTIAhgGf2ByrWxhFuOT6DNFkxS+87sKzwAmXXHJnT4l5Y15o+wXYgH3Ie4Ymp7LTtlaUbAvtDBjhXj6pRJaOHPYCHv+n0pi61unoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAOY8wDHshQFbojhsMk/P0eutBN2v9BkCvedpsB5Wps=;
 b=oC1ZfmDRpLT+aclAaH65dD42iiYc83a1T38xYhf8XZ+jZmOhF5ANj0vCVPxtsx6j751o+Ej60vEABH1vMzKZb710+y0p1NV0mzF8o1qDSJCCOfFVdS5z98fFH1WR30IFs1UMwz7k0aqvDbd+mezRro4M9OpOD7Eb18wsEDP52CuHLCA8GY2LaCbVIuo6Mhj4pRvI4jqYYTr2Y9dXvpae9TaJg4jRRoKg6Z/fxqXYJGc+tWUkJ8S6Zaq7Q9sllGwUf2NHKlyEQ7qC9f6OxVa5trJkAwMCq6nlu26faXLJxB/DaL/sOh9zyk0l6Tpb4wE9TCajrqkWEW4D7J546rQPdg==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by VI0PR03MB10476.eurprd03.prod.outlook.com (2603:10a6:800:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 16:19:49 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 16:19:48 +0000
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add tests for iter next method returning valid pointer
Date: Thu, 15 Aug 2024 17:16:56 +0100
Message-ID:
 <AM6PR03MB58481542FD4940701FE3161F99802@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <AM6PR03MB58489794C158C438B04FD0E599802@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB58489794C158C438B04FD0E599802@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [XUjugy1nO7nzCTAOSmsuARiPkbFTiEaB]
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240815161656.606502-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|VI0PR03MB10476:EE_
X-MS-Office365-Filtering-Correlation-Id: bb33ee2b-4f86-44af-401d-08dcbd461578
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|15080799003|8060799006|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	5qv22NZLFWhIqGjinGE848vhx1QnM39Wm8iJdQTYgLeFm0aMSzSq/hQlYOMM7y0CuVOzOO2FEVJONsLjB9xbTkueod9y1KDhnKHScO8/A1cWRJEELRriVqpmgjzg547ItP3DIBepXaxVZCuCJW/kla+oNVZ1crwOoQZdeI20vNN+3l82lkwaylpP7v0yoQUY3l5w7MphuRtHRDxSaSrNfP/YIpFXb4O63hE9nuxhtuNSaReT/0P1mw76zTliy+vNlFxTFSxGaGZ0i/Mn2wNHa1GzS/egzLPfNI6+jWRw17JZ/q3S5jSm0DgIQqdK5YheCwuDfF0L66kCfBGPr9VBtcslNnr5DTMFNwlpPBixhffFSt83pG7ya0qElsBqlF8Hm0pxf510FBHs2c+D3F97NNZrKgXf8dZGdwGJRvrXFKkUMeU8XBkYmPKHHH6hgOHrGvDGoMardSYhopBfZ1YCFvjSWmqh2n6znTHofWlYpP4VX5kkzBBBlYyi61Z5JK3agGmebeCxPsdSekygsHGZEsCUBJry+xoKnJiALOgd+2CLuoTKknN4Jsxd61N83/KiZrjsVrM2wEMk9ZXrpykAXcBs2Jx/62BTJWZrWIq2sz0KQPI/v7w+rk6drDVLFyph+T1r17p8539WzZBsSRhTKLjd1wh/gA/qSBdCziZYnznroiKnEi3nCTRBEFUF49zNFndg8C7OmShUnAE/K1+OUQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ynzHufqKVJWaIqw7lEeSO1SO3MS3HjNpV/9tsr7D5sJrQbpOXv+9HxpYNght?=
 =?us-ascii?Q?dCmnm+Eznvpv3uWcI0tKTVSjUJ8cbd/0bntCBMn9C4y/C9XPAg6NFGYD95Bi?=
 =?us-ascii?Q?gO9pBeDLU+ooeoBdkHplkibUpFVNi8qrWshV4RyIUJTUWVo/epB0C70CE9tS?=
 =?us-ascii?Q?pGwfXJvvdbfVXingql+EAdq8gOO6y/xxQuQywJ+CX5fT14nZMeUMr0ogkNio?=
 =?us-ascii?Q?7NncSScIAIJgPtH75GVHdStkk9j7DoEfSlp+guj0swu2N2BDR73r4zpTI8RV?=
 =?us-ascii?Q?Xh9kJjU8RMaQEMFxlKctzmXdOp0O1zSXjNpSNx2fcciXWUwQHM5SNF5To0As?=
 =?us-ascii?Q?NDj+11ccE7FbLBrdsQlM0r7dJRGI04LvIJdpjIqRf4w3NVxtv7tf8okib9F3?=
 =?us-ascii?Q?FRdfRE1LSjdLzTqNipL7YsI4w4ekFzeyV/8zsMejbjTxMH6EHgoLRbGj4BOJ?=
 =?us-ascii?Q?S31o32QNes5Tx9fXgmYmEHdOH7lAQJ44bnatW2wiXZYK3JDN+EqMu8F12V8u?=
 =?us-ascii?Q?UeAPBasdRxHTbpQnX9Pu37FBJFAOkKimitEJn1o47cayCfxBt4jJPPdBF8O6?=
 =?us-ascii?Q?js9+vHsWy9YNNjAFaUofRDHHNou7ia6EKrsZdW59RJxk+AS5O0nKL6+BDAw9?=
 =?us-ascii?Q?k+hej0SADbqBbBuYob1ALmrQR82LvuhRIavjaYNw3fbcA6nf9f3dSqosKpNe?=
 =?us-ascii?Q?O74sbP+H4ivwWZO4M2Ij+YCF3FJYTqzvFQdulbYp8jWxqHqUiJc5KMOdbJGN?=
 =?us-ascii?Q?Ls6TGGDfiFCt6eA2VuSJqMoS52t/218HVdF3HrJ+SritDjvwQJ7ZeLd0OTKM?=
 =?us-ascii?Q?CgmGWLunsAd4Cg5if9azfGhPbcz0c3JvvN12MjFGngCRcYc/onVOBv7UgIqu?=
 =?us-ascii?Q?mlQqOiYIv6kAAtonIq6o0Nq+NeCcEhij0/KRXaBFiwfc2u94cdkrzU4JKTJk?=
 =?us-ascii?Q?9h9sc/KHg9K9HFvZvr0LwroMnZaGrkJHAdA7vsfldTn/Pt4jnJl+PGAsFfhS?=
 =?us-ascii?Q?p3bk+m1D4iarayZMrp+UQu0ENPcIQvPXvQzMLqLgAQt2VMhZrxv7cXNVpuaT?=
 =?us-ascii?Q?IB5y9V/2JuY0NIS0e1+tRf5WYnohYL1B6d41ZReQvpbgDkqQUCIbvtF9Hlsb?=
 =?us-ascii?Q?N3GqvCOUpwUv4XVdV2keLeZUTNKZ3M7XpdzXPBsbpriq3QPbORwGxlV3hmPG?=
 =?us-ascii?Q?G4vhDjvC1GkTdiI3jxT8w+xUQam920zyJTftU4GxDOTWlrOk8FI8jWLy6eXs?=
 =?us-ascii?Q?oXKb4mzffHzDG2/cILWc?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb33ee2b-4f86-44af-401d-08dcbd461578
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 16:19:48.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10476

This patch adds two test cases for iter next method returning valid
pointer, which can also used as usage examples.

Currently iter next method should return valid pointer.

iter_next_trusted is the correct usage and test if iter next method
return valid pointer. bpf_iter_task_vma_next has KF_RET_NULL flag,
so the returned pointer may be NULL. We need to check if the pointer
is NULL before using it.

iter_next_trusted_or_null is the incorrect usage. There is no checking
before using the pointer, so it will be rejected by the verifier.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  5 ++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  2 +
 .../testing/selftests/bpf/prog_tests/iters.c  |  5 +-
 .../selftests/bpf/progs/iters_testmod.c       | 48 +++++++++++++++++++
 4 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_testmod.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index a80b0d2c6f38..810d8005211e 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -176,6 +176,10 @@ __bpf_kfunc void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr,
 {
 }
 
+__bpf_kfunc void bpf_kfunc_valid_pointer_test(struct vm_area_struct *ptr)
+{
+}
+
 __bpf_kfunc struct bpf_testmod_ctx *
 bpf_testmod_ctx_create(int *err)
 {
@@ -533,6 +537,7 @@ BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_kfunc_common_test)
 BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
+BTF_ID_FLAGS(func, bpf_kfunc_valid_pointer_test, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_create, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_testmod_ctx_release, KF_RELEASE)
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index e587a79f2239..8f122dc8a328 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -144,4 +144,6 @@ void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr, struct bpf_dynptr *ptr__nulla
 struct bpf_testmod_ctx *bpf_testmod_ctx_create(int *err) __ksym;
 void bpf_testmod_ctx_release(struct bpf_testmod_ctx *ctx) __ksym;
 
+void bpf_kfunc_valid_pointer_test(struct vm_area_struct *ptr) __ksym;
+
 #endif /* _BPF_TESTMOD_KFUNC_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
index 3c440370c1f0..89ff23c4a8bc 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -14,6 +14,7 @@
 #include "iters_state_safety.skel.h"
 #include "iters_looping.skel.h"
 #include "iters_num.skel.h"
+#include "iters_testmod.skel.h"
 #include "iters_testmod_seq.skel.h"
 #include "iters_task_vma.skel.h"
 #include "iters_task.skel.h"
@@ -297,8 +298,10 @@ void test_iters(void)
 	RUN_TESTS(iters);
 	RUN_TESTS(iters_css_task);
 
-	if (env.has_testmod)
+	if (env.has_testmod) {
+		RUN_TESTS(iters_testmod);
 		RUN_TESTS(iters_testmod_seq);
+	}
 
 	if (test__start_subtest("num"))
 		subtest_num_iters();
diff --git a/tools/testing/selftests/bpf/progs/iters_testmod.c b/tools/testing/selftests/bpf/progs/iters_testmod.c
new file mode 100644
index 000000000000..009b9f7ad45c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_testmod.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include "bpf_experimental.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("raw_tp/sys_enter")
+__success
+int iter_next_trusted(const void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma vma_it;
+	struct vm_area_struct *vma;
+
+	bpf_iter_task_vma_new(&vma_it, task, 0);
+
+	vma = bpf_iter_task_vma_next(&vma_it);
+
+	if (vma == NULL)
+		goto out;
+
+	bpf_kfunc_valid_pointer_test(vma);
+out:
+	bpf_iter_task_vma_destroy(&vma_it);
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int iter_next_trusted_or_null(const void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma vma_it;
+	struct vm_area_struct *vma;
+
+	bpf_iter_task_vma_new(&vma_it, task, 0);
+
+	vma = bpf_iter_task_vma_next(&vma_it);
+
+	bpf_kfunc_valid_pointer_test(vma);
+
+	bpf_iter_task_vma_destroy(&vma_it);
+	return 0;
+}
-- 
2.39.2


