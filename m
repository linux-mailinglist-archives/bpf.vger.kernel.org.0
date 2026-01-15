Return-Path: <bpf+bounces-79065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D94FD25486
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 16:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D96230A28D9
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321C13B8BC3;
	Thu, 15 Jan 2026 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTVxOFoP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944EE3612F2
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490458; cv=none; b=kcsHkQSzMQPCBz2FgIOLFL4JPchAwbRNOwoZRTZ2hXHsOjvUAd4kqB3MYaFZFDo68TK68QztxTeu7yYD7wRxPuNs0ukN5xTILiLNq5WuBD698TnplhlDM4D2IRT5rlgYC+9kpbO7zF0x28zpSLgNdNp+MVMrZvbDqVNIby++lCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490458; c=relaxed/simple;
	bh=/gkJg9IVFWdPTJ/KUF0SD0LhkJXLVBhh48Owqpafbh8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bOvdwvHc8jwA7jgXAQ/2Qy/hVuRpAERXnOmrUAWV2bvAAkT/Mo+MfuAXWpczgc69irYrq0IUIT8eC01RAIIbJY3N1hgqLkdnGULZVeE/YqCKLs6M3kYdBTJIzgYG0oVi1Vm27BDYrHafHTvNYAEVhcnZu56VAj7vmWx00TUTlr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTVxOFoP; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ae5af476e1so496904eec.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 07:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768490449; x=1769095249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3WBE7yLTwXJvXQknW3m3j/e1SLsqAi1Kc4r688prtj4=;
        b=nTVxOFoP86xkwaK+7aZ8P7Wm1/z6k04KGbiNk9xqGDP+OGqmMJIf3ssmgDd5Sh0gyQ
         2u/ayY7yfP0JPtkzuM9bsVdV0LfERkCVv6Giu9+SFN2sVr6XbaomYQnfHPV+381MMjfc
         wyYeo39jzAImgWbYQ2NoXa85XcTrmofHuszFREvW/JhmoRlewsokYQcRNPcuMAwkNTxV
         P3DV9Ipjc0SdiFRMQHA3m9QwxrfYpEtjTEqWgc3w+aR+U2rYFvgCwnWWpGhXLbHhTJl3
         lbLfMT7bQMxgNkfjEP3AHcigSwRMulpXZWzKVqsbIod9DxrcRxlLTEngGHShS9OkjXz2
         i4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768490449; x=1769095249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WBE7yLTwXJvXQknW3m3j/e1SLsqAi1Kc4r688prtj4=;
        b=OJwbY64OACNazrQMfN3yiBmzwLoS4QO5ugmRZO2zE+gJBxvZ/0zi382XZDWAfMxxeu
         E0pzSgVDwqSULj0c0UgAqEt8iOx5GfKIFoICBgJSmfYg9LNyq9a4s1iKG4DTtwp+PQDJ
         m4jy12phApyWSWDGav90LuC2TOP7aogI3Ldmg1U3u2hZqL8bEVPKEJBpAq+ETj2C3a2r
         31J9cadZJYW1uX2PmmASLe8hVFJUwEHSGuI9/ilshpQdEU+jIm+9izkjlYxP8mUIY+4p
         ku/UuZpkBG19/klDEh75q2JTKurlfaJHovQiAOqU0sjxRvuylb8raZNPwxgJhoHSa2Y2
         bN6w==
X-Forwarded-Encrypted: i=1; AJvYcCXHL5vzLPRNJptIOXBXROcJdMlbnt2xEiFevFPbtxv9GX/ZCQCyipvAd1yOxIx3t7YQ5Os=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz621g3tQ+1GTb0LSQkpX1ioKUz0bM0lKpr+zMfeWqvl7/zM59D
	50M21QtebA2ulc6p/Jo0zPYlAmcem4UFXrIrwU1AuEw/8RfQ6zib+Opw
