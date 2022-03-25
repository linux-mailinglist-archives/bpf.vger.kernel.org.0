Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B8D4E6DBE
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 06:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353526AbiCYFbg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 25 Mar 2022 01:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiCYFbg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 01:31:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E47A580DF
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 22:30:02 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22P2qPfY029919
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 22:30:02 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f153u0mfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 22:30:01 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 22:30:00 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7180914CB0B92; Thu, 24 Mar 2022 22:29:51 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 3/7] libbpf: add USDT notes parsing and resolution logic
Date:   Thu, 24 Mar 2022 22:29:37 -0700
Message-ID: <20220325052941.3526715-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220325052941.3526715-1-andrii@kernel.org>
References: <20220325052941.3526715-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QFywvYzrnPV5qW7vjRcm1h1dmKWIJoPe
X-Proofpoint-GUID: QFywvYzrnPV5qW7vjRcm1h1dmKWIJoPe
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_01,2022-03-24_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement architecture-agnostic parts of USDT parsing logic. The code is
the documentation in this case, it's futile to try to succinctly
describe how USDT parsing is done in any sort of concreteness. But
still, USDTs are recorded in special ELF notes section (.note.stapsdt),
where each USDT call site is described separately. Along with USDT
provider and USDT name, each such note contains USDT argument
specification, which uses assembly-like syntax to describe how to fetch
value of USDT argument. USDT arg spec could be just a constant, or
a register, or a register dereference (most common cases in x86_64), but
it technically can be much more complicated cases, like offset relative
to global symbol and stuff like that. One of the later patches will
implement most common subset of this for x86 and x86-64 architectures,
which seems to handle a lot of real-world production application.

USDT arg spec contains a compact encoding allowing usdt.bpf.h from
previous patch to handle the above 3 cases. Instead of recording which
register might be needed, we encode register's offset within struct
pt_regs to simplify BPF-side implementation. USDT argument can be of
different byte sizes (1, 2, 4, and 8) and signed or unsigned. To handle
this, libbpf pre-calculates necessary bit shifts to do proper casting
and sign-extension in a short sequences of left and right shifts.

The rest is in the code with sometimes extensive comments and references
to external "documentation" for USDTs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/usdt.c | 581 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 580 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 8481e300598e..86d5d8390eb1 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -18,10 +18,56 @@
 
 #define PERF_UPROBE_REF_CTR_OFFSET_SHIFT 32
 
+#define USDT_BASE_SEC ".stapsdt.base"
+#define USDT_SEMA_SEC ".probes"
+#define USDT_NOTE_SEC  ".note.stapsdt"
+#define USDT_NOTE_TYPE 3
+#define USDT_NOTE_NAME "stapsdt"
+
+/* should match exactly enum __bpf_usdt_arg_type from bpf_usdt.bpf.h */
+enum usdt_arg_type {
+	USDT_ARG_CONST,
+	USDT_ARG_REG,
+	USDT_ARG_REG_DEREF,
+};
+
+/* should match exactly struct __bpf_usdt_arg_spec from bpf_usdt.bpf.h */
+struct usdt_arg_spec {
+	__u64 val_off;
+	enum usdt_arg_type arg_type;
+	short reg_off;
+	bool arg_signed;
+	char arg_bitshift;
+};
+
+/* should match BPF_USDT_MAX_ARG_CNT in usdt.bpf.h */
+#define USDT_MAX_ARG_CNT 12
+
+/* should match struct __bpf_usdt_spec from usdt.bpf.h */
+struct usdt_spec {
+	struct usdt_arg_spec args[USDT_MAX_ARG_CNT];
+	__u64 usdt_cookie;
+	short arg_cnt;
+};
+
+struct usdt_note {
+	const char *provider;
+	const char *name;
+	/* USDT args specification string, e.g.:
+	 * "-4@%esi -4@-24(%rbp) -4@%ecx 2@%ax 8@%rdx"
+	 */
+	const char *args;
+	long loc_addr;
+	long base_addr;
+	long sema_addr;
+};
+
 struct usdt_target {
 	long abs_ip;
 	long rel_ip;
 	long sema_off;
+	struct usdt_spec spec;
+	const char *spec_str;
 };
 
 struct usdt_manager {
@@ -127,11 +173,449 @@ static int sanity_check_usdt_elf(Elf *elf, const char *path)
 	return 0;
 }
 
