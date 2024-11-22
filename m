Return-Path: <bpf+bounces-45480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AF79D6571
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 22:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A842B226CA
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 21:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093DA18C01B;
	Fri, 22 Nov 2024 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVYWH1Es"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090F2189BBB;
	Fri, 22 Nov 2024 21:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732311894; cv=none; b=o2AznxaJ1wHuJvmoc38FbA4oGTqTqEH3Xtvso0kHMY8ntdcAp0TKLiNhAMWfTkIGwO3hzRovP3lmVWNvwrg/z5BcalSbcICCx39AUjqA+4xMdjSAYKO6z8+ckkjP1mpk+rVIvDklrJssjHvP+SUyMbvFRMftbtD5L+4zNWBe9Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732311894; c=relaxed/simple;
	bh=yXtuqdkqiON2FQH19Xn7p7JZipGsOreBJciOwCTFs18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mk3akLF3HrAvOvzfeKc5ZGvTGFA/pJgXGWftx9ecdwC0U0KkdFuMv9AFXtJBuqRXvcPMXZFl/Ce/AvxX/B3F+YQHY9G1x/FyOToCAO61Oshpy3wO52mpJ1J1uCY3QlpiG93qFcqaHHzKogHqUfYhw7e9ehZmmYdTU11wTLT3GXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVYWH1Es; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e625b00bcso2294446b3a.3;
        Fri, 22 Nov 2024 13:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732311892; x=1732916692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sm8FC1r21Nw50L3IKKoiZuwoYTrF/btnXG3N6DfxUlA=;
        b=IVYWH1EsTSmgHHazalvCjK4x7YUYRT4/kt2OCqqtPs7Zz+RMJYxwM3TRysqLpWdghD
         6Gz1ZNI74wWjwqPRujDz9cy9IoPQP1zy/a56pLRgyIoStaVWEUX2t8VUxf5x9JK5JYk4
         KAob19V2VxyqA+jq+qhCNX+MFPR7HkkWgLQwpW0wmCq/iz4vtoeEK9HyrARIn/7kE4qq
         M2KnFrl+RaZVfIBq9kNkt3fZOjKN6a16Qgxoje/+2GxubCnDBgGZNncbw/En+fzPi3o4
         ZYwxbTxFfKolgd1h2WXoB0f3/BFgd9nN5xCvno2HsPIp7xh0SVXQTDelPOfIcNO+48Oa
         uREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732311892; x=1732916692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sm8FC1r21Nw50L3IKKoiZuwoYTrF/btnXG3N6DfxUlA=;
        b=PAOtyTRY/sY+rNb64AkbZeXiDIKoTli3VZcGhVosXFpbNm3whkU21A/hIw+2YUsiA5
         y+ZEupneouF4jD5c+76VGqFhHGtoxd/iiQuZpo5shxvWlXUzaY/9M4P3XV7duDNqNq5+
         fZ+LJZtKswUpl+Kh/tN6wRHOooI6l0Hk8GytdckaaE5BdkJ+3YZnAA+Qr1tYcbGaW2a4
         Q8pEONmx9iVj2xKCV11uOIo3VkdikiSSIv0vAfDTRosJiMR2vUnCaV+GhaKh0pPgZM2Z
         K+3hSJaPsWmgTQv9LmMr/jNNWn6pDmSY4KFkEUv5KImR+06TPjQDlqJJ9/LrBO9YoJNN
         rZ3w==
X-Gm-Message-State: AOJu0Yz7YV0fdV2brbDYajZRRA7Mqa1HtIO8VD1aSfEgmpUpcKZ4Swla
	9cTuP23yWPdpRp6h0cfS8DuM7/u8keXbQTAvU1YgiijctGekIsqPcalkSg==
