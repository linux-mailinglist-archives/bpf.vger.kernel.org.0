Return-Path: <bpf+bounces-74959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 452AFC69702
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0E174F0451
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 12:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89053570D5;
	Tue, 18 Nov 2025 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdobFG89"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B75A34DCEA
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469450; cv=none; b=FDtr41MevSIMzR7wjBp06htbJLBxAz8X8putaxEd64jI5Dd7TYVgOjxUWvVgmt+Hvk41JTBNBzT+h+9cp8HxsGGFYpSAvC6CZeg+rpoZ8NP+VMv9JUZwUnNiUZ54blEiWFOKzyLFGJlv3AhQWPCAm2VFqKr55IrDTd6mxxepvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469450; c=relaxed/simple;
	bh=+LW1LDwlw5aMWSZC+RME7xkgV6VVEeYQmuAgzKDmvtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/IQa17yzs//ERhcB1rRoOLO5TF3AOnAf8zCNh7SMZq5aAT67fj45GARSuOj4jUdBZs02Ujw4wH12r3W0MPjJXjHHogT66XNDwlNCvPNrQip2M0UgMNQTcNCTqorr5TGXNTEqgSRJ6hLdXpYBIQ2zr1w2P/qRbUtTePddQZA+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdobFG89; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-3436cbb723fso4151674a91.2
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 04:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763469446; x=1764074246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSVMHccR7qFQowMQrwveg0nRJjHYor4cBFPpOOVsWCI=;
        b=ZdobFG89XihdwouF7VTmof8NXxPPpnWRSF90gOqUX6zhmDlGfmbHn2i/29Wxo1sU2g
         ccGhFTB42xzYqgyitVQF/talHTSAEkDnbtmLPfu0tz+Dt5jOhujSUUT6j21NutwqBOmM
         96+jO+OOtuMRVbqKtzc1Dofeiny0hjYohyA1lPERR0yBqmgDhr80rFn9sKlpjNJLVU6G
         LZufg3zl7ltmHNaAmVW5az43B5u/IYQ9IQx96g7lFtdKhtuqeKE3UtPUPeg4Y/8K/sO/
         q5BWawOIq5k8Y7FeklGiIP0NsbL3NAuY3sxRkaUUoitmCJW/v4+1SaBwg4mAc2npL4yC
         4zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763469446; x=1764074246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GSVMHccR7qFQowMQrwveg0nRJjHYor4cBFPpOOVsWCI=;
        b=QfOi1fxeOBgUJfrebGtocI8aOV7P7sTPM7EeaPhMlIFQTT+XzcLyhxwVi9D9IuF3Hj
         hSuYJhgoTvbEZySQ4Ajd7Vt4onEvcIoaCY1UqH1jHNiC7RLYccIt2HaA/Kk2E/afLMOC
         rYs4Wh94AmTiIdMwKMyF+uVwcEuZq8BxXTuSB4ekDL2XDItMhZPL49mPY2UUPWlIWA3g
         XM40w1KQGNa3zrmAK88UoSmYwnFkRyj3qc0ssjU/5QlOv06s3MWXIErs9x+LocdkDHNq
         ybSt2/+/aRFIybCP85PBsNJ0ZxjIvLlrp4mO0mPj15JD57STZa1KR+Ms16eFKclsnF7m
         lDXw==
X-Forwarded-Encrypted: i=1; AJvYcCXSKK/gJSKvKtBuRnddusSHTWTb5rbTdMFUMjliDR/ygEb0NHg1oDZ0foV/e7fUW3LcIbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOCGNh15O+K7829HJIH8Ar0LFvJf5t2mdBxw61OWreWqGo/V47
	8ACCr/m5+Ixkg7F73XjMA+9IV0OiR6lPLW111QwuLixEl3PEhLXwe+l8
