Return-Path: <bpf+bounces-73206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8880DC2717D
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 23:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C8F3B3A54
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 21:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDF332AADB;
	Fri, 31 Oct 2025 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJWlN19I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B22329E68
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761947941; cv=none; b=O+NVRMcl/C7vRAsFlLUPBeIan2EIjxs05eeZuRSZ+0llQCqZIvMU+ElDAhCSbHXtk3+FJao2BLq7lwIHiHyshfRXLrHYSDohDIqmNO58k28v9R2sUmmHbho03dKbgfCc1o3c9jGwxOXLim2P8zQRNTH7uK4XgymsRs7cPaY0KW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761947941; c=relaxed/simple;
	bh=BkHalLtkAa4J9fJePE89GqYEYOm72y3dNXH26IygM2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+OID/aYOKL6Ge/636xFwFWLmZh3w795mn2VStzuB90fQV1EgF0UgGXIN/+m4zTszCcjrVQryddVU57E9r6VskAuRK7YTrz+ahKoDWkCPoWexM1LXT/SKcmawK1UlI7bDY+gPTTrYkPSa1PGlWEqXBr1YyfmQaIzsGQsinT2izA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJWlN19I; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4298b49f103so1098670f8f.2
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 14:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761947938; x=1762552738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTevzoTEqi9y+VAzFlBDud/Ap/l1cSEfcPY8yXHnVQI=;
        b=eJWlN19IrNVgdFtyIELzZxw9wI+JrUVjkM8U9TSTtAM9jeyfHI+CZasY3QP7eX/mPE
         KKWqGHsNjqLeLUZKe2m2CGxHRbOTehFjrSt9DJxsvL+5Em223H5g4JOBIH+cUPnvPtXW
         3AkcDuw33sHukb5bpvEapvvPMwt9EPQgGmFpbhdsxGkzDbIo1MaY8fJPxZmt2qXbWJCU
         5dY3Z30TAp/UK5jwReP9nAH1xmhwa3HRbnfXW5XMmfSFzERd3Wcs2OWMaUqftYAVa+7v
         ySE75jOBayhjOL2azSluEKDGuS6KxVd4Y/MdDxJPcU9mvQrddlCIynI8/ziYVl+GBiL4
         XYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761947938; x=1762552738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTevzoTEqi9y+VAzFlBDud/Ap/l1cSEfcPY8yXHnVQI=;
        b=t8L0+1utiOJvtigLRkyUQbwuTAude4Bo6ASe7lvv5tOPDHkCNFovOoZ/A54/WRlPHV
         WaUQmBZCHqc8dPs/8za/yL8ixVYwUbJd4Zasr7AxAOYCfqZpVg1neCW/59FNHpDDVv7E
         u1Twz4yd1FxIo4+BFjEVlS+YJQVPWGLyjZf7N/ZnibAQ5RGnzo/2CvNpso09v4ONn/pZ
         0HBFVirVn639GOlB6x0vzbs8d3Fvrn6ivigSoyzebiy1DvOLjUSR97WeheRCXipD1P1s
         AnTpOhBfxNtje8fwk0GMXRTvtoD31j/wPZZJbx85/Jj1rIPmVYskOudZSabox1Ke1a1H
         gpHQ==
X-Gm-Message-State: AOJu0YxO7WVMDOHWSAbS4Dc7zBkQj2L1cvj/HIsS9L/ZgpIIQagQYjdj
	Ec4+ClQpmgo2Sqf9O9FgPMbCyWI0WmTbgip+/9t1Ow95s8tOtnM/bB7c/4qEWQ==
