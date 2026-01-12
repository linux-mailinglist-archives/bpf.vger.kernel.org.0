Return-Path: <bpf+bounces-78533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B5AD11FE4
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 11:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 446CC308790F
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 10:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070EA320A04;
	Mon, 12 Jan 2026 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayD2FLn/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC5D29D29A
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214747; cv=none; b=HzDp/P9IaYRJbdiwblBQHDgM5XYeuiD35rZvplfG9uY6F//T9ZzL2MtUuHFRCOd9D+3UcbrFjTArxs0xq/Fs0LAZbGkZF7BBn2dIDwg17xBzCOC5dv1eOvBkH03q3TuWhd7GIwQGFZcOdQm992FQkj9RzoUCNEaj0dhy8YOB9Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214747; c=relaxed/simple;
	bh=fHGYT2wKIjsZzvpzHiDp2/v0DzQ4msIuSE/Oy76VwKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnoWsYZNH5yE4+7FSk5nqUo02WO0oLL3V2NMQVNLZ+eiEU+BdG8zyKrItopYPmFiaIxH/A5AR+Rs9gR4bn3TG1YU/Et7wHLcsch8soy+OXAbp53SuPb1KUSaz6V9fmq7GkvPiX1tKxxjN6upay5FdIB0ffSGcOaIFote022u2uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayD2FLn/; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a081c163b0so41363525ad.0
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 02:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768214745; x=1768819545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OtfIkJz+WopDcxIb9oG5mLIsx9842RNgnwqX2RofzM=;
        b=ayD2FLn/jzx19QbOI3MjGwLDZAq7zC3mW94Ibe5FC3PDRi5Qvc2o1FKvFHax/f0UTC
         wjsTPVRhmW7sfDYTyTGgNTmCZ6qfVEGyLMc42wIYTG7lFZ1BdYalkis+X9mZaGn7I+41
         +jnm/SE9emPDz2oYqenLrXgHbId+swjV1ZfaMTcNG3HeASYPc+39GFspjAj8pWP5La3B
         3WObxC/bGYspC/QTUdh0Sdoy2k+NhV/IuPbKxpmAVBBNToH11q+WutGyGuLBmTl2AIXC
         O6eAv02baE+PtuYRxiPE2HczebU9+xMkqKum/LZyvNKnC+m18efnFC7d4GoS/4kdzUj1
         xaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768214745; x=1768819545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+OtfIkJz+WopDcxIb9oG5mLIsx9842RNgnwqX2RofzM=;
        b=n43sez8dGqy0Z35x5cUFxmubitLhE6yHeM4DWwO938TNIxjldHxzot8OAiYM85tew7
         Pu8rECuHicFPkFOzkdEpDFebmj0H0oH2mUz1Nkpq3yru5wjleZOnMzkf8aOvn6cqiTSf
         xe4fmILz3Sjj9xYI2bGpsSRaSwIK2mxohF3OOOt8/t591Gbki5ggb7BKMGjI2i8b3H2H
         aSZ6docZLhFkuGjfcuf2LdONzDpOLVGvWN4yo2bMtzW+zf53SCoj948LaiNyAZ2uDDPa
         d8HgSPDnQSob9T7lLLnjrkFgzApY5KaGiXM9WPvLIhwXmFeutt2WutVLg15XsXdXI+T+
         uFZA==
X-Forwarded-Encrypted: i=1; AJvYcCUAuZszDTOxSs11n8t8BCttEpumZUPId58kUhVEBPY1bBOsq19NRfXEBB1lvWIHeTtC3jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzK05I8oH4JaiV+nqN3wLhXAaVf3pIKV16uwcsfy+aseP68xDP
	RAwkSKN3EGtgFWiyRSvaGIM1MlEyg4S7Z55d7WIZR27qzHpFe7bW+t1P
X-Gm-Gg: AY/fxX4+tLGB+zFxL4g2/ZZG+AsnF7oipMecl1TtPEH6jlsCADKgmoiUV2TYwzms4XW
	1qPdDphKlH+adTJMT+zs5V7u8SiwhmKzqVMTp5VJEYsq8rydeIn7JY9LaI8+go36wI0x0x8LGMW
	SpSZRc9IOyB7EBebdS2rNCf0ZqLQHafNPA8aDPku18Lb+bRMNSLIoLwyldn0YxN5D7DxT6/4w4v
	kTbWaJcMg8WuVsR/xgYeQsIpxjSH+mJGFhq8z4HLotbOAP7AvcGCzPVa4OeV9ZCf6jTlx8ydyH6
	m3GLo2jYeogBBSndEkFU9R++nyaLeWkvAj5x+pFCt+NfbUcvR8jjU6CD0sJ/NpLJltAyTvTcm1A
	NIZLzk9xn/9R80uN5yXMQSKIQ0xZdCmaHGRSD2mgf8FRj9Gj1s5692aH5GgYOd6cazwUd2KTsbm
	pngOcqpbg=
X-Google-Smtp-Source: AGHT+IFHYPz6czyuK+LvhbdH8QCXTjjrCywR7dF8EBPHJM5pOUuVPi0LV1ijswiqYj1oDCPUz3rFGg==
X-Received: by 2002:a17:902:ce91:b0:297:d4c4:4d99 with SMTP id d9443c01a7336-2a3ee40e4b1mr165119795ad.6.1768214744938;
        Mon, 12 Jan 2026 02:45:44 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2df6sm173551775ad.61.2026.01.12.02.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 02:45:44 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	eddyz87@gmail.com
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 1/2] bpf, x86: inline bpf_get_current_task() for x86_64
Date: Mon, 12 Jan 2026 18:45:28 +0800
Message-ID: <20260112104529.224645-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112104529.224645-1-dongml2@chinatelecom.cn>
References: <20260112104529.224645-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
to obtain better performance.

In !CONFIG_SMP case, the percpu variable is just a normal variable, and
we can read the current_task directly.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v4:
- handle the !CONFIG_SMP case

v3:
- implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of in
  x86_64 JIT.
---
 kernel/bpf/verifier.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3d44c5d06623..12e99171afd8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17688,6 +17688,8 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 	switch (imm) {
 #ifdef CONFIG_X86_64
 	case BPF_FUNC_get_smp_processor_id:
+	case BPF_FUNC_get_current_task_btf:
+	case BPF_FUNC_get_current_task:
 		return env->prog->jit_requested && bpf_jit_supports_percpu_insn();
 #endif
 	default:
@@ -23273,6 +23275,33 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			insn      = new_prog->insnsi + i + delta;
 			goto next_insn;
 		}
+
+		/* Implement bpf_get_current_task() and bpf_get_current_task_btf() inline. */
+		if ((insn->imm == BPF_FUNC_get_current_task || insn->imm == BPF_FUNC_get_current_task_btf) &&
+		    verifier_inlines_helper_call(env, insn->imm)) {
+#ifdef CONFIG_SMP
+			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&current_task);
+			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
+			insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
+#else
+			struct bpf_insn ld_current_addr[2] = {
+				BPF_LD_IMM64(BPF_REG_0, (unsigned long)&current_task)
+			};
+			insn_buf[0] = ld_current_addr[0];
+			insn_buf[1] = ld_current_addr[1];
+			insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
+#endif
+			cnt = 3;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
 #endif
 		/* Implement bpf_get_func_arg inline. */
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
-- 
2.52.0


