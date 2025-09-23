Return-Path: <bpf+bounces-69354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2660B95376
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002AC19044AA
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 09:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DF931D38F;
	Tue, 23 Sep 2025 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW4FKGuP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611222701CF
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619209; cv=none; b=K8UyaLHhgSZVii2iBWK24RSwfD/7X/9NkuJwsb5jtvrcXXDf+BmtVUt0N5oF7hXSjvSyAdz5cOLwg0+xPah35Y0nV4iH5ZNnLOV1Du8yZE0VHeBas4Mimsk/0ktslRmYxrr2qafXcFU59+T7d+vBaTh8JvWHxuPTSCT0nhvL/JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619209; c=relaxed/simple;
	bh=CFGQIdYFoGZnnU6HvNyb+l/ee08KR/O3dY2p3tvi2KI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FrBJC0V8vUqjcImGWISij8isDpHaTP6GFCHyEVZnAIwDIwxhS4ZroyTNVZQpIZgR1FDXpZoYj+tjxdN4lIu5QvJPuVZybE7HdaXL4xHR2f89Jy+uy4M4MCklFNDm0VDiXVzKYBZNM1eD/CzCw9qeokRnhYbchvYe2OlAVFu4iE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SW4FKGuP; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-77ee6e252e5so3471036b3a.2
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 02:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758619206; x=1759224006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0dhwpit34XfPXoxddyaGU725cO1ftVUG1qXMhrs3MVM=;
        b=SW4FKGuPfURhChAQQBLyYIK+tcDYGYl0M6QbnAaZRjGcN3zq9TkEDQp6joJ56Mtjf/
         S+PZqpilRK6bDAR7Mf5UD7MBfa0rhwQG4aajfvyRUypK2pMSZhtiyNhOxEigI3WvhUF0
         sQe25yX+gG0jK3G90K0OMZz9A6oICn2tvXaDczPSVL5yXfgLI9FfK9Z6jiTe0lWEa/Er
         rY6yxP2GBqWE9yol6GNiprdCpVHqKwFal9wrZqnY0Zd1b6OckGGEGmUWla5AXbch/XwG
         srs1zWsPDozhYjg50BWMVlg59vREJc9wKtEZW7s//A7l3oZkdfVDBGoynVhaawrXTWFG
         SloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619206; x=1759224006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dhwpit34XfPXoxddyaGU725cO1ftVUG1qXMhrs3MVM=;
        b=qp+inmmsXzwJW+E3RUF8fInHvgREGmiBlJnUF09PMoOTYwU0kIXZZl/DGWEwoXR8/Y
         JtCZXLAFSYsaa2eM9+Uqt8ALoUgK6allKriRz1EGPxMvNjdbYEevRjflsim4kba+/eWk
         DeJfpKlFkpdwjZjbGkuzE12DbirMsuuzf2SCL13BS5DTR23Pmv+l48YXLyYhPZUDcgjm
         CqdFvfLQ0D8u+O8yCYQau/ip2y3bYgr5OnYsf7OL/HAfj6RFoZ2iNrIDCh+gCyU/TYtN
         MZhKERbjfxpPNU4BQb27tWNBoV2Vo7tCtMrO+jXELoFFkOFR4ArSgeDCngwQo1eMAFus
         QlJw==
X-Forwarded-Encrypted: i=1; AJvYcCWLQzWxVP418k1lclg3s5fNZnadKuiLgZxplMikRM5wD21eoJQsCl0fDeJcTxdOe7aX4rc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9N+sz8Eu3zwB4hhdhtMXzNiVFcgCSGQJKCmNjN6WrtfUGXVex
	Z9gqefiZoW99g4tvya5f5JPrTjdVUj/d6mZBu6p10uVMyQNaF/bCXNeL
X-Gm-Gg: ASbGncu8bJUrnoRDEpiVJ3FsG7l+YXCKHFTFWpIBcPYUUL4vrAnmrFRocLSwh/vU5p4
	TOWm4D25g1qncGiSwALIMQVbOobDY12Sw3S3oSLUsaZCEDpkGhtO76XYLlp0MgNmhwzzlFFPnHo
	tL6ICQn36GsVqAuuuMj0PHgXeVN3oTqhjVVFLZhLrvyJ+6k3aLeb7b/urbeSWkPghsYlAOq7G04
	kDNY8Yqi4cFpuXJE2etVm9Pr8Kw8EZitAcB6r5IxLw4VoQs933kcxBUJvVBPplvr/A/33v8NJbU
	n2o23Fy5stUxKcbdoFC+Iha0wL0zdVJPlQ6wrw9hg/4JXRuWhmv5NBzvWZ987WXs3eOuXAR7f5T
	aWlEafNMflz80cuikjAk=
X-Google-Smtp-Source: AGHT+IGN+oSAolzbRO4iqlc6th7lLVX5x7Ige0JdxEZG8Rmzq2x+xKdBh/O3pTSpSmY3qaBwUhTWFw==
X-Received: by 2002:a05:6a20:a11a:b0:263:af5:f1c0 with SMTP id adf61e73a8af0-2cfe2a5d75cmr2793346637.15.1758619206429;
        Tue, 23 Sep 2025 02:20:06 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77d8c3adfd4sm14114941b3a.82.2025.09.23.02.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:20:06 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 1/2] tracing: fprobe: rename fprobe_entry to fprobe_fgraph_entry
Date: Tue, 23 Sep 2025 17:20:00 +0800
Message-ID: <20250923092001.1087678-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fprobe_entry() is used by fgraph_ops, so rename it to
fprobe_fgraph_entry to be more distinctive.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/fprobe.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 6a205903b1ed..1785fba367c9 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -254,8 +254,8 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
 	return ret;
 }
 
-static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
-			struct ftrace_regs *fregs)
+static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
+			       struct ftrace_regs *fregs)
 {
 	unsigned long *fgraph_data = NULL;
 	unsigned long func = trace->func;
@@ -340,7 +340,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 	/* If any exit_handler is set, data must be used. */
 	return used != 0;
 }
-NOKPROBE_SYMBOL(fprobe_entry);
+NOKPROBE_SYMBOL(fprobe_fgraph_entry);
 
 static void fprobe_return(struct ftrace_graph_ret *trace,
 			  struct fgraph_ops *gops,
@@ -379,7 +379,7 @@ static void fprobe_return(struct ftrace_graph_ret *trace,
 NOKPROBE_SYMBOL(fprobe_return);
 
 static struct fgraph_ops fprobe_graph_ops = {
-	.entryfunc	= fprobe_entry,
+	.entryfunc	= fprobe_fgraph_entry,
 	.retfunc	= fprobe_return,
 };
 static int fprobe_graph_active;
-- 
2.51.0


