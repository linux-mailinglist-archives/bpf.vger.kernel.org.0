Return-Path: <bpf+bounces-51019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2870A2F597
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619D3168F5E
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9676425A32B;
	Mon, 10 Feb 2025 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSTlrHXv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B791F2586F3;
	Mon, 10 Feb 2025 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209443; cv=none; b=l8d2b+X+X4DzgeaSWCFJv7/y8czG2DovCVyU5FiZ7ZJR0muzhnmoG5hxOGjaPw5JxYLK5dUHf9FEwCxb4KS0Vhq1tTkUjbjh5RK8R2CYw9XVVtL3XbfM2KEC/jhYR7nD1LiJv7bgeoZuVAmA5/FcLghF282CDR54dmISCOD+76A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209443; c=relaxed/simple;
	bh=PvsjZwquHBtkiD0ex5OqAaIb81/a5+rvsxROvzoxNf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLyuxYORHms2A+jYNchZ6IxWVaJG6aNaSknvBN1DRWPohM9b+DnfIOSoCUep+mMOYjHRtBtjfWkoxRTpwnlA+qY0d2grWMWVciaA6Rz7tZf3I4LXhzIuIYwSI9W/IeIQUTbcf3HJi2mVTMGQ0kKE4SE0Uhqf1f2l8Vdg1Jshd88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSTlrHXv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fa7465baceso2518728a91.0;
        Mon, 10 Feb 2025 09:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209441; x=1739814241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jp4xQH7m5lEMdSS67IiNyx4buTe0VVGMGzphEL5Q8YM=;
        b=PSTlrHXvcMz/sCbM9cjQUV6IuoKgxUG28IoTPUXtHxcX8Gx4x8OFXQ1Te0gw13yXHe
         DKqFthpl538C2P6AtiWEhWPkBwMUgzIHz/na8h2PyvNo/FVfwbNfbkfE+rSTqRwS5jHF
         2CMWZoWmFl/6c1HAdteu6XPnY2d+fb8nxIFyP9wdkUNma6JuKizRRA3l4VOxmri2octP
         GdVYMzotbqrmwtLvz2Kzf+UuyVDRwOiP1K0ZRJE5OuvqOnHG47e7bQbxvXMRO0K02+Vf
         P5m6lAOGRuJgh3RrJ4hlfP3qVxmexmV+aJRpfMYD1BqZ9FP7NVOmlfVkkL890woD8N1i
         LxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209441; x=1739814241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jp4xQH7m5lEMdSS67IiNyx4buTe0VVGMGzphEL5Q8YM=;
        b=FBT7rNbzgkPk5JS5LPEui/4hWQa/jbgednmqT4a2ZHsFvF+w2U0r3+0tAZioEYAcJV
         SAwxXxIYzMJK+hSNORIQ5Qy6S1d+3nzGx6V6dOPGNwasZpYupX9FHVq6cwo2yT+kQdl/
         RVQ6ggd4jNOT8b3EK8nE1xJaVGdSSXxRkmqtGQfK33T5q9Jp1zvRzkPNDstFwCDNcTyr
         BWRHdZyDWl+oJ75D62R2nU7HiTEaKYlMFs1euRqOOpe8nVsJSc6fIwtw4aZSHzoq5+T/
         lfRzJQ/78Wb+vDTJD8FHZkbIskPuZWYJCfNTiv5aeA64xG6WWuk6kxh6KPlms2uA/QT/
         Vpjw==
X-Gm-Message-State: AOJu0YxmtJq3EeQpFaN7g2rigaiuxSc/lP3/9OxX0tKPgg0nuA+5f4AU
	AdFQ0SNwdgIMMu4gJ2+MLPk4mKKkNlNFBi80OuIZCmcHqie+ggT1Rm1r3Ldo
X-Gm-Gg: ASbGncviGctB6WomN1ZGiZq35fRmDdnKWlWrlx5iGY+UzPTL/H0mT75d88FeRNCxWHC
	JMh2s9MPRA+na8zc0GtIQvb/MUb/5m8osPrr04IxS+3zqDcE0KwN+NYpnBHILno76A1sbGWBIYT
	bvTr5TiWvu8bxVjjAAJrM7yUs7hhTYQdCq62/NwygoanneE06VM4K+5rcn41/ADLoqrtBorTw21
	Eltd+WoruGIHLpT05uc7gRwrVnfb0DkpP+WLT1OoThZ23N5RGML03lwtJudkDLEhdl0rzV/+0Mk
	pBqtz2Fmjk9dTJjGLdzrnFOOoCM7Xe5ZK8l1LUd35HYExwqeRj0uKUPfeGoqc68W1g==
X-Google-Smtp-Source: AGHT+IHvNGQ+ztuqQK9ZnlrTb3Mcfg+sxnBLcJHC6K/i/pTxHP0oJdvSdgxyT8WSossa/YWQIw2g9w==
X-Received: by 2002:a17:90b:38c3:b0:2f4:434d:c7ed with SMTP id 98e67ed59e1d1-2fa24177361mr24714444a91.16.1739209440932;
        Mon, 10 Feb 2025 09:44:00 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3fb55dcasm5554961a91.4.2025.02.10.09.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:44:00 -0800 (PST)
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 12/19] bpf: net_sched: Support updating bstats
Date: Mon, 10 Feb 2025 09:43:26 -0800
Message-ID: <20250210174336.2024258-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210174336.2024258-1-ameryhung@gmail.com>
References: <20250210174336.2024258-1-ameryhung@gmail.com>
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
index ae06637f4bab..edf01f3f1c2a 100644
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


