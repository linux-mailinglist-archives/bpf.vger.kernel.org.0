Return-Path: <bpf+bounces-79026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47404D242CD
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 12:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC0E430C4C75
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 11:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2968137998A;
	Thu, 15 Jan 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4W+VmxJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8126D3793B9
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476258; cv=none; b=ILjD6GoQ38W3sG8dqvsSXXjRflp7pzRjWCFroVXtFv7FIcjRJz/cx+z0rA60dumVd8muYMWdOB8idA3kxwvaGv6ar63m9qzWGdq6CRdsxop+TBJ2hLsOu4/Z4Zpi0EC+dsqtR70kIegN1b2NaGVeaK75hQAXfekisPHebtZIHGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476258; c=relaxed/simple;
	bh=7cC1ms5ub9SS0bly7QzzdjNJghADRqDQHVSuwXZiOkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALOkPbib7L7KgXlIDMrssYZ1GwN7DXLp7WAwn+5n1vC45Fad9THqgJXGzQVnnNf/keI7mzaB4JT5nUrvhRFQvKoHtKtAKny0dm94JPhovonvW77riPqHY3AgNkowFHLwR6faaoWmjFZyaZ/MJeXTyyUoBDLuHHwMfOHZy37dyPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4W+VmxJ; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a0c09bb78cso5226935ad.0
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 03:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768476257; x=1769081057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG3OIJ4OsXGkuiYroAWEp+caX5ZqVGcvi7JJxvZjj6c=;
        b=G4W+VmxJB5qmyn2oawBZOediBCjOkWfHjPUYr6Zd+GFu//t684gklaKkqRWkqBjR4p
         0yHF1cKBtWcegQl//WINzgjGbrdSX13sGfNTc9vMFMWiYCCYviPgkAVML4wlcKSYbt9l
         YAIxGkCCuJlW4+gpWMiOA44rNmphZ6Ch7U/ehvGJu85vGtFMTWeXaiK62Dpv9EW2Ahyc
         +sIlU9b22YEmprLAP4Fyi2uhd+O3pD4eIqWiYsmdpUyvxQoPfrK1LzO5T3XFGzfrAMf9
         qOuyMdK5bPb/NjAtwmSyOFP1JnLHnuCpE7NawLIqwF7CLj9EeYbpcKVgUqDmoBj04lhz
         HPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768476257; x=1769081057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TG3OIJ4OsXGkuiYroAWEp+caX5ZqVGcvi7JJxvZjj6c=;
        b=ZpWcyYBqNZ6jvclhxjegmcLHBuwdTZggqN4J4ATQ+aRdgS8jW/DC/hfKeSMU/julan
         3GcJQfP9P98TdUjH2ru3+BF6WLGwAeqhjHBuhO0BdR2o6m30pJuEUHdUczwNRJjs4lem
         JnAc4cqZYGyicVjeMsj2uBDxupCZDzOhiIh0+wqYOLDvi5HPo1oy029pNfEzjZQjywe2
         C1M02RndoH6pDFihz2GwvMRd9+poMY/oTcE5/325x6soPHaIrQ+InecTBdlvqEuqsqM7
         MwbCKj+ICGJNxWi1+JQvew8yKWMtXOPZ4qZAG9pFM2ESARM48/abvUgu1F/1TkuvDA9g
         Qllw==
X-Forwarded-Encrypted: i=1; AJvYcCW1qcLGF+IKEk+hYH5Zw0b+WxRquTtnPnn8RyAUmkB/vsi5C7oV+icnS71KnOs54Mkesb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/sl8/ntCvTsfUbtgkjsyMgnr/d7NzZ1cWq5yZHWWhfwQwQh3V
	1FReAqbJPlHZaLT+5llZVl3uSZ5upWqr/ej25v2UQtgaAaElvRYOMhzf
X-Gm-Gg: AY/fxX7ZvABSDaMVJ4oiXI4jecauTVAqmoC44nCRa6RRFqmYSuMpmWlMILZpxb7vEZk
	IPrJXD9TAYImXgk72jba9rvCWAf9ki5nIzMDAMkHgHwWiwqi53AnSykycgWvdhXGetLW7MXX1vM
	VE12YHtU6fzeotu+22NX4GYFZGv6HXfuq3elMunaWDw+EDuthqYKXskYyu2UaoDAdMeciKJcIGg
	8EkJdBSDAg0oNSHupASW/ezQRoys8Wc3lsIZ7z0tL2wWQO4dLVDcyaj7b2WKy/8rp2v37nA6sqJ
	yn6DSzYM2UseXM6eAERFyAVSZvHgLR3PPHFpo6SCcG5T+OynKNGCpqbiryIgdvf3L+EgauaSipA
	WFAHfzR0c64voDvEGvge2HdlVCHgcnZb4fZhgLEIAlQfBMr4vqJyWcLOUDsjSu/pm7cnKDSyrnh
	oPy5iM84Y=
X-Received: by 2002:a17:903:1967:b0:298:45e5:54a4 with SMTP id d9443c01a7336-2a70098a018mr25525385ad.1.1768476256907;
        Thu, 15 Jan 2026 03:24:16 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3ba03f9sm248523225ad.0.2026.01.15.03.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:24:16 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v10 08/12] libbpf: add fsession support
Date: Thu, 15 Jan 2026 19:22:42 +0800
Message-ID: <20260115112246.221082-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115112246.221082-1-dongml2@chinatelecom.cn>
References: <20260115112246.221082-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF_TRACE_FSESSION to libbpf.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v10:
- split the modification to bpftool to a separate patch

v5:
- remove the handling of BPF_TRACE_SESSION in legacy fallback path for
  BPF_RAW_TRACEPOINT_OPEN
- use fsession terminology consistently
---
 tools/lib/bpf/bpf.c    | 1 +
 tools/lib/bpf/libbpf.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 21b57a629916..5846de364209 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -794,6 +794,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_MODIFY_RETURN:
+	case BPF_TRACE_FSESSION:
 	case BPF_LSM_MAC:
 		attr.link_create.tracing.cookie = OPTS_GET(opts, tracing.cookie, 0);
 		if (!OPTS_ZEROED(opts, tracing))
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index bbcfd72b07d5..0c8bf0b5cce4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -115,6 +115,7 @@ static const char * const attach_type_name[] = {
 	[BPF_TRACE_FENTRY]		= "trace_fentry",
 	[BPF_TRACE_FEXIT]		= "trace_fexit",
 	[BPF_MODIFY_RETURN]		= "modify_return",
+	[BPF_TRACE_FSESSION]		= "trace_fsession",
 	[BPF_LSM_MAC]			= "lsm_mac",
 	[BPF_LSM_CGROUP]		= "lsm_cgroup",
 	[BPF_SK_LOOKUP]			= "sk_lookup",
@@ -9859,6 +9860,8 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("fentry.s+",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fmod_ret.s+",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fexit.s+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
+	SEC_DEF("fsession+",		TRACING, BPF_TRACE_FSESSION, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("fsession.s+",		TRACING, BPF_TRACE_FSESSION, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("freplace+",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm+",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s+",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
-- 
2.52.0


