Return-Path: <bpf+bounces-43441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1439B55F0
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 23:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F014E2830EA
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 22:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBE820B216;
	Tue, 29 Oct 2024 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Kom1IbAN"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03olkn2092.outbound.protection.outlook.com [40.92.57.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA9520B1E1;
	Tue, 29 Oct 2024 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.57.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241883; cv=fail; b=kuuTwzDVQJqKKCcOP2Mb1cRxYj89e5ZblW2X9ROJK6Hc6Lrfem7f7FZIOXAdGIk2Cex6lvKr57DXMzJd5y1vl/LbOcCUwCvTNhzJaWdEaLx1qprJqj3hkLnmhijXhByzmjkndHegoZSSxaVAvBM/hsR9uO3TsX+AV5VEC2BFsMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241883; c=relaxed/simple;
	bh=vSGbKIF2sRp0vn+4IiqEk+mTnGBFk1oiOkzE23fOWyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ha3je6xJBuRUZTeAyi0Ul7IRiMoxjGDygbP8Dez89PIu83b4yBKuKr/T9aBY4/BPDKATHvn6pukEew8LNuroJF8AK9kB3IMrB+VM8LSwqgl5KShbONv10Suqfpz7s7zftTtdNMR0n/JD9CzvJ/LW44a+nyrz8cbPyDhWbTvjhLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Kom1IbAN; arc=fail smtp.client-ip=40.92.57.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbWU5PbV/yMusd9LK3egT3taYZquxTkH2gWJATh4pRlq4yGpE7BByDEFUe7H8Q/8A778wGf2jZr/7DFJORGNbL/1S31sTDSPGV3UitK49gUMnhJxBU1rHCWuyE82qnfpAsCs0Zo+eQ8sZWZquBEk+0QaIJM8txw8sXEVRAoH/f8626eQ8AFGxWbfKsLKCSCg7vzhQ6+Cl5d2MVhSgG70fJGNg/PzOunmth5oVX8swCoYu4tnQRwESnqT7+n1GDP099gYLkmzbMronCqYtZ8CNkYu293zXTshfYFCAkrbu77DuCuzPYL3wfwJKSboOEJo8q5aMydaCSKNemYVubFSdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8tUpDDVleEdlfs21asoU69Z0Pd+WVxTF9CVlBoq5E8=;
 b=GOZcVPuWrmk26nPuGtFe0CdKMMoVyN261ZuojvSMuO7TjoIlCv/EVwy00NPvb89nCfEZg+oGvfEL+laY/L4dBD6UU8q3wmuSYxXs9gBbwZS/LCVmKLTM+B0XuNlYmziGwA34tw79nz512Dm+p/z5LHN0PnCvrN+UV23K+fsjQRAFayST9jfu5com1/5188O0b/4ChFRm5nxZpxMcinXmo/w+k7V48JypYSrsOeOoHMNKoM9/eNnLrYK7bOEha5W3yAEE4utXkF8x/QNtPYQLpbF5dj55tkwV7NIOEocMK/j3sk4g7PFd6GI7TFc5Hkcj3Yb1cLGVZBAoqPP4PEQ8aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8tUpDDVleEdlfs21asoU69Z0Pd+WVxTF9CVlBoq5E8=;
 b=Kom1IbANPdMFdmwFUo3A8SvTXuMx0L2s0BwTZMvHDwGQFfm53EzRr76L1yP89ZpDvTks9jT+Ly41fj0oYEdDvlUb+Pd6WRYG+ARSxBXLRRNSG489WATomfFT/QLg1SFKVy+Qc6I9O9tEHemadR4OY+eocs30fYNKbYUIiIF/WXgCglvWgVqwusABkkKEbDklvy9fduUpLVdHHORFzqN8GI7KBdjnKhpKuboqzj1q02qpbQ5EjQGWpSQxcUDGzInIgocICn61ouF9VooKABhwBBDrGgQzZi6aqnGfAjCCcv7uXS6KX20TdbhMznjJcs9LyDegkNX6fgBFvD6U/rTpTQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AM0PR03MB6130.eurprd03.prod.outlook.com (2603:10a6:20b:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 22:44:38 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 22:44:38 +0000
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
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add tests for struct file related CRIB kfuncs.
Date: Tue, 29 Oct 2024 22:39:43 +0000
Message-ID:
 <AM6PR03MB584885F310F20CF130CB7194994B2@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB584801332A1D31C21D23CC19994B2@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB584801332A1D31C21D23CC19994B2@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0476.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::13) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20241029223943.119979-4-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AM0PR03MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5878f6-4a63-481d-b6b9-08dcf86b44e6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|5072599009|15080799006|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lY/6nX5xg5lObs9b/FaHoNUQUeJmru/BpSGYsrtCWraqa5KlXNCFnRu2QWcV?=
 =?us-ascii?Q?gj/XwvOL4nmTJ5pMOYRxQzvy1GeQbiEZqCHvjJy2EGh/ETV4aYUU21b0nhOt?=
 =?us-ascii?Q?woVU5Myri7u9aAwMhon9pncqw9PMp/13/F58eY6VgU3lF8jPNuEzXK8Z4XbC?=
 =?us-ascii?Q?fkYC8UWDF8nBwj+YyyUjd1U+n5xOKADxWcbwDsNZiP1XQx9mMyau2cPHGBee?=
 =?us-ascii?Q?bVCqCaUhq5EZ7NmeRS74EpiuCzBBtoCknutk87R+iPCPOnAY54UIeQVWFB33?=
 =?us-ascii?Q?JDLpmShhS5K8vMgB6tYRUyxYlJm1OZETbA/dIjnDmKbJORiLjbJOXZ8LC3S6?=
 =?us-ascii?Q?rwQjlYyNjc7qM5f5HUq5sUyFsn2o5TVMEBajMQUkgQPbDCZCMhL5cA/uiNzn?=
 =?us-ascii?Q?FZhQaAmPeKWhzNEzZJhSB5Qfsr2Kk1Yiqr9vejr73tkXmnQAULcNc/dRw8Ba?=
 =?us-ascii?Q?ncUcE9mxfQ1juXhNqr+n0VfN9MWdm+JhNReW/wid42jvZewxP+m6fbiul2GT?=
 =?us-ascii?Q?eEBhpPkTKfOJBUUSLwVtDJV+P4BzbAj1GcfJqz2+1LDZSj5mdtic8SRHYT8C?=
 =?us-ascii?Q?JSgWxTZ69TqRq+ehxVx/Y/VraZff4HbDRAs0a0UK6gOqJ5cObSBXuRAXVI6a?=
 =?us-ascii?Q?+VEKttFLdBbYnSNkgZ1uKvZiWI4u5mqrfqCkCJ/Rz1YpraUHrIoKqxJXQC4m?=
 =?us-ascii?Q?ZR2FKtPOux6eH1PDTyaxkK45HNJUC7TB8KNPQFInKOPZfeUQ/cWoFfSSEMp0?=
 =?us-ascii?Q?NunZwX2LnWbiiJ/A9eVy6tg4BTM4HRlDBdV6YCSaBjgFTc8dvO7NYYxFs6Ti?=
 =?us-ascii?Q?XA63o8si8wtH+iQTtNsqmFHCYqwxxHOJ6En8ta0wct3bsv8rOSJ7nc862gV3?=
 =?us-ascii?Q?mj4vshmuu8LDdDqgCd0ouEjqxpmPvzd3GE2PtzB3BNtvolB2W046HRHmBiej?=
 =?us-ascii?Q?u0hxHe0Z85RZjUCP8VhnQxNcyZGLqAZM12zRvAKHlDi5grsRVCp4QauGCPwE?=
 =?us-ascii?Q?tCc0Kb+VVNomJSMrFfZ9f44lTw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y5rBQ/Cjmke8LtGgnwUguD4yAK/g1NaGOshAP+hpUjttdyQuiJogF/W3ltmo?=
 =?us-ascii?Q?5I3qGyIMcLMaF1TwS96FnRFSBmCHN0DuoupskMGhEh6nGqpdB/myTmkpr0L9?=
 =?us-ascii?Q?JcOsV/o1OZZLJCQO/Z06zXnYonCPjCVThWce4jELZxaTQfNeCTXiPWz9DZx7?=
 =?us-ascii?Q?cpB04x4kDAZas+NqmQ74FQT7enxoHOSusJSZtE1S6k7SfOD38gPrXfHozHLb?=
 =?us-ascii?Q?762zA/2H0T9xnEICd9vcrRwuf3GsZOBMgqey96+29JzZD7m/uz3H8W4ca3VN?=
 =?us-ascii?Q?sF7+lSwq2PyPJxG+jHDQfz71aDapH7r2DRnIOY9oiQrnXjoJfieCLM2qBEJj?=
 =?us-ascii?Q?jRuy7j0h7PB/1K42vtYaUgGGNfBVgVm9gzHI+/4wNWP/MFyWzuBkWYh01134?=
 =?us-ascii?Q?QbdDHR1mSsdtM3GPyxlU4szn717MG5FcKbhEsRhOwMrHM3gT84FevmE3/9WN?=
 =?us-ascii?Q?femnvqIlPCctbJBO+ByMtUvBIuIBzRDrZBxuYL2ltkddojJkI+xDSxKrtJwg?=
 =?us-ascii?Q?CZQFueSBwpF6fXCO3ZF4Ntd1P+ao0gHo2hVdvN91B0rScS6Oy0V2NsUo5RuA?=
 =?us-ascii?Q?S6XSrL8dQwRtsGnBnDSST7jLcIg/jxiYtfcq8oeHc5QtR+joU1CXODlmHd/G?=
 =?us-ascii?Q?ynsYHv1QQla6B2cYG/wDU8xqLxSb8C+J0dpIJbcB7edUTqlQp1+mdkEr9xo5?=
 =?us-ascii?Q?IgQ31jmnOMqZRTka4JeU3iud2ZsW/kEDen4XFMl1BPYiv98eZjYMuroCNfih?=
 =?us-ascii?Q?ov0SWkmv5DAziE+e/q6U9RQ6WoMCl+8qxdLq89SRUq6HBy4FYB7ZKKVYLJAC?=
 =?us-ascii?Q?RuY7R+TguEtHfg0sLVBjY+nFerROpico1GOLHHccFeUGUukddeKBkHuzQCMx?=
 =?us-ascii?Q?7ynsY4QGyVa7u/3e9dnE1NwvBakxFizQp2Li2/r/EHkX41VK31X6oDbq5zY5?=
 =?us-ascii?Q?d9KZhW3e5K4MjECXQfN2dA4Cb175MLbStQKzh7kOOZlDde+4pBb9COQYHRyz?=
 =?us-ascii?Q?aiA8d/QoGhx+dF/QMRWriULfZxYsndWeTWTUryXJlsVBk0mT6eiP0vE7+6Zf?=
 =?us-ascii?Q?4zANocB2JwR4iC25ouTzXv4MZSKkutdEKVdCJSrMJsdbk2jviAW9Fre8oKuM?=
 =?us-ascii?Q?1eyKiaHHB/Q0eXA+GueHLmGm4dlYLKwr1OIvlqG1ZtahikW1Qg69hLRuw2qO?=
 =?us-ascii?Q?OOI2yOgAbVvTujB61idQhu3lVDwWdD1mtKEtzr2g6RU7Qy12jTVSo2z5q911?=
 =?us-ascii?Q?CA5e9/NRZVq87bLatxdK?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5878f6-4a63-481d-b6b9-08dcf86b44e6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 22:44:38.3008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6130

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
index 93b8f9b1bdf8..7b6f72ca6a6f 100644
--- a/tools/testing/selftests/bpf/progs/crib_common.h
+++ b/tools/testing/selftests/bpf/progs/crib_common.h
@@ -18,4 +18,8 @@ extern struct file *bpf_iter_task_file_next(struct bpf_iter_task_file *it) __ksy
 extern int bpf_iter_task_file_get_fd(struct bpf_iter_task_file *it__iter) __ksym;
 extern void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it) __ksym;
 
+extern struct file *bpf_fget_task(struct task_struct *task, int fd) __ksym;
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


