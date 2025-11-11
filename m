Return-Path: <bpf+bounces-74120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FFBC4AF6D
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 02:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED01D1893D82
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 01:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B744E303A03;
	Tue, 11 Nov 2025 01:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSv3uE4A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37071D86FF
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762825116; cv=none; b=WFhUC6rgjbYeoRkyZhmxHMvPoRyZlGVhDMQ3AtNtGrU/X6ckce6iqTwa1ViXrfOi2oQuP+0TvX0e9Za4ci5QTbSTZ4nSPI4L8uyAZ4UIXOs3TYwlRF834jUGWNM9fy/dtX6BJuqnT7/DV2Wp0Yt4Da1NU2sRuU7gx1WvV1N2JZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762825116; c=relaxed/simple;
	bh=ZJT+E/zAm3pctjBUJUTxV0w3bELsp+hNftwToUaFjSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mmuFbHMvDQkfcAulVYT5Usg8+fE/9AlqWwZ1UxAN9evdian2pFXMwJU29jSWFOunNKrNSpk4sQRowwKh4lkZMDFvi2e+Z5zbO9QrdWnzHHSFuE1r0HtRwRsHbr0rVYJOKIAQTty3VhnF8qO8HEO8TxCASg4VFETnFGmnhPFuANQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSv3uE4A; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-42b31c610fcso1759658f8f.0
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 17:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762825113; x=1763429913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kPJYmWWaj9Qh4COyt2ISB8CSbv4fNzsJamoGZEN3/vY=;
        b=FSv3uE4A0vzELdfvCT8r3oIfO/usid6WV0YvaZOMze83reJQvVK1D/Yk0weGGPzdou
         vbhBWGWv/hP4YJYkuKJF/5uweIn5iTdJ06Z+FBRXiyGW6Qzj3JW/WAhs94cWJuBlPprQ
         VJ4rBwMN4QArSPutHz6TJYb2zr4haksW1E8Va24tSogf+PUFkKfMPH4Q3dkhw15rMAna
         c0GZFwhjXgNiqqTDee8tmS08e9FqLx0MbaDRbCdD8XNg9Cib76T6ToGsKuOA9SyIIpQJ
         pOvK4aJzWn6RpPjSe/8dHkLRa03QT/P8NOBC2B7OyRP9qxeEqrG871zJpq0XR6c69BxT
         ubvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762825113; x=1763429913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPJYmWWaj9Qh4COyt2ISB8CSbv4fNzsJamoGZEN3/vY=;
        b=xLsoPwtIv/ZYx8z9+DblJbMOxLqzU0XAUn/+JgoyjXKvfG1aZ/59Wb89Rxf8YS5xr6
         M6FS7bFj/KX/PORgWwfYx0JVPuC70egArYqZ4h+AXUm1awUV4cm83qtddMZWJ+/BmjNP
         r2O1wOwwrsHLaZEAtmn9q2uUjx34sl91NTJNWI8J0RbtVIBY16GHBUwmK4uLZP9x0els
         JY3Udr4xlNLkm8Gm3BJ8P+zyDj5ms8bTbc8Ray+HqFHesgjkZpjN5Z+gYtc3NzLH9vay
         vSTOYoO5F+fD6qwzitYmEklJ0VAOcMULAsO3Zncc0FXNzLGbC32n4Bah4GcYoQCPhE/d
         Jt2A==
X-Gm-Message-State: AOJu0YyMp5szJ3vltdVBrGCOsdpo8SKS1djmGqR0e/zr3cCZX0r8EL0J
	tuNTQGoBbByEEN4sTkzdCpHxd0CjSUmrNc+POQL+xjlxNIB22519Fl6mJZzMb5i5
X-Gm-Gg: ASbGncsHuyLrYp7n4F68tH6mpC3O2EmtM53xro78/wvdjWiecX1KXEbjg1alLmmYIzU
	4hWznqhfSm1KEjeDJ5UI5Eh+82dGzuTsYxLAG5qucf/4G4NjTsn56h9W4P1LuRt7rS8/WDrWa1F
	7Hcgoef9sjkt2lZriJeFKne5PwIomy/NOkbvZe2VIKpqhRNe6dZbhGBVzdgGRlzx3hSSKWXXRH2
	5B4OHDAun+XolsvP0lBiaXDRBVFrJoeiq2N84faEBpmv1JCiv5NjFN1x9gPowyphG1+G5iMWJxM
	3CLydPlN2xUyK1InrRKntDLOxX5CJCqYWDNVGCNyDw0VE8TDRvn9rgdt5xopv2dvhXlGFRAyXHG
	QMiiqp5Vr/6FvTtQRpC28xzHtlaG5yh+wHJZqFmDv48FeCv6ColGNJQtCUEP2yvBArMdSV1teCl
	cOvHbzVUILlnwGQil88h8K5He3umC6zc7sjuEVKMpfmNgPHJY5WEbK/Q==
X-Google-Smtp-Source: AGHT+IEFZnAI2FJeXXSEcWWsuqRFG/MvxNWHONK07XluMWlYX131Nh0M6rJM85r7ps4i1j7KLlNEMA==
X-Received: by 2002:a05:6000:1acb:b0:42b:32a0:3484 with SMTP id ffacd0b85a97d-42b32a03626mr7344291f8f.45.1762825112500;
        Mon, 10 Nov 2025 17:38:32 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42b30f1cc4esm15848003f8f.36.2025.11.10.17.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 17:38:32 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1] rqspinlock: Adjust return value for queue destruction
Date: Tue, 11 Nov 2025 01:38:27 +0000
Message-ID: <20251111013827.1853484-1-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return -ETIMEDOUT whenever non-head waiters are signalled by head, and fix
oversight in commit 7bd6e5ce5be6 ("rqspinlock: Disable queue destruction for
deadlocks"). We no longer signal on deadlocks.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/rqspinlock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index b94e258bf2b9..3cc23d79a9fc 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -537,7 +537,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)

 		val = arch_mcs_spin_lock_contended(&node->locked);
 		if (val == RES_TIMEOUT_VAL) {
-			ret = -EDEADLK;
+			ret = -ETIMEDOUT;
 			goto waitq_timeout;
 		}

--
2.51.0


