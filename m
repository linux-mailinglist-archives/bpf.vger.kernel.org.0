Return-Path: <bpf+bounces-7749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D3A77BEF4
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 19:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D1C1C20299
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 17:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FE0CA52;
	Mon, 14 Aug 2023 17:28:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22015C8F1
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 17:28:52 +0000 (UTC)
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D969D10DD
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 10:28:50 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 695BE24C21FF8; Mon, 14 Aug 2023 10:28:35 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 05/15] selftests/bpf: Update error message in negative linked_list test
Date: Mon, 14 Aug 2023 10:28:35 -0700
Message-Id: <20230814172835.1364448-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814172809.1361446-1-yonghong.song@linux.dev>
References: <20230814172809.1361446-1-yonghong.song@linux.dev>
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

Some error messages are changed due to the addition of
percpu kptr support. Fix linked_list test with changed
error messages.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/linked_list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools=
/testing/selftests/bpf/prog_tests/linked_list.c
index 18cf7b17463d..db3bf6bbe01a 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -65,8 +65,8 @@ static struct {
 	{ "map_compat_raw_tp", "tracing progs cannot use bpf_{list_head,rb_root=
} yet" },
 	{ "map_compat_raw_tp_w", "tracing progs cannot use bpf_{list_head,rb_ro=
ot} yet" },
 	{ "obj_type_id_oor", "local type ID argument must be in range [0, U32_M=
AX]" },
-	{ "obj_new_no_composite", "bpf_obj_new type ID argument must be of a st=
ruct" },
-	{ "obj_new_no_struct", "bpf_obj_new type ID argument must be of a struc=
t" },
+	{ "obj_new_no_composite", "bpf_obj_new/bpf_percpu_obj_new type ID argum=
ent must be of a struct" },
+	{ "obj_new_no_struct", "bpf_obj_new/bpf_percpu_obj_new type ID argument=
 must be of a struct" },
 	{ "obj_drop_non_zero_off", "R1 must have zero offset when passed to rel=
ease func" },
 	{ "new_null_ret", "R0 invalid mem access 'ptr_or_null_'" },
 	{ "obj_new_acq", "Unreleased reference id=3D" },
--=20
2.34.1