X-Gm-Gg: AY/fxX5YT+0Pt/IzLsUQZ9i3eGDmM9KS4kiMyD0QC8a2rhB4MLI/SIxgfXjVgIDFpVC
	tAZkoRmeEhdljytmVvf9bTMIyK9yT4W4WBR0LYyIxtNWpzYYZ/9XSJZFzFx1j7l9SgguPzLSE2a
	ZiwOmUE/CzTt1pK0w60upWDewZpPU2bc+LR4bbPPlYRuxdsQBHE//3xATsxJ2BR7S838CL7pvwb
	XLWNf0aIjbGajawgZyJkNZ2s4Usxv4Ld2epRgUgw+Mx+Ob2XNBMYHAD2RtevanvWRAPrf2351DV
	fVlK0eBfZ6c+7f+xV4SF6hGraJYr25z4AOlKcKkEv+Aj4+vaXym3OcdFbwTC0v74JFOBdLDuEk2
	IuM147BnI5bVhv9i0q8G1w2A42qGmabXk6Sa8hd3ru9NHCwquefQtWrNI0CkVCnhARMH3+X5nGd
	ZbkbJ+lSddIjstMLR11plTbpo=
X-Received: by 2002:a05:7300:f60b:b0:2ab:f74a:6a63 with SMTP id 5a478bee46e88-2b6642f0eb1mr4561885eec.16.1768490448477;
        Thu, 15 Jan 2026 07:20:48 -0800 (PST)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078d9b1sm23544610eec.18.2026.01.15.07.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 07:20:48 -0800 (PST)
From: wujing <realwujing@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wujing <realwujing@gmail.com>,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: [PATCH] bpf/verifier: compress bpf_reg_state by using bitfields
Date: Thu, 15 Jan 2026 23:20:37 +0800
Message-Id: <20260115152037.449362-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct bpf_reg_state is 112 bytes long on 64-bit architectures,
with several fields that have limited ranges. In particular, the bool
'precise' at the end causes 7 bytes of padding.

This patch packs 'frameno', 'subreg_def', and 'precise' into a single
u32/s32 bitfield block:
- frameno: 4 bits (sufficient for MAX_CALL_FRAMES=8)
- subreg_def: 27 bits (sufficient for 1M insns limit)
- precise: 1 bit

This reduces the size of struct bpf_reg_state from 112 to 104 bytes,
saving 8 bytes per register. This also reduces the size of
struct bpf_stack_state. Overall, it reduces peak memory usage of the
verifier for complex programs with millions of states.

The patch also updates states_maybe_looping() to use a non-bitfield
boundary for memcmp(), as offsetof() cannot be used on bitfields.

Signed-off-by: wujing <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 include/linux/bpf_verifier.h | 6 +++---
 kernel/bpf/verifier.c        | 6 ++++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 562f7e63be29..0f83360afb03 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -196,14 +196,14 @@ struct bpf_reg_state {
 	 * is used which is an index in bpf_verifier_state->frame[] array
 	 * pointing to bpf_func_state.
 	 */
-	u32 frameno;
+	u32 frameno:4;
 	/* Tracks subreg definition. The stored value is the insn_idx of the
 	 * writing insn. This is safe because subreg_def is used before any insn
 	 * patching which only happens after main verification finished.
 	 */
-	s32 subreg_def;
+	s32 subreg_def:27;
 	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
-	bool precise;
+	bool precise:1;
 };
 
 enum bpf_stack_slot_type {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 378341e1177f..5e5b831a518c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19641,10 +19641,12 @@ static bool states_maybe_looping(struct bpf_verifier_state *old,
 
 	fold = old->frame[fr];
 	fcur = cur->frame[fr];
-	for (i = 0; i < MAX_BPF_REG; i++)
+	for (i = 0; i < MAX_BPF_REG; i++) {
 		if (memcmp(&fold->regs[i], &fcur->regs[i],
-			   offsetof(struct bpf_reg_state, frameno)))
+			   offsetof(struct bpf_reg_state, ref_obj_id) +
+			   sizeof(fold->regs[i].ref_obj_id)))
 			return false;
+	}
 	return true;
 }
 
-- 
2.39.5


