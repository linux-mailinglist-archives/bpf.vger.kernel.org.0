Return-Path: <bpf+bounces-8449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EDC78678D
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 08:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112721C20DCB
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 06:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0B8185E;
	Thu, 24 Aug 2023 06:34:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AF424522
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 06:34:34 +0000 (UTC)
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E21A8
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 23:34:30 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 740D3254E5B42; Wed, 23 Aug 2023 23:34:17 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Remove a WARN_ON_ONCE warning related to local kptr
Date: Wed, 23 Aug 2023 23:34:17 -0700
Message-Id: <20230824063417.201925-1-yonghong.song@linux.dev>
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

Currently, in function bpf_obj_free_fields(), for local kptr,
a warning will be issued if the struct does not contain any
special fields. But actually the kernel seems totally okay
with a local kptr without any special fields. Permitting
no special fields also aligns with future percpu kptr which
also allows no special fields.

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/syscall.c | 1 -
 1 file changed, 1 deletion(-)

NOTE: I didn't put a fix tag since except the warning
there is no correctness issue here.

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 10666d17b9e3..ebeb0695305a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -657,7 +657,6 @@ void bpf_obj_free_fields(const struct btf_record *rec=
, void *obj)
 			if (!btf_is_kernel(field->kptr.btf)) {
 				pointee_struct_meta =3D btf_find_struct_meta(field->kptr.btf,
 									   field->kptr.btf_id);
-				WARN_ON_ONCE(!pointee_struct_meta);
 				migrate_disable();
 				__bpf_obj_drop_impl(xchgd_field, pointee_struct_meta ?
 								 pointee_struct_meta->record :
--=20
2.34.1


