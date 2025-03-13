Return-Path: <bpf+bounces-53989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49444A60064
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 20:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B14C880F6C
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 19:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729CD1F3D55;
	Thu, 13 Mar 2025 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcKsbbMI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981341F3B8A;
	Thu, 13 Mar 2025 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892607; cv=none; b=dNZbUTVYwU8RltoFcsKt5zZ2lw3zqHCMnLX6xJwzwHbQqFB9Jmp4E0Olk+D38uWOuqt6YkcIs0M8S68eZbNbwxBpITcGjO4D1GdTa+eQVUCJ+VkkZlI1OHeFT6HmNMsGnl5SROr1opID+NIaRd6IPPDks6Pd1jmzPhORmT4nvKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892607; c=relaxed/simple;
	bh=PvsjZwquHBtkiD0ex5OqAaIb81/a5+rvsxROvzoxNf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhfO6aNKtNv9fNS4iAQZiFgAo8JucczNWP4Cm9YYIYrRPJa0405fzdZydrJVb87XLgHuv1V+eCMCfySKoa0azksoPY7FJDHokXjjAVZwiEN3WMzVv1FBtsWi3oJTI9UbR9NLZ8kBefpzWy9Ejp89txs6mvj6+efQwNh4H63rsH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcKsbbMI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22423adf751so22206295ad.2;
        Thu, 13 Mar 2025 12:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741892605; x=1742497405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jp4xQH7m5lEMdSS67IiNyx4buTe0VVGMGzphEL5Q8YM=;
        b=EcKsbbMIooQy/98pmuef1+pgntPKmMEU/JJOsUxnUGBxWVLHO349Whn/SbB6Bo+ZTB
         QpxN3+tAc3BacQPBkkOdi8pgHAd6ZVXtGslx9iHnVPqu9kmb97JOobZvHu3sXEmbuo3g
         D05nGcq6PqAU38QPFwdARukgmozI27Krn+1LuSWvp1w4KW9cp0FIlKPHvdXBAYpFEMHd
         dAvq8SjnJWZjTeYl2NZhdmyFb99TG/7tBIH0EaJ7+n4OzJZDM+N9On/KeJwHHiJeq5f+
         8xE4Ul743GTvlBqiKbf+PmEJ9Urjeg0kmurbziFbKduwHFeWr7hbuJVEvJvMUT75ut8M
         jSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741892605; x=1742497405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jp4xQH7m5lEMdSS67IiNyx4buTe0VVGMGzphEL5Q8YM=;
        b=Rz2PIasJdRiKV0VXf5+vUjjXsNd2r8DB3CeDC0N12vR7ydUUjDU+rTZEUhql1+zgUl
         XA4ERiW3wwgDn84Lxfi4G8Vdptg3EnaB1lWuBMerKp7S8WplfKXahRdbAAsmjqssfNQ5
         kyUwPFDU9utQWB5kqwi4xxY8TTIxh1+UQvjF5abmVazKzwIIyhFEFF+pyQI6rymO4HxZ
         uAKwNYd0p2+dKxRdXI4LjGvMIyvpPt72OKjFi3aDlgG8EIbxOQpD32AgyR5a4FrSF6GL
         lMsN3r4ZdGl11g//YVRRXCYsPbkQ0vA7qvfa2klXPwfgFF3TpSBKxFFXMVET+PC/+e8H
         cMtg==
X-Gm-Message-State: AOJu0YzLevUlHyAFjkPIHIEeYdqVbmxrlZOg2xaiCf01wSx/UCE+QdVB
	SHl+ECBNNmXo9KcfUw8gFFcgvvDnOm+EI8QnS828K+outcA0YgfZXo8OwX3c9uJf8A==
X-Gm-Gg: ASbGncufaKVy2C6KQyBpcRNUO1kcGHHbXpC3dY80A1+VsGeIw7bqXAAIH2InHCxUrfu
	bvN87YSpQu5TLjscx2H0/+mIuqUIXLc5mpDeQFHpH2WgDHN6cPedZgWXB7QaU/ZDteaYFXgpbqH
	1RrFZZAVIz3AS/Eup82LC+5im09LtjiE+JNHFgKOTriimiq08YAXd8RSlm3+wWkJnV66Xc5JJcG
	LUAAhySDnsSfxQ5Sulu5uutWtFy4BaSaVAvd4dVVjVS/7QsW7hB32rQX8J6W6RPMlpXkXMBvnNj
	aMaPkI3xm3avBltOS0sXq+O05/TSxae5ADjK6Q8jyxxzP51y/3T8Df7OX8Zc3A3gmDvlnmTLkTk
	vuGW0zDeXmqpnrAxjG3o=
X-Google-Smtp-Source: AGHT+IEViz9aexWCzBKu1TRWDoR4qQOUtDE4jPAiHk+PrnOU78udYENr3+FqtfWBYh+sldk8oNA7CQ==
X-Received: by 2002:a05:6a21:6b82:b0:1f5:6e71:e45 with SMTP id adf61e73a8af0-1f5bf84ac57mr472519637.27.1741892604754;
        Thu, 13 Mar 2025 12:03:24 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e2f45sm1652505a12.29.2025.03.13.12.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:03:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 06/13] bpf: net_sched: Support updating bstats
Date: Thu, 13 Mar 2025 12:03:00 -0700
Message-ID: <20250313190309.2545711-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250313190309.2545711-1-ameryhung@gmail.com>
References: <20250313190309.2545711-1-ameryhung@gmail.com>
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


