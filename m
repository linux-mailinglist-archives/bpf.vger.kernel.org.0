Return-Path: <bpf+bounces-43439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037409B55E7
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 23:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77CC2841CA
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 22:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A3320ADE0;
	Tue, 29 Oct 2024 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ipthFgUk"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2044.outbound.protection.outlook.com [40.92.58.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0FE199FBB;
	Tue, 29 Oct 2024 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241748; cv=fail; b=HRUtFLltgT5ErQFtcCxq0Te21LKQC5IbnxZ+F5hs6kc7z4EMJHTFmJnLlRxrh54mynGk+brMPGUMr+9dzHEC2MzX8y2t2r0jxvgSR+hvfK2rV94+GeRAiKjXfNRpSo7oc9CgmQLIzpSqW/803cFqBCRa3x5PmEiOjGSOWoEpS74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241748; c=relaxed/simple;
	bh=TmVbmywAbjQE9qy324iDqjWn/KJz3A/Q109kDadncfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qHYQmFZQ7xZ8Xq9ol62BMASORXpshnSodWhcV5uNMPPBn9FLgUhxgXXpUXAOtZ/HtwJK2GRqNoC2hwIQZhJA1EdC2/H6JHpmUUfDClPPDJfyoEK8AqUjBzm6J3M94VwhnV5T//o5ElreKfjtNXffTw/kPVvzPRWXLYYAB4GTYDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ipthFgUk; arc=fail smtp.client-ip=40.92.58.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgGiuI/3XZY9PY+DvLKv7baDHGsrkdVovE1KNHlvRylA4v9Za1qacybOjINaW60hZKgTaqvAROfjrDquvqmsTI+rVFOvWyV2nBKI4A4MCWGDDVB1Kf7LLcOR/Keog8j8ZWR+H8VeEoOoEha9ovRH3gsGoE+GwYbzq6BJg1Iwn57zCEyfPl3a9KYmwsxGGPE79+jIn8o53dkekO9ZB5L0vjlwrytZnRCfxVSHufPWg7Wm0BmJnveNqkGOkyxg9mpaYoC4eH49lIRuweIbgEIMMTRZygv/VH82CIjkZwOh7EvshYRcynOzOJbvWadyjAlXMmj5/agozmwIrf8gmBLJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCT168cnmImpgJ4I7ENlgp10y5Mp8vE5Je9OmnjFKxc=;
 b=a8lp7cM7xrBd46bz2vVsB2sAQ8oopPDFzKasPq/mixT3ImJpfedrYxZazF6f/aknw0H2dByJCAdAp/oZUXvRGxk15r2NC4BgPKaO9L9iHmf2sgEA7liszFhUC49NnufdM92eKeRn0iygPOoAucu0LNmE/oFXqp1HTh5/BT9kQ8NDo+mGq3isfY9eLgLU4/851q3CLQ/WC0wvrZnPNo+xzRAWu9/9p8NB0TCf4DKtPrD+e/fXcIU5E3GmWekPDjeO1DHLBx0+AlQbOcUdw+IrsdtrgwxU5VEfXcizCC0+judyd9RkTJCtpCOhNArT6E251Z170iSn+KbKW7iSfmUwgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCT168cnmImpgJ4I7ENlgp10y5Mp8vE5Je9OmnjFKxc=;
 b=ipthFgUkbYnW/bsj7RZXjZLWBXajrHJu9R0wr9hGs2R9XjBpmbbyvymZFCYxMOjdUgn/55NW/B/I3uAbSM9oQHbzqtkQPy/Pqdo1pKTRDDtNVBXJKeUHcclx0eMoloKL5w+b782DW67HJ2kTy/kYGQaukHcqXzhEt9ypLonLoc8YIfHxi/kdPSe7nYLs3aFU0nV2GrhPJmlAcAF1hpENfkzuCuKYa1whTpv4xfImVvH7T8RV8dLdNRU/gLk8GmYNnVcBI5Nv5tJPZ/FqpBKeqBKv20mRp4QVdCR06c2YrCVgujiKBJ3J38bkTLH4c+DLE/63+6goxSfeI/8l1Y5GNw==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AM0PR03MB6130.eurprd03.prod.outlook.com (2603:10a6:20b:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 22:42:23 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 22:42:23 +0000
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
Subject: [PATCH bpf-next 2/4] selftests/bpf: Add tests for open-coded style process file iterator
Date: Tue, 29 Oct 2024 22:39:41 +0000
Message-ID:
 <AM6PR03MB58481002AC107CA87A2301A3994B2@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB584801332A1D31C21D23CC19994B2@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB584801332A1D31C21D23CC19994B2@AM6PR03MB5848.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0476.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::13) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20241029223943.119979-2-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AM0PR03MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ade31d-561f-48e0-2799-08dcf86af489
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|5072599009|15080799006|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9dL+b2SOQWHimagi6Xxzu4qOOhU5atQRfLY/b6REOXlgdh0Z7RlyBtkKqkIR?=
 =?us-ascii?Q?IXyt70YP0GKl+UyLntQuW70zuxRh0X5So8UVWDvEMSheDLwKMLymmxEs0VCK?=
 =?us-ascii?Q?qOvYkoQGv0onL+Po4k+jifQZUsc5HdCdiLoECFGZ8vL8zVddcmBXs9wfLYR4?=
 =?us-ascii?Q?bTTnR4NlLIHQVgMH/aGdakLcxdSFoe6NI6TpCgrYgv2WNVoYIkUjPF+rRSiT?=
 =?us-ascii?Q?cCsgrsWhcVetSm1zgq5kkTGUM/7dErAan/pHCtsZSe+Yi0K0VeH6X3tlzNqW?=
 =?us-ascii?Q?RZQNCPNjqob8xCyrPjQt6ivr0ONXxtUgIh+HlUMJ4ssixw8tXcAsZeF2YHA1?=
 =?us-ascii?Q?dgpN+pFthRg0quIaAx+cV7dIa2vEo6B5ssr+g+1ej5nB6H6F/axOS2eumPLR?=
 =?us-ascii?Q?DdBnVIBqp49DIH2Y9Vtprhi6rlUHpp4BtWHyBQBhKCBwGH/h/ONFgBJ/Ra9z?=
 =?us-ascii?Q?FX/g/SWI6Pw3VVtSqKmkNhcoyiNbcyXUxmnekFfWGapFaFXpZrIGBh3uEz21?=
 =?us-ascii?Q?Kv6KnuHaVovK9fwEXLdDOWnat0XTiYONmJB7nraD2cXQmoHZvkVLcfSbWXZd?=
 =?us-ascii?Q?m3FcbmZxvRn+RQfR6RRh9/8Cek9e3OQxcDuXBWVE4yd/IOf5rZ08cKlOjc+x?=
 =?us-ascii?Q?xRNvpDsoprZk+EfS6WoxwRR4SdhNF+YO29u8/lDH7VivCFhofnG48FegmusW?=
 =?us-ascii?Q?gAI7j7vkvK+fD5MzVaya/QVbOBbiqzNQWQbagK0mFV8SUlpqXm+6oIusL7Ci?=
 =?us-ascii?Q?hbFKS4FFY+XNvTMyoWAneHbJRVveGoWdSUxS5mP5xVbUBt3GzwGEHmGjWOOo?=
 =?us-ascii?Q?MlxM+H10TrBcMbE6dUP5ThoAmfY24LKP3p2Z0FyC+AEnBGU4fNYfvL5M5XAa?=
 =?us-ascii?Q?VMwd85fRksoTdLVo4Kz7tx+uMAkQEHC3pYq4Sz+eoHfnpU4sdYMAK2vOj2un?=
 =?us-ascii?Q?4K2QB9o+DG7vMYZ8SZQ090zQWY/7kWt+ygdiTM54PmIfFp/nQvmFG85Y/ens?=
 =?us-ascii?Q?uahnXOYgWV0ofq0AuHPJwdUg8Q=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S2/Rs90cCMfbcCd7xal5pOcFRXK4PBAFIG+X25Lhv7ERhkJD1Fp23J8MNuS8?=
 =?us-ascii?Q?Czo/5lIIo+GyEcLiM5K9wyNmRAeo/ygAXyZiGOF4evYF/an5vSZyRcoQkNlv?=
 =?us-ascii?Q?OW+O9p0s6RzrEBqVaLV0Tb/2X4q02s0DR/heGClZxNdHE8ZGgAReoZfSkktC?=
 =?us-ascii?Q?8GBdgjxCEy9XrvJgtXKy+jBIuo5gqo/ZlzrPVaJoWSd5yLp0tl3zIDHhSQip?=
 =?us-ascii?Q?deF7P9FGVY4v/qhCVb4iEATJ1p3Q7mpvQLMkS3rC6c2J2cmFy7ldU+mX2Isr?=
 =?us-ascii?Q?7PfXyuqMVqvmp0l2ziBHp5W5QfdQoxGEu4W4Ap9SDZKkmF8I1euLH6GipWVP?=
 =?us-ascii?Q?swp3SU25eRNe9aGQkikSwV9yrt286D0EIldbSPDFANlTbcoklTvKDiakE1ko?=
 =?us-ascii?Q?7H7IDj4AqEuL+GQFSydwzxr5nAJOm53JN9cB8zL/g7ApeJPGmhqrak8ROeV2?=
 =?us-ascii?Q?lDSFxAGOUK51BheXevm5N8a8XoAFAWliK3mQs/2XIT194BK4rjkBq5DfUmac?=
 =?us-ascii?Q?vzVfWOLDBdhAuvRiIFOZIVE9QgvwbqaalIY3uDX0StcwAIDbIhMmKjb7fkIA?=
 =?us-ascii?Q?Uc3bIagKppvDgAwLWURIoig5gvXzJK3ipMOc66dqcyTczJCHe+1CSWBLNiRe?=
 =?us-ascii?Q?mrTG7unk1BOyHTsgyLFT6xThpoZ8fPyHNgfn3LRkTrLmPmKXakeuB9MXu17Q?=
 =?us-ascii?Q?tm5SVGSdRgwMQc39uNNn7KmrqC9Hsxzj26D7QLon438v4O9Om/HXTwWj+aeY?=
 =?us-ascii?Q?z72Dsg0zew505pnWIbdyMneY6LNunGmLeRo2Hoz0UAA0bX1WWNrCSbw2Za2G?=
 =?us-ascii?Q?ZlhStQ/fl1BkQQELvHxr60TPKEhlQpr+iEhlMDoG4b0PBwlDji2AAdbRktAt?=
 =?us-ascii?Q?wnj1h3IVAkR25n4nQ5d93DK5d48BJLPhynLSTMSFTTE/W6Ra/p2wqoha85A7?=
 =?us-ascii?Q?D0YtQ4mPwYovQJS3bNkyipKa7etNAKXOxHQUFcI0Zqb9tgjAjkSBhoDCuo2f?=
 =?us-ascii?Q?G5/xv2CO01xVppJ8ZVohvHKe5vsImCrZ5tJwi4s+M0MJowpApS4UpUon9FwG?=
 =?us-ascii?Q?HkEG4VssNffAl0MNR4M9AZlpFgUbiGneWKoo3duko2OI62OE702M2jWSECII?=
 =?us-ascii?Q?HQubzr4IxJOfu2DP2YwnGZGdEZ5PHYbxDKSX+QBKcw9x+kcdFqNhex/uc3T+?=
 =?us-ascii?Q?d0IN3+GKT4qrUKlG7VHMbBOdAPQGxev9vEIfcutiI3B7gAEtF8j0lOGzDt9Y?=
 =?us-ascii?Q?hkaJm+VfkB58yoKHKAj6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ade31d-561f-48e0-2799-08dcf86af489
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 22:42:23.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6130

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


