Return-Path: <bpf+bounces-2104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C10727CE7
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 12:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855E91C20FFF
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 10:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C21CBE7F;
	Thu,  8 Jun 2023 10:35:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A41A94E
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 10:35:43 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFAE2D46
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 03:35:38 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6260e771419so1985776d6.1
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 03:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686220537; x=1688812537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFKcJn3VhrX3jN6M8CYGvDQgnPeR9FxZhN0RrOT/Q78=;
        b=gHFHZ3DDDzXXt9AxTlK7wR+lZr1/QqyX9uLafDFZ5vm2kxQpbs+0EsgazYI1monRaQ
         X6dS4/PfG+j0rGn1SQVewtbW0kCoJ8ggVcrJ+41UQ+WIdZJM7vAh/M2nj8AyICXxGUtj
         nB3emouR5FZm8DVob5lPjPZ3ZmUYkMNF+uz70RSVRZ3+sU+FpE2nFdnBWSRlVED41CUd
         2NunuXaKeBexyU9I6zE3enXBhI50c3RunB/oeSyt7BJfbXTXQXDDyiYzi2e/Z7tGFzVC
         /9gKWz4fFd1Ec1zJelAODBLlijGhYQ7UkNE2T8sDp+JYwMC+6mKwfTGsOE4NtInJE6qr
         +GgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220537; x=1688812537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFKcJn3VhrX3jN6M8CYGvDQgnPeR9FxZhN0RrOT/Q78=;
        b=XNd1NXfWtGA4Q1rPOckS5wIkrIlRQesqV0EYjtoouYOIH+BY88NqfPnluH6FNmTjvx
         z6ir0Npb0sYifOOlL1q7hqT0EaikWCt+rFAXTfRPauUyImK6fETqEYQnwxAa+kT+1XgB
         Ahupb2mofcwokrQs3aWTOSpRyE2qK/ic+BkgH/6EVOuIH9g1lBeS9czBqnHn6Ml8hWZh
         1BQ1zAougnUAT1e0pBt6lHlvp9HdHuyTckXHyk5WC4oHSjdrJmol6BmWnxtQOXzr5PAO
         UtEVORviHjJmVm8tWAvefmDPFGXdPx93Eq2LSAk1aZlD+uxa4Voc4gOBEAk3y9gNGeNH
         30PA==
X-Gm-Message-State: AC+VfDxAUtO7U8+E6jPZKTG19z668gn6DxKM2roeRZP+346QcxFyiqAJ
	zQ4TYjAygJrFLzuUVqoeT8o=
X-Google-Smtp-Source: ACHHUZ46JqkV+yaYbw5DJSZbTe2H3cbVCys7N0MVjaJBnRJ4EKvoH/oy7iE1qm/Hhz2acM4xJXk6yw==
X-Received: by 2002:a05:6214:5017:b0:621:65de:f600 with SMTP id jo23-20020a056214501700b0062165def600mr832777qvb.1.1686220537483;
        Thu, 08 Jun 2023 03:35:37 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:2418:5400:4ff:fe77:b548])
        by smtp.gmail.com with ESMTPSA id p16-20020a0cf550000000b0062839fc6e36sm302714qvm.70.2023.06.08.03.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:35:37 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 02/11] bpftool: Add address filtering in kernel_syms_load()
Date: Thu,  8 Jun 2023 10:35:14 +0000
Message-Id: <20230608103523.102267-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230608103523.102267-1-laoar.shao@gmail.com>
References: <20230608103523.102267-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

To enhance the functionality of kernel_syms_load(), an extension is
proposed to allow filtering of specific addresses of interest. The
extension will ensure that the addresses being filtered are present in
the /proc/kallsyms file, which serves as a reference for valid kernel
symbols. If an address is found to be invalid or not present in
/proc/kallsyms, the function will return a value of -1, indicating an
error condition.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/bpf/bpftool/prog.c          |  6 ++--
 tools/bpf/bpftool/xlated_dumper.c | 72 +++++++++++++++++++++++++++++++--------
 tools/bpf/bpftool/xlated_dumper.h |  3 +-
 3 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 8443a14..116b5b5 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -777,7 +777,7 @@ static int do_show(int argc, char **argv)
 			__u32 *lens;
 			__u32 i;
 			if (info->nr_jited_ksyms) {
-				kernel_syms_load(&dd);
+				kernel_syms_load(&dd, NULL, 0);
 				ksyms = u64_to_ptr(info->jited_ksyms);
 			}
 
