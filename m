Return-Path: <bpf+bounces-79115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9872D27AB8
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C586317C2F1
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734823D1CAA;
	Thu, 15 Jan 2026 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbmT/d0y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651D53C1FD5
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501754; cv=none; b=JLGQmfSlwronbsiRslYbQYhJBwL5p24P1sTLIGAhIDkl0ndn20BeKeK8ViFCvTIpAW2TuoqdMcXhcfloq8G2cLUgIOeJlzsCTZvgKxvVezCqa6szp29EuSWCDDiidQeGl8czL0SADVuQzMtDhn2zFRjYW31vVFu/V6ymOBK5wNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501754; c=relaxed/simple;
	bh=oe6GDui7FMv3LDfCEhW37Oz6mPNOMbcHAzTPsPU9dQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CVhM0OPcoC63lYe5wnNdvLMGck23uH+i2hoV5pCvLLGDsNPQx5QSZVmrXeuWCHdqLhZqdOQgxbBYQYXoGTE79iNV/UVoUnylY6ArXmMwXtDtDh6u59cEkye9aHihxGveojgnkEhQ3Osa0zjk7qKhwhbiHILHrWSSNpRcDXX2nHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbmT/d0y; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43246af170aso708705f8f.0
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768501752; x=1769106552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TL6z+/oc/aj3XyufswKP/E3Ri61zjbrKqbwC8BK0GWg=;
        b=gbmT/d0yFoF5lYCyT5c4c5CGWWSmBLrmWHoEeyEXHe17ln//tXjj8ljTfqz17hI9S/
         WZT1NBiU+43F7B9TXP1o7KY0j+YgNa2vHvcspungz7BmiNBDlPIIjJNbLJKbbtBDcIQA
         N1PLjbwd5u1aeq4zaspzTDq+UnE7K/p4HL7fUVMnuscrlAWpVC5vXu0Qj9uZJsd61Tu4
         MSJmaNZfpjVOW8yak1ufkxMImNvAJ+ypQGiX+PmJ6Er+/QxF4pAZehYQd11HfIWZUtvo
         iY34cj0DzOZQe1o7wTHvMoVvUpT2H9BWlwdiPH5mxvV6Nhi3JxoXMUcbkxdNmk6+0CSk
         qW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768501752; x=1769106552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TL6z+/oc/aj3XyufswKP/E3Ri61zjbrKqbwC8BK0GWg=;
        b=j8rn/62z6kjoEamp3PQFb48T+gf9bcedClPB/LoLC8rwpkOyBBthqyFJgMPfHin9Hb
         47Rkmj74SBUUbabF4t2NdaZlo3/mVL+yWuqLFGC74B9vgQ2CklHdPgBLprzzPlID5DFd
         B8JRf8ptdwirzeD67hteQWgZSRrNlVsj4vOVtHhewBXF8n2YFbTtw4Wir4bFpa0SmYI2
         OfTIVnhszNCtgC2cuPFniwBfj4KwXlQT2m753b7RObZy+8+vxFrz4wie6OjeP6tl4SST
         yyfPa/A5j2oEkTqKTZ6BXbYXHPtKKEBZOFg1jLjZrbM5gWNNV5s8w8KjCE5XnJzIU1MX
         U+/A==
X-Gm-Message-State: AOJu0YzOl6F5u8dhj8CHy501M/ErHtCUklbGVJRfDCdltLh2xkYbXR0w
	jD1UpICwEu7WnNYOzE8u+UK8WZaFb4eAHZBOYdmEFJSz35MA5rM+dQkcjTNS+Q==
X-Gm-Gg: AY/fxX7rHxoZJNpopq0VfnBwBXSN3dUK9oSz6Lb5kfXdTPszDXgGgXnHdpUAeEniODM
	GPFMqBeTqIBRJ3sA3u/Ui5i8O6LQ7Om/1YMoHCGb6/htM/iZXGNbttxOWZj9yzh9kspB8ZnLhz4
	c9cqG3StLxuwS6mfAwyQpy32SgWDboYqqMShMzUgWX4UhhtkyAwIs2tk+3MwD0HizZ3lhJba6AH
	d4WMQxs4JwBK6QotHpntIhR1UdIX+/b59DoLbpKNDsGcX7Kx/wcgkJ0QplsZWa5aGNcXGgxj7c+
	EQSQSr34JFQYsn+0e2QMQctTknDUrzlx9boqaZIqArumJQPJ/5xmDmQ0IZsFFuC4fEHaqyl9Qv+
	/rKFg9hLRLiAYk3mxah64MsSncGnTnY+WOBDf20hKHKCE7ooCb3HTUit2isNmsWamFQ==
X-Received: by 2002:a05:6000:2f88:b0:425:86da:325f with SMTP id ffacd0b85a97d-43569578149mr536147f8f.27.1768501751596;
        Thu, 15 Jan 2026 10:29:11 -0800 (PST)
Received: from localhost ([2620:10d:c092:400::5:2520])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997eb2asm493218f8f.37.2026.01.15.10.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:29:11 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 15 Jan 2026 18:27:54 +0000
Subject: [PATCH RFC v5 07/10] bpf: Introduce bpf_timer_cancel_async() kfunc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-timer_nolock-v5-7-15e3aef2703d@meta.com>
References: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
In-Reply-To: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768501743; l=1365;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=fvqTA7mp+ilu1PpBDW0v9BGBvZHnrY5oIYAv2Xx0viI=;
 b=KFChsXYvHuQkIT3y9+70ASgxtEgnXPgkoidSSfSf/dOCNTVHmsKAy5VFToOKHuv1Mr1CyxiE1
 Pf3N4dveFgGBiJ4Rb9oQkA97Q5Jk/0BA9n7SV2TXA1DdEF8fsXInRKW
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

introducing bpf timer cancel kfunc that attempts canceling timer
asynchronously, hence, supports working in NMI context.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8c1ed75af072f64f2a63afd90ad40a962e8e46b0..e058102a6d4fc3d7b4bf507f92f876370bc32346 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4483,6 +4483,19 @@ __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
 	return 0;
 }
 
+__bpf_kfunc int bpf_timer_cancel_async(struct bpf_timer *timer)
+{
+	struct bpf_async_cb *cb;
+	struct bpf_async_kern *async = (void *)timer;
+
+	guard(rcu)();
+	cb = READ_ONCE(async->cb);
+	if (!cb)
+		return -EINVAL;
+
+	return bpf_async_schedule_op(cb, BPF_ASYNC_CANCEL, 0, 0);
+}
+
 __bpf_kfunc_end_defs();
 
 static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
@@ -4664,6 +4677,7 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_signal_impl)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume_impl)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
+BTF_ID_FLAGS(func, bpf_timer_cancel_async)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {

-- 
2.52.0


