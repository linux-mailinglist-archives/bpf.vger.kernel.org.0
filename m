Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9C9C93BD
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 23:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfJBVvL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 17:51:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9756 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725875AbfJBVvI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Oct 2019 17:51:08 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x92LkrEO028424
        for <bpf@vger.kernel.org>; Wed, 2 Oct 2019 14:51:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=cRVPbUpr9jKcJT9LKlH4TlMYDkGrnGqFabjbGf5b7gE=;
 b=WEfMXm1LY1Dha6UlIQSiD2cuMkHu1mnCDi8X2Ih3rZDqMInlocHM3yvpg1sVMaba/DjU
 +aeYE8I81GAf1L34N05P6AAf5xHhDGNv9RV/r0CaacCZtF+Reyhh95JnIqxZoErIXeUi
 +5wBSlryP0u330XbkB9Py0SjnCc5rrE+9yc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vcddnp45m-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 14:51:06 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Oct 2019 14:51:05 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 6EF28861822; Wed,  2 Oct 2019 14:51:01 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 6/7] libbpf: add BPF_CORE_READ/BPF_CORE_READ_INTO helpers
Date:   Wed, 2 Oct 2019 14:50:40 -0700
Message-ID: <20191002215041.1083058-7-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002215041.1083058-1-andriin@fb.com>
References: <20191002215041.1083058-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-02_09:2019-10-01,2019-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 suspectscore=8 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910020172
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add few macros simplifying BCC-like multi-level probe reads, while also
emitting CO-RE relocations for each read.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/bpf_helpers.h | 143 ++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index cb9d4d2224af..847dfd7125e4 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -19,6 +19,10 @@
  */
 #define SEC(NAME) __attribute__((section(NAME), used))
 
+#ifndef __always_inline
+#define __always_inline __attribute__((always_inline))
+#endif
+
 /* helper functions called from eBPF programs written in C */
 static void *(*bpf_map_lookup_elem)(void *map, const void *key) =
 	(void *) BPF_FUNC_map_lookup_elem;
