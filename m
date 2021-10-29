Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AC043F779
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 08:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhJ2Gxd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 02:53:33 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:26206 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhJ2Gx1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Oct 2021 02:53:27 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HgY232Lp1z8tx9;
        Fri, 29 Oct 2021 14:49:31 +0800 (CST)
Received: from huawei.com (10.67.189.2) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Fri, 29
 Oct 2021 14:50:54 +0800
From:   Lexi Shao <shaolexi@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <james.clark@arm.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <mark.rutland@arm.com>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <nixiaoming@huawei.com>, <peterz@infradead.org>,
        <qiuxi1@huawei.com>, <shaolexi@huawei.com>, <wangbing6@huawei.com>,
        <jeyu@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kafai@fb.com>, <songliubraving@fb.com>,
        <yhs@fb.com>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <natechancellor@gmail.com>, <ndesaulniers@google.com>,
        <bpf@vger.kernel.org>, <clang-built-linux@googlegroups.com>
Subject: [PATCH v2 2/2] kallsyms: ignore arm mapping symbols when loading module
Date:   Fri, 29 Oct 2021 14:50:38 +0800
Message-ID: <20211029065038.39449-3-shaolexi@huawei.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20211029065038.39449-1-shaolexi@huawei.com>
References: <cb7e9ef7-eda4-b197-df8a-0b54f9b56181@arm.com>
 <20211029065038.39449-1-shaolexi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Arm modules contains mapping symbols(e.g. $a $d) which are ignored in
module_kallsyms_on_each_symbol. However, these symbols are still
displayed when catting /proc/kallsyms. This confuses tools(e.g. perf)
that resolves kernel symbols with address using information from
/proc/kallsyms. See discussion in Link:
https://lore.kernel.org/all/c7dfbd17-85fd-b914-b90f-082abc64c9d1@arm.com/

Being left out in vmlinux(see scripts/kallsyms.c is_ignored_symbol) and
kernelspace API implies that these symbols are not used in any cases.
So we can ignore them in the first place by not adding them to module
kallsyms.

Signed-off-by: Lexi Shao <shaolexi@huawei.com>
---
 kernel/module.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 5c26a76e800b..b30cbbe144c7 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2662,16 +2662,22 @@ static char elf_type(const Elf_Sym *sym, const struct load_info *info)
 	return '?';
 }
 
-static bool is_core_symbol(const Elf_Sym *src, const Elf_Shdr *sechdrs,
-			unsigned int shnum, unsigned int pcpundx)
+static inline int is_arm_mapping_symbol(const char *str);
+static bool is_core_symbol(const Elf_Sym *src, const struct load_info *info)
 {
 	const Elf_Shdr *sec;
+	const Elf_Shdr *sechdrs = info->sechdrs;
+	unsigned int shnum = info->hdr->e_shnum;
+	unsigned int pcpundx = info->index.pcpu;
 
 	if (src->st_shndx == SHN_UNDEF
 	    || src->st_shndx >= shnum
 	    || !src->st_name)
 		return false;
 
+	if (is_arm_mapping_symbol(&info->strtab[src->st_name]))
+		return false;
+
 #ifdef CONFIG_KALLSYMS_ALL
 	if (src->st_shndx == pcpundx)
 		return true;
@@ -2714,8 +2720,7 @@ static void layout_symtab(struct module *mod, struct load_info *info)
 	/* Compute total space required for the core symbols' strtab. */
 	for (ndst = i = 0; i < nsrc; i++) {
 		if (i == 0 || is_livepatch_module(mod) ||
-		    is_core_symbol(src+i, info->sechdrs, info->hdr->e_shnum,
-				   info->index.pcpu)) {
+		    is_core_symbol(src+i, info)) {
 			strtab_size += strlen(&info->strtab[src[i].st_name])+1;
 			ndst++;
 		}
@@ -2778,8 +2783,7 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 	for (ndst = i = 0; i < mod->kallsyms->num_symtab; i++) {
 		mod->kallsyms->typetab[i] = elf_type(src + i, info);
 		if (i == 0 || is_livepatch_module(mod) ||
-		    is_core_symbol(src+i, info->sechdrs, info->hdr->e_shnum,
-				   info->index.pcpu)) {
+		    is_core_symbol(src+i, info)) {
 			mod->core_kallsyms.typetab[ndst] =
 			    mod->kallsyms->typetab[i];
 			dst[ndst] = src[i];
@@ -4246,8 +4250,7 @@ static const char *find_kallsyms_symbol(struct module *mod,
 		 * We ignore unnamed symbols: they're uninformative
 		 * and inserted at a whim.
 		 */
-		if (*kallsyms_symbol_name(kallsyms, i) == '\0'
-		    || is_arm_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
+		if (*kallsyms_symbol_name(kallsyms, i) == '\0')
 			continue;
 
 		if (thisval <= addr && thisval > bestval) {
-- 
2.12.3

