Return-Path: <bpf+bounces-73261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FABC296AA
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 21:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD7E3AF39E
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 20:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302D0242D86;
	Sun,  2 Nov 2025 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1oExh+U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0F923AE87
	for <bpf@vger.kernel.org>; Sun,  2 Nov 2025 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762116719; cv=none; b=CQALFTkg4b9HDMqlxURN5vdryiuhumiZbUe+sXP77oe21Lrxaar5IcfspKjel0UiDOUo8yBDLsfN5+IE98wsitq2Nj1L5Mo7Z8z1wMfgBTTqqXXkBhALVRIiUVjvACUowBFkzMd4e1WEQLm0F/KCjCV9DZXGFgC03GWon1xOiyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762116719; c=relaxed/simple;
	bh=r/zO0xVYZl17IQrjoREO/eXyaHGPfl38DxWwAceYxFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bpMDYek+qxREIgcLVb1c9a71bwvcgfdD1JqfoW1j0g7ltkTbuabR2v8rSWgP9fOa9gCC6mLVs5yG4/9CLrn+ic3T2JONz87G7W41/NBCIuvmE6/TnhPxpw2++2O9eYhgnTSh0ClTeEifuWMXfGs9NyM7S9g0CbWlInxgd/Ay7RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1oExh+U; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6408f034513so3107831a12.0
        for <bpf@vger.kernel.org>; Sun, 02 Nov 2025 12:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762116716; x=1762721516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRJmLQcgvdkl4a8jsXEPMADo/+2a91riwUAx70XcEpA=;
        b=d1oExh+Ugipo6izSnA15sYpcT5MWXdAmLmZX8f8YmwPuRSYXLR4Kzl6inFYYyFi+6I
         9pL3h67cfQWCZy4Cf7jVNs8a56FkQuPCBpQen1L7wdytYOgvnmaBYGldraW7FPrTFRn2
         kDSqfsQlv2nvjAUndCYun3fJYs3JZUtbnN8gmLCBvpkRJ4XZJaJdog6eIGNDi4ZQ5m5A
         qfybm9rhS8tmrGTozxcHNpHUUq+zvsBk8ijDjMmJdF0V5GAtbX4UPnCVXjA4d4uZSyM3
         NEH/yl0lfBlixP2dPuuJ7kuyWglVErGmfV0ve+CuGrg0ET9sNIGKJVzY7/h5U4Blnua+
         MyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762116716; x=1762721516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRJmLQcgvdkl4a8jsXEPMADo/+2a91riwUAx70XcEpA=;
        b=OyrDw/04ffsSF3LGpGIcZKH27dckiTcpO4LLZMrWHXC4w3FyJOfZIQ03ICNgN5wfAC
         ReRSBsPWdaTBIX+l7InZ0arObEatvRixuD61xOpJ7qSCSk/XSQmomO04gDGPlklhxjaF
         HhADpiZZRNR6H6MYLs8vLUo0lY10HZ0tYc9tezhWRXevINz1m0E+DJj1DIP3apjNg/ne
         5DdNBzRcSczrMD19qTpj/jxGC4YdvLVbvkW6saaQqPpxV4EwA4XsC8W408b8cp5lojYy
         N462kW4Ap08pqQCmGdV87AZrFPZ+OOE3kI/bUHjWIYOJxjYum2SVQpBkZteI5xSN31f4
         /aTg==
X-Gm-Message-State: AOJu0YwjCUBQ0yK0aTBdLpYXlXZjDoGUocxxhhtD8UGTKe1PdTDndPNc
	4zr2WOWNeyIBTxwmooEmW5N5FJw7GoUUAJBJ+weQxgW8X4KDYV9JSOPi5J9p9Q==
