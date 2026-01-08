Return-Path: <bpf+bounces-78184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F3379D00AC9
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 03:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18DAF300F27E
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 02:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C09C28B7DB;
	Thu,  8 Jan 2026 02:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQu4Cg0s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F41288C3D
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 02:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839186; cv=none; b=r+j9c0uWEGi9PdAxaAxOr2vvs3W23gFK98phunowUri9SN/E0g//BmEuadcpByqfpUcMOxtg7OaYJ6Yhze43VBuWgL3oCB9VESobCTFklqt4q21PvWNLDf0wGQOKM4zcVySrSpxdYgqzIs4vfEhyLNM6dEwAOH1nfjVKABT2C9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839186; c=relaxed/simple;
	bh=6BAjC/h/VbSD1F8qLcHMXta1kjnk/yDOcwCuMgQVEJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ch9ySy/K5f3BcbeOI45eohccIzwQw48+c23E/m1RM33T98UU7CQQiOOx/6qKtiOlsfbcfbs9bJ1sFFfePt4ssFp5h0L6nwns9HZCcve1y+pehXrCQrKh2mmRPDQnDnq6Sz8P6mNbD/5xxmLvGA687op5oW5ph2ZDxL6+MS7MqDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQu4Cg0s; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-79045634f45so31902347b3.1
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 18:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839184; x=1768443984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZvuCmGFnis+CKiifUfzQyTCYKAPuIWEe4J1fR1TapE=;
        b=NQu4Cg0sAzmyeI52aaV/0alld1bo9mJUZDibUjUJuvdrBIbPHd9OdW66w6QgkcJTIT
         4H+vMysIXY03urigOmlpg0gspEev5b16MwThM+qDjjlRCkCCvogtO8jpXaZKLEmVzlJk
         etaylxZsOuIi/v5jfsFiXXQp2l+R70mRKVTyFCvBWG/bn9Vl513dscx562GPLiQ+5WsU
         ifZXkI0D+edaI4zb7MqtA7mXbxQCImTuoh3LjVOaRLRK0obE3hJbpWMG+OXRxgoq4Ewk
         G1coVoblzRztZ3zMZnQ5ftj9m+Bcz4h9rzjmG3fmZBOaP8r4qyAf6eJGYnltudXzqBf6
         a99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839184; x=1768443984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wZvuCmGFnis+CKiifUfzQyTCYKAPuIWEe4J1fR1TapE=;
        b=F54I7CdKfSiYI47cTOnBZtrNo/Z/Jk74ktjSTGqMoKuux3i232XMZmL1V0jgxoAcXz
         JLfPqPZJHJ9tu3g7ggYk4qKrS3bsUnSs29/f1OLeUfYGeJySMrNFNm/iDdFIaBRIzAmq
         YiGMpC3jdWuMWneo6Qw/BmgPQZQ42hsumbvgKomH9FScuSvZikWgrFYc/UcHUir2fflb
         Mr+o7TiLla+3htI+tkfsCjO8/P+cM/Btl+D4A8uezKD6UyeyiFuoDbF5DOm2aWUZYkcD
         +Yxa6SIH7hd4Ze7gRBUOCSUdoLZKGq9lmOEGU/nrsmA7/FPv8f8+aSAsS8MnXOu7QYxo
         DRHg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ0xAW6lkozGUG/XmhHljbbkxExV32tj+wbf0Epa5RVuvief8d0Zvdbjt94JWGn7wNnZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ5zQq8q7CQWnAkunBBH+QgTW1stDE3EVbw1zAgxrEMda0ESK0
	9jof8QDsQ9gWSy8BGa7WlcDK5u2HzVMeRwiQ2PJUSYRbQU3RgFuSTr5H
X-Gm-Gg: AY/fxX6Z0+QSfutSlDzujlBCROEn8eZBJuhqIkOOuKrLnHFjgljmoOK3XZzhLuql2bL
	IaADaFfrjpjM+qHHA9O1I5DryDUCcFFJFsz9yDnzmjYdxmMxnVS+0PGXeKBt7R3pZKDVyVK7QAx
	LY956PKv9WtCUKJivXaxxfi8b2KbbAU0STZf2zVTR6kuVJz+WncOvSb2QDbk0RgC5TLXZMGVnxI
	fByV3JARd0C3WLa561V31yx9l+mNqmDCD3MBY63LRtuSLrMICUsn1gcnUwhJQaFUrmQY1AtN1c/
	DIIxhzu7Md4hatdivSpgDGPsluDVAOVynKdPLSsfNOcy3cEMQJPxShgc8TFOH3wvmOtHQBw/AiD
	tGgbkj1czoMmNQtEvimbpK4HqohjA4Xcol64+UAC0x5/5sblkwONs05VeBXoqyu0QTTFsB0NM5G
	FO6/MvU6A=
X-Google-Smtp-Source: AGHT+IFFUkTXq/7pSN80+t865ih2mWirCqzKTDpTj1/OqoorJNS/79kjqGfckfZs/EJueHVA9zaKDA==
X-Received: by 2002:a05:690c:6c08:b0:788:14a2:8bda with SMTP id 00721157ae682-790b580708bmr44723687b3.38.1767839183866;
        Wed, 07 Jan 2026 18:26:23 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa57deacsm24855027b3.20.2026.01.07.18.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:26:23 -0800 (PST)
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
Subject: [PATCH bpf-next v8 08/11] libbpf: add fsession support
Date: Thu,  8 Jan 2026 10:24:47 +0800
Message-ID: <20260108022450.88086-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108022450.88086-1-dongml2@chinatelecom.cn>
References: <20260108022450.88086-1-dongml2@chinatelecom.cn>
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


