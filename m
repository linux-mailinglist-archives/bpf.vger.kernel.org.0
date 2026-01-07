Return-Path: <bpf+bounces-78055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B0ECFC384
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 07:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D3C7301FDA2
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 06:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17C629293D;
	Wed,  7 Jan 2026 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQlbokat"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FA327A461
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768324; cv=none; b=BIIVDWX3xodWuiXIra8XAXs62t6N2SM0gGjCJoASfAa5AQidR3jbknFTCZfvYqgTjCQz84CYMiS6P23mqyulUlkNzglxSYkuTo5EpjnD86yPWo0RjIGW1CiANbLhDtCI/9wofgM+pTPHp0cjknOe+On3dVr1wW5kKd030TrkejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768324; c=relaxed/simple;
	bh=XHarCaGaxO4UOuhsLfcJy1QlrtGM5hU6MX1y6/kQaWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyIlEMCPOGuml506JNkwKeV6lUwLE4RQ3VRVNYpuLMdhYfFHOsAqrhZf54DuLJ5r5wYzm5kVLY4Vw2WAG+OrJ6der7y8YzO6nJCwsvksSiP7FXGiwkLY+3eXoiuE9MQK1RxYyAzzaiMy5vxvKlTLsImUONYlDg6fKpI29KKVeUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQlbokat; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-790abc54b24so14633397b3.3
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 22:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767768321; x=1768373121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngssSFUNq6ZVeh2IW9d/LUmz0anO5RIn1dRAez89M0E=;
        b=CQlbokat5/UVYYMK4IsMfRWSdQl3A2/rbIEzQiKT8rTYqaG/PlMKn58qBZHMJqY6PG
         pUgWkrQh6YERUCSBtfhEVNBVzGvPTramctImvSD1ANKCLpXA7dGPjRl4VOM3HpoorRlY
         9XvyjwpRBtitHXWBghhzpFDsr8D3xnCHdvlkLdP7fo/OQgr0xSICPACCb0KM2geTLDSb
         MVJg2ffZWfFJ2CsD8N7TgV7jsQhMwews0/cH4mTk53Et0rCZXha7VKaVrKHsJ/dBZBZE
         2KqBEpoZ8XborpJ5h1gRAG8W0N21iTMFbBDe5MjhP5/8YeA+SnF/DEviNzulB1+JN7qL
         /o5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768321; x=1768373121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ngssSFUNq6ZVeh2IW9d/LUmz0anO5RIn1dRAez89M0E=;
        b=DYEOB/JDzo9KE9hqAMATNRcGbnncSbMLk8Y3ztZ6JauUVwyWuVxq0djheQpqYTTTqy
         6pTw8Q/pm5SQ7GLSro1TINgp9Ed4MKIWaIzvzMK1KVhOnVYI1rW9G5RAX6MVflV8RLgG
         BL8uLnEskA22VGXYsUR8fHFRWRG0FtukQfnrxbdGGZUD2DNWkP43JI7XRfod9PJifsS+
         D3rb5p25AR7yEzmuxtpEDSpqWllYIx6+yYMNb5+RNQJZgPglEfT03Uo4mUFcOyDJRL5z
         rX6Kb3yk0Wd1GnpEkWHkmOnZs6QJGAgw+iG9/pJN6bx6M8sG4vtrj6Bl2baa/Nme0rX0
         dEaw==
X-Forwarded-Encrypted: i=1; AJvYcCXE9uKEgEoJKsZZr06jixM90YBORv+Og62fiPyaoMcI4TXqZvPkGaD3YROwsr81sY6s6Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9/WTy5VNgVyjXylwtqnK5vW8KkKQpinXudmYyqwrkRwUZoWRp
	3Dym9baHDJfJeof3xgJqcfGrTcZ2IMs0SJqhN9wyYw7i9LZ8TUcEVzMw
X-Gm-Gg: AY/fxX7xuX/SjWKb2jlixveQfG/gpudp5VtG/hGQB5wCSIR705r4ZNKVrlvgj5naAO+
	TGYhb13x7fl0VFE4PgVyXq4KuQz+N8Jzoj6t3dfXDb8i9HrPT0hkicYGI9IMihTd5HVnrPj77t7
	HRrFJ2UrhCjortlasQ16BAdzp90JfdAjKX4b2zfI4+cO7JQICpW9Ebh0p+iYOatStjovlG7M0LX
	C7JRBVWADN4EuZm7SMvn1rqq0ncKCfcTN/VK57r6VMgFRu1H97/iLCUKvV6Xh7RGOOXy1FxgYA0
	avVlxK9LznhG2nLDTAdoRhjT9/uQ5rWcH8BTknfCsGFrc/jP5qHPfaoXJDu+SrBeXeQACsQFP3/
	VlVp4xANMqxVIr5eqoEnV3w3ThBJwuIeRTo5lzd1EXUt0ps22eGeAnSSmghlx40aUiSBbw4PJGC
	AH0bCSpIiI8E7Eu1z7cw==
