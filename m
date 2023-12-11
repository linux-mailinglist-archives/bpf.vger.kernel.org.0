Return-Path: <bpf+bounces-17383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8359F80C34E
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 09:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369D41F20F33
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 08:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4BD20DE2;
	Mon, 11 Dec 2023 08:33:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDB9A0
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 00:33:47 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SpZlW5JtCz4f3kKH
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 16:33:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E64C71A0B7B
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 16:33:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCnqxFlyXZlGf5bDQ--.5149S4;
	Mon, 11 Dec 2023 16:33:43 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v2] bpf: Update the comments in maybe_wait_bpf_programs()
Date: Mon, 11 Dec 2023 16:34:47 +0800
Message-Id: <20231211083447.1921178-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnqxFlyXZlGf5bDQ--.5149S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1xuw1xWF1rWrWDZrW7XFb_yoW8ur4rpF
	ZIk34UGrs8Xrs2kw1qg3y8Z345tr95Gw17Gr1rKryFy3W3Wr909ryfKa15uF1avrs2grWI
	vryvyF9agF45ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Since commit 638e4b825d52 ("bpf: Allows per-cpu maps and map-in-map in
sleepable programs"), sleepable BPF program can also use map-in-map, but
maybe_wait_bpf_programs() doesn't handle it accordingly. The main reason
is that using synchronize_rcu_tasks_trace() to wait for the completions
of these sleepable BPF programs may incur a very long delay and
userspace may think it is hung, so the wait for sleepable BPF programs
is skipped. Update the comments in maybe_wait_bpf_programs() to reflect
the reason.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
v2:
  * Don't handle sleepable BPF programs due to the potential long delay
  * Update the comments in maybe_wait_bpf_programs() accordingly

v1: https://lore.kernel.org/bpf/20231208102355.2628918-8-houtao@huaweicloud.com/
  * Handle sleepable BPF programs in maybe_wait_bpf_programs()

 kernel/bpf/syscall.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0496b78b80f7..3fcf7741146a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -142,9 +142,13 @@ static u32 bpf_map_value_size(const struct bpf_map *map)
 
 static void maybe_wait_bpf_programs(struct bpf_map *map)
 {
-	/* Wait for any running BPF programs to complete so that
-	 * userspace, when we return to it, knows that all programs
-	 * that could be running use the new map value.
+	/* Wait for any running non-sleepable BPF programs to complete so that
+	 * userspace, when we return to it, knows that all non-sleepable
+	 * programs that could be running use the new map value. For sleepable
+	 * BPF programs, synchronize_rcu_tasks_trace() should be used to wait
+	 * for the completions of these programs, but considering the waiting
+	 * time can be very long and userspace may think it will hang forever,
+	 * so don't handle sleepable BPF programs now.
 	 */
 	if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS ||
 	    map->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS)
-- 
2.29.2


