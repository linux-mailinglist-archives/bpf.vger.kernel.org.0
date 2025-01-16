Return-Path: <bpf+bounces-49092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7815A14298
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C1E3A1186
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 19:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0761522FAF8;
	Thu, 16 Jan 2025 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lkqeDlIh"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2022.outbound.protection.outlook.com [40.92.59.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEF214AD2B;
	Thu, 16 Jan 2025 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056866; cv=fail; b=oGMGGflStdqm9lwNfdWjkEk3RFj5t4qYuukRmoe6ZIoqHiLm3euyaZmbDycG6I4WxfCEdXGbwnWoz2DC7TENZyiYp+xsPPMGaP0T7sMTVVosSwd+xac3QrdS3f5Y4h4qYt7r7uireuCd4BOfp+eEIG8eUTGBOJfyUQuoUM3AiCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056866; c=relaxed/simple;
	bh=pdfJ4hp7/BViOvZ0UT650FbASfKhkxxC4RvGNh+Sl5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cmvkNmwqdJYK215O49z4Q/9CPZMN9nwezRKkZb8f74hsfkm4Cc2f9omeILU4RezcKaxTFA6NtY8o/u4jEcazwIk5Hc0izNCgYXhwc/5eaa0UN8xYTcudWR4L2pDE6/s5oZ74MYBKvixOxG8WClKHlknbTyM874YQcFTbf9OQ2RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lkqeDlIh; arc=fail smtp.client-ip=40.92.59.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fl5Zaga1ZT0VQNIFQh5WU3K4vA6g0sSg0u/aKbPIVzHlHIXxE+7bE26WI9mVXep/IyQUCQMbGc49TIca7fI8CPwBEGPI93iQny22kSID6Q59w+gbqTN6j44CxUWa0M4NvuUv22r6b1seC2Lfq4NnpZxBigIOpXw2WrtNcYM7DWE5NW+0jfsiAMM47R/RxdByKDSLnsgP2E52GbcBZySsZpmdRpd/oO7BErHTg+V2ZYk6t/92jQ3AEQx1JqYU7cHj67cEyFRgm12pz3RUgBf4lVcCjmgo6PzgVXII5/gg5tnXxyDhESzaP/wjw7PsUqCJWWZExCJqkqF2fvIJ4fnwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ue3aM1cua/YxafH6GzXivqhlWZXDVQpuBtzoAZ3xS7Y=;
 b=OwquLtosnbU+LfbgKBBOZ+OE+KZXMF3G+0zIUUMD65XdhTEdaRDhq19ccQRjdXURxwxo/5soDKMHimBHbxim5XnDAlJPJnf+Sb1pjN0vuWOWWjV4+ijdSSu7dS+JG7iMnAMBZ67kMSBo+4Uz/OX7pIZrgNj8w+CeSSknzuJP/MzO+c/Y1dRlYHdiePWXdrgWsKPVLrNt8eKfnXVYUChLsq5U5vNhSt2rTzA6PjfwZ9HDDVN5BQHR9PjloDvbIXCv+FuQN/itde4ZphMcFS91174jZhz+MWBYqUarUvYfae8tG0ESxSjIOWCRIH/YTu7GY/PfJvNdHYlyErjFJOUsig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ue3aM1cua/YxafH6GzXivqhlWZXDVQpuBtzoAZ3xS7Y=;
 b=lkqeDlIhhqh7Df1hqy2SNfz9c0DjdW4l9HRNjyyqdOUGLo8aY2cJoUeNXm4n44hXg7DUuCN8Fr+s7FG1wia0+wULiwFBIneoxAEqd7hrsCdwpXZIB0VQHqw0IPca8jkxjqxVxAr3DIabYWeHhUaCwXK0yn1tJiA/M4GOP0BAbi2tuBIWBxjQr9SB2rGhMEFldDZaWCh8exIe2yeMq+Qg77241NCcWgf4HD0R39Q9CSb+diSMNnm9eedm8oCROM3fVET4xNG0ZWemTGVIGuCULPl8BRKWXTD0dnmvbUFHiV0w3mwLUYpn8W7NlLIauSATRX8OMvFFBe4fUpMrYN2DZQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS8PR03MB7970.eurprd03.prod.outlook.com (2603:10a6:20b:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 19:47:41 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 19:47:41 +0000
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
	tj@kernel.org,
	void@manifault.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 7/7] sched_ext: Add proof-of-concept test case
