Return-Path: <bpf+bounces-35370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D119399C6
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 08:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E4CCB217DF
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 06:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D723614A62A;
	Tue, 23 Jul 2024 06:32:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118414A09E;
	Tue, 23 Jul 2024 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721716330; cv=none; b=HWvRJTkBX7C0B/pOXJMXxNgHY114qRsZy2mWFNFcOSP3xuDGMwTKcxVX24rmUsEUspKTHKMVmnQ5RjES3b9BtEW2mAgyWlNf6Wg9eN6cT2e/aieVPNTToYaiDkmgZ9rlZ3anP9pMO3lQBcihd1ruqrioWEueEyMC9pqO9IMKkn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721716330; c=relaxed/simple;
	bh=98G5EYcrA0w8Bz5Q6obe7L6l3nViGXyN1IU2svx+MGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BpFL5LTmRAMc9XEHn3v7n27uqVtnMcutV5lTHMmxfrLp6BUWbsv4WDU59mGByz3VTDYFkr78QUz22bRnj1aiSnMgi7N02S2Y0Ta0r/r/VdRU10xZGwVGj7VurE+ngsX+75AaAjiop7td9DnMamZPJdo4MIUe1UkyzDiO5A8zMXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WSnP01bB3z4f3lVg;
	Tue, 23 Jul 2024 14:31:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B1E811A1421;
	Tue, 23 Jul 2024 14:32:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP2 (Coremail) with SMTP id Syh0CgA34wpOTp9mjImuAw--.48686S5;
	Tue, 23 Jul 2024 14:32:01 +0800 (CST)
From: Zheng Yejian <zhengyejian@huaweicloud.com>
To: masahiroy@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen.n.rao@linux.ibm.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	mcgrof@kernel.org,
	mathieu.desnoyers@efficios.com,
	nathan@kernel.org,
	nicolas@fjasle.eu,
	ojeda@kernel.org,
	akpm@linux-foundation.org,
	surenb@google.com,
	pasha.tatashin@soleen.com,
	kent.overstreet@linux.dev,
	james.clark@arm.com,
	jpoimboe@kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-modules@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	zhengyejian@huaweicloud.com
Subject: [PATCH v2 3/5] ftrace: Skip invalid __fentry__ in ftrace_process_locs()
Date: Tue, 23 Jul 2024 14:32:56 +0800
Message-Id: <20240723063258.2240610-4-zhengyejian@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240723063258.2240610-1-zhengyejian@huaweicloud.com>
References: <20240723063258.2240610-1-zhengyejian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA34wpOTp9mjImuAw--.48686S5
X-Coremail-Antispam: 1UD129KBjvJXoWxtryxKrWfZw17Cw48Xr47Jwb_yoWxGryDpF
	yUAr45Kr48Jr1jgan3ur4kury5G397ur47ta9xKrySvrnxXF10vanFvwn8A34UJrWkZFyx
	Ja43ZFy2kFWUZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0pRVOJ5UUUUU=
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

ftrace_location() was changed to not only return the __fentry__ location
when called for the __fentry__ location, but also when called for the
sym+0 location after commit aebfd12521d9 ("x86/ibt,ftrace: Search for
__fentry__ location"). That is, if sym+0 location is not __fentry__,
ftrace_location() would find one over the entire size of the sym.

However, there is case that more than one __fentry__ exist in the sym
range (described below) and ftrace_location() would find wrong __fentry__
location by binary searching, which would cause its users like livepatch/
kprobe/bpf to not work properly on this sym!

The case is that, based on current compiler behavior, suppose:
 - function A is followed by weak function B1 in same binary file;
 - weak function B1 is overridden by function B2;
Then in the final binary file:
 - symbol B1 will be removed from symbol table while its instructions are
   not removed;
 - __fentry__ of B1 will be still in __mcount_loc table;
 - function size of A is computed by substracting the symbol address of
   A from its next symbol address (see kallsyms_lookup_size_offset()),
   but because symbol info of B1 is removed, the next symbol of A is
   originally the next symbol of B1. See following example, function
   sizeof A will be (symbol_address_C - symbol_address_A):

     symbol_address_A
     symbol_address_B1 (Not in symbol table)
     symbol_address_C

The weak function issue has been discovered in commit b39181f7c690
("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid adding weak function")
but it didn't resolve the issue in ftrace_location().

To solve the issue, with Peter's suggestions, in previous patches, all
holes in the text have been found and filled with specail symbols, also
the same case with module weak function has been handled. Then check and
skip __fentry__ that locate in the holes.

Also in this patch, introduce module_kallsyms_find_symbol() to check if
a __fentry__ locate in a valid function of the given module. It is needed
because other symbol lookup functions like module_address_lookup() will
find module of the passed address first, but as ftrace_process_locs() is
called, the module has not been fully loaded, so those lookup functions
can not work.

Fixes: aebfd12521d9 ("x86/ibt,ftrace: Search for __fentry__ location")
Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
---
 include/linux/module.h   |  7 +++++++
 kernel/module/kallsyms.c | 23 +++++++++++++++++------
 kernel/trace/ftrace.c    | 12 +++++++++++-
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 0299d79433ae..4f5dd018e33d 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -962,6 +962,8 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 unsigned long module_kallsyms_lookup_name(const char *name);
 
 unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name);
