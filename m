Return-Path: <bpf+bounces-45449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DAB9D59B8
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 08:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADF01F2199D
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 07:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D575D15C13E;
	Fri, 22 Nov 2024 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ebm+Cz3u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D9230999;
	Fri, 22 Nov 2024 07:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732258961; cv=none; b=JQF/9dX3gyKbxBdcHkEFqUkVbwG3NLRBOnbSWfLKECN8sl00Crw3tSWBygNAbutdy+7g3t13JoZKpm6o3655Fne+5nFS/E3iKpRSmPqLn0524kivzlSFCZCoC3y5xjSTNwAxczbXLIUaJNm0JUrJAKfxC35X6PhMG9OUz2oZj6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732258961; c=relaxed/simple;
	bh=BCzQavMbTLZovY7ZiCYU9OQQrG1Bbg+lSGciM7uD4oM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lnybeEqfGWem2C0efVUvtX1ahtM6BJuqrz58kIt+gYj7SLa061rVFJrRhaGNS6/nlF/X+lYwAw3crsi+SyQWMpd9o+xE+y2cwaKVsr9sAoNIp6opNsM+Izu/Ra6QBhxWfnfZFkcz90tRBqIc3mrRJuwk2vZpv5+DD+cMi7PGCMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ebm+Cz3u; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7246c8c9b1cso1459897b3a.3;
        Thu, 21 Nov 2024 23:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732258959; x=1732863759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LhhSvv5L8cYQpEtuyqj4yMfGtjtEeZ7T3AiRgYyYgoE=;
        b=Ebm+Cz3uXfwOMW+xbI1CqPAnHlhbYNQzA0L4pr7ZqfF+IwhBT2sKIDDyJ1FNGwaS2u
         A61xp+RD3wlV3A8gt5+HOsiHbgs6v6gsuaJwuKR+kDbSJSOWU9jyD9f4F5AVJoorBKJR
         mgeiyHYhsOrMq851p8jIHw1RjKWTb6zx47rsnROnl9eZX3mlNvqGWfmzrHVR+jTOkfFq
         xAv3VBUxD+386V6IOISvX9b2Mtim3l86gbSr0iCqL0yJnLyWVvHtZUP8CLXpINqNuDNe
         nLB9+TXdhTi5QtejNRNOBJxezRTdXq7E+bGsZrYbgV+Ws6T6nvnGQX7BSj1CP5iCq5So
         EbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732258959; x=1732863759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhhSvv5L8cYQpEtuyqj4yMfGtjtEeZ7T3AiRgYyYgoE=;
        b=chO4+OmS8oSi2o1zY1EVmmYoE41leS0G6CLGjzZTFBpzV33xc0H/goijkgJwpfQ2K6
         UUPBTV9Cexf2eA2+zVAjDjQdbi5TuctMY4ZJPJhHwnV1o2qNr8zwoHQncQX/xtIbr6i0
         xZYnnSwWg3kbkErLwB9GhTZa+uKtfJ0mflLc9IvflOYd3hdglVraZJWhX7k6EnObsoPr
         SZQ2V18p2n2miyuZaRXsj3fBA1gRzuuIMlObrGdNG7EadCCIJ2hkqCH7aR7NJM3c1DJO
         7HoxDdnFU6EAwlsxx88pOFJ8AZnW5A8Da4gjJFV4oUqfLcO2IBADgblgEnPw6oysBW7G
         mMcA==
X-Gm-Message-State: AOJu0YzCPmVNv6OByDr8w6o8fpigz3Zu6t1HN9/oimn4fvVLrSBwUABl
	stq2G5b5WD1CIEXB3XsdN9lkQob2bm73i2LNM8yuiVdQz/ZJqvR9T8Pacg==
X-Gm-Gg: ASbGncsUXeYlfjNTR8fobLKeHyhfBIc3KWMnnNjya9xhvN3mewiwZ9hlksn3vHWUB9j
	cYCfkmXwODQEDbYvYbR9yUdpF5LoaSIrhn+N7vF+DeghRlGbNEl6KgvxYEMe4HLtlkOBfpHi8/d
	q94WX3utEHjWtrQDj3YnyymsCM+xiC59azpDsA6bpHoRNFFfk3XVLgulhugWUlAUEYC2Qrjztpc
	7PFECw4BsvMc4lJu62XFroJFS5H/3P+fPsZ6rsaoxWgUQ==
X-Google-Smtp-Source: AGHT+IEk/H/JS2CEAhv7Q1icOOTs1AZvoyydLZF3P5nUuQqQgXSspCY6KbzAcjtw3e9LO0om2hKSrg==
X-Received: by 2002:a05:6a00:9282:b0:71e:cb5:2219 with SMTP id d2e1a72fcca58-724df63c337mr2207090b3a.9.1732258958849;
        Thu, 21 Nov 2024 23:02:38 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc219426sm929720a12.40.2024.11.21.23.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 23:02:38 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: dwarves@vger.kernel.org,
	arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org,
	kernel-team@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Vadim Fedorenko <vadfed@meta.com>
