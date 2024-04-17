Return-Path: <bpf+bounces-27062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1AF8A8B96
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 20:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723D61C238DC
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 18:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061801CAAC;
	Wed, 17 Apr 2024 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="3BCFevUI"
X-Original-To: bpf@vger.kernel.org
Received: from ha.d.sender-sib.com (ha.d.sender-sib.com [77.32.148.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC48182AF
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.32.148.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379781; cv=none; b=SIEfwYgJoypvHgwLlqhwya+KknutpLRJH/IHAJJIFwgRQ9VRHR4nsHvvCPotp4XuDpyofNFEFhzWl4ceHI48hk2HGVt/FByErOqybHgok4bCQU6af8JqWMHkjlun6YlBx0cbLugXwq9yzi9Xf2FVa/1stvdBQP28h+t2pi06skk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379781; c=relaxed/simple;
	bh=04CT0cSgLIvg2WNxj34mRRlLZAesIJovFvvqqqH2FRQ=;
	h=Date:Subject:Cc:In-Reply-To:Mime-Version:References:Message-Id:To:
	 From; b=n3jA4oAF7pLOHR3qeAMI9CH0MbdbSXd5yl8Szq3kXi8+Nto3z84FMQQ6r0DeHQy51YIU4oQh3FK7t77sKXFUtHQl334ObnbQs/h0Wj3kQBYiOM4AT4/KGJC72l2db5qt1p58pUytYfwehYRuBGuIr2EtKuOuf1j8yTzEACeqTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=ha.d.sender-sib.com; dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=3BCFevUI; arc=none smtp.client-ip=77.32.148.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ha.d.sender-sib.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rcpassos.me;
 q=dns/txt; s=mail; bh=T/WkTT0ZazCQtPMfBItzgnsG6O/5ygy4oziDtky1otc=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=3BCFevUIheIMU6rlbwgoHQWHIXfKnIidXOelvignqEWrqUuAaUh1Hn72RygMKW9W6ZZsK2pl5mLV
        JbgjtXr2/Fz/+8emMrXZO4rjm3ferAAtBm0nJwlRR5DxPJ4CLPEUp7HpTRj5E5oPHHkjDzisUz64
        WTmp38WpF4M9bY17y2A=
Received: by smtp-relay.sendinblue.com with ESMTP id 6af7deb4-bb24-49e8-b3f1-8dd410597337; Wed, 17 April 2024 18:49:37 +0000 (UTC)
X-Mailin-EID: MjM2NzcxMDk4fmJwZkB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwNDE3MTg0OTE4LjIxNDcyLTEtcmFmYWVsQHJjcGFzc29zLm1lPn5oYS5kLnNlbmRlci1zaWIuY29t
Date: Wed, 17 Apr 2024 15:49:14 -0300
Subject: [PATCH bpf-next 1/2] bpf: fixes typos in comments
Cc: "Rafael Passos" <rafael@rcpassos.me>, bpf@vger.kernel.org
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417180446.9300-1-rafael@rcpassos.me>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240417180446.9300-1-rafael@rcpassos.me>
Message-Id: <6af7deb4-bb24-49e8-b3f1-8dd410597337@smtp-relay.sendinblue.com>
Origin-messageId: <20240417184918.21472-1-rafael@rcpassos.me>
To: <ast@kernel.org>,<andrii@kernel.org>,<daniel@iogearbox.net>
X-sib-id: xbHUlCkFBGJOtieHXJby0zdU8AfLhIj60X8NZb0KHiDRcnskL4Igo7lgQo191K9LyxRJ--CKI_ibIkz0fxWDg64sWbYQoOcQ_qHLTe3XJb3WV84-noevKL3fXH3r81fHb4zxhGN0l2dqdQZ8p-IACOpJyQeXrFQdwGQgTtDPWjbh
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 77.32.148.27:6736438_-1:6736438:Sendinblue
From: "Rafael Passos" <rafael@rcpassos.me>

I found the following typos in the comments, and fixed them:
s/unpriviledged/unprivileged/
s/reponsible/responsible/
s/possiblities/possibilities/
s/Divison/Division/
s/precsion/precision/
s/havea/have a/
s/reponsible/responsible/
s/responsibile/responsible/
s/tigher/tighter/
s/respecitve/respective/

Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---
 kernel/bpf/bpf=5Flocal=5Fstorage.c |  2 +-
 kernel/bpf/core.c              |  2 +-
 kernel/bpf/hashtab.c           |  2 +-
 kernel/bpf/helpers.c           |  2 +-
 kernel/bpf/verifier.c          | 12 ++++++------
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/bpf=5Flocal=5Fstorage.c b/kernel/bpf/bpf=5Flocal=5F=
storage.c
index bdea1a459153..976cb258a0ed 100644
--- a/kernel/bpf/bpf=5Flocal=5Fstorage.c
+++ b/kernel/bpf/bpf=5Flocal=5Fstorage.c
@@ -318,7 +318,7 @@ static bool check=5Fstorage=5Fbpf=5Fma(struct =
bpf=5Flocal=5Fstorage *local=5Fstorage,
 	 *
 	 * If the local=5Fstorage->list is already empty, the caller will not
 	 * care about the bpf=5Fma value also because the caller is not
-	 * responsibile to free the local=5Fstorage.
+	 * responsible to free the local=5Fstorage.
 	 */
=20
 	if (storage=5Fsmap)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a41718eaeefe..95c7fd093e55 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2814,7 +2814,7 @@ void bpf=5Fprog=5Ffree(struct bpf=5Fprog *fp)
 }
 EXPORT=5FSYMBOL=5FGPL(bpf=5Fprog=5Ffree);
=20
-/* RNG for unpriviledged user space with separated state from =
prandom=5Fu32(). */
+/* RNG for unprivileged user space with separated state from =
prandom=5Fu32(). */
 static DEFINE=5FPER=5FCPU(struct rnd=5Fstate, bpf=5Fuser=5Frnd=5Fstate);
=20
 void bpf=5Fuser=5Frnd=5Finit=5Fonce(void)
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 83a9a74260e9..c3e79a0b9361 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1539,7 +1539,7 @@ static void htab=5Fmap=5Ffree(struct bpf=5Fmap *map)
 	 */
=20
 	/* htab no longer uses call=5Frcu() directly. bpf=5Fmem=5Falloc does it
-	 * underneath and is reponsible for waiting for callbacks to finish
+	 * underneath and is responsible for waiting for callbacks to finish
 	 * during bpf=5Fmem=5Falloc=5Fdestroy().
 	 */
 	if (!htab=5Fis=5Fprealloc(htab)) {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8cde717137bd..61126180d398 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2412,7 +2412,7 @@ =5F=5Fbpf=5Fkfunc void *bpf=5Fdynptr=5Fslice=5Frdwr(c=
onst struct bpf=5Fdynptr=5Fkern *ptr, u32 o
 	/* bpf=5Fdynptr=5Fslice=5Frdwr is the same logic as bpf=5Fdynptr=5Fslice.=

 	 *
 	 * For skb-type dynptrs, it is safe to write into the returned pointer
-	 * if the bpf program allows skb data writes. There are two possiblities
+	 * if the bpf program allows skb data writes. There are two =
possibilities
 	 * that may occur when calling bpf=5Fdynptr=5Fslice=5Frdwr:
 	 *
 	 * 1) The requested slice is in the head of the skb. In this case, the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 68cfd6fc6ad4..537cdccb8363 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -172,7 +172,7 @@ static bool bpf=5Fglobal=5Fpercpu=5Fma=5Fset;
=20
 /* verifier=5Fstate + insn=5Fidx are pushed to stack when branch is =
encountered */
 struct bpf=5Fverifier=5Fstack=5Felem {
-	/* verifer state is 'st'
+	/* verifier state is 'st'
 	 * before processing instruction 'insn=5Fidx'
 	 * and after processing instruction 'prev=5Finsn=5Fidx'
 	 */
@@ -2131,7 +2131,7 @@ static void =5F=5Freg64=5Fdeduce=5Fbounds(struct =
bpf=5Freg=5Fstate *reg)
 static void =5F=5Freg=5Fdeduce=5Fmixed=5Fbounds(struct bpf=5Freg=5Fstate =
*reg)
 {
 	/* Try to tighten 64-bit bounds from 32-bit knowledge, using 32-bit
-	 * values on both sides of 64-bit range in hope to have tigher range.
+	 * values on both sides of 64-bit range in hope to have tighter range.
 	 * E.g., if r1 is [0x1'00000000, 0x3'80000000], and we learn from
 	 * 32-bit signed > 0 operation that s32 bounds are now [1; 0x7fffffff].
 	 * With this, we can substitute 1 as low 32-bits of =5Flow=5F 64-bit =
bound
@@ -2139,7 +2139,7 @@ static void =5F=5Freg=5Fdeduce=5Fmixed=5Fbounds(struc=
t bpf=5Freg=5Fstate *reg)
 	 * =5Fhigh=5F 64-bit bound (0x380000000 -> 0x37fffffff) and arrive at a
 	 * better overall bounds for r1 as [0x1'000000001; 0x3'7fffffff].
 	 * We just need to make sure that derived bounds we are intersecting
-	 * with are well-formed ranges in respecitve s64 or u64 domain, just
+	 * with are well-formed ranges in respective s64 or u64 domain, just
 	 * like we do with similar kinds of 32-to-64 or 64-to-32 adjustments.
 	 */
 	=5F=5Fu64 new=5Fumin, new=5Fumax;
@@ -14714,7 +14714,7 @@ static void regs=5Frefine=5Fcond=5Fop(struct =
bpf=5Freg=5Fstate *reg1, struct bpf=5Freg=5Fstate
=20
 /* Adjusts the register min/max values in the case that the dst=5Freg and
  * src=5Freg are both SCALAR=5FVALUE registers (or we are simply doing a =
BPF=5FK
- * check, in which case we havea fake SCALAR=5FVALUE representing =
insn->imm).
+ * check, in which case we have a fake SCALAR=5FVALUE representing =
insn->imm).
  * Technically we can do similar adjustments for pointers to the same =
object,
  * but we don't support that right now.
  */
@@ -17352,7 +17352,7 @@ static int is=5Fstate=5Fvisited(struct =
bpf=5Fverifier=5Fenv *env, int insn=5Fidx)
 			err =3D propagate=5Fliveness(env, &sl->state, cur);
=20
 			/* if previous state reached the exit with precision and
-			 * current state is equivalent to it (except precsion marks)
+			 * current state is equivalent to it (except precision marks)
 			 * the precision needs to be propagated back in
 			 * the current state.
 			 */
@@ -20209,7 +20209,7 @@ static int do=5Fmisc=5Ffixups(struct =
bpf=5Fverifier=5Fenv *env)
 			 * divide-by-3 through multiplication, followed by further
 			 * division by 8 through 3-bit right shift.
 			 * Refer to book =22Hacker's Delight, 2nd ed.=22 by Henry S. Warren, Jr=
.,
-			 * p. 227, chapter =22Unsigned Divison by 3=22 for details and proofs.
+			 * p. 227, chapter =22Unsigned Division by 3=22 for details and proofs.=

 			 *
 			 * N / 3 <=3D> M * N / 2^33, where M =3D (2^33 + 1) / 3 =3D 0xaaaaaaab.=

 			 */
--=20
2.44.0



