Return-Path: <bpf+bounces-48773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E00AA10861
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 15:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67EB4168D23
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 14:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DC213D520;
	Tue, 14 Jan 2025 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8LsWrLK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF566132C38;
	Tue, 14 Jan 2025 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863362; cv=none; b=lFn/TsAa5PgmwVNz6SlTI0bCXSVsoiW+H9u4mGf0/jwy3ME2o0HOP4PyYGtvGGuOoT15A16M3XWm9jgnUTiH/xLUw91ic5ffylsSoQQQiH4xpLbBEFYtpPljHSZOBMUcp/WIx+TgdVGstdRK7oC7yE4jofOLbJlqQpBu0Fbn5hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863362; c=relaxed/simple;
	bh=qSiSyz0nz58Pw8DcYBJ6s3CMd++11JYIbNRxyePh+KA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O69C62GHtE+1rk3uNGvoD1Gr/KYgmPz+RB0DF+YG+WYPryGiCY/gN2XqVixIh/gpjjHG9QfezaKpoYFDTWX1sUs0VGePbE2FIB8H6ibSGloh3LJKj1wD6dWU3/YVQmFHKXS8Wv07Idz9ob+UxYYMRxY3nqunuSBL71gmDiZ58I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8LsWrLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AACC4CEE1;
	Tue, 14 Jan 2025 14:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736863361;
	bh=qSiSyz0nz58Pw8DcYBJ6s3CMd++11JYIbNRxyePh+KA=;
	h=From:To:Cc:Subject:Date:From;
	b=B8LsWrLK7da58elU8aMXNmfT7+w85czlSzHAPLoBS9Qoj0iT4FpPh4thdlvZpq5C/
	 5VXb32LdAkoOX03OeL4lAeu6PIZO2qj+vdIiZmYecMi7nzX34ulrcygP3jvE8XbB/K
	 hV5rANh4Z1K55nhf8BUNbWDTS5sQe7kxfehuW446zDfoQmSAvlYWQaaBXR0kukuwyE
	 PrbH/3WhTwKjbD2bfdhMRtBKXNdUaeOsIbt7z//F4e6naPFvjopHyVcyxFeU5Y5M2S
	 ao5WbS86T/pWn0+sLxBuu0IMsDcd9Jqxle8JJCHpbPNT2TRuP7xCVUDCxta6MQ+H+r
	 9Vplh/kxTImrQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	David Laight <David.Laight@ACULAB.COM>,
	Peter Zijlstra <peterz@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	x86@kernel.org
Subject: [RFC] x86/alternatives: Merge first and second step in text_poke_bp_batch
Date: Tue, 14 Jan 2025 15:02:37 +0100
Message-ID: <20250114140237.3506624-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
while checking on similar code for uprobes I was wondering if we
can merge first 2 steps of instruction update in text_poke_bp_batch
function.

Basically the first step now would be to write int3 byte together
with the rest of the bytes of the new instruction instead of doing
that separately. And the second step would be to overwrite int3
byte with first byte of the new instruction.

Would that work or do I miss some x86 detail that could lead to crash?

I tried to hack it together in attached patch and it speeds up a bit
text_poke_bp_batch as shown below.

thoughts? thanks,
jirka


---
  # cat ~/test.sh
  for i in `seq 1 50`; do echo function > current_tracer ; echo nop > current_tracer ; done

current code:

  # perf stat -e cycles:k,instructions:k -a --  ~jolsa/test.sh

   Performance counter stats for 'system wide':

     158,872,470,494      cycles:k
      61,529,351,096      instructions:k                   #    0.39  insn per cycle

        12.847083584 seconds time elapsed

with the change below:

  # perf stat -e cycles:k,instructions:k -a --  ~jolsa/test.sh

   Performance counter stats for 'system wide':

     105,687,644,963      cycles:k
      45,981,957,996      instructions:k                   #    0.44  insn per cycle

        10.011825294 seconds time elapsed
---
 arch/x86/kernel/alternative.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 243843e44e89..99830e9cd641 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2125,9 +2125,9 @@ struct text_poke_loc {
 	s32 disp;
 	u8 len;
 	u8 opcode;
-	const u8 text[POKE_MAX_OPCODE_SIZE];
+	u8 text[POKE_MAX_OPCODE_SIZE];
 	/* see text_poke_bp_batch() */
-	u8 old;
+	u8 first;
 };
 
 struct bp_patching_desc {
@@ -2282,7 +2282,6 @@ static int tp_vec_nr;
  */
 static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
 {
-	unsigned char int3 = INT3_INSN_OPCODE;
 	unsigned int i;
 	int do_sync;
 
@@ -2313,29 +2312,20 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 */
 	smp_wmb();
 
-	/*
-	 * First step: add a int3 trap to the address that will be patched.
-	 */
-	for (i = 0; i < nr_entries; i++) {
-		tp[i].old = *(u8 *)text_poke_addr(&tp[i]);
-		text_poke(text_poke_addr(&tp[i]), &int3, INT3_INSN_SIZE);
-	}
-
-	text_poke_sync();
-
 	/*
 	 * Second step: update all but the first byte of the patched range.
 	 */
 	for (do_sync = 0, i = 0; i < nr_entries; i++) {
-		u8 old[POKE_MAX_OPCODE_SIZE+1] = { tp[i].old, };
+		u8 old[POKE_MAX_OPCODE_SIZE+1];
 		u8 _new[POKE_MAX_OPCODE_SIZE+1];
 		const u8 *new = tp[i].text;
 		int len = tp[i].len;
 
+		tp[i].first = tp[i].text[0];
+		tp[i].text[0] = (u8) INT3_INSN_OPCODE;
+
 		if (len - INT3_INSN_SIZE > 0) {
-			memcpy(old + INT3_INSN_SIZE,
-			       text_poke_addr(&tp[i]) + INT3_INSN_SIZE,
-			       len - INT3_INSN_SIZE);
+			memcpy(old, text_poke_addr(&tp[i]), len);
 
 			if (len == 6) {
 				_new[0] = 0x0f;
@@ -2343,9 +2333,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 				new = _new;
 			}
 
-			text_poke(text_poke_addr(&tp[i]) + INT3_INSN_SIZE,
-				  new + INT3_INSN_SIZE,
-				  len - INT3_INSN_SIZE);
+			text_poke(text_poke_addr(&tp[i]), new, len);
 
 			do_sync++;
 		}
@@ -2391,7 +2379,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * replacing opcode.
 	 */
 	for (do_sync = 0, i = 0; i < nr_entries; i++) {
-		u8 byte = tp[i].text[0];
+		u8 byte = tp[i].first;
 
 		if (tp[i].len == 6)
 			byte = 0x0f;
-- 
2.47.0


