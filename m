Return-Path: <bpf+bounces-22015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F7885508F
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 18:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D911C292AB
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACB486634;
	Wed, 14 Feb 2024 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLTzfkA0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C596E8527B
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932466; cv=none; b=B25ZfsaPZyJST/8NNQgqQ5YKYz+q9kOtj+unJtM9uGo/T4lckeyPltmRR2qywTF4z/ArWIXgOzUoyGmKYvvkejYWsFIEfwKes/2dZglK5kb8D3etqEjYVyHcdaLGITjPpSOY56md0NUw7uI/0Jow6MWKgLf5VfD5Cr/Df/wG+lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932466; c=relaxed/simple;
	bh=btWyZeKqUEPAusEEv6qMCONeZN32RnSHUx4v/zijVEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=stndGxGR1BxEBTyy27yJnhi0bRHRDFBXu4zyX887s2h4F7UJp78MrzpOWfUVi6hyyiIlRBR5oHHye5ivwXxsz6JYv9mzXuxUpQlzK/WlXvMbov0Mu2XuN60pSZ8K15+q421bk+xntbhgSjuEgnVI0Croajr81SNKZMxFIcToh5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLTzfkA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45266C433F1;
	Wed, 14 Feb 2024 17:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707932466;
	bh=btWyZeKqUEPAusEEv6qMCONeZN32RnSHUx4v/zijVEg=;
	h=From:To:Cc:Subject:Date:From;
	b=YLTzfkA0HsgTnjn/0yUkr3ES98BP0wub/KeS1AmOfo/cH/rDUA3Z12bLr/neHKOJQ
	 WGUnEX/kBub70hettKax+xXHplCsOqbhQp22Wx+FJdgm6lzFJkR7F93FE1XHnJiN3v
	 nKUtaUtDL5FwhAtP5BKp5a7uIKePJdV+4RIPxn0m2IFtlLm+wfgbiUA0KE+67iec9L
	 lhL47S7GJq84s7Sx92y5ImBeQ8CDS2jhoSjhPM9VJXC5AY/iyP+WXzMPYeCgei/UeH
	 v8CT+DWpoAaAtoHjaAD2gH4uvumQp2FyTN/MmkNSIVNW0jillzAZcRLOMiTU2Pk96x
	 GfLB1sZ1C++YA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: improve duplicate source code line detection
Date: Wed, 14 Feb 2024 09:41:00 -0800
Message-Id: <20240214174100.2847419-1-andrii@kernel.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verifier log avoids printing the same source code line multiple times
when a consecutive block of BPF assembly instructions are covered by the
same original (C) source code line. This greatly improves verifier log
legibility.

Unfortunately, this check is imperfect and in production applications it
quite often happens that verifier log will have multiple duplicated
source lines emitted, for no apparently good reason. E.g., this is
excerpt from a real-world BPF application (with register states omitted
for clarity):

