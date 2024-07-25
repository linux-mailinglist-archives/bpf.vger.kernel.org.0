Return-Path: <bpf+bounces-35590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D66E893B9BF
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 02:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982E9282F3C
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 00:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8256681E;
	Thu, 25 Jul 2024 00:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtxTbZ6H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777C233CA;
	Thu, 25 Jul 2024 00:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721866467; cv=none; b=LSfc22O9/6NAKRSy+28rp/f6TzdL8ARHI4AZLwmZ0gWLHoEjCcacrpjWrR39g/FqVvPoVBhNZnhlMwCrb1Ky0JyRsQodTTGxP9I3jIWuRVA2kFvfgDutJXX2bHWXKGEtOHIh3BpVH6m4aaso4/iWwpnP4OopTq3xshBu9VSRFGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721866467; c=relaxed/simple;
	bh=GfmyybgoFneffmyq/GmNA49FTZZjHne2dqt2E61Y14g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMkyEylVcVZnlGojXlOY/j2El7bVpxSQW1W7ru6O1p6Rc9BMMW0hq/Ic1HuAhzI6w6zWwJMq+Y/AZaGArvzOcrP6oU0+gZ6F5iU94V5UxFVtCmrbuQMJmC83cVpf0uMs8rN0/s3pdcxtor/LGoNJ6+LJwL495PVZP2mKOMafMWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtxTbZ6H; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7979c3ffb1so175566b.2;
        Wed, 24 Jul 2024 17:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721866464; x=1722471264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eG/lRRjkSAeWsEyW9O4j6uH4ueqTUceCM5jXvGupoY=;
        b=JtxTbZ6HieAPTopuD3HvT6fM95NnBQM4fUXZ0pKwZk5vsPzul8GxpzMzlIF1d9+uCp
         t5a0E/Xn75wrXdh+sJZQzwmZSCNkxpH6t/57NJ+ggdaT5x98hLsiBlYLbfE/8FdSXSNu
         SG3xD/GfjSDCqGNzUtCteWjmUuZgI8Z9fYqYSGzdYBpydXzxowSHDuYVopMCmH1JXgpq
         P1fSxECyNurAFq+sPXULzzjn2s2VH2zo9E43vrH1kQmXrkJjyv3mzNwWgC7pbrrDcA4e
         s6LjQ7fbZBfejGmZBt1g3Yc8tV+4r9Z+Oo/k57sKPKA1SBIxwl7rNeCYLydi/YasF+ic
         zMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721866464; x=1722471264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eG/lRRjkSAeWsEyW9O4j6uH4ueqTUceCM5jXvGupoY=;
        b=hBNSidtCyWFySmZeNJ+bZxExkXoE1tpz6sQEo3jYmPHLxl3P9YF+U/Px6vcL+/Fzfw
         tAblmIO/bRr91k46ORF1Dc2Ko2IQG075u4eIHxRvOKKLxya5lgneoME2M3CS/oJtcz52
         WGYzcNQIbaI5Q4CZVF8TJ1FZPX4t956h/fcHnlE/6BRRBEb/jrnGx8ffKOplAoxnGpiM
         NeQD4Pm82VvaA1fly6aQZEHatGNCMQBOdJfJ8tizzJSI9jnRIBcKTgFxvv6LP5UAefLj
         T6J6df/hvLvAYPjAzBiAbZ67o/ThDU3fKbD+ZuzX1tVsomE+N506cy9gaLcydrStggp6
         drAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk2Fo7IUa0tkITo4d6A7HVbHtDriD0OMMz78VYJ03WCo+5ci4pAiwtLa5mlRGkM2zL53Cg/UjeGKTpt0G4FpcCIHtCHYD0VxPCCb/pZVMsDc5ZgDw5+rQdc0dLcdOQ3Ap5FPY1gTKI
X-Gm-Message-State: AOJu0Yx9UyPuX39nqRqZzod6vmjI4iDv+Cxvorx1A1fbiNaSbEIOhNLg
	C4wQfd8VUwyxOIvlKOz+EBbFGNvR1v6seTq9nLV3hUUZ7pWMqCjo
X-Google-Smtp-Source: AGHT+IGozouLG2EpJhEHUQM4qO07EZGmIH0ARDqjTUpzMJNK1GlInNeZXI7G76ixpIfzP3Pn+DX4cg==
X-Received: by 2002:a50:bb49:0:b0:5a4:5df5:12ed with SMTP id 4fb4d7f45d1cf-5ac6396b261mr251094a12.29.1721866463753;
        Wed, 24 Jul 2024 17:14:23 -0700 (PDT)
Received: from teknoraver-mbp.homenet.telecomitalia.it (host-95-232-233-251.retail.telecomitalia.it. [95.232.233.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3a18sm164988a12.75.2024.07.24.17.14.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Jul 2024 17:14:23 -0700 (PDT)
From: technoboy85@gmail.com
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v3 1/2] bpf: enable generic kfuncs for BPF_CGROUP_* programs
Date: Thu, 25 Jul 2024 02:14:10 +0200
Message-ID: <20240725001411.39614-2-technoboy85@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725001411.39614-1-technoboy85@gmail.com>
References: <20240725001411.39614-1-technoboy85@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

These kfuncs are enabled even in BPF_PROG_TYPE_TRACING, so they
should be safe also in BPF_CGROUP_* programs.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 kernel/bpf/helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d02ae323996b..0d1d97d968b0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3052,6 +3052,12 @@ static int __init kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_DEVICE, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SYSCTL, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT, &generic_kfunc_set);
 	ret = ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
 						  ARRAY_SIZE(generic_dtors),
 						  THIS_MODULE);
-- 
2.45.2


