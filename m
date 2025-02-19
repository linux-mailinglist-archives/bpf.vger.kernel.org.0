Return-Path: <bpf+bounces-51957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DDEA3C37D
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 16:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12F407A92AE
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 15:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45E61F5617;
	Wed, 19 Feb 2025 15:18:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5719719D074;
	Wed, 19 Feb 2025 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978320; cv=none; b=Jsg4PYRTZ0Y4asRi/S56TFz9zDJVpDe/tS5rvur2zkgYkfV7h2y4zEd/sXJxqGPdZAF0AhI1REKjT+Efls6KqugW7DPZa0RYmkldoI0lm1Q0Mf8q5VyAZ8bSXowOEDBpfYR9Hd/pRNM8PVNpaSR7Rc6ChLbAuTTBKs15tGN66/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978320; c=relaxed/simple;
	bh=VNUeYJH8LJ8WIAuog2eseFdbOahlI7rKMvxe+9cfdgo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QKnNf3MCxV0YRqoQoFHQmGBp/0TfNkaWdgNb46weAVfDradgnwgTF6percuxMsPAD4o8UxKN93swQjdrS5bowQfhr9v5Evl67Cylig0SjrZI9PmliYAwQSNTElXbU5FTCeg7cxuCvnAidR0BWzjTsxKDCwv2nqX5GhDR2oQNKJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D891EC4CEEE;
	Wed, 19 Feb 2025 15:18:39 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tklqq-00000004bZn-1uXF;
	Wed, 19 Feb 2025 10:19:04 -0500
Message-ID: <20250219151904.306295401@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 19 Feb 2025 10:18:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 bpf <bpf@vger.kernel.org>,
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
Subject: [for-next][PATCH 3/6] scripts/sorttable: Always use an array for the mcount_loc sorting
References: <20250219151815.734900568@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The sorting of the mcount_loc section is done directly to the section for
x86 and arm32 but it uses a separate array for arm64 as arm64 has the
values for the mcount_loc stored in the rela sections of the vmlinux ELF
file.

In order to use the same code to remove weak functions, always use a
separate array to do the sorting. This requires splitting up the filling
of the array into one function and the placing the contents of the array
back into the rela sections or into the mcount_loc section into a separate
file.

Cc: bpf <bpf@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Cc: Martin  Kelly <martin.kelly@crowdstrike.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Link: https://lore.kernel.org/20250218200022.710676551@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.c | 122 ++++++++++++++++++++++++++++++++------------
 1 file changed, 90 insertions(+), 32 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index f62a91d8af0a..ec02a2852efb 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -594,31 +594,19 @@ struct elf_mcount_loc {
 	uint64_t stop_mcount_loc;
 };
 
-/* Sort the relocations not the address itself */
-static void *sort_relocs(Elf_Ehdr *ehdr, uint64_t start_loc, uint64_t size)
+/* Fill the array with the content of the relocs */
+static int fill_relocs(void *ptr, uint64_t size, Elf_Ehdr *ehdr, uint64_t start_loc)
 {
 	Elf_Shdr *shdr_start;
 	Elf_Rela *rel;
 	unsigned int shnum;
-	unsigned int count;
+	unsigned int count = 0;
 	int shentsize;
-	void *vals;
-	void *ptr;
-
-	compare_values = long_size == 4 ? compare_values_32 : compare_values_64;
+	void *array_end = ptr + size;
 
 	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
 	shentsize = ehdr_shentsize(ehdr);
 
-	vals = malloc(long_size * size);
-	if (!vals) {
-		snprintf(m_err, ERRSTR_MAXSZ, "Failed to allocate sort array");
-		pthread_exit(m_err);
-		return NULL;
-	}
-
-	ptr = vals;
-
 	shnum = ehdr_shnum(ehdr);
 	if (shnum == SHN_UNDEF)
 		shnum = shdr_size(shdr_start);
@@ -637,22 +625,18 @@ static void *sort_relocs(Elf_Ehdr *ehdr, uint64_t start_loc, uint64_t size)
 			uint64_t offset = rela_offset(rel);
 
 			if (offset >= start_loc && offset < start_loc + size) {
-				if (ptr + long_size > vals + size) {
-					free(vals);
+				if (ptr + long_size > array_end) {
 					snprintf(m_err, ERRSTR_MAXSZ,
 						 "Too many relocations");
-					pthread_exit(m_err);
-					return NULL;
+					return -1;
 				}
 
 				/* Make sure this has the correct type */
 				if (rela_info(rel) != rela_type) {
-					free(vals);
 					snprintf(m_err, ERRSTR_MAXSZ,
 						"rela has type %lx but expected %lx\n",
 						(long)rela_info(rel), rela_type);
-					pthread_exit(m_err);
-					return NULL;
+					return -1;
 				}
 
 				if (long_size == 4)
@@ -660,13 +644,28 @@ static void *sort_relocs(Elf_Ehdr *ehdr, uint64_t start_loc, uint64_t size)
 				else
 					*(uint64_t *)ptr = rela_addend(rel);
 				ptr += long_size;
+				count++;
 			}
 		}
 	}
