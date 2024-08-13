Return-Path: <bpf+bounces-37017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8C09504D0
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 14:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FE51C236C6
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 12:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B512D199225;
	Tue, 13 Aug 2024 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hxvv26L9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9255917D8A6;
	Tue, 13 Aug 2024 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551684; cv=none; b=tMeT6eax25v2O4M9todjMObivLkS1QCZqtrUMoSYrjhPrTYTNG1vPaDyBFw7/fqXLbRUZokNx7BbutkeULJJ3nTVPLcVtjH1WeiqEOpuJZeyscHA9EUEvaAbTXGmHoQXCoEffMZUt3HGcpSMh0lvWtHpjjI8QIZybHXWX/rW/tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551684; c=relaxed/simple;
	bh=lSxUx8QJC4EPhMBsEVy0vDjpMEg1x5VyoHxhEZZ5+ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mjz8Oq5C1Jz6yo5fHWBiywNED+WruHAes8jmKZAsrcbH9+NMo6ZCsVIFIH4yBdhmrywvwKEC/DhzXKaurA1nWFkZjUAaEZgQ85Q0zEEXVpqVtJ9cd7fE8o/o7DnMtd/PFNEm+/WD524bsjcAMExTbdin8QZdagLcNhYAuMt5N5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hxvv26L9; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bb8e62570fso6501856a12.1;
        Tue, 13 Aug 2024 05:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723551681; x=1724156481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3qivM8JDv5nFGvOqtv1aQ6yzpE06yGKDeScqPR2KII=;
        b=Hxvv26L9f+IIR1Ynfs3/WrBpkFh67OvdGzy96DjMcXJrRYLxUVWRVfZHrcsq4hw1g0
         ARi06RlJloDde1Dw9vGd0b/RYeYmZzAAy1BtSUebvVuQSUiTCagiemTwrIhzi8FyYyED
         u71bmKNpMZBSAQXUV9HWOha/jgIh4dzfRA1wYIaSrqX5XWezIi6Xh0Y6b0u40H/x1wYC
         z36H2HHVekIlyiraQBrleSf8rDRLgb3UxOp4Ibi/ALFt8emnJNqZY7Cpoq5KwzuodX+E
         5tRbFO4oXhtyhSNIRNz05zJ0GcZtNbh2ZnHhmei1A1M1yAdauinwT4GCY1SsT7VebDlX
         vKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723551681; x=1724156481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3qivM8JDv5nFGvOqtv1aQ6yzpE06yGKDeScqPR2KII=;
        b=uBU5uR9OhOQw8Dl7j7Eoo+bXyo/Cx4HnNoRH5vkU2aJzPxKk7GB9plErIhyVLM/GeI
         KWBGsF2zvLEctsiXvvlYMTQbETAx3r6xp9lxed88s7AplLZcva5lmxEMY8hGjIlPwzqg
         A3RxJDE1Zqchg29ZdhIFBF3MrvkXwYwzX1vEYPLIDEcZK3xdFv6GODvq1pTZ5d2H5UJG
         7pPRtX39zogODgSGYiEErYRsXCt59oAvR6zMg6ondnv1rmZFxvTv5vYQMUuLKT/pSqVL
         RzBdNQAZx5JV+bGbwO0QyFfis+ZzvaAWVach4XSNmPSBmaAkoZeY+UxJdf5/xik017iR
         OrsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAMVi5EriBZ9etKR72/41hO4dcJEm+AB98Q0J5sXP6Vlk9c7YzuI1tV69UHYFh9PkoZR4=@vger.kernel.org, AJvYcCX+8phSJT4puPxOdczcU22yE23IrKkqh+ux80aybvHc9KSLotC13cuJl8j2t+buXg3oznJSV0O3EKkAqF5ntoJvp06I@vger.kernel.org
X-Gm-Message-State: AOJu0YztwDduTqmq/u2B2OlAMBxakxHnbaCD4pehenF3CexnKFMqFQL4
	CjJCAOucMASzPB043k7KkC3rtIR1qy/wSVYmQP1lm1nSAtjRNDwL5G82Ml6J
X-Google-Smtp-Source: AGHT+IHPNXjvvrwsIrxty2hZgZxlI/dmhNdb2l6vEok6ER+BgSM0sWONVhLpWSV9CFoEgpXfmhRlvg==
X-Received: by 2002:a17:907:5cb:b0:a7a:8cfb:655b with SMTP id a640c23a62f3a-a80ed2d48b0mr237778766b.64.1723551680665;
        Tue, 13 Aug 2024 05:21:20 -0700 (PDT)
Received: from lenovo.homenet.telecomitalia.it (host-79-17-17-86.retail.telecomitalia.it. [79.17.17.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f41849cesm65358766b.199.2024.08.13.05.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:21:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 1/2] bpf: enable generic kfuncs for BPF_CGROUP_* programs
Date: Tue, 13 Aug 2024 14:20:59 +0200
Message-ID: <20240813122100.181246-2-technoboy85@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813122100.181246-1-technoboy85@gmail.com>
References: <20240813122100.181246-1-technoboy85@gmail.com>
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