Subject: [PATCH dwarves v1] btf_encoder: handle .BTF_ids section endianness when cross-compiling
Date: Thu, 21 Nov 2024 23:02:18 -0800
Message-ID: <20241122070218.3832680-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_encoder__tag_kfuncs() reads .BTF_ids section to identify a set of
kfuncs present in the ELF being processed. This section consists of
records of the following shape:

  struct btf_id_and_flag {
      uint32_t id;
      uint32_t flags;
  };

When endianness of binary operated by pahole differs from the
host endianness these fields require byte swap before using.

At the moment such byte swap does not happen and kfuncs are not marked
with decl tags when e.g. s390 kernel is compiled on x86.
To reproduces the bug:
- follow instructions from [0] to build an s390 vmlinux;
- execute:
  pahole --btf_features_strict=decl_tag_kfuncs,decl_tag \
         --btf_encode_detached=test.btf vmlinux
- observe no kfuncs generated:
  bpftool btf dump test.btf format c | grep __ksym

This commit fixes the issue by adding an endianness conversion step
for .BTF_ids section data before main processing step, modifying the
Elf_Data object in-place.
The choice is such in order to:
- minimize changes;
- keep using Elf_Data, as it provides fields {d_size,d_off} used
  by kfunc processing routines;
- avoid sprinkling bswap_32 at each 'struct btf_id_and_flag' field
  access in fear of forgetting to add new ones when code is modified.

[0] https://docs.kernel.org/bpf/s390.html

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Vadim Fedorenko <vadfed@meta.com>
Fixes: 72e88f29c6f7 ("pahole: Inject kfunc decl tags into BTF")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 btf_encoder.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 lib/bpf       |  2 +-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index e1adddf..3bdb73b 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -33,6 +33,7 @@
 #include <stdint.h>
 #include <search.h> /* for tsearch(), tfind() and tdestroy() */
 #include <pthread.h>
+#include <byteswap.h>
 
 #define BTF_IDS_SECTION		".BTF_ids"
 #define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
@@ -1847,11 +1848,47 @@ static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *
 	return 0;
 }
 
+/* If byte order of 'elf' differs from current byte order, convert the data->d_buf.
+ * ELF file is opened in a readonly mode, so data->d_buf cannot be modified in place.
+ * Instead, allocate a new buffer if modification is necessary.
+ */
+static int convert_idlist_endianness(Elf *elf, Elf_Data *data, bool *copied)
+{
+	int byteorder, i;
+	char *elf_ident;
+	uint32_t *tmp;
+
+	*copied = false;
+	elf_ident = elf_getident(elf, NULL);
+	if (elf_ident == NULL) {
+		fprintf(stderr, "Cannot get ELF identification from header\n");
+		return -EINVAL;
+	}
+	byteorder = elf_ident[EI_DATA];
+	if ((BYTE_ORDER == LITTLE_ENDIAN && byteorder == ELFDATA2LSB)
+	    || (BYTE_ORDER == BIG_ENDIAN && byteorder == ELFDATA2MSB))
+		return 0;
+	tmp = malloc(data->d_size);
+	if (tmp == NULL) {
+		fprintf(stderr, "Cannot allocate %lu bytes of memory\n", data->d_size);
+		return -ENOMEM;
+	}
+	memcpy(tmp, data->d_buf, data->d_size);
+	data->d_buf = tmp;
+	*copied = true;
+
+	/* .BTF_ids sections consist of u32 objects */
+	for (i = 0; i < data->d_size / sizeof(uint32_t); i++)
+		tmp[i] = bswap_32(tmp[i]);
+	return 0;
+}
+
 static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 {
 	const char *filename = encoder->source_filename;
 	struct gobuffer btf_kfunc_ranges = {};
 	struct gobuffer btf_funcs = {};
+	bool free_idlist = false;
 	Elf_Data *symbols = NULL;
 	Elf_Data *idlist = NULL;
 	Elf_Scn *symscn = NULL;
@@ -1919,6 +1956,9 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 			idlist_shndx = i;
 			idlist_addr = shdr.sh_addr;
 			idlist = data;
+			err = convert_idlist_endianness(elf, idlist, &free_idlist);
+			if (err < 0)
+				goto out;
 		}
 	}
 
@@ -2031,6 +2071,8 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 out:
 	__gobuffer__delete(&btf_funcs);
 	__gobuffer__delete(&btf_kfunc_ranges);
+	if (free_idlist)
+		free(idlist->d_buf);
 	if (elf)
 		elf_end(elf);
 	if (fd != -1)
diff --git a/lib/bpf b/lib/bpf
index 09b9e83..caa17bd 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 09b9e83102eb8ab9e540d36b4559c55f3bcdb95d
+Subproject commit caa17bdcbfc58e68eaf4d017c058e6577606bf56
-- 
2.47.0


