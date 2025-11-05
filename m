Return-Path: <bpf+bounces-73588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E35E2C34A8E
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 10:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B47CA4F9040
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596682EDD50;
	Wed,  5 Nov 2025 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8TsVqSt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E642EC57B
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333083; cv=none; b=kactMefBpcNYqVmaH9NOCX9LfC6Kl/QDwfCCaCN0HeEq2FNM8jaUKwK1alifywEaK4OUauoHz4gmjRaMUkeqPPd8hEOM7kzX5PxpUodleh6GQ4w/0ycgetJmbkP784VI4jOUcP3IN/Iv2THdErO/AfTPAqXe+q++qHUMq6il3Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333083; c=relaxed/simple;
	bh=h/H3jKCaUNS0v4/PB8F3Btz1k6QZB6pf+HwNnJ0mcIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+uO6iOu+VXTC0y+HOu8mPpJ9z5aqGXqTkUZs+gCowHEQlaN+Vm5/1mAvpIqWAUFW9YJSy4/v1qJ2jXvyhxXRwUD/vU/hCrBOC7lqNN68UU2Au2gC/qhbgYcyvIYVh/4A686r0sF2v0OGYSOkj5wXId6/DEIPBQd4uzh91ZJUPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8TsVqSt; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b710601e659so477623366b.1
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 00:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762333080; x=1762937880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywknrftBjNyhxtILJZTbzsp0u8rThEFASWWoC6kgwfg=;
        b=Y8TsVqStMNlCcffWVa4Blg8fO5B80MR7l6XqGH1vboFZm2s8dlDXSwYv4Ttwk7BBkJ
         A1XMErZlFZicKqJVk5CInT0cqYeSRIbPoS9t8uA0eKKwUID7EZnGh5d4Z93CHCVdlqIs
         1lFLL3/s8T2bYFiggZKPsvYSUD9mzuMAB1mupo6131BY+9djXzmL5Q0SFlorAMXpuMEX
         kLhr4SoDwhJ8pqaE7YIRjJnV0mDi0grDPTIkZ64LmWxDWRR/TQ3CU5Gn9eG8iGFrm+4/
         aoqnBADy0m0jdmR2X9nUN11jf81iwMCKfC6BLM4vVi4e+mgwj8Qq+XK1kgyeb+r0uuZU
         7GtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762333080; x=1762937880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywknrftBjNyhxtILJZTbzsp0u8rThEFASWWoC6kgwfg=;
        b=n6ZiRd++7lqxHHDGgwQ5uQQKpu7e5p73WeClL7+q1q3GBYi7d6Gbqvf0L8ZI08/yE1
         Y19Y58DKnrWrO3NOAogQGILxJJiPAlzHcHTakRq7LxTnVegynL1plN6VD9FwXJF9Omrk
         Ubqww0hqy67r6u3tBuc6y5iJlz2Qva8qg38bwFD61BtT4Np/cYUFnqByUQLxRfNmdEFJ
         1N9UR3LSpB0WVacVw+f9GqJM9Odb0F4cuYiC+59mo7tgoUd2ZWkdQp26BOF41gYACilv
         WIuBdMetT6zhvkF/EsAuusiUMSxSRTQDT//0lyqIKs6S5cIhTY2GOcWYJ/5sozd9XTIV
         A49Q==
X-Gm-Message-State: AOJu0YylPmkj/G1lBaCwzs5tJozv7R6EMjbm7AolBhSuq4CdhXcSguW6
	hF9bG2f2jc+wNkgsXAIeRAwbLY46PIjH8z055CVY4oGjaXYxLUmYpNTBmNDFyA==
X-Gm-Gg: ASbGncu7GmBUnrGx1jqVmmbGACVgZD9fiPkcLHLljNBcE6k0FoK+YFA68xzrCoVVSZB
	XiHBoMe5bmMvnGiGUjS00+1P+oNfd9xuarTnBGVys+7WD3O0uok/DPD0qtWz4x7tmBTrJJftkR9
	yIkdDr88x3ognHX18oCaCmus0yv7LORpQrLsIXEdxJK2NkJbBJFebKCZ26Ff7xpVkTNzShT25T8
	rVpzLzXK6yxXpxR4XSLQ08THaOFhJm1GFkFX8YkRy5wH9G3SJCIuIEf+mHT7bxO6j3R2A1XIvFy
	pe7WkwsMJOyZN9l7QDekSBfRiKt/WNSAqpWJPdD36n173Ymfwe+d0Ojwt/kSKPKxDJZN+n5SajJ
	OQHtc/3GxnNV67vQqZzy/0WiNyBPV5AL4iohtSPUkRx49Y1OZD20NCxD3xBDmG9ODTiPYavI7KH
	oT+UkiUwhPIpUuIfN2nQE=
X-Google-Smtp-Source: AGHT+IFXkvSjIhTdaPdFKlWo+hLfFAT5UYme5yAVDvyn1VVsa9PAnZg+2fMDimrRpFTkiH4+wyIiWA==
X-Received: by 2002:a17:907:96a8:b0:b49:5103:c0b4 with SMTP id a640c23a62f3a-b72655a6b72mr222704466b.56.1762333079740;
        Wed, 05 Nov 2025 00:57:59 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723db0fd12sm429685466b.32.2025.11.05.00.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:57:59 -0800 (PST)
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
Subject: [PATCH v11 bpf-next 02/12] bpftool: Recognize insn_array map type
Date: Wed,  5 Nov 2025 09:04:00 +0000
Message-Id: <20251105090410.1250500-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
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


