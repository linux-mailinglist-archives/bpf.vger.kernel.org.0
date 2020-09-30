Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0C727DF80
	for <lists+bpf@lfdr.de>; Wed, 30 Sep 2020 06:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgI3E2Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 00:28:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62218 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725801AbgI3E2Y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 30 Sep 2020 00:28:24 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U4Plgs003642
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=lJ6sBPE2SsRBPj3JEzVDrTLeHkbpgO+46xLL0W7pHkM=;
 b=NnGP/ZSF3lwfxevFOgmTkZA6uax9spD7Ij175LdG446WJsJ+SuRExznsm4fY8BuQexhQ
 YahiRlM13JRtmYMOQRxSuAjtrkWo7g7dyLL+zOlTi2OFebS4+4cTwbmNZwyEfxnFnycb
 lZbfp7lEs9q0T5YEEub0qTnrICR/1CFild8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33tn4tpgx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 21:28:23 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 21:28:22 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id BEAB82EC77F1; Tue, 29 Sep 2020 21:28:13 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <dwarves@vger.kernel.org>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH dwarves 10/11] strings: use BTF's string APIs for strings management
Date:   Tue, 29 Sep 2020 21:27:41 -0700
Message-ID: <20200930042742.2525310-11-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200930042742.2525310-1-andriin@fb.com>
References: <20200930042742.2525310-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_01:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 adultscore=0
 suspectscore=38 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300032
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch strings container to using struct btf and its
btf__add_str()/btf__find_str() APIs, which do equivalent internal string
deduplication. This turns out to be a very significantly faster than usin=
g
tsearch functions. To satisfy CTF encoding use case, some hacky string si=
ze
fetching approach is utilized, as libbpf doesn't provide direct API to ge=
t
total string section size and to copy over just strings data section.

BEFORE:
         22,624.28 msec task-clock                #    1.000 CPUs utilize=
d
                85      context-switches          #    0.004 K/sec
                 3      cpu-migrations            #    0.000 K/sec
           622,545      page-faults               #    0.028 M/sec
    68,177,206,387      cycles                    #    3.013 GHz         =
             (24.99%)
   114,370,031,619      instructions              #    1.68  insn per cyc=
le           (25.01%)
    26,125,001,179      branches                  # 1154.733 M/sec       =
             (25.01%)
       458,861,243      branch-misses             #    1.76% of all branc=
hes          (25.00%)
    24,533,455,967      L1-dcache-loads           # 1084.386 M/sec       =
             (25.02%)
       973,500,214      L1-dcache-load-misses     #    3.97% of all L1-dc=
ache hits    (25.05%)
       338,773,561      LLC-loads                 #   14.974 M/sec       =
             (25.02%)
        12,651,196      LLC-load-misses           #    3.73% of all LL-ca=
che hits     (25.00%)

      22.628910615 seconds time elapsed

      21.341063000 seconds user
       1.283763000 seconds sys

AFTER:
         18,362.97 msec task-clock                #    1.000 CPUs utilize=
d
                37      context-switches          #    0.002 K/sec
                 0      cpu-migrations            #    0.000 K/sec
           626,281      page-faults               #    0.034 M/sec
    52,480,619,000      cycles                    #    2.858 GHz         =
             (25.00%)
   104,736,434,384      instructions              #    2.00  insn per cyc=
le           (25.01%)
    23,878,428,465      branches                  # 1300.358 M/sec       =
             (25.01%)
       252,669,685      branch-misses             #    1.06% of all branc=
hes          (25.03%)
    21,829,390,952      L1-dcache-loads           # 1188.772 M/sec       =
             (25.04%)
       638,086,339      L1-dcache-load-misses     #    2.92% of all L1-dc=
ache hits    (25.02%)
       212,327,435      LLC-loads                 #   11.563 M/sec       =
             (25.00%)
        14,578,117      LLC-load-misses           #    6.87% of all LL-ca=
che hits     (25.00%)

      18.364427347 seconds time elapsed

      16.985494000 seconds user
       1.377959000 seconds sys

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 ctf_encoder.c |  2 +-
 libctf.c      | 14 ++++----
 libctf.h      |  4 +--
 strings.c     | 91 +++++++++++++++++++--------------------------------
 strings.h     | 32 +++---------------
 5 files changed, 49 insertions(+), 94 deletions(-)

diff --git a/ctf_encoder.c b/ctf_encoder.c
index 3cb455a33098..b761287d4534 100644
--- a/ctf_encoder.c
+++ b/ctf_encoder.c
@@ -248,7 +248,7 @@ int cu__encode_ctf(struct cu *cu, int verbose)
 	if (cu__cache_symtab(cu) < 0)
 		goto out_delete;
=20
-	ctf__set_strings(ctf, &strings->gb);
+	ctf__set_strings(ctf, strings);
=20
 	uint32_t id;
 	struct tag *pos;
