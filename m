Return-Path: <bpf+bounces-35372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6189399CF
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 08:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE489B21E1C
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 06:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE82314B960;
	Tue, 23 Jul 2024 06:32:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B1614A611;
	Tue, 23 Jul 2024 06:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721716332; cv=none; b=NX+iou6+ox1nqG7aueKZoPLfxaGgNjVGlKxXGHsWvNc11B4RbrBZbHVs1FlBd2j9u4nrpMguDs77y3k/sBiHjK2tp5N/VU8lubYaxkHmVeNx7sXDtoW4gYwAalOsvM7zZFQoa0XoxCHRqLyEmouDlWx4Pwcx1n179TgpSrQX7qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721716332; c=relaxed/simple;
	bh=IA1VKL3MvIYjPz7nwh+mOgEyBbw8WVZrT+VtknO8ITc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lfK5ICK7YCCVHe4oVWEhnenF1q68wXjtKeDgV+fAeqm+CF2KL92pgFUXndt/RAKWYwpRkUn1Dev/H2TYDwqfmoToO7ChU5DcpuOmB6ENqTeW7eXg9dcAqC1n45egTnyW8sS9lNh173TmiBmQHi0KAc/j3N1V9XY3w6Cf+LVomCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WSnP10gjfz4f3kFN;
	Tue, 23 Jul 2024 14:31:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7210C1A06D7;
	Tue, 23 Jul 2024 14:32:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP2 (Coremail) with SMTP id Syh0CgA34wpOTp9mjImuAw--.48686S3;
	Tue, 23 Jul 2024 14:32:00 +0800 (CST)
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
Subject: [PATCH v2 1/5] kallsyms: Emit symbol at the holes in the text
Date: Tue, 23 Jul 2024 14:32:54 +0800
Message-Id: <20240723063258.2240610-2-zhengyejian@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgA34wpOTp9mjImuAw--.48686S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4UtFyxuF4fJF1kXFy7ZFb_yoWxWFyfpa
	4Fk3yYgrWrJrn7W3srGw48WFW3uws7Zan5G3srG34YyFn0qrWSqay7K3yYyFWUJry8JFyj
	kr9ayFW2kF4vy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7sRETKZJUUUUU==
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

When a weak type function is overridden, its symbol will be removed
from the symbol table, but its code will not be removed. Besides,
due to lacking of size for kallsyms, kernel compute function size by
substracting its symbol address from its next symbol address (see
kallsyms_lookup_size_offset()). These will cause that size of some
function is computed to be larger than it actually is, just because
symbol of its following weak function is removed.

This issue also causes multiple __fentry__ locations to be counted in
the same function scope, and eventually causes ftrace_location() to find
wrong __fentry__ location. It was reported in
Link: https://lore.kernel.org/all/20240607115211.734845-1-zhengyejian1@huawei.com/

Peter suggested to change scipts/kallsyms.c to emit readily
identifiable symbol names for all the weak junk.

So in this patch:
1. Pass size info to scripts/kallsyms  (see mksysmap());
2. Traverse sorted function symbols, if one function address plus its
   size less than next function address, it means there's a hole, with
   Masahiro's suggestion, then emit a symbol there of which type and
   name are both empty to represent the hole.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
