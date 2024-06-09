Return-Path: <bpf+bounces-31674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9FF9014D8
	for <lists+bpf@lfdr.de>; Sun,  9 Jun 2024 09:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9039D1F219B2
	for <lists+bpf@lfdr.de>; Sun,  9 Jun 2024 07:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7E418EB0;
	Sun,  9 Jun 2024 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck/p3j2m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936FFEAE7
	for <bpf@vger.kernel.org>; Sun,  9 Jun 2024 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717918286; cv=none; b=ROkTIToOic1TzQrlDPKnsHw4EOy3whSeT5+5pxphCLy8LuhwhpJvBGLOevSKRCPP5G55UKMpQ7HFd+jknMA7KeU5teHN31P57jt0axR5gaUMgZVxTdQhF5GaLTWL6HE0lgbWKpNCx9N6i3DUXmMRZkj/645gA8xSmNLs/MrR3ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717918286; c=relaxed/simple;
	bh=sjcAvPA5vp0SzUQ8vmAd4JiCvvT4hZzvJbhzHa4dgdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2M1ultJG9I1nRSvoab7jsd7f1BVfPIRLfp2JZGnkOIIgdGK4oWWv6KA+BZ2UBIt8O/Ucg3i9T5c1fUIqSUV+1D6D8AQvrNx4cXbVeixAe1QuNUJbxeXhrT6LYFLMQf10w5oqd3b6jt2Q0Bo9PDpf/uu7tEtr3RkUBzsGtnltQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck/p3j2m; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6cdf9a16229so2535921a12.3
        for <bpf@vger.kernel.org>; Sun, 09 Jun 2024 00:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717918284; x=1718523084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3zYPYfQ9MEMK8RVWUtQoAFbYEjaPTYgsIbBL2WDda58=;
        b=ck/p3j2mseOhkngQ80c2ugEoI8OfNNPSHQd4JxkD8kcDUmNPiNL9YDbxS2VC3mzisL
         x2H4JbvxDqdXXOF+zFGs75AkZzCYqYoMw86MMZikx3QoBBDfEYvjHDb2pLArnJyke2j2
         1uZXMVAVZ1H8T17LWAIpM6OiL59X693gHP/JvyApi4AtOkjOSOS4NuLDFHaQ7+weNJyk
         0dzSKu9G5yA7IHDc32tysknc7j0FfYHI/AdNpijWNWkU6iFSop1nJE0YWugd8cWNlP1R
         FQ/3pugdmjEx94TuqpblNbiRCuMhY+pscjkGNCgfcIz0/7RAOi0AtvupabCT30dOl/wk
         u9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717918284; x=1718523084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zYPYfQ9MEMK8RVWUtQoAFbYEjaPTYgsIbBL2WDda58=;
        b=oyxB9T7tgM7u5GJ3hE/4gDovCkEEaxNe7FC/Hguu6dj39+E8sGb8wCdqKrMjd7GChO
         OkUiQvtzG8I5QhYLSc3o3s1j0EZDMfz3fNo0nYchfwX1/aQF+UMCpuTC16a/IVsLpyVd
         TQqDfGZ3qS89yV+yvk2M22SZhMnGPC4yOxG4xIn7ffMKJ++fyIg9bGYP6PdnHgawif9b
         m9L2WTq6qnCko/EZeZE305BL6meTCCPvAWkxoqONE50aMgDPsrSPCZFCmYBcXA9ZxJt0
         XzQfR5t2zSOEkjz3Jx3V+mh3s5OBiNs1jg6zLG3Rfsb9yGpVOvZ6x4GRZudVa7l07E/O
         7YaQ==
X-Gm-Message-State: AOJu0Yxu96Uu/HGt3eMPrkaDGAkkYUAa9K9yLsFTHh7gHJY/DasGtEGj
	f0kVjzx62xHa8X/Y2jFB7jgA/Wwt0GyFD+GVieUeMllq05N7Ooh028oExg==
X-Google-Smtp-Source: AGHT+IHhwHxP63hHUEzA4DQ43FiX58ayMmbiFCcgj83QpqEs9CpseVr0Vd723j146HNMdtZh4q3kSg==
X-Received: by 2002:a17:902:d2ce:b0:1f7:1006:9d44 with SMTP id d9443c01a7336-1f710069ff1mr2661285ad.41.1717918283699;
        Sun, 09 Jun 2024 00:31:23 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f70eb8e856sm3073175ad.103.2024.06.09.00.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 00:31:23 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next] bpf, verifier: Correct tail_call_reachable for bpf prog
Date: Sun,  9 Jun 2024 15:31:00 +0800
Message-ID: <20240609073100.42925-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's confusing to inspect 'prog->aux->tail_call_reachable' with drgn[0],
when bpf prog has tail call but 'tail_call_reachable' is false.

This patch corrects 'tail_call_reachable' when bpf prog has tail call.

[0] https://github.com/osandov/drgn

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 81a3d2ced78d5..d7045676246a7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2982,8 +2982,10 @@ static int check_subprogs(struct bpf_verifier_env *env)
 
 		if (code == (BPF_JMP | BPF_CALL) &&
 		    insn[i].src_reg == 0 &&
-		    insn[i].imm == BPF_FUNC_tail_call)
+		    insn[i].imm == BPF_FUNC_tail_call) {
 			subprog[cur_subprog].has_tail_call = true;
+			subprog[cur_subprog].tail_call_reachable = true;
+		}
 		if (BPF_CLASS(code) == BPF_LD &&
 		    (BPF_MODE(code) == BPF_ABS || BPF_MODE(code) == BPF_IND))
 			subprog[cur_subprog].has_ld_abs = true;

base-commit: 2c6987105026a4395935a3db665c54eb1bafe782
-- 
2.44.0