X-Gm-Gg: ASbGnct7pR9GXadYryac8BA1gmdWzUcokg1Ue/lQbQfDluBkH5uMPo/PkpmlaIIE1cX
	G8gzJLJ7Q/Vu6GMDMN8az1IaqET6wDZw7Fz6R9CkHRj1Do66jqae6hARQXSuW2jM66mixNL7bQQ
	74MPayuNXPS/Pvd6Jz93tljs14CXKq55q9B+gEhZOYf9iByqXgfvTADPpN99K2YM1t4BsAD5++U
	qoz5nIquf9Qb2zv4lXvl/V5Uhvt3AfvLS2/c9xAq4brwOt33o/yJUzIbaWFFqxj7eyttquA6L6s
	tKjvie3W6+1Sa72VCNTIdfJQVtSKlkQaaQ5pShvzGtKlVaaGBESGx/iqM8RCRW/d3iTWaeblnTV
	HQGrbShH2s26JNvy3HdXIVtnl5UK76zF7toVjR2h9RD04zIj88OJcAARrT8UAdG0mJV28xiVXea
	gi4no=
X-Google-Smtp-Source: AGHT+IEkHPjqr/DNfYl+324tb1mD1eBYWCWi7WeEbpZvsI/fU42kmj9WISJTXvmYqgVuan3OsUPuKg==
X-Received: by 2002:a05:6000:4305:b0:428:3ee0:6965 with SMTP id ffacd0b85a97d-429bd6a7930mr4283581f8f.43.1761947938052;
        Fri, 31 Oct 2025 14:58:58 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fd38c4esm28527365e9.12.2025.10.31.14.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 14:58:57 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH RFC v1 1/5] bpf: refactor bpf_async_cb callback update
Date: Fri, 31 Oct 2025 21:58:31 +0000
Message-ID: <20251031-timer_nolock-v1-1-bf8266d2fb20@meta.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251031-timer_nolock-v1-0-bf8266d2fb20@meta.com>
References: <20251031-timer_nolock-v1-0-bf8266d2fb20@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Move logic for updating callback and prog owning it into a separate
function: bpf_async_update_callback(). This helps to localize data race
and will be reused in the next patches.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 930e132f440fcef15343087d0a0254905b0acca1..e60fea1330d40326459933170023ca3e6ffc5cee 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1351,20 +1351,17 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
-static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback_fn,
-				    struct bpf_prog_aux *aux, unsigned int flags,
-				    enum bpf_async_type type)
+static int bpf_async_update_callback(struct bpf_async_kern *async, void *callback_fn,
+				     struct bpf_prog *prog)
 {
-	struct bpf_prog *prev, *prog = aux->prog;
+	struct bpf_prog *prev;
 	struct bpf_async_cb *cb;
-	int ret = 0;
+	int err = 0;
 
-	if (in_nmi())
-		return -EOPNOTSUPP;
 	__bpf_spin_lock_irqsave(&async->lock);
 	cb = async->cb;
 	if (!cb) {
-		ret = -EINVAL;
+		err = -EINVAL;
 		goto out;
 	}
 	if (!atomic64_read(&cb->map->usercnt)) {
@@ -1373,9 +1370,10 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
 		 * running even when bpf prog is detached and user space
 		 * is gone, since map_release_uref won't ever be called.
 		 */
-		ret = -EPERM;
+		err = -EPERM;
 		goto out;
 	}
+
 	prev = cb->prog;
 	if (prev != prog) {
 		/* Bump prog refcnt once. Every bpf_timer_set_callback()
@@ -1383,7 +1381,7 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
 		 */
 		prog = bpf_prog_inc_not_zero(prog);
 		if (IS_ERR(prog)) {
-			ret = PTR_ERR(prog);
+			err = PTR_ERR(prog);
 			goto out;
 		}
 		if (prev)
@@ -1394,7 +1392,19 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
 	rcu_assign_pointer(cb->callback_fn, callback_fn);
 out:
 	__bpf_spin_unlock_irqrestore(&async->lock);
-	return ret;
+	return err;
+}
+
+static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback_fn,
+				    struct bpf_prog_aux *aux, unsigned int flags,
+				    enum bpf_async_type type)
+{
+	struct bpf_prog *prog = aux->prog;
+
+	if (in_nmi())
+		return -EOPNOTSUPP;
+
+	return bpf_async_update_callback(async, callback_fn, prog);
 }
 
 BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void *, callback_fn,

-- 
2.51.1

