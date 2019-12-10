Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAA90118D37
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2019 17:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfLJQGa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Dec 2019 11:06:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55370 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLJQGa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Dec 2019 11:06:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so3838336wmj.5;
        Tue, 10 Dec 2019 08:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uln2RQTubmbmSm3toUruFIx97rlDeVPfwi5Q0Gnu9/I=;
        b=RPDFxn9kPWUByBVBZ+oMx+RgX6lziNUqbSvCY38r/VN+EiI2Dn9A5lhuU2ADzyyjpy
         kSmN5xdbfMDQagpAfx0Wiz1sl24uyc9oRbnAr1Q0/jzDNmmnIRs533l5x2aTtbk2W+nN
         IBDqRDg8iqlvHWZykreh4MLzGuH32qad4NSTWiNA3xo88BHVXgso12XiDfAx73RAM6a9
         1agIasR9BT6rTy4WtZOIxchAMRrb5eb50BHpozvW98c+vFmkF2Pgc40OGi5TxtjuL7QO
         ezJzegwU7aOSA72EWl7++BHr49tg9SFiiPfqP+hdbpC2l49cpm2OhuejXkQ991bK/Tyg
         LGRw==
X-Gm-Message-State: APjAAAWMJBugClWFtMB17ZJYH2qALuqYfqB4m4df9rD5GHrBgzatm0Gp
        Kd4+axcdNN5zYESZTE9oCpU=
X-Google-Smtp-Source: APXvYqyFmO6uwEBQbCQkTsq1diaZvZU+0js46VZ5RCZ3ZfJeR+dEiP3BWbk6DSSmfoZNkLbKdDwWPA==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr6325437wmk.15.1575993986009;
        Tue, 10 Dec 2019 08:06:26 -0800 (PST)
Received: from Nover ([161.105.209.130])
        by smtp.gmail.com with ESMTPSA id z4sm3679962wme.17.2019.12.10.08.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:06:25 -0800 (PST)
Date:   Tue, 10 Dec 2019 17:06:25 +0100
From:   Paul Chaignon <paul.chaignon@orange.com>
To:     bpf@vger.kernel.org
Cc:     Quentin Monnet <quentin.monnet@netronome.com>,
        paul.chaignon@gmail.com, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next 1/3] bpftool: match several programs with same tag
Message-ID: <4db34d127179faafd6eca408792222c922969904.1575991886.git.paul.chaignon@orange.com>
References: <cover.1575991886.git.paul.chaignon@orange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575991886.git.paul.chaignon@orange.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When several BPF programs have the same tag, bpftool matches only the
first (in ID order).  This patch changes that behavior such that dump and
show commands return all matched programs.  Commands that require a single
program (e.g., pin and attach) will error out if given a tag that matches
several.  bpftool prog dump will also error out if file or visual are
given and several programs have the given tag.

In the case of the dump command, a program header is added before each
dump only if the tag matches several programs; this patch doesn't change
the output if a single program matches.

Signed-off-by: Paul Chaignon <paul.chaignon@orange.com>
---
 .../bpftool/Documentation/bpftool-prog.rst    |  16 +-
 tools/bpf/bpftool/prog.c                      | 371 ++++++++++++------
 2 files changed, 272 insertions(+), 115 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 7a374b3c851d..d377d0cb7923 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -53,8 +53,10 @@ DESCRIPTION
 ===========
 	**bpftool prog { show | list }** [*PROG*]
 		  Show information about loaded programs.  If *PROG* is
-		  specified show information only about given program, otherwise
-		  list all programs currently loaded on the system.
+		  specified show information only about given programs,
+		  otherwise list all programs currently loaded on the system.
+		  In case of **tag**, *PROG* may match several programs which
+		  will all be shown.
 
 		  Output will start with program ID followed by program type and
 		  zero or more named attributes (depending on kernel version).
@@ -68,11 +70,15 @@ DESCRIPTION
 		  performed via the **kernel.bpf_stats_enabled** sysctl knob.
 
 	**bpftool prog dump xlated** *PROG* [{ **file** *FILE* | **opcodes** | **visual** | **linum** }]
-		  Dump eBPF instructions of the program from the kernel. By
+		  Dump eBPF instructions of the programs from the kernel. By
 		  default, eBPF will be disassembled and printed to standard
 		  output in human-readable format. In this case, **opcodes**
 		  controls if raw opcodes should be printed as well.
 
+		  In case of **tag**, *PROG* may match several programs which
+		  will all be dumped.  However, if **file** or **visual** is
+		  specified, *PROG* must match a single program.
+
 		  If **file** is specified, the binary image will instead be
 		  written to *FILE*.
 
