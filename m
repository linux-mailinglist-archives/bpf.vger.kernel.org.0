Return-Path: <bpf+bounces-37528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2310957039
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 18:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313141C21635
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 16:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D72172BCE;
	Mon, 19 Aug 2024 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhTNp1u1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0661416B723;
	Mon, 19 Aug 2024 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084911; cv=none; b=hcrplte/+S2gw77fuX47rw5unJ1bho1aPBLNN+C0nnr0uYgrCpiXJmwEzPTq2SoOlk29uTTYD0gDiwkb/9rMctsR3l+3vNzWKdsw+W+91tf4WTmMmfhDDSFQw8J1gybPFGKm7dN2ljUi7JJEXNeGGeLTkLErqeYQlAajpfgQ/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084911; c=relaxed/simple;
	bh=CnxAAb8nBmlN+qmJh7Y8cNjHTY3GdAjthSBsbnfArzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVHDEAIB67xcbrFUmuPwIidW5StCVB2jWHzKcSzoRF8/sUR4Jj/2BUr8jkewEMle7d+T17W7oxFH7OS+4p7H1Q+coDXxT47T9CgMQCQSW8RTcYQfu3wGt2X8eyE9m1je4BB+GWiWqmhsTkrJZ9COWrRda7O+EM36kciD4te+2Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhTNp1u1; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280bca3960so39714985e9.3;
        Mon, 19 Aug 2024 09:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724084908; x=1724689708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4byJmaRPBM/fF4ewgeAcBj1poyGjlWqdURxO7qwLpI=;
        b=bhTNp1u1xnpQCaovYu/W5D5Ekl1dFaYG2k77rMlcmW9mfr6Kna9S7FNwJCz4SDBrsb
         Qc4kXGGkPdZ0DUZqBSdulWAnsAtXjFdlOg6acYSDpkomlNo6LRLNITHueLEFerGMk/3A
         R/kIePwAc/n8APK9mwyAxQcE/Uq72nLeSuuUJjPHFSnybp92w4u8WvsHaVssVbrntlkH
         9QI2Yx6QdME0utl1kD6WGpOsiURoJLVCjgpQc+fPtOcbfwMzm6BuQy/Bp6TkcsmA7pkT
         A//wwWEu+vhaqJ4d1osH62KfwjIo31HPb700rqG//tXbcU7qV2tfLAFn5foQfsZDHoss
         V6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724084908; x=1724689708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4byJmaRPBM/fF4ewgeAcBj1poyGjlWqdURxO7qwLpI=;
        b=CCE9gYRmyJapwQjlW/iP7Inl95uVS22LRwraLkJsk8eEEnaJgF/eywa88PpBRxZKM0
         Fy/5HVE7uTGl/ob7A5RUHMrusaqGIyTVt53dJPnrWUhhQOLksXGraOCPKMyibNNBWvW1
         /UHpfvzkSvYwkghph+PhWXd/e8BQLTqYqfL0ztX1UzV7KORTX2Za7nbECjiIQoenRJFl
         VqVXEDUdBjqMC9lW6Y/TrYUZsrd374cApyUey4ROPpo9nRL8kSfAd9P3AMTZoKsfYA2U
         HyjecRE7QgEdNcx1Pn0JtC5A3lmLWSMpuHBFLRECjX2CNO+lP0L0+oKeNIMPL0ptdlFm
         lTiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEqSVro83KtyYyZRhgTdNMAq7q+nrIiwXEfOwImaBt7iCpU1aHPSA3CLAM09XZHDm8KkyB202Ejo/pJDPazy65+ORc4CM231h2nFRRs4t4Trp4x1CVC2ubDByZgC7kOjYedVee5eJ0
X-Gm-Message-State: AOJu0Yz9Z/2cZao17u2WtZ4P8J8NoubErZFB1OkQuLfKIpaa16a4TCQ0
	EIfOOt6+KXP6eWKSluR5ceVvEMD/oeDvovnkeOWV686vi2NPMo54
X-Google-Smtp-Source: AGHT+IHj4O3KlsGIoD/hPYIThC8068GQhL+twJa5maLXqyNuyjkBs0ZLRWPlUIcABNAFXkggpafj1Q==
X-Received: by 2002:a05:6000:1b01:b0:371:8f19:bff0 with SMTP id ffacd0b85a97d-3719445235amr6044273f8f.20.1724084908029;
        Mon, 19 Aug 2024 09:28:28 -0700 (PDT)
Received: from lenovo.fritz.box ([151.72.61.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897029sm10922134f8f.74.2024.08.19.09.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:28:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 1/2] bpf: enable generic kfuncs for BPF_CGROUP_* programs
Date: Mon, 19 Aug 2024 18:28:04 +0200
Message-ID: <20240819162805.78235-2-technoboy85@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819162805.78235-1-technoboy85@gmail.com>
References: <20240819162805.78235-1-technoboy85@gmail.com>
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
Since all BPF_CGROUP_* programs share the same hook,
call register_btf_kfunc_id_set() only once.

In enum btf_kfunc_hook, rename BTF_KFUNC_HOOK_CGROUP_SKB to a more
generic BTF_KFUNC_HOOK_CGROUP, since it's used for all the cgroup
related program types.

Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 kernel/bpf/btf.c     | 8 ++++++--
 kernel/bpf/helpers.c | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index bfb0d89ccc8b..b12db397303e 100644
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
@@ -8307,8 +8307,12 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
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
index d02ae323996b..26b9649ab4ce 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3052,6 +3052,7 @@ static int __init kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &generic_kfunc_set);
 	ret = ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
 						  ARRAY_SIZE(generic_dtors),
 						  THIS_MODULE);
-- 
2.46.0