X-Gm-Gg: ASbGnctn505kjzqjJwAYC3OnLispDdPvvGC3IDxyPjpW6DAYAXM2KTN0z3R2jHQYlsd
	y7C5N8XR6wzSS1lhCKDty89lSiYGpNX+SYE1Ba87btrDX64Au8i7M25fa833ntpwucmJy0MCPrT
	lD2p7At9pSrecOHJyvrbCBnPA/EgZsPbseldFS6ULVkGzdulPJyL4vZuHvHID/0E09lkj2LAQrA
	VjPr3+xac6mNcmcVEstaJ065rMnYXC/LGj8JocKfQJ0kDbZ4FBTSa1HxHEQM993j3zNPLLfrtk/
	OrqQDqtGqdzaZfK7Rd5aQS6nQIjOTLM8fLCCg5gUGFuFLV+oUxsuLuhmz8KqK7qcnyS0VQRPt4B
	neGS2+NvCBDqbQtx4TXXWsK2lpLmXZUUBkzxSWB6SSEFm7YdRySK32/B/JIDdB7kVQ4t5Kr4Etq
	fHpHHzeGTgCe/GLhwVqIKyEw==
X-Google-Smtp-Source: AGHT+IHlB7JZdM0iuSFbQkeMsYxejQo0JNDWZPI7r1VSRlyryqeoQgKWNGwlsPQuVu65rP/M3ItuMw==
X-Received: by 2002:a17:90b:58cc:b0:343:684c:f8ad with SMTP id 98e67ed59e1d1-343f9e92249mr18880629a91.4.1763469446351;
        Tue, 18 Nov 2025 04:37:26 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92772e7f2sm16331496b3a.57.2025.11.18.04.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 04:37:26 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	rostedt@goodmis.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 6/6] bpf: implement "jmp" mode for trampoline
Date: Tue, 18 Nov 2025 20:36:34 +0800
Message-ID: <20251118123639.688444-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118123639.688444-1-dongml2@chinatelecom.cn>
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the "jmp" mode for the bpf trampoline. For the ftrace_managed
case, we need only to set the FTRACE_OPS_FL_JMP on the tr->fops if "jmp"
is needed.

For the bpf poke case, we will check the origin poke type with the
"origin_flags", and current poke type with "tr->flags". The function
bpf_trampoline_update_fentry() is introduced to do the job.

The "jmp" mode will only be enabled with CONFIG_DYNAMIC_FTRACE_WITH_JMP
enabled and BPF_TRAMP_F_SHARE_IPMODIFY is not set. With
BPF_TRAMP_F_SHARE_IPMODIFY, we need to get the origin call ip from the
stack, so we can't use the "jmp" mode.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- wrap the write to tr->fops->flags with CONFIG_DYNAMIC_FTRACE_WITH_JMP
- reset BPF_TRAMP_F_SKIP_FRAME when the second try of modify_fentry in
  bpf_trampoline_update()

v2:
- rename bpf_text_poke to bpf_trampoline_update_fentry
- remove the BPF_TRAMP_F_JMPED and check the current mode with the origin
  flags instead.
---
 kernel/bpf/trampoline.c | 75 +++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 0230ad19533e..976d89011b15 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -175,24 +175,42 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 	return tr;
 }
 
-static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
+static int bpf_trampoline_update_fentry(struct bpf_trampoline *tr, u32 orig_flags,
+					void *old_addr, void *new_addr)
 {
+	enum bpf_text_poke_type new_t = BPF_MOD_CALL, old_t = BPF_MOD_CALL;
 	void *ip = tr->func.addr;
+
+	if (!new_addr)
+		new_t = BPF_MOD_NOP;
+	else if (bpf_trampoline_use_jmp(tr->flags))
+		new_t = BPF_MOD_JUMP;
+
+	if (!old_addr)
+		old_t = BPF_MOD_NOP;
+	else if (bpf_trampoline_use_jmp(orig_flags))
+		old_t = BPF_MOD_JUMP;
+
+	return bpf_arch_text_poke(ip, old_t, new_t, old_addr, new_addr);
+}
+
+static int unregister_fentry(struct bpf_trampoline *tr, u32 orig_flags,
+			     void *old_addr)
+{
 	int ret;
 
 	if (tr->func.ftrace_managed)
 		ret = unregister_ftrace_direct(tr->fops, (long)old_addr, false);
 	else
-		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, BPF_MOD_NOP,
-					 old_addr, NULL);
+		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr, NULL);
 
 	return ret;
 }
 
