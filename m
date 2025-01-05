Return-Path: <bpf+bounces-47891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF2BA01A68
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 17:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0215B18834C1
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 16:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48106181334;
	Sun,  5 Jan 2025 16:22:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1AD6CDAF;
	Sun,  5 Jan 2025 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736094140; cv=none; b=tnDo0zJ7xygRrWJCnPHqsklNFfUE3lr5t5CoTmp8+Tr6HG3qOGNXtUQaF9EhkbSzYl8M4ZpMVXNjy8xiJYg1bFxgxpAjR1nZLJfiv/G7aKQoB+jZyZC+wQ9La34Bgcn6/YD5Zlb7Zo1gweFe3jyPo2Z1ec88+xu1zNIvkXcNCOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736094140; c=relaxed/simple;
	bh=dtsZSR5PGN9lZfaBFK/cPKjmy4rRTW/a7uREJxy5Oaw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ujmGHtOOhW8ZLGrLJ0I9jzwu5fa+Cb5xJ58KDGi9CtJ/XDnm6rpK6Gv46gVY9/4Bmh8kzI1mHvpzDHEUE/kkKZv6C/gsrlXQQ9vw3QKytvfEx8k5e8tG1brGmZmURQbrI6SRGQO9gwdRIT+/xMJdhNAdtHWoJJM8OizzVq/Ykdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8288FC4CEE6;
	Sun,  5 Jan 2025 16:22:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tUTPk-00000008Erb-21EJ;
	Sun, 05 Jan 2025 11:23:44 -0500
Message-ID: <20250105162344.314385504@goodmis.org>
User-Agent: quilt/0.68
Date: Sun, 05 Jan 2025 11:22:13 -0500
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
References: <20250105162211.971039541@goodmis.org>
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



