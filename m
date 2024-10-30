Return-Path: <bpf+bounces-43459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7DE9B5878
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435E12869BC
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 00:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7448E11185;
	Wed, 30 Oct 2024 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="esxPko0r"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2020.outbound.protection.outlook.com [40.92.49.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A26264A;
	Wed, 30 Oct 2024 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.49.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247486; cv=fail; b=iAwZW1OZpAkaDIXnMX/ivtsJ1DcoCCYgjVTe4YH2krtWqE7HOXNrGjPU++Fnm0hGnJtliNjAcr10apG91BjxLYc6fPjx0mCpAFITvVGolbiccc0z7lK0Fy31ZsR1ucGZExQafMVgNYpx8ge/qBYo3pXwXBCEtdli1RLmxIIIJVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247486; c=relaxed/simple;
	bh=gZ4ZsfrXjLE/euxDXbRqSbrJN/oeswBzWeE0ZYDKq9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qN8AftBM7WS+012z6tE1wFVLVEJuMaWVt4CvzZ6dyeYnU3NSwHxf620Rs9S6IUnRh3/PdCoDwDDeuPBOa96zIl3p+R/ozKBwBp1PDxkn+anC93YwEakqwy7maq9W2mbToG+LNEQdKztIHKqZSD8mwjKty7jfQpa6+QQiZPbc6Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=esxPko0r; arc=fail smtp.client-ip=40.92.49.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJsKc+uVQ+NdOt+xBVfEgEmURg8fNbVGiiHaokv3/sMZB/nGPL+/unb0ZP1RndQVcxPnRvpD/rtrkMdQTnEkB+GsKEgUWQkIOneeYRq/UAMSb+tfhxDaBIjHaju2rrcFF5+PStd7+HyiorYhaTpFXJ6Pyzp9Ii7txEYBWoHFvIbIFlSlSCAwivD7ll6faG0K0VMjq7cvc2HfDDLPciB9dcwBc/0xhXUjnnrvd3Wd7ceQO4gJdJpr6KTv3zikRQ337gd0PFZMljyoogKBE+hT+XSHEqezFbobm4JJhMK60PwTQEdARzDAuG+HBKuhUmbtR3P1ixX7BSeQrbNjdP9bJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqMLYqY7WZmPsDuyp6cFamd6LLYvH1cd3WsR6pnyRM8=;
 b=X9pnpVo5XA+C3RPxD8es4VC+7nM3DIOZCHi3TL9x0D41QjpCTmYzm46gWu4ER0I6dGy695DdF2yie11h18TOhQXQG3jq9ebSAmkIRA6IYjXAaodNB41tdRk2JLJm0lVlJ4+H0UyEsDe4nqeaLa2x1S7qALMULNhaS7zNOk9/dvMmKbNW+v286+t3w1KjwcQpeN+1rcqdydHi+IUK/3uacpWHdKOuobF/O3EY1P555Fb6UdGFjPkBKxeQ6dQwaf7yidNi9I3xYiwS5DzU7Mu0B/TOk/vSxIOCudwPMedRQoXQ4PWHfZa15FOsF8FshYmqf3YykROlAN5pjNZuaUiHkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqMLYqY7WZmPsDuyp6cFamd6LLYvH1cd3WsR6pnyRM8=;
 b=esxPko0rNyAPSaEUKAl0FRkpx1zTDKcFEs+QdvDvlX7h4WgCYBbDQYDC6I9gzccshg3L3JKOtZla7IXQ1uVTIx2xd3C0HPuYxDZ3sjoDyB3kc2ZWPGflAco7LQuvUE7cTOo7F0/UIShZ++fmDuPbY2rqRTc05jAV7w8XYmQ4Rjt+R/1o0+EBu+7VoUi7hE2AleIbPG+ybZ0aBzVjfv4eAvVKEt5Et/UD9i2nFu7hDeJjKhZvuesDLNdG0rf/RN1Id730TbzYCWIK3avNpqdcr6gKMfch4/Bv7Mc+O2a+Z8iUcZDtixMVXnUKkJhJ2QjAAOHTG4u8K3429QIuQo+OcQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by DB4PR03MB10105.eurprd03.prod.outlook.com (2603:10a6:10:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 00:18:01 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 00:18:01 +0000
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
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Add tests for struct file related CRIB kfuncs
Date: Wed, 30 Oct 2024 00:14:57 +0000
Message-ID:
 <AM6PR03MB58487B04951BADA1C7CB6ADE99542@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5848098C1DF99C6C417B405D99542@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB5848098C1DF99C6C417B405D99542@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0238.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::11) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20241030001457.15593-4-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|DB4PR03MB10105:EE_
X-MS-Office365-Filtering-Correlation-Id: e28593f2-66e3-488a-9c45-08dcf87850a8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|461199028|8060799006|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rE13zP6L6sZws2d2GCHrna2V7LtIP3obH71GLAxBSCmUmIDlLk2IYX1TMZIk?=
 =?us-ascii?Q?aemIquGAuLT3a8FbMFo37s94Uhvkn/YJyQs8J12bbK348D71l4UixoC1vAlj?=
 =?us-ascii?Q?ClzdV8VWtLRqreDT8QY1jwe57Y3uZA74XqMHC1MG5aqg6ITR8Z0OmMyURKF8?=
 =?us-ascii?Q?/cKL9tBGJfUzncZjRsPeaqf3/xho6g3RnNSNM4dODPUrN/ecjHahxkRiwYPF?=
 =?us-ascii?Q?8V04fc4CONvM6cR/Sz9+R//hn2xMgHBBA2F0slc9IJdL5RyKMfx54hXILQri?=
 =?us-ascii?Q?Ril5ey+rr/a8T1M2ghbChLXP4SDCaYDxhMGJ8hEwKY0JoET0f687UPr8pWmj?=
 =?us-ascii?Q?0MI/Ge1whhcYI2e/4+L5HMcX5Q0f+ZVIgtfcwdRmxt+4hQ1ObFSdh9/e0xKL?=
 =?us-ascii?Q?3NaNts+SOX4KSgQt5A3bMnFM6Hq2d06PU/gNOJFLy5ORuir/18Xx8+UySmHG?=
 =?us-ascii?Q?0L7GcVm1+qj3vVRkMB4xxEwpQe9RuD07OG6c/Ddw7Jp4mZ+Mrm+zX8GkuZsR?=
 =?us-ascii?Q?zGw21sySSfTyLqwAUM4yg3DMklku6vEgr6dxcAooY3UeUGbWR1EJ0jWfHgeQ?=
 =?us-ascii?Q?UeC8hMsfgfTFc8UIbnBA5hL4mSnfguMVHzOHtLsQiQMoLe7QrL9GnCKk0bPf?=
 =?us-ascii?Q?zjjFrKi9vp1Vkj71gw3H1urVfY14kYO3GofOwxS8wEi83C4sjTbOFimaqWhw?=
 =?us-ascii?Q?MzA7SWBcSuMxyWJr2J9TpcnFd5N/OEbjIjmd5Y3oK2gW6IOtjLizDQ6XLRFD?=
 =?us-ascii?Q?rOF9x7HpWNSgCfTBpw308wv7zplN50W4C6IJT3aZHkzEYUUdnAcM69tJfWsI?=
 =?us-ascii?Q?A9S4b9QkqBASUHZkoHQ9nVaV98eUvXKqxR3d6KX3efyoqsqn1WtvgKOVG+BW?=
 =?us-ascii?Q?EEdRJ5mFdvQcRQ5vRm3jErb+09gK6y5cmjRTRiquuV+XzWuXbpcPxfvz5jg1?=
 =?us-ascii?Q?GC676pWb+fjb1ciGBfy1LfuNusjnT5Rw1OIjabj8NLu9DrDD3mGPFqAHgBFm?=
 =?us-ascii?Q?WX1Y0GlLaI+FzGTbCkKtIUIwEA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JXZ6VNGwG8QEpiZTh2HNp8/IHfnUA7cUG4kGMFe1SJO7hEoOi3zgeAEhlEw8?=
 =?us-ascii?Q?Os6ivvFStM8W/yReEXXvusg1jnTdbTZ85Nb6bG9vT1LXPcwuTxfV9xITcn3Z?=
 =?us-ascii?Q?JCdVdvMK1zkS/JtqC4M/y0tcY855iVf7FDkGqYsln5qYyRXwWXWDe2yU+gk3?=
 =?us-ascii?Q?XGSaOYUzYkSViRGBk1p2xGWMNDgljFJtXqo2O0aMMrakGxOzzY8b8Hu2Zbfv?=
 =?us-ascii?Q?Vr46SRWJMr88cmiPhwM/KmIc+o9d6i4yIo9NvZI8ejQKkvEySFiZ+f6X61jA?=
 =?us-ascii?Q?8awP8xZaCNTXt7ZqJmLT35hBwBkY8QcYtN+iKY7UVe/MjhHX14Sm0p6uVny2?=
 =?us-ascii?Q?HbsUy+cU2Zyi2auE/evaVLvJPMaJRcINqjKy/NBkwZ28As9MVXtZMseYredd?=
 =?us-ascii?Q?JEP2XNgji5yYr8rtD/VobG2W248alYis9k0m06DEwIdwSHxyiqoTtMfwLDGI?=
 =?us-ascii?Q?XuVsedO+2q7PBe3OECW6yIMgCAKlbs2XsWu77MAfI/ceuN4pYdq0X/EnmDs7?=
 =?us-ascii?Q?9aNW9uc1kSJyZHofRDkNCBU3f7xHPr+5FZuXHr0GInreMr63OZQuCj7FRFk3?=
 =?us-ascii?Q?+jz2eBzU5DE07BTo8qH/y35mbL5FUbPXS7+sQFpkj6bZOf+xaN6VjuxwvBIM?=
 =?us-ascii?Q?NryNHH6PX2lOOCs0/gqO3sd1bzOFc0LKfRvfNPehlWPhwl4H3C6pN7d4uALG?=
 =?us-ascii?Q?CDyP+TjpxJJIF86sbteVBvcZaE7dxF8tDLahjFvcyg8LPYw6Z4sTcQN2tNRo?=
 =?us-ascii?Q?dZkCwKekI6jMA/GzjSAQ5vZs8rmGATTk1Z9huGwHXX0p0qTt+50TaP5HDFsV?=
 =?us-ascii?Q?RwWj/3pq+PQCAWyQlNtT4/WWDxWxhB8zsfcOJQEIbZkBRrH01+ba/TZyUYDd?=
 =?us-ascii?Q?6MsxgKN7YvQHhpEq/BL0RRdRhBDM1dXZldMSJop6LySIu5ZcKicdIi9YCfQo?=
 =?us-ascii?Q?+VQWvFnbegddphItU55sa6YRGfRAVzrTTkrIwHf/JmB8g4bLJ+iGC0BCkeCT?=
 =?us-ascii?Q?1xV32jXJc0LWbHsJF1O5wpEv1H0U3hTXYw+FZY5f+V2ZCY7b213XP8OYS0i4?=
 =?us-ascii?Q?LwzWEO2ueo2qaQLJONUf0/VeesUaSKFCfSLiNsDuBqTFpLM8Gl8BzCsRpqby?=
 =?us-ascii?Q?iPuIvI/bVPl1iYtze2RLDSe6wKLmggc0TxOz88w7sYgzVLhf7xohyl26cUi0?=
 =?us-ascii?Q?CDuyxyQzwmwPgf8uwhaqi37Lg+s5a4F35Y2IR6eV5jsA8bL4VvAdsH/pezHr?=
 =?us-ascii?Q?xYxjVpILDG9N7i0Gay7u?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28593f2-66e3-488a-9c45-08dcf87850a8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 00:18:01.4801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB10105

This patch adds test cases for struct file related CRIB kfuncs.

The test case for bpf_fget_task() is written based on
files_test_process(), so there should only be 3 opened files,
corresponding to file descriptors 0, 1, 2.

bpf_get_file_ops_type() currently only returns FILE_OPS_UNKNOWN,
so no test cases are needed for now.

In addition, this patch adds failure test cases where bpf programs
cannot pass the verifier due to untrusted pointer arguments.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 tools/testing/selftests/bpf/prog_tests/crib.c |  1 +
 .../testing/selftests/bpf/progs/crib_common.h |  4 ++
 .../selftests/bpf/progs/crib_files_failure.c  | 22 +++++++++
 .../selftests/bpf/progs/crib_files_success.c  | 46 +++++++++++++++++++
 4 files changed, 73 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/crib.c b/tools/testing/selftests/bpf/prog_tests/crib.c
index 48c5156504ad..5ef887e43170 100644
--- a/tools/testing/selftests/bpf/prog_tests/crib.c
+++ b/tools/testing/selftests/bpf/prog_tests/crib.c
@@ -108,6 +108,7 @@ static void run_files_success_test(const char *prog_name)
 
 static const char * const files_success_tests[] = {
 	"test_bpf_iter_task_file",
+	"test_bpf_fget_task",
 };
 
 void test_crib(void)
diff --git a/tools/testing/selftests/bpf/progs/crib_common.h b/tools/testing/selftests/bpf/progs/crib_common.h
index 93b8f9b1bdf8..0bc77d1b02b2 100644
--- a/tools/testing/selftests/bpf/progs/crib_common.h
+++ b/tools/testing/selftests/bpf/progs/crib_common.h
@@ -18,4 +18,8 @@ extern struct file *bpf_iter_task_file_next(struct bpf_iter_task_file *it) __ksy
 extern int bpf_iter_task_file_get_fd(struct bpf_iter_task_file *it__iter) __ksym;
 extern void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it) __ksym;
 