+static int find_elf_sec_by_name(Elf *elf, const char *sec_name, GElf_Shdr *shdr, Elf_Scn **scn)
+{
+	Elf_Scn *sec = NULL;
+	size_t shstrndx;
+
+	if (elf_getshdrstrndx(elf, &shstrndx))
+		return -EINVAL;
+
+	/* check if ELF is corrupted and avoid calling elf_strptr if yes */
+	if (!elf_rawdata(elf_getscn(elf, shstrndx), NULL))
+		return -EINVAL;
+
+	while ((sec = elf_nextscn(elf, sec)) != NULL) {
+		char *name;
+
+		if (!gelf_getshdr(sec, shdr))
+			return -EINVAL;
+
+		name = elf_strptr(elf, shstrndx, shdr->sh_name);
+		if (name && strcmp(sec_name, name) == 0) {
+			*scn = sec;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+struct elf_seg {
+	long start;
+	long end;
+	long offset;
+	bool is_exec;
+};
+
+static int cmp_elf_segs(const void *_a, const void *_b)
+{
+	const struct elf_seg *a = _a;
+	const struct elf_seg *b = _b;
+
+	return a->start < b->start ? -1 : 1;
+}
+
+static int parse_elf_segs(Elf *elf, const char *path, struct elf_seg **segs, size_t *seg_cnt)
+{
+	GElf_Phdr phdr;
+	size_t n;
+	int i, err;
+	struct elf_seg *seg;
+	void *tmp;
+
+	*seg_cnt = 0;
+
+	if (elf_getphdrnum(elf, &n)) {
+		err = -errno;
+		return err;
+	}
+
+	for (i = 0; i < n; i++) {
+		if (!gelf_getphdr(elf, i, &phdr)) {
+			err = -errno;
+			return err;
+		}
+
+		pr_debug("usdt: discovered PHDR #%d in '%s': vaddr 0x%lx memsz 0x%lx offset 0x%lx type 0x%lx flags 0x%lx\n",
+			 i, path, (long)phdr.p_vaddr, (long)phdr.p_memsz, (long)phdr.p_offset,
+			 (long)phdr.p_type, (long)phdr.p_flags);
+		if (phdr.p_type != PT_LOAD)
+			continue;
+
+		tmp = libbpf_reallocarray(*segs, *seg_cnt + 1, sizeof(**segs));
+		if (!tmp)
+			return -ENOMEM;
+
+		*segs = tmp;
+		seg = *segs + *seg_cnt;
+		(*seg_cnt)++;
+
+		seg->start = phdr.p_vaddr;
+		seg->end = phdr.p_vaddr + phdr.p_memsz;
+		seg->offset = phdr.p_offset;
+		seg->is_exec = phdr.p_flags & PF_X;
+	}
+
+	if (*seg_cnt == 0) {
+		pr_warn("usdt: failed to find PT_LOAD program headers in '%s'\n", path);
+		return -ESRCH;
+	}
+
+	qsort(*segs, *seg_cnt, sizeof(**segs), cmp_elf_segs);
+	return 0;
+}
+
+static int parse_lib_segs(int pid, const char *lib_path, struct elf_seg **segs, size_t *seg_cnt)
+{
+	char path[PATH_MAX], line[PATH_MAX], mode[16];
+	size_t seg_start, seg_end, seg_off;
+	struct elf_seg *seg;
+	int tmp_pid, i, err;
+	FILE *f;
+
+	*seg_cnt = 0;
+
+	/* Handle containerized binaries only accessible from
+	 * /proc/<pid>/root/<path>. They will be reported as just /<path> in
+	 * /proc/<pid>/maps.
+	 */
+	if (sscanf(lib_path, "/proc/%d/root%s", &tmp_pid, path) == 2 && pid == tmp_pid)
+		goto proceed;
+
+	if (!realpath(lib_path, path)) {
+		pr_warn("usdt: failed to get absolute path of '%s' (err %d), using path as is...\n",
+			lib_path, -errno);
+		strcpy(path, lib_path);
+	}
+
+proceed:
+	sprintf(line, "/proc/%d/maps", pid);
+	f = fopen(line, "r");
+	if (!f) {
+		err = -errno;
+		pr_warn("usdt: failed to open '%s' to get base addr of '%s': %d\n",
+			line, lib_path, err);
+		return err;
+	}
+
+	/* We need to handle lines with no path at the end:
+	 *
+	 * 7f5c6f5d1000-7f5c6f5d3000 rw-p 001c7000 08:04 21238613      /usr/lib64/libc-2.17.so
+	 * 7f5c6f5d3000-7f5c6f5d8000 rw-p 00000000 00:00 0
+	 * 7f5c6f5d8000-7f5c6f5d9000 r-xp 00000000 103:01 362990598    /data/users/andriin/linux/tools/bpf/usdt/libhello_usdt.so
+	 */
+	while (fscanf(f, "%zx-%zx %s %zx %*s %*d%[^\n]\n",
+		      &seg_start, &seg_end, mode, &seg_off, line) == 5) {
+		void *tmp;
+
+		/* to handle no path case (see above) we need to capture line
+		 * without skipping any whitespaces. So we need to strip
+		 * leading whitespaces manually here
+		 */
+		i = 0;
+		while (isblank(line[i]))
+			i++;
+		if (strcmp(line + i, path) != 0)
+			continue;
+
+		pr_debug("usdt: discovered segment for lib '%s': addrs %zx-%zx mode %s offset %zx\n",
+			 path, seg_start, seg_end, mode, seg_off);
+
+		/* ignore non-executable sections for shared libs */
+		if (mode[2] != 'x')
+			continue;
+
+		tmp = libbpf_reallocarray(*segs, *seg_cnt + 1, sizeof(**segs));
+		if (!tmp) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+
+		*segs = tmp;
+		seg = *segs + *seg_cnt;
+		*seg_cnt += 1;
+
+		seg->start = seg_start;
+		seg->end = seg_end;
+		seg->offset = seg_off;
+		seg->is_exec = true;
+	}
+
+	if (*seg_cnt == 0) {
+		pr_warn("usdt: failed to find '%s' (resolved to '%s') within PID %d memory mappings\n",
+			lib_path, path, pid);
+		err = -ESRCH;
+		goto err_out;
+	}
+
+	qsort(*segs, *seg_cnt, sizeof(**segs), cmp_elf_segs);
+	err = 0;
+err_out:
+	fclose(f);
+	return err;
+}
+
+static struct elf_seg *find_elf_seg(struct elf_seg *segs, size_t seg_cnt, long addr, bool relative)
+{
+	struct elf_seg *seg;
+	int i;
+
+	if (relative) {
+		/* for shared libraries, address is relative offset and thus
+		 * should be fall within logical offset-based range of
+		 * [offset_start, offset_end)
+		 */
+		for (i = 0, seg = segs; i < seg_cnt; i++, seg++) {
+			if (seg->offset <= addr && addr < seg->offset + (seg->end - seg->start))
+				return seg;
+		}
+	} else {
+		/* for binaries, address is absolute and thus should be within
+		 * absolute address range of [seg_start, seg_end)
+		 */
+		for (i = 0, seg = segs; i < seg_cnt; i++, seg++) {
+			if (seg->start <= addr && addr < seg->end)
+				return seg;
+		}
+	}
+
+	return NULL;
+}
+
+static int parse_usdt_note(Elf *elf, const char *path, long base_addr,
+			   GElf_Nhdr *nhdr, const char *data, size_t name_off, size_t desc_off,
+			   struct usdt_note *usdt_note);
+
+static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note, long usdt_cookie);
+
 static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *path, pid_t pid,
 				const char *usdt_provider, const char *usdt_name, long usdt_cookie,
 				struct usdt_target **out_targets, size_t *out_target_cnt)
 {
-	return -ENOTSUP;
+	size_t off, name_off, desc_off, seg_cnt = 0, lib_seg_cnt = 0, target_cnt = 0;
+	struct elf_seg *segs = NULL, *lib_segs = NULL;
+	struct usdt_target *targets = NULL, *target;
+	long base_addr = 0;
+	Elf_Scn *notes_scn, *base_scn;
+	GElf_Shdr base_shdr, notes_shdr;
+	GElf_Ehdr ehdr;
+	GElf_Nhdr nhdr;
+	Elf_Data *data;
+	int err;
+
+	*out_targets = NULL;
+	*out_target_cnt = 0;
+
+	err = find_elf_sec_by_name(elf, USDT_NOTE_SEC, &notes_shdr, &notes_scn);
+	if (err)
+		return err;
+
+	if (notes_shdr.sh_type != SHT_NOTE)
+		return -EINVAL;
+
+	if (!gelf_getehdr(elf, &ehdr))
+		return -EINVAL;
+
+	err = parse_elf_segs(elf, path, &segs, &seg_cnt);
+	if (err) {
+		pr_warn("usdt: failed to process ELF program segments for '%s': %d\n", path, err);
+		goto err_out;
+	}
+
+	/* .stapsdt.base ELF section is optional, but is used for prelink
+	 * offset compensation (see a big comment further below)
+	 */
+	if (find_elf_sec_by_name(elf, USDT_BASE_SEC, &base_shdr, &base_scn) == 0)
+		base_addr = base_shdr.sh_addr;
+
+	data = elf_getdata(notes_scn, 0);
+	off = 0;
+	while ((off = gelf_getnote(data, off, &nhdr, &name_off, &desc_off)) > 0) {
+		long usdt_abs_ip, usdt_rel_ip, usdt_sema_off = 0;
+		struct usdt_note note;
+		struct elf_seg *seg = NULL;
+		void *tmp;
+
+		err = parse_usdt_note(elf, path, base_addr, &nhdr,
+				      data->d_buf, name_off, desc_off, &note);
+		if (err)
+			goto err_out;
+
+		if (strcmp(note.provider, usdt_provider) != 0 || strcmp(note.name, usdt_name) != 0)
+			continue;
+
+		/* We need to compensate "prelink effect". See [0] for details,
+		 * relevant parts quoted here:
+		 *
+		 * Each SDT probe also expands into a non-allocated ELF note. You can
+		 * find this by looking at SHT_NOTE sections and decoding the format;
+		 * see below for details. Because the note is non-allocated, it means
+		 * there is no runtime cost, and also preserved in both stripped files
+		 * and .debug files.
+		 *
+		 * However, this means that prelink won't adjust the note's contents
+		 * for address offsets. Instead, this is done via the .stapsdt.base
+		 * section. This is a special section that is added to the text. We
+		 * will only ever have one of these sections in a final link and it
+		 * will only ever be one byte long. Nothing about this section itself
+		 * matters, we just use it as a marker to detect prelink address
+		 * adjustments.
+		 *
+		 * Each probe note records the link-time address of the .stapsdt.base
+		 * section alongside the probe PC address. The decoder compares the
+		 * base address stored in the note with the .stapsdt.base section's
+		 * sh_addr. Initially these are the same, but the section header will
+		 * be adjusted by prelink. So the decoder applies the difference to
+		 * the probe PC address to get the correct prelinked PC address; the
+		 * same adjustment is applied to the semaphore address, if any. 
+		 *
+		 *   [0] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
+		 */
+		usdt_rel_ip = usdt_abs_ip = note.loc_addr;
+		if (base_addr) {
+			usdt_abs_ip += base_addr - note.base_addr;
+			usdt_rel_ip += base_addr - note.base_addr;
+		}
+
+		if (ehdr.e_type == ET_EXEC) {
+			/* When attaching uprobes (which what USDTs basically
+			 * are) kernel expects a relative IP to be specified,
+			 * so if we are attaching to an executable ELF binary
+			 * (i.e., not a shared library), we need to calculate
+			 * proper relative IP based on ELF's load address
+			 */
+			seg = find_elf_seg(segs, seg_cnt, usdt_abs_ip, false /* relative */);
+			if (!seg) {
+				err = -ESRCH;
+				pr_warn("usdt: failed to find ELF program segment for '%s:%s' in '%s' at IP 0x%lx\n",
+					usdt_provider, usdt_name, path, usdt_abs_ip);
+				goto err_out;
+			}
+			if (!seg->is_exec) {
+				err = -ESRCH;
+				pr_warn("usdt: matched ELF binary '%s' segment [0x%lx, 0x%lx) for '%s:%s' at IP 0x%lx is not executable\n",
+				        path, seg->start, seg->end, usdt_provider, usdt_name,
+					usdt_abs_ip);
+				goto err_out;
+			}
+
+			usdt_rel_ip = usdt_abs_ip - (seg->start - seg->offset);
+		} else if (!man->has_bpf_cookie) { /* ehdr.e_type == ET_DYN */
+			/* If we don't have BPF cookie support but need to
+			 * attach to a shared library, we'll need to know and
+			 * record absolute addresses of attach points due to
+			 * the need to lookup USDT spec by absolute IP of
+			 * triggered uprobe. Doing this resolution is only
+			 * possible when we have a specific PID of the process
+			 * that's using specified shared library. BPF cookie
+			 * removes the absolute address limitation as we don't
+			 * need to do this lookup (we just use BPF cookie as
+			 * an index of USDT spec), so for newer kernels with
+			 * BPF cookie support libbpf supports USDT attachment
+			 * to shared libraries with no PID filter.
+			 */
+			if (pid < 0) {
+				pr_warn("usdt: attaching to shared libaries without specific PID is not supported on current kernel\n");
+				err = -ENOTSUP;
+				goto err_out;
+			}
+
+			/* lib_segs are lazily initialized only if necessary */
+			if (lib_seg_cnt == 0) {
+				err = parse_lib_segs(pid, path, &lib_segs, &lib_seg_cnt);
+				if (err) {
+					pr_warn("usdt: failed to get memory segments in PID %d for shared library '%s': %d\n",
+						pid, path, err);
+					goto err_out;
+				}
+			}
+
+			seg = find_elf_seg(lib_segs, lib_seg_cnt, usdt_rel_ip, true /* relative */);
+			if (!seg) {
+				err = -ESRCH;
+				pr_warn("usdt: failed to find shared lib memory segment for '%s:%s' in '%s' at relative IP 0x%lx\n",
+				         usdt_provider, usdt_name, path, usdt_rel_ip);
+				goto err_out;
+			}
+
+			usdt_abs_ip = seg->start + (usdt_rel_ip - seg->offset);
+		}
+
+		pr_debug("usdt: probe for '%s:%s' in %s '%s': addr 0x%lx base 0x%lx (resolved abs_ip 0x%lx rel_ip 0x%lx) args '%s' in segment [0x%lx, 0x%lx) at offset 0x%lx\n",
+			 usdt_provider, usdt_name, ehdr.e_type == ET_EXEC ? "exec" : "lib ", path,
+			 note.loc_addr, note.base_addr, usdt_abs_ip, usdt_rel_ip, note.args,
+			 seg ? seg->start : 0, seg ? seg->end : 0, seg ? seg->offset : 0);
+
+		/* Adjust semaphore address to be a relative offset */
+		if (note.sema_addr) {
+			if (!man->has_sema_refcnt) {
+				pr_warn("usdt: kernel doesn't support USDT semaphore refcounting for '%s:%s' in '%s'\n",
+					usdt_provider, usdt_name, path);
+				err = -ENOTSUP;
+				goto err_out;
+			}
+
+			seg = find_elf_seg(segs, seg_cnt, note.sema_addr, false /* relative */);
+			if (!seg) {
+				err = -ESRCH;
+				pr_warn("usdt: failed to find ELF loadable segment with semaphore of '%s:%s' in '%s' at 0x%lx\n",
+				        usdt_provider, usdt_name, path, note.sema_addr);
+				goto err_out;
+			}
+			if (seg->is_exec) {
+				err = -ESRCH;
+				pr_warn("usdt: matched ELF binary '%s' segment [0x%lx, 0x%lx] for semaphore of '%s:%s' at 0x%lx is executable\n",
+					path, seg->start, seg->end, usdt_provider, usdt_name,
+					note.sema_addr);
+				goto err_out;
+			}
+
+			usdt_sema_off = note.sema_addr - (seg->start - seg->offset);
+
+			pr_debug("usdt: sema  for '%s:%s' in %s '%s': addr 0x%lx base 0x%lx (resolved 0x%lx) in segment [0x%lx, 0x%lx] at offset 0x%lx\n",
+				 usdt_provider, usdt_name, ehdr.e_type == ET_EXEC ? "exec" : "lib ",
+				 path, note.sema_addr, note.base_addr, usdt_sema_off,
+				 seg->start, seg->end, seg->offset);
+		}
+
+		/* Record adjusted addresses and offsets and parse USDT spec */
+		tmp = libbpf_reallocarray(targets, target_cnt + 1, sizeof(*targets));
+		if (!tmp) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+		targets = tmp;
+
+		target = &targets[target_cnt];
+		memset(target, 0, sizeof(*target));
+
+		target->abs_ip = usdt_abs_ip;
+		target->rel_ip = usdt_rel_ip;
+		target->sema_off = usdt_sema_off;
+
+		/* notes->args references strings from Elf itself, so they can
+		 * be referenced safely until elf_end() call
+		 */
+		target->spec_str = note.args;
+
+		err = parse_usdt_spec(&target->spec, &note, usdt_cookie);
+		if (err)
+			goto err_out;
+
+		target_cnt++;
+	}
+
+	*out_targets = targets;
+	*out_target_cnt = target_cnt;
+	err = target_cnt;
+
+err_out:
+	free(segs);
+	free(lib_segs);
+	if (err < 0)
+		free(targets);
+	return err;
 }
 
 struct bpf_link_usdt {
@@ -255,6 +739,7 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 		link->uprobe_cnt++;
 	}
 
+	free(targets);
 	elf_end(elf);
 	close(fd);
 
@@ -263,8 +748,102 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
 err_out:
 	bpf_link__destroy(&link->link);
 
+	free(targets);
 	if (elf)
 		elf_end(elf);
 	close(fd);
 	return libbpf_err_ptr(err);
 }
