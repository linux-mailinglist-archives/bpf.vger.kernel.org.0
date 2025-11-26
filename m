Return-Path: <bpf+bounces-75610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22112C8BDBF
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 21:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F0214E2A46
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 20:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFA533F39F;
	Wed, 26 Nov 2025 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgGJkdTN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78123126BC
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764188970; cv=none; b=rWrFEHuK8EQZZbd8ljO+h2zSZdWuI7+7NxnWDrT+6x7QiFol7msotUNnJIRKsPvd3IJnul/WFPyIniQjxxILELRWfD4w7KGxbObyHbzv3EdxdnLkt3l859ZoJkNyT/Adrl+k/Ad6SDVcizO8Rkf0VmOj412E5bew3MEP2zK7+v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764188970; c=relaxed/simple;
	bh=LSvzPVTKBvC3FMkFAMlHH80EywX1GC+VVzzXhKHQBQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g4vSrmJUtejjByv8amVX82jGcjMmGc/NVpK3pZwk0cbrdmQy1/e9uS0YfF3qEk/kEUTHmrxhtcxmyNqEYORunNoo2X4bofgrE5QwjaII5VxEa8Ph0A7727jchW+Q+WGgIwTf0RfevD6ZzCrLxTU/HRMtbo9mHXlNoCEBFSXixHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgGJkdTN; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29853ec5b8cso1955645ad.3
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 12:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764188968; x=1764793768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FmNiLi4toDO0VFPhyHUCXzsec6EA/6hKqsFZXKZa3HE=;
        b=CgGJkdTN6vuVErKcQ9XtBsQDxvrhpFmRDXvdhlWw8OnAUTfBmJfNY70rZMfD7OX3PV
         T5rfnVwV2eoWhWAxt3Y9lqJfnA+ngWUX0NAduk18CF5SX6gcS/EyIe8mYv7pEm32xk0e
         l2JUjsg1VGISXSRorc6Js5yZXqKKC05HeyxqJz0dEv/A8EMCPSta0+IjDu/1RaAdYxk0
         AAxXhbgLMJLvhNmSY7NexkYe/oh35mzMfvVOphMLENvbNrh9TQdtQ9ePDx+5/ImUZRhk
         CpI5qGD8FJZ+HDrW/W7uBZnE/G57Bd5rx+Yst/+hERok+BsKGHgfP6Yv/0z9J+mGl79r
         6e+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764188968; x=1764793768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmNiLi4toDO0VFPhyHUCXzsec6EA/6hKqsFZXKZa3HE=;
        b=DXJ/g1DBo8qEOkW2Llt7yH1nZlGz6gKIGJ9p2z9SwNcdMeXJKuFDCgYoGECOTbTfE3
         B4TYQbfn5AjPXxxeCQXRkVmSXaR+m0hFFb6NnKP7U5Brh2g/Le+QwZULsz2pLd3L+Ior
         mIqiNyK2HlAq/q2hGXAHO4ZQRk58KcYpRyzWvKRBDCsiB4pUfVx42BvFD+/jSGdaT9Tq
         1GTP76cR+jAGJFIVEAZ1CZLXbRqdxw8drT4Rr5uFP9FWcteENCP4MKw3BueLUud620TK
         cE5YpGAvGmumO1CPsSYiof6gSRai3VCsvJ0JQrWa2YC4HBQT88BKBdEfUBPiQV8/znmb
         fFjA==
X-Gm-Message-State: AOJu0YyYJgtaerozi8pvEWj96Lj942KYQeS9lMFrY1BpFUAsXyOxbKUz
	OluzyuIWYfL/8GsR81HaRUddM46yGinmvHhvq3CELFNTMyDXFw96z2XSLme97g==
X-Gm-Gg: ASbGncvzx6J5Ajid8kPfbjeYJ2GoGbEP9Y8SGsYjOmXTDPImcEYp8qsL4KsRChk1dez
	2fOUMFgQQMoMjL7SaR0nK/rIV2+xQv0yk5Q74obj+Bn+1XwcZkJsUirO5gWM3TehJ4GEZLlgTYB
	xfs3tPV1ZZVZE3ngsSr4VNk5agrNO8WBdF3XOM1QaPaUXrBZIxUTK4hlXoDwZYpgzrrNBSqWWHb
	jpw+xXo8XVPR5kJ1Ww33JBz+GKN1/9Afbz2MMScxpQuGjIlHhUORzWn1jPx4Qf23X1Ft4EvlF30
	x8pavr02i2+4pNfXqAUV5r4IN7htsN96Q4m3t6gNjA/a3YEXjBx4Bn+D3XwIyDLSmk67fYVDjwX
	EKPFTd0Qp6VAdjpaihPEitogDdBA7ophzuTfe7WeTJBTlLI20oK5I/m0S6kIyhLDrjijhruVhMg
	I1/Pky/Ddfjci/tw==
X-Google-Smtp-Source: AGHT+IHPXw1Adoz+N+WMC9EjEWTjYHjGOV5oNwbqU0hVtQzVKRShtd/iEURFDFn/3TpOW1n8/byUqA==
X-Received: by 2002:a17:903:2ec8:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-29b6c6f1d7dmr225169225ad.61.1764188967957;
        Wed, 26 Nov 2025 12:29:27 -0800 (PST)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b7874073fsm147070265ad.62.2025.11.26.12.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 12:29:27 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kaiyanm@hust.edu.cn,
	dddddd@hust.edu.cn,
	dzm91@hust.edu.cn,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] bpf: Disable file_alloc_security hook
Date: Wed, 26 Nov 2025 12:29:26 -0800
Message-ID: <20251126202927.2584874-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A use-after-free bug may be triggered by calling bpf_inode_storage_get()
in a BPF LSM program hooked to file_alloc_security. Disable the hook to
prevent this from happening.

The cause of the bug is shown in the trace below. In alloc_file(), a
file struct is first allocated through kmem_cache_alloc(). Then,
file_alloc_security hook is invoked. Since the zero initialization or
assignment of f->f_inode happen after this LSM hook, a BPF program may
get a dangeld inode pointer by walking the file struct.

  alloc_file()
  -> alloc_empty_file()
     -> f = kmem_cache_alloc()
     -> init_file()
        -> security_file_alloc() // f->f_inode not init-ed yet!
     -> f->f_inode = NULL;
  -> file_init_path()
     -> f->f_inode = path->dentry->d_inode

Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/1d2d1968.47cd3.19ab9528e94.Coremail.kaiyanm@hust.edu.cn/
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_lsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 0a59df1c550a..7cb6e8d4282c 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -51,6 +51,7 @@ BTF_ID(func, bpf_lsm_key_getsecurity)
 BTF_ID(func, bpf_lsm_audit_rule_match)
 #endif
 BTF_ID(func, bpf_lsm_ismaclabel)
+BTF_ID(func, bpf_lsm_file_alloc_security)
 BTF_SET_END(bpf_lsm_disabled_hooks)
 
 /* List of LSM hooks that should operate on 'current' cgroup regardless
-- 
2.47.3


