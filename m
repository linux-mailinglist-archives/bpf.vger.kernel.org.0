Return-Path: <bpf+bounces-51866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9135A3A83F
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 21:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826F9188E10E
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 20:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A333A1F584F;
	Tue, 18 Feb 2025 20:00:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8131EFFA2;
	Tue, 18 Feb 2025 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908800; cv=none; b=EtZ2efHkz0kb8iKfeihh5adJFdHN49e4G5JMvMFgOhQ6fcSQAp7rVgv5ZNrJoyEYsd+UXJS+RtjQUtr4dGLnx0Z8dejPS4C6htz268pZk+rpbrw+VN77/FROzVz1kAXW4AoX+VyRXhGY9gxzotL8DL62R6ORRwnyXfaS+0TNBSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908800; c=relaxed/simple;
	bh=OltVgEYzZ9xBW85TfnHfInwAEt15pvGNcSmUYnlj5mo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=spZxzbjrJzd8s8qbn9sD8307J8e7ACTYv3ERpW29DI7W6OVFG01xRuBzXsHBjTJsvnxb03Uc0vEJqkNnNnrouC0WpCeZ469dzTynSKF+qhQnjxPLAQzjdezDs0Vcaz0f2X93j34OTAe62onJhtgQ31v92VgMJ2WApFzwc8nkDpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04986C4CEEE;
	Tue, 18 Feb 2025 20:00:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tkTlW-00000004App-2tWh;
	Tue, 18 Feb 2025 15:00:22 -0500
Message-ID: <20250218200022.538888594@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 18 Feb 2025 14:59:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 bpf <bpf@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org
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
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v5 2/6] scripts/sorttable: Have mcount rela sort use direct values
References: <20250218195918.255228630@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The mcount_loc sorting for when the values are stored in the Elf_Rela
entries uses the compare_extable() function to do the compares in the
qsort(). That function does handle byte swapping if the machine being
compiled for is a different endian than the host machine. But the
sort_relocs() function sorts an array that pulled in the values from the
Elf_Rela section and has already done the swapping.

Create two new compare functions that will sort the direct values. One
will sort 32 bit values and the other will sort the 64 bit value. One of
these will be assigned to a compare_values function pointer and that will
be used for sorting the Elf_Rela mcount values.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 4a34c275123e..f62a91d8af0a 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -552,6 +552,28 @@ static void *sort_orctable(void *arg)
 
 #ifdef MCOUNT_SORT_ENABLED
 
+static int compare_values_64(const void *a, const void *b)
+{
+	uint64_t av = *(uint64_t *)a;
+	uint64_t bv = *(uint64_t *)b;
+
+	if (av < bv)
+		return -1;
+	return av > bv;
+}
+
+static int compare_values_32(const void *a, const void *b)
+{
+	uint32_t av = *(uint32_t *)a;
+	uint32_t bv = *(uint32_t *)b;
+
+	if (av < bv)
+		return -1;
+	return av > bv;
+}
+
+static int (*compare_values)(const void *a, const void *b);
+
 /* Only used for sorting mcount table */
 static void rela_write_addend(Elf_Rela *rela, uint64_t val)
 {
@@ -583,6 +605,8 @@ static void *sort_relocs(Elf_Ehdr *ehdr, uint64_t start_loc, uint64_t size)
 	void *vals;
 	void *ptr;
 
+	compare_values = long_size == 4 ? compare_values_32 : compare_values_64;
+
 	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
 	shentsize = ehdr_shentsize(ehdr);
 
@@ -640,7 +664,7 @@ static void *sort_relocs(Elf_Ehdr *ehdr, uint64_t start_loc, uint64_t size)
 		}
 	}
 	count = ptr - vals;
-	qsort(vals, count / long_size, long_size, compare_extable);
+	qsort(vals, count / long_size, long_size, compare_values);
 
 	ptr = vals;
 	for (int i = 0; i < shnum; i++) {
-- 
2.47.2



