Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC8362448E
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 15:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiKJOnq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 09:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiKJOno (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 09:43:44 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8292EF0A
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 06:43:43 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id l11so3418425edb.4
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 06:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfhLrjMmd1glswz5hr/esjMdBgxEvM9G/4scmePJDNc=;
        b=I5sV0GMAZOLkBAgLhGbxeN9KHa+zCD8CmcqVlmtfq6TbD9L/1DRsBwKKQPrVslRIOP
         mycbSSn096p8cbOQTDzAa6OpPp7b+PbQTDQNus986sosdV6uSrMzFqKigdiPv0L4N2Px
         8DK7DN/YngzC1Op4c+nTFa25y6rkWVhNHQVgjcFrs5wj5oBl9GlHJ1iqJk05E2d0V/Bp
         7HpbunpUlOhj1ObY0s6OqMVRzzMw/2zEwa98Nj9gUO/sVvhH952CvEAHJwyvt42KGy+g
         jqRKD7s1Uw0Jc8IPn9q5XL5CJE8IP41Q/usroeqiSzMhAugL0uU+wp0MJLJ2xtatS8AT
         EGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfhLrjMmd1glswz5hr/esjMdBgxEvM9G/4scmePJDNc=;
        b=VOAXmxCJzjMg+Hu5lGOfeYRBh4fFsz3VK1O9Y1edUpkBnt2Cpp6BhCEHpz1Znj9x9S
         SeVFGBhJzgAgZbGItW3ajiTNtLlzN+PWCH4bNAC98NJiRg/c+J8cIkwdbzuQjxvapnQO
         skNOPt3GKNT8LBWqYllq1YRYQfq1z0jnBD5F17IVlILui/YNjca/yiOW/EyediAoXwxN
         fODwEB42PK5ByZT3wzbpsObIsLCDHOiDjNlODFyeA85XEwa3rYwqPSXB+N/mJWA8o7Md
         L6tA6MqderWD3+3yeRr2ul0S0R6ys24pPPn60eREA+0lOiz603+2r8gbH6fuY96ogH7X
         unhg==
X-Gm-Message-State: ACrzQf2AWQGYBj4/D9P0xYuUhJ/ijFHjwtU9ndi0gSYY5uYfu6c95kNc
        mfVJqv9UV3g0yDp5H5MEV+hUi+zxUPOGwEKI
X-Google-Smtp-Source: AMsMyM6fXBbIk1k6if2xxa8ws9+0EZTHqJgxR3qiOUShVToPEttviUd93xjRHPVv6y92ti3lNQLMug==
X-Received: by 2002:a50:c01e:0:b0:460:fab2:c31f with SMTP id r30-20020a50c01e000000b00460fab2c31fmr2483066edb.335.1668091421831;
        Thu, 10 Nov 2022 06:43:41 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id g22-20020a50ee16000000b004616b006871sm8609272eds.82.2022.11.10.06.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 06:43:40 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: Dump data sections as part of btf_dump_test_case tests
Date:   Thu, 10 Nov 2022 16:43:19 +0200
Message-Id: <20221110144320.1075367-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221110144320.1075367-1-eddyz87@gmail.com>
References: <20221110144320.1075367-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Modify `test_btf_dump_case` to test `btf_dump__dump_type_data`
alongside `btf_dump__dump_type`.

The `test_btf_dump_case` function provides a convenient way to test
`btf_dump__dump_type` behavior as test cases are specified in separate
C files and any differences are reported using `diff` utility. This
commit extends `test_btf_dump_case` to call `btf_dump__dump_type_data`
for each `BTF_KIND_DATASEC` object in the test case object file.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_dump.c       | 118 +++++++++++++++---
 1 file changed, 104 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 24da335482d4..a0bdfc45660d 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include <bpf/btf.h>
+#include <libelf.h>
+#include <gelf.h>
 
 static int duration = 0;
 
@@ -23,31 +25,104 @@ static struct btf_dump_test_case {
 	{"btf_dump: namespacing", "btf_dump_test_case_namespacing", false},
 };
 
-static int btf_dump_all_types(const struct btf *btf, void *ctx)
+static int btf_dump_all_types(const struct btf *btf, struct btf_dump *d)
 {
 	size_t type_cnt = btf__type_cnt(btf);
-	struct btf_dump *d;
 	int err = 0, id;
 
-	d = btf_dump__new(btf, btf_dump_printf, ctx, NULL);
-	err = libbpf_get_error(d);
-	if (err)
-		return err;
-
 	for (id = 1; id < type_cnt; id++) {
 		err = btf_dump__dump_type(d, id);
 		if (err)
-			goto done;
+			break;
+	}
+
+	return err;
+}
+
+/* Keep this as macro to retain __FILE__, __LINE__ values used by PRINT_FAIL */
+#define report_elf_error(fn)								\
+	({										\
+		int __err = elf_errno();						\
+		PRINT_FAIL("%s() failed %s(%d)\n", fn, elf_errmsg(__err), __err);	\
+		__err;									\
+	})
+
+static int btf_dump_datasec(Elf *elf, const struct btf *btf, struct btf_dump *d, __u32 id)
+{
+	const char *btf_sec, *elf_sec;
+	const struct btf_type *t;
+	Elf_Data *data = NULL;
+	Elf_Scn *scn = NULL;
+	size_t shstrndx;
+	GElf_Shdr sh;
+
+	if (elf_getshdrstrndx(elf, &shstrndx))
+		return report_elf_error("elf_getshdrstrndx");
+
+	t = btf__type_by_id(btf, id);
+	btf_sec = btf__str_by_offset(btf, t->name_off);
+
+	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+		if (!gelf_getshdr(scn, &sh))
+			return report_elf_error("gelf_getshdr");
+		elf_sec = elf_strptr(elf, shstrndx, sh.sh_name);
+		if (!elf_sec)
+			return report_elf_error("elf_strptr");
+		if (strcmp(btf_sec, elf_sec) == 0) {
+			data = elf_getdata(scn, NULL);
+			if (!data)
+				return report_elf_error("elf_getdata");
+			break;
+		}
+	}
+
+	if (CHECK(!data, "btf_dump_datasec", "can't find ELF section %s\n", elf_sec))
+		return -1;
+
+	return btf_dump__dump_type_data(d, id, data->d_buf, data->d_size, NULL);
+}
+
+static int btf_dump_all_datasec(const struct btf *btf, struct btf_dump *d,
+				char *test_file, FILE *f)
+{
+	size_t type_cnt = btf__type_cnt(btf);
+	int err = 0, id, fd = 0;
+	Elf *elf = NULL;
+
+	fd = open(test_file, O_RDONLY | O_CLOEXEC);
+	if (CHECK(fd < 0, "open", "can't open %s for reading, %s(%d)\n",
+		  test_file, strerror(errno), errno)) {
+		err = errno;
+		goto done;
+	}
+
+	elf = elf_begin(fd, ELF_C_READ, NULL);
+	if (!elf) {
+		err = report_elf_error("elf_begin");
+		goto done;
+	}
+
+	for (id = 1; id < type_cnt; id++) {
+		if (!btf_is_datasec(btf__type_by_id(btf, id)))
+			continue;
+		err = btf_dump_datasec(elf, btf, d, id);
+		if (err)
+			break;
+		fprintf(f, "\n\n");
 	}
 
 done:
-	btf_dump__free(d);
+	if (fd)
+		close(fd);
+	if (elf)
+		elf_end(elf);
 	return err;
 }
 
 static int test_btf_dump_case(int n, struct btf_dump_test_case *t)
 {
 	char test_file[256], out_file[256], diff_cmd[1024];
+	struct btf_dump *d = NULL;
 	struct btf *btf = NULL;
 	int err = 0, fd = -1;
 	FILE *f = NULL;
@@ -86,12 +161,22 @@ static int test_btf_dump_case(int n, struct btf_dump_test_case *t)
 		goto done;
 	}
 
