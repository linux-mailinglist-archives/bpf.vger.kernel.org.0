Return-Path: <bpf+bounces-2635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BA1731B42
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 16:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE721C20EEE
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 14:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6356817739;
	Thu, 15 Jun 2023 14:25:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331F017AA1
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 14:25:34 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7393F2702
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 07:25:32 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b448cf5d83so7653361fa.1
        for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 07:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686839130; x=1689431130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bzw35DKgdmPM46OepQZbR2aZztzQNC+2pafz//LN1II=;
        b=T7ck2hWx/z4F4q/5yeAcKBrbwKLDmnzaYwFfRsxc92LrZkQblDLUvVQ6qlLEQ7I+Qp
         FoDvEzR87XzctSgTv4RtYTNmiCUgTKvNo/doM2Jk9GNVEIiJ9KaK0BkUH/Ela0SvqVmQ
         eG5b/xEaAK/buG/hcKwf4tViv07mKtEyqgqQBt8VKdoNw6j8m+/S1yEZThLfthnvKYSp
         1/hze+1zSJDBtGNby4LvYWlDs95Jr1WIfO5w5mYziDTZWdFIpGp2KlyUM2W1i8j/Z3zw
         zUbximIs6Kbd9reHUjvu0NLmY0vlTtqvS/fhWH/m9HhbYyagPwAJz8Cgh7ZchvG7Aiz8
         Fisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686839130; x=1689431130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzw35DKgdmPM46OepQZbR2aZztzQNC+2pafz//LN1II=;
        b=h1y17NMsmS32ndHJfe7dlxXdiVMXM3c9UYL69485CF4IPtldXMQ4xuRKa12Kte5MeW
         9jGs3nEzhKWSzbPUcuEgSQ06jboBPozEAlKfRxztAPRYekXM/zBAA1WT2QqAvXrD3BIy
         k8tTuFoJaoYReRIUKZhnowFisdqRh/lQ3TKeTXw9VHzs5hFfw++yScTojixoI3D9PjWE
         Cw39/s0DKgnwGG5zjOpG7ziLEZc1e4LqDYEr3GsJflU6RZiLdFdTZ2AVcOPga2vM6vfp
         /3bpT/kkiNTkGM2i+dzKbxgohuY3VYgwpI329Y9Pyu3BVtuFtN5U/a5H1DAW9ku1cGpC
         VUhA==
X-Gm-Message-State: AC+VfDx/e80F4bAB1PiElefE5F4HwXVCO7+JBRc+6pNwJqmGGNO5XvFQ
	1wBXB7vVTmDLYtmgkxH4OcVivrWLjE+eRw==
X-Google-Smtp-Source: ACHHUZ5FUeJHYlN5QgfS9y1GHAPJIhsH4sWHnZGsUk1ulqzWV4ooVdzDt74+m1jvu/ob9QkTmsaWlA==
X-Received: by 2002:a2e:9799:0:b0:2b3:4cb5:ded4 with SMTP id y25-20020a2e9799000000b002b34cb5ded4mr3167588lji.21.1686839130113;
        Thu, 15 Jun 2023 07:25:30 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q23-20020a2e9157000000b002b34db9de0asm684991ljg.11.2023.06.15.07.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 07:25:29 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	jemarch@gnu.org,
	david.faust@oracle.com,
	dzq.aishenghu0@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next] bpf: generate 'nomerge' for map helpers in bpf_helper_defs.h
Date: Thu, 15 Jun 2023 17:25:20 +0300
Message-Id: <20230615142520.10280-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Update code generation for bpf_helper_defs.h by adding
__attribute__((nomerge)) for a set of helper functions to prevent some
verifier unfriendly compiler optimizations.

This addresses a recent mailing list thread [1].
There Zhongqiu Duan and Yonghong Song discussed a C program as below:

     if (data_end - data > 1024) {
         bpf_for_each_map_elem(&map1, cb, &cb_data, 0);
     } else {
         bpf_for_each_map_elem(&map2, cb, &cb_data, 0);
     }

