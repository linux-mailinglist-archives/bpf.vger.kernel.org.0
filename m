Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCD96D1C71
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 11:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjCaJdH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 05:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjCaJcs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 05:32:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD27B1EFD1
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 02:32:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 385C6B82DC9
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 09:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5790DC433EF;
        Fri, 31 Mar 2023 09:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680255142;
        bh=pyNWgB+BYt6NpQv+YewnAK13rBDkOHmrmZ5nKooSB6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eTA7RbfBKuibiGWD3ePU1wyxxanJKjdQzUrKHb+bcduXPLLWqcthSwlGwTdPI38UG
         SkbrhS9kc5o/mtnQUXYI+HGatGLXWAdzs2hviwgXyoAYvPwl29Q47+eOvXW/gEKqW+
         A4ztvnJZ28U5jQM4P32cKit7mKN4P7pdSZPJ1Hspv/WyAMHVyn91LqSaz+CGZyPkGn
         nplyy/aWgrY8GXKhc2yhHiq62sJXFh1TyTgi+e8TD3DZQyPQODQ+cWD2duD+0MrM1c
         nfM5FL4rcpuUpgCY0DccycSnyvjCFSkHV0Ka4WLHUmDJmMjo1zNL0MO6ny6uqV3poa
         TaMd6yOE4xp0Q==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCHv4 bpf-next 2/3] selftests/bpf: Add read_build_id function
Date:   Fri, 31 Mar 2023 11:31:56 +0200
Message-Id: <20230331093157.1749137-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331093157.1749137-1-jolsa@kernel.org>
References: <20230331093157.1749137-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding read_build_id function that parses out build id from
specified binary.

It will replace extract_build_id and also be used in following
changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/trace_helpers.c | 82 +++++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h |  5 ++
 2 files changed, 87 insertions(+)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 934bf28fc888..9b070cdf44ac 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -11,6 +11,9 @@
 #include <linux/perf_event.h>
 #include <sys/mman.h>
 #include "trace_helpers.h"
+#include <linux/limits.h>
+#include <libelf.h>
+#include <gelf.h>
 
 #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
 #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
@@ -234,3 +237,82 @@ ssize_t get_rel_offset(uintptr_t addr)
 	fclose(f);
 	return -EINVAL;
 }
+
+static int
+parse_build_id_buf(const void *note_start, Elf32_Word note_size, char *build_id)
+{
+	Elf32_Word note_offs = 0;
+
+	while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
+		Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_offs);
+
+		if (nhdr->n_type == 3 && nhdr->n_namesz == sizeof("GNU") &&
+		    !strcmp((char *)(nhdr + 1), "GNU") && nhdr->n_descsz > 0 &&
+		    nhdr->n_descsz <= BPF_BUILD_ID_SIZE) {
+			memcpy(build_id, note_start + note_offs +
+			       ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhdr), nhdr->n_descsz);
+			memset(build_id + nhdr->n_descsz, 0, BPF_BUILD_ID_SIZE - nhdr->n_descsz);
+			return (int) nhdr->n_descsz;
+		}
+
+		note_offs = note_offs + sizeof(Elf32_Nhdr) +
+			   ALIGN(nhdr->n_namesz, 4) + ALIGN(nhdr->n_descsz, 4);
+	}
+
+	return -ENOENT;
+}
+
+/* Reads binary from *path* file and returns it in the *build_id* buffer
+ * with *size* which is expected to be at least BPF_BUILD_ID_SIZE bytes.
+ * Returns size of build id on success. On error the error value is
+ * returned.
+ */
+int read_build_id(const char *path, char *build_id, size_t size)
+{
+	int fd, err = -EINVAL;
+	Elf *elf = NULL;
+	GElf_Ehdr ehdr;
+	size_t max, i;
+
+	if (size < BPF_BUILD_ID_SIZE)
+		return -EINVAL;
+
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -errno;
+
+	(void)elf_version(EV_CURRENT);
+
+	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
+	if (!elf)
+		goto out;
+	if (elf_kind(elf) != ELF_K_ELF)
+		goto out;
+	if (!gelf_getehdr(elf, &ehdr))
+		goto out;
+
+	for (i = 0; i < ehdr.e_phnum; i++) {
+		GElf_Phdr mem, *phdr;
+		char *data;
+
+		phdr = gelf_getphdr(elf, i, &mem);
+		if (!phdr)
+			goto out;
+		if (phdr->p_type != PT_NOTE)
+			continue;
+		data = elf_rawfile(elf, &max);
+		if (!data)
+			goto out;
+		if (phdr->p_offset + phdr->p_memsz > max)
+			goto out;
+		err = parse_build_id_buf(data + phdr->p_offset, phdr->p_memsz, build_id);
+		if (err > 0)
+			break;
+	}
+
+out:
+	if (elf)
+		elf_end(elf);
+	close(fd);
+	return err;
+}
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index 53efde0e2998..876f3e711df6 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -4,6 +4,9 @@
 
 #include <bpf/libbpf.h>
 
+#define __ALIGN_MASK(x, mask)	(((x)+(mask))&~(mask))
+#define ALIGN(x, a)		__ALIGN_MASK(x, (typeof(x))(a)-1)
+
 struct ksym {
 	long addr;
 	char *name;
@@ -23,4 +26,6 @@ void read_trace_pipe(void);
 ssize_t get_uprobe_offset(const void *addr);
 ssize_t get_rel_offset(uintptr_t addr);
 
+int read_build_id(const char *path, char *build_id, size_t size);
+
 #endif
-- 
2.39.2

