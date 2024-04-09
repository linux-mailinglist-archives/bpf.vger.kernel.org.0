Return-Path: <bpf+bounces-26263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276E589D5F8
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 11:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CD61F242E4
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 09:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903648003B;
	Tue,  9 Apr 2024 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8aptbkz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D4280024;
	Tue,  9 Apr 2024 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656258; cv=none; b=WzcLmnxXwR/yNFQfjWE10irYFtYRoPeXY3MCe2B3BBXm2kROJHwjoWVBDAtET9Tux41CZHafSv4aBHNdZPM20atrY9VjLAUe0Jt0CICyDI44MgzmB7CQeEMbxKwYYHF1AwX5eAmNjJD08WsTUm4DUWMMHeqkgQKQO8u1lbcE2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656258; c=relaxed/simple;
	bh=Rbida/oaltsFG3OqFmrxLsFqLkt52ywYuO3hyKtFGgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BSALIdq/FpVurdUnHRkLrLAnLdx72r+lFmrlLlNpCddiuF+Ai8i+eDqJxf4lCY7rDQ4XL6n0gLsBmebSmq1eUqPVwt3rDv3BWg5uQhjraH5v7lwQzSxaY+vWcqVzKQgAkHRdSe0JNfIiGtCOm93elyfwLiRBsPvcvRzqXbR9Js8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8aptbkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417AEC433C7;
	Tue,  9 Apr 2024 09:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712656257;
	bh=Rbida/oaltsFG3OqFmrxLsFqLkt52ywYuO3hyKtFGgM=;
	h=From:To:Cc:Subject:Date:From;
	b=d8aptbkz2gcqP8K4pcd5Mzyi9KWRZNJSmkyd6/LZtZtpb+l8VyhEhyPLxXXViQgPt
	 2iY8/hpJvdSzN46KmIIpiSPOScQR/Xzp7z1pBp/yHnekqeqXFgBBzLrcIIrO2hvKYa
	 AQUoVUqKuFJWYXw/hvHquwF6j0Kje6a4+ytD5QDJTt+9tvLCbI93VpM0q8GYmk9did
	 fgZt80+Y64vcy5fJH9pVSLCRQE/cBKBAGztEDLPcTUHdtm35Bjdd4Ccub2b65X2Tld
	 aGY3v2Ma2LDBRtgaNlFtPQwih1I8XAeLYbIEtosZnqN3/5iEOAYvB6QNB7lS9y3Q58
	 HaW0SF+W3mYVg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf] arm32, bpf: Fix sign-extension mov instruction
Date: Tue,  9 Apr 2024 09:50:38 +0000
Message-ID: <20240409095038.26356-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of the mov instruction with sign extension
clobbers the source register because it sign extends the source and then
moves it to the destination.

Fix this by moving the src to a temporary register before doing the sign
extension only if src is not an emulated register (on the scratch stack).

Also fix the emit_a32_movsx_r64() to put the register back on scratch
stack if that register is emulated on stack.

Fixes: fc832653fa0d ("arm32, bpf: add support for sign-extension mov instruction")
Reported-by: syzbot+186522670e6722692d86@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000e9a8d80615163f2a@google.com/
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm/net/bpf_jit_32.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 1d672457d02f..8fde6ab66cb4 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -878,6 +878,13 @@ static inline void emit_a32_mov_r(const s8 dst, const s8 src, const u8 off,
 
 	rt = arm_bpf_get_reg32(src, tmp[0], ctx);
 	if (off && off != 32) {
+		/* If rt is not a stacked register, move it to tmp, so it doesn't get clobbered by
+		 * the shift operations.
+		 */
+		if (rt == src) {
+			emit(ARM_MOV_R(tmp[0], rt), ctx);
+			rt = tmp[0];
+		}
 		emit(ARM_LSL_I(rt, rt, 32 - off), ctx);
 		emit(ARM_ASR_I(rt, rt, 32 - off), ctx);
 	}
@@ -919,15 +926,15 @@ static inline void emit_a32_movsx_r64(const bool is64, const u8 off, const s8 ds
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	const s8 *rt;
 
-	rt = arm_bpf_get_reg64(dst, tmp, ctx);
-
 	emit_a32_mov_r(dst_lo, src_lo, off, ctx);
 	if (!is64) {
 		if (!ctx->prog->aux->verifier_zext)
 			/* Zero out high 4 bytes */
 			emit_a32_mov_i(dst_hi, 0, ctx);
 	} else {
+		rt = arm_bpf_get_reg64(dst, tmp, ctx);
 		emit(ARM_ASR_I(rt[0], rt[1], 31), ctx);
+		arm_bpf_put_reg64(dst, rt, ctx);
 	}
 }
 
-- 
2.40.1


