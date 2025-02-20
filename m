Return-Path: <bpf+bounces-52044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92FFA3D04E
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 05:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982A83BA8F1
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 04:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB161DE3CA;
	Thu, 20 Feb 2025 04:11:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB9419D067
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740024661; cv=none; b=bGUfd5FXv/8d2cgtXuUOsYrq14qC+zNIm7Jm+bl6M241OA39K+wcE9oUY5MYLxf7S2pi4GcbeHjg1zjdcrF0S997RmB0iFkk5I09UBA8szrvtE9Ysapr66pUHwKu/KQVzR4vG/JuCNeEcNXinSb05AXrpJsH1DdQtA/vu2+NjYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740024661; c=relaxed/simple;
	bh=rAJiTr9LHB3H8hKcZBMz7Cb3QtUgY5mKRbovgIi5l+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IdSiWpe0EKQ7miMaAyR7Li9p4OLQ+j3c0w6IoDSolzssk18L6AILcQDFqgbD12E+d0kT6duxolbCTSwNXuJO8vaJR9VycCzzs3ZO73E22Y+nBNwS3aWNVk6Zr3OO8baUm62ZGOSRzYIqCMgmD11j09ihqfGkF1ZyGutsaEq0SmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Yz0DF2xXlz4f3jt4
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 12:10:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B69701A0194
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 12:10:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl9Jq7ZnxgNtEQ--.52521S4;
	Thu, 20 Feb 2025 12:10:51 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf] bpf: Use preempt_count() directly in bpf_send_signal_common()
Date: Thu, 20 Feb 2025 12:22:59 +0800
Message-Id: <20250220042259.1583319-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl9Jq7ZnxgNtEQ--.52521S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyxXw4xKryxuFW8XFy8AFb_yoW8WF45pF
	4xXr92kFWxJa1Yqw4jyw4kWFyUAan8X397GFnxGw4fJr4DXr4rWrsFgr42qF4Fgr9xXr93
	Zrn29rW0vw48u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUFku4UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

bpf_send_signal_common() uses preemptible() to check whether or not the
current context is preemptible. If it is preemptible, it will use
irq_work to send the signal asynchronously instead of trying to hold a
spin-lock, because spin-lock is sleepable under PREEMPT_RT.

However, preemptible() depends on CONFIG_PREEMPT_COUNT. When
CONFIG_PREEMPT_COUNT is turned off (e.g., CONFIG_PREEMPT_VOLUNTARY=y),
!preemptible() will be evaluated as 1 and bpf_send_signal_common() will
use irq_work unconditionally.

Fix it by unfolding "!preemptible()" and using "preempt_count() != 0 ||
irqs_disabled()" instead.

Fixes: 87c544108b61 ("bpf: Send signals asynchronously if !preemptible")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
Hi,

I had reported the problem at [1], however, it seems it got lost or was
ignored. Therefore, I sent it out myself.

[1]: https://lore.kernel.org/all/94fcfa71-51c1-2130-3452-ec58aaef94d0@huaweicloud.com/

 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 71c1c02ca7a3e..2e6b525904d31 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -842,7 +842,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type, struct task_struc
 	if (unlikely(is_global_init(task)))
 		return -EPERM;
 
-	if (!preemptible()) {
+	if (preempt_count() != 0 || irqs_disabled()) {
 		/* Do an early check on signal validity. Otherwise,
 		 * the error is lost in deferred irq_work.
 		 */
-- 
2.29.2


