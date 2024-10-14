Return-Path: <bpf+bounces-41849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B95399C59E
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 11:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F42F1C21832
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 09:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA2915667B;
	Mon, 14 Oct 2024 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="I4GtDD6g"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2086.outbound.protection.outlook.com [40.92.89.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A5E14D428;
	Mon, 14 Oct 2024 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898044; cv=fail; b=W9EznRKMS+g61OWMOI3yK8hcldFGlg3EcpRPhIaRFfiI3yEaZRa1dKpL+Sm8llidpEThYRreT56VbkvowdMl/vgWjTjxHWva4o+/ikxhrbxE6ABkEN05hRresuwDKPNI035Muh/KyilAzmaQq05dvsanKqFpjFfqb20BGThCFE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898044; c=relaxed/simple;
	bh=dDEQw/DoFpjIJd6isXOsP+OEkdAkWaVzlNrDBWs6VnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZrGnEHjy/CasemifhlG7+1KVJF4GB65nOK9WJGxvtGYW4OEt9ZzKS2HI9IqLoE1iqliQWFm3wvulCBgCNc7XC3MZiBfY8V9mS5BZrb7qWAI947b7rt+e3GIxSf8Tdli7mchYAiwTOUWDY5ffzZ5UuQuYsdwnJq4pZzgGtAF3zZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=I4GtDD6g; arc=fail smtp.client-ip=40.92.89.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0UyM/2sVt545MzDdhgh4MzJxkGjIIlox6wEFrvzY/1oruZWiuE4hzd3tppjtKi14XnZ01KEtnlr85+sYAo+cOMosWiCOiYQp0A6Zs5YQ14qNVr9XNYYANUgO+ggY1vEBJ6PNS7TfGyH6ZUNb5Ki8O3uAZdoSz13omxPaaWu7pkMKl8T41HVj5SBkkL9TDfldDROd7XEoM0Q1OFCX/gHcDbeSOgxQvX1AZ7yOWMyUBJ5DEXpd/bcQDjYX/7rLE6rUkHEStCLJxaLN5GgaF6aZrCZKB4xS4asi1rfs5qeIT0psNK5IOqbCXRzAuL9/MLgUjr1ncZDWlI88cH0kzq3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqBK9SQsNWOBtMIult+DaR/J5AP3PER2JbTGX217M3c=;
 b=r7XD7H+ZlGNDO4N/wtUw8Iuspy3ASkw4t6z/dfmj4oHQyqkMeaYx4mvyU1+N7rtvklsCkniWdf8oSdh5AMuVIBNXyNrYt2LUMMUpViWdoSQpIzIr7/c2LSYl+WaE+qe7f64KEgZLOfbJa0R4MzgjE2P1bJWOn4ePIVtXN2dDSqcGVBwd0FQnzVOTNjvCVPhPYnlYa024KNqVO6a08jYe2lBIRstUggvglFj/qmqom2r3dj/g2nuARZiqirwfJB0+HShlAgP8eVvs7bNX2qYCsng4vX1RuLQqrsxM3Vr8bj5H1xHo1trQo/v8EIAiMKB/Q6TG3VQdOQobabY2RqVWJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqBK9SQsNWOBtMIult+DaR/J5AP3PER2JbTGX217M3c=;
 b=I4GtDD6gE1Qv3nPPOS4KHSoPKz1nQE2CWV6JcSs9VUdTZlSQv5l/ynIV5QQ6/B5H7R6Uf3hHTB9UYYxqEjAaTVgQPsQA8nC5AkuHaL9hKI6G+D9vBD/GJg+90pMdOejZproTCmH84RrDtNO8MyN/+c1vtxsoknHnbLbFe9Tw0ZwRt+DMgtMSsXXZL0BF9qNb4CgSRIbexGJJanMDqBXTYMl1vww/gtejTTDcdEvUaUWZ3umnEiZGEyLAuYkB9D7uGbUHXUwPm6A7AgGwFK2/bg6Mhclb+DLhsCxGoogQIxNo4BQdUghsnJV5UtqRDePPz6ZTuUhyV1oqvszCaJB6Aw==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AM9PR03MB7060.eurprd03.prod.outlook.com (2603:10a6:20b:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Mon, 14 Oct
 2024 09:27:20 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8048.017; Mon, 14 Oct 2024
 09:27:20 +0000
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add tests for bpf_task_from_vpid() kfunc
Date: Mon, 14 Oct 2024 10:25:53 +0100
Message-ID:
 <AM6PR03MB5848F13435CD650AC4B7BD7099442@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5848E50DA58F79CDE65433C399442@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB5848E50DA58F79CDE65433C399442@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0150.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::10) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20241014092553.16330-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AM9PR03MB7060:EE_
X-MS-Office365-Filtering-Correlation-Id: 90940b97-0233-48fd-68b3-08dcec3266d5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|5072599009|15080799006|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	ACHKZj0hcDTgRI/hIV12z6+OaUmJlkWzUi+SimzaAW5qnY7vr4FyQcprASP7BMT7MUIMcoFUxTdkMiJdUDFOBn6dVR1QC7TKFKMaqCi4ZW6dO4SemWkj/zah9cr/7I9BQnxIDV/Tew0vAh8QRlCYZTlOl6hDqNlPjpH1mWo7uMaSelzUKXeH7EZNMhSWmuw0/S234M5TC7eFIGPUWuB/JnvkbQ0rtSNroSHEZB2QWBGoie88F5xw04pbMpobiyVeDueauPg97fHWoFMsqcCPRzGhfuBvobQVps13gdguVlFwVkXlQkVDTjiI6smIsTWTZpnb8xKpvw7PVKpo56IfmuUYAqueQRPZX4VMFpIYREAh2QTxpxjjpZvtA6NfmEMayTVpHkR4lkcZ+Wf2ALTOytjMJZRbUGw7gE9bZ7ggWTcAfzmSZzK2Xj65zWZ6O9qI3I2lzRx5FN07PYDNl9lP7kBCaP/CXu7DfOvZmTzDEo4LSN/lZKRjlPLWa15d9eoUSzahKHiMehWJEqLOEGrvacNUuBDX4rynQr7+z5JSMEK9rfh0Oww4Hk7YazsXFmJnELjr7n9qQKFm3QTF9748CjksYxrnyiWM4oEf5AmB91R2AqYxUSKYiwd1Sah7lzs4q1lXd8DtD8h587n3iOufTVpm+r8aXvdsyLhqC5U/Fxz+3pfncTVPADRgaUK1KJT4AuqhdnNcHE4/N5JcZQffmw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1uvlHQbj6dLH43VliBjRiJhrNy8lrgvCUQJcD64ZxE0SrnMign+UN7gxFPuA?=
 =?us-ascii?Q?8z+EpUFvf1MOdb/V4lmr6txCb2GUMtT+GExCK8GR4ke8VTXZJfZT3EjtpC8c?=
 =?us-ascii?Q?tnl+l8cf/WezvKazb6huXIckOhb5rEq2Cn3ta6I76P5i057yajvXNp28wrAM?=
 =?us-ascii?Q?alST5CjQRiiFKtF8wy1OaPHP8E72k16F7Vr/X+azHJEgaNuWYIM+oUVCZz56?=
 =?us-ascii?Q?vuMoDxRBGQQXJ32msNFK62/uWFf4ClGBS3uD3wiPKQCYFDxgU/HXj6kVhUtL?=
 =?us-ascii?Q?mtudAvB0pjH2QQJdvhjZcUJ9gtf2vF0RHL75GAtIgFi/QyxmsfkBatjeVUIM?=
 =?us-ascii?Q?fkrbVwfAXcVsXK9T3E5w1N609K6aR3aCq61RUQ9camiYz64jUy/BeVZqYBWl?=
 =?us-ascii?Q?Wz7gPnA5W3/cfP24JMt1IcNN0x2hIpiCJjMpv1YDYqRkaEuv/wKsRvfcEaHa?=
 =?us-ascii?Q?7CLtPo+Kpt0/2FO9QIK8EQkR2GIAu+tKulbGxMBU/xOqfdGTNfWXPhe147e1?=
 =?us-ascii?Q?bcvd2/Ef3NuW1DJKjAH2eag1/oEwyaHxDJfC0ILMLvU7Y+523BalAT+MonfP?=
 =?us-ascii?Q?Vs8lNE6O8bl01wjuOjZZroYGswZYYCtfzs1sePhPqquZ+JxOWtZEQGOM2VEt?=
 =?us-ascii?Q?Jd+YhRHfKMwFn5+IiZRkcYuk/HAy63NfCNlzOfzX5Q3AbbbNPHFH6yjrabnM?=
 =?us-ascii?Q?Nppjk+FE3K1QMEYGpALDllkxadOJ8gEvpLe852giWDNqWMzIPbi3hamcKchT?=
 =?us-ascii?Q?8Im+OO8jl2WZvNN33rLcHvP3XqB7RBu8B2MJLeHVskTjGSMWr3gG7vZpspcH?=
 =?us-ascii?Q?nilhYouv7LViWg0P0kPbo+WjOkpSFaLPmtfUNi99HdI22dKXAslwoWFjy6if?=
 =?us-ascii?Q?75mZD6sGh02fIs8nUK50/gHLONuqE1V4fbplOf28mGysvfUCdd97f6h0WqJT?=
 =?us-ascii?Q?39zGCSEydsz43jHFdIAnEEGVrZH6gaYaAb0OgpTZpdsTI9ppZgoekWl2MQZt?=
 =?us-ascii?Q?tAA8koUwpeJRn09ABV+nU43ywxopvXxx6I/GQnHgE3rcvJvL7KVDxPUsGKd1?=
 =?us-ascii?Q?ZoW77kYWk7iBUg96Io459X/A25vDyS27jVfRV8OfumixIs3DZV5tmdhxFjiN?=
 =?us-ascii?Q?qGHKQv16jTddsJrn5NxrLhdkmFGUmMA7OQIjY0sTvNJ46Uq5Mz6bs+iRx8Ta?=
 =?us-ascii?Q?Yvlzd4s2zJqVa3jtwsMsdUjHJG03DnDXRptpk53xkk26fw4+hPm491aLHYEq?=
 =?us-ascii?Q?0ZG5UcvL61jM1hFDFdra?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90940b97-0233-48fd-68b3-08dcec3266d5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:27:19.9980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7060

This patch adds test cases for bpf_task_from_vpid() kfunc.

task_kfunc_from_vpid_no_null_check is used to test the case where
the return value is not checked for NULL pointer.

test_task_from_vpid_current is used to test obtaining the
struct task_struct of the process in the pid namespace based on vpid.

test_task_from_vpid_invalid is used to test the case of invalid vpid.

test_task_from_vpid_current and test_task_from_vpid_invalid will run
in the new namespace.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 .../selftests/bpf/prog_tests/task_kfunc.c     | 80 +++++++++++++++++++
 .../selftests/bpf/progs/task_kfunc_common.h   |  1 +
 .../selftests/bpf/progs/task_kfunc_failure.c  | 14 ++++
 .../selftests/bpf/progs/task_kfunc_success.c  | 51 ++++++++++++
 4 files changed, 146 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
index d4579f735398..83b90335967a 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
@@ -68,6 +68,74 @@ static void run_success_test(const char *prog_name)
 	task_kfunc_success__destroy(skel);
 }
 
