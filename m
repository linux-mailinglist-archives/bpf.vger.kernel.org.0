Return-Path: <bpf+bounces-14909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B2F7E8DFB
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 03:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F40280D50
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 02:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1C023BD;
	Sun, 12 Nov 2023 02:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724F51FBF
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 02:31:03 +0000 (UTC)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B29C3840
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 18:31:02 -0800 (PST)
Received: from localhost ([173.252.127.8]) by mrelay.perfora.net (mreueus003
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LmJfA-1rbtEF3naU-00Zu3U; Sun, 12 Nov
 2023 03:30:46 +0100
From: Jordan Rome <linux@jordanrome.com>
To: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: add assert for user stacks in test_task_stack
Date: Sat, 11 Nov 2023 18:30:10 -0800
Message-Id: <20231112023010.144675-1-linux@jordanrome.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PN7RG/90Yun44E0zzqkcOvPWLKrXq93inSWNwhsV9D4nSM4gWW7
 IjKZHNvEJ/BG2p6CiZCrF9RghPoRSOAdRuuHoRmyrWDEZqbq6hBWKeIVw8BZcOOa+a5ZfTM
 hxSvnDOxKrfB0rOiQqfZWZtE94kcN4DNJo0HG0NzwgSwYoGfEh4EIov2dai7HU4u6zJ6/B+
 YcGqcDOytfYDFiDQTXu5g==
UI-OutboundReport: notjunk:1;M01:P0:d9kQUhjnrqE=;JW1t3YHYoBk2lsCKhwABs4+pGUJ
 v/Iomktq4xrJd8skvHN3ZC/WIHXT25Vk6AZ+UpI8YOo70TIuH7Qeb4FhdjPkGmpBdYDZpGxne
 BpcRGs0DUiGXw9HFT38zcB8IrzTVNcovnBLZYVnVa37hHZp2VkbKUth5ayQNEeTPeBn1F28D0
 RUuTiKLaMg7Sc7xzIumSWmqY0boBsoeutBgs8IJb++AJwSIhdAg4WTmagjENE9/Q8Ppd1nFBU
 OXdjFJkWHlcF+yDk01ZwM8HYCyBmFfoXS6X6b0Xxpsbsm1qR8vzusDmwD9JLidKRYIIsPUI0C
 chc5y5pFekzX8uyA1aPJI9Z3Ulf30Z9vFJthfGis5VZ4ZWZfMvVI5zoftvIY8/t0GhLAjgF2v
 WF6kTNQEYWp6+yht6Q5wtPQcQ1aXtcqomSrQNxjWgvqfKA1HWh4/+aDSjeqa90jMA63rnR7bl
 a/mq+dFWJNDm2DW68vJTLBGq0Q21I0h0ygJmB+2GzdnbL+1aI5/ol+aasAN3g7CLHTIveL9p3
 EehY3hntkRqJ3e6Iid/GFGGpcWN67ze3/aRx1NauVA5mzG6T5kNT3DOvuP+LLR8b/RXatXLbC
 Q6lx/ZrQuzyua+EH2lmb6UyQ49BrfxPlqKzfMhDUj/V2LxWDFMJyL4w4HRRSt+GNSxZZPbnQG
 NidroPWaJo2MwO9hk5RxzCS0T3zuhfQkEblVsKUI+1BIOeONgldLpvo4jXFVquLjfCigNO5H0
 T5AxMgTYzBlKWs2Hu+8aU8OeykUXSLqmQ40WXsAPc+ssLfgEq5G3ONp05Cavz3yIXr5fKuVBt
 GEdSPVTmGkdTXGelVHU6JPGELDwe6uetIL8kK03l5UAkoRNzRiT9NzfbTZ3MrffAV6IacoQdt
 94x4u33m7FjfDfg==

This is a follow up to:
commit b8e3a87a627b ("bpf: Add crosstask check to __bpf_get_stack").

This test ensures that the task iterator only gets a single
user stack (for the current task).

Signed-off-by: Jordan Rome <linux@jordanrome.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c       | 2 ++
 tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 4e02093c2cbe..618af9dfae9b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -332,6 +332,8 @@ static void test_task_stack(void)
 	do_dummy_read(skel->progs.dump_task_stack);
 	do_dummy_read(skel->progs.get_task_user_stacks);
 
+	ASSERT_EQ(skel->bss->num_user_stacks, 1, "num_user_stacks");
+
 	bpf_iter_task_stack__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
index f2b8167b72a8..442f4ca39fd7 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
@@ -35,6 +35,8 @@ int dump_task_stack(struct bpf_iter__task *ctx)
 	return 0;
 }
 
+int num_user_stacks = 0;
+
 SEC("iter/task")
 int get_task_user_stacks(struct bpf_iter__task *ctx)
 {
@@ -51,6 +53,9 @@ int get_task_user_stacks(struct bpf_iter__task *ctx)
 	if (res <= 0)
 		return 0;
 
+	/* Only one task, the current one, should succeed */
+	++num_user_stacks;
+
 	buf_sz += res;
 
 	/* If the verifier doesn't refine bpf_get_task_stack res, and instead
-- 
2.39.3