X-Google-Smtp-Source: AGHT+IFQwZ8JqUgzAhI97yEdL+gAVwRf+HPm2jxhPz+VXVx31xofYms+tNraAMtA1CL3y+eUpP+gmA==
X-Received: by 2002:a05:690c:c85:b0:784:aec5:7042 with SMTP id 00721157ae682-790b567cc26mr18001097b3.38.1767768321214;
        Tue, 06 Jan 2026 22:45:21 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790b1be88dcsm9635047b3.47.2026.01.06.22.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:45:20 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v7 07/11] bpf,x86: add fsession support for x86_64
Date: Wed,  7 Jan 2026 14:43:48 +0800
Message-ID: <20260107064352.291069-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107064352.291069-1-dongml2@chinatelecom.cn>
References: <20260107064352.291069-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF_TRACE_FSESSION supporting to x86_64, including:

1. clear the return value in the stack before fentry to make the fentry
   of the fsession can only get 0 with bpf_get_func_ret().

2. clear all the session cookies' value in the stack.

2. store the index of the cookie to ctx[-1] before the calling to fsession

3. store the "is_return" flag to ctx[-1] before the calling to fexit of
   the fsession.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v5:
- add the variable "func_meta"
- define cookie_off in a new line

v4:
- some adjustment to the 1st patch, such as we get the fsession prog from
  fentry and fexit hlist
- remove the supporting of skipping fexit with fentry return non-zero

v2:
- add session cookie support
- add the session stuff after return value, instead of before nr_args
---
 arch/x86/net/bpf_jit_comp.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a87304161d45..32c13175bc65 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3094,12 +3094,17 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 		      struct bpf_tramp_links *tl, int stack_size,
 		      int run_ctx_off, bool save_ret,
-		      void *image, void *rw_image)
+		      void *image, void *rw_image, u64 func_meta)
 {
 	int i;
 	u8 *prog = *pprog;
 
 	for (i = 0; i < tl->nr_links; i++) {
+		if (tl->links[i]->link.prog->call_session_cookie) {
+			/* 'stack_size + 8' is the offset of func_md in stack */
+			emit_st_r0_imm64(&prog, func_meta, stack_size + 8);
+			func_meta -= (1 << BPF_TRAMP_M_COOKIE);
+		}
 		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
 				    run_ctx_off, save_ret, image, rw_image))
 			return -EINVAL;
@@ -3222,7 +3227,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	void *orig_call = func_addr;
+	int cookie_off, cookie_cnt;
 	u8 **branches = NULL;
+	u64 func_meta;
 	u8 *prog;
 	bool save_ret;
 
@@ -3290,6 +3297,11 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	ip_off = stack_size;
 
+	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
+	/* room for session cookies */
+	stack_size += cookie_cnt * 8;
+	cookie_off = stack_size;
+
 	stack_size += 8;
 	rbx_off = stack_size;
 
@@ -3383,9 +3395,19 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 	}
 
+	if (bpf_fsession_cnt(tlinks)) {
+		/* clear all the session cookies' value */
+		for (int i = 0; i < cookie_cnt; i++)
+			emit_st_r0_imm64(&prog, 0, cookie_off - 8 * i);
+		/* clear the return value to make sure fentry always get 0 */
+		emit_st_r0_imm64(&prog, 0, 8);
+	}
+	func_meta = nr_regs + (((cookie_off - regs_off) / 8) << BPF_TRAMP_M_COOKIE);
+
 	if (fentry->nr_links) {
 		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
-			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image))
+			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image,
+			       func_meta))
 			return -EINVAL;
 	}
 
@@ -3445,9 +3467,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 	}
 
+	/* set the "is_return" flag for fsession */
+	func_meta += (1 << BPF_TRAMP_M_IS_RETURN);
+	if (bpf_fsession_cnt(tlinks))
+		emit_st_r0_imm64(&prog, func_meta, nregs_off);
+
 	if (fexit->nr_links) {
 		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off,
-			       false, image, rw_image)) {
+			       false, image, rw_image, func_meta)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
-- 
2.52.0


