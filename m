Return-Path: <bpf+bounces-5794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EAF760906
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 07:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4C328179B
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 05:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5164A7498;
	Tue, 25 Jul 2023 05:06:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BF75385
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 05:06:16 +0000 (UTC)
X-Greylist: delayed 1333 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Jul 2023 22:06:14 PDT
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC6511A
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 22:06:14 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 52A8F239DC95E; Mon, 24 Jul 2023 21:43:48 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next v2] MAINTAINERS: Replace my email address
Date: Mon, 24 Jul 2023 21:43:48 -0700
Message-Id: <20230725044348.648808-1-yonghong.song@linux.dev>
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
	TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yonghong Song <yhs@fb.com>

Switch from corporate email address to linux.dev address.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Changelog:
  v1 -> v2:
   - Use new address as the Signed-off-by address.

diff --git a/MAINTAINERS b/MAINTAINERS
index 990e3fce753c..b170081d6c3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3703,7 +3703,7 @@ M:	Daniel Borkmann <daniel@iogearbox.net>
 M:	Andrii Nakryiko <andrii@kernel.org>
 R:	Martin KaFai Lau <martin.lau@linux.dev>
 R:	Song Liu <song@kernel.org>
-R:	Yonghong Song <yhs@fb.com>
+R:	Yonghong Song <yonghong.song@linux.dev>
 R:	John Fastabend <john.fastabend@gmail.com>
 R:	KP Singh <kpsingh@kernel.org>
 R:	Stanislav Fomichev <sdf@google.com>
@@ -3742,7 +3742,7 @@ F:	tools/lib/bpf/
 F:	tools/testing/selftests/bpf/
=20
 BPF [ITERATOR]
-M:	Yonghong Song <yhs@fb.com>
+M:	Yonghong Song <yonghong.song@linux.dev>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	kernel/bpf/*iter.c
--=20
2.34.1


