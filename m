Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15033C767E
	for <lists+bpf@lfdr.de>; Tue, 13 Jul 2021 20:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhGMSi0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Jul 2021 14:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhGMSi0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Jul 2021 14:38:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC5CC0613DD
        for <bpf@vger.kernel.org>; Tue, 13 Jul 2021 11:35:35 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id dj21so14646128edb.0
        for <bpf@vger.kernel.org>; Tue, 13 Jul 2021 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0t8xnMhkRp3C3cF6dzKp9oUPrsgxh1IBWwGZGBZKEpA=;
        b=YJwxpak9XWIGKy3NQsuYgYGcKoPKmZLHI7XpwS5t9vJoDcDS9E43a6K7y1NkEgFC0a
         nYGzS+qfB/TtXTzUWCtAO06OfbIfeo4p8awm9k3mWe+opxLvcd/l4QGTlvy0mzBUjKz+
         c1K+CCCzvtMIeJGEZGVGmGPpandn/MtQOw923LIEknxZmdm0OR/XvGqOEsbJE21EPRw4
         1ViGQI6q4GvwtHZbwhS650p+981KoTdvscuQa31ptuZYlLLkWOqNc1VUS1VzCD/C70Fr
         XyXN1BTVQyCegW4a6vCSb4uEwQyN+ZoTbcOkbIKxBc2xK+MELfcKBJ2X00iR1TUBgO5q
         +Fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0t8xnMhkRp3C3cF6dzKp9oUPrsgxh1IBWwGZGBZKEpA=;
        b=VTrwmyiN4LCVuPF/iIcUekJRADMVpgcnGR4nIVBvkxZDVZylCnrlUFWU6HHjRoJq8H
         ge3YIWU7yzUFP/Ftt6VATCkRKmc7lTGJ439Hg1T5Bj7/H7gS2vQ64SGL6NRKtHfWoubX
         tTmRbKDDs8nuXWQ1jFsXxFl90xjNWhHbcYY7yxpCyaCCXRQ2DT9xqiCQ/elN9/Nvfgwg
         I9orimd3YCkqoqY6VXtJIDqnHBps8NtDYEeZ0dvC23UCgAI7IDIKKdLmaofV/c/9Pu+f
         hXZ14Op+/Km1gMxLHATnvi/AgiYyshwEX0ONo65L2XlNp0dro7HzyE3gAZIYWf+yZ8oT
         e42w==
X-Gm-Message-State: AOAM5329zzxguTrsJm0cMJUglSE+kRjtMXjEAKfplhn7hdp5iP1p5YG7
        jp2M3y8Uj4QQXKSPcbYh8apSmlcnR7A=
X-Google-Smtp-Source: ABdhPJw6CwPkAL6X9GO5kE1dfFiogcphYjB7TzbtKCWK6AxsOATqzdEChl7KBzIbtDulqJAT/mlzRw==
X-Received: by 2002:a05:6402:448:: with SMTP id p8mr7357391edw.60.1626201333471;
        Tue, 13 Jul 2021 11:35:33 -0700 (PDT)
Received: from [192.168.2.75] (host-95-232-75-128.retail.telecomitalia.it. [95.232.75.128])
        by smtp.gmail.com with ESMTPSA id v24sm4814871eds.44.2021.07.13.11.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 11:35:33 -0700 (PDT)
Subject: [PATCH bpf-next 2/2] tools/bpf/bpftool: xlated dump from ELF file
 directly
From:   Lorenzo Fontana <fontanalorenz@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net
References: <aa97c776-9a82-9acc-fb13-dd082fdcaa61@gmail.com>
Message-ID: <f01efeef-9653-0f5f-b76e-d37597ba08d5@gmail.com>
Date:   Tue, 13 Jul 2021 20:35:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <aa97c776-9a82-9acc-fb13-dd082fdcaa61@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpftool can dump an xlated or jitted representation
of the programs already loaded into the kernel.
That capability is very useful for understanding what
are the instructions the kernel will execute for that program.

However, sometimes the verifier does not load the program and
one cannot use this feature until changes are made to make the
verifier happy again.

This patch reuses the same dump function to dump the program
from an ELF file directly instead of loading the instructions
from a loaded file descriptor. In this way, the user
can use all the bpftool features for "xlated" without loading.

In particular, the "visual" command is very useful when combined
to this because the dot graph makes easy to spot bad instruction
sequences.

Usage:

  bpftool prog dump xlated elf program.o

It also works with the other commands like 'visual' to print
an dot representation of the program.

  bpftool prog dump xlated elf program.o visual

Signed-off-by: Lorenzo Fontana <fontanalorenz@gmail.com>
---
 tools/bpf/bpftool/common.c | 15 ++++++++++++---
 tools/bpf/bpftool/main.h   |  2 +-
 tools/bpf/bpftool/prog.c   | 26 +++++++++++++++++++++++---
 3 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 1828bba19020..b28d15505705 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -703,7 +703,7 @@ static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
 	return -1;
 }
 
