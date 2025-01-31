Return-Path: <bpf+bounces-50233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE0FA24357
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E00168792
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934751F37AD;
	Fri, 31 Jan 2025 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed1dTr87"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30AA1F37A2;
	Fri, 31 Jan 2025 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351778; cv=none; b=PIFzhKFZiRTMhtHHkz9bJvglEp0Eq0DD9CuVt9BkwwFUru6WzVrIlLqp45IYAEAcnoI7HHo5Mz11Tz8DqXia2uy3BUquDvhWZ/sIHsAJULPe3HOuE8cfOp98+x7DEuJAs0X4LSuv9RTpITOWzkj78w6ElMzK8FhgobcJHP1UACs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351778; c=relaxed/simple;
	bh=9j9ayn9vddtSbb5PDOLCF9fL7FXTV/IwE8oNGDcu+/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmUmygMa1KzUYXXHLgjChfArCPDieBs8iziz79fZ6m5C0VKTLlpdJ4Res4b/AwXSO5E+v8bysDBTAX4nfzLpJGA64oWkP/LIjdZQO9DqkKGGL3gjIsBwF+mI8/MuvT5z2LtJ9AihoKxpDDnMjbOwuRoh/ME1+3ZykkWeW0wG+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ed1dTr87; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso3239358a91.3;
        Fri, 31 Jan 2025 11:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738351776; x=1738956576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeQdpMyy6nDYQ4+R5zYQB6sZCeY7xrydRKRRjxE/p3M=;
        b=ed1dTr87rKoCI+pr6JIVyd8giFnwgecnsHktMqT7joBQFBGWW+RTBfNZNMsk+StS8I
         uEQ83xYATr7D4UhX6HYSgpAZ+KlDw5vRP1JSiuOzMGitKfaMQ1P9pol0oit3SUgBPG2p
         MOWbzFthljrYXl8tbwzKeABDceJxRjR97PbbFjCsYfhFahFl2vxtZSvbJSvKg+HBWvd/
         /3BCvpw9HfWuJN9rAou91nDYU+bzU+x1kEd/7byzd1lCUTHqBHHOC50VuXXaPCRuEv0u
         d3WndHVEoqKyRAeS+1a2IB9s2fvoa1G1iI6MjPdI3BBAWY80TbtRvWVzvKDdmOYXJxL6
         pN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738351776; x=1738956576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeQdpMyy6nDYQ4+R5zYQB6sZCeY7xrydRKRRjxE/p3M=;
        b=HwyCUNXMUgfjs1r9pUuJ0R1nDcYvF2uN6cdrXFshMNcLo9j/9UVDdzKh6XvuGtbZxd
         nLLwOS62/2KUiWd9sOYjmnvRVHyzGLUU8zQgAfCTV9PeR5ga4WBllPT1tH7OQRxkSdhp
         TqC13f5l6QowCjhJH2ALFYNbT2MIkgBrua7lKWh563U9afkgOHTNMjlrdr4fvDQUCTVC
         T+4AWZ4tl3EBu5/J7b0xkDrPowdc5tYUcLdRfdQfKhwQV6Zb+YvFgaNqZH+VVNHzZcNr
         7ep2UiKH6zmnVcsGCoeHJToBddGvGoDbU0T3KFDUV4qvhF35QEfmsM5cThFuBRBGPFNe
         N9aw==
X-Gm-Message-State: AOJu0Yx9+96/L0bx8KXLoil65EleeHMNtM6A6fgb1TqMA6uaD+vCJHpH
	VV69RX6VpKWg0M9yDhsw2MdCHFh260d8iDLm501mTdJLS3naRRGsV05Qy3/ln+U=
X-Gm-Gg: ASbGncvwYLXB618h55Lbu01YspM0sLz8BgIxb9TLRMpuA5yG4ngiUKVznvjRSLuxhof
	429FQFNZxCGAwZ5XMH6fT5JY86n6LGYpAp/jBy2Z7DRY2cxKD/CcPryBjog7hHGyVDuPossClH/
	mVl7FkOuXC0sQ08Etm4MJ6SwXQlUu3B784PTkpEf/6JmD3kTbZi8K9ydBGsMawoy1CcAanglwns
	1Dmphs3HNp8ypR8yWGNVG6sgGk6k+VP9CYLRFyfAJKeOr02zhCiA+HQ9uLJ/b9YahTUcJm7n1hq
	hdgAWKMBfPZk7BjPjJHbghBqondnCdJNcvv6wNi6f0MUJ4L9B3J2bdwexwtUrtuVsg==
X-Google-Smtp-Source: AGHT+IGLnp8kodW3NTulgGNV/t+SlNdynQwACA4YDsKRevCUawfcq1NaCpLJNnBArga9rD81fAjTpQ==
X-Received: by 2002:a17:90b:5410:b0:2ee:96a5:721e with SMTP id 98e67ed59e1d1-2f83abdf0e5mr20817604a91.12.1738351775679;
        Fri, 31 Jan 2025 11:29:35 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d3707sm4072471a91.23.2025.01.31.11.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:29:35 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	cong.wang@bytedance.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	ming.lei@redhat.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 12/18] bpf: net_sched: Support updating bstats
Date: Fri, 31 Jan 2025 11:28:51 -0800
Message-ID: <20250131192912.133796-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131192912.133796-1-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Add a kfunc to update Qdisc bstats when an skb is dequeued. The kfunc is
only available in .dequeue programs.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 net/sched/bpf_qdisc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 5abf11aa8340..1f2819e41df8 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -213,6 +213,15 @@ __bpf_kfunc void bpf_qdisc_reset_destroy_epilogue(struct Qdisc *sch)
 	qdisc_watchdog_cancel(&q->watchdog);
 }
 
+/* bpf_qdisc_bstats_update - Update Qdisc basic statistics
+ * @sch: The qdisc from which an skb is dequeued.
+ * @skb: The skb to be dequeued.
+ */
+__bpf_kfunc void bpf_qdisc_bstats_update(struct Qdisc *sch, const struct sk_buff *skb)
+{
+	bstats_update(&sch->bstats, skb);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(qdisc_kfunc_ids)
@@ -223,6 +232,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_qdisc_init_prologue, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_qdisc_bstats_update, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(qdisc_kfunc_ids)
 
 BTF_SET_START(qdisc_common_kfunc_set)
@@ -238,6 +248,7 @@ BTF_SET_END(qdisc_enqueue_kfunc_set)
 
 BTF_SET_START(qdisc_dequeue_kfunc_set)
 BTF_ID(func, bpf_qdisc_watchdog_schedule)
+BTF_ID(func, bpf_qdisc_bstats_update)
 BTF_SET_END(qdisc_dequeue_kfunc_set)
 
 static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.47.1