@@ -80,15 +86,17 @@ DESCRIPTION
 		  built instead, and eBPF instructions will be presented with
 		  CFG in DOT format, on standard output.
 
-		  If the prog has line_info available, the source line will
+		  If the programs have line_info available, the source line will
 		  be displayed by default.  If **linum** is specified,
 		  the filename, line number and line column will also be
 		  displayed on top of the source line.
 
 	**bpftool prog dump jited**  *PROG* [{ **file** *FILE* | **opcodes** | **linum** }]
 		  Dump jited image (host machine code) of the program.
+
 		  If *FILE* is specified image will be written to a file,
 		  otherwise it will be disassembled and printed to stdout.
+		  *PROG* must match a single program when **file** is specified.
 
 		  **opcodes** controls if raw opcodes will be printed.
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 4535c863d2cd..ca4278269e73 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -25,6 +25,11 @@
 #include "main.h"
 #include "xlated_dumper.h"
 
+enum dump_mode {
+	DUMP_JITED,
+	DUMP_XLATED,
+};
+
 static const char * const attach_type_strings[] = {
 	[BPF_SK_SKB_STREAM_PARSER] = "stream_parser",
 	[BPF_SK_SKB_STREAM_VERDICT] = "stream_verdict",
@@ -77,11 +82,13 @@ static void print_boot_time(__u64 nsecs, char *buf, unsigned int size)
 		strftime(buf, size, "%FT%T%z", &load_tm);
 }
 
-static int prog_fd_by_tag(unsigned char *tag)
+static int
+prog_fd_by_tag(unsigned char *tag, int *fds)
 {
 	unsigned int id = 0;
+	int fd, nb_fds = 0;
+	void *tmp;
 	int err;
-	int fd;
 
 	while (true) {
 		struct bpf_prog_info info = {};
@@ -89,36 +96,54 @@ static int prog_fd_by_tag(unsigned char *tag)
 
 		err = bpf_prog_get_next_id(id, &id);
 		if (err) {
-			p_err("%s", strerror(errno));
-			return -1;
+			if (errno != ENOENT) {
+				p_err("%s", strerror(errno));
+				goto err_close_fds;
+			}
+			return nb_fds;
 		}
 
 		fd = bpf_prog_get_fd_by_id(id);
 		if (fd < 0) {
 			p_err("can't get prog by id (%u): %s",
 			      id, strerror(errno));
-			return -1;
+			goto err_close_fds;
 		}
 
 		err = bpf_obj_get_info_by_fd(fd, &info, &len);
 		if (err) {
 			p_err("can't get prog info (%u): %s",
 			      id, strerror(errno));
-			close(fd);
-			return -1;
+			goto err_close_fd;
 		}
 
-		if (!memcmp(tag, info.tag, BPF_TAG_SIZE))
-			return fd;
+		if (memcmp(tag, info.tag, BPF_TAG_SIZE)) {
+			close(fd);
+			continue;
+		}
 
-		close(fd);
+		if (nb_fds > 0) {
+			tmp = realloc(fds, (nb_fds + 1) * sizeof(int));
+			if (!tmp) {
+				p_err("failed to realloc");
+				goto err_close_fd;
+			}
+			fds = tmp;
+		}
+		fds[nb_fds++] = fd;
 	}
+
+err_close_fd:
+	close(fd);
+err_close_fds:
+	for (nb_fds--; nb_fds >= 0; nb_fds--)
+		close(fds[nb_fds]);
+	return -1;
 }
 
-int prog_parse_fd(int *argc, char ***argv)
+static int
+prog_parse_fds(int *argc, char ***argv, int *fds)
 {
-	int fd;
-
 	if (is_prefix(**argv, "id")) {
 		unsigned int id;
 		char *endptr;
@@ -132,10 +157,12 @@ int prog_parse_fd(int *argc, char ***argv)
 		}
 		NEXT_ARGP();
 
-		fd = bpf_prog_get_fd_by_id(id);
-		if (fd < 0)
+		fds[0] = bpf_prog_get_fd_by_id(id);
+		if (fds[0] < 0) {
 			p_err("get by id (%u): %s", id, strerror(errno));
-		return fd;
+			return -1;
+		}
+		return 1;
 	} else if (is_prefix(**argv, "tag")) {
 		unsigned char tag[BPF_TAG_SIZE];
 
@@ -149,7 +176,7 @@ int prog_parse_fd(int *argc, char ***argv)
 		}
 		NEXT_ARGP();
 
