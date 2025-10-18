Return-Path: <bpf+bounces-71281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD458BED168
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 16:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36095E79D0
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 14:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD1C2DC794;
	Sat, 18 Oct 2025 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZ2Azo1W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A3C2DBF5B
	for <bpf@vger.kernel.org>; Sat, 18 Oct 2025 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760797323; cv=none; b=ML10NQDfystiQeXIxx+5ycQ7d4zZT+8nN7mKpYg2NI/M1Sk9VEVjPG8DnItT4xsQ5jcpdfjNZa/4KzmgjWSuAIFA5+mjN3zvu5+KLUFdsFlXgRJji7jBUpHpnxMYcCrmRu7lKc3XGg5L2ZIYrUy0F1Gx/9QNphEaaecwFsV386Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760797323; c=relaxed/simple;
	bh=JKPhFCZ2Wzt7BBEmHO2+O8K1JfWX20E1BadKWktgF0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSZ2Mjh30j1Fj79YzRsJpwAe0zSZQQvFtgBTL08EoYRfDaXTWPFaI+dSNyNBa545bj5wlZurai4xcQYKMF7LWm7+bKioh2Woyp2ezPLs/tHyRMYxdUJS7mE5LfSyrKGpQpUsUgWzv/hcGRpOlz4Hmbw9NXfkdnfmd/6FSUTtafQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZ2Azo1W; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-782023ca359so2912146b3a.2
        for <bpf@vger.kernel.org>; Sat, 18 Oct 2025 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760797321; x=1761402121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTgng+JyAPm5fFCGDOYluLNqW4oXLGf4l2RyL+9kLZs=;
        b=GZ2Azo1W6m0Cr00/OUykd77R6nZ89QqJgHsS5f9luRgInIWWaf02X1zCrAKvn/b+JP
         aj3WVxRCnHGEz5mvOAwLyqEf88/9glfQ2AJ+WxXrR1dsbNHWQ4/w78Ik+ulHZ9PMVGfd
         idUhdCWDtPcqD5nzOOHK9PUEJl351JgyswLykDcSQ/MdjZRUCZbM8WmJvR/Xggfau5Hr
         1ZeedhkW7Xr6fmRT0ULOHKPfJ/+wBr6xPjIT+W5TwW7jO6Eptn6s/WxxmAxUsG62f1G2
         XPmSdfSLUeNRsTQ4xApdSRMsIDRwIsVn7tawhg8hN6MsoKltz1HC0cN29DEy698rUElG
         hrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760797321; x=1761402121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTgng+JyAPm5fFCGDOYluLNqW4oXLGf4l2RyL+9kLZs=;
        b=YWyRXuqOk+v3pkzNJk/K1/zVR9X0sSy8rwpnBkXs8EDel7PMDsi/WN0cZdExwYWb1c
         qU0SUQ+NK38inCUqQ1kotIJfG2Bfwk4BuTeKuRaGjaryPzdalKWeD6MrFEgzvtZ/IcAT
         OXvt+Q0DPZNuDJxGYEfLTvZI2K6i3JOxqVsKBfkcD9ZJJy2+K3TgQtp0odEYV1fwDiSJ
         vCxYgQNUo/kIrqyztcRImEndC/Mq6rwDF57iuGCMBLQNmgmEMkY2iQMsV0kmI9jclB+y
         XDncgIwnVeMFxGtUas/JqMSeVJVxxCODn+gqSXY3kB46j9od2RmQ5EuEg8YvUJbSsoKt
         hh8w==
X-Forwarded-Encrypted: i=1; AJvYcCX8C7MZWjDcZeryamd65lg1b493z8X3QtBjxdg5pf9aMhxbo9la5ZzgBWBUEez/ai5YN4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqrGRmtOpfxFzxPZrPTRXtP8fJtsFnZBkibVYgcBg042ojIAMc
	xsKv/1rqCTtaBOayxtwFOrzz4XqDogUJyp0PpSDfS2vNqf6i6Z6OgQtV