BEFORE
======
; for (int i = 0; i < STROBE_MAX_MAP_ENTRIES; ++i) { @ strobemeta_probe.bpf.c:394
5369: (07) r8 += 2                    ;
5370: (07) r7 += 16                   ;
; for (int i = 0; i < STROBE_MAX_MAP_ENTRIES; ++i) { @ strobemeta_probe.bpf.c:394
5371: (07) r9 += 1                    ;
5372: (79) r4 = *(u64 *)(r10 -32)     ;
; for (int i = 0; i < STROBE_MAX_MAP_ENTRIES; ++i) { @ strobemeta_probe.bpf.c:394
5373: (55) if r9 != 0xf goto pc+2
; if (i >= map->cnt) @ strobemeta_probe.bpf.c:396
5376: (79) r1 = *(u64 *)(r10 -40)     ;
5377: (79) r1 = *(u64 *)(r1 +8)       ;
; if (i >= map->cnt) @ strobemeta_probe.bpf.c:396
5378: (dd) if r1 s<= r9 goto pc-5     ;
; descr->key_lens[i] = 0; @ strobemeta_probe.bpf.c:398
5379: (b4) w1 = 0                     ;
5380: (6b) *(u16 *)(r8 -30) = r1      ;
; task, data, off, STROBE_MAX_STR_LEN, map->entries[i].key); @ strobemeta_probe.bpf.c:400
5381: (79) r3 = *(u64 *)(r7 -8)       ;
5382: (7b) *(u64 *)(r10 -24) = r6     ;
; task, data, off, STROBE_MAX_STR_LEN, map->entries[i].key); @ strobemeta_probe.bpf.c:400
5383: (bc) w6 = w6                    ;
; barrier_var(payload_off); @ strobemeta_probe.bpf.c:280
5384: (bf) r2 = r6                    ;
5385: (bf) r1 = r4                    ;

As can be seen, line 394 is emitted thrice, 396 is emitted twice, and
line 400 is duplicated as well. Note that there are no intermingling
other lines of source code in between these duplicates, so the issue is
not compiler reordering assembly instruction such that multiple original
source code lines are in effect.

It becomes more obvious what's going on if we look at *full* original line info
information (using btfdump for this, [0]):

  #2764: line: insn #5363 --> 394:3 @ ./././strobemeta_probe.bpf.c
            for (int i = 0; i < STROBE_MAX_MAP_ENTRIES; ++i) {
  #2765: line: insn #5373 --> 394:21 @ ./././strobemeta_probe.bpf.c
            for (int i = 0; i < STROBE_MAX_MAP_ENTRIES; ++i) {
  #2766: line: insn #5375 --> 394:47 @ ./././strobemeta_probe.bpf.c
            for (int i = 0; i < STROBE_MAX_MAP_ENTRIES; ++i) {
  #2767: line: insn #5377 --> 394:3 @ ./././strobemeta_probe.bpf.c
            for (int i = 0; i < STROBE_MAX_MAP_ENTRIES; ++i) {
  #2768: line: insn #5378 --> 414:10 @ ./././strobemeta_probe.bpf.c
            return off;

We can see that there are four line info records covering
instructions #5363 through #5377 (instruction indices are shifted due to
subprog instruction being appended to main program), all of them are
pointing to the same C source code line #394. But each of them points to
a different part of that line, which is denoted by differing column
numbers (3, 21, 47, 3).

But verifier log doesn't distinguish between parts of the same source code line
and doesn't emit this column number information, so for end user it's just a
repetitive visual noise. So let's improve the detection of repeated source code
line and avoid this.

With the changes in this patch, we get this output for the same piece of BPF
program log:

AFTER
=====
; for (int i = 0; i < STROBE_MAX_MAP_ENTRIES; ++i) { @ strobemeta_probe.bpf.c:394
5369: (07) r8 += 2                    ;
5370: (07) r7 += 16                   ;
5371: (07) r9 += 1                    ;
5372: (79) r4 = *(u64 *)(r10 -32)     ;
5373: (55) if r9 != 0xf goto pc+2
; if (i >= map->cnt) @ strobemeta_probe.bpf.c:396
5376: (79) r1 = *(u64 *)(r10 -40)     ;
5377: (79) r1 = *(u64 *)(r1 +8)       ;
5378: (dd) if r1 s<= r9 goto pc-5     ;
; descr->key_lens[i] = 0; @ strobemeta_probe.bpf.c:398
5379: (b4) w1 = 0                     ;
5380: (6b) *(u16 *)(r8 -30) = r1      ;
; task, data, off, STROBE_MAX_STR_LEN, map->entries[i].key); @ strobemeta_probe.bpf.c:400
5381: (79) r3 = *(u64 *)(r7 -8)       ;
5382: (7b) *(u64 *)(r10 -24) = r6     ;
5383: (bc) w6 = w6                    ;
; barrier_var(payload_off); @ strobemeta_probe.bpf.c:280
5384: (bf) r2 = r6                    ;
5385: (bf) r1 = r4                    ;

All the duplication is gone and the log is cleaner and less distracting.

  [0] https://github.com/anakryiko/btfdump

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/log.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index cc789efc7f43..c702c3a42958 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -362,15 +362,28 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
 				  u32 insn_off,
 				  const char *prefix_fmt, ...)
 {
-	const struct bpf_line_info *linfo;
+	const struct bpf_line_info *linfo, *prev_linfo;
 	const struct btf *btf;
 	const char *s, *fname;
 
 	if (!bpf_verifier_log_needed(&env->log))
 		return;
 
+	prev_linfo = env->prev_linfo;
 	linfo = find_linfo(env, insn_off);
-	if (!linfo || linfo == env->prev_linfo)
+	if (!linfo || linfo == prev_linfo)
+		return;
+
+	/* It often happens that two separate linfo records point to the same
+	 * source code line, but have differing column numbers. Given verifier
+	 * log doesn't emit column information, from user perspective we just
+	 * end up emitting the same source code line twice unnecessarily.
+	 * So instead check that previous and current linfo record point to
+	 * the same file (file_name_offs match) and the same line number, and
+	 * avoid emitting duplicated source code line in such case.
+	 */
+	if (prev_linfo && linfo->file_name_off == prev_linfo->file_name_off &&
+	    BPF_LINE_INFO_LINE_NUM(linfo->line_col) == BPF_LINE_INFO_LINE_NUM(prev_linfo->line_col))
 		return;
 
 	if (prefix_fmt) {
-- 
2.39.3


