Return-Path: <bpf+bounces-74493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BF2C5C4F6
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 10:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AADD5036BB
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4379F307489;
	Fri, 14 Nov 2025 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yzd8SLfN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB0130B52E
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112336; cv=none; b=sa0i5z+Rfvqw8cvwe7c7433p//fIfWuIdnABnE+yTDxT9fk60+RBVBbw++yz9Jyd6YRmUHpuQ2d5EEbxFClPj4ru95nydSQKXOlnPL/ILjEW9pyHAz7y6U8JzT0tPQtxRfdBHdrxPOj7A7xfztM55uWx3qH54GBuTFOMZRYs6Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112336; c=relaxed/simple;
	bh=TIjsGgErGjhnsODM1Ph/ITY27XoQ96fhmRIiGKpLPac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TO42TdBSwp981Bpo/DLUT0WXegCSbqDNtVOQ3TJfL7K1rukuEMBViDEdl4jItitJwmSanQMPQT/QiHtgw+vPfEsyfa3s3jqTJEuHhhZoCabM6/UCMBbCsIaahqIqP0XJLqnmYlr5UpIMLU2J4m5LifncU7Y8p9qHoAxzk3cGcfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yzd8SLfN; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-298039e00c2so21870305ad.3
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 01:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763112334; x=1763717134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GH1XgjhxGvH7eOvtS78BjGizHMW/kgqOUJowiQXUBA=;
        b=Yzd8SLfNYUGICSEwn2XJUh+BrNTaUlFEeE2/2izq4OQlev4UEVBlmPG9MumotdLadi
         6VfjXjDSQtHlJpcq7X9DfD6RQt4PBKeNr5+xBQmZEVu+GADo1eM3CdM89Rxk9tZsWo5m
         vIndcC9wXByLWG44c9AUDHCCOOXcQ2QDcXCN17zaEzR0mz3IYugeTpppNXpL+Hn2vdyF
         84Si5QUrCjnhR5Tumgz2lSCWvv/6vMXr3e5OQwqcTGQ7MzN7aDbjkWMQhphMMVawxged
         8gb6dUxrsi7tKKyvjaMvSK3SUV+W6jASh/7AzvpcqCyx2dbUBzfOZvWdCJBeTWEwqTgi
         PMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112334; x=1763717134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0GH1XgjhxGvH7eOvtS78BjGizHMW/kgqOUJowiQXUBA=;
        b=l4WWIgR4QOXmQgVvX+qMzOm4FC4lvh8X6cGtxlaW0o0RQWqQKPYEJ3zXLjITxkzU9a
         GIWy/Vfg2DMuIsCrchcO2aU3oDADsBn1Na0Sduwe9wh15W+fEUL3Ld/OGH0n6ldzLzyT
         jpYrqmyR1mBoGFRpkSBswR5fnucS1tOi52l2aFJJkO7kYL1Ra6xzeLiTEuZLYH6To6hx
         apzgWVyGeVqmgTZpg2m0JWzlPT4ABhT1w65QfGqvv92nhTLjbc93XRYT40Z6kmtEqsem
         47RYMTDQ7VN01oQENdSzC2UGWVls3HanPAB+HLvXfJoAKNGl/HvmnsTiepAKDZtK9ifv
         EUaQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/PhC0G52PiRlVgSSxtkAvdFBXcjpgQkyAcyWA6chrm9sIiuurLM+w6gstb3h9fh0oghY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Oq3TjlKWn1XOUKPoI4iyAnWbKVxWO/pqO0wZug/NyXG1DQqq
	D06/P8YE4/aUvyArT0uRg0zHEpH1lBBXKteQ/maTsYOIsyqBjwfqq6zY
X-Gm-Gg: ASbGncvYJpxpswu+/CAi/dPpwM7xNYH9u2zhGaoTPyZSC2TbixE17thZ+bw4HKqLWl1
	ldOygs5t17YG1buzsWKN5CCKxy632hNTZE60K3vboYEXvw8mk8bq3tnmluAOX9ap8LUw3JxZz7M
	c5bAZRGnEueQ+Zczd8DehjwFwt7hfs4HdhoZXRKgu7O1eue+kV6xuHiRyAcfpVBGBPBuDJrNlIw
	e0BXcqYuna5JZfMkeMvzdqch0h7WsGoRt9PRuQMQcqNjYUQI1liVSsto8XhLLLtG8h9wSFadkxJ
	W+vXuJfnFVoZrxRtcpMZ+p24kPaTJIFbGGNYkQuhdOAMKaQF7R/9LB1s9t4PIlow/WadtOGMG0p
	94wJsShUvZSFpdVxjKC2njg7cymVpRJIsRRGti5tNx61vzFHG66t0saaveE7MH6YHlyDusXunx7
	Kf
