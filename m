Return-Path: <bpf+bounces-78470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 59134D0D702
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 15:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78C6F3007C2E
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 14:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A15346A18;
	Sat, 10 Jan 2026 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFjYEqd0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6E72E7F32
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768054378; cv=none; b=A+0WyE+hDzwpRnakUfuVJ3FNuWcGwG/yx5Va+o9Avy7Nsh8ZHpDD+o/ITGmK8VpQ8clHgJhMqbKv6Nr+obOlQM3oz2vTduff+Yylln17BLkrlFWU8kBWYwgPpHN7x2qTxNJUH+fBx+OjTWYxnVV/cwgbhDFpfi38/vtfd+X5Tdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768054378; c=relaxed/simple;
	bh=6BAjC/h/VbSD1F8qLcHMXta1kjnk/yDOcwCuMgQVEJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4tUHv4VzHHMazvKG0C2uC+xjI4wUDE6JoZKO1BDclx3ffLWs2GZ/O1/ATKIcUnBRSDMuRu3urIznRsMHnfma7qdl1SIc1M7K+KirTMlApKTCs+IyIaRtKjil4nhEoNvnzRxbYwpoGKT0aR33jTE5euePa5H1ZryBbPLv806AZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFjYEqd0; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so3509689a91.2
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 06:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768054376; x=1768659176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZvuCmGFnis+CKiifUfzQyTCYKAPuIWEe4J1fR1TapE=;
        b=RFjYEqd0etTf7GP00cXHNQAOfmOVeTt523/9B/PYw84T4R1f9ybOjY28di7DrnWcff
         ZxapC2OEaB2bzGPlcRZF/ojxH6bPjevLYRqAnc5zDQSCRRZq+Z7SZ6KxTdMd9h/Sy6Wk
         gX9ZckpnOtmItwehWkVYDcixsbCA5il1e5+G1Zg0hfA8Jnwq+xwwFmP12EPe1Hy4zhMy
         ErV35kqklnoQFx1q3d/x1MoPcriIN+8tpAS+IUu8kza9oFnq0XX/r7JAQ8IuQ2NA5kKr
         uSu0bSkz++KNk0W2lT5nYcGxEoch86DpxKkDcywvv17BHQOO0jydmo4Ja0Q12i45eZW1
         o5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768054376; x=1768659176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wZvuCmGFnis+CKiifUfzQyTCYKAPuIWEe4J1fR1TapE=;
        b=p2n+LDJGTNvuZWzM0FzXMwph27e1BQKjwOJVJZ66V09/KtqXnZG1tosnP5o0ipQ+0H
         oWOUJFtEMiQHAmXCN4UsngaPPeOH0nKh/aum0OOmyY66v5kYadZ6qGuQh/rmpcn+ZRCq
         enIKXXX+i0XYiYhx6zX+XfFMzcgw1DHUMv3KIapMwqVaTka5zoNj9vXjCfdE2jbfm7nS
         cm/Hk2XorL8zzmAJIFzFS7pfRt3pRUz3siWfkBWr7SyH/EBwbht5m5IviDjE23k49Rpq
         1yIAFpl2F0+3lX3vOxHqMNJ/gb/f+pJPNIoSB+5eDYpHSOQuieEkSYEa1h8KTEIXoYGb
         oV+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVucqkwaAtfIwH5qvDLURRS5rHlvf099SEzbLhssaWbvGH5Tar0sqLYO+l8mT+8qzrtLJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQfU2m87CU3MQ+qpUBVT6JPSfb1kz2qd9Cxqbsb2eUq6kRZoW3
	OjNomIlptuzJRNDWJVMB6KAPHSXFLEMehw9sIXOhAOvAXgg1YZxQEJw2
X-Gm-Gg: AY/fxX6EiY/5frJCeU/PZ4iVAaiOGrz3xg5vNrTMzIOFa88dxeeDzR1NtXoI0Rescjf
	A1EdsUxcTiIfMmXbL5IoO2BfKGc2WUiIveV1KZy86mR/vyHsyY7xOqY+5pV3y72tAW5p66Tvxba
	NGzdmNk0YNzI+W2lbEZZzT8YMveNaau1SWVtEbQ4OD7IRHQBsC7UV3U9fe0826XrqqCZwEYqQBa
	esCU6m+h9X+gRsZ6xqomm7SQpN07rH1dS+5BA+p9w/ty15+F2MirHQ4J44UfHDa+gShW+P7SH4g
	cW6lZ3RojSj1Rm9xiQ3iE4xtjxqBInLs+Tt/SomExy69STcZjnN8nVO5gVpDwsTl4FfMPgQLlQ+
	ihDe02mxxHw1PQsjEvNtstea8SSCnoHdcJDowTJunaHLUwoAf0triysDHdlQ/iD2gOskGZdo462
	NkjPEDgOk=
X-Google-Smtp-Source: AGHT+IFGZ+bG8xHT9xuAISlyvfchDBAbNmG3GBwI/BYhtaOvoHEk8y+p5yfyCVS6FJeecUMzM+SSng==
X-Received: by 2002:a17:90b:2692:b0:34c:99d6:175d with SMTP id 98e67ed59e1d1-34f68c30794mr11364698a91.2.1768054376190;
        Sat, 10 Jan 2026 06:12:56 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f42658f03sm1481079b3a.20.2026.01.10.06.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:12:55 -0800 (PST)
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
Subject: [PATCH bpf-next v9 08/11] libbpf: add fsession support
Date: Sat, 10 Jan 2026 22:11:12 +0800
Message-ID: <20260110141115.537055-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110141115.537055-1-dongml2@chinatelecom.cn>
References: <20260110141115.537055-1-dongml2@chinatelecom.cn>
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
v5:
- remove the handling of BPF_TRACE_SESSION in legacy fallback path for
  BPF_RAW_TRACEPOINT_OPEN
- use fsession terminology consistently
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
index 6ea81701e274..6564b0e02909 100644
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


