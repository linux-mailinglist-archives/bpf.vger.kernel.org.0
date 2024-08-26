Return-Path: <bpf+bounces-38111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAD395FD77
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 00:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D089EB22B8A
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 22:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0B91A072D;
	Mon, 26 Aug 2024 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkJ7MI9G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA98419DF8C
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 22:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712516; cv=none; b=HCIuaXU1o2/WbMYcnKDLcNEuTbarLy9Ry14+5Y1ySY/LA0C5R//jUpGM3JjXDLD/NucWPCMsVOMqgjy/mhA3Mis0dKzNO1wMT49YZ4BTFySK24Hl2FUlK7zpxw2ZqvekcIJUgRDspwCkpjpFIlB9ylNLqIq0Qu+QANtcmfahzeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712516; c=relaxed/simple;
	bh=5NwOudOFWnXh4lyHo42+i2xGtw4JYG8ZrpilEYzj5+4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzfygDuxrWnq9St3aOPDDv9BbYLEb2/8BV4/TKGmIb7CgYQuqRmGMunRGGlfTifVbEGvH1f/3s50LSDmrjNz5VCAJleyZxZxW/LipWIDW57Y6dGMnKFDxT9otl+WxZTIhLrI3z35vkwGDppFk6+bS+3fq0MORXN91qvUOMDTTSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkJ7MI9G; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2021c03c13aso36138015ad.1
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 15:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724712514; x=1725317314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfjT7GSOtZtNnx63ak6Ir9XNZzCuHiDAsgy7qozHdxI=;
        b=PkJ7MI9GaZ7pwBebPxGItMcEmzzRsgmy4kLCnhIrKq7WEbJu0zBcnD9TpQyxyqWok6
         ZunoWja2IdZfxXqq+uAYvnEmSJAYTiFdEQaLkSogAnRhJGfWe4qhEhhhIDLaVMZqSNYt
         P+6rkr047EXsgscpXSnw6Hp9+aXsSlmi0iEahWGyh+sEuRYTEx2q2CqTPrhpPtVyEjuR
         jdORKvCqM1sYKE75qrIRjFsvilV7snPjsnuqL0QrUlpowDWM7pFIqtyihhPGfF06DCLx
         hAsy04EHv8RW13lRlWpdOoNs8uCaOs7cPdttdZyjWFuobqt0PrYeqLTnUBQH1OrJjtot
         wEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724712514; x=1725317314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfjT7GSOtZtNnx63ak6Ir9XNZzCuHiDAsgy7qozHdxI=;
        b=aKZ6aeYxPHgEE2dJ7dNGIdmuFaU7pzRhtxbGAtKdZXFU66ZhoJYptujH9sVEW8UJcZ
         TsDsa8gpcwZKevPifH2pTBOZKXgG6gf9ly11DtJo27VeRp4q+KBm10wBUI3LMQC5dLo2
         PFNxiniKg8R/HrJ/JiW8T5FiXdC7nGOgzraPJ5g6pqZuioGg7ZBsIuI96hsKW01dLaSA
         P66YMNBKE4XcQt9YC3fUUAZI6NDRQIKM2DEcKSNw1n520g9EPahbzjq1fda7rjQVvik7
         HSM+ukt1kusjQi78QreNJrx2P1Fs5KhHsdFBHLM9VOIIvyGocs9c5o9T60lCm6WqvzWA
         e19Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrEcMlNG+J58GztdsVb3nqZ67jLrA70yEVt7/Zgndm9kCN3QhCSNEmHsqumWn7KixQqYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqU3Zq3/Ov9PwR5/5ZxFHIitAyirDsO3YC7jH6SJsOeVkbVAd5
	036eWscA2TW94ZfL/ySEtUHCI4cOkKHT1zzMMpuK/cXqMzH98lvL8NksVA==
X-Google-Smtp-Source: AGHT+IEtLkUmGEYfqFGSZZpuxNSnBH6qQzp8UXIY+nHkTyswcJqTVoBxomOtGuTB+OVvEGyXYNHl7g==
X-Received: by 2002:a17:903:22c3:b0:1fb:80a3:5826 with SMTP id d9443c01a7336-204ddcba3e9mr17171685ad.4.1724712514076;
        Mon, 26 Aug 2024 15:48:34 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855808a7sm72128895ad.72.2024.08.26.15.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 15:48:33 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 1/3] bpf: new btf kfunc hooks for tracepoint and perf event
Date: Mon, 26 Aug 2024 15:48:12 -0700
Message-ID: <20240826224814.289034-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826224814.289034-1-inwardvessel@gmail.com>
References: <20240826224814.289034-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The additional hooks (and prog-to-hook mapping) for tracepoint and perf
event programs allow for registering kfuncs to be used within these
program types.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/bpf/btf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 520f49f422fe..4816e309314e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -210,6 +210,7 @@ enum btf_kfunc_hook {
 	BTF_KFUNC_HOOK_TC,
 	BTF_KFUNC_HOOK_STRUCT_OPS,
 	BTF_KFUNC_HOOK_TRACING,
+	BTF_KFUNC_HOOK_TRACEPOINT,
 	BTF_KFUNC_HOOK_SYSCALL,
 	BTF_KFUNC_HOOK_FMODRET,
 	BTF_KFUNC_HOOK_CGROUP_SKB,
@@ -219,6 +220,7 @@ enum btf_kfunc_hook {
 	BTF_KFUNC_HOOK_LWT,
 	BTF_KFUNC_HOOK_NETFILTER,
 	BTF_KFUNC_HOOK_KPROBE,
+	BTF_KFUNC_HOOK_PERF_EVENT,
 	BTF_KFUNC_HOOK_MAX,
 };
 
@@ -8306,6 +8308,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 	case BPF_PROG_TYPE_TRACING:
 	case BPF_PROG_TYPE_LSM:
 		return BTF_KFUNC_HOOK_TRACING;
+	case BPF_PROG_TYPE_TRACEPOINT:
+		return BTF_KFUNC_HOOK_TRACEPOINT;
 	case BPF_PROG_TYPE_SYSCALL:
 		return BTF_KFUNC_HOOK_SYSCALL;
 	case BPF_PROG_TYPE_CGROUP_SKB:
@@ -8326,6 +8330,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 		return BTF_KFUNC_HOOK_NETFILTER;
 	case BPF_PROG_TYPE_KPROBE:
 		return BTF_KFUNC_HOOK_KPROBE;
+	case BPF_PROG_TYPE_PERF_EVENT:
+		return BTF_KFUNC_HOOK_PERF_EVENT;
 	default:
 		return BTF_KFUNC_HOOK_MAX;
 	}
-- 
2.46.0