Date: Thu, 16 Jan 2025 19:41:12 +0000
Message-ID:
 <AM6PR03MB50806B93D8187527AE4A9B7E991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0041.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::19) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250116194112.14824-7-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS8PR03MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ec5472-45a3-46ee-54c8-08dd3666a389
X-MS-Exchange-SLBlob-MailProps:
	Vs63Iqe4sQl3RqqletCEFdzMlpBSGXYPwmFenpr/y74wp7dRb+1jc991cfIdHMeeLHapMdZ7lqBuXELq0CtSjMKJlV0l5BgOtuFvwYEHAqcDLi5k8DHjNQrrowFJorJPts9mh2v+lDqh+vJsDjgVJ4V2UrCd6klyRn7sZ31HuQqci5m11BLzrgWpA8KXAQzV3lqequVah02kWP3QgHP9DkHLJf2rJt5ivcuAN2KTcMOZ8Zj3DllJcBRcHOnz4DLhGYBJg1hTSsRm2VzLoao4iE4VJ7z7/7vKXhfUUVFLVkhbLX4xwfMycyhzKFaWBgkDk191XroQPBImEd1xY+5MNOBoAJiYLwUGGf89vzleCmjRBq3X4BpLblHAqaRc9UjFx6gwGTEs1JXjeMpFrK9VTi2KLqy61fhpcqzbvjUuLXsjhIuI+BLACAYgjQ0SJG1ozHw93vOfmQ1t4UOaQjTPuTIE2a591dvbnicLOxd3M1Sywppkdu92Ah41oQ8IPM63fOHs81EVtl1Y+2GcWPCUAQ3AER5lXQIWLZYhbTQ3FGWB4O0jyzxRlhmBKYDPmW/9fbdE1DOywy77aw6Vb1Vh6cTw6CKNqYB0ZLFee1WHcOlvzS5ZNZt5xR/iF4ykBwjULMJWkEKGlEO9i585rFUIMXCCQ9ausSzeraHe6KsdnyteYhfeOuTo+yskKIwRX1fnepv1kJl4Xm7jWhEr63T0aG+4JpBJ70XKBb/j4RKnoZI=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|8060799006|5072599009|461199028|19110799003|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kkcodqdgtb/Jx6ifxV+9i1Tg4IShfPzCjy3MfUj1mK4vK1orSg0cdpX9ShTI?=
 =?us-ascii?Q?KBYbEWNx7XIOokwylwI638NICDTDz4NxF4or/xM5MDA3en3JgkseoTIdaVto?=
 =?us-ascii?Q?gfchS3lr4sT213ptTHwbXuCj5RrMM8h+/D4zRZXBa1LPQX1MWigH89jSVaEc?=
 =?us-ascii?Q?8W736sOPeuYuvImJnbxjsfDX064NQJMM5EsccgKL4yXMmFNHo/CRUIqOiPI7?=
 =?us-ascii?Q?LmfQJzPA3nDZh9u9eL/08cg/PQlMvdT6hEmL45pniRN6xxxhhukJkd5tCBzc?=
 =?us-ascii?Q?FNXvMrzf3iHVDQbWIhQ8abbcbSe8HKl7JwHqCUNRjcL0si3aqEEWFFvzOBqZ?=
 =?us-ascii?Q?5hY4LyKN9ucDh1rcZAZRaOX71N3xPDZxxxypNQJ1/1NqJc7r4e4Gc6lpCgu9?=
 =?us-ascii?Q?fu/26Seg3FFsJ2k4ET1D7a+tAD3HTlsuEdnGvRBV6i5eQPOufClKhqXH9DRm?=
 =?us-ascii?Q?ypWssCQXCaIQ04UoFy2JlxbANSgbRWI4nQu7nLMpJZrty7vsBkcVv+7jvAqu?=
 =?us-ascii?Q?sgvVndF77ug6+X26IHyVpWfk6nojLGchsuokBnk7nPBJcTCpQeyvLX5Sl4cq?=
 =?us-ascii?Q?06JejD9bapxyM3Ta78PF6UTM20HRJmKdYmDQMN3NjtlVDKbVLybtxtELzMgU?=
 =?us-ascii?Q?ChYp38f14JdHYNXtixwQCamiviKSlETFzh9d9Z7Lxl3ofiUdna9ki9X2JWnn?=
 =?us-ascii?Q?v2JdY395K87MYlsLYgB2mvklDXjIktu7VO6lvlY1UOJwbm5dGSycYb1vKLZO?=
 =?us-ascii?Q?uaklN8A7pyABxUnlEDEe7aFPMTpSI1ioFL2af85NpTp40IuXMudlzCLDzg7b?=
 =?us-ascii?Q?Gf35o1CHe8a6PU6htf5Zgm+Iu359WAUr34ysu3uBnooZJzk9rKVQrOF2umvX?=
 =?us-ascii?Q?jCz/SAuqM+dDNfGrzsLGhStcWllvxJOASvXfS+ITofOF5CDbRf+B6HHHcd2M?=
 =?us-ascii?Q?8VsTz0srLB3qtq1WvTC0+L+Q66txmer69ZRooQrBl0Qxh9AdsJvpQPWEJVTh?=
 =?us-ascii?Q?XkpFXrKo9QHQwodZlYjSXQyiIeI+Wp88CZKSJyNJ9hbmli5yNHgL2omaQnly?=
 =?us-ascii?Q?K/r1xVFKkPuPTIuG5sWB19qan+uGHw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WeFL9iVV0i3zZM7UYAbA7bx5Q0pg2QYavdoUsFG7U2O8xjUybBITvxBLLVVX?=
 =?us-ascii?Q?tGYYFmksw8kvLRye8ziIG5jezKP6xr4LUOWrkUzK/o7+Tg6q/ZEgkXW/ZPYp?=
 =?us-ascii?Q?BHgN7gpraCjGOhGmwvYODBgxdjVb/w38CbqC0hCfPhNJSsLy66YGUowGFJNy?=
 =?us-ascii?Q?kpz3y6wghcdS3NGwzSwulMfu9LVxFIIsgBv93ddXrOonIB98peETtMpgir4l?=
 =?us-ascii?Q?eXrhVo+SxzYFJBbilGUdOkbjlvYe6lcq4PEinihXtKPk9gqoqdQq3uDF0wM7?=
 =?us-ascii?Q?4q4/Wie2aWalmpZBGISBrDOOm7M1mh/LPxzqdOiySmSd3eqbi2le9CbIIkVH?=
 =?us-ascii?Q?DbxmAN/J8VnI8lsYDgoi11rwnyfmYqzuYHlPw3bb7PK3eYVh5TqOlX6ZN+Ij?=
 =?us-ascii?Q?gTE7dcSnZ+Jgs9jOvNMnVVuM3a3PFdH/dRYcZSdlxbdNsLdOf6K3gIF9u/eB?=
 =?us-ascii?Q?MH/rThPGBHb1H4c35ZC7VCdwmSqFfl6yVbow921vo9LoS78MCobbIIlg3Fto?=
 =?us-ascii?Q?PZ/7nu43HySihlwyf2iZb45fOn3kKCG5TQD11x6bZDdZmSm/+IUptBh63ANN?=
 =?us-ascii?Q?QlPeR51G74I2VQcOAlYDhB4oo5KvlaTM7yjVIO5WmzF/09GGhoTCvvzWKeWo?=
 =?us-ascii?Q?QP03x+08LOsQKHhZJq7qdtONMUp1hdPihK1x5ebtLeh3jmpOCWPikf6TotQd?=
 =?us-ascii?Q?6wjuzGdO+Z9smdbiiim2Q5G9EW+XKQqf2EbmAJlfRg8PVDmvqgHO8DMpwbyz?=
 =?us-ascii?Q?O3L5RMEiVLZ4fVbgm+ShA+IItgMiqLQamxLS3D6eh5qbWPQsB572MsLb2VLS?=
 =?us-ascii?Q?nF1jwU6GI/65md43jPH0KP613g4VHRUGqFhKB0wHYCEhJ3GgJNkwRHRSQFRR?=
 =?us-ascii?Q?+WNykNGK59z6o8/koXuTrgAr/lBcYDald+MbE9N/q1MDKuiLP09iYg+ksBKl?=
 =?us-ascii?Q?Q72lKZ3cZEy2AHwl9krxrwgFRO6OMhb5lvLdvu+XUsLr6f79Yk38mOuxhhFc?=
 =?us-ascii?Q?WnSi8Wmtz736fn5TGrsKpZzuhdlyezEhUjF+qzrTJjRluXmmRslEgw9aZWLw?=
 =?us-ascii?Q?A0ZoIC4xfOgO+pu7J9JN7Mqi8YcOwuUn7e8+g/iUlVtk3R9MJsKDQdHdgwuc?=
 =?us-ascii?Q?EWFS67ynhsViE3O9H1ItDldAJylORqFG8NPlFpovj9K72PRm+y50VUYwhxy9?=
 =?us-ascii?Q?VDVdtY4n+mwyslblXI4VKgnD3nIAmao35uElX/s2Omhwf+/arzUpIrPKAOrG?=
 =?us-ascii?Q?aBPXmctazF1h1ZSygyBx?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ec5472-45a3-46ee-54c8-08dd3666a389
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 19:47:41.7296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7970

