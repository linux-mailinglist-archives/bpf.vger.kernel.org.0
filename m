Return-Path: <bpf+bounces-40149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5931197DB2B
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 03:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AE81C20EEA
	for <lists+bpf@lfdr.de>; Sat, 21 Sep 2024 01:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F81823D7;
	Sat, 21 Sep 2024 01:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMhiYtwQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7619223BE
	for <bpf@vger.kernel.org>; Sat, 21 Sep 2024 01:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726881462; cv=none; b=g9T/7YvH/EXlJRBWKTBSqxp1OYm9Oa/Wxim0A2O9YUZlTdolxXSN1g6gCIsRC4HdLLN08IduPccBFhkguKCnGlXXyuTxNUIw8RMh2bBc16fgCyHLwiuozOaybNBvBWYdVcbzGUHpvEqnryg9KBVrdPI24xXwQCsKbAp+PLR3N5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726881462; c=relaxed/simple;
	bh=mcAGPEMkqUg004bPxTc7SyCnzoMnCAJWW7FJyhTayj4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gay41dG09cBaVb0bWswjmKamqxnsSvuceGloZZouMWdlaZaGafOmasT60EIfb2KktN3XuVMVaJ6wgonoYMlPfo4bfWFvrlx5FB54iSvC7HXK9V9lzIH73NnPasueA+hfZc4geJ41FezzhSKfd/gFluWK6K4SzNCQMy7hABNNugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMhiYtwQ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so2144981a12.2
        for <bpf@vger.kernel.org>; Fri, 20 Sep 2024 18:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726881460; x=1727486260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IWrkQa3cGIGCL+0S6GbnicyRJIts72U6vC/j08snbow=;
        b=LMhiYtwQd9k6NW50x9ptm3pS4MXuT6aJjOip8ZOE5JnCs6/dNgdDoKExQhAcUGyo/7
         WCOLDq/lnLWM7rZ2eod/NokXbIB+VogOR+DOP+c1BCEMxtESR83pfX2EQiWgWR4cyEQD
         t7UEDeqfcsiNwXdrvmxrO6U8HowrJBNqM4vXP6OaOOUFRl/jgf7RXd7g6xk9qIglst1O
         ajWr3wd+quStzs4T+fHT+K2qZUPeHENmSnNOQmIRzQZ7qkC2WFqbCYDs4lbvfym50v1E
         FSSSrwJ54CEOFWlbtUqQ2h+8pbGTZ9gpxowiDSojEkNTHBcW9hEZyg1ZPtGuSa0vJYTH
         5A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726881460; x=1727486260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWrkQa3cGIGCL+0S6GbnicyRJIts72U6vC/j08snbow=;
        b=sDE2hl1OOVMUePxlFzWEmwHa4efwmveA3/ktV1gJHypzjZYsqa2EGhL59uz9qH72ji
         nPS0QUjE5uTR8m6MF6PQLsrvsUWpXtsOE/aTey25vxKhN38nEW2Y2LYUk1+sz9zY1KTG
         x4gvx6ay1AhP0HHecV5lVP9OBsoe4F+vE3YAhO36v6oDkjJKQEmTfGfM7QYrZYQMA9c/
         aamCpJPus85eK+vDvUaBQFZtcVmr2GmF6aZC8liFf3+UR4rYeXmfxtVsujjhkpneIfFf
         7ikkhc+pf8js62PC80r5DltF6CiqfYurgPzcuNf6YvCmo6haTWZb7HT0hNn/OO55c/LG
         d4Aw==
X-Forwarded-Encrypted: i=1; AJvYcCU+nKrArVkqAMTdLucXnKu6v5cGRH6mFOpOABVcVWd+eWXH94n9GhRGRGr6MOTGRw5Xhtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs10LIXvQIZrW4D/lQzBXEYqX1xLYBA44DLUmrCReezYOBNWVd
	gkJBCtSx6QHsZXI4A4EyL8f/RyXal91xh0/DCCM39eN0A9sqVRoFe+J6gg==
X-Google-Smtp-Source: AGHT+IGJTmKGwZJAj8BH6meZPdX3bAbnge7LAqouS+3sMYIaOlzczbHRha518psqbTOAhRahVM7Lvw==
X-Received: by 2002:a17:903:230e:b0:206:ac72:d74a with SMTP id d9443c01a7336-208d8371a9emr71773465ad.19.1726881459517;
        Fri, 20 Sep 2024 18:17:39 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079470b053sm100321225ad.218.2024.09.20.18.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 18:17:38 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	bpf@vger.kernel.org
Subject: [RFC bpf-next] libbpf: add resizable array helpers
Date: Fri, 20 Sep 2024 18:17:12 -0700
Message-ID: <20240921011712.83355-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arrays in custom data sections can be resized via bpf_map__set_value().
While working with these types of arrays in some sched_ext programs, there
was some feedback that the manual operations involved could use helpers.
The macros in the potential patch are intended to make resizing bpf arrays
easier.

