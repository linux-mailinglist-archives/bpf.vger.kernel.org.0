Return-Path: <bpf+bounces-71317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4BABEEBFD
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 22:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 382834E42B1
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 20:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6256228CB8;
	Sun, 19 Oct 2025 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD8hFbO7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC319D89E
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760904929; cv=none; b=C/LhbewDvtUD7nT64UZHVME7DjB7mWflgzlbLqeT8S7xi364fYTfNObWH0TSX2XBFXwt6lBpuBzyl/Adz7LbVpkXBaOBFYWsKZPPR7A0Z18zcV/YQMYGSDQjRoZsTuIJnY9fI4TMQMylH2Kwc9/mk/k1zvSZO71ZxfAh6q1Sbfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760904929; c=relaxed/simple;
	bh=gqAMNAzS1HW359Hjdmjs3cuO5g/4wApWz8kJT3Vk4/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fRl9yDShoV2dM8gkhQtr3YHlKg07B7weQ09SOQWmy2ufVvC6P7dP9hY4HU6qesn9zF7S2vl7RM5eNokB6pdn/mEw7IiEVCxUA1Vwl+lbLV5ErArxpbTVmTtCMJGFu/Deg6Et3XvwaRT9CqSFdeDFxgHwFZytciOu5eb3MZAWCFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OD8hFbO7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4711f156326so22600195e9.1
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 13:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760904925; x=1761509725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLqHwpNaMwBq9k6ESRubgRsFVAzQRrCYHh/je2m8hV4=;
        b=OD8hFbO7RWT6Tquj9WeeWj0BpPLsIPaC50Goi2PuCnPgSzhITlJeREAjfh48iyMW0I
         SzsDZcXco+og9pi6QEgqi3D0TtgdtCaqXdOOKRrW1k92qwus7wchrLVTIo9Vods42slI
         LRp8a9TOYIPGUqslnJpH14eR9nPC7C6Oh3RpE/bDqOhmKNX9EvoC5rGcmnQLXQLIXTRY
         z0zzN6KOcV71Ow0UEY6xIM9xPdwhethYuJS13Ws9LCSiJ6qxFE1VuH5vfYuHZpigtfAu
         P36ELm7Y+kLq+Gqy0jYTxHmwbwEw+yKGEgXp5qa1yd+0I/FxTRLzcKkIUdd/wnSJ+u/w
         jrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760904925; x=1761509725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLqHwpNaMwBq9k6ESRubgRsFVAzQRrCYHh/je2m8hV4=;
        b=eOTBqheCadVBA6ripzJPqtf9GaG9iu2LPWYJi1XyAbISdfPvROVbG49sdzecTEz6E2
         pTtsCnPUNdBzeC9sHA17AM1y1i0n4fs4ZtDtZiGTefTagfCMM1tRDKUE12rKTFyodhEb
         rk5dke/JA+3YYnZgpol2giUIKLYWXR6BIveHmVFJXoS0g0b2HVKVynBKlWcQl0vg/hvr
         wXK2qumWsk9VjGOrP442e4eBTrII/qM/IFBMCm96EEBtP7UoJOGY8VQJF7Stl0f2d0VV
         2JQ0sP7qWtjpyHD5WVh0OjVG0voZUbioDoWTROsDLfZguc9tqAUZybuRJer5pWxcWpHv
         yRMg==
X-Gm-Message-State: AOJu0YyYJ5A7M5xP9GK7N+xRp2Dlb+9gQkOU5MlX5AiGzu+l4WZthOBh
	egyfJI07PlJHph2/rv427jLS+sWk14hjPP1Y9NUH9PVpq3RnkFI/3HAsb+pdcg==
X-Gm-Gg: ASbGncsSOpcxfYtrbSKsrKOwQMt3vSLL4L6FYoN46S1e7ZHrgWFHo3GpVefvP2QobFt
	gybfvhWYylUnf9YS5ApzCEXEZjdkWHRl/iqviy/Mjm0eFT76eyvU2nPQESimu7BVEBF48Nz4eZ/
	Re3F3bvESLke7j0lexKHsH8WZFqmNEuNauEZQZ3EMLHdfbMwVlPU98OsFQ9YoqgbZSLWTZbxwdE
	8pUPfnF2ibzx9WsFBnetbmlI6ruzF2tn0I/zcKGmMHsujn5hgxdhfflk/r7BJTKPkGrQzsJjZkQ
	zulmEEsP1VL1nq2FL6e+/tCDGtuKyaJQBB4h1qRjIU3AXG6U8ovVw6BAZgFsQuCXuboG+pWyMaS
	bN3dtSJm17A4/wVoP3c0W9OlBAt2l1z2vREv1DH9SrPM61i0hFlJP9DwRNFOuWc3TCS5cbIIOSI
	vDQoa7QiR5pnkBL83fSOksUzpr8RzM8Q==
X-Google-Smtp-Source: AGHT+IHfD0ZI1my+k+IRt8m3F4pjIDoVR/q4xiCV/Tn/uNKz4xCiTkvilaanw3QAlcgk0Areme42yw==
X-Received: by 2002:a05:600c:871a:b0:46d:996b:826f with SMTP id 5b1f17b1804b1-47117917257mr81236585e9.25.1760904925394;
        Sun, 19 Oct 2025 13:15:25 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c831asm190460105e9.13.2025.10.19.13.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 13:15:24 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 02/17] bpf: save the start of functions in bpf_prog_aux
Date: Sun, 19 Oct 2025 20:21:30 +0000
Message-Id: <20251019202145.3944697-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/verifier.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 204f9c759a41..3bda915cd7a8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1623,6 +1623,7 @@ struct bpf_prog_aux {
 	u32 ctx_arg_info_size;
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
+	u32 subprog_start;
 	struct btf *attach_btf;
 	struct bpf_ctx_arg_aux *ctx_arg_info;
 	void __percpu *priv_stack_ptr;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 80c99ef4cac5..4579082068ca 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21607,6 +21607,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->func_idx = i;
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf = prog->aux->btf;
+		func[i]->aux->subprog_start = subprog_start;
 		func[i]->aux->func_info = prog->aux->func_info;
 		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
 		func[i]->aux->poke_tab = prog->aux->poke_tab;
-- 
2.34.1


