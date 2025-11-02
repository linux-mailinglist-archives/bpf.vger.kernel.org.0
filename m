Return-Path: <bpf+bounces-73265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88668C296B6
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 21:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E71B4E62BD
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 20:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E8A248F66;
	Sun,  2 Nov 2025 20:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbMPuZE5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AEA220F5C
	for <bpf@vger.kernel.org>; Sun,  2 Nov 2025 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762116724; cv=none; b=Tztum79NflpW1Dpsv/OTNbTL46WoXcAj5ImmFWDQtuXeyhZ1mlsYQI2977xX0m1eEULt4ITwa3xPuPkTv6AhOFRIMaLHs65tiVoYxNZ97hheIFYGwv9nYgaUMmq1znuaxpVzBuifNmTBJjk2SsDmmLb96jsmW7JJ6keclltlrzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762116724; c=relaxed/simple;
	bh=h/H3jKCaUNS0v4/PB8F3Btz1k6QZB6pf+HwNnJ0mcIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HASvo99D9QwxcUtorSnU2u9X0/7d2NHvyNv7Hk96eulqsSHoCtHO+6yF+ioadisty9R8e34vhDjOO5kzg091SA4Xvxj0l3Tx0OFtjiTt+92wWJ5AqKo/MMmsw6ZmWnfi/6yl8LOubP8D/jP56i6EKovqbxKyfk9LqrEGeRALsp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbMPuZE5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b70fb7b531cso21436066b.2
        for <bpf@vger.kernel.org>; Sun, 02 Nov 2025 12:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762116719; x=1762721519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywknrftBjNyhxtILJZTbzsp0u8rThEFASWWoC6kgwfg=;
        b=lbMPuZE5SwF8qJugeorWCSlk+xZ8jWseUz+zKOeg/B3CSlYwgJGAdURBRC3q930klN
         ZDS7MiuVZmMdlXhrq3Qu1SDisQCSZgEdUsC1L1eBL4nlEILTZKl+bOuWHSXDqBV5CSI/
         l1teAy5Bm+WUyma2IGmObSIq/rQVG/9PmonIBrMm6oiz9DY8M1tRdsTekCeK569kRfEe
         G4xrHb2AkvJ03SIahOwAIzGkyDMy60WIGQ5CqUhPM2qxRK6VLGZqYT7LI6YcC68D7r0a
         7YbJzR0McpK8bEK2xypyl2/Sg+4NgW6EaL1wNt5Z4jijMC+jBJcz91eI7snRMCm7P9I2
         1Z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762116719; x=1762721519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywknrftBjNyhxtILJZTbzsp0u8rThEFASWWoC6kgwfg=;
        b=sJ3LlAbIt0WCUBcmOOrnBRqdnmx8+N+b5iWEI+DMt3whuWeRKvASVI+zoW+xVJ3LzU
         UAhP+ZPrY/Y9+yw9STOR80V9YtWGx5d6IO6aNZuLLUgnW19GlcR4g/lS9nv2TP0zEqdc
         EPCNoZ0LbJ4+awgJBLW11q+Pa+bF+644lBOT2ugeBrGFSq7cE2rS3gHoiASmfE3Y4jkD
         yCyM88WuhTopvWlh4TdP0VtNGydm07mwtBjPoFPr+EEdF24OtRGWm8gFvX3EVGTbNncb
         m33VlAFJOIPLVJvgLhzbIMSBQa+fpikyYPEZwF0dS3UFN0RyyvL8mIuFGN69RyY0r4Wx
         tmBw==
X-Gm-Message-State: AOJu0YwfspdlyID+Bdf8D16HgA6aZkcjqluAzBnHmuxXGm9aDRu2s0av
	srDiLly51uMNQmHTQ6vXXyjq5/etJvlpE5OpJNSnL9jItIAQaMX60WntM5Mocg==
X-Gm-Gg: ASbGncsgEN9DMST+eVVQa8bZqu+W7LqsHge0O6TOS0xEnC6UaLqNUCfGffsBQY01iCt
	xk0zSb24Ky8lNAwzTb273oeIoXyf2lBj3PebUAVuRFdL1YzJy5IyA13xG/TCqVe/1XS16wIJ071
	cS0CtrrcC4zefvBLBYiwD/NqWsJsuR+1wKBKjlK8HXg/U2rYKp5k9DkbKTMnCqA4O8alLgCXGN0
	EwbElajOLUAHNSpNXqi16LpEilyhC95jO94RB9YFi1cuDHB73UgOBhoIQXPdLTDjDa6zIC9unX4
	6r+Gub6nhWdW+L1tvkqt2kqrw/xCsaiw031K8VAcB4HX0nsdy6NVeskS+hWfFStW+cUkoe7ATX3
	Q/A3mfLSQPNxPB+e3MC3qiGk1y0WKp2PJZPP5zJwT3Pz7QqfHwWgDSV9yIubmuPHFya810M95Fr
	GRx3XrZf7R+SpH8GdrcM8yUTLPhPuO9Q==
X-Google-Smtp-Source: AGHT+IGq16Z74RGNVwWfBFnELthg0tWax+VMbzncJ3/QJTIP8uaJIIcTZuuo5CBxDaBe1UnMEI1G7w==
X-Received: by 2002:a17:907:608d:b0:b6d:8d28:1687 with SMTP id a640c23a62f3a-b70704c3dc0mr897873566b.37.1762116719417;
        Sun, 02 Nov 2025 12:51:59 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b71240c245bsm14029566b.10.2025.11.02.12.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 12:51:59 -0800 (PST)
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
Subject: [PATCH v10 bpf-next 09/11] bpftool: Recognize insn_array map type
Date: Sun,  2 Nov 2025 20:57:20 +0000
Message-Id: <20251102205722.3266908-10-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
References: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
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