To illustrate, declaring an array that will be resized looks like this:
__u32 my_map[1] SEC(".data.my_map");

Instead, using a macro to help with the declaration:
__u32 BPF_RESIZABLE_ARRAY(data, my_map);

To allow access to the post-resized array in the bpf program, this helper
can be used which maintains verifier safety:
u32 *val = (u32 *)ARRAY_ELEM_PTR(my_map, ctx->cpu, nr_cpus);

Meanwhile in the userspace program, instead of doing:
size_t sz = bpf_map__set_value_size(skel->maps.data_my_map, sizeof(skel->data_my_map->my_map[0]) * nr_cpus);
skel->data_my_map = bpf_map__initial_value(skel->maps.data_my_map, &sz);

The resizing macro can be used:
BPF_RESIZE_ARRAY(data, my_map, nr_cpus);

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/uapi/linux/bpf.h    | 23 ++++++++++++++++++
 tools/lib/bpf/bpf_helpers.h | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e05b39e39c3f..92e93c9fc056 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7513,4 +7513,27 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+/*
+ * BPF_RESIZE_ARRAY - Convenience macro for resizing a BPF array
+ * @elfsec: the data section of the BPF program in which to the array exists
+ * @arr: the name of the array
+ * @n: the desired array element count
+ *
+ * For BPF arrays declared with RESIZABLE_ARRAY(), this macro performs two
+ * operations. It resizes the map which corresponds to the custom data
+ * section that contains the target array. As a side effect, the BTF info for
+ * the array is adjusted so that the array length is sized to cover the new
+ * data section size. The second operation is reassigning the skeleton pointer
+ * for that custom data section so that it points to the newly memory mapped
+ * region.
+ */
+#define BPF_RESIZE_ARRAY(elfsec, arr, n)					  \
+	do {									  \
+		size_t __sz;							  \
+		bpf_map__set_value_size(skel->maps.elfsec##_##arr,		  \
+				sizeof(skel->elfsec##_##arr->arr[0]) * (n));	  \
+		skel->elfsec##_##arr =						  \
+			bpf_map__initial_value(skel->maps.elfsec##_##arr, &__sz); \
+	} while (0)
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 305c62817dd3..b0d496b0f0d6 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -420,4 +420,52 @@ extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __weak __ksym;
 )
 #endif /* bpf_repeat */
 
+/**
+ * RESIZABLE_ARRAY - Generates annotations for an array that may be resized
+ * @elfsec: the data section of the BPF program in which to place the array
+ * @arr: the name of the array
+ *
+ * libbpf has an API for setting map value sizes. Since data sections (i.e.
+ * bss, data, rodata) themselves are maps, a data section can be resized. If
+ * a data section has an array as its last element, the BTF info for that
+ * array will be adjusted so that length of the array is extended to meet the
+ * new length of the data section. This macro annotates an array to have an
+ * element count of one with the assumption that this array can be resized
+ * within the userspace program. It also annotates the section specifier so
+ * this array exists in a custom sub data section which can be resized
+ * independently.
+ *
+ * See BPF_RESIZE_ARRAY() for the userspace convenience macro for resizing an
+ * array declared with BPF_RESIZABLE_ARRAY().
+ */
+#define BPF_RESIZABLE_ARRAY(elfsec, arr) arr[1] SEC("."#elfsec"."#arr)
+
+/*
+ * BPF_ARRAY_ELEM_PTR - Obtain the verified pointer to an array element
+ * @arr: array to index into
+ * @i: array index
+ * @n: number of elements in array
+ *
+ * Similar to MEMBER_VPTR() but is intended for use with arrays where the
+ * element count needs to be explicit.
+ * It can be used in cases where a global array is defined with an initial
+ * size but is intended to be be resized before loading the BPF program.
+ * Without this version of the macro, MEMBER_VPTR() will use the compile time
+ * size of the array to compute the max, which will result in rejection by
+ * the verifier.
+ */
+#define BPF_ARRAY_ELEM_PTR(arr, i, n) (typeof(arr[i]) *)({	  \
+	u64 __base = (u64)arr;					  \
+	u64 __addr = (u64)&(arr[i]) - __base;			  \
+	asm volatile (						  \
+		"if %0 <= %[max] goto +2\n"		  	  \
+		"%0 = 0\n"					  \
+		"goto +1\n"					  \
+		"%0 += %1\n"					  \
+		: "+r"(__addr)					  \
+		: "r"(__base),					  \
+		  [max]"r"(sizeof(arr[0]) * ((n) - 1)));  \
+	__addr;						  \
+})
+
 #endif
-- 
2.46.0


