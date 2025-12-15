Return-Path: <bpf+bounces-76568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AED78CBC58E
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 04:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C043301F24B
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 03:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31292BE643;
	Mon, 15 Dec 2025 03:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAHQGox8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24DD299A94
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 03:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765770166; cv=none; b=TPLUkxG0lu7fF+IhWFZCRRJGtcoXtkx27lJ8UE99t2nHTo03JhN/kO2vhi5Dwic7cJAqttd55TMf7GyQ/8M73x7IERMhe+JVevyUKInneIQmAl+AnSOQc9AHTBlTaKejSUj+jxwTVeN5M1BfEr7ek9Vob6jb31LY3eb9ChzARqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765770166; c=relaxed/simple;
	bh=yGNIMta8W5fCJfVCRLduvS9JRYsFtLAV7Z8MNBPkCso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kGN5OzCbiUrvtqdbuCD9v2zaPDVZledcr1R5SaEIMDSACSAHnAjDwrtt9t3S31EhiUqmpd/fPJvUljG1cRQtHUQim5Frd1xvy84U9juldIZeVOMU0aE2qFKLpexRrKKVKiyEqki4wRe0LZER6bipEfvYqPfYccCDqfJHcNA/Uac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAHQGox8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29f30233d8aso27445565ad.0
        for <bpf@vger.kernel.org>; Sun, 14 Dec 2025 19:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765770164; x=1766374964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5UBV2dmchl80Cv5GOle8EKJ8orIpqARGfyikGjXPIY=;
        b=EAHQGox8fuOksrR6LDr9tAsS1HTRn0yac52jvD7dN/HO7278i4eSlh2uoXpRPuaacy
         c4pNPIEZ+wR4x/L5LP6tnKvnyQPHbyZx5jBg3n/AH/Tk5wuZtZ6K5UZXuH3F+6NOMj6Q
         5/lKLCxaeUiKlo5bnBFAz06vDbQKMQzWs27j+IVsKzlwQgUG4i/P8mYomk0Ah6LipwnG
         o03fSshtnJnJ8VIJ4UWb9Aas6T6OpLvG+NODO/lZShdGPIV87uzaBGYueJ+BbWUSi2mA
         0EcFz0xCUvHtBGYdw290qZPVxAuOTe0b3E7HoF9D1Pl5cltIt4dYPPfpJav/ReMugX7n
         PDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765770164; x=1766374964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p5UBV2dmchl80Cv5GOle8EKJ8orIpqARGfyikGjXPIY=;
        b=LJPsHdPvTpCaejiQ6jfnP06Ii0LHnAESSpvWoWwPlLfMeTvPXIpM97k6AMzkcqJS9w
         cV5FtroZMEQc15KutV3AbbQvVMkANrOswAA6vSUJYvb68lPVrZp7M6rkVJ5w8kMeghCp
         zv5c3ZyT6EQG5LAiuKQfs6SrUKFW0etnVtn1wwE5Bj5yu7KDWZB7h9yjBLFCLKbyMuPg
         64fD2DW6NRlag40sGC1FGC9VRXkNUeBdrjtVcGIJO1pcEEeWnvBU04xl2nFj3+Pdlk68
         JIrHe8Ab2wBbtGzUJj3beavy9N/jaZfQRrbtXJU+gLgu4vH8+NtmnrMPlT9Z9lQlQQdJ
         Vrlw==
X-Forwarded-Encrypted: i=1; AJvYcCWILVVpiEtVMoRp6b8EJ0icpJAU1w/O1Bqohu6yLcbH6Je+4NWTXdVpF0qA1Bs+92kZJZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTfN4PvUtJCxVxj/O+sJlJcWR0eJXDtGkxmvcbb0rfsgZz72zl
	1Xmzc4YA/97BD+jry89LvUYeOJdSfdu0y799JsD0fMMiki9mjjyNS0EM
