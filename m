Return-Path: <bpf+bounces-67142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD53B3F579
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 08:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54651A83E28
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 06:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC8A2E3AE3;
	Tue,  2 Sep 2025 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp9O/VwC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7307932F743;
	Tue,  2 Sep 2025 06:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794591; cv=none; b=F4GL/TQ5WWlxvMElm1wgA4nhLxLVaCYUJALbXM5mgraRwoNbYZU6S9o2MNvyaR2q7p7sxIs3nLLJs3Ag7UUXDFatRPFy+aPQxi/oBKezY3bgvBetnq1To0krEyGLlDxTl7NX1qCmMdtlJCqeUGQhK4ayVnUwcuGlzwURrwDhICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794591; c=relaxed/simple;
	bh=UK5vFoDixW+pa/nYeUJpufo6atQ70w+vMke9EfX3kUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pbEumjB5dM9A6WnZNZQ3SRNs0OhHYzDU/CN/xBOcBhLS97UFbZV5oRIkV5538OLKnCeZn3SsNLHNNpfetOmgXwtl777cmFOb3H1aiwoquc3tEAlinamVBqYmT5a9XWieB6HXMcJRw7vPl+8PiMcpl4bTNuAyLnwa69vRlx3fUI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vp9O/VwC; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77238a3101fso1851098b3a.0;
        Mon, 01 Sep 2025 23:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756794590; x=1757399390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RNOyyPpyvUOWymFCI905294N8UhshYAkdPsadCOYhYE=;
        b=Vp9O/VwCUA9SIAlXCgPhxa9B0GgrHo63DlCmdGuuBuuVbLcYFz0jN27B5npXMTyoW+
         GnV6DLD+L+TJgRlJjDHmcySEoC+/mg3F2JLHnKe38DTjTCkNC+a3EjDXGtEt35iAuEpo
         u1dJjHFAHI1F+NXdKEQ8SbbVmSAabD6/r1bcIhszi04+mT2bRwiOOdtvSvjWgRv03S2M
         nBhABiFRi0rhBlX+HWbv9oiyiyt8Sgz79/7/Rt3ATmRcCyqse/Fo5DUlviIF01drWyj+
         hGXkIDgSaPSP/6Icugy/SDOyQT5DRmdQKIlvY2B6A0q7W3Hz40hYeP6lkolHZd9DtSKI
         dFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756794590; x=1757399390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNOyyPpyvUOWymFCI905294N8UhshYAkdPsadCOYhYE=;
        b=e2irqegjjJ5zWeJstr5rfGxxfaupB4yQIXUAjANcPSa91wdsxKu1Lbe39XgT2+GtSM
         FU2bnMNmtHf2cij/c+ogiK3BR9mJLdP5ByG0G9MfrNq997B1NM2J+vuC5YqXVWaW+iQU
         LlTZQx33uNvLyedgM2j97j+FIoyxNWZeI3Ya+hBeqPzMMP2dRHKK3e2MJj0TuH3NDhAC
         f38pEhPzFr4D3leatAWznDyWh33lP9fMybPJugcshvMhJygseXqRI9oao7I0u9ZK7zXF
         d6YeMmKDKSCcPQZDBkYHClG4GSHu6jo0Aha9w4Oh/ypsqjoleDrDKfdjaK+Ib+Pv6zIO
         PGEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfj9zuJKM4ynShi10YRp4kl5gyMdVYEC6I8b/PWZkUHzHHCTXnPs3ntE3Y48/SD0yGbHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEsjIFA+Fp4aK2HM5/xj+9UJm43xz8BYOQe6A8Nt0OBJ5Juirq
	lT08c3E0OKXAvssDVDAvzo/nCipRiw5/4k1/PoiAeXTcZjZ+C5f6jyxo
X-Gm-Gg: ASbGncsm+bceK8e6f3f8ufUIyEmPtftLMyfi7TFvGeZp7lcZ8Wc77eqVuHq6Rl9dCTt
	f4Qf9kuiji7WC27bGIYjuebQfuj3vCQXzu179qnx1lWHWs9LPfMC1+XXj2Shl4NKwKKmXWbG8Y0
	MsCTq3dKUXZ4Vt7X/wr8VG7klLKqRMIv9ET+BGMu2jBIxKdJQazkZUe/LHERcCOlSX5Ge3YL2Ed
	pgRr84q8QmSDfGmlmg0M9nH8T+NWDW8zhEkYcqmWE6mULwxzM+eUsQ87kSvBMzai4x0WTe3tqqc
	wmpAsfCLzlO8Fu4UGw9EhuSNX/HVHkZVdZa25NGgInHaFp+do1YCPEpSgIAVGuRL6dpd/Tr98LD
	Aj0+pxbAznSKGKfTV9iz9I7Bb4LkaU2pYlZnJB4wXWp5EfgDdYwiNYSczbNUTZmQNHB4KL0WdA8
	PqHDxHp8vJ
