Return-Path: <bpf+bounces-72267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80145C0B133
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBE2C4EC899
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 19:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FABB2FF175;
	Sun, 26 Oct 2025 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToAssUsX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538562FE566
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761506450; cv=none; b=eJzMd+eOXWOou28AH7QgeSN2B7mBKzPHuBLtbGGuHHwRPdCEX1Bj5E2hqfaHyRMX/ksbTb9mvpmiIT5/Ii0Pfze/kEtTUIDmyTVEAtMg8EeKHaKj8RuMfNx4weRbmW6LqmaDUTq7XXdzTfnaBtdjar1nbjLtEapsH8Bxb7EiYrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761506450; c=relaxed/simple;
	bh=h/H3jKCaUNS0v4/PB8F3Btz1k6QZB6pf+HwNnJ0mcIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SvafnaGolED2REN30po5QTYVGYb3f1QvXxBZ2un2L7BLcT8H6ToccppabSpid7qWizeoA4vG+EjkG7VhWL0u9srrsbqnjeO0k+3sfh0mthuejA+qKd+0FHfcvitO17EN6ZYu/uLIwN5ZaFiDwg1+TyIevP5+DIQLQxdY11RlPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToAssUsX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4711810948aso27415915e9.2
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761506447; x=1762111247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywknrftBjNyhxtILJZTbzsp0u8rThEFASWWoC6kgwfg=;
        b=ToAssUsX8DbagRRHnWCVs+yVI19Oz3H8Nps4bW6WKPMJ9Uc5vLfp4KQcMOWQvMAtlU
         yWbKKlktZ/BiNm9fw6onAvkosqQDxEWz79fwK7tqnCp//M86HTz0NYbmeBrMka/x3c9x
         iAw+qHFLAKyVjO8uDsFJLxdW1F55SJCYbbrOECKXLGprt2EIdg1BjRhRDKU8fvpAy5fe
         d89j18z7FTEx3H09sM84dZhiAcQXB93d92+eyrz6whYUmR3Ed21D4cVM+xwkL1uyL+sO
         HzpGP3RR4oYUa+/6qONZHRfG50HmUmDyBWUREnQvGiNZHm+aSV2IqrcNYuiwMnastJQ7
         HcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761506447; x=1762111247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywknrftBjNyhxtILJZTbzsp0u8rThEFASWWoC6kgwfg=;
        b=GWBUGY4ewNKtFPDzA4I9AXKOeX0a4RLfisGCudg2R9PSciYy4FpnbApfDuycdikWBP
         TQD1jlrGZNcHVr3QmTaCTR0h5bf/oQYPRkHhbxwMHIevS6roaPA/DjXX4+BKmmAu/bWe
         jW6qC0bEnxA/BBySKkwV5t1Voh+Vhvs8+AQuDaT0GINXyo7oanqEMleS8VFz/bVxgDFr
         ivOHrcDx9+PBvd6SsLSxTfApIW9uajEqKcR2Ga3Azlc6rUddIzTDeXOtmbBylWBZN8sU
         bGF7huPZiwwD14kFj4iylAGKCnwUvyNCM10vBXTe64hpa4lrOGEnm6/dgDWq1+2jCGam
         HgMw==
X-Gm-Message-State: AOJu0Yy0O75wSFUzAIhfpfSMmwluJ+vwvsEs4aYHhLAbGWFl9Fi+OGvG
	ExQftACIQSHp/tpDWrafTNkznwUURQlp/immtmJAmA2P3JqHcZYN8MrottsKbA==
X-Gm-Gg: ASbGncuCD+TXrrtQF/+chiaCkLrvtbcC4aARiX/1Qxj8NbCdHAFtumdXHa33ZjzJee9
	j7GbeTv2w1ITCLFvESslj3jgyrSgRpRiKqb5GnX0SOOwika9VZf2EqW9/MAERh2O5Axqrw8OPH4
	L70YgRwaQH0hO4LTBNM+lmh6aE7es5/NkzOEU+6lA9qhBMUCfzn48gJCnmobo2sYBIRYumGMgSW
	KwxfDEYe43gogU0evd8W4ORiNgZDfC5l5AMF7n6niqhWJS0aknIUDVLi397E2z1Gur/pl5HmRUp
	qYpP9PYSKkyQAu9XhZyVJLAi3lTRgWfsLbmWHuGX6nCkWpXPK0bXhIVnfmzoANoWmeKPYILbcFf
	ldMQxC+BgmqXODSAxs+Hv0rofzPvfQUHfC5L7tJSVfDaCWcrCH9/bldzOQB8CZp/5Wp2AkVfvSR
	Cjb8KKpZcC/1QUIeMT5f95RXZqLHMXQw==
X-Google-Smtp-Source: AGHT+IFGt9bt3IhtlQslg7iRadWq+DzPdAG0lRHQ8coSj2OdsIG29kZ5s+Ml/ZEaS0dAhi6IECLM0g==
X-Received: by 2002:a05:600c:450d:b0:475:dcbb:76b0 with SMTP id 5b1f17b1804b1-475dcbb783dmr41626855e9.12.1761506447182;
        Sun, 26 Oct 2025 12:20:47 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4894c9sm92434375e9.5.2025.10.26.12.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 12:20:46 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v7 bpf-next 10/12] bpftool: Recognize insn_array map type
Date: Sun, 26 Oct 2025 19:27:07 +0000
Message-Id: <20251026192709.1964787-11-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach bpftool to recognize instruction array map type.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Acked-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/Documentation/bpftool-map.rst | 3 ++-
 tools/bpf/bpftool/map.c                         | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 252e4c538edb..1af3305ea2b2 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -55,7 +55,8 @@ MAP COMMANDS
 |     | **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
 |     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
 |     | **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
-|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** }
+|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena**
+|     | **insn_array** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c9de44a45778..7ebf7dbcfba4 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1477,7 +1477,8 @@ static int do_help(int argc, char **argv)
 		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
 		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
-		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena }\n"
+		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena |\n"
+		"                 insn_array }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-f|--bpffs} | {-n|--nomount} }\n"
 		"",
-- 
2.34.1


