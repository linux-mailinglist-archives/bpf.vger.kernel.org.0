Return-Path: <bpf+bounces-32018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9514B90619C
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 04:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA863B2275E
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 02:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F5F2D60A;
	Thu, 13 Jun 2024 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="FrfDdlgN"
X-Original-To: bpf@vger.kernel.org
Received: from ha.d.sender-sib.com (ha.d.sender-sib.com [77.32.148.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986E97F9
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.32.148.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718244533; cv=none; b=ZQmjwIcRa7E0cez73mW+bDEk1Y1ainRKY4KHAkoKvKVZi58/sNWrd+X8PAZq931vPMWLqB2tRHSqQEYzOu68OfKAodjqF/fb/3m/OxG72ypItL4/MAGf/zBCWsJr489jblqgIICUcQ1T2/cRpuHaz3RI2YyLA3uaCnml3hfcKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718244533; c=relaxed/simple;
	bh=gLkRe5EjSooELuD3f3yR4UWPAnGsqSzPSCAsVNuuywU=;
	h=Date:Subject:In-Reply-To:References:Cc:Mime-Version:Message-Id:To:
	 From; b=FfQPlynEtpaubyALei7A0W7vpBpBk51BUN8gzn7owOxJ3r/hXiLPLOJqa4QcPRvGplAGnmaZ3uyu0oHEstSgbPD3O38uSwQ7eRErQzAm5oKUKY8zpuS3LNyuSYVoels3onmlvcuIOZfOPuh/WNYLkejsJnO10kqaVsAb3TMZEUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=ha.d.sender-sib.com; dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=FrfDdlgN; arc=none smtp.client-ip=77.32.148.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ha.d.sender-sib.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rcpassos.me;
 q=dns/txt; s=mail; bh=6Sv+TOmx3kcWVbDGL7T9AkXTUI4z9onBeBdT3MnSbXg=;
 h=from:reply-to:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=FrfDdlgNXV8/Jk78xk2Vlvj2QgpfDtqRV2U9P/G/dGq+zxChV9AErGH6Nc5fe3D/Q7KtCp6A37X1
        lPeYezj+J1kzOSRf01FYPVeCySkbf6/SHSnrJsaXLnlzCnmYooLOhjh2iVrXHGavrdmqce79w6T+
        BGpZoXLAjitNRAOZ0y8=
Received: by smtp-relay.sendinblue.com with ESMTP id 7eaed3dc-28e5-409f-8f73-a1bf8acc2937; Thu, 13 June 2024 02:07:43 +0000 (UTC)
X-Mailin-EID: MjM2NzcxMDk4fmJwZkB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwNjEzMDIwNzI5LjQzOTUzLTItcmFmYWVsQHJjcGFzc29zLm1lPn5oYS5kLnNlbmRlci1zaWIuY29t
Date: Wed, 12 Jun 2024 23:03:12 -0300
Subject: [PATCH bpf-next 1/3] bpf: remove unused parameter in bpf_jit_binary_pack_finalize
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
Message-Id: <7eaed3dc-28e5-409f-8f73-a1bf8acc2937@smtp-relay.sendinblue.com>
Origin-messageId: <20240613020729.43953-2-rafael@rcpassos.me>
To: <davem@davemloft.net>,<dsahern@kernel.org>,<ast@kernel.org>,<daniel@iogearbox.net>,<andrii@kernel.org>,<tglx@linutronix.de>,<mingo@redhat.com>,<bp@alien8.de>
X-sib-id: Fglj40LGfy3ZUybM1D_dEp0PNuguA9NZ9qb8afsLkxRG3oi8p-hc1NMwrnRr_nMuKfBgPkNo0b5vyTJkfAmcUnUQVPPqDVfPIrE_d_w12Cn6H7Z1sm2X9wuQAlxzDmSL9dsalk_hatqlupPDQb5-Wk0zUw4SdKjXH5vG6iEp6xIo
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 77.32.148.27:6736438_-1:6736438:Sendinblue
From: "Rafael Passos" <rafael@rcpassos.me>

Fixes a compiler warning. the bpf=5Fjit=5Fbinary=5Fpack=5Ffinalize =
function
was taking an extra bpf=5Fprog parameter that went unused.

Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---
 arch/x86/net/bpf=5Fjit=5Fcomp.c | 4 ++--
 include/linux/filter.h      | 3 +--
 kernel/bpf/core.c           | 3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/net/bpf=5Fjit=5Fcomp.c b/arch/x86/net/bpf=5Fjit=5Fcom=
p.c
index 5159c7a22922..bd7e13602bf6 100644
--- a/arch/x86/net/bpf=5Fjit=5Fcomp.c
+++ b/arch/x86/net/bpf=5Fjit=5Fcomp.c
@@ -3363,7 +3363,7 @@ struct bpf=5Fprog *bpf=5Fint=5Fjit=5Fcompile(struct =
bpf=5Fprog *prog)
 			 *
 			 * Both cases are serious bugs and justify WARN=5FON.
 			 */
-			if (WARN=5FON(bpf=5Fjit=5Fbinary=5Fpack=5Ffinalize(prog, header, =
rw=5Fheader))) {
+			if (WARN=5FON(bpf=5Fjit=5Fbinary=5Fpack=5Ffinalize(header, =
rw=5Fheader))) {
 				/* header has been freed */
 				header =3D NULL;
 				goto out=5Fimage;
@@ -3442,7 +3442,7 @@ void bpf=5Fjit=5Ffree(struct bpf=5Fprog *prog)
 		 * before freeing it.
 		 */
 		if (jit=5Fdata) {
-			bpf=5Fjit=5Fbinary=5Fpack=5Ffinalize(prog, jit=5Fdata->header,
+			bpf=5Fjit=5Fbinary=5Fpack=5Ffinalize(jit=5Fdata->header,
 						     jit=5Fdata->rw=5Fheader);
 			kvfree(jit=5Fdata->addrs);
 			kfree(jit=5Fdata);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index b02aea291b7e..dd41a93f06b2 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1129,8 +1129,7 @@ bpf=5Fjit=5Fbinary=5Fpack=5Falloc(unsigned int =
proglen, u8 **ro=5Fimage,
 			  struct bpf=5Fbinary=5Fheader **rw=5Fhdr,
 			  u8 **rw=5Fimage,
 			  bpf=5Fjit=5Ffill=5Fhole=5Ft bpf=5Ffill=5Fill=5Finsns);
-int bpf=5Fjit=5Fbinary=5Fpack=5Ffinalize(struct bpf=5Fprog *prog,
-				 struct bpf=5Fbinary=5Fheader *ro=5Fheader,
+int bpf=5Fjit=5Fbinary=5Fpack=5Ffinalize(struct bpf=5Fbinary=5Fheader =
*ro=5Fheader,
 				 struct bpf=5Fbinary=5Fheader *rw=5Fheader);
 void bpf=5Fjit=5Fbinary=5Fpack=5Ffree(struct bpf=5Fbinary=5Fheader =
*ro=5Fheader,
 			      struct bpf=5Fbinary=5Fheader *rw=5Fheader);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1a6c3faa6e4a..f6951c33790d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1174,8 +1174,7 @@ bpf=5Fjit=5Fbinary=5Fpack=5Falloc(unsigned int =
proglen, u8 **image=5Fptr,
 }
=20
 /* Copy JITed text from rw=5Fheader to its final location, the ro=5Fheader=
. */
-int bpf=5Fjit=5Fbinary=5Fpack=5Ffinalize(struct bpf=5Fprog *prog,
-				 struct bpf=5Fbinary=5Fheader *ro=5Fheader,
+int bpf=5Fjit=5Fbinary=5Fpack=5Ffinalize(struct bpf=5Fbinary=5Fheader =
*ro=5Fheader,
 				 struct bpf=5Fbinary=5Fheader *rw=5Fheader)
 {
 	void *ptr;
--=20
2.45.2



