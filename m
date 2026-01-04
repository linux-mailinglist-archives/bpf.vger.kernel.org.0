Return-Path: <bpf+bounces-77775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B62D7CF0EEA
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 13:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26A9B300DCB3
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 12:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B852F617F;
	Sun,  4 Jan 2026 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR56goIp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA532EBBAF
	for <bpf@vger.kernel.org>; Sun,  4 Jan 2026 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529805; cv=none; b=T7mbSET2UFJa2Z+oW5X4wTMZWZXhfOdg3/pMPY+NblzH2conLNwP27c540XxOMOImzCZ7hOFnJ0OJROOH9EG+xDvuYAzb0ByAZoKbsmEuX46nXaV+Qj9WPs2v0wL+2e6XMbkVoBW7ehOiXBcxBNdzsKlA9M7x2cvQ4QhVTf1idE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529805; c=relaxed/simple;
	bh=5FPTTn8VrDMMCi8rzKPPkNm4Tds81/hDdgqt5SuYt/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dO+Ro6eHVspxiSil7EhAuDzV4t23VUIYJXT3HoYiBjP2hMT2UAEhgRa4IwAU4JfzxdA1x8deSAN16V1O0OAO1Y9QqsX8wTl75mUnsj/g85+qyqq8QNYi7yi6HwxB1gHV4TuoZDkNQhmbxd8oVFTtKSTFVUpM84XfRoRVFErlnf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UR56goIp; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7900ab67562so59072627b3.0
        for <bpf@vger.kernel.org>; Sun, 04 Jan 2026 04:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767529802; x=1768134602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKy0X0XlxlcjI1cU8qAHOVK/4C53Fmoj+OMhrX6dTQs=;
        b=UR56goIpoA0XLk1UFsPiGrsvYV1N5KeYERJ6Unhjzp+cHm0NmK2HgBDzCz4TVCtrNE
         ALdVggr6LHR5Cqdn9LRcLXV2zA3+fKLxxUFFBPCmDqP6zas+onUo/EKJ/aRE8kLppTn7
         Y8dmhQxuazBKL5ZD8X94V/+5VWpcMEasTjnIQNgS0jvsdx90sWsRjsbvXaTTc92qmbN2
         gd5lVm74Hh5h+Tq9YEqLBBIImFgzwjYsUYfZvs24jA+kzWHGjjP+DSANPMHIshAyfEu8
         rZiceBa6nPxENOHPxOYiuVXk86XRit4nDz2vcsD178tUBb97z7f6isD7K/sJ7pk2XFZS
         lzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767529802; x=1768134602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MKy0X0XlxlcjI1cU8qAHOVK/4C53Fmoj+OMhrX6dTQs=;
        b=whlwEIVSsyCtQ5I1QMQZs1wH1s6hg1GE640honGv/oZKvI7o6T4AfyiAtDbHDai841
         /EYFQq2S9YT5B7j3Fn9hWrfSyX7UIUeGPH2FWtlATMdIkGRjoe5EHCQ+se5YTQwifkEu
         04Kaw6OVVI9r2GQPfpdbL4vKgS3zh3omPJgEylHB6xzWkN3V5dQZOEJutxtmFwxiAmjR
         Q1yOZk2s6T09Sw4IBhGvd9C+ZKG9rPGk2yOMe4+n7cebGbYUZU7hzgwGxSd4v//tzUYL
         we1sdvhKtV8vqIqraF4B8kklppJK9IbbC9N7U5CFSRLc+MoknbUkfkx6oOO0R5kIKApD
         KuGA==
X-Forwarded-Encrypted: i=1; AJvYcCUI6pcezkBV3yizAXf/j4cNGpnfKd/ZRKrlYHeNkk8koTGtqqKtU8lOFQfuI8AZPCU4wSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/lqBpkUS9T1Ri/zsAbCLEIXON9LOIREh8GyxA1tlDbiZOnchR
	w917y2dRly7k4zZ5ukbMdJ+dwTWQp7fhOvf+i9vL6RXlI9cjvQGvEWTH
X-Gm-Gg: AY/fxX7f5oN2epz+S9Sy5x1ZQs08rgsYpBDuvHnFP9VWos7n046Ue7Ogo55ibeolWdV
	WD9PphhQfLfL+axcbNagbrAM6KqUFGZTh70qd6KfYrwtFXsyCf/srbyDoa3A02AhGCklEqH8tQl
	ZKV4sSSIlwa+TZ2KCl5kMIiX/g9zQHuEp1nJLa/+S+ei0+oCPM2228Upj5oTYVzUnKgXw8e9srX
	OPe6Kd5HFjFwVoa10UgHiyPi2A3JfKZwvBXojekTbYCkvS/RCz4Jvoj45EeHZA7n/xIaXODCkfH
	EDl+ULPKcCL0jHCl5VkhRyfh3gZuaRPf1aBmGUJb4I4ZP7USdXD1a0d090Xx547jDl6p4sccons
	jKqy4NeqHs4h8XZXXTOsR1QCRDxe8tbQwdZ5/3R5fzTM8rPOx99eC9h95F1lgtcuYQdTH2i32Lf
	s5i0+g8ks=
X-Google-Smtp-Source: AGHT+IF9aWW/XLWaxSzp1Z0Y+8CoeSNf0aI2UoJSmKodmODLwXZzd5seFMY7pe0MwU57/c3Mxk/1Jg==
X-Received: by 2002:a05:690c:3513:b0:78c:7ee5:4434 with SMTP id 00721157ae682-78fb3ed3008mr368580467b3.10.1767529802261;
        Sun, 04 Jan 2026 04:30:02 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm175449427b3.12.2026.01.04.04.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 04:30:02 -0800 (PST)
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
Subject: [PATCH bpf-next v6 07/10] libbpf: add fsession support
Date: Sun,  4 Jan 2026 20:28:11 +0800
Message-ID: <20260104122814.183732-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104122814.183732-1-dongml2@chinatelecom.cn>
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF_TRACE_FSESSION to libbpf and bpftool.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/bpf/bpftool/common.c | 1 +
 tools/lib/bpf/bpf.c        | 1 +
 tools/lib/bpf/libbpf.c     | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index e8daf963ecef..8bfcff9e2f63 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1191,6 +1191,7 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
 	case BPF_TRACE_FENTRY:			return "fentry";
 	case BPF_TRACE_FEXIT:			return "fexit";
 	case BPF_MODIFY_RETURN:			return "mod_ret";
+	case BPF_TRACE_FSESSION:		return "fsession";
 	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
 	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
 	default:	return libbpf_bpf_attach_type_str(t);
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
index 1a52d818a76c..89d6f45ef058 100644
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