This patch adds a proof-of-concept test case scx_simple_cap_test, which
is based on scx_simple.

Add scx_bpf_dsq_move_to_local to enqueue, which will be rejected by
the verifier.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 tools/sched_ext/Makefile                  |   2 +-
 tools/sched_ext/scx_simple_cap_test.bpf.c | 159 ++++++++++++++++++++++
 tools/sched_ext/scx_simple_cap_test.c     | 107 +++++++++++++++
 3 files changed, 267 insertions(+), 1 deletion(-)
 create mode 100644 tools/sched_ext/scx_simple_cap_test.bpf.c
 create mode 100644 tools/sched_ext/scx_simple_cap_test.c

diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index ca3815e572d8..0e87aa77594b 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -176,7 +176,7 @@ $(INCLUDE_DIR)/%.bpf.skel.h: $(SCXOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BP
 
 SCX_COMMON_DEPS := include/scx/common.h include/scx/user_exit_info.h | $(BINDIR)
 
-c-sched-targets = scx_simple scx_qmap scx_central scx_flatcg
+c-sched-targets = scx_simple scx_qmap scx_central scx_flatcg scx_simple_cap_test
 
 $(addprefix $(BINDIR)/,$(c-sched-targets)): \
 	$(BINDIR)/%: \
diff --git a/tools/sched_ext/scx_simple_cap_test.bpf.c b/tools/sched_ext/scx_simple_cap_test.bpf.c
new file mode 100644
index 000000000000..6bcf4dcbfcb4
--- /dev/null
+++ b/tools/sched_ext/scx_simple_cap_test.bpf.c
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A simple scheduler.
+ *
+ * By default, it operates as a simple global weighted vtime scheduler and can
+ * be switched to FIFO scheduling. It also demonstrates the following niceties.
+ *
+ * - Statistics tracking how many tasks are queued to local and global dsq's.
+ * - Termination notification for userspace.
+ *
+ * While very simple, this scheduler should work reasonably well on CPUs with a
+ * uniform L3 cache topology. While preemption is not implemented, the fact that
+ * the scheduling queue is shared across all CPUs means that whatever is at the
+ * front of the queue is likely to be executed fairly quickly given enough
+ * number of CPUs. The FIFO scheduling mode may be beneficial to some workloads
+ * but comes with the usual problems with FIFO scheduling where saturating
+ * threads can easily drown out interactive ones.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+const volatile bool fifo_sched;
+
+static u64 vtime_now;
+UEI_DEFINE(uei);
+
+/*
+ * Built-in DSQs such as SCX_DSQ_GLOBAL cannot be used as priority queues
+ * (meaning, cannot be dispatched to with scx_bpf_dsq_insert_vtime()). We
+ * therefore create a separate DSQ with ID 0 that we dispatch to and consume
+ * from. If scx_simple only supported global FIFO scheduling, then we could just
+ * use SCX_DSQ_GLOBAL.
+ */
+#define SHARED_DSQ 0
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(u32));
+	__uint(value_size, sizeof(u64));
+	__uint(max_entries, 2);			/* [local, global] */
+} stats SEC(".maps");
+
+static void stat_inc(u32 idx)
+{
+	u64 *cnt_p = bpf_map_lookup_elem(&stats, &idx);
+	if (cnt_p)
+		(*cnt_p)++;
+}
+
+static inline bool vtime_before(u64 a, u64 b)
+{
+	return (s64)(a - b) < 0;
+}
+
+s32 BPF_STRUCT_OPS(simple_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake_flags)
+{
+	bool is_idle = false;
+	s32 cpu;
+
+	cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &is_idle);
+	if (is_idle) {
+		stat_inc(0);	/* count local queueing */
+		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+	}
+
+	return cpu;
+}
+
+void BPF_STRUCT_OPS(simple_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	stat_inc(1);	/* count global queueing */
+
+	/* bpf capabilities test! */
+	scx_bpf_dsq_move_to_local(SHARED_DSQ);
+
+	if (fifo_sched) {
+		scx_bpf_dsq_insert(p, SHARED_DSQ, SCX_SLICE_DFL, enq_flags);
+	} else {
+		u64 vtime = p->scx.dsq_vtime;
+
+		/*
+		 * Limit the amount of budget that an idling task can accumulate
+		 * to one slice.
+		 */
+		if (vtime_before(vtime, vtime_now - SCX_SLICE_DFL))
+			vtime = vtime_now - SCX_SLICE_DFL;
+
+		scx_bpf_dsq_insert_vtime(p, SHARED_DSQ, SCX_SLICE_DFL, vtime,
+					 enq_flags);
+	}
+}
+
+void BPF_STRUCT_OPS(simple_dispatch, s32 cpu, struct task_struct *prev)
+{
+	scx_bpf_dsq_move_to_local(SHARED_DSQ);
+}
+
+void BPF_STRUCT_OPS(simple_running, struct task_struct *p)
+{
+	if (fifo_sched)
+		return;
+
+	/*
+	 * Global vtime always progresses forward as tasks start executing. The
+	 * test and update can be performed concurrently from multiple CPUs and
+	 * thus racy. Any error should be contained and temporary. Let's just
+	 * live with it.
+	 */
+	if (vtime_before(vtime_now, p->scx.dsq_vtime))
+		vtime_now = p->scx.dsq_vtime;
+}
+
+void BPF_STRUCT_OPS(simple_stopping, struct task_struct *p, bool runnable)
+{
+	if (fifo_sched)
+		return;
+
+	/*
+	 * Scale the execution time by the inverse of the weight and charge.
+	 *
+	 * Note that the default yield implementation yields by setting
+	 * @p->scx.slice to zero and the following would treat the yielding task
+	 * as if it has consumed all its slice. If this penalizes yielding tasks
+	 * too much, determine the execution time by taking explicit timestamps
+	 * instead of depending on @p->scx.slice.
+	 */
+	p->scx.dsq_vtime += (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+}
+
+void BPF_STRUCT_OPS(simple_enable, struct task_struct *p)
+{
+	p->scx.dsq_vtime = vtime_now;
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(simple_init)
+{
+	return scx_bpf_create_dsq(SHARED_DSQ, -1);
+}
+
+void BPF_STRUCT_OPS(simple_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SCX_OPS_DEFINE(simple_ops,
+	       .select_cpu		= (void *)simple_select_cpu,
+	       .enqueue			= (void *)simple_enqueue,
+	       .dispatch		= (void *)simple_dispatch,
+	       .running			= (void *)simple_running,
+	       .stopping		= (void *)simple_stopping,
+	       .enable			= (void *)simple_enable,
+	       .init			= (void *)simple_init,
+	       .exit			= (void *)simple_exit,
+	       .name			= "simple");
diff --git a/tools/sched_ext/scx_simple_cap_test.c b/tools/sched_ext/scx_simple_cap_test.c
new file mode 100644
index 000000000000..c4a0a5b1e0cf
--- /dev/null
+++ b/tools/sched_ext/scx_simple_cap_test.c
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <libgen.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include "scx_simple_cap_test.bpf.skel.h"
+
+const char help_fmt[] =
+"A simple sched_ext scheduler.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s [-f] [-v]\n"
+"\n"
+"  -f            Use FIFO scheduling instead of weighted vtime scheduling\n"
+"  -v            Print libbpf debug messages\n"
+"  -h            Display this help and exit\n";
+
+static bool verbose;
+static volatile int exit_req;
+
+static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
+{
+	if (level == LIBBPF_DEBUG && !verbose)
+		return 0;
+	return vfprintf(stderr, format, args);
+}
+
+static void sigint_handler(int simple)
+{
+	exit_req = 1;
+}
+
+static void read_stats(struct scx_simple_cap_test *skel, __u64 *stats)
+{
+	int nr_cpus = libbpf_num_possible_cpus();
+	__u64 cnts[2][nr_cpus];
+	__u32 idx;
+
+	memset(stats, 0, sizeof(stats[0]) * 2);
+
+	for (idx = 0; idx < 2; idx++) {
+		int ret, cpu;
+
+		ret = bpf_map_lookup_elem(bpf_map__fd(skel->maps.stats),
+					  &idx, cnts[idx]);
+		if (ret < 0)
+			continue;
+		for (cpu = 0; cpu < nr_cpus; cpu++)
+			stats[idx] += cnts[idx][cpu];
+	}
+}
+
+int main(int argc, char **argv)
+{
+	struct scx_simple_cap_test *skel;
+	struct bpf_link *link;
+	__u32 opt;
+	__u64 ecode;
+
+	libbpf_set_print(libbpf_print_fn);
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+restart:
+	skel = SCX_OPS_OPEN(simple_ops, scx_simple_cap_test);
+
+	while ((opt = getopt(argc, argv, "fvh")) != -1) {
+		switch (opt) {
+		case 'f':
+			skel->rodata->fifo_sched = true;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	SCX_OPS_LOAD(skel, simple_ops, scx_simple_cap_test, uei);
+	link = SCX_OPS_ATTACH(skel, simple_ops, scx_simple_cap_test);
+
+	while (!exit_req && !UEI_EXITED(skel, uei)) {
+		__u64 stats[2];
+
+		read_stats(skel, stats);
+		printf("local=%llu global=%llu\n", stats[0], stats[1]);
+		fflush(stdout);
+		sleep(1);
+	}
+
+	bpf_link__destroy(link);
+	ecode = UEI_REPORT(skel, uei);
+	scx_simple_cap_test__destroy(skel);
+
+	if (UEI_ECODE_RESTART(ecode))
+		goto restart;
+	return 0;
+}
-- 
2.39.5


