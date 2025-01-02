Return-Path: <bpf+bounces-47757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2756C9FFF01
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323701883AB2
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 19:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3CA1B4236;
	Thu,  2 Jan 2025 18:59:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3881922D3;
	Thu,  2 Jan 2025 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844387; cv=none; b=j/Gx8xO/n3WFvB3eEknQgOZO20vFT4rvSVlVcislMvcSu4UD6mJr1s/CBDLxqrm1RacMqcE9Xnmm5wBF4tIn0jk4uX6KjLX2UhhIsC+ykMKgINbHmEGhqaAn2EvozNYhdbgsdasB+Vy2FsimfRYH+/gQDkoVMBbxHvTg4MUEs6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844387; c=relaxed/simple;
	bh=dtsZSR5PGN9lZfaBFK/cPKjmy4rRTW/a7uREJxy5Oaw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KKTaiagt0b4qmthZFUXI7rwTLPWZDvccV8te7D3NmDLe539sYuTuGQuYsgphVTZnA81PO1hYGo8vhY310yDNO3kQjpwXa/Nb8e4cUGoKQ9mk9irICk9IKFoGNRSD6XKPvFaK159NF/cbaoQEipzIZkC+gGnj7yQxOkP51rTRBWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98A8C4CED6;
	Thu,  2 Jan 2025 18:59:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tTQRL-00000005Mjt-2W5I;
	Thu, 02 Jan 2025 14:01:03 -0500
Message-ID: <20250102190103.445521024@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 02 Jan 2025 13:58:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 bpf <bpf@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>,
 Zheng Yejian <zhengyejian1@huawei.com>,
 Martin  Kelly <martin.kelly@crowdstrike.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 02/14] scripts/sorttable: Remove unused write functions
References: <20250102185845.928488650@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The code of sorttable.h was copied from the recordmcount.h  which defined
various write functions for different sizes (2, 4, 8 byte lengths). But
sorttable only uses the 4 byte writes. Remove the extra versions as they
are not used.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 83cdb843d92f..4dcdbf7a5e26 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -68,8 +68,6 @@ static uint32_t (*r)(const uint32_t *);
 static uint16_t (*r2)(const uint16_t *);
 static uint64_t (*r8)(const uint64_t *);
 static void (*w)(uint32_t, uint32_t *);
-static void (*w2)(uint16_t, uint16_t *);
-static void (*w8)(uint64_t, uint64_t *);
 typedef void (*table_sort_t)(char *, int);
 
 /*
@@ -146,31 +144,11 @@ static void wbe(uint32_t val, uint32_t *x)
 	put_unaligned_be32(val, x);
 }
 
-static void w2be(uint16_t val, uint16_t *x)
-{
-	put_unaligned_be16(val, x);
-}
-
-static void w8be(uint64_t val, uint64_t *x)
-{
-	put_unaligned_be64(val, x);
-}
-
 static void wle(uint32_t val, uint32_t *x)
 {
 	put_unaligned_le32(val, x);
 }
 
-static void w2le(uint16_t val, uint16_t *x)
-{
-	put_unaligned_le16(val, x);
-}
-
-static void w8le(uint64_t val, uint64_t *x)
-{
-	put_unaligned_le64(val, x);
-}
-
 /*
  * Move reserved section indices SHN_LORESERVE..SHN_HIRESERVE out of
  * the way to -256..-1, to avoid conflicting with real section
@@ -277,16 +255,12 @@ static int do_file(char const *const fname, void *addr)
 		r2	= r2le;
 		r8	= r8le;
 		w	= wle;
-		w2	= w2le;
-		w8	= w8le;
 		break;
 	case ELFDATA2MSB:
 		r	= rbe;
 		r2	= r2be;
 		r8	= r8be;
 		w	= wbe;
-		w2	= w2be;
-		w8	= w8be;
 		break;
 	default:
 		fprintf(stderr, "unrecognized ELF data encoding %d: %s\n",
-- 
2.45.2