-	err = btf_dump_all_types(btf, f);
-	fclose(f);
-	close(fd);
-	if (CHECK(err, "btf_dump", "failure during C dumping: %d\n", err)) {
+	d = btf_dump__new(btf, btf_dump_printf, f, NULL);
+	err = libbpf_get_error(d);
+	if (CHECK(err, "btf_dump", "btf_dump__new failed: %d\n", err))
+		goto done;
+
+	err = btf_dump_all_types(btf, d);
+	if (CHECK(err, "btf_dump", "btf_dump_all_types failed: %d\n", err))
+		goto done;
+
+	err = btf_dump_all_datasec(btf, d, test_file, f);
+	if (CHECK(err, "btf_dump", "btf_dump_all_datasec failed: %d\n", err))
+		goto done;
+
+	if (CHECK(fflush(f), "btf_dump", "fflush() on %s failed: %s(%d)\n",
+		  test_file, strerror(errno), errno))
 		goto done;
-	}
 
 	snprintf(test_file, sizeof(test_file), "progs/%s.c", t->file);
 	if (access(test_file, R_OK) == -1)
@@ -122,6 +207,11 @@ static int test_btf_dump_case(int n, struct btf_dump_test_case *t)
 	remove(out_file);
 
 done:
+	if (f)
+		fclose(f);
+	if (fd >= 0)
+		close(fd);
+	btf_dump__free(d);
 	btf__free(btf);
 	return err;
 }
-- 
2.34.1