+int module_kallsyms_find_symbol(struct module *mod, unsigned long addr,
+				unsigned long *size, unsigned long *offset);
 
 #else	/* CONFIG_MODULES && CONFIG_KALLSYMS */
 
@@ -1006,6 +1008,11 @@ static inline unsigned long find_kallsyms_symbol_value(struct module *mod,
 	return 0;
 }
 
+static inline int module_kallsyms_find_symbol(struct module *mod, unsigned long addr,
+					      unsigned long *size, unsigned long *offset)
+{
+	return 0;
+}
 #endif  /* CONFIG_MODULES && CONFIG_KALLSYMS */
 
 #endif /* _LINUX_MODULE_H */
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index cce4f81b9933..71b3ed25cd40 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -253,10 +253,10 @@ static const char *kallsyms_symbol_name(struct mod_kallsyms *kallsyms, unsigned
  * Given a module and address, find the corresponding symbol and return its name
  * while providing its size and offset if needed.
  */
-static const char *find_kallsyms_symbol(struct module *mod,
-					unsigned long addr,
-					unsigned long *size,
-					unsigned long *offset)
+static const char *__find_kallsyms_symbol(struct module *mod,
+					  unsigned long addr,
+					  unsigned long *size,
+					  unsigned long *offset)
 {
 	unsigned int i, best = 0;
 	unsigned long nextval, bestval;
@@ -326,6 +326,17 @@ static const char *find_kallsyms_symbol(struct module *mod,
 	return kallsyms_symbol_name(kallsyms, best);
 }
 
+int module_kallsyms_find_symbol(struct module *mod, unsigned long addr,
+				unsigned long *size, unsigned long *offset)
+{
+	const char *ret;
+
+	preempt_disable();
+	ret = __find_kallsyms_symbol(mod, addr, size, offset);
+	preempt_enable();
+	return !!ret;
+}
+
 void * __weak dereference_module_function_descriptor(struct module *mod,
 						     void *ptr)
 {
@@ -360,7 +371,7 @@ int module_address_lookup(unsigned long addr,
 #endif
 		}
 
-		sym = find_kallsyms_symbol(mod, addr, size, offset);
+		sym = __find_kallsyms_symbol(mod, addr, size, offset);
 
 		if (sym)
 			ret = strscpy(namebuf, sym, KSYM_NAME_LEN);
@@ -381,7 +392,7 @@ int lookup_module_symbol_name(unsigned long addr, char *symname)
 		if (within_module(addr, mod)) {
 			const char *sym;
 
-			sym = find_kallsyms_symbol(mod, addr, NULL, NULL);
+			sym = __find_kallsyms_symbol(mod, addr, NULL, NULL);
 			if (!sym)
 				goto out;
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 0f579430f02a..fff5d3466c41 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6989,6 +6989,16 @@ static void test_is_sorted(unsigned long *start, unsigned long count)
 }
 #endif
 
+static int is_invalid_rec(struct module *mod, unsigned long addr)
+{
+	char str[KSYM_SYMBOL_LEN];
+
+	if (mod)
+		return !module_kallsyms_find_symbol(mod, addr, NULL, NULL);
+
+	return !kallsyms_lookup(addr, NULL, NULL, NULL, str);
+}
+
 static int ftrace_process_locs(struct module *mod,
 			       unsigned long *start,
 			       unsigned long *end)
@@ -7060,7 +7070,7 @@ static int ftrace_process_locs(struct module *mod,
 		 * object files to satisfy alignments.
 		 * Skip any NULL pointers.
 		 */
-		if (!addr) {
+		if (!addr || is_invalid_rec(mod, addr)) {
 			skipped++;
 			continue;
 		}
-- 
2.25.1


