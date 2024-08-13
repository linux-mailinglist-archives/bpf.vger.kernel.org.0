Return-Path: <bpf+bounces-37030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5A0950678
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 15:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7437728626C
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 13:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3680219B3E3;
	Tue, 13 Aug 2024 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHrN3hBl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183B619B3C5;
	Tue, 13 Aug 2024 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555730; cv=none; b=uGMzPWt1JHKie4HBQcOTdNCtf1z/B9wK13AnQI8P7tpMC0n7ccAevLoxMSxb/vwB5Z2Mzt1ahxssrWwJP92AHp/Ev8M4jqXM19Ir9EtSZzfMoSoGapNcQO/CvcWuIMv4RJzP2AKOMVpz4HoEsoitw0S+TVRHGrPknJAnI4b5ClU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555730; c=relaxed/simple;
	bh=lSxUx8QJC4EPhMBsEVy0vDjpMEg1x5VyoHxhEZZ5+ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7+dIFxPQrbnmQXVbktpRs+146YFgb22EhdxOm9DGRU/GPE2XDYpKlZ1zEF1VZrvQZrJk9m5E+91D0BXG1SY6NQiCx9BrNtPVLrpwcWi46llxJArHJH05mP6qwkpr71Ao6r3UL0twy/fikU7mu8rQwLFJkFeFITI83MTdMq6l2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHrN3hBl; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efdf02d13so9029269e87.2;
        Tue, 13 Aug 2024 06:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723555727; x=1724160527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3qivM8JDv5nFGvOqtv1aQ6yzpE06yGKDeScqPR2KII=;
        b=gHrN3hBlwInHlLHwQXftLE7DQ50Iqq0tHEwMd/zh407sObxggq5t8qnxkdoK3Y3I4x
         bfqEIyn1Hz2+/klFk+zark3Jryhqyb6oz5CnKeUjbzg+UYY0tVYSzLfy8uXCh+kNgbM4
         2DZx2zGRVn4jaNm+tk9xw6FL2AwQMqqzp2bbjgH1pJJSd7UoNgtnL3lE5Cy/XWzAc1mB
         DiqG+IwIR65NRKGDDu1fRPi8pB5Kv8a+wozSTI42aHPXV6nyKfn25McUyw8uhsMPAPEI
         smnK8yPe6GQJULk7S7Yo4gIeCi9hUMQN4vM25CQ0kPxDOCjB0LOy6z6pVczWq3X60nbK
         KrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555727; x=1724160527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3qivM8JDv5nFGvOqtv1aQ6yzpE06yGKDeScqPR2KII=;
        b=cHgb2P84OG7fwG1AqfwvfGkGnjJDZYUKRQxCDYT+PIQfrFN0YChxztfNl4+76D9uD9
         5wzIYwppP6nRBL0cS5gCNp+mX7WpFN9t4iN41YbhEIWLitlQQ7krNf0PGxd9ZyWWAwAl
         l1ox7CH7Lf+e7jnaWK+JCUo0LhH9A06kzfKOiU47S75L9hWUzFGKbg70aqYY8IYr+fxs
         Yqlerue4QZW1l4+Q40Q5MW6q84HtWJyfDPWdMWww+xcCiZtr2UTXO/IkWMISQzHx5Gy9
         9LGnrTPr4aKCOIXnuyVmESy6pLVWQQNkT+X1IMzY4rpawyVmmY0PJvadok097ekft76o
         qTAg==
X-Forwarded-Encrypted: i=1; AJvYcCV/PDfFzjqV/u/Q8i+/6+XqLSVEXKV88yD1OeEogGxvNIzmeEHizD3NwaF70MlD4iWjkyuP4rW6rfKovPgr1KqnamPQxKj4m1rlqJ9XoCUcN1vY4STtsh8+HpvFGb2R65tPIFIfB91/
X-Gm-Message-State: AOJu0Yz0fHz6/c3jVdKdvcSCo9EtKF0/opu2O41dYdtTJo0XkCP5hzhW
	Jk7zY7z60pRlX7cj91bCxAZkn8g/f3C8Te9h1GMUQ94FwAK+VQxw
X-Google-Smtp-Source: AGHT+IGixZb4iQ8MItRX4SkJeF2nVC4Y4UlA589p4iD9NqyABs/rB1o1Sg/PVpC2mrSTjIN8nEuF7w==
X-Received: by 2002:ac2:4e14:0:b0:530:e0fd:4a97 with SMTP id 2adb3069b0e04-532135a5d5fmr3170162e87.0.1723555726827;
        Tue, 13 Aug 2024 06:28:46 -0700 (PDT)
Received: from lenovo.homenet.telecomitalia.it (host-79-17-17-86.retail.telecomitalia.it. [79.17.17.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414afe2sm70426766b.144.2024.08.13.06.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:28:46 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH bpf-next v5 1/2] bpf: enable generic kfuncs for BPF_CGROUP_* programs
Date: Tue, 13 Aug 2024 15:28:30 +0200
Message-ID: <20240813132831.184362-2-technoboy85@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813132831.184362-1-technoboy85@gmail.com>
References: <20240813132831.184362-1-technoboy85@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

These kfuncs are enabled even in BPF_PROG_TYPE_TRACING, so they
should be safe also in BPF_CGROUP_* programs.

In enum btf_kfunc_hook, rename BTF_KFUNC_HOOK_CGROUP_SKB to a more
generic BTF_KFUNC_HOOK_CGROUP, since it's used for all the cgroup
related program types.

Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 kernel/bpf/btf.c     | 8 ++++++--
 kernel/bpf/helpers.c | 6 ++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 95426d5b634e..08d094875f00 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -212,7 +212,7 @@ enum btf_kfunc_hook {
 	BTF_KFUNC_HOOK_TRACING,
 	BTF_KFUNC_HOOK_SYSCALL,
 	BTF_KFUNC_HOOK_FMODRET,
-	BTF_KFUNC_HOOK_CGROUP_SKB,
+	BTF_KFUNC_HOOK_CGROUP,
 	BTF_KFUNC_HOOK_SCHED_ACT,
 	BTF_KFUNC_HOOK_SK_SKB,
 	BTF_KFUNC_HOOK_SOCKET_FILTER,
@@ -8312,8 +8312,12 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 	case BPF_PROG_TYPE_SYSCALL:
 		return BTF_KFUNC_HOOK_SYSCALL;
 	case BPF_PROG_TYPE_CGROUP_SKB:
+	case BPF_PROG_TYPE_CGROUP_SOCK:
+	case BPF_PROG_TYPE_CGROUP_DEVICE:
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
-		return BTF_KFUNC_HOOK_CGROUP_SKB;
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+		return BTF_KFUNC_HOOK_CGROUP;
 	case BPF_PROG_TYPE_SCHED_ACT:
 		return BTF_KFUNC_HOOK_SCHED_ACT;
 	case BPF_PROG_TYPE_SK_SKB:
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d02ae323996b..0d1d97d968b0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3052,6 +3052,12 @@ static int __init kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_DEVICE, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SYSCTL, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT, &generic_kfunc_set);
 	ret = ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
 						  ARRAY_SIZE(generic_dtors),
 						  THIS_MODULE);
-- 
2.46.0


