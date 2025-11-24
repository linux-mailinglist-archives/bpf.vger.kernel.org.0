Return-Path: <bpf+bounces-75346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FEAC813DF
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 16:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5293A1878
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B3030C62E;
	Mon, 24 Nov 2025 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVYBLbQ7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C50822333B
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763996927; cv=none; b=eMjInoOkxuujhYH8nS/veuFTQqQpR6+KQBlRt67vxbZjOoZ4GZJfKzC2gepZHM/Ok05TnYouOQPaDYj31oa/QhPDt3Lor3LMka2iwyhDxgFOBiErPfVlZoOdjx9rhxqrQXcKB3UkKdTtUbe2eS5Swyq4NPYrYXgyRYfWSDjljqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763996927; c=relaxed/simple;
	bh=47P4FvVfRAgwJCVCJ9JJv0N5+h0I/7FI5HbhMOYDn14=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tJs/Rv4jhM5+NjuluGXpO+xHpAmPUdtszkdwZYE2qiXH8+fQAL0V28+fxYySf0a2CQUWPKos9ZFAmM4uGyROwZN7L+rfi3/N8zDvsj7aM2kcp13NYoO6zfpuWUsjOs7loVtqv3R5wr7J0ofaDVhfkp6dSJUEWlshwu/6VCpQ0LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVYBLbQ7; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso1796364f8f.0
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 07:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763996923; x=1764601723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HC9HvfnuM5PdJZlGLdSdxe71w0rPDXwxpmySSag+Wb0=;
        b=YVYBLbQ7rg2NHMcU3s3Y4TgF8ZWJrkWiq/yLvqPhCYHjuh3UYalkO+cZYrbe9KQRri
         k+8h++7xERn8gRG+iWzmMFrkANlWRV8kdCP3s1SAYR6FK3AMTrKH1Lam/3ayMJqCXmYy
         c1XKmbLk7F2jUOxcK6oO3z1Es+FIcxJ3MLo/PeiZSwfyTZKcpk6MZjvGIqcnCx+RtLxq
         H38j5D3goxf6dqon06+wm1SPmP5IgEFnRC0EBwBIlmcqs5VGBvoPEynHqtE3TZh4DqhB
         ExW08LUJoWXKgdVoQXS/d/WIAlG44l6khMcm9S2zmoToLKZNWpgRDYcQciGfxrYNoK9U
         GJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763996923; x=1764601723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HC9HvfnuM5PdJZlGLdSdxe71w0rPDXwxpmySSag+Wb0=;
        b=SP8kwFbdMG98ypNIfkqgMgBpzDe4LRI7NKfRhuRlV+djO1U7qJbJ1u5cfJJEC+NI9F
         i2fbWw3HJDZIER5eLyVINMkQrXcbenqx19s1ElZC8ZXTpotJPveeLUvqvKW12HWxS0/N
         IIaonkbDvmwdEmn7miaDphIQszSnrARsg+ds8cYNMq1hlq7F7Hi5FhpNxNJqgubsN4Lk
         bshE+oGIv/oGVGNy4KkxstEOmsVSEMw6FODn0GgKi2W2L3zEKRJEJE0f7bq2e6HC2Goc
         cIVx9iCzu1PiClgfb+bQVeenF8KNfiSRipiVOZ6215x+wV6NBIjwtc84jZ25o2b3ZvvA
         E5BA==
X-Gm-Message-State: AOJu0YyI2qfJSxEEv1FzpOl/zbFxbl3CKOp1XaowS2fhfBQ53WsifBNP
	UZHvZX9aJaqlGFumVDb5WaZ/QeRhYN78zf8Db495wW6E32QHOt7hbBgQbEfsSQ==
X-Gm-Gg: ASbGncuQnfREjgfM0hyXkFOUcjWbAeRfe++XxAWPDs1DGE4vhkD9Z6WaAr7TqY6to5M
	CSRL6il9gqOLXicRwIPgAs6BKqpOhKySVP/Pf6gbJmEB9F/xLRKSsNdZ+0kJPY3cnC2yNy6/Ofr
	yOcJTx+pERTxvSW3LODw+e+wEFwLJqwE7sXwnDX1UTwygoQ/8lFt8o1R7HsB8zEsMAyayP5iFK3
	VTuhqBzftK5kv08eENcub68CuFmkpST/EECkeL9/ZqC86DyBe1CEcBUSIlkwg/OTdYiFy+7Fncq
	UNlRMLd+H0wc9NfcleyP9bQYov9kq3E0IA1Di6wAWV2VM4qqoVspPCKzVpLfjQBO98496iX4BRE
	Cjlg7H/U+9IsuYdSn0HimyphiBSZfv2O0YtOCokV4e8UN493Y9b5f5XDto493d2uancCvIEPQ2z
	6995tRkLfBeSnys9ko6nOQ7Tlq4uyGceKp0KK9Ir/L
X-Google-Smtp-Source: AGHT+IFM8FtpWA+1EXOKQND62moIGHcRzCybLb1yJ4Na0bi8EJAVJmD+ndL6m7dkNuy1o35zjgfXuw==
X-Received: by 2002:a05:6000:40c7:b0:42b:39ae:d07b with SMTP id ffacd0b85a97d-42cc1d1bf4dmr12816856f8f.50.1763996923087;
        Mon, 24 Nov 2025 07:08:43 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd9061sm29222573f8f.41.2025.11.24.07.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 07:08:42 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next] bpf: cleanup aux->used_maps after jit
Date: Mon, 24 Nov 2025 15:15:15 +0000
Message-Id: <20251124151515.2543403-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit b4ce5923e780 ("bpf, x86: add new map type: instructions array")
env->used_map was copied to func[i]->aux->used_maps before jitting.
Clear these fields out after jitting such that pointer to freed memory
(env->used_maps is freed later) are not kept in a live data structure.

The reason why the copies were initially added is explained in
https://lore.kernel.org/bpf/20251105090410.1250500-1-a.s.protopopov@gmail.com

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Fixes: b4ce5923e780 ("bpf, x86: add new map type: instructions array")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2e170be647bd..766695491bc5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22266,6 +22266,15 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		cond_resched();
 	}
 
+	/*
+	 * Cleanup func[i]->aux fields which aren't required
+	 * or can become invalid in future
+	 */
+	for (i = 0; i < env->subprog_cnt; i++) {
+		func[i]->aux->used_maps = NULL;
+		func[i]->aux->used_map_cnt = 0;
+	}
+
 	/* finally lock prog and jit images for all functions and
 	 * populate kallsysm. Begin at the first subprogram, since
 	 * bpf_prog_load will add the kallsyms for the main program.
-- 
2.34.1


