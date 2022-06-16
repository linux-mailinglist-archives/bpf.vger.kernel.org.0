Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAAD54EDAD
	for <lists+bpf@lfdr.de>; Fri, 17 Jun 2022 00:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379197AbiFPWzb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jun 2022 18:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378754AbiFPWz1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jun 2022 18:55:27 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2746212F
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 15:55:26 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 2A739DC20437; Thu, 16 Jun 2022 15:54:42 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next] bpf: Fix non-static bpf_func_proto struct definitions
Date:   Thu, 16 Jun 2022 15:54:07 -0700
Message-Id: <20220616225407.1878436-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,
        TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch does two things:

1) Marks the dynptr bpf_func_proto structs that were added in [1]
as static, as pointed out by the kernel test robot in [2].

2) There are some bpf_func_proto structs marked as extern which can
instead be statically defined.

[1] https://lore.kernel.org/bpf/20220523210712.3641569-1-joannelkoong@gma=
il.com/

[2] https://lore.kernel.org/bpf/62ab89f2.Pko7sI08RAKdF8R6%25lkp@intel.com=
/

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf.h  |  3 ---
 kernel/bpf/helpers.c | 12 ++++++------
 kernel/bpf/syscall.c |  2 +-
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8e6092d0ea95..92797fa78d9a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2262,12 +2262,9 @@ extern const struct bpf_func_proto bpf_for_each_ma=
p_elem_proto;
 extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
 extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
 extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
-extern const struct bpf_func_proto bpf_kallsyms_lookup_name_proto;
 extern const struct bpf_func_proto bpf_find_vma_proto;
 extern const struct bpf_func_proto bpf_loop_proto;
-extern const struct bpf_func_proto bpf_strncmp_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
-extern const struct bpf_func_proto bpf_kptr_xchg_proto;
=20
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 225806a02efb..a1c84d256f83 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -584,7 +584,7 @@ BPF_CALL_3(bpf_strncmp, const char *, s1, u32, s1_sz,=
 const char *, s2)
 	return strncmp(s1, s2, s1_sz);
 }
=20
-const struct bpf_func_proto bpf_strncmp_proto =3D {
+static const struct bpf_func_proto bpf_strncmp_proto =3D {
 	.func		=3D bpf_strncmp,
 	.gpl_only	=3D false,
 	.ret_type	=3D RET_INTEGER,
@@ -1402,7 +1402,7 @@ BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void *=
, ptr)
  */
 #define BPF_PTR_POISON ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA)=
)
=20
-const struct bpf_func_proto bpf_kptr_xchg_proto =3D {
+static const struct bpf_func_proto bpf_kptr_xchg_proto =3D {
 	.func         =3D bpf_kptr_xchg,
 	.gpl_only     =3D false,
 	.ret_type     =3D RET_PTR_TO_BTF_ID_OR_NULL,
@@ -1487,7 +1487,7 @@ BPF_CALL_4(bpf_dynptr_from_mem, void *, data, u32, =
size, u64, flags, struct bpf_
 	return err;
 }
=20
-const struct bpf_func_proto bpf_dynptr_from_mem_proto =3D {
+static const struct bpf_func_proto bpf_dynptr_from_mem_proto =3D {
 	.func		=3D bpf_dynptr_from_mem,
 	.gpl_only	=3D false,
 	.ret_type	=3D RET_INTEGER,
@@ -1513,7 +1513,7 @@ BPF_CALL_4(bpf_dynptr_read, void *, dst, u32, len, =
struct bpf_dynptr_kern *, src
 	return 0;
 }
=20
-const struct bpf_func_proto bpf_dynptr_read_proto =3D {
+static const struct bpf_func_proto bpf_dynptr_read_proto =3D {
 	.func		=3D bpf_dynptr_read,
 	.gpl_only	=3D false,
 	.ret_type	=3D RET_INTEGER,
@@ -1539,7 +1539,7 @@ BPF_CALL_4(bpf_dynptr_write, struct bpf_dynptr_kern=
 *, dst, u32, offset, void *,
 	return 0;
 }
=20
-const struct bpf_func_proto bpf_dynptr_write_proto =3D {
+static const struct bpf_func_proto bpf_dynptr_write_proto =3D {
 	.func		=3D bpf_dynptr_write,
 	.gpl_only	=3D false,
 	.ret_type	=3D RET_INTEGER,
@@ -1566,7 +1566,7 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern =
*, ptr, u32, offset, u32, len
 	return (unsigned long)(ptr->data + ptr->offset + offset);
 }
=20
-const struct bpf_func_proto bpf_dynptr_data_proto =3D {
+static const struct bpf_func_proto bpf_dynptr_data_proto =3D {
 	.func		=3D bpf_dynptr_data,
 	.gpl_only	=3D false,
 	.ret_type	=3D RET_PTR_TO_DYNPTR_MEM_OR_NULL,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index aeb31137b2ed..7d5af5b99f0d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5131,7 +5131,7 @@ BPF_CALL_4(bpf_kallsyms_lookup_name, const char *, =
name, int, name_sz, int, flag
 	return *res ? 0 : -ENOENT;
 }
=20
-const struct bpf_func_proto bpf_kallsyms_lookup_name_proto =3D {
+static const struct bpf_func_proto bpf_kallsyms_lookup_name_proto =3D {
 	.func		=3D bpf_kallsyms_lookup_name,
 	.gpl_only	=3D false,
 	.ret_type	=3D RET_INTEGER,
--=20
2.30.2

