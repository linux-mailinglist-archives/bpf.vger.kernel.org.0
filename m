Return-Path: <bpf+bounces-36958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A49194FA61
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 01:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CE3BB21C3F
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 23:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FFC19A29C;
	Mon, 12 Aug 2024 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3DPCUe/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E459D195808
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 23:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723506252; cv=none; b=gQuqZxuwiWCoyYmcikQ1oTZUtWV2P5czi9Z9VBo0HbK/UKiFsksvxAngCN/X3YxvV2Os/51y0WdrQr9HT88pEveMP3P1PNCR0UvxZSZgI7RWAqGzxEBSoDxYlvTJOrbTp6vq3SykwFlCwtoVxO2ijS9BqkLF8zSYUe58NQLPUXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723506252; c=relaxed/simple;
	bh=GtB4rpVJBdQ424pizksFvRBEVmZqF9dYzVTmD6OmCBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJQOx6hjrgTlzxr3+G4m47BR400AsKFni3vHzmHdl5kVm7BA0RcwyPTx4H2UZkP7UwZtkT7yaS9hnz7vYvcHKDwtZEDhBV3kewEb4erPVlr2gOIhCJF4+f4/faGfpDnmQUbEzg++ANwbFzT4uo9yWiZqemnXEE7UCo86nCQRqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3DPCUe/; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7163489149eso3428391a12.1
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 16:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723506250; x=1724111050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Itp3RsMLtUdvaq48vqjDQ/Io7MrJKLVG+WNvVh0GTdE=;
        b=S3DPCUe/rIy0MQYcIM20Hwz5RvUMnGrUYuuRxn56BsaDvYthoTpoGnMoGd3KPIrLG/
         ktZMgCiROvqXZ/lDrqptII91IBa4gR/RqIpVwIcJo3uzoOs+XSaCAuKbaSBSfAx3b8Vs
         kgnv5eRce2TEaCwkXSXQZmSusrmJTFgzYulMvpZS30v1TqNEmkPdwVvstORohRtX73VY
         JDHUmRU3VrSKUuZBpb8bShaRbqT9n/XbvHWUkT6BAMEPlw6xEGx5ijNhE7c9s5pOL+Ik
         zPGkaEupsdmjSwOrKqVc7iCn3SSKPq0k4BkGrSxQQ4wj7gvvn8FsmOhYxXwmID8mH7Pb
         w2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723506250; x=1724111050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Itp3RsMLtUdvaq48vqjDQ/Io7MrJKLVG+WNvVh0GTdE=;
        b=q61c63ZqgmtyBHsMojRhJEuI5btwH48LvP2t83OQ9HiUtpM+NIbGlEtccDGyuMutQd
         IRCXILIMV5KjzckP7wdilVvDHApDF9L4Lkl78x86bRYG82mC1TBbrGtj0VYbSEfxoRhE
         PQiM/AFV4FdLs9uxNyP1GZ9NnZJZ4bop8VxtMFzGhF8MTLtx8K7FFXRNnXhvNbYCKpLr
         hWBCzvBVFGlWmuAloerWVzJxaLb2xVqWBMKC2x83kH5qbxgklnWZfIrK9azDxW01e1yW
         DdqC9Mti/KNT98As3xMApVR0jDVyntoy8d6MvbW3LOSQYOT80y4oow7PkgfNQ9+URhc5
         hqWw==
X-Gm-Message-State: AOJu0YzCWgCTbNozUAAZAvdd2ytIIIWoDcRhIhForL7zu+Xo+KGgReGh
	TsVZiTYdylwbibZxShFdbA66cQ7FLYL78ecLWtNCv3iHAZsCXv9HOXBF/8sAMcg=
X-Google-Smtp-Source: AGHT+IEmjvij6GlVeuvGjZ/h1gmYY5hJzZsBVKMjoVj+xWSzBgYyHmR59/ZhyFRSAP52Guz6xEZI9w==
X-Received: by 2002:a17:90a:e409:b0:2c7:c6c4:1693 with SMTP id 98e67ed59e1d1-2d39254823cmr2101653a91.21.1723506249830;
        Mon, 12 Aug 2024 16:44:09 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fcfe3c1asm5688538a91.39.2024.08.12.16.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 16:44:09 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/3] bpf: support nocsr patterns for calls to kfuncs
Date: Mon, 12 Aug 2024 16:43:54 -0700
Message-ID: <20240812234356.2089263-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812234356.2089263-1-eddyz87@gmail.com>
References: <20240812234356.2089263-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recognize nocsr patterns around kfunc calls.
For example, suppose bpf_cast_to_kern_ctx() follows nocsr contract
(which it does, it is rewritten by verifier as "r0 = r1" insn),
in such a case, rewrite BPF program below:

  r2 = 1;
  *(u64 *)(r10 - 32) = r2;
  call %[bpf_cast_to_kern_ctx];
  r2 = *(u64 *)(r10 - 32);
  r0 = r2;

Removing the spill/fill pair:

  r2 = 1;
  call %[bpf_cast_to_kern_ctx];
  r0 = r2;

Add a KF_NOCSR flag to mark kfuncs that follow nocsr contract.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/btf.h   |  1 +
 kernel/bpf/verifier.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index cffb43133c68..59ca37300423 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -75,6 +75,7 @@
 #define KF_ITER_NEXT    (1 << 9) /* kfunc implements BPF iter next method */
 #define KF_ITER_DESTROY (1 << 10) /* kfunc implements BPF iter destructor */
 #define KF_RCU_PROTECTED (1 << 11) /* kfunc should be protected by rcu cs when they are invoked */
+#define KF_NOCSR        (1 << 12) /* kfunc follows nocsr calling contract */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index df3be12096cf..c579f74be3f9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16140,6 +16140,28 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 	}
 }
 
+/* Same as helper_nocsr_clobber_mask() but for kfuncs, see comment above */
+static u32 kfunc_nocsr_clobber_mask(struct bpf_kfunc_call_arg_meta *meta)
+{
+	const struct btf_param *params;
+	u32 vlen, i, mask;
+
+	params = btf_params(meta->func_proto);
+	vlen = btf_type_vlen(meta->func_proto);
+	mask = 0;
+	if (!btf_type_is_void(btf_type_by_id(meta->btf, meta->func_proto->type)))
+		mask |= BIT(BPF_REG_0);
+	for (i = 0; i < vlen; ++i)
+		mask |= BIT(BPF_REG_1 + i);
+	return mask;
+}
+
+/* Same as verifier_inlines_helper_call() but for kfuncs, see comment above */
+static bool verifier_inlines_kfunc_call(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return false;
+}
+
 /* GCC and LLVM define a no_caller_saved_registers function attribute.
  * This attribute means that function scratches only some of
  * the caller saved registers defined by ABI.
@@ -16238,6 +16260,20 @@ static void mark_nocsr_pattern_for_call(struct bpf_verifier_env *env,
 				  bpf_jit_inlines_helper_call(call->imm));
 	}
 
+	if (bpf_pseudo_kfunc_call(call)) {
+		struct bpf_kfunc_call_arg_meta meta;
+		int err;
+
+		err = fetch_kfunc_meta(env, call, &meta, NULL);
+		if (err < 0)
+			/* error would be reported later */
+			return;
+
+		clobbered_regs_mask = kfunc_nocsr_clobber_mask(&meta);
+		can_be_inlined = (meta.kfunc_flags & KF_NOCSR) &&
+				 verifier_inlines_kfunc_call(&meta);
+	}
+
 	if (clobbered_regs_mask == ALL_CALLER_SAVED_REGS)
 		return;
 
-- 
2.45.2


