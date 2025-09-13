Return-Path: <bpf+bounces-68295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D94B562C3
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 21:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10BB57A3193
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 19:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FB125486D;
	Sat, 13 Sep 2025 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiSwkhbo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424AD211C
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757792023; cv=none; b=k0SfeXxpNPaeHOj3NSYXVMzStjQ9rW2bHX425fQXpYuh7VFy2LTaGsAC2RcBMN4RMgyjvea2OfSC7e0Fg3+BeaDLJ1tlK58ssfC3t0gD9Zb7Vfj4Nn0NBOwXi3RHg5+kKUyrWS/IYDL6TJghdec0iW+id9IrCjxpovnqsPKerkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757792023; c=relaxed/simple;
	bh=lUUKgwe+de9IoCvhnirb7HtXkCI4fr+3aPegyXXDEWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PO5iuCL3aPCqEKvKnV5EDoySG1SoiQz2MsrnDYisG3Kk1BXKtQCVRVcXltlTtH0fgzNQ6n2zRpmSIyF1ZFaBZAZSUdIQRe1jerQfqFlgNg05tl1vSPhXGNEzl6L0lHhI8wdDhQYeniMRd6s55SM+T9DMAjXAbrNwGW/RL4MO4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiSwkhbo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso29212495e9.3
        for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 12:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757792020; x=1758396820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ofmijWASze65WoXsymSSKhZnB+iZf4hOg616aQywdg=;
        b=IiSwkhboFJFTmUY9XipWOTU9Ip5x4/w+n4uJIKXqJ+MzwDfxMkMb/orRGWtuhT1hs4
         bzpEqjfhIaUdC5iqndaf7gGHdnyqyGYUKMI6BVtl19UqyuRFP47EetBdAIusumjyQldm
         XMCgLYSC/0XyX7TsdEgXynC4l4ez7eRwGC2iMGQ00GiQYibcYE6NXEzsgBs9XiMtKWmK
         RooO0KwIpQ3VtQH7v+L1hONebcASanS9DV7vzs01XPcPzYMxyQ2Y4pQ09hZpd+oo5V7g
         MLh0yF2rKMgtbSthWQdmqO2gqarL2D+hpDGZ4vFreTXB/2hmd3b0ojFhUIsNJgNSUhJb
         yYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757792020; x=1758396820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ofmijWASze65WoXsymSSKhZnB+iZf4hOg616aQywdg=;
        b=Y6TG36PAPzXTTIFNBWJ/IO3PF0ymUqFIp94LtK41WR1VnJ+LeenZom/PiozQBM7Ir1
         460p0xE7KFnbydT5Ms7evqEj+WQq6Cn910zhfQAtm0lPgoRLg4rRxz09i7KYoYdvJSnZ
         qG1gbjuPp6c6aWcJcSpRaStUmx/03Y2JzTPH3Quj+7Emc5odlJ2df02xzNxfn6RlHaky
         LroCnDMPTuUD4q4RW8qBZFvQTlWmivf1LxuXKROZHKDIf3zudB0cUtpRQi4qppuayi+S
         lU0V/5c4EcqYfjbbbDb1rdetqWX3Dn4rQiT2Mz4inTGV3Ex/Rdk9sOSaMv71bth6/PqY
         M72A==
X-Gm-Message-State: AOJu0YxB/9ajkRhqdDrjEE2MD92ge7kKyWVJbfdgIakTfnffMRv0jPtj
	onzllqt9KOrTv95t869zgHbLqkC8dC0VgIFk6AABYQrPZF0KuogbFW6LoAt1bQ==
X-Gm-Gg: ASbGncvXToCEDpvadBgYgXLZjMMhTqQLTHcGT3OufoNwPQPcw4Uvuq9pukqH8HHFg3I
	QE6VVJMG+wwEkSpcHDs2U/qk/E4n2w+Dc8IbgwOwc251tiSSyUx8OVRJN4psLuXLm/OKNAYz0Yk
	sHRkxb0XZxkzPYCEcOjY4382zgaDoWZ+HsG4yuBsxQrREZa6cNU7UL0vTRTYLyGiHF/fSFOfn02
	vvsmLML6+fhUnjJT/KS4XfMkTZsv2fYn5+J30M2M03j3ZzBwJaz4rxpzerIrv8f+8Htzb9ROytU
	uZDyIHlP2dXJLazIervGVxA+Bk2z6BS0USMdHGTNEyKOHl/Sqpvo/5Z6ogQHanVTkQ84UUtjbeS
	6ye//nx8XOIHXxGoiJuSBHapnuJlKz/S7Hz7J8h/zWbfgU7KlK+MA
X-Google-Smtp-Source: AGHT+IH6dkuXjDjS5IaQ1VTXeXEEY5fallTrIGERrjrxewJ4jKMs2zGrAOYFYk+SZ8NCuMEVR88QzQ==
X-Received: by 2002:a05:6000:1ace:b0:3e7:5c44:2cbf with SMTP id ffacd0b85a97d-3e7659c4148mr7368192f8f.15.1757792020146;
        Sat, 13 Sep 2025 12:33:40 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7ff9f77c4sm4948753f8f.27.2025.09.13.12.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 12:33:39 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 02/13] bpf: save the start of functions in bpf_prog_aux
Date: Sat, 13 Sep 2025 19:39:11 +0000
Message-Id: <20250913193922.1910480-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
References: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new subprog_start field in bpf_prog_aux. This field may
be used by JIT compilers wanting to know the real absolute xlated
offset of the function being jitted. The func_info[func_id] may have
served this purpose, but func_info may be NULL, so JIT compilers
can't rely on it.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/verifier.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 41f776071ff5..1056fd0d54d3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1601,6 +1601,7 @@ struct bpf_prog_aux {
 	u32 ctx_arg_info_size;
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
+	u32 subprog_start;
 	struct btf *attach_btf;
 	struct bpf_ctx_arg_aux *ctx_arg_info;
 	void __percpu *priv_stack_ptr;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5b4d28048b19..14c0c6fe9416 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21597,6 +21597,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->func_idx = i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
+		func[i]->aux->subprog_start = subprog_start;
 		func[i]->aux->func_info = prog->aux->func_info;
 		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
-- 
2.34.1