X-Gm-Gg: ASbGnctr2PdKwkn8MTIOSjh2ZGWlRwsW4YAqP38dTMZkBgOOKZmnzG//pJ9kmWFwV6L
	x8Uu8hQ2fqSK3kadgHBWUHWAagcFIJN6TrpEIPcfGPrRNedAj5Y8+vU1h7U/tKg9cB2eyOY0YKQ
	o2z5PklCNlbxbK63TjjPk4NJZlbgg0531UXzQVr7QiEyNjNYOtUiMsIR1TkdRODnk7TwPMBUFOF
	Opn9tvU/UlNaNMwEPCbKuTco9qQj4BlrwDx8GEhru7XJXjTKnl7QjcUK9zntaTGvteOJA1FnPYL
	FQYTS63JWMxoysWim2Mr/OWpNPdneUh+AnEXSBoP8DFwyNPvyyxmo79DuMvm6Z633HY6iBhFVxN
	r40sQKIIDc3yXW1BFk54e8T3Zzu47cGXpOMh8Azx7kbK38i8FwabQLFuxIIiJYeLZH5zu6MwY9w
	Js
X-Google-Smtp-Source: AGHT+IFm9xR2qdw43jegcye4ND/f40zSsvNQsshT2VKSlXk2RtQ50rm4cgIWORQV6xJDs47kUiNJtQ==
X-Received: by 2002:a05:6a00:a589:b0:77d:51e5:e5d1 with SMTP id d2e1a72fcca58-7a220d2328emr8535692b3a.19.1760797321344;
        Sat, 18 Oct 2025 07:22:01 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010d818sm2913589b3a.53.2025.10.18.07.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 07:22:01 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	leon.hwang@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC bpf-next 4/5] libbpf: add support for tracing session
Date: Sat, 18 Oct 2025 22:21:23 +0800
Message-ID: <20251018142124.783206-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018142124.783206-1-dongml2@chinatelecom.cn>
References: <20251018142124.783206-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF_TRACE_SESSION to libbpf and bpftool.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/bpf/bpftool/common.c | 1 +
 tools/lib/bpf/bpf.c        | 2 ++
 tools/lib/bpf/libbpf.c     | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index e8daf963ecef..534be6cfa2be 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1191,6 +1191,7 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
 	case BPF_TRACE_FENTRY:			return "fentry";
 	case BPF_TRACE_FEXIT:			return "fexit";
 	case BPF_MODIFY_RETURN:			return "mod_ret";
+	case BPF_TRACE_SESSION:			return "fsession";
 	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
 	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
 	default:	return libbpf_bpf_attach_type_str(t);
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 339b19797237..caed2b689068 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -794,6 +794,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_MODIFY_RETURN:
+	case BPF_TRACE_SESSION:
 	case BPF_LSM_MAC:
 		attr.link_create.tracing.cookie = OPTS_GET(opts, tracing.cookie, 0);
 		if (!OPTS_ZEROED(opts, tracing))
@@ -917,6 +918,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_MODIFY_RETURN:
+	case BPF_TRACE_SESSION:
 		return bpf_raw_tracepoint_open(NULL, prog_fd);
 	default:
 		return libbpf_err(err);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index dd3b2f57082d..e582620cd097 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -115,6 +115,7 @@ static const char * const attach_type_name[] = {
 	[BPF_TRACE_FENTRY]		= "trace_fentry",
 	[BPF_TRACE_FEXIT]		= "trace_fexit",
 	[BPF_MODIFY_RETURN]		= "modify_return",
+	[BPF_TRACE_SESSION]		= "trace_session",
 	[BPF_LSM_MAC]			= "lsm_mac",
 	[BPF_LSM_CGROUP]		= "lsm_cgroup",
 	[BPF_SK_LOOKUP]			= "sk_lookup",
@@ -9607,6 +9608,8 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("fentry.s+",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fmod_ret.s+",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fexit.s+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
+	SEC_DEF("fsession+",		TRACING, BPF_TRACE_SESSION, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("fsession.s+",		TRACING, BPF_TRACE_SESSION, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("freplace+",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm+",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s+",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
-- 
2.51.0


