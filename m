Return-Path: <bpf+bounces-32213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5064C9095BB
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 04:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F66F2835ED
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 02:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A0DD26D;
	Sat, 15 Jun 2024 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="aU0w9KNP"
X-Original-To: bpf@vger.kernel.org
Received: from mail116.out.titan.email (mail116.out.titan.email [54.173.78.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AAC3C17
	for <bpf@vger.kernel.org>; Sat, 15 Jun 2024 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.173.78.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718419756; cv=none; b=LgN9NtFzbu8q7DbDFZT2UasC6W+Nfrer6rip7/UhQx/9TYT5Ow6YCulhblTgrUMVH+iUOtaANTA/CX4Aizb0zWzkJDaCtivwV6NLnjStcalCKNukvTf5/8a8hZDUJO33OFzJACu99Y6Hl6wemWhptZh5vUl5eEXIVSCPMYLUanY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718419756; c=relaxed/simple;
	bh=07rFAS8WwGZWiaPyO800g9sGe85Ge0zho1a5Q+zggSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trEvCSeCRfYTmf2AG8ZgtQh0FkKYbdcROtZVub9my3whnnYNM4B3jpVAUKhpfjMkQSOwzkBlzjGeN19l4uwW6/noRu0cCiZ1mX0XbwVNepskeUFqVDpLf50Y3aMEx9TMjkXngnWsAzijebW95DZ4559d5G6W8W99/upJi7jIelE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me; spf=fail smtp.mailfrom=rcpassos.me; dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=aU0w9KNP; arc=none smtp.client-ip=54.173.78.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=rcpassos.me
Received: from smtp-out.flockmail.com (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 07E7DE0004;
	Sat, 15 Jun 2024 02:30:05 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=cGsEWPmFAOpeOF34QVN3RL42zid/Nqkv3FBPOLsZFr4=;
	c=relaxed/relaxed; d=rcpassos.me;
	h=in-reply-to:from:cc:subject:message-id:mime-version:to:date:references:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1718418604; v=1;
	b=aU0w9KNPh/E7qbUm/8QafWcv/g3f+RR+aN/O72+V2DdVZagebvZED+ijh8Sj8YdHuWUOVy+l
	3/lYgM13wa6/7H6VMcMrvZ9zYB2cb3HA+aYe+b7gh2vrAAyuLra3MtMISQt1a1xGY0cK2Lc33W+
	6vcS0cEqizbz0EOgmpNxzEzA=
Received: from darkforce.pihole.rcpassos.me (unknown [104.28.243.51])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 030A2E0081;
	Sat, 15 Jun 2024 02:30:03 +0000 (UTC)
Feedback-ID: :rafael@rcpassos.me:rcpassos.me:flockmailId
From: Rafael Passos <rafael@rcpassos.me>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: Rafael Passos <rafael@rcpassos.me>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next V2 2/3] bpf: remove unused parameter in __bpf_free_used_btfs
Date: Fri, 14 Jun 2024 23:24:09 -0300
Message-ID: <20240615022641.210320-3-rafael@rcpassos.me>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240615022641.210320-1-rafael@rcpassos.me>
References: <20240615022641.210320-1-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1718418604915340736.31293.5894362100255476690@prod-use1-smtp-out1004.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=W6Y+VwWk c=1 sm=1 tr=0 ts=666cfcac
	a=rO3HKV82O4ipXYUjDYeURw==:117 a=rO3HKV82O4ipXYUjDYeURw==:17
	a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=CEWIc4RMnpUA:10
	a=c6FAzJyZY7ECWPs6LbIA:9 a=---8k2CCGq07aBBJLGWX:22
X-Virus-Scanned: ClamAV using ClamSMTP

Fixes a compiler warning. The __bpf_free_used_btfs function
was taking an extra unused struct bpf_prog_aux *aux param

Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---
 include/linux/bpf.h   | 3 +--
 kernel/bpf/core.c     | 5 ++---
 kernel/bpf/verifier.c | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f636b4998bf7..960780ef04e1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2933,8 +2933,7 @@ bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
 	return ret;
 }
 
-void __bpf_free_used_btfs(struct bpf_prog_aux *aux,
-			  struct btf_mod_pair *used_btfs, u32 len);
+void __bpf_free_used_btfs(struct btf_mod_pair *used_btfs, u32 len);
 
 static inline struct bpf_prog *bpf_prog_get_type(u32 ufd,
 						 enum bpf_prog_type type)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index f6951c33790d..ae2e1eeda0d4 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2742,8 +2742,7 @@ static void bpf_free_used_maps(struct bpf_prog_aux *aux)
 	kfree(aux->used_maps);
 }
 
-void __bpf_free_used_btfs(struct bpf_prog_aux *aux,
-			  struct btf_mod_pair *used_btfs, u32 len)
+void __bpf_free_used_btfs(struct btf_mod_pair *used_btfs, u32 len)
 {
 #ifdef CONFIG_BPF_SYSCALL
 	struct btf_mod_pair *btf_mod;
@@ -2760,7 +2759,7 @@ void __bpf_free_used_btfs(struct bpf_prog_aux *aux,
 
 static void bpf_free_used_btfs(struct bpf_prog_aux *aux)
 {
-	__bpf_free_used_btfs(aux, aux->used_btfs, aux->used_btf_cnt);
+	__bpf_free_used_btfs(aux->used_btfs, aux->used_btf_cnt);
 	kfree(aux->used_btfs);
 }
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index acc9dd830807..c703612e04f7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18619,8 +18619,7 @@ static void release_maps(struct bpf_verifier_env *env)
 /* drop refcnt of maps used by the rejected program */
 static void release_btfs(struct bpf_verifier_env *env)
 {
-	__bpf_free_used_btfs(env->prog->aux, env->used_btfs,
-			     env->used_btf_cnt);
+	__bpf_free_used_btfs(env->used_btfs, env->used_btf_cnt);
 }
 
 /* convert pseudo BPF_LD_IMM64 into generic BPF_LD_IMM64 */
-- 
2.45.2


