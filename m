Return-Path: <bpf+bounces-32230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B59909956
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 19:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A4628335C
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 17:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32BD481B3;
	Sat, 15 Jun 2024 17:46:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FF611CAF
	for <bpf@vger.kernel.org>; Sat, 15 Jun 2024 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718473606; cv=none; b=MxLlWtSmaV0kMcASGHcO9OUhJzwrr3tJznQsvgjT55cgeRsUS1Om1pzROT34LWmN4S8jX2GTWvwbQrFUJfFjnlE/DhmMPAUfI6hubby7twSnTkxBPjKb84xwnlAX0Yba1/cLuA2Y+Z+E0tPqFBGtpK0/MWuv0vZXm3gWExM/o04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718473606; c=relaxed/simple;
	bh=zmn2dsgzP03pujXrBlF5G5PYkKIr5SiivYYaYAnw6DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRrpxmxj6T+ZJoXebwd7PmWZ9KY72eZTkVwKK4BnPRQFi6DOOYaZgTujO+YvrwPKJZK4++XBQiY/8o11l9oSXWqDGksPJwI9Gjsk9HXh8ZO9rWXsNy1J9gzhw8jzI+Hd0rs9/FZuaJy3nIskNzpKeJMl7M5zWcq3tsVGtIiCgrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 142BD58024D1; Sat, 15 Jun 2024 10:46:32 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf 2/3] bpf: Add missed var_off setting in coerce_subreg_to_size_sx()
Date: Sat, 15 Jun 2024 10:46:32 -0700
Message-ID: <20240615174632.3995278-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240615174621.3994321-1-yonghong.song@linux.dev>
References: <20240615174621.3994321-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In coerce_subreg_to_size_sx(), for the case where upper
sign extension bits are the same for smax32 and smin32
values, we missed to setup properly. This is especially
problematic if both smax32 and smin32's sign extension
bits are 1.

The following is a simple example illustrating the inconsistent
verifier states due to missed var_off:

  0: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
  1: (bf) r3 =3D r0                       ; R0_w=3Dscalar(id=3D1) R3_w=3D=
scalar(id=3D1)
  2: (57) r3 &=3D 15                      ; R3_w=3Dscalar(smin=3Dsmin32=3D=
0,smax=3Dumax=3Dsmax32=3Dumax32=3D15,var_off=3D(0x0; 0xf))
  3: (47) r3 |=3D 128                     ; R3_w=3Dscalar(smin=3Dumin=3Ds=
min32=3Dumin32=3D128,smax=3Dumax=3Dsmax32=3Dumax32=3D143,var_off=3D(0x80;=
 0xf))
  4: (bc) w7 =3D (s8)w3
  REG INVARIANTS VIOLATION (alu): range bounds violation u64=3D[0xffffff8=
0, 0x8f] s64=3D[0xffffff80, 0x8f]
    u32=3D[0xffffff80, 0x8f] s32=3D[0x80, 0xffffff8f] var_off=3D(0x80, 0x=
f)

The var_off=3D(0x80, 0xf) is not correct, and the correct one should
be var_off=3D(0xffffff80; 0xf) since from insn 3, we know that at
insn 4, the sign extension bits will be 1. This patch fixed this
issue by setting var_off properly.

Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 904ef5a03cf5..e0a398a97d32 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6281,6 +6281,7 @@ static void coerce_subreg_to_size_sx(struct bpf_reg=
_state *reg, int size)
 		reg->s32_max_value =3D s32_max;
 		reg->u32_min_value =3D (u32)s32_min;
 		reg->u32_max_value =3D (u32)s32_max;
+		reg->var_off =3D tnum_subreg(tnum_range(s32_min, s32_max));
 		return;
 	}
=20
--=20
2.43.0


