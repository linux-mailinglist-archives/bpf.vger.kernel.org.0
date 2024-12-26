Return-Path: <bpf+bounces-47642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2312B9FCE1B
	for <lists+bpf@lfdr.de>; Thu, 26 Dec 2024 22:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF6F163796
	for <lists+bpf@lfdr.de>; Thu, 26 Dec 2024 21:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B674198E8C;
	Thu, 26 Dec 2024 21:49:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33AC189521;
	Thu, 26 Dec 2024 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735249741; cv=none; b=q5us8RJeMkhdukf67SR+XIY8JmVd6HRpWgTJDuTz1nWiXqaJU9ip9PzWlwlv6CByPY5KOT97OgtX0H1eB/EYLp9goW/5KQDae7Qzm0a4jXiWcziNsODKeaJ0kbUYZ2diRIIkZLVh2x1ZFC/eS3b1GgBdkixoYvQYjczpRUAyHz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735249741; c=relaxed/simple;
	bh=jQ+w8QGLVhhqsvschag6AgrcuKQcCuyqekV1qjhP4MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=XmMlLSvlwOAuPAH7xIL3SS2wEfSyAytuaBH41hpTl1F3+1QTKe703N7Qh9Q3QhN023dUdW7OGUFbEkndm2+PPwJW+HBApToF/R+48PPK9Y0KINc/LY20HYM05+rwpb60BO7iqwq1ghbHjMMCpA9++QqbNW01cVQnFZ+cIria0Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AF9C4CED1;
	Thu, 26 Dec 2024 21:48:59 +0000 (UTC)
Date: Thu, 26 Dec 2024 16:49:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas
 Schier <nicolas@fjasle.eu>, Zheng Yejian <zhengyejian1@huawei.com>, Martin
 Kelly <martin.kelly@crowdstrike.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@redhat.com>, Mark
 Rutland <mark.rutland@arm.com>
Subject: [POC][RFC][PATCH] build: Make weak functions visible in kallsyms
Message-ID: <20241226164957.5cab9f2d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

This is a proof of concept, so the implementation may need some work. The
point here is to see if this is something we want to have. I only made it
work for x86, but there's nothing arch specific except knowing if it's for
32bit or 64bit. I also have to add accommodation for big vs little endian
cross compiling.

Weak functions have been playing havoc with ftrace users for some time.
That's because if a weak function can be traced, it gets an "fentry" or
"mcount" inserted inside of it. This gets added to the the list in the
__mcount_loc section where ftrace will find them all.

But then, when the linker removes these functions because they were
overridden, the code does not disappear, leaving the pointers in the
__mcount_loc locations.

This also played havoc with kallsyms, as it generates the size of functions
by looking at the next function. If the next function was a weak function
that was overridden, the content of that function is joined with the
previous function.

Combining this with ftrace, it use to show the previous function twice (if
it was traced), or worse, if the previous function was notrace, it would
still show up in available_filter_functions list. This made the BPF test
suite fail:

  https://lore.kernel.org/all/20220412094923.0abe90955e5db486b7bca279@kernel.org/

