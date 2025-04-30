Return-Path: <bpf+bounces-57076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AEAAA52CF
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 19:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DD13A6128
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 17:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE37264F9D;
	Wed, 30 Apr 2025 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kga60Dil"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF5D26562D
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035000; cv=none; b=c8lqNMAl+OEtOJjZW9Ye5fYswqWeihXxsFvKBqv/f+KYMlea9vnSP6dVvLXqCZ0CcGKmUyiJdC0aQTKmz81LIyDqWIL7fVbYrNMcyT1dU3SSBLFGJp/olA7w2Ufmr4zYZ6BsOz7JsC0EIJBqM06bXgAraMbGShcKZKbpDt68hr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035000; c=relaxed/simple;
	bh=cqREeqKOwGChr9yyh/08jX4r02hEBnq32GnkDxgf6bQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gfR/3ygagl5ZBbwDisRLlfGQUCjqgt0XU0l5W7eGYpTwJBLbRhIL4NRmB1EhenpKZ/a7EjCw8FWwaBcPTlrC6vMSi6gzMAIofU1c77nOTKkfQMlwtAZn0HgiMJX4nvUqK9sMveF0RHMab0ba5q7IpLS8fXMRvAP0f8ZGzR3iYE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kga60Dil; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac25520a289so10730066b.3
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746034996; x=1746639796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPQMnzr8/yi81HwZfJCBoXKB8PMYLz+JDeYclfDVgio=;
        b=Kga60DilAudvWEz1iAtsaaq0PkcB3GTjPZs1I9IhvGNChkUP2b7oyIykkMbZzN9pPZ
         lmDw3Ze428xcMAw5folcUHaWX+QnLVI1AjnIg4TS91ZregryHtbWXMeRhkVgs+wM9/zv
         2+mqjqgF7WSzptW4IC0QXcVK2vKo3fx/+nnFpncHnLR6mz+99UGm6f24iQdurK+FKDAT
         ZgldXmUFBpZSQBNhLryODtK0vnGD3gYY+DbKLQYdHB1dHm0HPSOVZqb+eUZYzWTEty9N
         iLeV2FdAQUjcJAujKBIEN906tm1l0thmdjKyO3Fe9n975OpaBYr353SNzVR1o0pd1GMl
         lxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746034996; x=1746639796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPQMnzr8/yi81HwZfJCBoXKB8PMYLz+JDeYclfDVgio=;
        b=QlXRRQpjzhtR22yoolBPWMedmUpm2y1EeksQWjfSKQqdJb9lPIEtVnrTNce6nnjNBu
         U8+/qlTRqMdYY1oBfEBdVFd8DgKwM7UdGiwjS+HTS40aeMIUAK1zqwo/HW6YFRVEq9ld
         iF4pq3zp15U5yJIh/2oPWAddRPuV8GsMf2TKviTZuqjFFiHJ9hKr+3F7bZLi+0G9hFhK
         KupUsYDKxOmK2VC90HXJB093dyqEluyEm1uYIYfNTVePITggcPM4e/Vg+HJbhqLdptBt
         AH6hsJSP+9gdkm/5VSY2NRgVo8Utdbc2sLnmS9s3+ilI5vRaX429zybt2nTTzb0p+DN9
         6KCw==
X-Gm-Message-State: AOJu0Yw8Y8C40+frRiVeL0rRONY7mtiaxNi7t4+4ysV/W8MslN5bpNS1
	C4LRw/ZW+ISFabLI19To0pV/QN5K3gsV2tEoLJYL29Ov5twhkwTBgyekAg==
X-Gm-Gg: ASbGncsfqZZ0EbBxjOBmThUAqv1qLouxHoLJPH0pKDx5c8JkoYHLMPWpoE6I1WIVA0k
	hX6pkud4hfHZhsGmQr/zRxMT1GzDa6M1R/Dk3WiMrKPPVNMQk3ZX1MKm1N7urQyIaEBn4PCgw8g
	d2zW47it1AUwHRbBWJJ9Q0xBP4u9PRb9MJtScAGKfJX+fIcPOCGV0uLBPnfoBxju46gIEYDwOYC
	8d3JBGhYojAqGJ/KzlqPlLwqmJL2nyLHpkRUTCZO8X06b55t2LRGupuGW1DqjUTDQasoaNMbZho
	6Robq0/1T3+0mG/WGTLJeQoWyVyt/tpjrhWB84QEh69LY9kAWeDgM9vGFiNk