---
 scripts/kallsyms.c      | 94 +++++++++++++++++++++++++++++++++++++++--
 scripts/link-vmlinux.sh |  4 +-
 scripts/mksysmap        |  2 +-
 3 files changed, 94 insertions(+), 6 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 47978efe4797..cf64c20a8292 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -34,6 +34,7 @@
 
 struct sym_entry {
 	unsigned long long addr;
+	unsigned long long size;
 	unsigned int len;
 	unsigned int seq;
 	unsigned int start_pos;
@@ -72,7 +73,6 @@ static int token_profit[0x10000];
 static unsigned char best_table[256][2];
 static unsigned char best_table_len[256];
 
-
 static void usage(void)
 {
 	fprintf(stderr, "Usage: kallsyms [--all-symbols] [--absolute-percpu] "
@@ -128,8 +128,16 @@ static struct sym_entry *read_symbol(FILE *in, char **buf, size_t *buf_len)
 	size_t len;
 	ssize_t readlen;
 	struct sym_entry *sym;
+	unsigned long long size = 0;
 
 	errno = 0;
+	/*
+	 * Example of expected symbol format:
+	 * 1. symbol with size info:
+	 *    ffffffff81000070 00000000000001d7 T __startup_64
+	 * 2. symbol without size info:
+	 *    0000000002a00000 A text_size
+	 */
 	readlen = getline(buf, buf_len, in);
 	if (readlen < 0) {
 		if (errno) {
@@ -143,9 +151,24 @@ static struct sym_entry *read_symbol(FILE *in, char **buf, size_t *buf_len)
 		(*buf)[readlen - 1] = 0;
 
 	addr = strtoull(*buf, &p, 16);
+	if (*buf == p || *p++ != ' ') {
+		fprintf(stderr, "line format error: unable to parse address\n");
+		exit(EXIT_FAILURE);
+	}
+
+	if (*p == '0') {
+		char *str = p;
+
+		size = strtoull(str, &p, 16);
+		if (str == p || *p++ != ' ') {
+			fprintf(stderr, "line format error: unable to parse size\n");
+			exit(EXIT_FAILURE);
+		}
+	}
 
-	if (*buf == p || *p++ != ' ' || !isascii((type = *p++)) || *p++ != ' ') {
-		fprintf(stderr, "line format error\n");
+	type = *p++;
+	if (!isascii(type) || *p++ != ' ') {
+		fprintf(stderr, "line format error: unable to parse type\n");
 		exit(EXIT_FAILURE);
 	}
 
@@ -180,6 +203,7 @@ static struct sym_entry *read_symbol(FILE *in, char **buf, size_t *buf_len)
 		exit(EXIT_FAILURE);
 	}
 	sym->addr = addr;
+	sym->size = size;
 	sym->len = len;
 	sym->sym[0] = type;
 	strcpy(sym_name(sym), name);
@@ -788,6 +812,69 @@ static void sort_symbols(void)
 	qsort(table, table_cnt, sizeof(table[0]), compare_symbols);
 }
 
+static bool has_hole(const struct sym_entry *se1, const struct sym_entry *se2)
+{
+	char type = se1->sym[0];
+
+	/* Only check text symbol or weak symbol */
+	if (type != 't' && type != 'T' &&
+	    type != 'w' && type != 'W')
+		return 0;
+	/* Symbol without size has no hole */
+	if (!se1->size)
+		return 0;
+	return se1->addr + se1->size < se2->addr;
+}
+
+static struct sym_entry *gen_hole_symbol(const struct sym_entry *se)
+{
+	struct sym_entry *sym;
+
+	/* Use empty symbol type/name as a special case to represent the hole */
+	sym = malloc(sizeof(*sym) + 1);
+	if (!sym) {
+		fprintf(stderr, "unable to allocate memory for hole symbol\n");
+		exit(EXIT_FAILURE);
+	}
+	sym->addr = se->addr + se->size;
+	sym->size = 0;
+	sym->len = 1;
+	sym->sym[0] = '\0';
+	sym->percpu_absolute = 0;
+	return sym;
+}
+
+static void emit_hole_symbols(void)
+{
+	unsigned int i, j, nr_emit;
+	unsigned int new_cnt;
+
+	nr_emit = 0;
+	for (i = 0; i < table_cnt - 1; i++) {
+		if (has_hole(table[i], table[i+1]))
+			nr_emit++;
+	}
+	if (!nr_emit)
+		return;
+
+	new_cnt = table_cnt + nr_emit;
+	table = realloc(table, sizeof(*table) * new_cnt);
+	if (!table) {
+		fprintf(stderr, "unable to allocate memory for emitting hole symbols\n");
+		exit(EXIT_FAILURE);
+	}
+
+	for (i = table_cnt - 1, j = new_cnt - 1; i >= 0; i--, j--) {
+		if ((i != table_cnt - 1) && has_hole(table[i], table[i+1]))
+			table[j--] = gen_hole_symbol(table[i]);
+		if (j != i)
+			table[j] = table[i];
+		else
+			break;
+	}
+	table_cnt = new_cnt;
+}
+
 static void make_percpus_absolute(void)
 {
 	unsigned int i;
@@ -847,6 +934,7 @@ int main(int argc, char **argv)
 	if (absolute_percpu)
 		make_percpus_absolute();
 	sort_symbols();
+	emit_hole_symbols();
 	if (base_relative)
 		record_relative_base();
 	optimize_token_table();
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 518c70b8db50..8e1373902bfe 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -189,11 +189,11 @@ kallsyms_step()
 }
 
 # Create map file with all symbols from ${1}
-# See mksymap for additional details
+# See mksysmap for additional details
 mksysmap()
 {
 	info NM ${2}
-	${NM} -n "${1}" | sed -f "${srctree}/scripts/mksysmap" > "${2}"
+	${NM} -nS "${1}" | sed -f "${srctree}/scripts/mksysmap" > "${2}"
 }
 
 sorttable()
diff --git a/scripts/mksysmap b/scripts/mksysmap
index c12723a04655..7a4415f21143 100755
--- a/scripts/mksysmap
+++ b/scripts/mksysmap
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 # sed script to filter out symbols that are not needed for System.map,
-# or not suitable for kallsyms. The input should be 'nm -n <file>'.
+# or not suitable for kallsyms. The input should be 'nm -nS <file>'.
 #
 # System.map is used by module-init tools and some debugging
 # tools to retrieve the actual addresses of symbols in the kernel.
-- 
2.25.1