diff --git a/libctf.c b/libctf.c
index 424f157c2415..7f375e47e9b2 100644
--- a/libctf.c
+++ b/libctf.c
@@ -19,6 +19,7 @@
 #include "ctf.h"
 #include "dutil.h"
 #include "gobuffer.h"
+#include "strings.h"
=20
 bool ctf__ignore_symtab_function(const GElf_Sym *sym, const char *sym_na=
me)
 {
@@ -284,7 +285,7 @@ int ctf__load_symtab(struct ctf *ctf)
 	return ctf->symtab =3D=3D NULL ? -1 : 0;
 }
=20
-void ctf__set_strings(struct ctf *ctf, struct gobuffer *strings)
+void ctf__set_strings(struct ctf *ctf, struct strings *strings)
 {
 	ctf->strings =3D strings;
 }
@@ -567,7 +568,7 @@ int ctf__encode(struct ctf *ctf, uint8_t flags)
 	size =3D (gobuffer__size(&ctf->types) +
 		gobuffer__size(&ctf->objects) +
 		gobuffer__size(&ctf->funcs) +
-		gobuffer__size(ctf->strings));
+		strings__size(ctf->strings));
=20
 	ctf->size =3D sizeof(*hdr) + size;
 	ctf->buf =3D malloc(ctf->size);
@@ -591,13 +592,13 @@ int ctf__encode(struct ctf *ctf, uint8_t flags)
 	hdr->ctf_type_off =3D offset;
 	offset +=3D gobuffer__size(&ctf->types);
 	hdr->ctf_str_off  =3D offset;
-	hdr->ctf_str_len  =3D gobuffer__size(ctf->strings);
+	hdr->ctf_str_len  =3D strings__size(ctf->strings);
=20
 	void *payload =3D ctf->buf + sizeof(*hdr);
 	gobuffer__copy(&ctf->objects, payload + hdr->ctf_object_off);
 	gobuffer__copy(&ctf->funcs, payload + hdr->ctf_func_off);
 	gobuffer__copy(&ctf->types, payload + hdr->ctf_type_off);