X-Google-Smtp-Source: AGHT+IH8JdBL4kgG2wlYs/vtfYVs3OXl9lPqSBwJDQ1zGrYP08Gk8O6hyA6D59Y+JlLxX9WZiLPJ4w==
X-Received: by 2002:a17:903:2f0e:b0:295:8c51:64ff with SMTP id d9443c01a7336-2986a7420ebmr27102945ad.29.1763112334321;
        Fri, 14 Nov 2025 01:25:34 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346dasm50451525ad.7.2025.11.14.01.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:25:33 -0800 (PST)
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC bpf-next 7/7] bpf: implement "jmp" mode for trampoline
Date: Fri, 14 Nov 2025 17:24:50 +0800
Message-ID: <20251114092450.172024-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251114092450.172024-1-dongml2@chinatelecom.cn>
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
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

For the bpf poke case, the new flag BPF_TRAMP_F_JMPED is introduced to
store and check if the trampoline is in the "jmp" mode.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/bpf.h     |  6 +++++
 kernel/bpf/trampoline.c | 53 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index aec7c65539f5..3598785ac8d1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1201,6 +1201,12 @@ struct btf_func_model {
  */
 #define BPF_TRAMP_F_INDIRECT		BIT(8)
 
+/*
+ * Indicate that the trampoline is using "jmp" instead of "call". This flag
+ * is only used in the !ftrace_managed case.
+ */
+#define BPF_TRAMP_F_JMPED		BIT(9)
+
 /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
  * bytes on x86.
  */
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 5949095e51c3..02a9f33d8f6c 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -175,15 +175,37 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 	return tr;
 }
 
-static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
+static int bpf_text_poke(struct bpf_trampoline *tr, void *old_addr,
+			 void *new_addr)
 {
+	enum bpf_text_poke_type new_t = BPF_MOD_CALL, old_t = BPF_MOD_CALL;
 	void *ip = tr->func.addr;
 	int ret;
 
+	if (bpf_trampoline_need_jmp(tr->flags))
+		new_t = BPF_MOD_JUMP;
+	if (tr->flags & BPF_TRAMP_F_JMPED)
+		old_t = BPF_MOD_JUMP;
+
+	ret = bpf_arch_text_poke_type(ip, old_t, new_t, old_addr, new_addr);
+	if (!ret) {
+		if (new_t == BPF_MOD_JUMP)
+			tr->flags |= BPF_TRAMP_F_JMPED;
+		else
+			tr->flags &= ~BPF_TRAMP_F_JMPED;
+	}
+
+	return ret;
+}
+
+static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
+{
+	int ret;
+
 	if (tr->func.ftrace_managed)
 		ret = unregister_ftrace_direct(tr->fops, (long)old_addr, false);
 	else
-		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, NULL);
+		ret = bpf_text_poke(tr, old_addr, NULL);
 
 	return ret;
 }
@@ -191,7 +213,6 @@ static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_addr,
 			 bool lock_direct_mutex)
 {
-	void *ip = tr->func.addr;
 	int ret;
 
 	if (tr->func.ftrace_managed) {
@@ -200,7 +221,7 @@ static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_ad
 		else
 			ret = modify_ftrace_direct_nolock(tr->fops, (long)new_addr);
 	} else {
-		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, new_addr);
+		ret = bpf_text_poke(tr, old_addr, new_addr);
 	}
 	return ret;
 }
@@ -223,7 +244,7 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 		ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
 		ret = register_ftrace_direct(tr->fops, (long)new_addr);
 	} else {
-		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
+		ret = bpf_text_poke(tr, NULL, new_addr);
 	}
 
 	return ret;
@@ -415,7 +436,8 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	}
 
 	/* clear all bits except SHARE_IPMODIFY and TAIL_CALL_CTX */
-	tr->flags &= (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CALL_CTX);
+	tr->flags &= (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CALL_CTX |
+		      BPF_TRAMP_F_JMPED);
 
 	if (tlinks[BPF_TRAMP_FEXIT].nr_links ||
 	    tlinks[BPF_TRAMP_MODIFY_RETURN].nr_links) {
@@ -432,9 +454,17 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 
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
@@ -465,6 +495,11 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	if (err)
 		goto out_free;
 
+	if (bpf_trampoline_need_jmp(tr->flags))
+		tr->fops->flags |= FTRACE_OPS_FL_JMP;
+	else
+		tr->fops->flags &= ~FTRACE_OPS_FL_JMP;
+
 	WARN_ON(tr->cur_image && total == 0);
 	if (tr->cur_image)
 		/* progs already running at this address */
-- 
2.51.2