X-Gm-Gg: ASbGncuvVerGGum8xbJ4Ci128+eTjcPSYFVT6lKh4+q2IvX1lpl4EdEdZ3rL9jooZiP
	bs6/z7uvI0bWRN19XMdYqwe9ywpx78OuSrFPcNIYJFezGN9o9C0He+5E8aoi+OI/mTSCmzlljMf
	oXXfsI/UGyauNqVG9UQD/z7M6PUph13EuxyQsR/yJGbKi51YpGfgMaTDcglf8h7RabuB8dwHV2d
	Pd3em4tPWz9IcxcMA8fEFiMOER4em+G0SxbwnXYhUhPJClKUSIUySSc3N6nSweaMqCR4ziDMS24
	4gGdolePA9umYL+kfVqK2qCpD/QnEJWm7hsYCP4UJbFfGhMhDYj+5NA31XQUVlEUwpQqiPP+3lR
	ULjyg+MYL3xnpufJI0ZMuSgkCEGy+C9Nj1tPZjCCUIaoy6cWyL2l1A0wF6ct79V8/iKp3g+j8la
	Dal045bI7XaoSU1oMtKRo=
X-Google-Smtp-Source: AGHT+IESPCVM/rmPEAViVk37IYkl2hqZYy6KlwzDzIIO6ZTW1/c1yOygdFjtoNO07DXiJNR4iKBjBw==
X-Received: by 2002:a17:906:3684:b0:b70:ac7a:2a8b with SMTP id a640c23a62f3a-b70ac7a6b2cmr245989066b.19.1762116715519;
        Sun, 02 Nov 2025 12:51:55 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b71240c245bsm14029566b.10.2025.11.02.12.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 12:51:54 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v10 bpf-next 05/11] bpf, x86: allow indirect jumps to r8...r15
Date: Sun,  2 Nov 2025 20:57:16 +0000
Message-Id: <20251102205722.3266908-6-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
References: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the emit_indirect_jump() function only accepts one of the
RAX, RCX, ..., RBP registers as the destination. Make it to accept
R8, R9, ..., R15 as well, and make callers to pass BPF registers, not
native registers. This is required to enable indirect jumps support
in eBPF.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6e3574033473..e7123f0f2e66 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -660,24 +660,38 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 
 #define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
 
-static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
+static void __emit_indirect_jump(u8 **pprog, int reg, bool ereg)
 {
 	u8 *prog = *pprog;
 
+	if (ereg)
+		EMIT1(0x41);
+
+	EMIT2(0xFF, 0xE0 + reg);
+
+	*pprog = prog;
+}
+
+static void emit_indirect_jump(u8 **pprog, int bpf_reg, u8 *ip)
+{
+	u8 *prog = *pprog;
+	int reg = reg2hex[bpf_reg];
+	bool ereg = is_ereg(bpf_reg);
+
 	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
 		OPTIMIZER_HIDE_VAR(reg);
-		emit_jump(&prog, its_static_thunk(reg), ip);
+		emit_jump(&prog, its_static_thunk(reg + 8*ereg), ip);
 	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
 		EMIT_LFENCE();
-		EMIT2(0xFF, 0xE0 + reg);
+		__emit_indirect_jump(&prog, reg, ereg);
 	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
 		OPTIMIZER_HIDE_VAR(reg);
 		if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
-			emit_jump(&prog, &__x86_indirect_jump_thunk_array[reg], ip);
+			emit_jump(&prog, &__x86_indirect_jump_thunk_array[reg + 8*ereg], ip);
 		else
-			emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
+			emit_jump(&prog, &__x86_indirect_thunk_array[reg + 8*ereg], ip);
 	} else {
-		EMIT2(0xFF, 0xE0 + reg);	/* jmp *%\reg */
+		__emit_indirect_jump(&prog, reg, ereg);
 		if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) || IS_ENABLED(CONFIG_MITIGATION_SLS))
 			EMIT1(0xCC);		/* int3 */
 	}
@@ -797,7 +811,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	 * rdi == ctx (1st arg)
 	 * rcx == prog->bpf_func + X86_TAIL_CALL_OFFSET
 	 */
-	emit_indirect_jump(&prog, 1 /* rcx */, ip + (prog - start));
+	emit_indirect_jump(&prog, BPF_REG_4 /* R4 -> rcx */, ip + (prog - start));
 
 	/* out: */
 	ctx->tail_call_indirect_label = prog - start;
@@ -3543,7 +3557,7 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image,
 		if (err)
 			return err;
 
-		emit_indirect_jump(&prog, 2 /* rdx */, image + (prog - buf));
+		emit_indirect_jump(&prog, BPF_REG_3 /* R3 -> rdx */, image + (prog - buf));
 
 		*pprog = prog;
 		return 0;
-- 
2.34.1