-	gobuffer__copy(ctf->strings, payload + hdr->ctf_str_off);
+	strings__copy(ctf->strings, payload + hdr->ctf_str_off);
=20
 	*(char *)(ctf->buf + sizeof(*hdr) + hdr->ctf_str_off) =3D '\0';
 	if (flags & CTF_FLAGS_COMPR) {
@@ -620,11 +621,10 @@ int ctf__encode(struct ctf *ctf, uint8_t flags)
 	}
 #if 0
 	printf("\n\ntypes:\n entries: %d\n size: %u"
-		 "\nstrings:\n entries: %u\n size: %u\ncompressed size: %d\n",
+		 "\nstrings:\n size: %u\ncompressed size: %d\n",
 	       ctf->type_index,
 	       gobuffer__size(&ctf->types),
-	       gobuffer__nr_entries(ctf->strings),
-	       gobuffer__size(ctf->strings), size);
+	       strings__size(ctf->strings), size);
 #endif
 	int fd =3D open(ctf->filename, O_RDWR);
 	if (fd < 0) {
diff --git a/libctf.h b/libctf.h
index 071616c72de3..749be8955c52 100644
--- a/libctf.h
+++ b/libctf.h
@@ -24,7 +24,7 @@ struct ctf {
 	struct gobuffer	  objects; /* data/variables */
 	struct gobuffer	  types;
 	struct gobuffer	  funcs;
-	struct gobuffer   *strings;
+	struct strings   *strings;
 	char		  *filename;
 	size_t		  size;
 	int		  swapped;
@@ -76,7 +76,7 @@ int ctf__add_function(struct ctf *ctf, uint16_t type, u=
int16_t nr_parms,
=20
 int ctf__add_object(struct ctf *ctf, uint16_t type);
=20
-void ctf__set_strings(struct ctf *ctf, struct gobuffer *strings);
+void ctf__set_strings(struct ctf *ctf, struct strings *strings);
 int  ctf__encode(struct ctf *ctf, uint8_t flags);
=20
 char *ctf__string(struct ctf *ctf, uint32_t ref);
diff --git a/strings.c b/strings.c
index ddb2b1bd85b5..45f8faaeb15d 100644
--- a/strings.c
+++ b/strings.c
@@ -15,75 +15,41 @@
 #include <zlib.h>
=20
 #include "dutil.h"
+#include "lib/bpf/src/libbpf.h"
=20
 struct strings *strings__new(void)
 {
 	struct strings *strs =3D malloc(sizeof(*strs));
=20
-	if (strs !=3D NULL) {
-		strs->tree =3D NULL;
-		gobuffer__init(&strs->gb);
+	if (!strs)
+		return NULL;
+
+	strs->btf =3D btf__new_empty();
+	if (libbpf_get_error(strs->btf)) {
+		free(strs);
+		return NULL;
 	}
=20
 	return strs;
-
-}
-
-static void do_nothing(void *ptr __unused)
-{
 }
=20
 void strings__delete(struct strings *strs)
 {
 	if (strs =3D=3D NULL)
 		return;
-	tdestroy(strs->tree, do_nothing);
-	__gobuffer__delete(&strs->gb);
+	btf__free(strs->btf);
 	free(strs);
 }
=20
-static strings_t strings__insert(struct strings *strs, const char *s)
-{
-	return gobuffer__add(&strs->gb, s, strlen(s) + 1);
-}
-
-struct search_key {
-	struct strings *strs;
-	const char *str;
-};
-
-static int strings__compare(const void *a, const void *b)
-{
-	const struct search_key *key =3D a;
-
-	return strcmp(key->str, key->strs->gb.entries + (unsigned long)b);
-}
-
 strings_t strings__add(struct strings *strs, const char *str)
 {
-	unsigned long *s;
 	strings_t index;
-	struct search_key key =3D {
-		.strs =3D strs,
-		.str =3D str,
-	};
=20
 	if (str =3D=3D NULL)
 		return 0;
=20
-	s =3D tsearch(&key, &strs->tree, strings__compare);
-	if (s !=3D NULL) {
-		if (*(struct search_key **)s =3D=3D (void *)&key) { /* Not found, repl=
ace with the right key */
-			index =3D strings__insert(strs, str);
-			if (index !=3D 0)
-				*s =3D (unsigned long)index;
-			else {
-				tdelete(&key, &strs->tree, strings__compare);
-				return 0;
-			}
-		} else /* Found! */
-			index =3D *s;
-	} else
+	index =3D btf__add_str(strs->btf, str);
+	if (index < 0)
 		return 0;
=20
 	return index;
@@ -91,21 +57,32 @@ strings_t strings__add(struct strings *strs, const ch=
ar *str)
=20
 strings_t strings__find(struct strings *strs, const char *str)
 {
-	strings_t *s;
-	struct search_key key =3D {
-		.strs =3D strs,
-		.str =3D str,
-	};
+	return btf__find_str(strs->btf, str);
+}
=20
-	if (str =3D=3D NULL)
-		return 0;
+/* a horrible and inefficient hack to get string section size out of BTF=
 */
+strings_t strings__size(const struct strings *strs)
+{
+	const struct btf_header *p;
+	uint32_t sz;
+
+	p =3D btf__get_raw_data(strs->btf, &sz);
+	if (!p)
+		return -1;
=20
-	s =3D tfind(&key, &strs->tree, strings__compare);
-	return s ? *s : 0;
+	return p->str_len;
 }
=20
-int strings__cmp(const struct strings *strs, strings_t a, strings_t b)
+/* similarly horrible hack to copy out string section out of BTF */
+int strings__copy(const struct strings *strs, void *dst)
 {
-	return a =3D=3D b ? 0 : strcmp(strings__ptr(strs, a),
-				   strings__ptr(strs, b));
+	const struct btf_header *p;
+	uint32_t sz;
+
+	p =3D btf__get_raw_data(strs->btf, &sz);
+	if (!p)
+		return -1;
+
+	memcpy(dst, (void *)p + p->str_off, p->str_len);
+	return 0;
 }
diff --git a/strings.h b/strings.h
index 01f50efd7adb..522fbf21de0d 100644
--- a/strings.h
+++ b/strings.h
@@ -6,13 +6,12 @@
   Copyright (C) 2008 Arnaldo Carvalho de Melo <acme@redhat.com>
 */
=20
-#include "gobuffer.h"
+#include "lib/bpf/src/btf.h"
=20
 typedef unsigned int strings_t;
=20
 struct strings {
-	void		*tree;
-	struct gobuffer	gb;
+	struct btf *btf;
 };
=20
 struct strings *strings__new(void);
@@ -21,33 +20,12 @@ void strings__delete(struct strings *strings);
=20
 strings_t strings__add(struct strings *strings, const char *str);
 strings_t strings__find(struct strings *strings, const char *str);
-
-int strings__cmp(const struct strings *strings, strings_t a, strings_t b=
);
+strings_t strings__size(const struct strings *strings);
+int strings__copy(const struct strings *strings, void *dst);
=20
 static inline const char *strings__ptr(const struct strings *strings, st=
rings_t s)
 {
-	return gobuffer__ptr(&strings->gb, s);
-}
-
-static inline const char *strings__entries(const struct strings *strings=
)
-{
-	return gobuffer__entries(&strings->gb);
-}
-
-static inline unsigned int strings__nr_entries(const struct strings *str=
ings)
-{
-	return gobuffer__nr_entries(&strings->gb);
-}
-
-static inline strings_t strings__size(const struct strings *strings)
-{
-	return gobuffer__size(&strings->gb);
-}
-
-static inline const char *strings__compress(struct strings *strings,
-					    unsigned int *size)
-{
-	return gobuffer__compress(&strings->gb, size);
+	return btf__str_by_offset(strings->btf, s);
 }
=20
 #endif /* _STRINGS_H_ */
--=20
2.24.1

