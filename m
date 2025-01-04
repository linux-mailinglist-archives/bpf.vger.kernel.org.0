Return-Path: <bpf+bounces-47864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CF2A01188
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 02:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D165F1884C51
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 01:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434021DDEA;
	Sat,  4 Jan 2025 01:37:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939FF8F7D
	for <bpf@vger.kernel.org>; Sat,  4 Jan 2025 01:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735954635; cv=none; b=WE6nzRzKbVCuMra2MLuZ9QsgFsATiLsuvWXPVf0RoibDDKr0xjyZk3MPIgOwlVI+n/oYHPUFe8q9wX2ilwUx/P4XtT6UmJFOJVT9BlPzyBtrKoJmeEgX7TDcHNOInavrreCzy2fBs5dAVfoDmpYoeG/qUjZ102JI+Nej7nPhovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735954635; c=relaxed/simple;
	bh=mrKdTuT6/hwbvAtZCX9GucdGQu4bEQ+ckV8dFRheRos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D0Jskq2MeOYHzHixZhADzpziaWcNZyA9ZGoPqJ+q6e8FuW5ylKUNCoLQlfBlZU+r27PE3tP0Ij8dteH3T6YdmeMXCNw9rM4NmqfLiGg1g6W0jvH97JKPcIOUElHjRXAgR6iv6L9kAzepRiS8C8ubRRUYnes8NXLRM6Z9OAn8QGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YQ32R67bKz4f3lVs
	for <bpf@vger.kernel.org>; Sat,  4 Jan 2025 09:36:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1094F1A12CA
	for <bpf@vger.kernel.org>; Sat,  4 Jan 2025 09:37:09 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgA3X4PDkHhnNAPuGQ--.62296S2;
	Sat, 04 Jan 2025 09:37:08 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next v2] bpf: Move out synchronize_rcu_tasks_trace from mutex CS
Date: Sat,  4 Jan 2025 01:39:46 +0000
Message-Id: <20250104013946.1111785-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3X4PDkHhnNAPuGQ--.62296S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW7KF4rWr43KrWxuw45ZFb_yoW8Zr45pF
	srGasxKr4UJr42qws5Zr4xC34UA3ykW3y5GF4DJa4F9r1YgrZY9FWDKFW5Aw1F9rZ7XFyI
	q34qqr17GFyjvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Commit ef1b808e3b7c ("bpf: Fix UAF via mismatching bpf_prog/attachment
RCU flavors") resolved a possible UAF issue in uprobes that attach
non-sleepable bpf prog by explicitly waiting for a tasks-trace-RCU grace
period. But, in the current implementation, synchronize_rcu_tasks_trace
is included within the mutex critical section, which increases the
length of the critical section and may affect performance. So let's move
out synchronize_rcu_tasks_trace from mutex CS.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
v2: Simplify code logic. (Jiri)

 kernel/trace/bpf_trace.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 48db147c6c7d..a90880f475af 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2245,6 +2245,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 {
 	struct bpf_prog_array *old_array;
 	struct bpf_prog_array *new_array;
+	struct bpf_prog *prog = NULL;
 	int ret;
 
 	mutex_lock(&bpf_event_mutex);
@@ -2265,18 +2266,22 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 	}
 
 put:
-	/*
-	 * It could be that the bpf_prog is not sleepable (and will be freed
-	 * via normal RCU), but is called from a point that supports sleepable
-	 * programs and uses tasks-trace-RCU.
-	 */
-	synchronize_rcu_tasks_trace();
-
-	bpf_prog_put(event->prog);
+	prog = event->prog;
 	event->prog = NULL;
 
 unlock:
 	mutex_unlock(&bpf_event_mutex);
+
+	if (prog) {
+		/*
+		 * It could be that the bpf_prog is not sleepable (and will be freed
+		 * via normal RCU), but is called from a point that supports sleepable
+		 * programs and uses tasks-trace-RCU.
+		 */
+		synchronize_rcu_tasks_trace();
+
+		bpf_prog_put(prog);
+	}
 }
 
 int perf_event_query_prog_array(struct perf_event *event, void __user *info)
-- 
2.34.1


