Return-Path: <bpf+bounces-76852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 750BACC6EEF
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 11:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 232AA3084895
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 09:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B2F33D4FC;
	Wed, 17 Dec 2025 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ja87KcUW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65518325715
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965342; cv=none; b=iFDdNbJc5CqJSXCO6a6Ix0Q7CB8Ck4kbbq0+MGocORSp8frugC00256JGXBCmyeBWIbimFkEF8ym9MOHNQTVe5mQ16pSWSN9LBgi9OnDRqlleGiH4hj02uoYvrm13mapm5LRyLg44Fssz5WITl79xcdqdo5x5cxpB2/BY1R01oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965342; c=relaxed/simple;
	bh=UkSmveJpeLu2H0txFtf6NwK9YZmeNSpp7nztFJDWGgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6KCqWVORTLXxLibX3ZLosnNa9lDGYqRLVQYZXdtGqNZsDOEOMY4e7qTB4t8Tbv0N0oT8xkKiVf3XkDPeZ1kk59Rdwpd2x2fUeQve+MvwZva9ldPwnP/o3jAmkyn2Mm7UCccyYsBISXX4x7X1GvxoTGqHFtca2HBr7hLr6YGniI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ja87KcUW; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-29f0f875bc5so73516845ad.3
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 01:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765965340; x=1766570140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3hISc+qVpfPhZR5W/mBA2uyXZnUeLvA3pjNsPMwako=;
        b=ja87KcUWave+KNJYXe4b3tVV9IHOIVQrvCZ5ZNq1YbQsIBvhG3Vw5W6FqSY3RVRM2H
         dPSlFo2yU4hwjmYNZAvdAuNCRSXjvnu/B/GghU+i8y/COdFND1SG4yG9KqoXUghZRMtG
         J5p+9gvneS4hbS4roRqZFr33gUgUUmz0oz16KW1qQx0YZtmwDr4MyRLVKZgH11kZ//6X
         vxVJ5pwvo/ct+QvbN+cotk98tcgtHkYh0aq8UDJuA9zH9oo3l2x/wMLopymD44alU1yK
         nlcDKG+zH33kgqheI9P1HEIM/QF26+SGiGOiKwaZR9CG18ACaXIcAhgZZieX4szZ1iJU
         y2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765965340; x=1766570140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F3hISc+qVpfPhZR5W/mBA2uyXZnUeLvA3pjNsPMwako=;
        b=tMBjCQTaaZCz5u5WAjOEMRaZUGrXGg86XkD5xckAq9Wz/xHM0jU3S5KopAzQFikQ3Q
         FFsvsqhwLu60+yiAGa/Pp1Knex9jbHsGsHBh/+EucMlduFy08ht5U+2gdNX7ODaCAG9z
         uhRbfQVM2a8MohQgbbefgaLT7Tz1wCKJHoEmIEyEj9RsiGLsY2zzAfd1tDmhdM9p165L
         T4AmoC+KO92o/vLER0Bf4G0ng8NMf6IXKM637yORhWLZdD3YZSeZQN6ALoNFUfSt3TE5
         ZqNM8/xpyLqFHVcFDZGcBd0DdSRzMjNUliXO6KSC1qC55Xe+vjb1r+1ZX/CFWVyw3d5e
         41yA==
X-Forwarded-Encrypted: i=1; AJvYcCVlX6l1gbP+2bPsEAh/MjQBXi5BdTzs1pdulCNs1fXntgEnf1gAQxSsPDMaT7/z1X4GjMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb4zS4K/HalJZbqxKfaRaj1B++8KDiHThFkvv41MNS6jd68p42
	zlhS/XB6PlcqETSFn94piZcMwPZihtS+YBGXrSlJj4oIHXKW7PDaozhQ
X-Gm-Gg: AY/fxX7FykSswEMSPNitIb21ahGX4+kclEzLuk/QxE9MjmMIDbit9EW/CWAmq1tuC/j
	QcrSwJy57sR66U+vAc8AnHzFxiFw4gkIbTzMeviwQbCkvkBOoli4b+D1myu1L3H3sDruDtM0gvX
	9Y0vIZgZkbRIq3Y3fLoizQANVBqsl7ZZirtKuG4FM3ggRHJboBbQeCQ/QmRxcuH6z8MGGkuzZXt
	9LM2LfaxRazwaaoVLvf0hwX8keO+CFlmLFLaWRvW+nwYimDjEvDZwSI6nB15xFEgvu74yBEcjoP
	fPpSGyAkVj5CynmW5sQ9re61udOmgQUcpL4DrB8HEMuQSGTK7v9ETk7EnGQa8fdZQ5B02djdQHx
	9q3nsGlvJt/PdoL5vDDEUhRUvzQS8SYVCGICNtZONTk8qofcUl8T9dwb5W9aL+FwdrRHLnrbtIY
	g++lkCyOA=
X-Google-Smtp-Source: AGHT+IE5C/7U4p2EYr4v4jB/aE1Y+kulMB/uRRmgnAOhqGAxDTc1dap1o8cF6QJMgVNWg3Mc/h9vQQ==
X-Received: by 2002:a17:902:d54d:b0:295:557e:7476 with SMTP id d9443c01a7336-29f23dfddb0mr161739725ad.7.1765965339729;
        Wed, 17 Dec 2025 01:55:39 -0800 (PST)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a07fa0b1aasm140715945ad.3.2025.12.17.01.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 01:55:39 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 7/9] libbpf: add support for tracing session
Date: Wed, 17 Dec 2025 17:54:43 +0800
Message-ID: <20251217095445.218428-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217095445.218428-1-dongml2@chinatelecom.cn>
References: <20251217095445.218428-1-dongml2@chinatelecom.cn>
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
index 21b57a629916..5042df4a5df7 100644
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
index c7c79014d46c..0c095195df31 100644
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
@@ -9853,6 +9854,8 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("fentry.s+",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fmod_ret.s+",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fexit.s+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
+	SEC_DEF("fsession+",		TRACING, BPF_TRACE_SESSION, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("fsession.s+",		TRACING, BPF_TRACE_SESSION, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("freplace+",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm+",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s+",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
-- 
2.52.0