X-Gm-Gg: AY/fxX7n3st2k8n3+KDaQK7d/FK9Yd6dHfg5MyyuyQ8UxMvAhKKqz4KszvbXPyo2AsD
	q7nByUGeDr1LntjADxqr/m0rJSppZUSt9kDDq/0dMbotieA4QfFZCpFKPsBMr53cKOOVpqHwV06
	icWbSF+Eh4on9UnFdGOuMkU1Yhd4IpVhTzkZWgFfJU+wQQGtr4PmeiBVZ4IrlYXdQiFPtanYYHP
	BhOX/rrdFJ1Jl/DQEefj2gntS5W5vTVDv/elDnogPaBqAHZzHN5UtJb3d03YuvTd/SE9IGBxFUD
	xMgoTgNVFZRW+cwFzN2ttUwuyHs07vPeOFR0JUSaSe9diU6e/2xqbiqbSU9ZNrlQsdzsFkdyyFW
	q2STOkrDC372qJ1rhmfQ+iSENYZF1xynMlZbSt/iCfu2Bwy/+h43k8lTg8Y5JTaXeDpbDX2+L11
	0OMz73CKUiAvx8oTYzo8DVavz0npg=
X-Google-Smtp-Source: AGHT+IEv/SYjvRWH1owJzIiSvcEbD/HWRjgkyxil80rYRGJmI57RoXZa6jI2N8QcNELLK7oHytfmhw==
X-Received: by 2002:a17:902:d2c7:b0:2a0:e94e:5df6 with SMTP id d9443c01a7336-2a0e94e5ebemr19780285ad.50.1765770164019;
        Sun, 14 Dec 2025 19:42:44 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe23a207sm3420562a91.1.2025.12.14.19.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 19:42:42 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: [PATCH v4 1/3] ftrace: Build trace_btf.c when CONFIG_DEBUG_INFO_BTF is enabled
Date: Mon, 15 Dec 2025 11:41:51 +0800
Message-Id: <20251215034153.2367756-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251215034153.2367756-1-dolinux.peng@gmail.com>
References: <20251215034153.2367756-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

The trace_btf.c file provides BTF helper functions used by the ftrace
subsystem. This change makes its compilation solely dependent on
CONFIG_DEBUG_INFO_BTF, allowing features like funcgraph-retval to also
utilize these helpers.

Additionally, the redundant dependency on CONFIG_PROBE_EVENTS_BTF_ARGS
is removed, as CONFIG_DEBUG_INFO_BTF already depends on
CONFIG_BPF_SYSCALL.

Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 kernel/trace/Kconfig  | 2 +-
 kernel/trace/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e1214b9dc990..653c1fcefa4c 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -755,7 +755,7 @@ config FPROBE_EVENTS
 config PROBE_EVENTS_BTF_ARGS
 	depends on HAVE_FUNCTION_ARG_ACCESS_API
 	depends on FPROBE_EVENTS || KPROBE_EVENTS
-	depends on DEBUG_INFO_BTF && BPF_SYSCALL
+	depends on DEBUG_INFO_BTF
 	bool "Support BTF function arguments for probe events"
 	default y
 	help
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index fc5dcc888e13..6c4bf5a6c4f3 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -116,7 +116,7 @@ obj-$(CONFIG_KGDB_KDB) += trace_kdb.o
 endif
 obj-$(CONFIG_DYNAMIC_EVENTS) += trace_dynevent.o
 obj-$(CONFIG_PROBE_EVENTS) += trace_probe.o
-obj-$(CONFIG_PROBE_EVENTS_BTF_ARGS) += trace_btf.o
+obj-$(CONFIG_DEBUG_INFO_BTF) += trace_btf.o
 obj-$(CONFIG_UPROBE_EVENTS) += trace_uprobe.o
 obj-$(CONFIG_BOOTTIME_TRACING) += trace_boot.o
 obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o
-- 
2.34.1