+static int run_vpid_test(void *prog_name)
+{
+	struct task_kfunc_success *skel;
+	struct bpf_program *prog;
+	int prog_fd, err = 0;
+
+	if (getpid() != 1)
+		return 1;
+
+	skel = open_load_task_kfunc_skel();
+	if (!skel)
+		return 2;
+
+	if (skel->bss->err) {
+		err = 3;
+		goto cleanup;
+	}
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!prog) {
+		err = 4;
+		goto cleanup;
+	}
+
+	prog_fd = bpf_program__fd(prog);
+	if (prog_fd < 0) {
+		err = 5;
+		goto cleanup;
+	}
+
+	if (bpf_prog_test_run_opts(prog_fd, NULL)) {
+		err = 6;
+		goto cleanup;
+	}
+
+	if (skel->bss->err)
+		err = 7 + skel->bss->err;
+cleanup:
+	task_kfunc_success__destroy(skel);
+	return err;
+}
+
+static void run_vpid_success_test(const char *prog_name)
+{
+	const int stack_size = 1024 * 1024;
+	int child_pid, wstatus;
+	char *stack;
+
+	stack = (char *)malloc(stack_size);
+	if (!ASSERT_OK_PTR(stack, "clone_stack"))
+		return;
+
+	child_pid = clone(run_vpid_test, stack + stack_size,
+			  CLONE_NEWPID | SIGCHLD, (void *)prog_name);
+	if (!ASSERT_GT(child_pid, -1, "child_pid"))
+		goto cleanup;
+
+	if (!ASSERT_GT(waitpid(child_pid, &wstatus, 0), -1, "waitpid"))
+		goto cleanup;
+
+	if (WEXITSTATUS(wstatus) > 7)
+		ASSERT_OK(WEXITSTATUS(wstatus) - 7, "vpid_test_failure");
+	else
+		ASSERT_OK(WEXITSTATUS(wstatus), "run_vpid_test_err");
+cleanup:
+	free(stack);
+}
+
 static const char * const success_tests[] = {
 	"test_task_acquire_release_argument",
 	"test_task_acquire_release_current",
@@ -83,6 +151,11 @@ static const char * const success_tests[] = {
 	"test_task_kfunc_flavor_relo_not_found",
 };
 
+static const char * const vpid_success_tests[] = {
+	"test_task_from_vpid_current",
+	"test_task_from_vpid_invalid",
+};
+
 void test_task_kfunc(void)
 {
 	int i;
@@ -94,5 +167,12 @@ void test_task_kfunc(void)
 		run_success_test(success_tests[i]);
 	}
 
+	for (i = 0; i < ARRAY_SIZE(vpid_success_tests); i++) {
+		if (!test__start_subtest(vpid_success_tests[i]))
+			continue;
+
+		run_vpid_success_test(vpid_success_tests[i]);
+	}
+
 	RUN_TESTS(task_kfunc_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_common.h b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
index 6720c4b5be41..e9c4fea7a4bb 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_common.h
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
@@ -23,6 +23,7 @@ struct {
 struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
 void bpf_task_release(struct task_struct *p) __ksym;
 struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
+struct task_struct *bpf_task_from_vpid(s32 vpid) __ksym;
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
 
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index ad88a3796ddf..4c07ea193f72 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -247,6 +247,20 @@ int BPF_PROG(task_kfunc_from_pid_no_null_check, struct task_struct *task, u64 cl
 	return 0;
 }
 
+SEC("tp_btf/task_newtask")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int BPF_PROG(task_kfunc_from_vpid_no_null_check, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *acquired;
+
+	acquired = bpf_task_from_vpid(task->pid);
+
+	/* Releasing bpf_task_from_vpid() lookup without a NULL check. */
+	bpf_task_release(acquired);
+
+	return 0;
+}
+
 SEC("lsm/task_free")
 __failure __msg("R1 must be a rcu pointer")
 int BPF_PROG(task_kfunc_from_lsm_task_free, struct task_struct *task)
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
index a55149015063..5fb4fc19d26a 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
@@ -366,3 +366,54 @@ int BPF_PROG(task_kfunc_acquire_trusted_walked, struct task_struct *task, u64 cl
 
 	return 0;
 }
+
+SEC("syscall")
+int test_task_from_vpid_current(const void *ctx)
+{
+	struct task_struct *current, *v_task;
+
+	v_task = bpf_task_from_vpid(1);
+	if (!v_task) {
+		err = 1;
+		return 0;
+	}
+
+	current = bpf_get_current_task_btf();
+
+	/* The current process should be the init process (pid 1) in the new pid namespace. */
+	if (current != v_task)
+		err = 2;
+
+	bpf_task_release(v_task);
+	return 0;
+}
+
+SEC("syscall")
+int test_task_from_vpid_invalid(const void *ctx)
+{
+	struct task_struct *v_task;
+
+	v_task = bpf_task_from_vpid(-1);
+	if (v_task) {
+		err = 1;
+		goto err;
+	}
+
+	/* There should be only one process (current process) in the new pid namespace. */
+	v_task = bpf_task_from_vpid(2);
+	if (v_task) {
+		err = 2;
+		goto err;
+	}
+
+	v_task = bpf_task_from_vpid(9999);
+	if (v_task) {
+		err = 3;
+		goto err;
+	}
+
+	return 0;
+err:
+	bpf_task_release(v_task);
+	return 0;
+}
-- 
2.39.5