@@ -312,4 +316,143 @@ struct bpf_map_def {
 	bpf_probe_read(dst, sz,						    \
 		       (const void *)__builtin_preserve_access_index(src))
 
+/*
+ * bpf_core_read_str() is a thin wrapper around bpf_probe_read_str()
+ * additionally emitting BPF CO-RE field relocation for specified source
+ * argument.
+ */
+#define bpf_core_read_str(dst, sz, src)					    \
+	bpf_probe_read_str(dst, sz,					    \
+			   (const void *)__builtin_preserve_access_index(src))
+
+#define ___concat(a, b) a ## b
+#define ___apply(fn, n) ___concat(fn, n)
+#define ___nth(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, __11, N, ...) N
+
+/* return number of provided arguments; used for switch-based variadic macro
+ * definitions (see ___last, ___arrow, etc below)
+ */
+#define ___narg(...) ___nth(_, ##__VA_ARGS__, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
+/* return 0 if no arguments are passed, N - otherwise; used for
+ * recursively-defined macros to specify termination (0) case, and generic
+ * (N) case (e.g., ___read_ptrs, ___core_read)
+ */
+#define ___empty(...) ___nth(_, ##__VA_ARGS__, N, N, N, N, N, N, N, N, N, N, 0)
+
+#define ___last1(x) x
+#define ___last2(a, x) x
+#define ___last3(a, b, x) x
+#define ___last4(a, b, c, x) x
+#define ___last5(a, b, c, d, x) x
+#define ___last6(a, b, c, d, e, x) x
+#define ___last7(a, b, c, d, e, f, x) x
+#define ___last8(a, b, c, d, e, f, g, x) x
+#define ___last9(a, b, c, d, e, f, g, h, x) x
+#define ___last10(a, b, c, d, e, f, g, h, i, x) x
+#define ___last(...) ___apply(___last, ___narg(__VA_ARGS__))(__VA_ARGS__)
+
+#define ___nolast2(a, _) a
+#define ___nolast3(a, b, _) a, b
+#define ___nolast4(a, b, c, _) a, b, c
+#define ___nolast5(a, b, c, d, _) a, b, c, d
+#define ___nolast6(a, b, c, d, e, _) a, b, c, d, e
+#define ___nolast7(a, b, c, d, e, f, _) a, b, c, d, e, f
+#define ___nolast8(a, b, c, d, e, f, g, _) a, b, c, d, e, f, g
+#define ___nolast9(a, b, c, d, e, f, g, h, _) a, b, c, d, e, f, g, h
+#define ___nolast10(a, b, c, d, e, f, g, h, i, _) a, b, c, d, e, f, g, h, i
+#define ___nolast(...) ___apply(___nolast, ___narg(__VA_ARGS__))(__VA_ARGS__)
+
+#define ___arrow1(a) a
+#define ___arrow2(a, b) a->b
+#define ___arrow3(a, b, c) a->b->c
+#define ___arrow4(a, b, c, d) a->b->c->d
+#define ___arrow5(a, b, c, d, e) a->b->c->d->e
+#define ___arrow6(a, b, c, d, e, f) a->b->c->d->e->f
+#define ___arrow7(a, b, c, d, e, f, g) a->b->c->d->e->f->g
+#define ___arrow8(a, b, c, d, e, f, g, h) a->b->c->d->e->f->g->h
+#define ___arrow9(a, b, c, d, e, f, g, h, i) a->b->c->d->e->f->g->h->i
+#define ___arrow10(a, b, c, d, e, f, g, h, i, j) a->b->c->d->e->f->g->h->i->j
+#define ___arrow(...) ___apply(___arrow, ___narg(__VA_ARGS__))(__VA_ARGS__)
+
+#define ___type(...) typeof(___arrow(__VA_ARGS__))
+
+#define ___read(read_fn, dst, src_type, src, accessor)			    \
+	read_fn((void *)(dst), sizeof(*(dst)), &((src_type)(src))->accessor)
+
+/* "recursively" read a sequence of inner pointers using local __t var */
+#define ___rd_last(...)							    \
+	___read(bpf_core_read, &__t,					    \
+		___type(___nolast(__VA_ARGS__)), __t, ___last(__VA_ARGS__));
+#define ___rd_p0(src) const void *__t = src;
+#define ___rd_p1(...) ___rd_p0(___nolast(__VA_ARGS__)) ___rd_last(__VA_ARGS__)
+#define ___rd_p2(...) ___rd_p1(___nolast(__VA_ARGS__)) ___rd_last(__VA_ARGS__)
+#define ___rd_p3(...) ___rd_p2(___nolast(__VA_ARGS__)) ___rd_last(__VA_ARGS__)
+#define ___rd_p4(...) ___rd_p3(___nolast(__VA_ARGS__)) ___rd_last(__VA_ARGS__)
+#define ___rd_p5(...) ___rd_p4(___nolast(__VA_ARGS__)) ___rd_last(__VA_ARGS__)
+#define ___rd_p6(...) ___rd_p5(___nolast(__VA_ARGS__)) ___rd_last(__VA_ARGS__)
+#define ___rd_p7(...) ___rd_p6(___nolast(__VA_ARGS__)) ___rd_last(__VA_ARGS__)
+#define ___rd_p8(...) ___rd_p7(___nolast(__VA_ARGS__)) ___rd_last(__VA_ARGS__)
+#define ___rd_p9(...) ___rd_p8(___nolast(__VA_ARGS__)) ___rd_last(__VA_ARGS__)
+#define ___read_ptrs(src, ...)						    \
+	___apply(___rd_p, ___narg(__VA_ARGS__))(src, __VA_ARGS__)
+
+#define ___core_read0(fn, dst, src, a)					    \
+	___read(fn, dst, ___type(src), src, a);
+#define ___core_readN(fn, dst, src, ...)				    \
+	___read_ptrs(src, ___nolast(__VA_ARGS__))			    \
+	___read(fn, dst, ___type(src, ___nolast(__VA_ARGS__)), __t,	    \
+		___last(__VA_ARGS__));
+#define ___core_read(fn, dst, src, a, ...)				    \
+	___apply(___core_read, ___empty(__VA_ARGS__))(fn, dst,		    \
+						      src, a, ##__VA_ARGS__)
+
+/*
+ * BPF_CORE_READ_INTO() is a more performance-conscious variant of
+ * BPF_CORE_READ(), in which final field is read into user-provided storage.
+ * See BPF_CORE_READ() below for more details on general usage.
+ */
+#define BPF_CORE_READ_INTO(dst, src, a, ...)				    \
+	({								    \
+		___core_read(bpf_core_read, dst, src, a, ##__VA_ARGS__)	    \
+	})
+
+/*
+ * BPF_CORE_READ_STR_INTO() does same "pointer chasing" as
+ * BPF_CORE_READ() for intermediate pointers, but then executes (and returns
+ * corresponding error code) bpf_core_read_str() for final string read.
+ */
+#define BPF_CORE_READ_STR_INTO(dst, src, a, ...)			    \
+	({								    \
+		___core_read(bpf_core_read_str, dst, src, a, ##__VA_ARGS__) \
+	})
+
+/*
+ * BPF_CORE_READ() is used to simplify BPF CO-RE relocatable read, especially
+ * when there are few pointer chasing steps.
+ * E.g., what in non-BPF world (or in BPF w/ BCC) would be something like:
+ *	int x = s->a.b.c->d.e->f->g;
+ * can be succinctly achieved using BPF_CORE_READ as:
+ *	int x = BPF_CORE_READ(s, a.b.c, d.e, f, g);
+ *
+ * BPF_CORE_READ will decompose above statement into 4 bpf_core_read (BPF
+ * CO-RE relocatable bpf_probe_read() wrapper) calls, logically equivalent to:
+ * 1. const void *__t = s->a.b.c;
+ * 2. __t = __t->d.e;
+ * 3. __t = __t->f;
+ * 4. return __t->g;
+ *
+ * Equivalence is logical, because there is a heavy type casting/preservation
+ * involved, as well as all the reads are happening through bpf_probe_read()
+ * calls using __builtin_preserve_access_index() to emit CO-RE relocations.
+ *
+ * N.B. Only up to 9 "field accessors" are supported, which should be more
+ * than enough for any practical purpose.
+ */
+#define BPF_CORE_READ(src, a, ...)					    \
+	({								    \
+		___type(src, a, ##__VA_ARGS__) __r;			    \
+		BPF_CORE_READ_INTO(&__r, src, a, ##__VA_ARGS__);	    \
+		__r;							    \
+	})
+
 #endif
-- 
2.17.1

