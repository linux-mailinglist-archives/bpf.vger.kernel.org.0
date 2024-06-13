Return-Path: <bpf+bounces-32017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612E490619B
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 04:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8E41C218B4
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 02:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DD64EB5E;
	Thu, 13 Jun 2024 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="bqlIFtmk"
X-Original-To: bpf@vger.kernel.org
Received: from ha.d.sender-sib.com (ha.d.sender-sib.com [77.32.148.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9872129CE5
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.32.148.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718244533; cv=none; b=bHjhp90ogiAhRhRJ9peIvyvKQzuN3tHSZ1dIe4GLrIixV7igfkJHqNXohy8CWppo5F6OZoY6kyLr4eE0FFLlpFQ7YK104GohJ5aqw9qHSLUeClk/RIzurLdFD8HG8CADLbjEy/JvKw2MhzeerL8vQtsWGOm3tATiXVi94iV9yYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718244533; c=relaxed/simple;
	bh=VKJsZV+BwKnsy7MuVOAepUmHLdowS95v2Rmg9J7BPN8=;
	h=Date:Subject:In-Reply-To:References:Cc:Mime-Version:Message-Id:To:
	 From; b=YLKZH8Yef4LJggQJ5lMv5Fh896sh4zTmclsKbkcixNbMyFvsdT/AEpPwBWqKNAeysAtHJSOSS9tdfAE0GTYMAVhDPnZpQUiIeUOeo4TxnVVhi8HXaO9pz4JKyCo3fgHjk3re1Gul0vVSNGzfWQYgXVYAmNwvoPwVoXcFV70i4XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=ha.d.sender-sib.com; dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=bqlIFtmk; arc=none smtp.client-ip=77.32.148.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ha.d.sender-sib.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rcpassos.me;
 q=dns/txt; s=mail; bh=WHsaCBtzUv98IBMa4xm9Qs/oWq7oF044syaYJsCyTSI=;
 h=from:reply-to:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=bqlIFtmkkvCfy8ik/x+cap9nPoMq+87dDaXLa9+Zz39Ls9D4aLENJRaeQ7dlJugZtCXLR2EJhoGD
        ilHRLI3Qe9aM6P6+khaiS0R20ZyJFdzXHEFpQ7SrBKsjnNfIKpm26ZudAXt24CJcXOeL1vSnjq/x
        LZGglofJLdA5sruLda4=
Received: by smtp-relay.sendinblue.com with ESMTP id c95b4ec3-383f-4ebe-a0f0-2067ba945919; Thu, 13 June 2024 02:07:43 +0000 (UTC)
X-Mailin-EID: MjM2NzcxMDk4fmJwZkB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwNjEzMDIwNzI5LjQzOTUzLTMtcmFmYWVsQHJjcGFzc29zLm1lPn5oYS5kLnNlbmRlci1zaWIuY29t
Date: Wed, 12 Jun 2024 23:03:13 -0300
Subject: [PATCH bpf-next 2/3] bpf: remove unused parameter in __bpf_free_used_btfs
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613020729.43953-1-rafael@rcpassos.me>
References: <20240613020729.43953-1-rafael@rcpassos.me>
Content-Transfer-Encoding: quoted-printable
Cc: "Rafael Passos" <rafael@rcpassos.me>, bpf@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Reply-To: Rafael Passos <rafael@rcpassos.me>
Message-Id: <c95b4ec3-383f-4ebe-a0f0-2067ba945919@smtp-relay.sendinblue.com>
Origin-messageId: <20240613020729.43953-3-rafael@rcpassos.me>
To: <ast@kernel.org>,<daniel@iogearbox.net>,<andrii@kernel.org>
X-sib-id: SFxX2vvBhn3aUmUS-ymVDABz38zT4Lll0jtOZsUzfXJJ90vtqpIeFIlz9ZgPqh-22Oi-spRPP8oStIHK7Cp-WLpuqjjzIFRSGo2wpRGhIPZjwn8_x2tZdYU8TUYM-Vh85OwRJyREKG-rxumamNFtQo0u2OjIpWbwQdYF_mvpa06P
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 77.32.148.27:6736438_-1:6736438:Sendinblue
From: "Rafael Passos" <rafael@rcpassos.me>

Fixes a compiler warning. The =5F=5Fbpf=5Ffree=5Fused=5Fbtfs function
was taking an extra unused struct bpf=5Fprog=5Faux *aux param

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
@@ -2933,8 +2933,7 @@ bpf=5Fprobe=5Fread=5Fkernel=5Fcommon(void *dst, u32 =
size, const void *unsafe=5Fptr)
 	return ret;
 }
=20
-void =5F=5Fbpf=5Ffree=5Fused=5Fbtfs(struct bpf=5Fprog=5Faux *aux,
-			  struct btf=5Fmod=5Fpair *used=5Fbtfs, u32 len);
+void =5F=5Fbpf=5Ffree=5Fused=5Fbtfs(struct btf=5Fmod=5Fpair *used=5Fbtfs, =
u32 len);
=20
 static inline struct bpf=5Fprog *bpf=5Fprog=5Fget=5Ftype(u32 ufd,
 						 enum bpf=5Fprog=5Ftype type)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index f6951c33790d..ae2e1eeda0d4 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2742,8 +2742,7 @@ static void bpf=5Ffree=5Fused=5Fmaps(struct =
bpf=5Fprog=5Faux *aux)
 	kfree(aux->used=5Fmaps);
 }
=20
-void =5F=5Fbpf=5Ffree=5Fused=5Fbtfs(struct bpf=5Fprog=5Faux *aux,
-			  struct btf=5Fmod=5Fpair *used=5Fbtfs, u32 len)
+void =5F=5Fbpf=5Ffree=5Fused=5Fbtfs(struct btf=5Fmod=5Fpair *used=5Fbtfs, =
u32 len)
 {
 #ifdef CONFIG=5FBPF=5FSYSCALL
 	struct btf=5Fmod=5Fpair *btf=5Fmod;
@@ -2760,7 +2759,7 @@ void =5F=5Fbpf=5Ffree=5Fused=5Fbtfs(struct =
bpf=5Fprog=5Faux *aux,
=20
 static void bpf=5Ffree=5Fused=5Fbtfs(struct bpf=5Fprog=5Faux *aux)
 {
-	=5F=5Fbpf=5Ffree=5Fused=5Fbtfs(aux, aux->used=5Fbtfs, =
aux->used=5Fbtf=5Fcnt);
+	=5F=5Fbpf=5Ffree=5Fused=5Fbtfs(aux->used=5Fbtfs, aux->used=5Fbtf=5Fcnt);
 	kfree(aux->used=5Fbtfs);
 }
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index acc9dd830807..c703612e04f7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18619,8 +18619,7 @@ static void release=5Fmaps(struct =
bpf=5Fverifier=5Fenv *env)
 /* drop refcnt of maps used by the rejected program */
 static void release=5Fbtfs(struct bpf=5Fverifier=5Fenv *env)
 {
-	=5F=5Fbpf=5Ffree=5Fused=5Fbtfs(env->prog->aux, env->used=5Fbtfs,
-			     env->used=5Fbtf=5Fcnt);
+	=5F=5Fbpf=5Ffree=5Fused=5Fbtfs(env->used=5Fbtfs, env->used=5Fbtf=5Fcnt);
 }
=20
 /* convert pseudo BPF=5FLD=5FIMM64 into generic BPF=5FLD=5FIMM64 */
--=20
2.45.2



