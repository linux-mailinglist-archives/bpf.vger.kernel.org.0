Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DAA6B8431
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 22:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCMVrH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 17:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjCMVrG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 17:47:06 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DF188EC8
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 14:46:53 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DE3Jku020582
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 14:46:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=2rP7UuJtJ0TtRetM3Sr8fRhz9rYyiZvQTaIhfJHM55I=;
 b=DFDCKzow6nJa3drsBe0FItS5ux+/8CNjSS9dQpM8XrEWaMB1L/dFW/f8GR9uqIPJEU6Y
 tbFj0+xrVNH0oSQ+ybksVy0geBIxuTiUI6CGZ8AT5gTSrWWMx1a7I+Mdj7eV4kXIfEhN
 08jYP5AW3Qqwy/IP0MuUGPjxHxD3gP5l9ZM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pa58kkeau-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 14:46:52 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 13 Mar 2023 14:46:51 -0700
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 13 Mar 2023 14:46:51 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 98A4619415017; Mon, 13 Mar 2023 14:46:42 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next] bpf: Disable migration when freeing stashed local kptr using obj drop
Date:   Mon, 13 Mar 2023 14:46:41 -0700
Message-ID: <20230313214641.3731908-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rgtSzqyplK5S2AOav_EbYGhYXnTWQ591
X-Proofpoint-GUID: rgtSzqyplK5S2AOav_EbYGhYXnTWQ591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_11,2023-03-13_03,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When a local kptr is stashed in a map and freed when the map goes away,
currently an error like the below appears:

[   39.195695] BUG: using smp_processor_id() in preemptible [00000000] co=
de: kworker/u32:15/2875
[   39.196549] caller is bpf_mem_free+0x56/0xc0
[   39.196958] CPU: 15 PID: 2875 Comm: kworker/u32:15 Tainted: G         =
  O       6.2.0-13016-g22df776a9a86 #4477
[   39.197897] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[   39.198949] Workqueue: events_unbound bpf_map_free_deferred
[   39.199470] Call Trace:
[   39.199703]  <TASK>
[   39.199911]  dump_stack_lvl+0x60/0x70
[   39.200267]  check_preemption_disabled+0xbf/0xe0
[   39.200704]  bpf_mem_free+0x56/0xc0
[   39.201032]  ? bpf_obj_new_impl+0xa0/0xa0
[   39.201430]  bpf_obj_free_fields+0x1cd/0x200
[   39.201838]  array_map_free+0xad/0x220
[   39.202193]  ? finish_task_switch+0xe5/0x3c0
[   39.202614]  bpf_map_free_deferred+0xea/0x210
[   39.203006]  ? lockdep_hardirqs_on_prepare+0xe/0x220
[   39.203460]  process_one_work+0x64f/0xbe0
[   39.203822]  ? pwq_dec_nr_in_flight+0x110/0x110
[   39.204264]  ? do_raw_spin_lock+0x107/0x1c0
[   39.204662]  ? lockdep_hardirqs_on_prepare+0xe/0x220
[   39.205107]  worker_thread+0x74/0x7a0
[   39.205451]  ? process_one_work+0xbe0/0xbe0
[   39.205818]  kthread+0x171/0x1a0
[   39.206111]  ? kthread_complete_and_exit+0x20/0x20
[   39.206552]  ret_from_fork+0x1f/0x30
[   39.206886]  </TASK>

This happens because the call to __bpf_obj_drop_impl I added in the patch
adding support for stashing local kptrs doesn't disable migration. Prior
to that patch, __bpf_obj_drop_impl logic only ran when called by a BPF
progarm, whereas now it can be called from map free path, so it's
necessary to explicitly disable migration.

Also, refactor a bit to just call __bpf_obj_drop_impl directly instead
of bothering w/ dtor union and setting pointer-to-obj_drop.

Fixes: c8e187540914 ("bpf: Support __kptr to local kptrs")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h  | 12 ++++--------
 kernel/bpf/btf.c     |  4 +---
 kernel/bpf/syscall.c | 10 +++++++---
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 756b85f0d0d3..71cc92a4ba48 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -190,18 +190,14 @@ enum btf_field_type {
 };
=20
 typedef void (*btf_dtor_kfunc_t)(void *);
-typedef void (*btf_dtor_obj_drop)(void *, const struct btf_record *);
=20
 struct btf_field_kptr {
 	struct btf *btf;
 	struct module *module;
-	union {
-		/* dtor used if btf_is_kernel(btf), otherwise the type
-		 * is program-allocated and obj_drop is used
-		 */
-		btf_dtor_kfunc_t dtor;
-		btf_dtor_obj_drop obj_drop;
-	};
+	/* dtor used if btf_is_kernel(btf), otherwise the type is
+	 * program-allocated, dtor is NULL,  and __bpf_obj_drop_impl is used
+	 */
+	btf_dtor_kfunc_t dtor;
 	u32 btf_id;
 };
=20
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 66fad7a16b6c..b7e5a5510b91 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3551,8 +3551,6 @@ static int btf_find_field(const struct btf *btf, co=
nst struct btf_type *t,
 	return -EINVAL;
 }
=20
-extern void __bpf_obj_drop_impl(void *p, const struct btf_record *rec);
-
 static int btf_parse_kptr(const struct btf *btf, struct btf_field *field=
,
 			  struct btf_field_info *info)
 {
@@ -3578,7 +3576,7 @@ static int btf_parse_kptr(const struct btf *btf, st=
ruct btf_field *field,
 		/* Type exists only in program BTF. Assume that it's a MEM_ALLOC
 		 * kptr allocated via bpf_obj_new
 		 */
-		field->kptr.dtor =3D (void *)&__bpf_obj_drop_impl;
+		field->kptr.dtor =3D NULL;
 		id =3D info->kptr.type_id;
 		kptr_btf =3D (struct btf *)btf;
 		btf_get(kptr_btf);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0684febc447a..5b88301a2ae0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -650,6 +650,8 @@ void bpf_obj_free_timer(const struct btf_record *rec,=
 void *obj)
 	bpf_timer_cancel_and_free(obj + rec->timer_off);
 }
=20
+extern void __bpf_obj_drop_impl(void *p, const struct btf_record *rec);
+
 void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 {
 	const struct btf_field *fields;
@@ -679,9 +681,11 @@ void bpf_obj_free_fields(const struct btf_record *re=
c, void *obj)
 				pointee_struct_meta =3D btf_find_struct_meta(field->kptr.btf,
 									   field->kptr.btf_id);
 				WARN_ON_ONCE(!pointee_struct_meta);
-				field->kptr.obj_drop(xchgd_field, pointee_struct_meta ?
-								  pointee_struct_meta->record :
-								  NULL);
+				migrate_disable();
+				__bpf_obj_drop_impl(xchgd_field, pointee_struct_meta ?
+								 pointee_struct_meta->record :
+								 NULL);
+				migrate_enable();
 			} else {
 				field->kptr.dtor(xchgd_field);
 			}
--=20
2.34.1