@@ -841,7 +841,7 @@ static int do_show(int argc, char **argv)
 				goto exit_free;
 		}
 	} else {
-		kernel_syms_load(&dd);
+		kernel_syms_load(&dd, NULL, 0);
 		dd.nr_jited_ksyms = info->nr_jited_ksyms;
 		dd.jited_ksyms = u64_to_ptr(info->jited_ksyms);
 		dd.btf = btf;
@@ -1927,7 +1927,7 @@ static int do_loader(int argc, char **argv)
 	if (verifier_logs) {
 		struct dump_data dd = {};
 
-		kernel_syms_load(&dd);
+		kernel_syms_load(&dd, NULL, 0);
 		dump_xlated_plain(&dd, (void *)gen.insns, gen.insns_sz, false, false);
 		kernel_syms_destroy(&dd);
 	}
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index da608e1..327c3d6 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -23,46 +23,88 @@ static int kernel_syms_cmp(const void *sym_a, const void *sym_b)
 	       ((struct kernel_sym *)sym_b)->address;
 }
 
-void kernel_syms_load(struct dump_data *dd)
+static int cmp_u64(const void *A, const void *B)
+{
+	const __u64 *a = A, *b = B;
+
+	return *a - *b;
+}
+
+/* Set @filter_addrs to filter out the interested addresses.
+ * The addresses in @filter_addrs must be in /proc/kallsyms.
+ * The number of addresses in @filter_addrs must be @filter_cnt.
+ * Each address in @filter_addrs must be unique.
+ *
+ * Return 0 on success, -1 on invalid filter, 1 on no symbols.
+ */
+int kernel_syms_load(struct dump_data *dd, const __u64 *filter_addrs,
+		     __u32 filter_cnt)
 {
 	struct kernel_sym *sym;
 	char buff[256];
-	void *tmp, *address;
+	void *tmp = NULL, *address;
+	bool realloc = true;
+	__u32 i = 0;
 	FILE *fp;
 
 	fp = fopen("/proc/kallsyms", "r");
 	if (!fp)
-		return;
+		return 1;
 
+	if (filter_addrs && filter_cnt)
+		qsort((void *)filter_addrs, filter_cnt, sizeof(__u64),
+		      cmp_u64);
 	while (fgets(buff, sizeof(buff), fp)) {
-		tmp = libbpf_reallocarray(dd->sym_mapping, dd->sym_count + 1,
-					  sizeof(*dd->sym_mapping));
-		if (!tmp) {
+		if (realloc) {
+			tmp = libbpf_reallocarray(dd->sym_mapping,
+						  dd->sym_count + 1,
+						  sizeof(*dd->sym_mapping));
+			if (!tmp) {
 out:
-			free(dd->sym_mapping);
-			dd->sym_mapping = NULL;
-			fclose(fp);
-			return;
+				free(dd->sym_mapping);
+				dd->sym_mapping = NULL;
+				fclose(fp);
+				return 1;
+			}
+			dd->sym_mapping = tmp;
+			sym = &dd->sym_mapping[dd->sym_count];
 		}
-		dd->sym_mapping = tmp;
-		sym = &dd->sym_mapping[dd->sym_count];
 		if (sscanf(buff, "%p %*c %s", &address, sym->name) != 2)
 			continue;
-		sym->address = (unsigned long)address;
 		if (!strcmp(sym->name, "__bpf_call_base")) {
-			dd->address_call_base = sym->address;
+			dd->address_call_base = (unsigned long)address;
 			/* sysctl kernel.kptr_restrict was set */
-			if (!sym->address)
+			if (!address)
 				goto out;
 		}
+		if (filter_addrs && filter_cnt) {
+			if ((__u64)address != filter_addrs[i]) {
+				if (realloc)
+					realloc = false;
+				continue;
+			}
+			if (i++ == filter_cnt)
+				break;
+			if (!realloc)
+				realloc = true;
+		}
+		sym->address = (unsigned long)address;
 		if (sym->address)
 			dd->sym_count++;
 	}
 
 	fclose(fp);
 
+	/* invalid filter address found */
+	if (filter_addrs && filter_cnt && i != filter_cnt) {
+		free(dd->sym_mapping);
+		dd->sym_mapping = NULL;
+		return -1;
+	}
+
 	qsort(dd->sym_mapping, dd->sym_count,
 	      sizeof(*dd->sym_mapping), kernel_syms_cmp);
+	return 0;
 }
 
 void kernel_syms_destroy(struct dump_data *dd)
diff --git a/tools/bpf/bpftool/xlated_dumper.h b/tools/bpf/bpftool/xlated_dumper.h
index 9a94637..14ecbd7 100644
--- a/tools/bpf/bpftool/xlated_dumper.h
+++ b/tools/bpf/bpftool/xlated_dumper.h
@@ -26,7 +26,8 @@ struct dump_data {
 	char scratch_buff[SYM_MAX_NAME + 8];
 };
 
-void kernel_syms_load(struct dump_data *dd);
+int kernel_syms_load(struct dump_data *dd, const __u64 *filter_addrs,
+		     __u32 filter_cnt);
 void kernel_syms_destroy(struct dump_data *dd);
 struct kernel_sym *kernel_syms_search(struct dump_data *dd, unsigned long key);
 void dump_xlated_json(struct dump_data *dd, void *buf, unsigned int len,
-- 
1.8.3.1


