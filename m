Return-Path: <bpf+bounces-27060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5728A8ACB
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 20:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49A01C2219C
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 18:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A0E172BD7;
	Wed, 17 Apr 2024 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="ew2jrmUy"
X-Original-To: bpf@vger.kernel.org
Received: from ha.d.sender-sib.com (ha.d.sender-sib.com [77.32.148.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B25172BA2
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.32.148.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713377316; cv=none; b=LgkWp/JThBDGa5o0l3MWSahfbj8aJVQ0xGnLOu+gM0Dfq0H3YTd3K1M+TmjHXFPDps7FXYX9abRzsyaixw7Hu2PQ/5BeO+WXPA4Mnx9lDwywrmBp9zW56IkUfDpkFd6YnK7yQik5AtuTvQVwc5SI1q8dYbCnaC1xus2/h2V6ihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713377316; c=relaxed/simple;
	bh=bxVangwNz1QJBrKeX5KBN1KwjsiyeT8xwPTDfAZayC0=;
	h=Date:Subject:In-Reply-To:Mime-Version:References:Cc:Message-Id:To:
	 From; b=R37QlySmbm0NYEDhekHnIbL+drEEtbh8UP9CkYNc5UeiEs3dF0tnit1YgHRQny9l6pQsmiRYy8YET4XozmgSbqvivneFgB3pIm2QA0s70mbR+B5d19NStVm98O843Yt3RNPcSDAV6QrjNsPdpbZ4GX+BETD1TG0wqg1DAgntk9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=ha.d.sender-sib.com; dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=ew2jrmUy; arc=none smtp.client-ip=77.32.148.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ha.d.sender-sib.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rcpassos.me;
 q=dns/txt; s=mail; bh=NQ3lqyCQ0E2jBjKUI0ZmHF9KzGb9aIJltSifdEjKEj4=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=ew2jrmUyvoHL3zm0O/FjRgmxjVLPFuygntRinswzl+bo6qXHWc7iNzDV26VT5e8/H0yJ1iRBrbF3
        DHyOCFAPNUKNl+KODJtqkUZs6BHHNFrUvOTpWtOfT9mobNfNk5rOGOFyDqwwV+PgXQGCxjkbuKQ8
        otQVG6l2Hn2JtySWfEo=
Received: by smtp-relay.sendinblue.com with ESMTP id fbe1d636-8172-4698-9a5a-5a3444b55322; Wed, 17 April 2024 18:08:32 +0000 (UTC)
X-Mailin-EID: MjM2NzcxMDk4fmJwZkB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwNDE3MTgwNDQ2LjkzMDAtNC1yYWZhZWxAcmNwYXNzb3MubWU%2BfmhhLmQuc2VuZGVyLXNpYi5jb20%3D
Date: Wed, 17 Apr 2024 14:52:26 -0300
Subject: [PATCH] bpf: fix typo in function save_aux_ptr_type
In-Reply-To: <20240417180446.9300-1-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: git-send-email 2.44.0
References: <20240417180446.9300-1-rafael@rcpassos.me>
Cc: "Rafael Passos" <rafael@rcpassos.me>, bpf@vger.kernel.org
Message-Id: <fbe1d636-8172-4698-9a5a-5a3444b55322@smtp-relay.sendinblue.com>
Origin-messageId: <20240417180446.9300-4-rafael@rcpassos.me>
To: <ast@kernel.org>,<daniel@iogearbox.net>,<andrii@kernel.org>
X-sib-id: yjKRDps_FEXVSlCZ0AMOAP9FTHP5aTyPHaZeIJJm3CVZLYrVOnbhM6BJyvwBNFuR-_1gu4NhO4ddRotNyirqaI8Zn8N_3pHysIvE0me-XqpRYpyjibTXIvrh84fsShzViGBdWiKgXowjUodO1bHS9zLI66nTQe5kg9VmyCXRHLUm
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



