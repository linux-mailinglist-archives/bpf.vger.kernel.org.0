Return-Path: <bpf+bounces-47727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA7A9FEC88
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 04:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467C71882F78
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 03:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC9C2114;
	Tue, 31 Dec 2024 03:32:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF7E22338
	for <bpf@vger.kernel.org>; Tue, 31 Dec 2024 03:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735615962; cv=none; b=GnYzG9xQDIo36q+4M/DVRJAT5OuljL4boFRxLW3L+SoZ2nxfywnxixQZdTkh7fxDyR5Rbsegj4ceoasFIYgHZJmI3F316L3i04KWSGEHOIBsYwlfcaBkerjidk7mU7ayeE6CaAyLRidUE0jJK6zhllDGKebBH6FsjpKyuu5Dib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735615962; c=relaxed/simple;
	bh=RyJYAHduaHEYk7xk6iqEAkjXkeKoha6H8AForLjCJ3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dkmk1r6+kmeSlQjeEIR8grdu5Sgq0UeBLyMxDk8wWgwViV3DdsAAADRLAVHVORW/lT+qTHImB/LA/khoeG4711Oiv21F8XTIGKFCSsmws5GauHSC4qyGe8B4kmdH3+eEeAXZrL4+y0Aa3N/2LXcoXS1JLadOZ2NJA9H98RbcpxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YMdnd110Nz4f3jt1
	for <bpf@vger.kernel.org>; Tue, 31 Dec 2024 11:32:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E593D1A0CDA
	for <bpf@vger.kernel.org>; Tue, 31 Dec 2024 11:32:35 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgD304fSZXNnpCR6GA--.61535S2;
	Tue, 31 Dec 2024 11:32:35 +0800 (CST)
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next] bpf: Move out synchronize_rcu_tasks_trace from mutex CS
Date: Tue, 31 Dec 2024 03:35:09 +0000
Message-Id: <20241231033509.349277-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD304fSZXNnpCR6GA--.61535S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW7KF4rWr43KrWxAry7Jrb_yoW8ZrWkpF
	4DC3s8Kr4UWr4jqw1rXrn7C34UA3ykX398Ja1UGa4rurWYgrZYgF1DKFWYqryF9rWxGFyI
	qw1jqr17GFWjvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
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
 kernel/trace/bpf_trace.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 48db147c6c7d..30ef8a6f5ca2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2245,12 +2245,15 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 {
 	struct bpf_prog_array *old_array;
 	struct bpf_prog_array *new_array;
+	struct bpf_prog *prog;
 	int ret;
 
 	mutex_lock(&bpf_event_mutex);
 
-	if (!event->prog)
-		goto unlock;
+	if (!event->prog) {
+		mutex_unlock(&bpf_event_mutex);
+		return;
+	}
 
 	old_array = bpf_event_rcu_dereference(event->tp_event->prog_array);
 	if (!old_array)
@@ -2265,6 +2268,11 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 	}
 
 put:
+	prog = event->prog;
+	event->prog = NULL;
+
+	mutex_unlock(&bpf_event_mutex);
+
 	/*
 	 * It could be that the bpf_prog is not sleepable (and will be freed
 	 * via normal RCU), but is called from a point that supports sleepable
@@ -2272,11 +2280,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
 	 */
 	synchronize_rcu_tasks_trace();
 
-	bpf_prog_put(event->prog);
-	event->prog = NULL;
-
-unlock:
-	mutex_unlock(&bpf_event_mutex);
+	bpf_prog_put(prog);
 }
 
 int perf_event_query_prog_array(struct perf_event *event, void __user *info)
-- 
2.34.1