Which was converted by clang to something like this:

     if (data_end - data > 1024)
       tmp = &map1;
     else
       tmp = &map2;
     bpf_for_each_map_elem(tmp, cb, &cb_data, 0);

Which in turn triggered verification error, because
verifier.c:record_func_map() requires a single map address for each
bpf_for_each_map_elem() call.

In fact, this is a requirement for the following helpers:
- bpf_tail_call
- bpf_map_lookup_elem
- bpf_map_update_elem
- bpf_map_delete_elem
- bpf_map_push_elem
- bpf_map_pop_elem
- bpf_map_peek_elem
- bpf_for_each_map_elem
- bpf_redirect_map
- bpf_map_lookup_percpu_elem

I had an off-list discussion with Yonghong where we agreed that clang
attribute 'nomerge' (see [2]) could be used to prevent the
optimization hitting in [1]. However, currently 'nomerge' applies only
to functions and statements, hence I submitted change requests [3],
[4] to allow specifying 'nomerge' for function pointers as well.

The patch below updates bpf_helper_defs.h generation by adding a
definition of __nomerge macro, and using this macro in definitions of
relevant helpers.

The generated code looks as follows:

    /* This is auto-generated file. See bpf_doc.py for details. */

    #if __has_attribute(nomerge)
    #define __nomerge __attribute__((nomerge))
    #else
    #define __nomerge
    #endif

    /* Forward declarations of BPF structs */
    ...
    static long (*bpf_for_each_map_elem)(void *map, ...) __nomerge = (void *) 164;
    ...

(In non-RFC version the macro definition would have to be updated to
 check for supported clang version).

Does community agree with such approach?

[1] https://lore.kernel.org/bpf/03bdf90f-f374-1e67-69d6-76dd9c8318a4@meta.com/
[2] https://clang.llvm.org/docs/AttributeReference.html#nomerge
[3] https://reviews.llvm.org/D152986
[4] https://reviews.llvm.org/D152987
---
 scripts/bpf_doc.py | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index eaae2ce78381..dbd4893c793e 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -777,14 +777,33 @@ class PrinterHelpers(Printer):
         'bpf_get_socket_cookie',
         'bpf_sk_assign',
     ]
+    # Helpers that need __nomerge attribute
+    nomerge_helpers = set([
+	"bpf_tail_call",
+	"bpf_map_lookup_elem",
+	"bpf_map_update_elem",
+	"bpf_map_delete_elem",
+	"bpf_map_push_elem",
+	"bpf_map_pop_elem",
+	"bpf_map_peek_elem",
+	"bpf_for_each_map_elem",
+	"bpf_redirect_map",
+	"bpf_map_lookup_percpu_elem"
+    ])
+
+    macros = '''\
+#if __has_attribute(nomerge)
+#define __nomerge __attribute__((nomerge))
+#else
+#define __nomerge
+#endif'''
 
     def print_header(self):
-        header = '''\
-/* This is auto-generated file. See bpf_doc.py for details. */
-
-/* Forward declarations of BPF structs */'''
-
-        print(header)
+        print('/* This is auto-generated file. See bpf_doc.py for details. */')
+        print()
+        print(self.macros)
+        print()
+        print('/* Forward declarations of BPF structs */')
         for fwd in self.type_fwds:
             print('%s;' % fwd)
         print('')
@@ -846,7 +865,11 @@ class PrinterHelpers(Printer):
             comma = ', '
             print(one_arg, end='')
 
-        print(') = (void *) %d;' % helper.enum_val)
+        print(')', end='')
+        if proto['name'] in self.nomerge_helpers:
+            print(' __nomerge', end='')
+
+        print(' = (void *) %d;' % helper.enum_val)
         print('')
 
 ###############################################################################
-- 
2.40.1


