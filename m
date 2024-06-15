Return-Path: <bpf+bounces-32217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBEF90967E
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 09:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006581C210A5
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 07:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75B117580;
	Sat, 15 Jun 2024 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="O0L5eScF"
X-Original-To: bpf@vger.kernel.org
Received: from mail71.out.titan.email (mail71.out.titan.email [209.209.25.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C04F79F5
	for <bpf@vger.kernel.org>; Sat, 15 Jun 2024 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.209.25.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718435650; cv=none; b=ocJDBgRYZFY8feFRWtkoI5ZLS9raB+PJfln/vtxSAd9eeJqL8vq6yQgO6CXuqc/3AftlGIYA51rvsYQ24edrcwU8f4CW0Qpm51qr8Ja31CfWTzSthABUlkcLKQFmLlNBAKjMFWEvNbSM4yUhD9KOxOX3g0TF3uv9rdl2vIWeO3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718435650; c=relaxed/simple;
	bh=anPG9CE8wI7z2sJ/hcWhURkt8KwfaIY3f6wDeE81tyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnVpHwyLjO8lvK7P6Jd4zaE4hCFs4bpivQPIpjeRnfPyXWGh5xUJLi9/cgKB24/NBnNSSKienE3TWY62+AdS1dRwzhaRJX9unL9ZSnYkzol8faimBkQIQQbvI4DXBK5M3I3uMDANcz7j5S102qrjsskmcQSiuIBMldOQ8WOShRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me; spf=fail smtp.mailfrom=rcpassos.me; dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=O0L5eScF; arc=none smtp.client-ip=209.209.25.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=rcpassos.me
Received: from smtp-out.flockmail.com (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id D59E6140134;
	Sat, 15 Jun 2024 02:28:26 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=BkI70YSVQkL9NnOSiJwJmMwNFfsQfSwBhRvdgZXcvwM=;
	c=relaxed/relaxed; d=rcpassos.me;
	h=from:references:mime-version:subject:to:in-reply-to:cc:date:message-id:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1718418506; v=1;
	b=O0L5eScF9kjNsb+QD0Twa+4RYxZG4QkVVCCpZhdfWN9eo6gw7wILIygyp6oCfoRSgwBReNfj
	IjF97Ddbr9oeP6mPX4RHGj9ehn17PByRpxR4PKV2lIQVpZfBVq7Kd3zaKO3u4nxRkHtC70BCLTz
	8aKpnA7EtskMPhKu2ybED/uk=
Received: from darkforce.pihole.rcpassos.me (unknown [104.28.243.51])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 82B79140051;
	Sat, 15 Jun 2024 02:28:24 +0000 (UTC)
Feedback-ID: :rafael@rcpassos.me:rcpassos.me:flockmailId
From: Rafael Passos <rafael@rcpassos.me>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	puranjay@kernel.org,
	will@kernel.org,
	xi.wang@gmail.com,
	bjorn@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de
Cc: Rafael Passos <rafael@rcpassos.me>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next V2 1/3] bpf: remove unused parameter in bpf_jit_binary_pack_finalize
Date: Fri, 14 Jun 2024 23:24:08 -0300
Message-ID: <20240615022641.210320-2-rafael@rcpassos.me>
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
X-Titan-Src-Out: 1718418506743325457.23820.1194268936732658971@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=W6Y+VwWk c=1 sm=1 tr=0 ts=666cfc4a
	a=rO3HKV82O4ipXYUjDYeURw==:117 a=rO3HKV82O4ipXYUjDYeURw==:17
	a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=CEWIc4RMnpUA:10
	a=IHYL5owqxkw3MIL43fUA:9 a=---8k2CCGq07aBBJLGWX:22
X-Virus-Scanned: ClamAV using ClamSMTP

Fixes a compiler warning. the bpf_jit_binary_pack_finalize function
was taking an extra bpf_prog parameter that went unused.
This removves it and updates the callers accordingly.

Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---
 arch/arm64/net/bpf_jit_comp.c   | 3 +--
 arch/powerpc/net/bpf_jit_comp.c | 4 ++--
 arch/riscv/net/bpf_jit_core.c   | 5 ++---
 arch/x86/net/bpf_jit_comp.c     | 4 ++--
 include/linux/filter.h          | 3 +--
 kernel/bpf/core.c               | 3 +--
 6 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 720336d28856..6edaeafd1499 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1829,8 +1829,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			prog->jited_len = 0;
 			goto out_free_hdr;
 		}
-		if (WARN_ON(bpf_jit_binary_pack_finalize(prog, ro_header,
-							 header))) {
+		if (WARN_ON(bpf_jit_binary_pack_finalize(ro_header, header))) {
 			/* ro_header has been freed */
 			ro_header = NULL;
 			prog = orig_prog;
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 984655419da5..2a36cc2e7e9e 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -225,7 +225,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	fp->jited_len = proglen + FUNCTION_DESCR_SIZE;
 
 	if (!fp->is_func || extra_pass) {
-		if (bpf_jit_binary_pack_finalize(fp, fhdr, hdr)) {
+		if (bpf_jit_binary_pack_finalize(fhdr, hdr)) {
 			fp = org_fp;
 			goto out_addrs;
 		}
@@ -348,7 +348,7 @@ void bpf_jit_free(struct bpf_prog *fp)
 		 * before freeing it.
 		 */
 		if (jit_data) {
-			bpf_jit_binary_pack_finalize(fp, jit_data->fhdr, jit_data->hdr);
+			bpf_jit_binary_pack_finalize(jit_data->fhdr, jit_data->hdr);
 			kvfree(jit_data->addrs);
 			kfree(jit_data);
 		}
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 0a96abdaca65..6de753c667f4 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -178,8 +178,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	prog->jited_len = prog_size - cfi_get_offset();
 
 	if (!prog->is_func || extra_pass) {
-		if (WARN_ON(bpf_jit_binary_pack_finalize(prog, jit_data->ro_header,
-							 jit_data->header))) {
+		if (WARN_ON(bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header))) {
 			/* ro_header has been freed */
 			jit_data->ro_header = NULL;
 			prog = orig_prog;
@@ -258,7 +257,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 		 * before freeing it.
 		 */
 		if (jit_data) {
-			bpf_jit_binary_pack_finalize(prog, jit_data->ro_header, jit_data->header);
+			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
 			kfree(jit_data);
 		}
 		hdr = bpf_jit_binary_pack_hdr(prog);
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5159c7a22922..bd7e13602bf6 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3363,7 +3363,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			 *
 			 * Both cases are serious bugs and justify WARN_ON.
 			 */
-			if (WARN_ON(bpf_jit_binary_pack_finalize(prog, header, rw_header))) {
+			if (WARN_ON(bpf_jit_binary_pack_finalize(header, rw_header))) {
 				/* header has been freed */
 				header = NULL;
 				goto out_image;
@@ -3442,7 +3442,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 		 * before freeing it.
 		 */
 		if (jit_data) {
-			bpf_jit_binary_pack_finalize(prog, jit_data->header,
+			bpf_jit_binary_pack_finalize(jit_data->header,
 						     jit_data->rw_header);
 			kvfree(jit_data->addrs);
 			kfree(jit_data);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index b02aea291b7e..dd41a93f06b2 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1129,8 +1129,7 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **ro_image,
 			  struct bpf_binary_header **rw_hdr,
 			  u8 **rw_image,
 			  bpf_jit_fill_hole_t bpf_fill_ill_insns);
-int bpf_jit_binary_pack_finalize(struct bpf_prog *prog,
-				 struct bpf_binary_header *ro_header,
+int bpf_jit_binary_pack_finalize(struct bpf_binary_header *ro_header,
 				 struct bpf_binary_header *rw_header);
 void bpf_jit_binary_pack_free(struct bpf_binary_header *ro_header,
 			      struct bpf_binary_header *rw_header);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1a6c3faa6e4a..f6951c33790d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1174,8 +1174,7 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
 }
 
 /* Copy JITed text from rw_header to its final location, the ro_header. */
-int bpf_jit_binary_pack_finalize(struct bpf_prog *prog,
-				 struct bpf_binary_header *ro_header,
+int bpf_jit_binary_pack_finalize(struct bpf_binary_header *ro_header,
 				 struct bpf_binary_header *rw_header)
 {
 	void *ptr;
-- 
2.45.2


