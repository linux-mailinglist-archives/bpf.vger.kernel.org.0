Return-Path: <bpf+bounces-68915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489F3B8823F
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 09:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5E65800EC
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 07:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36C32BEC2B;
	Fri, 19 Sep 2025 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Pq7cfChK"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8A275112;
	Fri, 19 Sep 2025 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758266410; cv=none; b=bco63NPPDZKxwaDEHumzy0gKUa/0wEJb/nwVGzxZtRNWLPu0SnWXa/DoJ/aLCywzmfQQVdjtWXtKuZRmqsw8aHHsDPJ3XDdZ8a5z/1uBRMsTBVpJAxha82dpfHeLGy9mBRfwe2F/rmnIUYXtOS//ACpZla+64ep420/iT9B0bZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758266410; c=relaxed/simple;
	bh=b6Tw3mttVPfCDgGtYbSaC/pZphbcciOixdTxHxNmyqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VLOkc2LI6BEJlfPLX5pRCdot94c+0qbu4gtjrHHOG+ndclBovUIj3EEDDvZ64U3uL2NIFA6EtBmNEvrPrjwLsoqn2AQ+w1IstopcksX6K1aL+nYGZ8OX9gORf/bzDA+1UOJvMQSM+0eLnf3Ole8uOIs3jHNQRiyc94wbP6hxnzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Pq7cfChK; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=MU
	L1gPQPoyj/ZgGBhJEEFe6Bn2eA41tvMvWxnkv0EIU=; b=Pq7cfChK2PIDayrf7p
	7HknrJMWIl/u8kfWKGp7MbqaZ5hvgvPNfxVlTxWL4iUAbf81CzIqHai7jD9xA+cD
	t3kJh3WDhc9npGQ8ezsM7nfhQ3IhgfOy091/icAxIyxEEYzrxGdLPbQ5H52DGUIE
	PHyAN65PS3gY2+xOlqr3tAXd8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAnJDXmA81oI1x_Dg--.54587S2;
	Fri, 19 Sep 2025 15:19:04 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org
Subject: [BUG] Failed to obtain stack trace via bpf_get_stackid on ARM64 architecture 
Date: Fri, 19 Sep 2025 15:19:02 +0800
Message-Id: <20250919071902.554223-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAnJDXmA81oI1x_Dg--.54587S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7try8XFy8WFWUWry8JF18Krg_yoW8ZF4Dpa
	sxZa4akF4rZw43tFW7Ar45XF1Svrs7ZryUCF1rGr13CF4DX3y8JF1xKFW2vFn8urZYg343
	Z3W7tFy7K397Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtcTLUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbipRHJeGjHvNu7WQABsu

When I use bpf_program__attach_kprobe_multi_opts to hook a BPF program that contains the bpf_get_stackid function on the arm64 architecture,
I find that the stack trace cannot be obtained. The trace->nr in __bpf_get_stackid is 0, and the function returns -EFAULT.

For example:
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi.c b/tools/testing/selftests/bpf/progs/kprobe_multi.c
index 9e1ca8e34913..844fa88cdc4c 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi.c
@@ -36,6 +36,15 @@ __u64 kretprobe_test6_result = 0;
 __u64 kretprobe_test7_result = 0;
 __u64 kretprobe_test8_result = 0;
 
+typedef __u64 stack_trace_t[2];
+
+struct {
+       __uint(type, BPF_MAP_TYPE_STACK_TRACE);
+       __uint(max_entries, 1024);
+       __type(key, __u32);
+       __type(value, stack_trace_t);
+} stacks SEC(".maps");
+
 static void kprobe_multi_check(void *ctx, bool is_return)
 {
        if (bpf_get_current_pid_tgid() >> 32 != pid)
@@ -100,7 +109,9 @@ int test_kretprobe(struct pt_regs *ctx)
 SEC("kprobe.multi")
 int test_kprobe_manual(struct pt_regs *ctx)
 {
+       int id = bpf_get_stackid(ctx, &stacks, 0);
        kprobe_multi_check(ctx, false);
+       bpf_printk("stackid: %d\n", id);
        return 0;
 }

./test_progs -t kprobe_multi_test/attach_api_pattern
#155/4   kprobe_multi_test/attach_api_pattern:OK
#155     kprobe_multi_test:OK
#156     kprobe_multi_testmod_test:OK
Summary: 2/1 PASSED, 0 SKIPPED, 0 FAILED

cat /sys/kernel/debug/tracing/trace
test_progs-68315   [004] ...1. 13377.097527: bpf_trace_printk: stackid: -14
......

Test Version:
6ff4a0fa3e1 ("bpf, arm64: Call bpf_jit_binary_pack_finalize() in bpf_jit_free()")
Linux localhost.localdomain 6.17.0-rc5+ #2 SMP PREEMPT_DYNAMIC Fri Sep 19 10:29:07 CST 2025 aarch64 aarch64 aarch64 GNU/Linux
clang version 17.0.6 ( 17.0.6-30.p03.ky11)
gcc (GCC) 12.3.1 (kylin 12.3.1-62.p02.ky11)
GNU Make 4.4.1


