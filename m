Return-Path: <bpf+bounces-72209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24080C0A1F9
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 04:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B3E18A5A1C
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 03:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DA826A1A4;
	Sun, 26 Oct 2025 03:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWgDQdHD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A662571DA
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 03:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761447741; cv=none; b=DGOhnkhL7DZ8CV9wT6yobTsHbcsrp5o46Db5+4Exal2yxRkJJHRDHAZyGggoSXL7xKmBA+MBlaJx2TUN8BW478oVyeWXTDbltoTzsiDO0G+M3+PJdkAVDkpCfS8U7cFCuK7/GclAaU4bYcoB1GGhK2UbmjOdyk+RQFqYSHUX8Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761447741; c=relaxed/simple;
	bh=GuQCFueyfn/NObmpfJmrdR72fVp0TkDQ5S2HEwT1H3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPEuaXfS+yUZecAVY3aBtkaUBVRdxRGNKWxpU1bWNfMNyCpHalTdwkTnzzzk/LvI4P1uz87CNmFPQ7OIarnZhB/HUc/qA4I6QLnYUMmmv+fV7iIFK+dXQv6Rq3CTKdVn9c/9Zdx7SkpSLFeNG7jyiKfugHzKvfeQTlqsN5tsAVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWgDQdHD; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b6cf25c9ad5so2662635a12.0
        for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 20:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761447739; x=1762052539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUOMYuKJiVL10Vf/aBjRKKIq/GvniLJo4ZiI6vGstps=;
        b=YWgDQdHDAtXoElxx5CnGKV/TgEz36w8+uuxtC+GMnMcHLBnJbZM7/7omz82BJa/lcf
         Kt4EuLwfbuSTLm59z12h2680ZPPfGA0sfFNt/N1uzdzpD5J68cDj0wcJO9C71QJ5phCE
         ivv3gP37sB3iWVw1xYV8VG3WVjo55kC2sXqg8KSmUY75I657AHITvJH3inXOBZClNUCh
         j76ixUtg3FbukyWIdPRl4Qvr86/UwkGaEAmn8zQEC+Vaa23DWz2wV5XQVBT66aA96E4q
         M3qHi6rOhX34/7xQb5CoqyPxcB6bL70Xn73C+uiYRHV/zPyL7BzjoYO9Y2ZGP1jWXzUW
         297w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761447739; x=1762052539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUOMYuKJiVL10Vf/aBjRKKIq/GvniLJo4ZiI6vGstps=;
        b=RSCgtj3TYSuGYULDsf/HAYh5f4cSYa0UBVT/1ujuocoNWB+G9A7v2YO31SFeBI3hg9
         xkaV1ZO7lVkKhKF7k/vsyPTWmM97tFTZlqsYIuEacqQwFNvbUZ09EQN68MSM/IiCp9Wc
         KqndhxGtToU8qHkbwc2Yejdil7/Ivie7B90CHLCUoJtiHQ0ChaMZ0Jw3KwDJHPBAeurw
         K/7AfN3n187goNqkvIS90av6O+kLqUwCdAhjMkJxjwAOUTV6/eeQynKdxzvwi0+E72IX
         2YCwVPEElJ9RATKWzOpxeHnko3qwkZaRvjmAFWyKUhLEZTUXEZm/8XNvO3LtqQEydQyU
         gDuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBtaA94Qd3qnkeVlxZZYsmszuw8Y6xWW4rmLT1Qz0Qpq6zmriouDNJsrslpsdH9bZ88wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcmYW6gQHRIIVYgu4ikeoF3uxwFZQtu5iDS8ztbmdFiTaWZ2qb
	uGdXEAIJq9oedpAwy8B7k3g+U9bVfbMuvxSEaO1IdrVDx8r+kEKlcZLb
X-Gm-Gg: ASbGncuMsQp5NYRp/QW6gAlQ1ggpKmn4ueTLrGSsBFL4s2WTeOIgBWBibXBuExM2QRm
	g9/T3LYEzvGL7N1cheTC7o7yqLRBlUtN1XJwZlhp+OJWyMyYM1a3UtNsmbfj6A9BYehBecIVf/H
	z7eDHYSYH2SivKbFNZIDcivHQ+xgSg3QsD4l/mhNQamOL8a8oMPi7jNZ5zfLjNaD0IewNgFODqq
	JOdoyYAQQkg8vWcj1OBxPFXNkNJkTt30/sRBFDtiM4KPa4eD6O8D4vd0hQ0Kem7UKNSEP6THqxn
	riYOyuOo3gYXZyyyQoLqsaNjiDATWSwgaDRiRqBjByTc1CfCewbFFkP72RvSkX76/DfzXOTdz90
	iI+3BqaGY+HExi1AcOa3gyeuWF9ARngtcDRajr6uOZpEDVYS6jxjMqMwwPx/6nXj2O8CySv5GaB
	WbKVbDmSeozwM=
X-Google-Smtp-Source: AGHT+IGcA7pHr4jE0Gm+8ckx81Sfog4EhdhLlaxTxBPWluCuyJcg7FGtnsCogj3Zbc3RxSb9u6qqzw==
X-Received: by 2002:a17:902:e841:b0:290:c902:759 with SMTP id d9443c01a7336-290ccab6c0amr359938645ad.51.1761447738936;
        Sat, 25 Oct 2025 20:02:18 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40b1esm38100645ad.73.2025.10.25.20.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 20:02:18 -0700 (PDT)
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
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 5/7] libbpf: add support for tracing session
Date: Sun, 26 Oct 2025 11:01:41 +0800
Message-ID: <20251026030143.23807-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251026030143.23807-1-dongml2@chinatelecom.cn>
References: <20251026030143.23807-1-dongml2@chinatelecom.cn>
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
index b90574f39d1c..50d10d01315a 100644
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
2.51.1


