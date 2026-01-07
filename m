Return-Path: <bpf+bounces-78056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2793CFC399
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 07:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8205300FD4B
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 06:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6949129B8FE;
	Wed,  7 Jan 2026 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaJSl8lu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7427FB32
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768334; cv=none; b=gPhswSa0IapdamItJDGHhW0IOGOYL9dK8HL5J0yuppzAJkQMlSzShGn9G6y0COd6RMCDnn7WoC31vgjqZQPjSnPgcQctP4U4dwcPsuN/lLDToMEUNK14iK1NiHr93G7MH+2ef6PvGkCYsqvBqRCujvNkfk9aFLvSwqcGqoPcAI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768334; c=relaxed/simple;
	bh=38EFZU9SO7U6LMxWk1zoyW+hWkQLuXnfoO/nf75J5dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GX6+B7BqbDMkBLkSOaNKFpaXWr/eih4QbmQfJCSMj1iAWmO5RAHx7ty5+NIDZ6Mfv4FSybue6CUABtply8zm1Ts7SnwyaiZRQpfLQCS8FNvSuS6ySvgxo96BSWaJ8xPHtg1h6xwDQxQV1eHm/eoREmqe794NtM2vOuwW7/OFskw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaJSl8lu; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-6446c924f9eso1487590d50.1
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 22:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767768331; x=1768373131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRIQ7Wgt3vABzQydK8+/8/bPVfaCrBmV63dZ8jFFcOQ=;
        b=BaJSl8luWFvtDGIlpT/STPAI2o3YYzgG6gCSEY/emyY8+2Sfj2K9UCRhA/7YmCEx0W
         6jVyEBbcZXMP1qoJvxsRJuWW+FaZskPNxprnEwX2UQwo+xFMUEPw2vkIf8q1B2SoLajt
         52VU9tFQw0arCwo/FWqZ51EokeafcoN15OHBAo6qAj3cLLeNoZ4YoCltrh3ytOXxmheE
         6+vIgxmycul4JvQLj+kkGins/XTWMjgxlZ/K3NoREsF5UtJq+apdzc3Na9UkRoXFjDsO
         Tg52pbx4ZTsAqqcssyLgR/4mQASiLJ5/DB6OGSB6Y9mHhcXnMp1Q3f5Nu0Ft8zRHJlVm
         GmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768331; x=1768373131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YRIQ7Wgt3vABzQydK8+/8/bPVfaCrBmV63dZ8jFFcOQ=;
        b=d2p9jDCK0AvSKSAtcB3oVxy8KdAnNV8m/D8In43LNkm5L05lky7p+4ivhUDCbLQnH6
         MBsIzHBKY3D4y2QaP+6DflIAVSp0BNtNYzm8r/kKdE0F8B6ta+MQZyciedhw2O+7NWT1
         3n5nJIqPdp8sTRfC7pHB+ZFgSs76J3eCErbJ7taBkcGjpQkFWkPx+8XJA9nlkohDVJ+d
         SAJwYrhDfexQKF2qD6ieHivOtiWGq8ERj4QbErw+wsAYm55q48eE8CJf2RO4CX4E4iKy
         8bObpILFpNzNo+eLwM7YD+s4n5TwjeLLFwh9HxDZLF8Vqt+Xsd9d+3v+V1lQzqpk1JiT
         vNmA==
X-Forwarded-Encrypted: i=1; AJvYcCWcbZrEgLabvEIOsXo+Iyi3FA/7n1bNvYY3If8lO2LR2+0B51PYTONMQsHTjaAHiWeq7ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YywvFvv8ksMVvSsD5T+dM4yOqIaQUp1pBeJsHqYRCyhBXx8e8LR
	uYXlDhn/R2ENela6Mm50Ve7LDDUT9NumHCXoD4sDOPXam8Op7y+Dazpk
X-Gm-Gg: AY/fxX7MaiSyjxGTBMbbCGJrBxciJ1I9HHZmnChnZs9Xnq2T4GGvzsxs/K1671RJuwf
	bI6y38QATRbykgMYtKAbJvTMbtRz4Vuq63zaIwQjqAYAJPu+YRG58Q+OojYZS0+hUhx18ckPYwi
	FGC158cIU7UUf/8AG7SiNU7cT9M05LCmTsr/MaZHUBtaqO4MbyuqKlwvFZ4CExNyQLZ3Y4+yz8/
	Xl21HBrQ5gQ4CBZVni1uhNgCHxL1T826XUq+R2Txru9ILvsgdSCujm0Jfma3KUiz+Benv+Zw+40
	2Mhg70t5I1JUuEvdKhx25XTnmn6wwDOYnhfJ5kgA4dIfi9qDi9iSKi1oP3c5KQxfGSpwITqpBXG
	xc+sC/h6QTalNld/CjoJ9yMIGr18ZjNZKwVT6TJ5OvUrAVbAsMqlB6DAelFopHkvNfC6nl2IZQ1
	3dG0wuSYY=
X-Google-Smtp-Source: AGHT+IGRWEofOcq5wuRI9ET+y4onyXMcVVrrexW6pEOpfZocA/LjmKomcwJLUi2JlI2SIEYuiekAAQ==
X-Received: by 2002:a05:690e:1405:b0:647:108c:15e with SMTP id 956f58d0204a3-64716c38402mr1382110d50.54.1767768330922;
        Tue, 06 Jan 2026 22:45:30 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790b1be88dcsm9635047b3.47.2026.01.06.22.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:45:30 -0800 (PST)
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
Subject: [PATCH bpf-next v7 08/11] libbpf: add fsession support
Date: Wed,  7 Jan 2026 14:43:49 +0800
Message-ID: <20260107064352.291069-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107064352.291069-1-dongml2@chinatelecom.cn>
References: <20260107064352.291069-1-dongml2@chinatelecom.cn>
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


