Return-Path: <bpf+bounces-64499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BE5B1385D
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 11:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F419188388A
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 09:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C3D2153C1;
	Mon, 28 Jul 2025 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuZROGzC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954071D6AA
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753696296; cv=none; b=QZEvI9dhf2UpQdTyyno1Z49dwF3Ndupb/wyqXtUpnTSgXxqCb8SeuWajU62CKiKbzvblfTDVMsVqcz3/63BbR8ZoxvB6Ih8tViNTUlEK/7cL4byQHJVTk5f73wEUAs1gjCHr31sIn05bZyjGJtulAIiwHf69YAgdOuIXe8Vx2XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753696296; c=relaxed/simple;
	bh=azvxjh91eabga4PSBNlg0F5aU/Pw4WGxe3sfJ0haWRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPyT7eDz9A8h76zRbELViGQEK7tcBzRYZl89TGJtEFZC8QIXAhYkU8SapoWOOEk/xnt4pnOS+pMPLsYlR2ALNsQ9z6yRPspv5+GAbFWs19HpAuyY5uVkvOAdRA9JsjlwbwQvds3Pbr/cARDchXOjB9l4bEG0KvQQ0vXNnpIPsvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuZROGzC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b780bdda21so1843951f8f.3
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 02:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753696293; x=1754301093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8QJrMAZbOkDUi6iUPVElL+487Mi3ATnNf0Lc6z34PRY=;
        b=GuZROGzCEEEY1JszAuMKHW86bYatt5zDZH4OqOL9XW0SIkq70Uza4FjPEwVQ13U42F
         t+fl+72bFvLIPBE6+8Y54Ny2VsNT7slh9PcrKrlJUDM+DQ7ezIbtBSpYpBmSOU6Zt0Lh
         iF6y/V5WVbJHWv47xxOHvV/7vjwqWv+GwIYzSV+oqqEVnoGbGhsTlSxBCuvULr+Fyyad
         XRTpxqOrpIFBlHUrZfykRfCgnq917Y+kn+AZ8Rm04z9SNdynVvJ04nK/r44qhMtlBx+d
         3adLWjFbXcX2iY3DZYk7vHIOlcwAKRq04O+Mq70uPuHRihnW1PiRQlb9g+DTXed9N6x3
         PiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753696293; x=1754301093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QJrMAZbOkDUi6iUPVElL+487Mi3ATnNf0Lc6z34PRY=;
        b=cpHmJfJva16vCjo3LGPAtgRI6VtIKtr+MIjVX9uxg4bthXCiyK7obGZuiJkvZeUb6o
         rLiSbdeawOWqfNK7uE/Q5K9lPpqUjwt4nFyRpSjywGrq5pRJ5W7DxWxR8e2ky4RJCRa9
         lgJetRuyarbwOeTJB01jWU51UFYy3Rf5NRUJNddN58k4CLSXxrO1WjinvopwHt4lmWij
         kFB9fBGbOCYfZgokGJN4B3rxJwLjmC4S+SNqmtDIHuubzriRsEMJVp3jMi16xtZ09RxW
         xTB3IUXM+IQLJJDUjm1i0om1m/nNKVVqguHRo8q0Y/O6e2HPmznabyBvRC5uTebAsW0S
         wAWA==
X-Gm-Message-State: AOJu0YxzK/n5m6JgIXoyA/wtZ3ywdttqwdA/nEzhqzmqVy/ZUaPO6zwG
	pWWbTj+JUwWIqz/GqDQWX3eIy7CAwaYlPXbsTo3CUA7+OlCDhFZT4sRJOp3lJS4A
X-Gm-Gg: ASbGncsAQoABPwvUZT7Tzxw3OvcX8pbEdIIZ/gwT/8Hd67Y2eSqqmNJKTw/+nzaITTj
	LUVhnmvHZEb1+EXKyn/4d1kZ9gf7GC+Ls6CsEWRULbH428BfgTisy0UrfOex06+7An5Gu4DDDvs
	6QzZ4syvwXdWyO30mloEmRpwka8Rj6d+yWf9p7pgrEm0tR5TcOxhjOnB6wfo9KK/xu4auDah6td
	kdLNEbkSr65P5jYLkFOnfbSIDJgxg2w5TvkTSXb+AWuq5/JXeQGcDHpMh3YTZ1bITJVJmZ6VBT8
	MBPcQftqF92aU/joKqNvPW7oxr5MJ44xva8hvbcodizYFFBAwE3BARXZX1xpMlsAsdwT5MV7hsx
	+Ke2OgZlHPcZcGBW53XzGMljLVnMyl5yjOU5TQNEfmCQH0UO8KrM7WT+CcQJOcdmAIszJ3P0oA1
	HpKisqnN3CAvLMEVf+XuJwgdJV2T+lYQ==
X-Google-Smtp-Source: AGHT+IHVHBT6Xukt3gp2aFANC+Knd+DlRadxKhhrp6hJ487AHt//wGxW6f86AQldRYkq7gwGpNGQHg==
X-Received: by 2002:a05:6000:1ac6:b0:3b7:7617:f732 with SMTP id ffacd0b85a97d-3b7767657e2mr8300126f8f.39.1753696292590;
        Mon, 28 Jul 2025 02:51:32 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00616c0b53953fa0e3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:616c:b53:953f:a0e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586ec79441sm111344055e9.2.2025.07.28.02.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:51:32 -0700 (PDT)
Date: Mon, 28 Jul 2025 11:51:30 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v4 3/5] selftests/bpf: Test cross-sign 64bits range
 refinement
