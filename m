Return-Path: <bpf+bounces-26211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C686489CB38
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 19:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE801F26E51
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 17:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E5414533E;
	Mon,  8 Apr 2024 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXdOfOlg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC881E489;
	Mon,  8 Apr 2024 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598711; cv=none; b=O4JnbBZysRL4UK1kqzJQfdkgHFA0ozkbX8vPjhSH7d4vB2IbtczsOpEOSOksqAk4PD/wFWBE7bRWRIN7KdjzHFfCViQwypQovyNVzNkfr8NrdXy+3f3BrLVpQMRRnIGD9bYSjTEAUPKZ4XnmOn+5FUWL+F9GXjhJSYRfQc1qmI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598711; c=relaxed/simple;
	bh=I7bgtQ8gbOL0E2c8wwj95xLx0EZYPdW47b5jlkuPcHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UGM8tSA1HTngo6rGTDWlcPYfHT8YhcKbUPZhuSEAj6Tlr2gFN9mr9dPd/Fm4iAsrfF+B7Ie9I5p46GMfo4Z6patN5ThOWfhiWIFLFKk6ZExk3Rkiutb7qk+QbDRps0RDNvQsglJ8fkTayJDri6FaKTjx1uASyBIy0wAGvOr6tKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXdOfOlg; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61149e50602so31593617b3.0;
        Mon, 08 Apr 2024 10:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712598708; x=1713203508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+2f3kuFiH1Ga7KB4I0xvIU7KxaYtU7frTWrfLqHdiM=;
        b=eXdOfOlgueSOC5kjW8JvnUy7WRysBEOfvAI3EfCLrP/pAY40OX3xaM2CRBJ6S+XPXN
         REv//JlSdoxXDRIEQYMt/95YgbW1l1mzcm6zwAIMFke3hy/PM512dllgnImtnpMddxEb
         0QYivdhcC+ZUoldg5MVNoH7PHYBJfCsAZxZ/RBQ/kP2Dya+cmJNhu5EgvPuD+pJB742/
         KFy4q0qDHxojOfr8POkxl92CBAT4jabdq+fx9d+7ociZg7bd+kJsK+rHLFI6usvW0Tqd
         rzH0Sipgp6rW3dKzXBi8bWRPLkF/KKP2ByeV6+ozrR6aKO7FdZoK0xVWs06oOTMOrDAW
         E2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712598708; x=1713203508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+2f3kuFiH1Ga7KB4I0xvIU7KxaYtU7frTWrfLqHdiM=;
        b=jjqo/rNPq3vCwbhQdp/SEOBmaPj5MpPrSX7oN33G4yy4JRZ5R0yTwxyNqsMPu/NUJm
         3pLOIzKIbDyOPWj75eFGQPC5Cz8C4eulubrrSPIGcecHr15xj+S0XJqFxdzIL4sN2jbW
         UoiAoT7SVH+mSCHbp2SwDkAAnf9T4y735rhoSHBmI/Wunh0KOuUbn1yUpf+NC/rSVDrI
         YOJ82sFKBr7hdBWLm8tYYwYgEakaquxAQtjqHLrFIS2BaY9VaGg8kFScGXq3vOjoho5F
         aejmj+skv3JdD1cNEzA2tGBAQMgHcuDAxqzVxF9aUFTe49w55FQoq73epvq789V6h/F6
         u0ww==
X-Forwarded-Encrypted: i=1; AJvYcCU4qZ238LW3RM0dLRiWsHUiqYmvqnWlkFR5JB2if4fkshv9dZhJpvSE/QNSqV9/iKJ5vN3xCH4oxm63kutjqr3TePog4a4TxIZfrpuHpCk7L9ia9kJs0ouaZtlNPb7lUUjzRWnkJ6nT
X-Gm-Message-State: AOJu0YzEw78nBYMAj2SOonuQrgzn9fYQ2DolLsgTYO4SSn/OuzaSsAR1
	01yaJzQAdmnt/kbCtpwsmBnZmLSIfEAlqwYLd+t8rnIkI+LRekzy
X-Google-Smtp-Source: AGHT+IGjNIozNM/Gk5nmE77bGMS5iD3tyNtoEpqJ2F1rY2T8TfOULkST/DqjM/uZfMgn5emB3BlmfA==
X-Received: by 2002:a81:8406:0:b0:618:fab:cd23 with SMTP id u6-20020a818406000000b006180fabcd23mr300308ywf.15.1712598708377;
        Mon, 08 Apr 2024 10:51:48 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ac67:e262:f006:430])
        by smtp.gmail.com with ESMTPSA id by17-20020a05690c083100b006143de9a59esm1771117ywb.11.2024.04.08.10.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 10:51:47 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: mhiramat@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	andrii@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH v2] rethook: Remove warning messages printed for finding return address of a frame.
Date: Mon,  8 Apr 2024 10:51:40 -0700
Message-Id: <20240408175140.60223-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function rethook_find_ret_addr() prints a warning message and returns 0
when the target task is running and is not the "current" task in order to
prevent the incorrect return address, although it still may return an
incorrect address.

However, the warning message turns into noise when BPF profiling programs
call bpf_get_task_stack() on running tasks in a firm with a large number of
hosts.

The callers should be aware and willing to take the risk of receiving an
incorrect return address from a task that is currently running other than
the "current" one. A warning is not needed here as the callers are intent
on it.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>

---
Changes from v1:

 - Rephrased the commit log.

   - Removed the confusing last part of the first paragraph.

   - Removed "frequently" from the 2nd paragraph, replaced by "a firm with
     a large number of hosts".

v1: https://lore.kernel.org/all/20240401191621.758056-1-thinker.li@gmail.com/
---
 kernel/trace/rethook.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index fa03094e9e69..4297a132a7ae 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -248,7 +248,7 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
 	if (WARN_ON_ONCE(!cur))
 		return 0;
 
-	if (WARN_ON_ONCE(tsk != current && task_is_running(tsk)))
+	if (tsk != current && task_is_running(tsk))
 		return 0;
 
 	do {
-- 
2.34.1