-int prog_parse_fds(int *argc, char ***argv, int **fds)
+int prog_parse_fds(int *argc, char ***argv, int **fds, char **elf_filepath)
 {
 	if (is_prefix(**argv, "id")) {
 		unsigned int id;
@@ -763,9 +763,18 @@ int prog_parse_fds(int *argc, char ***argv, int **fds)
 		if ((*fds)[0] < 0)
 			return -1;
 		return 1;
+	} else if (is_prefix(**argv, "elf")) {
+		NEXT_ARGP();
+		if (!argc) {
+			p_err("expected ELF file path");
+			return -1;
+		}
+		*elf_filepath = **argv;
+		NEXT_ARGP();
+		return 1;
 	}
 
-	p_err("expected 'id', 'tag', 'name' or 'pinned', got: '%s'?", **argv);
+	p_err("expected 'id', 'tag', 'name', 'elf' or 'pinned', got: '%s'?", **argv);
 	return -1;
 }
 
@@ -779,7 +788,7 @@ int prog_parse_fd(int *argc, char ***argv)
 		p_err("mem alloc failed");
 		return -1;
 	}
-	nb_fds = prog_parse_fds(argc, argv, &fds);
+	nb_fds = prog_parse_fds(argc, argv, &fds, NULL);
 	if (nb_fds != 1) {
 		if (nb_fds > 1) {
 			p_err("several programs match this handle");
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index c1cf29798b99..f4e426d03b4a 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -187,7 +187,7 @@ int do_iter(int argc, char **argv) __weak;
 
 int parse_u32_arg(int *argc, char ***argv, __u32 *val, const char *what);
 int prog_parse_fd(int *argc, char ***argv);
-int prog_parse_fds(int *argc, char ***argv, int **fds);
+int prog_parse_fds(int *argc, char ***argv, int **fds, char **elf_filepath);
 int map_parse_fd(int *argc, char ***argv);
 int map_parse_fds(int *argc, char ***argv, int **fds);
 int map_parse_fd_and_info(int *argc, char ***argv, void *info, __u32 *info_len);
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index cc48726740ad..04fa9a83ef7e 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -537,7 +537,7 @@ static int do_show_subset(int argc, char **argv)
 		p_err("mem alloc failed");
 		return -1;
 	}
-	nb_fds = prog_parse_fds(&argc, &argv, &fds);
+	nb_fds = prog_parse_fds(&argc, &argv, &fds, NULL);
 	if (nb_fds < 1)
 		goto exit_free;
 
@@ -787,7 +787,10 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 static int do_dump(int argc, char **argv)
 {
 	struct bpf_prog_info_linear *info_linear;
+	struct bpf_object *obj;
+	struct bpf_program *prog;
 	char *filepath = NULL;
+	char *elf_filepath = NULL;
 	bool opcodes = false;
 	bool visual = false;
 	enum dump_mode mode;
@@ -817,7 +820,8 @@ static int do_dump(int argc, char **argv)
 		p_err("mem alloc failed");
 		return -1;
 	}
-	nb_fds = prog_parse_fds(&argc, &argv, &fds);
+	elf_filepath = malloc(sizeof(char) * PATH_MAX);
+	nb_fds = prog_parse_fds(&argc, &argv, &fds, &elf_filepath);
 	if (nb_fds < 1)
 		goto exit_free;
 
@@ -849,7 +853,6 @@ static int do_dump(int argc, char **argv)
 		linum = true;
 		NEXT_ARG();
 	}
-
 	if (argc) {
 		usage();
 		goto exit_close;
@@ -866,9 +869,26 @@ static int do_dump(int argc, char **argv)
 	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
 	arrays |= 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
 
+	if (elf_filepath != NULL) {
+		obj = bpf_object__open(elf_filepath); 
+		if (libbpf_get_error(obj)) {
+			p_err("ERROR: opening BPF object file failed");
+			return 0;
+		}
+
+		bpf_object__for_each_program(prog, obj) {
+			struct bpf_prog_info pinfo;
+			pinfo.xlated_prog_insns = ptr_to_u64(bpf_program__insns(prog));
+			pinfo.xlated_prog_len = bpf_program__size(prog);
+			err = prog_dump(&pinfo, mode, filepath, opcodes, visual, linum);
+		}
+		return 0;
+	}
+
 	if (json_output && nb_fds > 1)
 		jsonw_start_array(json_wtr);	/* root array */
 	for (i = 0; i < nb_fds; i++) {
+		printf("uno\n");
 		info_linear = bpf_program__get_prog_info_linear(fds[i], arrays);
 		if (IS_ERR_OR_NULL(info_linear)) {
 			p_err("can't get prog info: %s", strerror(errno));
-- 
2.32.0