Message-ID: <a0e17b00dab8dabcfa6f8384e7e151186efedfdd.1753695655.git.paul.chaignon@gmail.com>
References: <cover.1753695655.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753695655.git.paul.chaignon@gmail.com>

This patch adds coverage for the new cross-sign 64bits range refinement
logic. The three tests cover the cases when the u64 and s64 ranges
overlap (1) in the negative portion of s64, (2) in the positive portion
of s64, and (3) in both portions.

The first test is a simplified version of a BPF program generated by
syzkaller that caused an invariant violation [1]. It looks like
syzkaller could not extract the reproducer itself (and therefore didn't
report it to the mailing list), but I was able to extract it from the
console logs of a crash.

The principle is similar to the invariant violation described in
commit 6279846b9b25 ("bpf: Forget ranges when refining tnum after
JSET"): the verifier walks a dead branch, uses the condition to refine
ranges, and ends up with inconsistent ranges. In this case, the dead
branch is when we fallthrough on both jumps. The new refinement logic
improves the bounds such that the second jump is properly detected as
always-taken and the verifier doesn't end up walking a dead branch.

The second and third tests are inspired by the first, but rely on
condition jumps to prepare the bounds instead of ALU instructions. An
R10 write is used to trigger a verifier error when the bounds can't be
refined.

Link: https://syzkaller.appspot.com/bug?extid=c711ce17dd78e5d4fdcf [1]
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 63b533ca4933..41f4389e08c7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1550,4 +1550,122 @@ l0_%=:	r0 = 0;				\
 	: __clobber_all);
 }
 
+/* This test covers the bounds deduction on 64bits when the s64 and u64 ranges
+ * overlap on the negative side. At instruction 7, the ranges look as follows:
+ *
+ * 0          umin=0xfffffcf1                 umax=0xff..ff6e  U64_MAX
+ * |                [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]        |
+ * |----------------------------|------------------------------|
+ * |xxxxxxxxxx]                                   [xxxxxxxxxxxx|
+ * 0    smax=0xeffffeee                       smin=-655        -1
+ *
+ * We should therefore deduce the following new bounds:
+ *
+ * 0                             u64=[0xff..ffd71;0xff..ff6e]  U64_MAX
+ * |                                              [xxx]        |
+ * |----------------------------|------------------------------|
+ * |                                              [xxx]        |
+ * 0                                        s64=[-655;-146]    -1
+ *
+ * Without the deduction cross sign boundary, we end up with an invariant
+ * violation error.
+ */
+SEC("socket")
+__description("bounds deduction cross sign boundary, negative overlap")
+__success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
+__msg("7: (1f) r0 -= r6 {{.*}} R0=scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))")
+__retval(0)
+__naked void bounds_deduct_negative_overlap(void)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	w3 = w0;			\
+	w6 = (s8)w0;			\
+	r0 = (s8)r0;			\
+	if w6 >= 0xf0000000 goto l0_%=;	\
+	r0 += r6;			\
+	r6 += 400;			\
+	r0 -= r6;			\
+	if r3 < r0 goto l0_%=;		\
+l0_%=:	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test covers the bounds deduction on 64bits when the s64 and u64 ranges
+ * overlap on the positive side. At instruction 3, the ranges look as follows:
+ *
+ * 0 umin=0                      umax=0xffffffffffffff00       U64_MAX
+ * [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]            |
+ * |----------------------------|------------------------------|
+ * |xxxxxxxx]                                         [xxxxxxxx|
+ * 0      smax=127                                smin=-128    -1
+ *
+ * We should therefore deduce the following new bounds:
+ *
+ * 0  u64=[0;127]                                              U64_MAX
+ * [xxxxxxxx]                                                  |
+ * |----------------------------|------------------------------|
+ * [xxxxxxxx]                                                  |
+ * 0  s64=[0;127]                                              -1
+ *
+ * Without the deduction cross sign boundary, the program is rejected due to
+ * the frame pointer write.
+ */
+SEC("socket")
+__description("bounds deduction cross sign boundary, positive overlap")
+__success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
+__msg("3: (2d) if r0 > r1 {{.*}} R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=127,var_off=(0x0; 0x7f))")
+__retval(0)
+__naked void bounds_deduct_positive_overlap(void)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	r0 = (s8)r0;			\
+	r1 = 0xffffffffffffff00;	\
+	if r0 > r1 goto l0_%=;		\
+	if r0 < 128 goto l0_%=;		\
+	r10 = 0;			\
+l0_%=:	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test is the same as above, but the s64 and u64 ranges overlap in two
+ * places. At instruction 3, the ranges look as follows:
+ *
+ * 0 umin=0                           umax=0xffffffffffffff80  U64_MAX
+ * [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]        |
+ * |----------------------------|------------------------------|
+ * |xxxxxxxx]                                         [xxxxxxxx|
+ * 0      smax=127                                smin=-128    -1
+ *
+ * 0xffffffffffffff80 = (u64)-128. We therefore can't deduce anything new and
+ * the program should fail due to the frame pointer write.
+ */
+SEC("socket")
+__description("bounds deduction cross sign boundary, two overlaps")
+__failure __flag(BPF_F_TEST_REG_INVARIANTS)
+__msg("3: (2d) if r0 > r1 {{.*}} R0_w=scalar(smin=smin32=-128,smax=smax32=127,umax=0xffffffffffffff80)")
+__msg("frame pointer is read only")
+__naked void bounds_deduct_two_overlaps(void)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	r0 = (s8)r0;			\
+	r1 = 0xffffffffffffff80;	\
+	if r0 > r1 goto l0_%=;		\
+	if r0 < 128 goto l0_%=;		\
+	r10 = 0;			\
+l0_%=:	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


