Return-Path: <bpf+bounces-27063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA918A8B9B
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 20:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176E31C23B68
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 18:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699D61D52C;
	Wed, 17 Apr 2024 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="s46z5Jok"
X-Original-To: bpf@vger.kernel.org
Received: from ha.d.sender-sib.com (ha.d.sender-sib.com [77.32.148.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E050318026
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.32.148.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379865; cv=none; b=dTlTuBlfN0FcLK4Ra+JnQNU/nGr+Bxt8te1nYMgEjzNcbp8HOOUVnmNbQChO1qKZ1ljO59MTjQTSZZu7PZTVfx5eSdhbaK0XihoWX+DrGL/QOzmFApuIifJT2qE++wqSy54pys4Sw4KCKVbdewsgtoVP5OgtFW9erl5rErhGxXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379865; c=relaxed/simple;
	bh=bxVangwNz1QJBrKeX5KBN1KwjsiyeT8xwPTDfAZayC0=;
	h=Date:Subject:Cc:In-Reply-To:Mime-Version:References:Message-Id:To:
	 From; b=C2o1aR0rn1Sb3y8Np/I5I77GhQzMt6BRMMhQE+hK/XWyha0HZkfb5VNwBZKRVvB7+1NiMdJ1d2kSPo6S6skeGfd4bJyUi8dWPvbogt71wn5ZsmXXfXxo6BvIHEJg2KGoXdsEAz++yaWQ2Lli45LaLBhMB8Flpz0mhwE9YLKy9KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=ha.d.sender-sib.com; dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=s46z5Jok; arc=none smtp.client-ip=77.32.148.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ha.d.sender-sib.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rcpassos.me;
 q=dns/txt; s=mail; bh=NQ3lqyCQ0E2jBjKUI0ZmHF9KzGb9aIJltSifdEjKEj4=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=s46z5JokP/SSlYPUm8CyACGGByp4Z6zZraRSdP6NV8McnHqVq755zlFTQgEIrGnIbECmO43fFOwU
        5SePIzr6RTbNfaQVcohDC7beAgtbPyd4oB4pfAF+ZvgqSOlGCybEbzX+UJ57vhklkkudQj5AwhgM
        s9nVIN4L5cN6DO1VjGQ=
Received: by smtp-relay.sendinblue.com with ESMTP id faf2d9cf-3326-4932-b735-5dbee87e67cb; Wed, 17 April 2024 18:51:00 +0000 (UTC)
X-Mailin-EID: MjM2NzcxMDk4fmJwZkB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwNDE3MTg0OTE4LjIxNDcyLTItcmFmYWVsQHJjcGFzc29zLm1lPn5oYS5kLnNlbmRlci1zaWIuY29t
Date: Wed, 17 Apr 2024 15:49:15 -0300
Subject: [PATCH bpf-next 2/2] bpf: fix typo in function save_aux_ptr_type
Cc: "Rafael Passos" <rafael@rcpassos.me>, bpf@vger.kernel.org
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417184918.21472-1-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20240417180446.9300-1-rafael@rcpassos.me> <20240417184918.21472-1-rafael@rcpassos.me>
Message-Id: <faf2d9cf-3326-4932-b735-5dbee87e67cb@smtp-relay.sendinblue.com>
Origin-messageId: <20240417184918.21472-2-rafael@rcpassos.me>
To: <ast@kernel.org>,<andrii@kernel.org>,<daniel@iogearbox.net>
X-sib-id: PbvmQ5yo8aOk3QbgNiWBWDXVFvtKUhG4q0LDXg3LNSdo-liQl2VEwhrL5wUU1Ap4rY08qeEtUcLWPzazG4jBJ8H_DlBb7t-UPwrKBDsT-olx2EtzlIHpFRwxdwBuIbBj2JD-j-9ONKNW4VyJbL39oWe_sFpihwjELLlzPJlmcODM
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 77.32.148.27:6736438_-1:6736438:Sendinblue
From: "Rafael Passos" <rafael@rcpassos.me>

I found this typo in the save=5Faux=5Fptr=5Ftype function.
s/allow=5Ftrust=5Fmissmatch/allow=5Ftrust=5Fmismatch/
I did not find this anywhere else in the codebase.

Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 537cdccb8363..5a7e34e83a5b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6971,7 +6971,7 @@ static int check=5Fmem=5Faccess(struct =
bpf=5Fverifier=5Fenv *env, int insn=5Fidx, u32 regn
 }
=20
 static int save=5Faux=5Fptr=5Ftype(struct bpf=5Fverifier=5Fenv *env, enum =
bpf=5Freg=5Ftype type,
-			     bool allow=5Ftrust=5Fmissmatch);
+			     bool allow=5Ftrust=5Fmismatch);
=20
 static int check=5Fatomic(struct bpf=5Fverifier=5Fenv *env, int insn=5Fidx=
, struct bpf=5Finsn *insn)
 {
@@ -17530,7 +17530,7 @@ static bool reg=5Ftype=5Fmismatch(enum =
bpf=5Freg=5Ftype src, enum bpf=5Freg=5Ftype prev)
 }
=20
 static int save=5Faux=5Fptr=5Ftype(struct bpf=5Fverifier=5Fenv *env, enum =
bpf=5Freg=5Ftype type,
-			     bool allow=5Ftrust=5Fmissmatch)
+			     bool allow=5Ftrust=5Fmismatch)
 {
 	enum bpf=5Freg=5Ftype *prev=5Ftype =3D &env->insn=5Faux=5Fdata[env->insn=
=5Fidx].ptr=5Ftype;
=20
@@ -17548,7 +17548,7 @@ static int save=5Faux=5Fptr=5Ftype(struct =
bpf=5Fverifier=5Fenv *env, enum bpf=5Freg=5Ftype typ
 		 * src=5Freg =3D=3D stack|map in some other branch.
 		 * Reject it.
 		 */
-		if (allow=5Ftrust=5Fmissmatch &&
+		if (allow=5Ftrust=5Fmismatch &&
 		    base=5Ftype(type) =3D=3D PTR=5FTO=5FBTF=5FID &&
 		    base=5Ftype(*prev=5Ftype) =3D=3D PTR=5FTO=5FBTF=5FID) {
 			/*
--=20
2.44.0