-static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_addr,
+static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
+			 void *old_addr, void *new_addr,
 			 bool lock_direct_mutex)
 {
-	void *ip = tr->func.addr;
 	int ret;
 
 	if (tr->func.ftrace_managed) {
@@ -201,10 +219,8 @@ static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_ad
 		else
 			ret = modify_ftrace_direct_nolock(tr->fops, (long)new_addr);
 	} else {
-		ret = bpf_arch_text_poke(ip,
-					 old_addr ? BPF_MOD_CALL : BPF_MOD_NOP,
-					 new_addr ? BPF_MOD_CALL : BPF_MOD_NOP,
-					 old_addr, new_addr);
+		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr,
+						   new_addr);
 	}
 	return ret;
 }
@@ -229,8 +245,7 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 			return ret;
 		ret = register_ftrace_direct(tr->fops, (long)new_addr);
 	} else {
-		ret = bpf_arch_text_poke(ip, BPF_MOD_NOP, BPF_MOD_CALL,
-					 NULL, new_addr);
+		ret = bpf_trampoline_update_fentry(tr, 0, NULL, new_addr);
 	}
 
 	return ret;
@@ -416,7 +431,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		return PTR_ERR(tlinks);
 
 	if (total == 0) {
-		err = unregister_fentry(tr, tr->cur_image->image);
+		err = unregister_fentry(tr, orig_flags, tr->cur_image->image);
 		bpf_tramp_image_put(tr->cur_image);
 		tr->cur_image = NULL;
 		goto out;
@@ -440,9 +455,20 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 again:
-	if ((tr->flags & BPF_TRAMP_F_SHARE_IPMODIFY) &&
-	    (tr->flags & BPF_TRAMP_F_CALL_ORIG))
-		tr->flags |= BPF_TRAMP_F_ORIG_STACK;
+	if (tr->flags & BPF_TRAMP_F_CALL_ORIG) {
+		if (tr->flags & BPF_TRAMP_F_SHARE_IPMODIFY) {
+			/* The BPF_TRAMP_F_SKIP_FRAME can be cleared in the
+			 * first try, reset it in the second try.
+			 */
+			tr->flags |= BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SKIP_FRAME;
+		} else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_JMP)) {
+			/* Use "jmp" instead of "call" for the trampoline
+			 * in the origin call case, and we don't need to
+			 * skip the frame.
+			 */
+			tr->flags &= ~BPF_TRAMP_F_SKIP_FRAME;
+		}
+	}
 #endif
 
 	size = arch_bpf_trampoline_size(&tr->func.model, tr->flags,
@@ -473,10 +499,18 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	if (err)
 		goto out_free;
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_JMP
+	if (bpf_trampoline_use_jmp(tr->flags))
+		tr->fops->flags |= FTRACE_OPS_FL_JMP;
+	else
+		tr->fops->flags &= ~FTRACE_OPS_FL_JMP;
+#endif
+
 	WARN_ON(tr->cur_image && total == 0);
 	if (tr->cur_image)
 		/* progs already running at this address */
-		err = modify_fentry(tr, tr->cur_image->image, im->image, lock_direct_mutex);
+		err = modify_fentry(tr, orig_flags, tr->cur_image->image,
+				    im->image, lock_direct_mutex);
 	else
 		/* first time registering */
 		err = register_fentry(tr, im->image);
@@ -499,8 +533,15 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	tr->cur_image = im;
 out:
 	/* If any error happens, restore previous flags */
-	if (err)
+	if (err) {
 		tr->flags = orig_flags;
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_JMP
+		if (bpf_trampoline_use_jmp(tr->flags))
+			tr->fops->flags |= FTRACE_OPS_FL_JMP;
+		else
+			tr->fops->flags &= ~FTRACE_OPS_FL_JMP;
+#endif
+	}
 	kfree(tlinks);
 	return err;
 
-- 
2.51.2


