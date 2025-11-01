Return-Path: <bpf+bounces-73235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CA1C27C5E
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 12:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8102188D294
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 11:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE442F25F3;
	Sat,  1 Nov 2025 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjDMb01t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DC12F2613
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761994878; cv=none; b=Xs1HR2f5Oj+cdl5IhPbnhDTvcrV2sZ78QvAchRn+zzlr4wrlt8WR0yDYiycVgYNAUsvv9YGqgvA7n4gup4gM8Vj+FF+3VBqZ4E7sKblNIsiqsWdAc3wsskMimjZXfuwiTCfk0iVHE1B6BAmrac6QwndjknD362W+pVzRFIGRLUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761994878; c=relaxed/simple;
	bh=h/H3jKCaUNS0v4/PB8F3Btz1k6QZB6pf+HwNnJ0mcIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xa2tijNuvz8zMurujHz6zbDUAOEx/hUVHX/QpuvAT6ECNp77fRo4s4phNGgIk3bptqxNHkIrW0ikqoCbSo1exiOxECjDKj5KNUU5Dz6FD+VIFXG83zFhKBBStGpnQOGVYMGJz70ozbsVqyD6dbOPzcT33bmeq3d9rB1gPbKbjyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjDMb01t; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4710022571cso30349065e9.3
        for <bpf@vger.kernel.org>; Sat, 01 Nov 2025 04:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761994874; x=1762599674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywknrftBjNyhxtILJZTbzsp0u8rThEFASWWoC6kgwfg=;
        b=TjDMb01t7tW3VqYn+OY+o/2ccwFDYjtAG7SPzMvZ9LilbEn+1w13rmOM/6+EoQPOMM
         sMhF10vW5Ddbjcs2FaFu6pbbKAe4JYUAh55ij/sfi/KJUF5C4FcMXlu7Kloq8YLG8VYp
         1K8nYLV576nkCEl1p8k6IQUit5nalc7aSLKtKyeNUv+xGcFI4Dq/VwkLa4AAecRKK0go
         S4BjBPwlz3sQgeTjhkAiyHbGdAKn8322HpUGEiJO34GsTb51bslgcg6kPjzPinBub4J3
         UYd7txcJcmCENWIDequvgg0qtoIwKSCr/Pksi2iHC++bycrn1zWDdiq2U1Y3A51FyhC3
         gxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761994874; x=1762599674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywknrftBjNyhxtILJZTbzsp0u8rThEFASWWoC6kgwfg=;
        b=ZuR4Yux0oVUQXlK4QCC5p8MK6LGQ9p6LVuKBqQBOoJTLfgisGS5SUeL5mfLjPqJZ9t
         AmkmJvn57LvP8nmzxwJ0YR16rrIXoNZr5RBnorBJyvt5ZrD2eGpJ79gbcrxb2zzUMh5E
         nDb+4JEDVri+OZUiL5Ie3P8lnmy5Z6Raq0AP4QvbAltJ1JIxTrMnWyupq7PLFHUFyNxL
         QrJUAuNBWR0gJUvjf4MUQ/e7oxLZgEfhhb4kLBQI16N+k4kqZcBGCpda6rUvei5hJlwn
         x87bMvmKD1A6hgVK0pR9z92VPkSXh1Uu3ZKQyiTYvGTvIocaKoFf+FUPg1vwKKSTSfKL
         KKEg==
X-Gm-Message-State: AOJu0YyL7kmu1UPx6z3LYRBM8SluQb7ozJ4e4PuKU1pctyPbVZ2MT4tU
	G1lrnazFYkAHEJ0mfi2TxobhY/v+IqoeQ1DLKbki+V8St+EkCvMHUWIA9XIJJQ==
X-Gm-Gg: ASbGncu6edvCdXrPJRHczoSSfloi55mAOtgb6AqpVW7ouz1JKEBHhSPNJwAzts7mkuB
	zavbZ6Un27q3C7ad/5ki3ufv4+PSFjy2SnZQ62QA55JQ1+cctvBVj4jrtdDM20Z5fJauSmJMAQY
	Gt65L++YRqCIg5HYT+iHDblmr3J8dIu7muDkyGR7XBi3Os6kySn/vB6Fj+PzBWfdBfvIYKMfk1q
	ytn2AH0xBYjdCBcou122tutd25AyyAWMT1AntM5R9Z8l3+Pou4pUfKAaTO7qk54EHfMYU5fpxLU
	tZ8KIe2uatqYjFR4ailLmnU+I/1l9g+WrQ6gAKBvtY93LygyZGnha99anGWR19XIevTrzXa8GLl
	ft1crOK0Hg9T6/pgKREPyQ7oMe++tmQTuibX5YI3VVj5cyW0nyVUvsXHRkIYYHxqSZeby0YOpe1
	qV1tMYFh57Xtc8uQhYWzBPBIOb8x6w2Q==
X-Google-Smtp-Source: AGHT+IHbJn0ArTWh/wDA7S/jXoK48G1jQqoMEDCWt9XMmpssiWYtJq505i4aEP+lKqIdWUmRnFx6gQ==
X-Received: by 2002:a05:600c:3b8b:b0:471:989:9d7b with SMTP id 5b1f17b1804b1-4773086d53amr61706245e9.21.1761994874145;
        Sat, 01 Nov 2025 04:01:14 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fc52378sm38794005e9.6.2025.11.01.04.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:01:13 -0700 (PDT)
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
Subject: [PATCH v9 bpf-next 09/11] bpftool: Recognize insn_array map type
Date: Sat,  1 Nov 2025 11:07:15 +0000
Message-Id: <20251101110717.2860949-10-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251101110717.2860949-1-a.s.protopopov@gmail.com>
References: <20251101110717.2860949-1-a.s.protopopov@gmail.com>
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