-		return prog_fd_by_tag(tag);
+		return prog_fd_by_tag(tag, fds);
 	} else if (is_prefix(**argv, "pinned")) {
 		char *path;
 
@@ -158,13 +185,43 @@ int prog_parse_fd(int *argc, char ***argv)
 		path = **argv;
 		NEXT_ARGP();
 
-		return open_obj_pinned_any(path, BPF_OBJ_PROG);
+		fds[0] = open_obj_pinned_any(path, BPF_OBJ_PROG);
+		if (fds[0] < 0)
+			return -1;
+		return 1;
 	}
 
 	p_err("expected 'id', 'tag' or 'pinned', got: '%s'?", **argv);
 	return -1;
 }
 
+int prog_parse_fd(int *argc, char ***argv)
+{
+	int *fds = NULL;
+	int nb_fds, fd;
+
+	fds = malloc(sizeof(int));
+	if (!fds) {
+		p_err("mem alloc failed");
+		return -1;
+	}
+	nb_fds = prog_parse_fds(argc, argv, fds);
+	if (nb_fds != 1) {
+		if (nb_fds > 1) {
+			p_err("several programs match this handle");
+			for (nb_fds--; nb_fds >= 0; nb_fds--)
+				close(fds[nb_fds]);
+		}
+		fd = -1;
+		goto err_free;
+	}
+
+	fd = fds[0];
+err_free:
+	free(fds);
+	return fd;
+}
+
 static void show_prog_maps(int fd, u32 num_maps)
 {
 	struct bpf_prog_info info = {};
@@ -194,11 +251,9 @@ static void show_prog_maps(int fd, u32 num_maps)
 	}
 }
 
-static void print_prog_json(struct bpf_prog_info *info, int fd)
+static void
+print_prog_header_json(struct bpf_prog_info *info)
 {
-	char *memlock;
-
-	jsonw_start_object(json_wtr);
 	jsonw_uint_field(json_wtr, "id", info->id);
 	if (info->type < ARRAY_SIZE(prog_type_name))
 		jsonw_string_field(json_wtr, "type",
@@ -219,7 +274,15 @@ static void print_prog_json(struct bpf_prog_info *info, int fd)
 		jsonw_uint_field(json_wtr, "run_time_ns", info->run_time_ns);
 		jsonw_uint_field(json_wtr, "run_cnt", info->run_cnt);
 	}
+}
 