The workaround to that was to check the addresses of functions in this
file, and if it was too far from the start of the function, it was
considered invalid (as fentry and mcount are at the start of functions):

  commit b39181f7c6907 ("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid
  adding weak function")

But this still an issue with live kernel patching, as it checks the length
of the function, and if the does not match to what it sees before the weak
function disappears it fails to get added:

  https://patchwork.kernel.org/project/linux-trace-kernel/cover/20240723063258.2240610-1-zhengyejian@huaweicloud.com/

  which took an approach to fix this.

This is similar to that approach but also a bit simpler. I simply added a
weakfuncs.c program that gets run on all object files right after they are
built, and appends to the symbol table copies of the weak functions, but
the are not weak. The names are:

  __weak__##function_name##__weak__

This now shows up in kallsyms as:

ffffffffa8e03f20 t rootfs_init_fs_context
ffffffffa8e03f40 T __pfx_wait_for_initramfs
ffffffffa8e03f50 T wait_for_initramfs
ffffffffa8e03fa0 t __pfx_show_mem
ffffffffa8e03fb0 t show_mem
ffffffffa8e03fc0 T __pfx___weak__calibrate_delay_is_known__weak__
ffffffffa8e03fd0 T __weak__calibrate_delay_is_known__weak__
ffffffffa8e03ff0 T __pfx___weak__calibration_delay_done__weak__
ffffffffa8e03ff0 W __pfx_calibration_delay_done
ffffffffa8e04000 T __weak__calibration_delay_done__weak__
ffffffffa8e04000 W calibration_delay_done
ffffffffa8e04010 T __pfx_calibrate_delay
ffffffffa8e04020 T calibrate_delay
ffffffffa8e04630 t __pfx_calibrate_delay_

As well as in the available_filter_functions:

__probestub_initcall_finish
do_one_initcall
__weak__free_initmem__weak__
run_init_process
trace_initcall_start_cb
trace_initcall_finish_cb
rootfs_init_fs_context
wait_for_initramfs
__weak__calibrate_delay_is_known__weak__
__weak__calibration_delay_done__weak__
calibrate_delay

This makes kallsyms work properly now, as it does see the weak functions
and will not consider their code as part of the previous function.

Thoughts?

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/Makefile       |   1 +
 scripts/Makefile.build |  13 ++
 scripts/Makefile.lib   |   1 +
 scripts/weakfuncs.c    | 489 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 504 insertions(+)
 create mode 100644 scripts/weakfuncs.c

diff --git a/scripts/Makefile b/scripts/Makefile
index 6bcda4b9d054..c1336c0baf6e 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -5,6 +5,7 @@
 
 hostprogs-always-$(CONFIG_KALLSYMS)			+= kallsyms
 hostprogs-always-$(BUILD_C_RECORDMCOUNT)		+= recordmcount
+hostprogs-always-y					+= weakfuncs
 hostprogs-always-$(CONFIG_BUILDTIME_TABLE_SORT)		+= sorttable
 hostprogs-always-$(CONFIG_ASN1)				+= asn1_compiler
 hostprogs-always-$(CONFIG_MODULE_SIG_FORMAT)		+= sign-file
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index c16e4cf54d77..0b6c3b9de28b 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -148,6 +148,19 @@ cmd_gen_symversions_c =	$(call gen_symversions,c)
 
 endif
 
+# Due to recursion, we must skip empty.o.
+# The empty.o file is created in the make process in order to determine
+# the target endianness and word size. It is made before all other C
+# files, including recordmcount.
+cmd_weakfuncs =					\
+	if [ $(@) != "scripts/mod/empty.o" ]; then	\
+		$(objtree)/scripts/weakfuncs "$(@)";	\
+	fi;
+weakfuncs_source := $(srctree)/scripts/weakfuncs.c
+$(obj)/%.o: $(obj)/%.c $(weakfuncs_source) FORCE
+	$(call if_changed_rule,cc_o_c)
+	$(call cmd,force_checksrc)
+
 ifdef CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
 # compiler will not generate __mcount_loc use recordmcount or recordmcount.pl
 ifdef BUILD_C_RECORDMCOUNT
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 7395200538da..c20659251914 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -321,6 +321,7 @@ define rule_cc_o_c
 	$(call cmd,gen_objtooldep)
 	$(call cmd,gen_symversions_c)
 	$(call cmd,record_mcount)
+	$(call cmd,weakfuncs)
 	$(call cmd,warn_shared_object)
 endef
 
diff --git a/scripts/weakfuncs.c b/scripts/weakfuncs.c
new file mode 100644
index 000000000000..4051720dde49
--- /dev/null
+++ b/scripts/weakfuncs.c
@@ -0,0 +1,489 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <stdbool.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <elf.h>
+
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+
+#define APPEND_STR "__weak__"
+
+/* Will append APPEND_STR to the start and end */
+#define APPEND_STR_SIZE 16
+
+#define ALIGN(x, y) (((x) + (y) - 1) / (y) * (y))
+
+typedef union {
+	Elf32_Ehdr	e32;
+	Elf64_Ehdr	e64;
+} Elf_Ehdr;
+
+typedef union {
+	Elf32_Shdr	s32;
+	Elf64_Shdr	s64;
+} Elf_Shdr;
+
+typedef union {
+	Elf32_Sym	s32;
+	Elf64_Sym	s64;
+} Elf_Sym;
+
+struct elf {
+	void 		*map;
+	Elf_Ehdr	*ehdr;
+	Elf_Shdr	*shsym;
+	Elf_Shdr	*shstr;
+	const char	*shstrings;
+	const char	*strings;
+	char		*newstrings;
+	off_t		file_size;
+	off_t		newsym;
+	off_t		symend;
+	off_t		newstrstart;
+	size_t		origstrsize;
+	size_t		newstrend;
+	size_t		newstrsize;
+	int		fd;
+	bool		is_32;
+};
+
+static inline int e_shnum(struct elf *elf)
+{
+	if (elf->is_32)
+		return elf->ehdr->e32.e_shnum;
+	else
+		return elf->ehdr->e64.e_shnum;
+}
+
+static inline int e_shstrndx(struct elf *elf)
+{
+	if (elf->is_32)
+		return elf->ehdr->e32.e_shstrndx;
+	else
+		return elf->ehdr->e64.e_shstrndx;
+}
+
+static inline int sh_type(struct elf *elf, Elf_Shdr *shdr)
+{
+	if (elf->is_32)
+		return shdr->s32.sh_type;
+	else
+		return shdr->s64.sh_type;
+}
+
+static inline size_t sh_offset(struct elf *elf, Elf_Shdr *shdr)
+{
+	if (elf->is_32)
+		return shdr->s32.sh_offset;
+	else
+		return shdr->s64.sh_offset;
+}
+
+static inline size_t sh_size(struct elf *elf, Elf_Shdr *shdr)
+{
+	if (elf->is_32)
+		return shdr->s32.sh_size;
+	else
+		return shdr->s64.sh_size;
+}
+
+static inline size_t sh_entsize(struct elf *elf, Elf_Shdr *shdr)
+{
+	if (elf->is_32)
+		return shdr->s32.sh_entsize;
+	else
+		return shdr->s64.sh_entsize;
+}
+
+static inline const char *sh_name(struct elf *elf, Elf_Shdr *shdr)
+{
+	if (elf->is_32)
+		return elf->shstrings + shdr->s32.sh_name;
+	else
+		return elf->shstrings + shdr->s64.sh_name;
+}
+
+static inline const char *sym_name(struct elf *elf, Elf_Sym *sym)
+{
+	if (elf->is_32)
+		return elf->strings + sym->s32.st_name;
+	else
+		return elf->strings + sym->s64.st_name;
+}
+
+static inline int sym_bind(struct elf *elf, Elf_Sym *sym)
+{
+	if (elf->is_32)
+		return ELF32_ST_BIND(sym->s32.st_info);
+	else
+		return ELF64_ST_BIND(sym->s64.st_info);
+}
+
+static inline size_t sym_value(struct elf *elf, Elf_Sym *sym)
+{
+	if (elf->is_32)
+		return sym->s32.st_value;
+	else
+		return sym->s64.st_value;
+}
+
+static inline int sym_size(struct elf *elf, Elf_Sym *sym)
+{
+	if (elf->is_32)
+		return sym->s32.st_size;
+	else
+		return sym->s64.st_size;
+}
+
+static inline int sym_shndx(struct elf *elf, Elf_Sym *sym)
+{
+	if (elf->is_32)
+		return sym->s32.st_shndx;
+	else
+		return sym->s64.st_shndx;
+}
+
+static inline Elf_Shdr *get_shdr(struct elf *elf, int index)
+{
+	if (elf->is_32) {
+		return elf->map + elf->ehdr->e32.e_shoff +
+			(index * elf->ehdr->e32.e_shentsize);
+	} else {
+		return elf->map + elf->ehdr->e64.e_shoff +
+			(index * elf->ehdr->e64.e_shentsize);
+	}
+}
+
+static void update_sym_bind(struct elf *elf, Elf_Sym *sym)
+{
+	int t;
+
+	if (elf->is_32) {
+		t = ELF32_ST_TYPE(sym->s32.st_info);
+		sym->s32.st_info = ELF32_ST_INFO(STB_GLOBAL, t);
+	} else {
+		t = ELF64_ST_TYPE(sym->s64.st_info);
+		sym->s64.st_info = ELF64_ST_INFO(STB_GLOBAL, t);
+	}	
+}
+
+static void update_sym_name(struct elf *elf, Elf_Sym *sym, size_t idx)
+{
+	if (elf->is_32)
+		sym->s32.st_name = idx;
+	else
+		sym->s64.st_name = idx;
+}
+
+static Elf_Shdr *find_sym_table(struct elf *elf)
+{
+	Elf_Shdr *shdr;
+
+	for (int i = 0; i < e_shnum(elf); i++) {
+		shdr = get_shdr(elf, i);
+		if (sh_type(elf, shdr) == SHT_SYMTAB)
+			return shdr;
+	}
+	return NULL;
+}
+
+static const char *find_strings(struct elf *elf)
+{
+	Elf_Shdr *shdr;
+
+	shdr = get_shdr(elf, e_shstrndx(elf));
+	elf->shstrings = elf->map + sh_offset(elf, shdr);
+
+	for (int i = 0; i < e_shnum(elf); i++) {
+		shdr = get_shdr(elf, i);
+		if (sh_type(elf, shdr) != SHT_STRTAB)
+			continue;
+
+		if (!strcmp(sh_name(elf, shdr), ".strtab")) {
+			elf->shstr = shdr;
+			elf->origstrsize = sh_size(elf, shdr);
+			return elf->map + sh_offset(elf, shdr);
+		}
+	}
+	return NULL;
+}
+
+static int add_string(struct elf *elf, const char *str)
+{
+	size_t size;
+	int len = strlen(str);
+	char *newstr;
+
+	size = elf->newstrsize + len + APPEND_STR_SIZE + 1;
+	newstr = realloc(elf->newstrings, size);
+	if (!newstr)
+		return -1;
+
+	elf->newstrings = newstr;
+
+	newstr += elf->newstrsize;
+
+	memcpy(newstr, APPEND_STR, APPEND_STR_SIZE / 2);
+	newstr += APPEND_STR_SIZE / 2;
+
+	memcpy(newstr, str, len);
+	newstr += len;
+
+	memcpy(newstr, APPEND_STR, APPEND_STR_SIZE / 2 + 1);
+
+	elf->newstrsize += len + APPEND_STR_SIZE + 1;
+
+	return 0;
+}
+
+static int process_weak_func(struct elf *elf, Elf_Sym *sym)
+{
+	static off_t symsize;
+	static void *buf;
+	const char *str;
+	Elf_Shdr *shdr;
+	off_t end;
+	ssize_t r;
+
+	shdr = get_shdr(elf, sym_shndx(elf, sym));
+	/* Make sure the section is executable */
+	if (sh_type(elf, shdr) != SHT_PROGBITS)
+		return 0;
+
+	if (!symsize) {
+		symsize = sh_entsize(elf, elf->shsym);
+		buf = calloc(1, symsize);
+		if (!buf) {
+			perror("Allocated temp buffer");
+			return -1;
+		}
+	}
+
+	if (!elf->newsym) {
+		void *symtab;
+		size_t size;
+
+		/* copy the symbol table */
+		end = elf->file_size;
+		/* Make aligned by symbol entry size */
+		end = ALIGN(end, symsize);
+
+		if (lseek(elf->fd, end, SEEK_SET) != end) {
+			perror("lseek");
+			return -1;
+		}
+
+		elf->newsym = end;
+		symtab = elf->map + sh_offset(elf, elf->shsym);
+		size = sh_size(elf, elf->shsym);
+		r = write(elf->fd, symtab, size);
+		if (r != size) {
+			perror("Copying symtable");
+			return -1;
+		}
+
+		/* Make sure it's still aligned */
+		end = lseek(elf->fd, 0, SEEK_END);
+		if (end < 0) {
+			perror("Getting new end of file");
+			return -1;
+		}
+
+		elf->symend = end;
+		end = ALIGN(end, symsize);
+		if (end != elf->symend) {
+			/* Add padding */
+			r = write(elf->fd, buf, end - elf->symend);
+			free(buf);
+			if (r < 0) {
+				perror("Adding padding");
+				return -1;
+			}
+			elf->symend = end;
+		}
+		elf->newstrend = elf->origstrsize;
+	}
+
+	memcpy(buf, sym, symsize);
+	sym = buf;
+	update_sym_bind(elf, sym);
+	str = sym_name(elf, sym);
+	update_sym_name(elf, sym, elf->newstrend);
+	elf->newstrend += strlen(str) + APPEND_STR_SIZE + 1;
+
+	if (add_string(elf, str) < 0) {
+		perror("Failed adding new string");
+		return -1;
+	}
+
+	r = write(elf->fd, sym, symsize);
+	if (r < 0) {
+		perror("Creating new symbol");
+		return -1;
+	}
+	elf->symend += symsize;
+
+	return 0;
+}
+
+static int add_new_strings(struct elf *elf)
+{
+	off_t end;
+	size_t r;
+
+	end = lseek(elf->fd, 0, SEEK_END);
+	if (end < 0) {
+		perror("lseek");
+		return -1;
+	}
+	elf->newstrstart = end;
+
+	r = write(elf->fd, elf->strings, elf->origstrsize);
+	if (r != elf->origstrsize) {
+		perror("Appending copy of string section");
+		return -1;
+	}
+
+	r = write(elf->fd, elf->newstrings, elf->newstrsize);
+	if (r != elf->newstrsize) {
+		perror("Appending new strings to section");
+		return -1;
+	}
+	
+	end = lseek(elf->fd, 0, SEEK_END);
+	if (end < 0) {
+		perror("lseek");
+		return -1;
+	}
+	elf->newstrend = end;
+
+	return 0;
+}
+
+static void update_shdr(struct elf *elf, Elf_Shdr *shdr,
+			size_t offset, size_t size)
+{
+	if (elf->is_32) {
+		shdr->s32.sh_offset = offset;
+		shdr->s32.sh_size = size;
+	} else {
+		shdr->s64.sh_offset = offset;
+		shdr->s64.sh_size = size;
+	}
+}
+
+static void update_elf(struct elf *elf)
+{
+	update_shdr(elf, elf->shsym, elf->newsym, elf->symend - elf->newsym);
+	update_shdr(elf, elf->shstr, elf->newstrstart,
+		    elf->newstrend - elf->newstrstart);
+}
+
+static int add_weak_funcs(struct elf *elf)
+{
+	Elf_Shdr *sh_sym = find_sym_table(elf);
+	Elf_Sym *sym;
+	void *end_sym;
+
+	if (!sh_sym) {
+		fprintf(stderr, "Could not find symbol table\n");
+		return -1;
+	}
+
+	elf->shsym = sh_sym;
+	elf->strings = find_strings(elf);
+	if (!elf->strings) {
+		fprintf(stderr, "Could not find string table\n");
+		return -1;
+	}
+
+	sym = elf->map + sh_offset(elf, sh_sym);
+	end_sym = elf->map + sh_offset(elf, sh_sym) + sh_size(elf, sh_sym);
+
+	while ((void *)sym < end_sym) {
+		if (sym_bind(elf, sym) == STB_WEAK) {
+			if (process_weak_func(elf, sym) < 0)
+				return -1;
+		}
+		sym = (void *)sym + sh_entsize(elf, sh_sym);
+	}
+
+	if (elf->newstrings) {
+		if (add_new_strings(elf) < 0)
+			return -1;
+		update_elf(elf);
+	}
+
+	return 0;
+}
+
+static int handle_weak_funcs(const char *file)
+{
+	struct elf elf = {};
+	struct stat st;
+	void *map;
+	int ret = -1;
+	int fd;
+
+	if (stat(file, &st) < 0) {
+		perror(file);
+		return -1;
+	}
+
+	fd = open(file, O_RDWR);
+	if (fd < 0) {
+		perror(file);
+		return -1;
+	}
+
+	map = mmap(NULL, st.st_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	if (map == MAP_FAILED) {
+		perror("mmap");
+		return -1;
+	}
+
+	elf.map = map;
+	elf.ehdr = map;
+	elf.fd = fd;
+	elf.file_size = st.st_size;
+
+	switch (elf.ehdr->e32.e_machine) {
+	case EM_386:
+		elf.is_32 = true;
+		break;
+	case EM_X86_64:
+		elf.is_32 = false;
+		break;
+	default:
+		fprintf(stderr, "ELF type %d is unsupported\n", elf.ehdr->e32.e_machine);
+		goto out;
+	}
+
+	ret = add_weak_funcs(&elf);
+	ret = 0;
+ out:
+	munmap(map, st.st_size);
+	close(fd);
+	return ret;
+}
+
+int main(int argc, char **argv)
+{
+	if (argc < 2) {
+		fprintf(stderr, "usage: weakfunc file.o ...\n");
+		exit(-1);
+	}
+
+	for (int i = 1; i < argc; i++) {
+		int ret = handle_weak_funcs(argv[i]);
+
+		if (ret < 0)
+			exit(ret);
+	}
+}
-- 
2.45.2