X-Gm-Gg: ASbGncvt4VXZe5pdESNoP5fXsluqOdWCXLngBNxJA2y+Vj+KLjJ0fvJXwMf5N8UH4lG
	0cOzSVfKdPCVfsTd4pnDhq0LVHijopjPWpcQawUtrHCvq1ag4aGXKlcOw5V8Zrjs+ORYj+X7G9e
	Sdl1xt6WrSmDLrUB6nwBdcJNFKcw4CcLgqHdCFnCakwRBWHKZ1jgDWksPX0Pj8Jo7c0gFJOXSep
	csKDyrqHUHvoE1TBVyTJCvZtKVTYygNwJpZlWaT5Uqq4Q==
X-Google-Smtp-Source: AGHT+IFG/fals+3GvKVYBp8jSQymkxugtsv22tdy0eBMbrfyCT0bDBmOInoCX2UCWUE0RtjRj5pUZg==
X-Received: by 2002:a05:6a00:810:b0:724:e77f:ffb4 with SMTP id d2e1a72fcca58-724e77fffeemr3970279b3a.18.1732311891823;
        Fri, 22 Nov 2024 13:44:51 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcbfbc69esm1838329a12.6.2024.11.22.13.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 13:44:51 -0800 (PST)
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
	Jiri Olsa <olsajiri@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Vadim Fedorenko <vadfed@meta.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH dwarves v2 1/1] btf_encoder: handle .BTF_ids section endianness
Date: Fri, 22 Nov 2024 13:44:31 -0800
Message-ID: <20241122214431.292196-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122214431.292196-1-eddyz87@gmail.com>
References: <20241122214431.292196-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_encoder__tag_kfuncs() reads .BTF_ids section to identify a set of
kfuncs present in the ELF file being processed.
This section consists of:
- arrays of uint32_t elements;
- arrays of records with the following structure:
  struct btf_id_and_flag {
      uint32_t id;
      uint32_t flags;
  };

When endianness of a binary operated by pahole differs from the host
system's endianness, these fields require byte-swapping before use.
Currently, this byte-swapping does not occur, resulting in kfuncs not
being marked with declaration tags.

This commit resolves the issue by introducing an endianness conversion
step for the .BTF_ids section data before the main processing stage.
Since the ELF file is opened in O_RDONLY mode, gelf_xlatetom()
cannot be used for endianness conversion.
Instead, a new type is introduced:

  struct local_elf_data {
	void *d_buf;
	size_t d_size;
	int64_t d_off;
	bool owns_buf;
  };

This structure is populated from the Elf_Data object representing
the .BTF_ids section. When byte-swapping is required, a local copy
of d_buf is created.

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>
Cc: Jiri Olsa <olsajiri@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Vadim Fedorenko <vadfed@meta.com>
Fixes: 72e88f29c6f7 ("pahole: Inject kfunc decl tags into BTF")
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 btf_encoder.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index e1adddf..06d4a61 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -33,6 +33,7 @@
 #include <stdint.h>
 #include <search.h> /* for tsearch(), tfind() and tdestroy() */
 #include <pthread.h>
+#include <byteswap.h>
 
 #define BTF_IDS_SECTION		".BTF_ids"
 #define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
@@ -145,6 +146,14 @@ struct btf_kfunc_set_range {
 	uint64_t end;
 };
 
+/* Like Elf_Data, but when there is a need to change the data read from ELF */
+struct local_elf_data {
+	void *d_buf;
+	size_t d_size;
+	int64_t d_off;
+	bool owns_buf;
+};
+
 static LIST_HEAD(encoders);
 static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
 
@@ -1681,7 +1690,8 @@ out:
 }
 
 /* Returns if `sym` points to a kfunc set */
-static int is_sym_kfunc_set(GElf_Sym *sym, const char *name, Elf_Data *idlist, size_t idlist_addr)
+static int is_sym_kfunc_set(GElf_Sym *sym, const char *name, struct local_elf_data *idlist,
+			    size_t idlist_addr)
 {
 	void *ptr = idlist->d_buf;
 	struct btf_id_set8 *set;
@@ -1847,13 +1857,52 @@ static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *
 	return 0;
 }
 