+static void
+print_prog_json(struct bpf_prog_info *info, int fd)
+{
+	char *memlock;
+
+	jsonw_start_object(json_wtr);
+	print_prog_header_json(info);
 	print_dev_json(info->ifindex, info->netns_dev, info->netns_ino);
 
 	if (info->load_time) {
@@ -268,10 +331,9 @@ static void print_prog_json(struct bpf_prog_info *info, int fd)
 	jsonw_end_object(json_wtr);
 }
 
-static void print_prog_plain(struct bpf_prog_info *info, int fd)
+static void
+print_prog_header_plain(struct bpf_prog_info *info)
 {
-	char *memlock;
-
 	printf("%u: ", info->id);
 	if (info->type < ARRAY_SIZE(prog_type_name))
 		printf("%s  ", prog_type_name[info->type]);
@@ -289,6 +351,14 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
 		printf(" run_time_ns %lld run_cnt %lld",
 		       info->run_time_ns, info->run_cnt);
 	printf("\n");
+}
+
+static void
+print_prog_plain(struct bpf_prog_info *info, int fd)
+{
+	char *memlock;
+
+	print_prog_header_plain(info);
 
 	if (info->load_time) {
 		char buf[32];
@@ -351,21 +421,43 @@ static int show_prog(int fd)
 
 static int do_show(int argc, char **argv)
 {
+	int fd, nb_fds, i;
+	int *fds = NULL;
 	__u32 id = 0;
 	int err;
-	int fd;
 
 	if (show_pinned)
 		build_pinned_obj_table(&prog_table, BPF_OBJ_PROG);
 
 	if (argc == 2) {
-		fd = prog_parse_fd(&argc, &argv);
-		if (fd < 0)
+		fds = malloc(sizeof(int));
+		if (!fds) {
+			p_err("mem alloc failed");
 			return -1;
+		}
+		nb_fds = prog_parse_fds(&argc, &argv, fds);
+		if (nb_fds < 1)
+			goto err_free;
 
-		err = show_prog(fd);
-		close(fd);
-		return err;
+		if (json_output && nb_fds > 1)
+			jsonw_start_array(json_wtr);	/* root array */
+		for (i = 0; i < nb_fds; i++) {
+			err = show_prog(fds[i]);
+			close(fds[i]);
+			if (err) {
+				for (i++; i < nb_fds; i++)
+					close(fds[i]);
+				goto err_free;
+			}
+		}
+		if (json_output && nb_fds > 1)
+			jsonw_end_array(json_wtr);	/* root array */
+
+		return 0;
+
+err_free:
+		free(fds);
+		return -1;
 	}
 
 	if (argc)
@@ -408,101 +500,32 @@ static int do_show(int argc, char **argv)
 	return err;
 }
 
-static int do_dump(int argc, char **argv)
+static int
+prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
+	  char *filepath, bool opcodes, bool visual, bool linum)
 {
-	struct bpf_prog_info_linear *info_linear;
 	struct bpf_prog_linfo *prog_linfo = NULL;
-	enum {DUMP_JITED, DUMP_XLATED} mode;
 	const char *disasm_opt = NULL;
-	struct bpf_prog_info *info;
 	struct dump_data dd = {};
 	void *func_info = NULL;
 	struct btf *btf = NULL;
-	char *filepath = NULL;
-	bool opcodes = false;
-	bool visual = false;
 	char func_sig[1024];
 	unsigned char *buf;
-	bool linum = false;
 	__u32 member_len;
-	__u64 arrays;
 	ssize_t n;
 	int fd;
 
-	if (is_prefix(*argv, "jited")) {
-		if (disasm_init())
-			return -1;
-		mode = DUMP_JITED;
-	} else if (is_prefix(*argv, "xlated")) {
-		mode = DUMP_XLATED;
-	} else {
-		p_err("expected 'xlated' or 'jited', got: %s", *argv);
-		return -1;
-	}
-	NEXT_ARG();
-
-	if (argc < 2)
-		usage();
-
-	fd = prog_parse_fd(&argc, &argv);
-	if (fd < 0)
-		return -1;
-
-	if (is_prefix(*argv, "file")) {
-		NEXT_ARG();
-		if (!argc) {
-			p_err("expected file path");
-			return -1;
-		}
-
-		filepath = *argv;
-		NEXT_ARG();
-	} else if (is_prefix(*argv, "opcodes")) {
-		opcodes = true;
-		NEXT_ARG();
-	} else if (is_prefix(*argv, "visual")) {
-		visual = true;
-		NEXT_ARG();
-	} else if (is_prefix(*argv, "linum")) {
-		linum = true;
-		NEXT_ARG();
-	}
-
-	if (argc) {
-		usage();
-		return -1;
-	}
-
-	if (mode == DUMP_JITED)
-		arrays = 1UL << BPF_PROG_INFO_JITED_INSNS;
-	else
-		arrays = 1UL << BPF_PROG_INFO_XLATED_INSNS;
-
-	arrays |= 1UL << BPF_PROG_INFO_JITED_KSYMS;
-	arrays |= 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
-	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;
-	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
-	arrays |= 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
-
-	info_linear = bpf_program__get_prog_info_linear(fd, arrays);
-	close(fd);
-	if (IS_ERR_OR_NULL(info_linear)) {
-		p_err("can't get prog info: %s", strerror(errno));
-		return -1;
-	}
-
-	info = &info_linear->info;
 	if (mode == DUMP_JITED) {
 		if (info->jited_prog_len == 0) {
 			p_info("no instructions returned");
-			goto err_free;
+			return -1;
 		}
 		buf = (unsigned char *)(info->jited_prog_insns);
 		member_len = info->jited_prog_len;
 	} else {	/* DUMP_XLATED */
 		if (info->xlated_prog_len == 0) {
 			p_err("error retrieving insn dump: kernel.kptr_restrict set?");
-			goto err_free;
+			return -1;
 		}
 		buf = (unsigned char *)info->xlated_prog_insns;
 		member_len = info->xlated_prog_len;
@@ -510,7 +533,7 @@ static int do_dump(int argc, char **argv)
 
 	if (info->btf_id && btf__get_from_id(info->btf_id, &btf)) {
 		p_err("failed to get btf");
-		goto err_free;
+		return -1;
 	}
 
 	func_info = (void *)info->func_info;
@@ -526,7 +549,7 @@ static int do_dump(int argc, char **argv)
 		if (fd < 0) {
 			p_err("can't open file %s: %s", filepath,
 			      strerror(errno));
-			goto err_free;
+			return -1;
 		}
 
 		n = write(fd, buf, member_len);
@@ -534,7 +557,7 @@ static int do_dump(int argc, char **argv)
 		if (n != member_len) {
 			p_err("error writing output file: %s",
 			      n < 0 ? strerror(errno) : "short write");
-			goto err_free;
+			return -1;
 		}
 
 		if (json_output)
@@ -548,7 +571,7 @@ static int do_dump(int argc, char **argv)
 						     info->netns_ino,
 						     &disasm_opt);
 			if (!name)
-				goto err_free;
+				return -1;
 		}
 
 		if (info->nr_jited_func_lens && info->jited_func_lens) {
@@ -643,11 +666,137 @@ static int do_dump(int argc, char **argv)
 		kernel_syms_destroy(&dd);
 	}
 
-	free(info_linear);
+	return 0;
+}
+
+static int
+do_dump(int argc, char **argv)
+{
+	struct bpf_prog_info_linear *info_linear;
+	char *filepath = NULL;
+	bool opcodes = false;
+	bool visual = false;
+	enum dump_mode mode;
+	bool linum = false;
+	int *fds = NULL;
+	int nb_fds, i;
+	__u64 arrays;
+
+	if (is_prefix(*argv, "jited")) {
+		if (disasm_init())
+			return -1;
+		mode = DUMP_JITED;
+	} else if (is_prefix(*argv, "xlated")) {
+		mode = DUMP_XLATED;
+	} else {
+		p_err("expected 'xlated' or 'jited', got: %s", *argv);
+		return -1;
+	}
+	NEXT_ARG();
+
+	if (argc < 2)
+		usage();
+
+	fds = malloc(sizeof(int));
+	if (!fds) {
+		p_err("mem alloc failed");
+		return -1;
+	}
+	nb_fds = prog_parse_fds(&argc, &argv, fds);
+	if (nb_fds < 1)
+		goto err_free;
+
+	if (is_prefix(*argv, "file")) {
+		NEXT_ARG();
+		if (!argc) {
+			p_err("expected file path");
+			goto err_close;
+		}
+		if (nb_fds > 1) {
+			p_err("several programs matched");
+			goto err_close;
+		}
+
+		filepath = *argv;
+		NEXT_ARG();
+	} else if (is_prefix(*argv, "opcodes")) {
+		opcodes = true;
+		NEXT_ARG();
+	} else if (is_prefix(*argv, "visual")) {
+		if (nb_fds > 1) {
+			p_err("several programs matched");
+			goto err_close;
+		}
+
+		visual = true;
+		NEXT_ARG();
+	} else if (is_prefix(*argv, "linum")) {
+		linum = true;
+		NEXT_ARG();
+	}
+
+	if (argc) {
+		usage();
+		goto err_close;
+	}
+
+	if (mode == DUMP_JITED)
+		arrays = 1UL << BPF_PROG_INFO_JITED_INSNS;
+	else
+		arrays = 1UL << BPF_PROG_INFO_XLATED_INSNS;
+
+	arrays |= 1UL << BPF_PROG_INFO_JITED_KSYMS;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
+	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
+
+	if (json_output && nb_fds > 1)
+		jsonw_start_array(json_wtr);	/* root array */
+	for (i = 0; i < nb_fds; i++) {
+		info_linear = bpf_program__get_prog_info_linear(fds[i], arrays);
+		close(fds[i]);
+		if (IS_ERR_OR_NULL(info_linear)) {
+			p_err("can't get prog info: %s", strerror(errno));
+			for (i++; i < nb_fds; i++)
+				close(fds[i]);
+			goto err_free;
+		}
+
+		if (json_output && nb_fds > 1) {
+			jsonw_start_object(json_wtr);	/* prog object */
+			print_prog_header_json(&info_linear->info);
+			jsonw_name(json_wtr, "insns");
+		} else if (nb_fds > 1) {
+			print_prog_header_plain(&info_linear->info);
+		}
+
+		if (prog_dump(&info_linear->info, mode, filepath, opcodes,
+			      visual, linum)) {
+			free(info_linear);
+			for (i++; i < nb_fds; i++)
+				close(fds[i]);
+			goto err_free;
+		}
+
+		if (json_output && nb_fds > 1)
+			jsonw_end_object(json_wtr);	/* prog object */
+		else if (i != nb_fds - 1 && nb_fds > 1)
+			printf("\n");
+
+		free(info_linear);
+	}
+	if (json_output && nb_fds > 1)
+		jsonw_end_array(json_wtr);	/* root array */
+
+	free(fds);
 	return 0;
 
+err_close:
+	for (i = 0; i < nb_fds; i++)
+		close(fds[i]);
 err_free:
-	free(info_linear);
+	free(fds);
 	return -1;
 }
 
-- 
2.17.1

