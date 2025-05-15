Return-Path: <bpf+bounces-58277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5BBAB7E47
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 08:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77F44A78FB
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 06:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A337296719;
	Thu, 15 May 2025 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PeLUz3zw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E531C27
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747291693; cv=none; b=bzSnY2ufCkscEA2YsZiXaPQZeKN8IXk3iAvQvuJwm4aEf5ca6whwHXmVUyo54uC7Z7CgycmNaD/yyhP1wV98DdRan2xzqjERM6qoeWLVytECDX9WTiN5ZZy/O82rfVtYgpm2P8v6L0F800Xoq1rxQ9k9Fv4+Je+gn0blovbXlAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747291693; c=relaxed/simple;
	bh=pCOKfqrUqerqVW/lrEibXtb97pPwyr9mufaH1jke1PE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P0rDCeVqeIp7/z1Ly9vdfihhQanCSrxhC+QVPHb9pK6Unqlpn6eUTaz/fcgwlnnimLZG49+eDQ/WSkzubaHe6Q/DdvpNZLEMXQ5LJvFgD5QH7iytiNa2+7AJYdx4uiAYfYNJSqStcuZM6uI+ZtONvsnMcW8AU2wqAQXooagszdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PeLUz3zw; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b2093aef78dso525028a12.0
        for <bpf@vger.kernel.org>; Wed, 14 May 2025 23:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747291691; x=1747896491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4O9Ag2+phgLJMMiW8a2CQx+t0xdJte/3dUf07UrWGag=;
        b=PeLUz3zwRPLpwxL0lPMWMzaEJUMMHZ0sDHyG3oUnfCPcC29+rOiGnBmtrEwPVUKtUc
         FbZB2PC9OiLAw5ealg2hPfiG7ztvy6QNUZnMhchateMkE1jaNrtdQROeZZcenNDgFvF8
         sGcN+x7EzTTKUR6BREMj2fUnDcydZJ1TaOjKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747291691; x=1747896491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4O9Ag2+phgLJMMiW8a2CQx+t0xdJte/3dUf07UrWGag=;
        b=es10z+RteayiMO35LllTpXsQIXugNpTGBOAFCpPWlZBsNLdTXgotZCo+ue5ml2gP77
         i/uOEvzZL2WCfkPUnR2hkFtTGTCOqVpgQMt1jzfSq73Q+XlNtFPYcXvtjYELs8ETxcNm
         0ELrLvtY8MOqsbiXqoIIqvxE8R85PlaHeMfEEEgL5AjmZP5Pb8tpNJ6j+yebhgg0oMKy
         gEP/x8PSInTm8OoozeYKvkBQneBmsQMW93u3DF/OqsUSN7Pz/C8dRSidbW+xdVJR9Xn4
         GsU7JqiIGSAOJ0wWYL03p5U6mNZQ+oxScH2MuR0RX+tABGMZrndsxABjfke4K4jx4gBH
         xy2g==
X-Forwarded-Encrypted: i=1; AJvYcCWRi7KuhmkF9uN1gSnZy73tWwlzrGHpfMaf3p7a/zKbSUfBeTJVWSNaOx1HSZIVUUmJXJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvPjZ3m9PejFq1hHrkV4cPb76eD38CwLD3zQRaM6lg5RG7QX6y
	uMSTUR2xEcAwMpMS0bno22fwn8gNNkkZqXdlrYYPxvfNMQfYOEx18iBH9AiHdw==
X-Gm-Gg: ASbGnctpl2s1w+q7Aq7DQB8JGuPtpJWvMN/WUDHLQfYiED3Tj6fFqWUb5N1I1UrdnnR
	MAS3dB10FCM7GWobJh7ehL4YODfBRAo2vbVRnLzz43REhyPJE4UXVFGaXfnRmxCXk36AeH1TRbp
	QWDw60QSED2lK86eckF2xURendKXdcG4tyyLxSDWNCdTHIZqMZgYBQmNn2zc1vXKf/8HKIpCj05
	5DMHY02WA8QqzGU3BHrWq8nuZ8JibF2HfH5G3xFxHXBApFuvp+GTTbJaQiPvE9880ZO7WdMDPKi
	kt5mnb9KM/mSNCJya9JAKXEfUDK7XOVt8uUZTJaj+Vo7dKIao+YSDPlWUOZtInNGWZBil3MM99/
	Fbw==
X-Google-Smtp-Source: AGHT+IFd4TC3pjFpUh1gYRkIvDJD3J/aYbWd+r4NPLgxJSMSFO2ecsNHnoVnUUGCRYcQ9ui1VNtjIw==
X-Received: by 2002:a17:902:ec88:b0:220:c178:b2e with SMTP id d9443c01a7336-231b605b0afmr19562775ad.17.1747291690800;
        Wed, 14 May 2025 23:48:10 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:291c:c511:a135:fe23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7549200sm108636875ad.10.2025.05.14.23.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 23:48:10 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2] bpf: add bpf_msleep_interruptible() kfunc
Date: Thu, 15 May 2025 15:47:40 +0900
Message-ID: <20250515064800.2201498-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_msleep_interruptible() puts a calling context into an
interruptible sleep.  This function is expected to be used
for testing only (perhaps in conjunction with fault-injection)
to simulate various execution delays or timeouts.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---

v2:
-- switched to kfunc (Matt)

 kernel/bpf/helpers.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index fed53da75025..a7404ab3b0b8 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -24,6 +24,7 @@
 #include <linux/bpf_mem_alloc.h>
 #include <linux/kasan.h>
 #include <linux/bpf_verifier.h>
+#include <linux/delay.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -3283,6 +3284,11 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned long *flags__irq_flag)
 	local_irq_restore(*flags__irq_flag);
 }
 
+__bpf_kfunc unsigned long bpf_msleep_interruptible(unsigned int msecs)
+{
+	return msleep_interruptible(msecs);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3388,6 +3394,7 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_local_irq_save)
 BTF_ID_FLAGS(func, bpf_local_irq_restore)
+BTF_ID_FLAGS(func, bpf_msleep_interruptible, KF_SLEEPABLE)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.49.0.1101.gccaa498523-goog


