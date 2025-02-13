Return-Path: <bpf+bounces-51444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C118EA349EA
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 17:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7868E7A4E7F
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F82D27FE8F;
	Thu, 13 Feb 2025 16:21:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA9C20127E;
	Thu, 13 Feb 2025 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463695; cv=none; b=qCNNIZlF331mpZSs26CrXHR8vaWXo5hOijgfBIi9yS6tjxbi+iQsT3r0j984xfdKFgTg8bv/0Im6276as2cgBEUj9EAl/pq1Dxi+pvXHFlBCzO3ISvv4KGZpZ6DKVIaz0/YFgIHQiUaGegIdtykJAL+L1P/9S50DjSn1JbDmn6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463695; c=relaxed/simple;
	bh=adWDEN1xA8RJXsxjA7ajZlW+Xp1KGSevPLjjon+DSOA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=d7hu5pL7iIYpP+Y8wUpNty+G8kLIRbmhKTBcM7uBRQCxkq3bjciHYrP/Pg6TkDjw+HJdSSVRNWSNirMVEKmNrC++InzNBI7iDKWh32fVIp+ltBLEqud5mcYTAIxxrj4SQ49CXPAg/GnqSpLmNWtJYlPNTZUYbJHQYhsfZ6D3ATQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C06BC4CEED;
	Thu, 13 Feb 2025 16:21:35 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tibyD-00000001qbV-43ID;
	Thu, 13 Feb 2025 11:21:45 -0500
Message-ID: <20250213162145.821148283@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 13 Feb 2025 11:20:50 -0500
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
Subject: [PATCH v3 3/6] scripts/sorttable: Always use an array for the mcount_loc sorting
References: <20250213162047.306074881@goodmis.org>
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