X-Google-Smtp-Source: AGHT+IGpbtWsp+Mm/S48jCR6WqRD9PeJ1vXrRe/i0losym/wKIvIDEFhe81JpBAm2YjMZtF3X56FTA==
X-Received: by 2002:a05:6a00:1d9e:b0:772:4e7f:8106 with SMTP id d2e1a72fcca58-7724e7f87f8mr7686637b3a.16.1756794589591;
        Mon, 01 Sep 2025 23:29:49 -0700 (PDT)
Received: from localhost.localdomain ([101.82.213.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26a0b3sm12641236b3a.10.2025.09.01.23.29.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Sep 2025 23:29:49 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	daniel@iogearbox.net,
	bigeasy@linutronix.de,
	tgraf@suug.ch,
	paulmck@kernel.org,
	razor@blackwall.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 next-next] net/cls_cgroup: Fix task_get_classid() during qdisc run
Date: Tue,  2 Sep 2025 14:29:33 +0800
Message-Id: <20250902062933.30087-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During recent testing with the netem qdisc to inject delays into TCP
traffic, we observed that our CLS BPF program failed to function correctly
due to incorrect classid retrieval from task_get_classid(). The issue
manifests in the following call stack:

        bpf_get_cgroup_classid+5
        cls_bpf_classify+507
        __tcf_classify+90
        tcf_classify+217
        __dev_queue_xmit+798
        bond_dev_queue_xmit+43
        __bond_start_xmit+211
        bond_start_xmit+70
        dev_hard_start_xmit+142
        sch_direct_xmit+161
        __qdisc_run+102             <<<<< Issue location
        __dev_xmit_skb+1015
        __dev_queue_xmit+637
        neigh_hh_output+159
        ip_finish_output2+461
        __ip_finish_output+183
        ip_finish_output+41
        ip_output+120
        ip_local_out+94
        __ip_queue_xmit+394
        ip_queue_xmit+21
        __tcp_transmit_skb+2169
        tcp_write_xmit+959
        __tcp_push_pending_frames+55
        tcp_push+264
        tcp_sendmsg_locked+661
        tcp_sendmsg+45
        inet_sendmsg+67
        sock_sendmsg+98
        sock_write_iter+147
        vfs_write+786
        ksys_write+181
        __x64_sys_write+25
        do_syscall_64+56
        entry_SYSCALL_64_after_hwframe+100

The problem occurs when multiple tasks share a single qdisc. In such cases,
__qdisc_run() may transmit skbs created by different tasks. Consequently,
task_get_classid() retrieves an incorrect classid since it references the
current task's context rather than the skb's originating task.

Given that dev_queue_xmit() always executes with bh disabled, we can use
softirq_count() instead to obtain the correct classid.

The simple steps to reproduce this issue:
1. Add network delay to the network interface:
  such as: tc qdisc add dev bond0 root netem delay 1.5ms
2. Build two distinct net_cls cgroups, each with a network-intensive task
3. Initiate parallel TCP streams from both tasks to external servers.

Under this specific condition, the issue reliably occurs. The kernel
eventually dequeues an SKB that originated from Task-A while executing in
the context of Task-B.

It is worth noting that it will change the established behavior for a
slightly different scenario:

  <sock S is created by task A>
  <class ID for task A is changed>
  <skb is created by sock S xmit and classified>

prior to this patch the skb will be classified with the 'new' task A
classid, now with the old/original one. The bpf_get_cgroup_classid_curr()
function is a more appropriate choice for this case.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Thomas Graf <tgraf@suug.ch>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/net/cls_cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---
v3->v4: describe the scenario where the original sender's classid could be
        modified. (Paolo)
v2->v3: update the commit log (Nikolay)
v1->v2: use softirq_count() instead of in_softirq() (Sebastian)


diff --git a/include/net/cls_cgroup.h b/include/net/cls_cgroup.h
index 7e78e7d6f015..668aeee9b3f6 100644
--- a/include/net/cls_cgroup.h
+++ b/include/net/cls_cgroup.h
@@ -63,7 +63,7 @@ static inline u32 task_get_classid(const struct sk_buff *skb)
 	 * calls by looking at the number of nested bh disable calls because
 	 * softirqs always disables bh.
 	 */
-	if (in_serving_softirq()) {
+	if (softirq_count()) {
 		struct sock *sk = skb_to_full_sk(skb);
 
 		/* If there is an sock_cgroup_classid we'll use that. */
-- 
2.43.5