+extern struct file *bpf_fget_task(struct task_struct *task, unsigned int fd) __ksym;
+extern unsigned int bpf_get_file_ops_type(struct file *file) __ksym;
+extern void bpf_put_file(struct file *file) __ksym;
+
 #endif /* __CRIB_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/crib_files_failure.c b/tools/testing/selftests/bpf/progs/crib_files_failure.c
index ebae01d87ff9..9360aad50c15 100644
--- a/tools/testing/selftests/bpf/progs/crib_files_failure.c
+++ b/tools/testing/selftests/bpf/progs/crib_files_failure.c
@@ -84,3 +84,25 @@ int bpf_iter_task_file_destroy_uninit_iter(void *ctx)
 
 	return 0;
 }
+
+SEC("syscall")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int bpf_fget_task_untrusted_file(void *ctx)
+{
+	struct task_struct *task = NULL;
+
+	bpf_fget_task(task, 1);
+
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int bpf_get_file_ops_type_untrusted_file(void *ctx)
+{
+	struct file *file = NULL;
+
+	bpf_get_file_ops_type(file);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/crib_files_success.c b/tools/testing/selftests/bpf/progs/crib_files_success.c
index 92ca7d9d44c3..8dddac6a7378 100644
--- a/tools/testing/selftests/bpf/progs/crib_files_success.c
+++ b/tools/testing/selftests/bpf/progs/crib_files_success.c
@@ -71,3 +71,49 @@ int test_bpf_iter_task_file(void *ctx)
 	bpf_task_release(task);
 	return 0;
 }
+
+SEC("syscall")
+int test_bpf_fget_task(void *ctx)
+{
+	struct task_struct *task;
+	struct file *file;
+
+	task = bpf_task_from_vpid(pid);
+	if (task == NULL) {
+		err = 1;
+		return 0;
+	}
+
+	file = bpf_fget_task(task, 0);
+	if (file == NULL) {
+		err = 2;
+		goto cleanup;
+	}
+
+	bpf_put_file(file);
+
+	file = bpf_fget_task(task, 1);
+	if (file == NULL) {
+		err = 3;
+		goto cleanup;
+	}
+
+	bpf_put_file(file);
+
+	file = bpf_fget_task(task, 2);
+	if (file == NULL) {
+		err = 4;
+		goto cleanup;
+	}
+
+	bpf_put_file(file);
+
+	file = bpf_fget_task(task, 3);
+	if (file != NULL) {
+		err = 5;
+		bpf_put_file(file);
+	}
+cleanup:
+	bpf_task_release(task);
+	return 0;
+}
-- 
2.39.5