-	count = ptr - vals;
-	qsort(vals, count / long_size, long_size, compare_values);
+	return count;
+}
+
+/* Put the sorted vals back into the relocation elements */
+static void replace_relocs(void *ptr, uint64_t size, Elf_Ehdr *ehdr, uint64_t start_loc)
+{
+	Elf_Shdr *shdr_start;
+	Elf_Rela *rel;
+	unsigned int shnum;
+	int shentsize;
+
+	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
+	shentsize = ehdr_shentsize(ehdr);
+
+	shnum = ehdr_shnum(ehdr);
+	if (shnum == SHN_UNDEF)
+		shnum = shdr_size(shdr_start);
 
-	ptr = vals;
 	for (int i = 0; i < shnum; i++) {
 		Elf_Shdr *shdr = get_index(shdr_start, shentsize, i);
 		void *end;
@@ -689,8 +688,32 @@ static void *sort_relocs(Elf_Ehdr *ehdr, uint64_t start_loc, uint64_t size)
 			}
 		}
 	}
-	free(vals);
-	return NULL;
+}
+
+static int fill_addrs(void *ptr, uint64_t size, void *addrs)
+{
+	void *end = ptr + size;
+	int count = 0;
+
+	for (; ptr < end; ptr += long_size, addrs += long_size, count++) {
+		if (long_size == 4)
+			*(uint32_t *)ptr = r(addrs);
+		else
+			*(uint64_t *)ptr = r8(addrs);
+	}
+	return count;
+}
+
+static void replace_addrs(void *ptr, uint64_t size, void *addrs)
+{
+	void *end = ptr + size;
+
+	for (; ptr < end; ptr += long_size, addrs += long_size) {
+		if (long_size == 4)
+			w(*(uint32_t *)ptr, addrs);
+		else
+			w8(*(uint64_t *)ptr, addrs);
+	}
 }
 
 /* Sort the addresses stored between __start_mcount_loc to __stop_mcount_loc in vmlinux */
@@ -699,14 +722,49 @@ static void *sort_mcount_loc(void *arg)
 	struct elf_mcount_loc *emloc = (struct elf_mcount_loc *)arg;
 	uint64_t offset = emloc->start_mcount_loc - shdr_addr(emloc->init_data_sec)
 					+ shdr_offset(emloc->init_data_sec);
-	uint64_t count = emloc->stop_mcount_loc - emloc->start_mcount_loc;
+	uint64_t size = emloc->stop_mcount_loc - emloc->start_mcount_loc;
 	unsigned char *start_loc = (void *)emloc->ehdr + offset;
+	Elf_Ehdr *ehdr = emloc->ehdr;
+	void *e_msg = NULL;
+	void *vals;
+	int count;
+
+	vals = malloc(long_size * size);
+	if (!vals) {
+		snprintf(m_err, ERRSTR_MAXSZ, "Failed to allocate sort array");
+		pthread_exit(m_err);
+	}
 
 	if (sort_reloc)
-		return sort_relocs(emloc->ehdr, emloc->start_mcount_loc, count);
+		count = fill_relocs(vals, size, ehdr, emloc->start_mcount_loc);
+	else
+		count = fill_addrs(vals, size, start_loc);
+
+	if (count < 0) {
+		e_msg = m_err;
+		goto out;
+	}
+
+	if (count != size / long_size) {
+		snprintf(m_err, ERRSTR_MAXSZ, "Expected %u mcount elements but found %u\n",
+			(int)(size / long_size), count);
+		e_msg = m_err;
+		goto out;
+	}
+
+	compare_values = long_size == 4 ? compare_values_32 : compare_values_64;
+
+	qsort(vals, count, long_size, compare_values);
+
+	if (sort_reloc)
+		replace_relocs(vals, size, ehdr, emloc->start_mcount_loc);
+	else
+		replace_addrs(vals, size, start_loc);
+
+out:
+	free(vals);
 
-	qsort(start_loc, count/long_size, long_size, compare_extable);
-	return NULL;
+	pthread_exit(e_msg);
 }
 
 /* Get the address of __start_mcount_loc and __stop_mcount_loc in System.map */
-- 
2.47.2



