Return-Path: <bpf+bounces-66266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14576B30F63
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 08:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5471AAC7335
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 06:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69352E62DC;
	Fri, 22 Aug 2025 06:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMm5E5af"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E183D27B335;
	Fri, 22 Aug 2025 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844938; cv=none; b=nJ8mpfwSq/KV3NlywTyx+thLXRLQOh99fhEzNHvrYanfiapVBc4TT17iHyxS94ro+m3yIGCWJITKbDDM2D5oKMASU7lyuDdsRy3/YaM/0SiBAOS1xfRpJH7jPe+TQ17VlCU4o6JzLG2JI71HaXHHdcTB5Y12oeFC1gqJ1649Pa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844938; c=relaxed/simple;
	bh=iXpYXCN1x34lZ8VI9aiuqMvXMDjQvQQHN3G+RjXOopw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jNDBgAK7DxfC6rbeTQRUKHV7witBHHo85lWOkjhmy+8mkNUo5EGMsXN2igCvbxGEmATO2lD3XXdDpm4AHG9NGR6gxnelWtPEQndiE1I4SS2vC1x6TUZN0rhED7Ik6n7stYK9KqD0z3q92sSpJKYl7SONP/xhE9z69MLHwPlMZJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMm5E5af; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-324e7600bf0so1837125a91.0;
        Thu, 21 Aug 2025 23:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755844936; x=1756449736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zognEqlh8xhTAIdT4lPPmGYK0eu8rF8ErUK8aPMoM8o=;
        b=CMm5E5afxrax4TLeC8+hN+mjE12BMuWTb5oUW51RD+Wbuh/trHCfMLanVnTX6IuNpz
         HA3v499GXf1Wl06+cN3rHt3K2GyWX5aUfJCpKiw2AWlxPEuAFxlEDH7IQJSRWG4MAI2d
         b0MXcHK//7U1Ldp7qyqcA5T8iz0pQDfivxhp9j47nyysznsY9WdrIBHPJgU2YnFsy2Eq
         C8KvCZOVjPIXUu4/LW7e2wHQw1oZqkcDk6d/WM2CYrOi7Ff/O0BYm45hfT9PJfl9xXf4
         zPHVMZjCJoZlvMmGLgt9N8nBDqtuf3BiJlTZLUPvGXM2Siwg9mni3XEsJ9VMMuGi1jvk
         0I4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755844936; x=1756449736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zognEqlh8xhTAIdT4lPPmGYK0eu8rF8ErUK8aPMoM8o=;
        b=NTUd6N7a39lF8uhwUb5eN+a4Z1hfh9Q0YIWO3eDKGvMqf2pU0L6wHHgDoT4gxVmFch
         VD2UMyq8kFd0SNSqXe0FpM3XOBTpemwMTAiv8ZTr93pkyDzJJh1lqFbXoNagAfG7KWRP
         9Mhoj4NGU1XxX/kZL3NjmaCUDBpIZckLJYGJvn7kq/d+qIKgBSxH7WbyFB9SPmdQnWPX
         oItg0WROo0h3lwgur2OWwmBWyznCPoMKNJcyaKWiYMyXUZtgfMC4K9VHv9+9un7jBIeU
         rlS9Kue5vpr3nkFTl/OiVqaHpW2bdhbRhP5fCDJm739Mz+fcKANM/lQ+Z3Y0WGRz9/Fd
         hrXw==
X-Forwarded-Encrypted: i=1; AJvYcCUWF2g1PG7QngnBiulSj3AptOaXWfGRHF7EoK+vOpNRhofAbQCNg9Je4zpUqCoSh9Lf7Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNCatFitJVTBUBz9Z3Lox3bykQTaLK5zQx+EszYlzmf4wEX5UD
	ejkmqK/NLbvIEdPC1BVqqXrd/Gqllk6m5FuL+t1YbNdmZLndggzysFBD
X-Gm-Gg: ASbGncs4Lr9FyTlVuEVfHABL+kzM1UMy+3xxgOT9eRHs3QY64F2xfOFbImJ2HKljLwt
	nJ8DmYGuQwq7dMWwFC7oEYfGT4MbnK/zkTNjCA4E3CXfYFqelzrgWzLndXl7v7HXLHZNxoOcVI8
	/TOIh62DEoU6JuLimBCJYcbZD5v9eEq6/utphLd5EfPT0wM7XUh3x2N0XybYTbZCZ32DDy/KSA3
	1rkWf1CFxadJmTv0VcdthLIso3BrZTgRL/2FHaLMyJcHMbebCNMxy7cjJeQk7fjkA94ldnE9MD+
	HkXsJNX2aIh6idwXY3xYSNpVn/5q68nTa7Ev7eSZhq7vA23dWYAvLyPcSn4KnGjJHn14SwdxdIu
	slilBsd+bgZaEVR46uruc9tNFfTF7H/i9V3BUjUNPHzr42Dnqvhr5Tw/GSZtu2JmBhw0Y5Qhk+c
	HFkaw=
X-Google-Smtp-Source: AGHT+IHyySsOUXTk+f5WEVDZbRO5VSTVnfRbuOXZRZb4zcRlBaDoFLGdzXBoKlFwd03ujeu+d3J/4Q==
X-Received: by 2002:a17:90b:4fd0:b0:325:c92:4a89 with SMTP id 98e67ed59e1d1-32515e3cad8mr2586829a91.5.1755844935945;
        Thu, 21 Aug 2025 23:42:15 -0700 (PDT)
Received: from localhost.localdomain ([101.82.213.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-325123e4751sm1532049a91.1.2025.08.21.23.42.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 21 Aug 2025 23:42:15 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	daniel@iogearbox.net,
	bigeasy@linutronix.de,
	tgraf@suug.ch,
	paulmck@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2] net/cls_cgroup: Fix task_get_classid() during qdisc run
Date: Fri, 22 Aug 2025 14:42:00 +0800
Message-Id: <20250822064200.38149-1-laoar.shao@gmail.com>
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

Given that dev_queue_xmit() always executes with bh disabled, we can safely
use in_softirq() instead of in_serving_softirq() to properly identify the
softirq context and obtain the correct classid.

The simple steps to reproduce this issue:
1. Add network delay to the network interface:
  such as: tc qdisc add dev bond0 root netem delay 1.5ms
2. Create two distinct net_cls cgroups, each running a network-intensive task
3. Initiate parallel TCP streams from both tasks to external servers.

Under this specific condition, the issue reliably occurs. The kernel
eventually dequeues an SKB that originated from Task-A while executing in
the context of Task-B.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Thomas Graf <tgraf@suug.ch>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

---

v1->v2: use softirq_count() instead of in_softirq()
---
 include/net/cls_cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


