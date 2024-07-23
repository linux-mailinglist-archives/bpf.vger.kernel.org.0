Return-Path: <bpf+bounces-35371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8C19399CD
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 08:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5592D1F2282D
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 06:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB46D14B954;
	Tue, 23 Jul 2024 06:32:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AA514A60F;
	Tue, 23 Jul 2024 06:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721716332; cv=none; b=XdK41ISXaW0SLCu3E1Uti+JAs4nScDLGJIyIPtOCQ4hbBKf2L6tSdX8sY0U6jXuhJZbW2JS/s+GOB9d+AfPzM1jfRjC9OsZjfOteZpeknd5htVXAxNnRRM/f1FpjrYzWMQAH4i0K1l7YhYqY4a/SDgTaZ7b10a7XzkpLaV/LX6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721716332; c=relaxed/simple;
	bh=MHUArHOlS3ABc3VTGuZAUpyYis5yQzmCYZycpKOAu6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j4hRpUhbQqlKQyAOYnf7fNPfCN6SQA+Uvm3zh0rlQT7quUE/vqpFHaZvF7j16DdO5pBIfO3fqpFg/HC3Nuajse3R5ier4uJcl8jV6hKRI2msJdOtLuN0BfM09tDexmfD388dzkJGXKUkZURaDGLh0OtUoLZSk4mV8APeIezRt6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WSnP13nP3z4f3khJ;
	Tue, 23 Jul 2024 14:31:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id DDC8E1A06D6;
	Tue, 23 Jul 2024 14:32:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP2 (Coremail) with SMTP id Syh0CgA34wpOTp9mjImuAw--.48686S6;
	Tue, 23 Jul 2024 14:32:01 +0800 (CST)
From: Zheng Yejian <zhengyejian@huaweicloud.com>
To: masahiroy@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen.n.rao@linux.ibm.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	mcgrof@kernel.org,
	mathieu.desnoyers@efficios.com,
	nathan@kernel.org,
	nicolas@fjasle.eu,
	ojeda@kernel.org,
	akpm@linux-foundation.org,
	surenb@google.com,
	pasha.tatashin@soleen.com,
	kent.overstreet@linux.dev,
	james.clark@arm.com,
	jpoimboe@kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-modules@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	zhengyejian@huaweicloud.com
Subject: [PATCH v2 4/5] ftrace: Fix possible out-of-bound issue in ftrace_process_locs()
Date: Tue, 23 Jul 2024 14:32:57 +0800
Message-Id: <20240723063258.2240610-5-zhengyejian@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240723063258.2240610-1-zhengyejian@huaweicloud.com>
References: <20240723063258.2240610-1-zhengyejian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA34wpOTp9mjImuAw--.48686S6
X-Coremail-Antispam: 1UD129KBjvJXoW7urykXF47Aw15uF47WrWfXwb_yoW8tFWDpF
	W5Kan3tr4DJa9I9anIga1kWFyfJ3yrG3y8Ga13G3s3Awn3Gr409r12vrnxZr9xJr95trW2
	kF4jvrsxGFWxXrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pR4E__UUUUU=
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

In ftrace_process_locs(), a series pages are prepared and linked in
start_pg, then fentry records are skipped or added, then unused pages
are freed.

However, assume that all records are skipped, currently the start_pg
will still be in list of ftrace_pages_start but without any record.
Then in ftrace_free_mem() index record by (pg->index - 1) will be out
of bound.

To fix this issue, properly handle with unused start_pg and add
WARN_ON_ONCE() where the records need to be indexed.

Fixes: 26efd79c4624 ("ftrace: Fix possible warning on checking all pages used in ftrace_process_locs()")
Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
---
 kernel/trace/ftrace.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index fff5d3466c41..6947be8801d9 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7087,10 +7087,22 @@ static int ftrace_process_locs(struct module *mod,
 		rec->ip = addr;
 	}
 
-	if (pg->next) {
+	if (pg->index == 0) {
+		/* No record is added on the current page, so it's unused */
+		pg_unuse = pg;
+	} else if (pg->next) {
+		/* Current page has records, so it's next page is unused */
 		pg_unuse = pg->next;
 		pg->next = NULL;
 	}
+	/*
+	 * Even the start_pg hasn't been used, that means, no record has
+	 * been added, so restore state of ftrace_pages and just go out.
+	 */
+	if (pg_unuse == start_pg) {
+		ftrace_pages->next = NULL;
+		goto out;
+	}
 
 	/* Assign the last page to ftrace_pages */
 	ftrace_pages = pg;
@@ -7306,6 +7318,8 @@ void ftrace_release_mod(struct module *mod)
 	 */
 	last_pg = &ftrace_pages_start;
 	for (pg = ftrace_pages_start; pg; pg = *last_pg) {
+		/* The page should have at lease one record */
+		WARN_ON_ONCE(!pg->index);
 		rec = &pg->records[0];
 		if (within_module(rec->ip, mod)) {
 			/*
@@ -7685,6 +7699,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		mod_map = allocate_ftrace_mod_map(mod, start, end);
 
 	for (pg = ftrace_pages_start; pg; last_pg = &pg->next, pg = *last_pg) {
+		/* The page should have at lease one record */
+		WARN_ON_ONCE(!pg->index);
 		if (end < pg->records[0].ip ||
 		    start >= (pg->records[pg->index - 1].ip + MCOUNT_INSN_SIZE))
 			continue;
-- 
2.25.1