X-Google-Smtp-Source: AGHT+IFAnF63UAJAEf19Ifjk1N6wypJGSov91P6IDOTnpcs00TXWRBpxanh5f4AxobX4YF9zNod/TA==
X-Received: by 2002:a17:906:dc8c:b0:abf:733f:5c42 with SMTP id a640c23a62f3a-acedc575056mr363768666b.8.1746034995932;
        Wed, 30 Apr 2025 10:43:15 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6eda7affsm953500366b.170.2025.04.30.10.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 10:43:15 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v3 bpf-next] bpf: fix uninitialized values in BPF_{CORE,PROBE}_READ
Date: Wed, 30 Apr 2025 17:47:54 +0000
Message-Id: <20250430174754.2576367-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the latest LLVM bpf selftests build will fail with
the following error message:

    progs/profiler.inc.h:710:31: error: default initialization of an object of type 'typeof ((parent_task)->real_cred->uid.val)' (aka 'const unsigned int') leaves the object uninitialized and is incompatible with C++ [-Werror,-Wdefault-const-init-unsafe]
      710 |         proc_exec_data->parent_uid = BPF_CORE_READ(parent_task, real_cred, uid.val);
          |                                      ^
    tools/testing/selftests/bpf/tools/include/bpf/bpf_core_read.h:520:35: note: expanded from macro 'BPF_CORE_READ'
      520 |         ___type((src), a, ##__VA_ARGS__) __r;                               \
          |                                          ^

This happens because BPF_CORE_READ (and other macro) declare the
variable __r using the ___type macro which can inherit const modifier
from intermediate types.

Fix this by using __typeof_unqual__, when supported. (And when it
is not supported, the problem shouldn't appear, as older compilers
haven't complained.)

Fixes: 792001f4f7aa ("libbpf: Add user-space variants of BPF_CORE_READ() family of macros")
Fixes: a4b09a9ef945 ("libbpf: Add non-CO-RE variants of BPF_CORE_READ() macro family")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/lib/bpf/bpf_core_read.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index c0e13cdf9660..a371213b7f3e 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -390,6 +390,14 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
 
 #define ___type(...) typeof(___arrow(__VA_ARGS__))
 
+#if defined(__clang__) && (__clang_major__ >= 19)
+#define ___type_unqual(...) __typeof_unqual__(___arrow(__VA_ARGS__))
+#elif defined(__GNUC__) && (__GNUC__ >= 14)
+#define ___type_unqual(...) __typeof_unqual__(___arrow(__VA_ARGS__))
+#else
+#define ___type_unqual(...) ___type(__VA_ARGS__)
+#endif
+
 #define ___read(read_fn, dst, src_type, src, accessor)			    \
 	read_fn((void *)(dst), sizeof(*(dst)), &((src_type)(src))->accessor)
 
@@ -517,7 +525,7 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
  * than enough for any practical purpose.
  */
 #define BPF_CORE_READ(src, a, ...) ({					    \
-	___type((src), a, ##__VA_ARGS__) __r;				    \
+	___type_unqual((src), a, ##__VA_ARGS__) __r;			    \
 	BPF_CORE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);		    \
 	__r;								    \
 })
@@ -533,14 +541,14 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
  * input argument.
  */
 #define BPF_CORE_READ_USER(src, a, ...) ({				    \
-	___type((src), a, ##__VA_ARGS__) __r;				    \
+	___type_unqual((src), a, ##__VA_ARGS__) __r;			    \
 	BPF_CORE_READ_USER_INTO(&__r, (src), a, ##__VA_ARGS__);		    \
 	__r;								    \
 })
 
 /* Non-CO-RE variant of BPF_CORE_READ() */
 #define BPF_PROBE_READ(src, a, ...) ({					    \
-	___type((src), a, ##__VA_ARGS__) __r;				    \
+	___type_unqual((src), a, ##__VA_ARGS__) __r;			    \
 	BPF_PROBE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);		    \
 	__r;								    \
 })
@@ -552,7 +560,7 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
  * not restricted to kernel types only.
  */
 #define BPF_PROBE_READ_USER(src, a, ...) ({				    \
-	___type((src), a, ##__VA_ARGS__) __r;				    \
+	___type_unqual((src), a, ##__VA_ARGS__) __r;			    \
 	BPF_PROBE_READ_USER_INTO(&__r, (src), a, ##__VA_ARGS__);	    \
 	__r;								    \
 })
-- 
2.34.1


