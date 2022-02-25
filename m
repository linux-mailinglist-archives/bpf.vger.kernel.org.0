Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1494C4E34
	for <lists+bpf@lfdr.de>; Fri, 25 Feb 2022 19:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiBYTAW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 14:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiBYTAV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 14:00:21 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53AC2023AA
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 10:59:48 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21PEIYgX012312
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 10:59:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=hycLjxix3d+J4pl770y11Ykybb+6xGWiOWRIMeLKxjE=;
 b=eFzwe3Ut2io8QL07m+v4bVPE42X/ymJZyk23Zu8hGUlNYO5Ui9RrTDicUBTSMCuLEHQF
 j4eiSvtkjgDl7gB4eBH2cKMK5NiO61jsHrYSMcc8RfUJ5a49C7xDsz/uc0qxxTWbwbdM
 +53rhQapBlpOfCVJlN8zOxzVc2XLI4VeFRk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ef0rnhx4a-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 10:59:48 -0800
Received: from twshared33837.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 10:59:45 -0800
Received: by devvm4573.vll0.facebook.com (Postfix, from userid 200310)
        id 618E040549BB; Fri, 25 Feb 2022 10:59:35 -0800 (PST)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <fallentree@fb.com>, <ast@kernel.org>,
        <sunyucong@gmail.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3] bpf: Fix issue with bpf preload module taking over stdout/stdin of kernel.
Date:   Fri, 25 Feb 2022 10:59:24 -0800
Message-ID: <20220225185923.2535519-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: nhvfzrC0nydTmW1XYf6opxarA_7jiGkF
X-Proofpoint-ORIG-GUID: nhvfzrC0nydTmW1XYf6opxarA_7jiGkF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_10,2022-02-25_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 adultscore=0 spamscore=0 phishscore=0 impostorscore=0
 mlxlogscore=648 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202250108
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

In a previous commit (1), BPF preload process was switched from user mode
process to use in-kernel light skeleton instead. However, in the kernel c=
ontext
the available FD starts from 0, instead of normally 3 for user mode proce=
ss.
The preload process also left two FDs open, taking over FD 0 and 1. This =
later
caused issues when kernel trys to setup stdin/stdout/stderr for init proc=
ess,
assuming FD 0,1,2 are available.

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
  - skel_closenz was changed to skel_closegez to correctly handle
    FD=3D0 case.
  - various places detecting FD > 0 was changed to FD >=3D 0.
  - Call iterators_skel__detach() funciton to release FDs after links
  are obtained.

1: commit cb80ddc ("bpf: Convert bpf_preload.ko to use light skeleton.")

Fixes: commit cb80ddc ("bpf: Convert bpf_preload.ko to use light skeleton=
.")
Signed-off-by: Yucong Sun <fallentree@fb.com>

V3 -> V1: removed all changes related to handle fd=3D0.
V2 -> V1: rename skel_closenez to skel_closegez, added comment as
requested.
---
 kernel/bpf/preload/bpf_preload_kern.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/b=
pf_preload_kern.c
index 30207c048d36..13cd0d146dd7 100644
--- a/kernel/bpf/preload/bpf_preload_kern.c
+++ b/kernel/bpf/preload/bpf_preload_kern.c
@@ -54,6 +54,16 @@ static int load_skel(void)
 		err =3D PTR_ERR(progs_link);
 		goto out;
 	}
+	/* Avoid taking over stdin/stdout/stderr of init process. This also
+	   makes skel_closenz() no-op later in free_links_and_skel(). */
+	if (skel->links.dump_bpf_map_fd < 3) {
+		close_fd(skel->links.dump_bpf_map_fd);
+		skel->links.dump_bpf_map_fd =3D 0;
+	}
+	if (skel->links.dump_bpf_prog_fd < 3) {
+		close_fd(skel->links.dump_bpf_prog_fd);
+		skel->links.dump_bpf_prog_fd =3D 0;
+	}
 	return 0;
 out:
 	free_links_and_skel();
--=20
2.30.2

