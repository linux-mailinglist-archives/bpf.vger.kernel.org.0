Return-Path: <bpf+bounces-73851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3ABC3B135
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB25B504E13
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D04A33FE15;
	Thu,  6 Nov 2025 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCH6GiVv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5EA33C53A
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433630; cv=none; b=N2MdCZOlFd94UCUTCZEgeTA3+M00EJam37ksVPn+4l9gww8ejcCttNYyduH0G05CUgdJlX66rjDbGjrK1Ch0pJMX3DWHrR6iU6YSRcNZWf7MWr9/fItwvUVeq5q1eGiHEW0QFzDf0ylJy3FWzh4JVy4I5/edXmBEgaiWPd2HdGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433630; c=relaxed/simple;
	bh=Q+gPCrBvqV9eKYawaaZc594PBuJnFIBv2mWZKk6piR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uAxyceVyo05Zt0cKmg+YfcrlUp6CW+6meRW+ywT41kyM8bwhve0ikT13LY9zjg58pxiA+p1e3FyBh0tLNkHfRjtaRXGhYxr240JbmtKOeQ4xXFLxG2P85v7hE+UxZxXAxbhWHuvUJPKzQfqCP6eZf41Fx6VzmzoTI4lcI5URBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCH6GiVv; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429c7869704so821378f8f.2
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 04:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433626; x=1763038426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K34fjCYCGoSJdwCxfEsku+tPUzx/FlDGUOaZ5xDsmCE=;
        b=gCH6GiVveRDMs7EoevQ8mPsqJ7GoXyb7Wzlx3oNyF9R+WxBEHvZXnzB7QkdG5qG+4a
         PJMamgzZIM6+1CBE2P48CI6tGnlOGztEz/MC0pCChRh+SK4yCIFFB6J4pXyqGzUmS2Ix
         1lqX7n4vNdkcqm1FXrdKJ7W6VCLvypcb3hn6IxbORgHFKBUzR0XAkILT4D1Ys8F3EMGC
         i7rtN98eCRHHco2k5nb33pfJmC2i6F40OGI5m5/gC21Oe1Ji3AOcTZ85SaEsqOeyERYF
         d66+Q66n3m6GR/TGNjob0Pailh+lECMQLBxFO0tj7lyGVG/cAzii1u5ZDFXnsmh2O1Pu
         l47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433626; x=1763038426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K34fjCYCGoSJdwCxfEsku+tPUzx/FlDGUOaZ5xDsmCE=;
        b=vJJM/6+LVeA4U95WTS7cVfV+lEQt5RiSKKnVr8bAFtzB/96RQJurzlMQGUxo0y2jYG
         IKCXh7qsaesqjgvxme1R11qF1keiFYbD2SX4I6uDkhBhmFjdP4Q+PBt5pwqSdTfrnzec
         MeGLAdqi2xSgetPnMD4dax0opi4Dm0fH2vd/UnTEE/T+FAnvCzsCjrGv3E3Ut61F8Pnp
         sZxzLhrBi8ujl4lPrLVyeIOB+WvHyzejEvkpyF61ODazo56xmmCuIb7u5i7t+fgyYBSU
         Ves2FkzXRRNgFRa6uNkzh7BCT0hMcgQprzHLn7Vj7r9UkHkP0imcSO1XN3GpZ4w4WMFN
         VhFQ==
X-Gm-Message-State: AOJu0Yzcbj514NhQ/YHkyritZ+pwSuuh1Lq0xVlJpU/NrD6a4CLOzsGQ
	WCADGLfXNl50NSLBIsywGKCUChsa6AJoeQZdO5VtAEvbx6YbwHZLAVuQXOHB
X-Gm-Gg: ASbGncuh5GxP2i+wIGL0U3qwJiztdJWle3sxyjM3BbeZN7fQ8TIGFTDjQCabfGBZQfK
	MWSsHmzbWCQhnyx9O3ITegpkawX17ZIScihVGQdbjz9jYSLIYvu9ralYC/ibI8VbPpCtKpBVNcS
	HYvBBGKnSTlqZN787fp1X3nf84722lv/NtR1NMd98mBWcc/Ww9IPRLlnxwx/NvzPyf2M+5Ua+ZM
	JNGRHLktU9bp7GTKsyclH3ejchktz3f7/g7tvbqQxyoSk0CWfBceZBnExlIJq60+vSyKJ4b2/tg
	rKKMTqljjgXpIkM9kPMX8b0rt7++XfD8JmvrUFW3vK6QtEd1MNU/tM/USQ3wYsyGVCqEAcOJRw6
	aKI7fpp3aZKLT0q/E0etz9svFbW035tSdZWTzUGfdqpeZRnxrz9sOTse/BHSVdK0PQS1DqVpHTJ
	Yfq3GPKbj2O9FRAvU5tPMDSc7VllM3F2qhKlr9wYNoRadPalys29xXW54=
X-Google-Smtp-Source: AGHT+IEsHuLNMGEHDB74IdUzyIrXs5wkTefXkfvvLRH9gq2+IppFGexW3BvrP1HGL9GdfsxYTxaF9Q==
X-Received: by 2002:a05:6000:64b:b0:429:dde3:6576 with SMTP id ffacd0b85a97d-429e32e6c08mr5782407f8f.16.1762433626184;
        Thu, 06 Nov 2025 04:53:46 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:45 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
X-Google-Original-From: Hao Sun <hao.sun@inf.ethz.ch>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	sunhao.th@gmail.com,
	Hao Sun <hao.sun@inf.ethz.ch>
Subject: [PATCH RFC 17/17] bpf: Enable bcf for priv users
Date: Thu,  6 Nov 2025 13:52:55 +0100
Message-Id: <20251106125255.1969938-18-hao.sun@inf.ethz.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
References: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable bcf when bcf_buf is provided and is_priv.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fb672c9cc7cd..d48357bac9f3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25961,6 +25961,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	env->bypass_spec_v1 = bpf_bypass_spec_v1(env->prog->aux->token);
 	env->bypass_spec_v4 = bpf_bypass_spec_v4(env->prog->aux->token);
 	env->bpf_capable = is_priv = bpf_token_capable(env->prog->aux->token, CAP_BPF);
+	env->bcf.available = is_priv && attr->bcf_buf_size;
 
 	bpf_get_btf_vmlinux();
 
-- 
2.34.1


