Return-Path: <bpf+bounces-33104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BEF917259
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 22:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23811C22DBF
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 20:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB3B17D37D;
	Tue, 25 Jun 2024 20:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdaNNIGo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3663178394
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 20:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719346597; cv=none; b=dAGcl/vNMs1EQuNJzcw/rTPQIRZ+l/uOx3578Tfkx5O+pOdHWIm6GqBimIRgoCsmLAAqqkoyoFaOofuUNfQhJLtLfBKVC/8ffbe3iYOmlTZ8HQwVxEZn3YK0CGpclS3vwfnWkNS5QCRtJE+79ycHXH86vEoyVJb28O3nc43y1mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719346597; c=relaxed/simple;
	bh=BC0s94eFsNo11gFSt+i38SfgrSiH5NziRZOQsxNhJd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsUI5GqpY8gz8w02ZvqT43ODqClwuWDcOaqmEbWSlaxhPJuaCRa70OuFMt47cZWuAY6B4JMVUMBD/UMID/JXULTrd4H9fAB7j30enxNKqv/DJSTTqZMaL+19Qrr2foZ1HeN07nYTqf/RixHz+fV1LTxFXDaV4xprdlEMz0Oin8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdaNNIGo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f9aeb96b93so41972275ad.3
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 13:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719346595; x=1719951395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbcqZVtCDv/dReaVQ87DGtCUb8qPTSFEL3lnMfB4fmU=;
        b=SdaNNIGoEvKxPgcWe5PC56wxRhWzfZ3iieXGj14dvUT7qUoKUDklQXxRQ0/UUV76T5
         Q2KMpyhOcLwE/17ItykKUD+/JfksTbdetnnrpOJMDX+wpNpsH4IYEFXVluOVAi7M9lKl
         9DWhiyuOLVest/2HoArzjHL041op1wbYWa7O7KIdXgFYj30gkAn1TpNkVO15uCJ2O+1u
         u8CictBHdhTQmwoPtExLENs7uIyCKV5bRK8WoK8KQpwZVuTD6MPLGgd4i3aLoK4dM3G7
         uT0VRoynV8KFW4ZChDROCeRBEdFz4U4e/48ByH5IjmAd3vi2UPu8lUYC0o043+JDKoFX
         CmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719346595; x=1719951395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbcqZVtCDv/dReaVQ87DGtCUb8qPTSFEL3lnMfB4fmU=;
        b=GyOJd+z+W6dNYQIP8q23ck1h/nxTn4W7mq9BK7VcouH+VQuF3M6GDC5kI4QNILt/VY
         n7HAyUuFGnjLA5b4udmfnggPiMzTddw04ufCiRmECLs/xtB5LVs0LQzo9VQY1Km81d0P
         BmzsGbeUzlQzZw+xLwZJj7bVO+BUxGE7mc08uB4FycXGqV+62MD/blUuThEGm1UKpGoZ
         0nRe377OozAy1BrfXgnnxvrX3dMcvOsmd74Y36MnV6nWdGPsshXyVMvzpMRjT4MgtdtO
         POzR4WKDTL8jjnWUsWuD3RJp8t/oYDiYDnXZEJKD/m5/r9XXNhpoLexvLLzwqDwf96S8
         p0LQ==
X-Gm-Message-State: AOJu0YxHubuljTIdcqEntyVHySAtLD9NJAIfZ/6di3+dLOzXemOWJ/hZ
	cJspXFDxNorDLyYa2dYt1bP/4rZWfVmv3Ylp99WgdS6nNMaV0VhvGuqr3g==
X-Google-Smtp-Source: AGHT+IGpDSav1fcxqRCGRRR4ARoqdlyzjsYN0J1FKVzULq9PklGgEm+R8ySSO0RfDB3KOtYSmu8DNg==
X-Received: by 2002:a17:902:f544:b0:1f8:90df:7437 with SMTP id d9443c01a7336-1fa23ed664emr110300105ad.38.1719346594937;
        Tue, 25 Jun 2024 13:16:34 -0700 (PDT)
Received: from john.. ([98.97.39.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebabc13fsm85600725ad.250.2024.06.25.13.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 13:16:34 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: bpf@vger.kernel.org,
	vincent.whitchurch@datadoghq.com
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com
Subject: [PATCH bpf 1/2] bpf: sockmap, fix introduced strparser recursive lock
Date: Tue, 25 Jun 2024 13:16:31 -0700
Message-Id: <20240625201632.49024-2-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240625201632.49024-1-john.fastabend@gmail.com>
References: <20240625201632.49024-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Originally there was a race where removing a psock from the sock map while
it was also receiving an skb and calling sk_psock_data_ready(). It was
possible the removal code would NULL/set the data_ready callback while
concurrently calling the hook from receive path. The fix was to wrap the
access in sk_callback_lock to ensure the saved_data_ready pointer didn't
change under us. There was some discussion around doing a larger change
to ensure we could use READ_ONCE/WRITE_ONCE over the callback, but that
was for *next kernels not stable fixes.

But, we unfortunately introduced a regression with the fix because there
is another path into this code (that didn't have a test case) through
the stream parser. The stream parser runs with the lower lock which means
we get the following splat and lock up.


 ============================================
 WARNING: possible recursive locking detected
 6.10.0-rc2 #59 Not tainted
 --------------------------------------------
 test_sockmap/342 is trying to acquire lock:
 ffff888007a87228 (clock-AF_INET){++--}-{2:2}, at:
 sk_psock_skb_ingress_enqueue (./include/linux/skmsg.h:467
 net/core/skmsg.c:555)

 but task is already holding lock:
 ffff888007a87228 (clock-AF_INET){++--}-{2:2}, at:
 sk_psock_strp_data_ready (net/core/skmsg.c:1120)

To fix ensure we do not grap lock when we reach this code through the
strparser.

Fixes: 6648e613226e1 ("bpf, skmsg: Fix NULL pointer dereference in sk_psock_skb_ingress_enqueue")
Reported-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 include/linux/skmsg.h | 9 +++++++--
 net/core/skmsg.c      | 5 ++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index c9efda9df285..3659e9b514d0 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -461,13 +461,18 @@ static inline void sk_psock_put(struct sock *sk, struct sk_psock *psock)
 		sk_psock_drop(sk, psock);
 }
 
-static inline void sk_psock_data_ready(struct sock *sk, struct sk_psock *psock)
+static inline void __sk_psock_data_ready(struct sock *sk, struct sk_psock *psock)
 {
-	read_lock_bh(&sk->sk_callback_lock);
 	if (psock->saved_data_ready)
 		psock->saved_data_ready(sk);
 	else
 		sk->sk_data_ready(sk);
+}
+
+static inline void sk_psock_data_ready(struct sock *sk, struct sk_psock *psock)
+{
+	read_lock_bh(&sk->sk_callback_lock);
+	__sk_psock_data_ready(sk, psock);
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index fd20aae30be2..8429daecbbb6 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -552,7 +552,10 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 	msg->skb = skb;
 
 	sk_psock_queue_msg(psock, msg);
-	sk_psock_data_ready(sk, psock);
+	if (skb_bpf_strparser(skb))
+		__sk_psock_data_ready(sk, psock);
+	else
+		sk_psock_data_ready(sk, psock);
 	return copied;
 }
 
-- 
2.33.0


