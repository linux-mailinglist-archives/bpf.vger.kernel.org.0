Return-Path: <bpf+bounces-64740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FC9B166A2
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 20:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9658622B8A
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 18:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7232E2EFD;
	Wed, 30 Jul 2025 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gula8Dch"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907952E0400;
	Wed, 30 Jul 2025 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901947; cv=none; b=BbYhUH6YrLNeXWwloqMOgw2gIKA7XEvuOCTr9OOAjerzxgJDaWoGu+eAEaSgermeZ+ZPghTTTV1lyBBC7chBCOhwBNfg5xrEB7AIyGhhVVbTFMdx8wNS9/1hYRdioZbLkZmZTkjGy64twMMg+CD5LQZM5YwbjV6UwukWb/7fRQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901947; c=relaxed/simple;
	bh=R8RF6B/wwYwRLYKoTYuoOAtIrsUgd3cFkjTNqKXQJq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/n78jrpx6TBErzAa7zrfWzMDpuYxV178ns3K2dMOMfw3dzBHRwH/GfuW6eb7wHnPC6+NKpfyVCa3CUH684sZZ+nCnL+5S/NON5dwoy7K3fKvExDy8UQsvVKe4gkULjG1K9xohCjvS/oP0XcDbQgERONGzQZSeCuMLWwfgYVnCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gula8Dch; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b170c99aa49so83058a12.1;
        Wed, 30 Jul 2025 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753901946; x=1754506746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WRE5VdxGmSovm4Y/7dDPMHX+ysgoR5q6wq/bi/8Tms=;
        b=Gula8Dch0bbm1s2z89+bx5UdPJBQZVRecJz510yTytSsk7BFUAo1pWRMKl9pI8xLkn
         JUeTbc98htzi74A9YKHN6Gcu26r7ohL0BZPlsbNlEAosfmOBwjZiZo3MOntHkflmnjgt
         fnJMIASgAAhnCh0ZoGDeAjXRTDIYH9JocHQK2W1E/4Sz4OuU1tjGzYjeT0alWYGO7c/X
         RmigakEK2XhBvTUTuTkr+DecCM2ZFYnRUEsC3m+i/kjCHdqhKR2QfDLogvx0pGtQnyis
         /8mhOLYYviPjP1Lp3Ly8fGdYkSMjCvkgwHtMu7n8N1fi2bWGUaSy3b2boUO9unWqfi4C
         Ebqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753901946; x=1754506746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WRE5VdxGmSovm4Y/7dDPMHX+ysgoR5q6wq/bi/8Tms=;
        b=KHFD9jm4QaxNWMR2nMHtbiZcoVkcXAcTf7kMm4TAECqhaHgtZecka9Nd20hFEIQhn+
         fVLq8X1/1vsv9XOkji8OZkw4n9i+5p7HXnNcXNSCnWEr2UeYULGUDa9RFCF6PmcKsaqi
         dDfww81Q60UjrXy3Htwhy5XE0Ee4g1zEllmMXjoVKVf5W5CacYR5mO3V8B8KXUYZ9cGi
         afFlQnyPyOvNozrFH+WGLLB4eIyTgFWj+7dzwudwvlEv4ip4m9MNlO5plw7gcINkGeOt
         migdZ/9KT2ObaY3IJFhWKxHBMa79/6+rmMiaPn7WjvGv0dvLX6uBvxrLs5+Ta7baUPK6
         B/Tg==
X-Gm-Message-State: AOJu0YxeNbgp0i/0WCuOxLT8uoZfdafKFyjh0/Qr5AFkAFG4+d5P1bEL
	FznqwdyEvYfViDsEWUcRsBtDODTBWMf0hEzUOCrVB2VTYc5BP4SLaVKnsHGt2g==
X-Gm-Gg: ASbGncv6vjBhNtkpl2/FXBL80LWiRikNfyOj+D8/mHpeRa/fR4I4BrecMjRgbO1uyBc
	r7oqvoq7yyXNHuPG2azG1VzGIe51MN/MvHdGg6XfpLVBa4uOo82rwJobg4ys6Qhdzev+u1eSOOn
	1Hk2XN+6FBEQVZqrP7zk0a7l3tilTxFhgDvD1pO29ompif9JClPRAPj1jQTGGhVzR1a9uEn7CcB
	KYS/LUXyEeyJjKD9zYnL/WGDUeS0L0p6Q850kjHGOnonU7JPjt0u6TtUNz5yrDiSafofFXfR+To
	rXmFddr3ARqea0pRZ1D5xpkrpU1774M5d7JInW9183YnuJEtsofmngwhQdi9Z/PJ5o5pWKebDSU
	p2Es3m86u82KNesyd5/yCvw3i
X-Google-Smtp-Source: AGHT+IG/HWvf8xu19Vv5o/wVsy9jZOvEbJ+0cIMEBIB9y0p2bhk4GsMz2giPeRLzJClJ/xIuCJsqDw==
X-Received: by 2002:a17:90b:2885:b0:31f:210e:e34a with SMTP id 98e67ed59e1d1-31f5dd9dcb4mr6801892a91.8.1753901945572;
        Wed, 30 Jul 2025 11:59:05 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63ddfb2asm2671606a91.22.2025.07.30.11.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 11:59:05 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	memxor@gmail.com,
	martin.lau@kernel.org,
	linux-lists@etsalapatis.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 1/4] bpf: Allow syscall bpf programs to call non-recur helpers
Date: Wed, 30 Jul 2025 11:58:52 -0700
Message-ID: <20250730185903.3574598-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250730185903.3574598-1-ameryhung@gmail.com>
References: <20250730185903.3574598-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow syscall programs to call non-recur helpers too since syscall bpf
programs runs in process context through bpf syscall, BPF_PROG_TEST_RUN,
and cannot run recursively.

bpf_task_storage_{get,set} have "_recur" versions that call trylock
instead of taking the lock directly to avoid deadlock when called by
bpf programs that run recursively. Currently, only bpf_lsm, bpf_iter,
struct_ops without private stack are allow to call the non-recur helpers
since they cannot be recursively called in another bpf program.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 94defa405c85..c823f8efe3ed 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -962,6 +962,7 @@ static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
 	case BPF_PROG_TYPE_STRUCT_OPS:
 		return prog->aux->jits_use_priv_stack;
 	case BPF_PROG_TYPE_LSM:
+	case BPF_PROG_TYPE_SYSCALL:
 		return false;
 	default:
 		return true;
-- 
2.47.3


