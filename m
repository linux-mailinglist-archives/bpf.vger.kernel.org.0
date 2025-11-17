Return-Path: <bpf+bounces-74692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6E6C62477
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 04:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7215C35E446
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 03:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0EB3164CD;
	Mon, 17 Nov 2025 03:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4AvlxL3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ED6315790
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 03:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763351389; cv=none; b=hL5zLxq+tlMpspuMldWxJUCPqg/QAulVqTEEpiBVk+O/SLSURQ07Ja4a+k6vEAvHtNXeAXQapiW8ejrkTDARRrAjKMMNEx0etK1syD1Q3dT0Zjvmcpv8Lw+SrnkTxKEMBcqJ5tARxDbaT6YO605dYJhD5PCR4f2V2R3ad9RuzI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763351389; c=relaxed/simple;
	bh=u5Rb2C9pYXvckE5T/TpOMjPCug8T6f4VewyBgd5lbhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cd7cwNaxv9rQQa96VovIBD74dZ1p+2sHiHEHKTRrCcJXo5HOxiyWT0K1sMD36OsSxrfIGFIvOgQQQtfgQVUGG8xRcSQrz1GBfCbyMJxHk7mA5xqgCye9p/DAen/dD/AxtVIOLlDVVcwgTZlmvDm67S2wShk2aAw90x/vTwc05v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4AvlxL3; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-3434700be69so5111458a91.1
        for <bpf@vger.kernel.org>; Sun, 16 Nov 2025 19:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763351387; x=1763956187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgOfihzSf2PbQKCPVjj6xpRGhPLmu6v43Rdyu3AIJZY=;
        b=W4AvlxL3Btg4V4jXhlninNiMhlK51RpIz5bUKtSb5vaa+hIr+j5nU/rTf+H2bdHjJJ
         miSQrV9FqHwuT8Su7+RKefFQwnrh2RH4xxTQvDQgd+uWUBiMj/HdNqhk8AZv5BmUaAzw
         zGZ9JVp0HkPfJrEcfyXXW72H+3nwEq/XEwK/9Brg9ikmOMMTmgkxyJ2AMQguqR5mEi4d
         wCPLn/gEOp+7G0YKn0/esgUs/B6h+pkaPujsLmntNPDSvkgtVWHtAcOmNXQ+qO3S/Mf9
         6MU0nXhmLgceOTcUckUsNLCIEk18QhTUGn57tKCilDPhI0j05DpEY58yJy8sIxi+0bpP
         9wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763351387; x=1763956187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tgOfihzSf2PbQKCPVjj6xpRGhPLmu6v43Rdyu3AIJZY=;
        b=dC5eU6wzowXUI4Iwnet8+YsO1hRzizt7qyL+LRw6cc87HEGTjEXxKRKfKwePplSHX3
         y7OMZIMlr0qZwhxeclRSGtL4nQ3GuHLI8OS5TCIW/txE0xGntVHu0Dxoxj6AlepZYPV0
         fT0A2oqwgP3y/DEaX62NvNPRu3oP/iCWDp2trZDu7JJIjowvHcQCdv5euCSy4ap7vCVP
         S47uTXT/EkAWhWEDC+h+aGwsOUGXK7RoMyNYFDkHy873in5jol5CbxZ3FK4XI7v3r5RO
         geGNMBpm9sWqhz/nH2+JnYyd5kB/4rO7kOGeOlCSkLGIotTCXJX8PYali0S7aXFg9XyK
         uSmA==
X-Forwarded-Encrypted: i=1; AJvYcCWy4/+6pvg475K2WSwzXsDhxDZKM155tqSZh+l2FPXCUVW+j3w005Ps6EF/uV/d/ZD3tlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Bn95nTIzI4WbIjK6VIziSFrx88+HY1MLbolp47t5j6DDhiA2
	/2smD4KXSEoIhAldj4o9WTCtx2cdVOKw7pvJ/itd7BLQ7bPW2vF719aP
X-Gm-Gg: ASbGncvLRJok7CaQy9zUf7Lk/3zxNhANU7YAKYp0UmoMhP/P+/EmIQAJfYy+8E4TwPK
	e2TJzrRXRNO5fAU9V9en9fg873N4Cjn7rZ8ZzXHIE+4K6UomkHY0o6jZRFxOT6sZsVZ8dQs1c3N
	K7u7u0jby+qQPaiK3nTF3r4Q3Kjl4V9jvU0VXMyaZz3z+H2cc6xkBzFY/6kW5VibHXWP5X9Emsz
	fezpd8B/2cYT/WvSIHC8cqIF2ufAkDQ71FO6/xZOhq5xPDi7RXEsXd21BHZ5ZsIFUSwHypr239K
	D0S1O8eEI6lG5jJ5wKyi+BRB9p/YKpYL/2QECkeW3hUApLRLm2vifcxKfKDC/qv8U/JENni39Vl
	XOpEf3Hm6a6Pvyi5q1GW/fNDzgi/tSNXYiz6Q/unkbmUEnTcVTlNZqc6E2zoPsMGW5SlWFbjaFi
	VL
X-Google-Smtp-Source: AGHT+IHagUEA3uPZ5gtcQdccIe+pzAvPra/VZ3Ntx70iEi1QOdM9Ilv7D22FAgxKJInZwTAya3ne4A==
X-Received: by 2002:a17:90b:2f83:b0:33f:eca0:47ae with SMTP id 98e67ed59e1d1-343fa7327fdmr11744548a91.28.1763351387393;
        Sun, 16 Nov 2025 19:49:47 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37703a0d9sm10348179a12.31.2025.11.16.19.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 19:49:47 -0800 (PST)
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
Subject: [PATCH bpf-next v2 6/6] bpf: implement "jmp" mode for trampoline
Date: Mon, 17 Nov 2025 11:49:06 +0800
Message-ID: <20251117034906.32036-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251117034906.32036-1-dongml2@chinatelecom.cn>
References: <20251117034906.32036-1-dongml2@chinatelecom.cn>
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
v2:
- rename bpf_text_poke to bpf_trampoline_update_fentry
- remove the BPF_TRAMP_F_JMPED and check the current mode with the origin
  flags instead.
---
 kernel/bpf/trampoline.c | 68 ++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 2dcc999a411f..80ab435d6e00 100644
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
@@ -440,9 +455,17 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 again:
-	if ((tr->flags & BPF_TRAMP_F_SHARE_IPMODIFY) &&
-	    (tr->flags & BPF_TRAMP_F_CALL_ORIG))
-		tr->flags |= BPF_TRAMP_F_ORIG_STACK;
+	if (tr->flags & BPF_TRAMP_F_CALL_ORIG) {
+		if (tr->flags & BPF_TRAMP_F_SHARE_IPMODIFY) {
+			tr->flags |= BPF_TRAMP_F_ORIG_STACK;
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
@@ -473,10 +496,16 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	if (err)
 		goto out_free;
 
+	if (bpf_trampoline_use_jmp(tr->flags))
+		tr->fops->flags |= FTRACE_OPS_FL_JMP;
+	else
+		tr->fops->flags &= ~FTRACE_OPS_FL_JMP;
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
@@ -499,8 +528,13 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	tr->cur_image = im;
 out:
 	/* If any error happens, restore previous flags */
-	if (err)
+	if (err) {
 		tr->flags = orig_flags;
+		if (bpf_trampoline_use_jmp(tr->flags))
+			tr->fops->flags |= FTRACE_OPS_FL_JMP;
+		else
+			tr->fops->flags &= ~FTRACE_OPS_FL_JMP;
+	}
 	kfree(tlinks);
 	return err;
 
-- 
2.51.2