+
+/* Parse out USDT ELF note from '.note.stapsdt' section.
+ * Logic inspired by perf's code.
+ */
+static int parse_usdt_note(Elf *elf, const char *path, long base_addr,
+			   GElf_Nhdr *nhdr, const char *data, size_t name_off, size_t desc_off,
+			   struct usdt_note *note)
+{
+	const char *provider, *name, *args;
+	long addrs[3];
+	size_t len;
+
+	/* sanity check USDT note name and type first */
+	if (strncmp(data + name_off, USDT_NOTE_NAME, nhdr->n_namesz) != 0)
+		return -EINVAL;
+	if (nhdr->n_type != USDT_NOTE_TYPE)
+		return -EINVAL;
+
+	/* sanity check USDT note contents ("description" in ELF terminology) */
+	len = nhdr->n_descsz;
+	data = data + desc_off;
+
+	/* +3 is the very minimum required to store three empty strings */
+	if (len < sizeof(addrs) + 3)
+		return -EINVAL;
+
+	/* get location, base, and semaphore addrs */
+	memcpy(&addrs, data, sizeof(addrs));
+
+	/* parse string fields: provider, name, args */
+	provider = data + sizeof(addrs);
+
+	name = (const char *)memchr(provider, '\0', data + len - provider);
+	if (!name) /* non-zero-terminated provider */
+		return -EINVAL;
+	name++;
+	if (name >= data + len || *name == '\0') /* missing or empty name */
+		return -EINVAL;
+
+	args = memchr(name, '\0', data + len - name);
+	if (!args) /* non-zero-terminated name */
+		return -EINVAL;
+	++args;
+	if (args >= data + len) /* missing arguments spec */
+		return -EINVAL;
+
+	note->provider = provider;
+	note->name = name;
+	if (*args == '\0' || *args == ':')
+		note->args = "";
+	else
+		note->args = args;
+	note->loc_addr = addrs[0];
+	note->base_addr = addrs[1];
+	note->sema_addr = addrs[2];
+
+	return 0;
+}
+
+static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg);
+
+static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note, long usdt_cookie)
+{
+	const char *s;
+	int len;
+
+	spec->usdt_cookie = usdt_cookie;
+	spec->arg_cnt = 0;
+
+	s = note->args;
+	while (s[0]) {
+		if (spec->arg_cnt >= USDT_MAX_ARG_CNT) {
+			pr_warn("usdt: too many USDT arguments (> %d) for '%s:%s' with args spec '%s'\n",
+				USDT_MAX_ARG_CNT, note->provider, note->name, note->args);
+			return -E2BIG;
+		}
+
+		len = parse_usdt_arg(s, spec->arg_cnt, &spec->args[spec->arg_cnt]);
+		if (len < 0)
+			return len;
+
+		s += len;
+		spec->arg_cnt++;
+	}
+
+	return 0;
+}
+
+static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
+{
+	pr_warn("usdt: libbpf doesn't support USDTs on current architecture\n");
+	return -ENOTSUP;
+}
-- 
2.30.2

