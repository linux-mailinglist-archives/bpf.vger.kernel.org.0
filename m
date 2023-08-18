Return-Path: <bpf+bounces-8096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B596378123F
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 19:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AA31C213C3
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 17:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B5C19BD3;
	Fri, 18 Aug 2023 17:43:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035CA469F
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 17:43:27 +0000 (UTC)
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDD32102
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 10:43:26 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 2BB3C24FD501E; Fri, 18 Aug 2023 10:43:12 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix a selftest compilation error
Date: Fri, 18 Aug 2023 10:43:12 -0700
Message-Id: <20230818174312.1883381-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When building the kernel and selftest with clang compiler (llvm17 or llvm=
18),
I hit the following compilation failure:
  In file included from progs/test_lwt_redirect.c:3:
  In file included from /usr/include/linux/ip.h:21:
  In file included from /usr/include/asm/byteorder.h:5:
  In file included from /usr/include/linux/byteorder/little_endian.h:13:
  /usr/include/linux/swab.h:136:8: error: unknown type name '__always_inl=
ine'
    136 | static __always_inline unsigned long __swab(const unsigned long=
 y)
        |        ^
  /usr/include/linux/swab.h:171:8: error: unknown type name '__always_inl=
ine'
    171 | static __always_inline __u16 __swab16p(const __u16 *p)
  ...

bpf_helpers.h file provided a definition for __always_inline.
Putting 'ip.h' after 'bpf_helpers.h' fixed the issue.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/test_lwt_redirect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_lwt_redirect.c b/tool=
s/testing/selftests/bpf/progs/test_lwt_redirect.c
index 7ab1fd310efb..8c895122f293 100644
--- a/tools/testing/selftests/bpf/progs/test_lwt_redirect.c
+++ b/tools/testing/selftests/bpf/progs/test_lwt_redirect.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/bpf.h>
-#include <linux/ip.h>
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
+#include <linux/ip.h>
 #include "bpf_tracing_net.h"
=20
 /* We don't care about whether the packet can be received by network sta=
ck.
--=20
2.34.1