+/* If byte order of 'elf' differs from current byte order, convert the data->d_buf.
+ * ELF file is opened in a readonly mode, so data->d_buf cannot be modified in place.
+ * Instead, allocate a new buffer if modification is necessary.
+ */
+static int convert_idlist_endianness(Elf *elf, Elf_Data *src, struct local_elf_data *dst)
+{
+	int byteorder, i;
+	char *elf_ident;
+	uint32_t *tmp;
+
+	dst->d_size = src->d_size;
+	dst->d_off = src->d_off;
+	elf_ident = elf_getident(elf, NULL);
+	if (elf_ident == NULL) {
+		fprintf(stderr, "Cannot get ELF identification from header\n");
+		return -EINVAL;
+	}
+	byteorder = elf_ident[EI_DATA];
+	if ((BYTE_ORDER == LITTLE_ENDIAN && byteorder == ELFDATA2LSB)
+	    || (BYTE_ORDER == BIG_ENDIAN && byteorder == ELFDATA2MSB)) {
+		dst->d_buf = src->d_buf;
+		dst->owns_buf = false;
+		return 0;
+	}
+	tmp = malloc(src->d_size);
+	if (tmp == NULL) {
+		fprintf(stderr, "Cannot allocate %lu bytes of memory\n", src->d_size);
+		return -ENOMEM;
+	}
+	memcpy(tmp, src->d_buf, src->d_size);
+	dst->d_buf = tmp;
+	dst->owns_buf = true;
+
+	/* .BTF_ids sections consist of u32 objects */
+	for (i = 0; i < dst->d_size / sizeof(uint32_t); i++)
+		tmp[i] = bswap_32(tmp[i]);
+	return 0;
+}
+
 static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 {
 	const char *filename = encoder->source_filename;
 	struct gobuffer btf_kfunc_ranges = {};
+	struct local_elf_data idlist = {};
 	struct gobuffer btf_funcs = {};
 	Elf_Data *symbols = NULL;
-	Elf_Data *idlist = NULL;
 	Elf_Scn *symscn = NULL;
 	int symbols_shndx = -1;
 	size_t idlist_addr = 0;
@@ -1918,7 +1967,9 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 		} else if (!strcmp(secname, BTF_IDS_SECTION)) {
 			idlist_shndx = i;
 			idlist_addr = shdr.sh_addr;
-			idlist = data;
+			err = convert_idlist_endianness(elf, data, &idlist);
+			if (err < 0)
+				goto out;
 		}
 	}
 
@@ -1960,7 +2011,7 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 			continue;
 
 		name = elf_strptr(elf, strtabidx, sym.st_name);
-		if (!is_sym_kfunc_set(&sym, name, idlist, idlist_addr))
+		if (!is_sym_kfunc_set(&sym, name, &idlist, idlist_addr))
 			continue;
 
 		range.start = sym.st_value;
@@ -2003,13 +2054,13 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 			if (ranges[j].start <= addr && addr < ranges[j].end) {
 				found = true;
 				off = addr - idlist_addr;
-				if (off < 0 || off + sizeof(*pair) > idlist->d_size) {
+				if (off < 0 || off + sizeof(*pair) > idlist.d_size) {
 					fprintf(stderr, "%s: kfunc '%s' offset outside section '%s'\n",
 						__func__, func, BTF_IDS_SECTION);
 					free(func);
 					goto out;
 				}
-				pair = idlist->d_buf + off;
+				pair = idlist.d_buf + off;
 				break;
 			}
 		}
@@ -2031,6 +2082,8 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 out:
 	__gobuffer__delete(&btf_funcs);
 	__gobuffer__delete(&btf_kfunc_ranges);
+	if (idlist.owns_buf)
+		free(idlist.d_buf);
 	if (elf)
 		elf_end(elf);
 	if (fd != -1)
-- 
2.47.0


