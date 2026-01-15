Return-Path: <bpf+bounces-79062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8C9D253D7
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 16:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EAEF30C7BB2
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 15:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D36E3AE6F5;
	Thu, 15 Jan 2026 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHyXTsEC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94A03ACA5C
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768489916; cv=none; b=UnSihWx4H0dIXD3ni8ja1JEedEbXhEcMjZvVwcS9M/k9SyiKAn/fuJ1Ayg1myLSXVEU9pGpbFLiZ98Q66gY6Rwv9GGghxnxO3rzNedAVyoUtFdjmuBoRKf6UH4kODJzWZ0syTHX3oQXK3SmlV/oZV4JQwPb6qlddROqcwakRol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768489916; c=relaxed/simple;
	bh=yOl3JsGDYhtKv5TIWwrEijEOhNXgYJP4Sk8EBl133mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eShnqy7GeTfLFou4+AKYVmGSwOrSDj6b2pmuaNCdhAEqvSFChFAC1bcJTZ1HW0cYSoACPZHn17pZN844xFYZYHmRAdU8sRaHba0HNRst1P6mED0XbZgpYYV2X2ZImkfVIkCAfzELoQyysGp1D/cskO80imHV3KcuGyyQjBh47Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHyXTsEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E63C116D0;
	Thu, 15 Jan 2026 15:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768489915;
	bh=yOl3JsGDYhtKv5TIWwrEijEOhNXgYJP4Sk8EBl133mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qHyXTsECVPRx0FehSXKsGMPXlYE6JhXehUY1fbOB5MbcExKs3rZ/YYOb6aDF5OhqT
	 NJTcAH3Pw2DJKaJee73T070DwvztPhFazAPoR0zZwiNljTceqA6pXRA1PPC02SPF2D
	 dkbx695VwoLrWPd6fBEmKD524bNwkwKo+1z2kBTY+lgkGF/nQ40eiksBITn4QDq3/D
	 BdlU2HoHHDr+cSRezNgBE+fv7nZzJSxLbNE8tLgHxEm+9w+XKR8cE9W3Dy+p6n6C3X
	 XxOOOIXCii1jNKhgCmvTY5SCE0SJQ6fbPlBA7rXTaiVoJJXpOjLlaEWCnte0tNg88C
	 eohCv7RCPMWZQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/2] bpf: Preserve id of register in sync_linked_regs()
Date: Thu, 15 Jan 2026 07:11:40 -0800
Message-ID: <20260115151143.1344724-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115151143.1344724-1-puranjay@kernel.org>
References: <20260115151143.1344724-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sync_linked_regs() copies the id of known_reg to reg when propagating
bounds of known_reg to reg using the off of known_reg, but when
known_reg was linked to reg like:

known_reg = reg         ; both known_reg and reg get same id
known_reg += 4          ; known_reg gets off = 4, and its id gets BPF_ADD_CONST

now when a call to sync_linked_regs() happens, let's say with the following:

if known_reg >= 10 goto pc+2

known_reg's new bounds are propagated to reg but now reg gets
BPF_ADD_CONST from the copy.

This means if another link to reg is created like:

another_reg = reg       ; another_reg should get the id of reg but
                          assign_scalar_id_before_mov() sees
                          BPF_ADD_CONST on reg and assigns a new id to it.

As reg has a new id now, known_reg's link to reg is broken. If we find
new bounds for known_reg, they will not be propagated to reg.

This can be seen in the selftest added in the next commit:

0: (85) call bpf_get_prandom_u32#7    ; R0=scalar()
1: (57) r0 &= 255                     ; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
2: (bf) r1 = r0                       ; R0=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff)) R1=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
3: (07) r1 += 4                       ; R1=scalar(id=1+4,smin=umin=smin32=umin32=4,smax=umax=smax32=umax32=259,var_off=(0x0; 0x1ff))
4: (a5) if r1 < 0xa goto pc+4         ; R1=scalar(id=1+4,smin=umin=smin32=umin32=10,smax=umax=smax32=umax32=259,var_off=(0x0; 0x1ff))
5: (bf) r2 = r0                       ; R0=scalar(id=2,smin=umin=smin32=umin32=6,smax=umax=smax32=umax32=255) R2=scalar(id=2,smin=umin=smin32=umin32=6,smax=umax=smax32=umax32=255)
6: (a5) if r1 < 0xe goto pc+2         ; R1=scalar(id=1+4,smin=umin=smin32=umin32=14,smax=umax=smax32=umax32=259,var_off=(0x0; 0x1ff))
7: (35) if r0 >= 0xa goto pc+1        ; R0=scalar(id=2,smin=umin=smin32=umin32=6,smax=umax=smax32=umax32=9,var_off=(0x0; 0xf))
8: (37) r0 /= 0
div by zero

When 4 is verified, r1's bounds are propagated to r0 but r0 also gets
BPF_ADD_CONST (bug).
When 5 is verified, r0 gets a new id (2) and its link with r1 is broken.

After 6 we know r1 has bounds [14, 259] and therefore r0 should have
bounds [10, 255], therefore the branch at 7 is always taken. But because
r0's id was changed to 2, r1's new bounds are not propagated to r0.
The verifier still thinks r0 has bounds [6, 255] before 7 and execution
can reach div by zero.

Fix this by preserving id in sync_linked_regs() like off and subreg_def.

Fixes: 98d7ca374ba4 ("bpf: Track delta between "linked" registers.")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7a375f608263..9de0ec0c3ed9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16871,6 +16871,7 @@ static void sync_linked_regs(struct bpf_verifier_state *vstate, struct bpf_reg_s
 		} else {
 			s32 saved_subreg_def = reg->subreg_def;
 			s32 saved_off = reg->off;
+			u32 saved_id = reg->id;
 
 			fake_reg.type = SCALAR_VALUE;
 			__mark_reg_known(&fake_reg, (s32)reg->off - (s32)known_reg->off);
@@ -16878,10 +16879,11 @@ static void sync_linked_regs(struct bpf_verifier_state *vstate, struct bpf_reg_s
 			/* reg = known_reg; reg += delta */
 			copy_register_state(reg, known_reg);
 			/*
-			 * Must preserve off, id and add_const flag,
+			 * Must preserve off, id and subreg_def flag,
 			 * otherwise another sync_linked_regs() will be incorrect.
 			 */
 			reg->off = saved_off;
+			reg->id = saved_id;
 			reg->subreg_def = saved_subreg_def;
 
 			scalar32_min_max_add(reg, &fake_reg);
-- 
2.47.3


