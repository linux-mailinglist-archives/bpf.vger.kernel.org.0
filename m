Return-Path: <bpf+bounces-66376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C95EB333DE
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 04:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F444189DB28
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 02:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B42B22DF95;
	Mon, 25 Aug 2025 02:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4/5WUCD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7D0610D;
	Mon, 25 Aug 2025 02:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756087848; cv=none; b=V5JdsPOVFQlSbolDyTFubBwCa3Z5j8U/tRVJO6OqB9I59k3zQ3KyZJw9NeaREw/RFAPLwNFb7ZoOTaxxeWZpTuUmjT4YE4yr5kGb2vL5xm9J8dy+W6JP7bKVbqQm/mllT9qu4g61315mbnrko/eZNKZdDdQLvOmrhqqHEg/Gbmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756087848; c=relaxed/simple;
	bh=njPJlR3n/BsJ0/+OvLyjtbaWv7n5QcdZVPMBn1HjR+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sTYj3MpOkoCcM7GuQEQSYWKoxt1E69VoneIat7rKbPS9xK1PURRvI3pHgECts+2Z4Ds70/xNPTdRR4CO/R2xXd3HvOMVrXowm9cH/7r5HgHJVvcJ7FyXjqxL2SO21yjzkir3sK/UeDCCfP9Bq4Zpq6hhvY/xGvUCYl0jru9slA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4/5WUCD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2e6038cfso4230459b3a.0;
        Sun, 24 Aug 2025 19:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756087846; x=1756692646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ccnSqaBNMnJ8DtnJecDUFYqocnmsNSqSvEdNt606FJE=;
        b=g4/5WUCDptVaqJ2bOyPBcYHfgW7fjBY+5eC6ZwYNxZbwLEpBwbypplzhslel0DXpdm
         WweEU+Ye0wG/HrJ+SzjPfPd6Kzbxigbz3EaTl+qXdTlLSGzHZYElQuwjZ+s4m2k7zebt
         SZdpwD9HEBntKSMEKuoL4iam2wrQRdLL0TUMrqzFkg+X3s2//jJKSuk7mp8wB0g+n5th
         jtDU5EQAyt0aRpTtsIwyW1QnQbqhRjaPouh1S74mc7RsrVeHpttIuXiXIyssRUGF7iiN
         sLOe8bWAb2dzQRE5bqPQ62BuSF+O/J2CHzOMd5rnknXolzHnoQZa+HuiRB/qWV222Yrn
         x+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756087846; x=1756692646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccnSqaBNMnJ8DtnJecDUFYqocnmsNSqSvEdNt606FJE=;
        b=tGrzRsFnMw9iUzGYVZIagBlgQrbCiFy9qPxiJ7hE6mg4bk1CWuEgcqLMhO+rvdHzLd
         6K4dLnwjKRxNhKHC3hvwIC3s9FuBO6vf9fiyyqIRRPhQvuW8eKxZLOl6bEO9d52nhk0/
         P+CG/mHqE4gbbxYxnH7fIcdHgdERi/vIZvRICrY0ackKn5pWEIYzX264pZka4gL7DGds
         UbQ4z09uQ+gJMtUrO45+K9E3z2aU3CSfSPNUXX2ULuGw6NuzpQ/9VUkcHhyOyjE30Kdo
         cUOyd40kPkk+Sb5pIq3PpmUkQHq3URgsjEEfQHmwGHjOnMVqkJdA7ZREqdt1h5aYA2mg
         5H0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdkP2CcBAAVKW7V6BEgHKGog0CEl+KZ6bqN1FhywV65LmTJ7FiV4dLRmE0fHHXesR7KCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwRBp8Q1a9M85ZMfQnyAL7m/i8a2ZkRb513eeFZ4rYUaMMXHOI
	H78MabJX/EwVXHAJDMpjE0Gp/Fz8v6btN/JVoB9tY5AU7ZZLrl6Q0Zf/
X-Gm-Gg: ASbGncvq1JnqIovGmzs8V7Jz4xEpeASWC2Aja6RF6esWnmXTVx2nLn7MTkYFvhXbXM7
	MRcrMarZer54IYMH3FYstYC8rDYhZyc73NVm1zbYYEQv0lywgnTgITLY/YBfHUgeI3AR8KURtJi
	gGBaAK6ixheHP3aUU1eU1Hb7/9HiXws2l1/QV4LS22DXTnot+2SHlnu+RQPFQZlbO4xWATkDIcG
	fgBShsiGn24/neDHTX9RDkafhZDGS5r1oLdWw01qqEPONAtDYsJ1qdYQGq1/dxkxNcP0GvI2+w7
	b/hxW0drnGJTqVCM1dSbAIXGzLJxZ6THSUUbIrgkFXF7850cs5qKGKz7Gg5FrcKp/VFP1i8aGGK
	la83eQnY0cTJSoBu2vhMtf4ml7dHwBeXvHiFOIskpZDPqJ40/UiUjbhyOZz0AxO3VHfVybLbzhq
	1krDA=
X-Google-Smtp-Source: AGHT+IEQTK5LGVKY8tKEoD8uMRjwoHvbmPExeCTOhhPu5K5+tB8mCK6erOXpGL/UtAfJMdwHC1CLHg==
X-Received: by 2002:a05:6a00:1909:b0:74e:ac5b:17ff with SMTP id d2e1a72fcca58-7702fa5e6e0mr17531448b3a.13.1756087845818;
        Sun, 24 Aug 2025 19:10:45 -0700 (PDT)
Received: from localhost.localdomain ([101.82.213.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770402290d1sm5761537b3a.101.2025.08.24.19.10.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 Aug 2025 19:10:45 -0700 (PDT)
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
Subject: [PATCH v3] net/cls_cgroup: Fix task_get_classid() during qdisc run
Date: Mon, 25 Aug 2025 10:10:33 +0800
Message-Id: <20250825021033.27435-1-laoar.shao@gmail.com>
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
2. Create two distinct net_cls cgroups, each running a network-intensive task
3. Initiate parallel TCP streams from both tasks to external servers.

Under this specific condition, the issue reliably occurs. The kernel
eventually dequeues an SKB that originated from Task-A while executing in
the context of Task-B.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Thomas Graf <tgraf@suug.ch>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Nikolay Aleksandrov <razor@blackwall.org>

---

v2->v3: update the commit log (Nikolay)
v1->v2: use softirq_count() instead of in_softirq() (Sebastian)
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


