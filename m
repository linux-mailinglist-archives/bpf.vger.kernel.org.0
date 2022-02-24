Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5475A4C3803
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 22:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiBXVuR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Feb 2022 16:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiBXVuQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Feb 2022 16:50:16 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122BF22A299
        for <bpf@vger.kernel.org>; Thu, 24 Feb 2022 13:49:43 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21OK7789004750
        for <bpf@vger.kernel.org>; Thu, 24 Feb 2022 13:49:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=0Dh4/ra2zAykBTv78rebx/eepnXTB5RA0o/IcYQCm+A=;
 b=I0oosKrxJ9fHcIJLlrjLfKSca3AELYjjLbKx6x44IUAaQjX6s6Or0SwG4i0pS9QKFvSU
 f/TY0gp504bH0XSozmUw5dKQ2pQKdmSbSKkFdbC0Dfsf98Pk8+RgLlCeeiiqVRh7h4Ob
 329AJK02+uV7fzoX1FnyUxRjzsSMpQSkTlw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ee5sw51qj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 24 Feb 2022 13:49:42 -0800
Received: from twshared5730.23.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 13:49:40 -0800
Received: by devvm4573.vll0.facebook.com (Postfix, from userid 200310)
        id 1E1E93FAA516; Thu, 24 Feb 2022 13:49:34 -0800 (PST)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernddddel.org>, <fallentree@fb.com>, <ast@kernel.org>
Subject: [PATCH bpf-next] bpf: Fix issue with bpf preload module taking over stdout/stdin of kernel.
Date:   Thu, 24 Feb 2022 13:49:28 -0800
Message-ID: <20220224214928.826717-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: BBWRlTnoCzWiFFmt9uTdaG7HeZmmrPBS
X-Proofpoint-ORIG-GUID: BBWRlTnoCzWiFFmt9uTdaG7HeZmmrPBS
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-24_06,2022-02-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=986 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202240120
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In a previous commit (1), BPF preload process was switched from user
mode process to use in-kernel light skeleton instead. However, in the
kernel context the available fd starts from 0, instead of normally 3 for
user mode process. and the preload process leaked two FDs, taking over
FD 0 and 1. This  which later caused issues when kernel trys to setup
stdin/stdout/stderr for init process, assuming fd 0,1,2 is available.

As seen here:

Before fix:
ls -lah /proc/1/fd/*

lrwx------1 root root 64 Feb 23 17:20 /proc/1/fd/0 -> /dev/null
lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/1 -> /dev/null
lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/2 -> /dev/console
lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/6 -> /dev/console
lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/7 -> /dev/console

After Fix / Normal:

ls -lah /proc/1/fd/*

lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/0 -> /dev/console
lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/1 -> /dev/console
lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/2 -> /dev/console

In this patch:
  - skel_closenz was changed to skel_closenez to correctly handle
    FD=3D0 case.
  - various places detecting FD > 0 was changed to FD >=3D 0.
  - Call iterators_skel__detach() funciton to release FDs after links
  are obtained.

1: https://github.com/kernel-patches/bpf/commit/cb80ddc67152e72f28ff6ea8517=
acdf875d7381d

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 kernel/bpf/preload/bpf_preload_kern.c          |  1 +
 kernel/bpf/preload/iterators/iterators.lskel.h | 16 +++++++++-------
 tools/bpf/bpftool/gen.c                        |  9 +++++----
 tools/lib/bpf/skel_internal.h                  |  8 ++++----
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf=
_preload_kern.c
index 30207c048d36..c6bb1e72e0f1 100644
--- a/kernel/bpf/preload/bpf_preload_kern.c
+++ b/kernel/bpf/preload/bpf_preload_kern.c
@@ -54,6 +54,7 @@ static int load_skel(void)
 		err =3D PTR_ERR(progs_link);
 		goto out;
 	}
+	iterators_bpf__detach(skel);
 	return 0;
 out:
 	free_links_and_skel();
diff --git a/kernel/bpf/preload/iterators/iterators.lskel.h b/kernel/bpf/pr=
eload/iterators/iterators.lskel.h
index 70f236a82fe1..25294fd88f10 100644
--- a/kernel/bpf/preload/iterators/iterators.lskel.h
+++ b/kernel/bpf/preload/iterators/iterators.lskel.h
@@ -28,7 +28,7 @@ iterators_bpf__dump_bpf_map__attach(struct iterators_bpf =
*skel)
 	int prog_fd =3D skel->progs.dump_bpf_map.prog_fd;
 	int fd =3D skel_link_create(prog_fd, 0, BPF_TRACE_ITER);
=20
-	if (fd > 0)
+	if (fd >=3D 0)
 		skel->links.dump_bpf_map_fd =3D fd;
 	return fd;
 }
@@ -39,7 +39,7 @@ iterators_bpf__dump_bpf_prog__attach(struct iterators_bpf=
 *skel)
 	int prog_fd =3D skel->progs.dump_bpf_prog.prog_fd;
 	int fd =3D skel_link_create(prog_fd, 0, BPF_TRACE_ITER);
=20
-	if (fd > 0)
+	if (fd >=3D 0)
 		skel->links.dump_bpf_prog_fd =3D fd;
 	return fd;
 }
@@ -57,8 +57,10 @@ iterators_bpf__attach(struct iterators_bpf *skel)
 static inline void
 iterators_bpf__detach(struct iterators_bpf *skel)
 {
-	skel_closenz(skel->links.dump_bpf_map_fd);
-	skel_closenz(skel->links.dump_bpf_prog_fd);
+	skel_closenez(skel->links.dump_bpf_map_fd);
+	skel->links.dump_bpf_map_fd =3D -1;
+	skel_closenez(skel->links.dump_bpf_prog_fd);
+	skel->links.dump_bpf_prog_fd =3D -1;
 }
 static void
 iterators_bpf__destroy(struct iterators_bpf *skel)
@@ -66,10 +68,10 @@ iterators_bpf__destroy(struct iterators_bpf *skel)
 	if (!skel)
 		return;
 	iterators_bpf__detach(skel);
-	skel_closenz(skel->progs.dump_bpf_map.prog_fd);
-	skel_closenz(skel->progs.dump_bpf_prog.prog_fd);
+	skel_closenez(skel->progs.dump_bpf_map.prog_fd);
+	skel_closenez(skel->progs.dump_bpf_prog.prog_fd);
 	skel_free_map_data(skel->rodata, skel->maps.rodata.initial_value, 4096);
-	skel_closenz(skel->maps.rodata.map_fd);
+	skel_closenez(skel->maps.rodata.map_fd);
 	skel_free(skel);
 }
 static inline struct iterators_bpf *
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 145734b4fe41..e60b3feeddef 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -469,7 +469,7 @@ static void codegen_attach_detach(struct bpf_object *ob=
j, const char *obj_name)
 		codegen("\
 			\n\
 										    \n\
-				if (fd > 0)					    \n\
+				if (fd >=3D 0)					    \n\
 					skel->links.%1$s_fd =3D fd;		    \n\
 				return fd;					    \n\
 			}							    \n\
@@ -506,7 +506,8 @@ static void codegen_attach_detach(struct bpf_object *ob=
j, const char *obj_name)
 	bpf_object__for_each_program(prog, obj) {
 		codegen("\
 			\n\
-				skel_closenz(skel->links.%1$s_fd);	    \n\
+				skel_closenez(skel->links.%1$s_fd);	    \n\
+				skel->links.%1$s_fd =3D -1;	    \n\
 			", bpf_program__name(prog));
 	}
=20
@@ -536,7 +537,7 @@ static void codegen_destroy(struct bpf_object *obj, con=
st char *obj_name)
 	bpf_object__for_each_program(prog, obj) {
 		codegen("\
 			\n\
-				skel_closenz(skel->progs.%1$s.prog_fd);	    \n\
+				skel_closenez(skel->progs.%1$s.prog_fd);	    \n\
 			", bpf_program__name(prog));
 	}
=20
@@ -549,7 +550,7 @@ static void codegen_destroy(struct bpf_object *obj, con=
st char *obj_name)
 			       ident, bpf_map_mmap_sz(map));
 		codegen("\
 			\n\
-				skel_closenz(skel->maps.%1$s.map_fd);	    \n\
+				skel_closenez(skel->maps.%1$s.map_fd);	    \n\
 			", ident);
 	}
 	codegen("\
diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index bd6f4505e7b1..51e81e79bdf2 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -204,11 +204,11 @@ static inline void *skel_finalize_map_data(__u64 *ini=
t_val, size_t mmap_sz, int
 }
 #endif
=20
-static inline int skel_closenz(int fd)
+static inline int skel_closenez(int fd)
 {
-	if (fd > 0)
-		return close(fd);
-	return -EINVAL;
+	if (fd < 0)
+		return -EINVAL;
+	return close(fd);
 }
=20
 #ifndef offsetofend
--=20
2.30.2

