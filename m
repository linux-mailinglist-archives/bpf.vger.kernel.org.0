Return-Path: <bpf+bounces-43457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78019B5870
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C22286931
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 00:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0251CD2FF;
	Wed, 30 Oct 2024 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="G1fiCqWa"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2021.outbound.protection.outlook.com [40.92.48.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A40DDC3;
	Wed, 30 Oct 2024 00:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247382; cv=fail; b=tXdP6Qyqdz/mPEJOJmAJDT87/RfW+H9oiRHH5DucsTzIUJ7Y+qOd3Z6sqjKWoFOedvH7AdQVjaaRuI/WXvujKCMSyZ5deWc63XCazx3zAEIdLH+xt17grCGYa+Fph1EtqVHUJ3C6Bq2l66V0y8+OZQR+WFZAxOTCpFDzAdq+PIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247382; c=relaxed/simple;
	bh=TmVbmywAbjQE9qy324iDqjWn/KJz3A/Q109kDadncfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZacCU8zkuoHIEh8Ys2G+9HsfQMOSWBVsL0w+Yy9I9H55Wnl8phJQTuyFLdrDQwgaF6bJdow/sm5hRE0VXR/usYUIdbmulyDNQMDzEJeuHEfaudmStgnzGWBskiTkV6RaCZd/bPJGqDmKLalibB16V0DSS5JRwgybOS+UGoD7wN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=G1fiCqWa; arc=fail smtp.client-ip=40.92.48.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rulBd5rBRjWlzY8a/lXGrQvv7UjiXRh2zRxATRRYbeU5jbFuZT4vcBwrtu0Ylv491NN2/TPrbYnFT0DzHA63nSZ1bJqT8EjedeWMYiy8Q5ujWsF8+dPZfzo9fTyE+FKjnn5ks7ZPakHHmdNS1JDqoAwbHHF4NDKQOSj7nMjwiJ1MU2/M3CUDQe09NiAeBnpifUV7wuQu4TeisNnV68R9R1lm0R/7jRn7aek4WyRNMkwXoAxJowpzv2DEJ8twDWjd99YPuh6wIxpcARrqluZqecj6egPbNBHX7QdvrOXxDZGs/YLdd9RSNN+do6YX/Wi3J307UpmKneLRSmUR6sZuTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCT168cnmImpgJ4I7ENlgp10y5Mp8vE5Je9OmnjFKxc=;
 b=Gl/0AXJv0P1IHFM454sG2DzzbOkixvIxS1s+yxYV5cuL3MIt73XPcHH6Jbg1yHTDPTg2YvcAaV29G1hgCzJOqaisaA0Oz8V6FXx+J88zfff0edtsYYtppg9C/zJdUM/R7ybMlMwWfGF2SMtvJVyxZv/2HMwBYgjl283XR0sOj8JKULBbhSOwszO3R9J3FYDWYW79tg/fdWHrM+Jj/3qEbwCIDNmQb0ZqxC+bshtBgYiSsHCQqCTnzJPsr19pJS348PhfEGa652mqeqVbZAiob2AH/5kmtlhiFnSU0yLF4KdgxBA/aDTHvxGhvuYVTvREedaq5vG2B3KWkFeVrXe3cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCT168cnmImpgJ4I7ENlgp10y5Mp8vE5Je9OmnjFKxc=;
 b=G1fiCqWaUYgNK77lBpKnfzn5KxFNH7soZ9pqXGZZ9QEb+Q+1+orPSGrqaqjOl3rIvYZfILplc5pqLfPzBxWWACAMto/4DL9uqco+/IklUmDHWzuZ4OPmCt4Z0pPa85dmBxIPEX+RfzUni1LwBF5yG587E/CK3zit1k5SiV7ZYwGV3cng1gYBeL0lhP9OOr4o/yOTl6lUe5ktWMdl1iQPd0Xgz3Ku9gFoHTe2IMlgVl6WVvLrdObhIj1b8DOjSRk6dAntZtRp2D+FgUzurbEZWWcRqH23LcsU73U0mzrLa6Hn9nWNwZROVSalKQkjepxKI0RSTD7BVMlpFMHCXDABFw==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by DB4PR03MB10105.eurprd03.prod.outlook.com (2603:10a6:10:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 00:16:13 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 00:16:13 +0000
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
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: Add tests for open-coded style process file iterator
Date: Wed, 30 Oct 2024 00:14:55 +0000
Message-ID:
 <AM6PR03MB5848A57EF16323E99A4E6F8D99542@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5848098C1DF99C6C417B405D99542@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB5848098C1DF99C6C417B405D99542@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0238.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::11) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20241030001457.15593-2-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|DB4PR03MB10105:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b74f99-48d9-4292-2828-08dcf878106d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|461199028|8060799006|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DYam3ZJBXWJmWtkBhcJwA0ANtxsMfcCJckpLWDoqGGuKw5ALSu57hQda8Xer?=
 =?us-ascii?Q?r5ZQjDdZT+RbZwD473/UrTHERF5JF+UqC5rsQVckxDxXsCtHWVg+YF2vXWJu?=
 =?us-ascii?Q?oIb9V/vYcK0Ej5+65l9WBjuciHhwrXuSthJYwVc9p9SatnYr7ceGpOkStD0A?=
 =?us-ascii?Q?ZGebtPD4r2GZUkW/yBTqwwRTU8SJsI0j7Xe9icPdumo10arm6ya7h9czTSN8?=
 =?us-ascii?Q?4LEZVroeYJm3mr9mODKkpbzGkh9d96CaKsrJ35nIIW0hPMaVdWGw6/Ra1rN9?=
 =?us-ascii?Q?NlITpjlL8dtcg+uL/wPALt7pPspSXdoN/CCLym+303TvbC9YWlG0tvunadkw?=
 =?us-ascii?Q?pIJUuOUOcgdJpnHcX5bDG8McUn/IuD15pQA/cwES8uJ6sJsejHQAusaBV6A3?=
 =?us-ascii?Q?kQRKarFjiXVcZtFnouUvLFDM/2E3LhG7NGJk62vYEmQ0WTWxQqhLAiRvfnjD?=
 =?us-ascii?Q?ziWHj7m2o3ijp1NP2MIO5yI5WkfJMF94V0jL38daiPj+xg/hgv1XkVjo5V5P?=
 =?us-ascii?Q?Ea+4x2KP7iqfe/nQfslasa40PiBy8NVbGb0WUD5gaKc/hTzOcWAuZ4M8/4u5?=
 =?us-ascii?Q?rLb3133tQu+Wu//emWlrO5D1q4z4YmoW6+UTXBSLIuXMOcCjRxgRIIauOTMg?=
 =?us-ascii?Q?jocaz8oPlpK7DIWigjfyZgEeRgNtHqqcaS2hIIfCVaYwG3BN4a2gYXDS53Bq?=
 =?us-ascii?Q?D9BeeDJShPgipAPW9PJlmstqezh015CPFQ0/4/VracfE10mdDFMYPwU7rOq9?=
 =?us-ascii?Q?uuhQHLt75Qc0GA3av9XQ7SY1TKhICV7KB9GaNR8t/Q/DjgX6VJPDkw9buQeX?=
 =?us-ascii?Q?AEpLz/aFKv3O+aK7VzFZbaQHMCSbdtEGKrwrSrS3uV99PCzaa81WoJkEBm4c?=
 =?us-ascii?Q?3tRP85J9mtL+Uo1oksmhx7WgPr9F/ZtRa8SFBE8YgFe0EBdLMR38go85zDz2?=
 =?us-ascii?Q?If9yhVhubrrwpp7kZRbwis3tCPP0RzanH5ODcw2ukU6S3o2cF1Kvy0KPxeo2?=
 =?us-ascii?Q?H4DM7Fynl+uY4CrQ150smb/RJA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5ndiF0X6wIAl1P3YMCqTfwqX2CUwF0Fnnp5TW4t0XOOokNFz3ak+r7sAk3J3?=
 =?us-ascii?Q?qWborBl1i+9UmuQWhTMl/kE+RZWS/SNbJBYeQLHYTOu9wJ6QPWAq1L+hOiy+?=
 =?us-ascii?Q?aUDkVXq6cYvlTOZDByEh4hUiZ7GL3I/BMhQ73gwYhnnTYRBD1dPXHX+8bR+n?=
 =?us-ascii?Q?3+8wNu5/TSMzh+u/6Lt2pUmRCaHNrQKx54O7qjma1VStawHGagCjGJGWPheO?=
 =?us-ascii?Q?JkWb8lNShmU8U9vb3iQMHSgXGFmP/Q+7F2393KW7OJx+2yk4PcQ9eJlLEoPO?=
 =?us-ascii?Q?cNrDqK6khWsnf6cakkPvc5cMFgjnmhLUxtIajiK5VGdRx87TVdfI+f90/J2J?=
 =?us-ascii?Q?Wx1o+APmFdJoBZFox1pEDk33a3on99TLd7FUyKu80Que5gvpO0ugHn16RIXu?=
 =?us-ascii?Q?znCn0nudSOPWn6Y5tiZV44NvGHVqH0lbGWigJftg7XOhwstFXpJP978QWmT0?=
 =?us-ascii?Q?RvdEYKvtcB6JWPASqXvWpmlLMuRBpahcOW23MoTiNr8DVc0K30+tttAxPBWS?=
 =?us-ascii?Q?fcQM0UVnJTVIM8VYhdoBbK/gISOaZj2L62fTSvUPyEowVFAT2iBmnbmvKNnQ?=
 =?us-ascii?Q?GAXqJ2b6t26iwnacJceYpUlvbcdwPjMwZCKxYJEW2fjCtiDVa6iD8+k2AB58?=
 =?us-ascii?Q?0TZGEyUIym0I6eooA1K7uBgr8YeLlJyQsh84EXn36h4OK3Tx2wv8CZ3+unyW?=
 =?us-ascii?Q?aag2A50yuKnV67BzEt9YqqVbjPYJB4MVlDM3CLaDHEdtbSQS/bt99YoNW3si?=
 =?us-ascii?Q?RZjq7ybx7iYTFHWI+THmAhpj+5bE6tVhoSY0tQRq+5xX7+5NX4JIQdOl7c/0?=
 =?us-ascii?Q?AF0rrxbxKpP+oaIL5TIHYj/gMqxPySpvVpusof71W7oTSSVbSTPuApIGS9jN?=
 =?us-ascii?Q?UeNgA33ylP0X1k+BiNW9IjfzpsY5eS3wy1LJAJOeQyc7xPJEiQOTacet7UKl?=
 =?us-ascii?Q?MjXa9iG9qc6UhFv6Krno0C47bWm26yUQj7VPJ2sxhCMWAM+cm8T5OHV8Q2sv?=
 =?us-ascii?Q?WVlTSUIgg39TclLntB/tI/7X+G5cWrQByp5J7MfhPAq1abZjhPactMpeOZGh?=
 =?us-ascii?Q?otzbyXmGoyHKW4sMCztmVF6L4xh+52jEM0XsYOkQU6Mok1pCm9Cxxt98TBxp?=
 =?us-ascii?Q?kDNhHbcmzbCe3pXQjS1c8+aSpyCWg5N/y3SNdDLpRLBOjroQzMN+T1mZKBCj?=
 =?us-ascii?Q?wg7/rTwbCaOsLAE66Y0ZI56dKD8UjNM7L16s+nYtLQYPPsVzkI30IoJ5xGnt?=
 =?us-ascii?Q?DTNwtL1Ur+YhWT+xwpji?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b74f99-48d9-4292-2828-08dcf878106d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 00:16:13.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB10105

This patch adds test cases for open-coded style process file iterator.

Test cases related to process files are run in the newly created child
process. Close all opened files inherited from the parent process in
the child process to avoid the files opened by the parent process
affecting the test results.

In addition, this patch adds failure test cases where bpf programs
cannot pass the verifier due to uninitialized or untrusted
arguments, etc.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 tools/testing/selftests/bpf/prog_tests/crib.c | 125 ++++++++++++++++++
 .../testing/selftests/bpf/progs/crib_common.h |  21 +++
 .../selftests/bpf/progs/crib_files_failure.c  |  86 ++++++++++++
 .../selftests/bpf/progs/crib_files_success.c  |  73 ++++++++++
 4 files changed, 305 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/crib.c
 create mode 100644 tools/testing/selftests/bpf/progs/crib_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/crib_files_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/crib_files_success.c

diff --git a/tools/testing/selftests/bpf/prog_tests/crib.c b/tools/testing/selftests/bpf/prog_tests/crib.c
new file mode 100644
index 000000000000..48c5156504ad
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/crib.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <test_progs.h>
+#include <unistd.h>
+#include <sys/wait.h>
+#include <sys/socket.h>
+#include "crib_files_failure.skel.h"
+#include "crib_files_success.skel.h"
+
+struct files_test_args {
+	bool *setup_end;
+	bool *cr_end;
+};
+
+static int files_test_process(void *args)
+{
+	struct files_test_args *test_args = (struct files_test_args *)args;
+	int pipefd[2], sockfd, err = 0;
+
+	/* Create a clean file descriptor table for the test process */
+	close_range(0, ~0U, 0);
+
+	if (pipe(pipefd) < 0)
+		return 1;
+
+	sockfd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+	if (sockfd < 0) {
+		err = 2;
+		goto cleanup_pipe;
+	}
+
+	*test_args->setup_end = true;
+
+	while (!*test_args->cr_end)
+		;
+
+	close(sockfd);
+cleanup_pipe:
+	close(pipefd[0]);
+	close(pipefd[1]);
+	return err;
+}
+
+static void run_files_success_test(const char *prog_name)
+{
+	int prog_fd, child_pid, wstatus, err = 0;
+	const int stack_size = 1024 * 1024;
+	struct crib_files_success *skel;
+	struct files_test_args args;
+	struct bpf_program *prog;
+	bool setup_end, cr_end;
+	char *stack;
+
+	skel = crib_files_success__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (!ASSERT_OK(skel->bss->err, "pre_test_err"))
+		goto cleanup_skel;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "find_program_by_name"))
+		goto cleanup_skel;
+
+	prog_fd = bpf_program__fd(prog);
+	if (!ASSERT_GT(prog_fd, -1, "bpf_program__fd"))
+		goto cleanup_skel;
+
+	stack = (char *)malloc(stack_size);
+	if (!ASSERT_OK_PTR(stack, "clone_stack"))
+		return;
+
+	setup_end = false;
+	cr_end = false;
+
+	args.setup_end = &setup_end;
+	args.cr_end = &cr_end;
+
+	/* Note that there is no CLONE_FILES */
+	child_pid = clone(files_test_process, stack + stack_size, CLONE_VM | SIGCHLD, &args);
+	if (!ASSERT_GT(child_pid, -1, "child_pid"))
+		goto cleanup_stack;
+
+	while (!setup_end)
+		;
+
+	skel->bss->pid = child_pid;
+
+	err = bpf_prog_test_run_opts(prog_fd, NULL);
+	if (!ASSERT_OK(err, "prog_test_run"))
+		goto cleanup_stack;
+
+	cr_end = true;
+
+	if (!ASSERT_GT(waitpid(child_pid, &wstatus, 0), -1, "waitpid"))
+		goto cleanup_stack;
+
+	if (!ASSERT_OK(WEXITSTATUS(wstatus), "run_files_test_err"))
+		goto cleanup_stack;
+
+	ASSERT_OK(skel->bss->err, "run_files_test_failure");
+cleanup_stack:
+	free(stack);
+cleanup_skel:
+	crib_files_success__destroy(skel);
+}
+
+static const char * const files_success_tests[] = {
+	"test_bpf_iter_task_file",
+};
+
+void test_crib(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(files_success_tests); i++) {
+		if (!test__start_subtest(files_success_tests[i]))
+			continue;
+
+		run_files_success_test(files_success_tests[i]);
+	}
+
+	RUN_TESTS(crib_files_failure);
+}
diff --git a/tools/testing/selftests/bpf/progs/crib_common.h b/tools/testing/selftests/bpf/progs/crib_common.h
new file mode 100644
index 000000000000..93b8f9b1bdf8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/crib_common.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __CRIB_COMMON_H
+#define __CRIB_COMMON_H
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+extern struct task_struct *bpf_task_from_vpid(s32 vpid) __ksym;
+extern void bpf_task_release(struct task_struct *p) __ksym;
+
+struct bpf_iter_task_file;
+extern int bpf_iter_task_file_new(struct bpf_iter_task_file *it,
+		struct task_struct *task) __ksym;
+extern struct file *bpf_iter_task_file_next(struct bpf_iter_task_file *it) __ksym;
+extern int bpf_iter_task_file_get_fd(struct bpf_iter_task_file *it__iter) __ksym;
+extern void bpf_iter_task_file_destroy(struct bpf_iter_task_file *it) __ksym;
+
+#endif /* __CRIB_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/crib_files_failure.c b/tools/testing/selftests/bpf/progs/crib_files_failure.c
new file mode 100644
index 000000000000..ebae01d87ff9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/crib_files_failure.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "crib_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("syscall")
+__failure __msg("expected uninitialized iter_task_file as arg #1")
+int bpf_iter_task_file_new_inited_iter(void *ctx)
+{
+	struct bpf_iter_task_file task_file_it;
+	struct task_struct *task;
+
+	task = bpf_get_current_task_btf();
+
+	bpf_iter_task_file_new(&task_file_it, task);
+
+	bpf_iter_task_file_new(&task_file_it, task);
+
+	bpf_iter_task_file_destroy(&task_file_it);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("Possibly NULL pointer passed to trusted arg1")
+int bpf_iter_task_file_new_untrusted_task(void *ctx)
+{
+	struct bpf_iter_task_file task_file_it;
+	struct task_struct *task = NULL;
+
+	bpf_iter_task_file_new(&task_file_it, task);
+
+	bpf_iter_task_file_destroy(&task_file_it);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("Unreleased reference")
+int bpf_iter_task_file_no_destory(void *ctx)
+{
+	struct bpf_iter_task_file task_file_it;
+	struct task_struct *task;
+
+	task = bpf_get_current_task_btf();
+
+	bpf_iter_task_file_new(&task_file_it, task);
+
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("expected an initialized iter_task_file as arg #1")
+int bpf_iter_task_file_next_uninit_iter(void *ctx)
+{
+	struct bpf_iter_task_file task_file_it;
+
+	bpf_iter_task_file_next(&task_file_it);
+
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("expected an initialized iter_task_file as arg #1")
+int bpf_iter_task_file_get_fd_uninit_iter(void *ctx)
+{
+	struct bpf_iter_task_file task_file_it;
+
+	bpf_iter_task_file_get_fd(&task_file_it);
+
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("expected an initialized iter_task_file as arg #1")
+int bpf_iter_task_file_destroy_uninit_iter(void *ctx)
+{
+	struct bpf_iter_task_file task_file_it;
+
+	bpf_iter_task_file_destroy(&task_file_it);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/crib_files_success.c b/tools/testing/selftests/bpf/progs/crib_files_success.c
new file mode 100644
index 000000000000..92ca7d9d44c3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/crib_files_success.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "crib_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+int err, pid;
+
+SEC("syscall")
+int test_bpf_iter_task_file(void *ctx)
+{
+	struct bpf_iter_task_file task_file_it;
+	struct task_struct *task;
+	struct file *file;
+	int fd;
+
+	task = bpf_task_from_vpid(pid);
+	if (task == NULL) {
+		err = 1;
+		return 0;
+	}
+
+	bpf_iter_task_file_new(&task_file_it, task);
+
+	file = bpf_iter_task_file_next(&task_file_it);
+	if (file == NULL) {
+		err = 2;
+		goto cleanup;
+	}
+
+	fd = bpf_iter_task_file_get_fd(&task_file_it);
+	if (fd != 0) {
+		err = 3;
+		goto cleanup;
+	}
+
+	file = bpf_iter_task_file_next(&task_file_it);
+	if (file == NULL) {
+		err = 4;
+		goto cleanup;
+	}
+
+	fd = bpf_iter_task_file_get_fd(&task_file_it);
+	if (fd != 1) {
+		err = 5;
+		goto cleanup;
+	}
+
+	file = bpf_iter_task_file_next(&task_file_it);
+	if (file == NULL) {
+		err = 6;
+		goto cleanup;
+	}
+
+	fd = bpf_iter_task_file_get_fd(&task_file_it);
+	if (fd != 2) {
+		err = 7;
+		goto cleanup;
+	}
+
+	file = bpf_iter_task_file_next(&task_file_it);
+	if (file != NULL)
+		err = 7;
+
+cleanup:
+	bpf_iter_task_file_destroy(&task_file_it);
+	bpf_task_release(task);
+	return 0;
+}
-- 
2.39.5


