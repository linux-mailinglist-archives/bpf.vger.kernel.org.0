Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D096523CD3
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 20:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbiEKSru (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 14:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346464AbiEKSrs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 14:47:48 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCCD19322F
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 11:47:45 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BGKhrS026259
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 11:47:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Ggphd/uinDmGR6gNcHzsA/wlZjwlxpYHWyaDKsZnOK0=;
 b=prWmwp99sYJaJH28EzVPsWQrVhjK0WqxUpDEFGFs/DtB5uBGrzLWF0iCvDV7xFHIGEfq
 J44bfB0vC/7QEONpUlVA5OxErhEW+8e7d/5Sx0tGHxaidIJ9kZbiSEXGG6lpQUvqsDl/
 za+SsceXXcR531F/18cFW5Dp9daDpI/Lu4w= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g04tb51ah-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 11:47:44 -0700
Received: from twshared16483.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 11:47:41 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id A15CBA2AD043; Wed, 11 May 2022 11:47:35 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix a few clang compilation errors
Date:   Wed, 11 May 2022 11:47:35 -0700
Message-ID: <20220511184735.3670214-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ElF02oHPM8POll0bfE_2A5UNolEMyp-M
X-Proofpoint-ORIG-GUID: ElF02oHPM8POll0bfE_2A5UNolEMyp-M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With latest clang, I got the following compilation errors:
  .../prog_tests/test_tunnel.c:291:6: error: variable 'local_ip_map_fd' i=
s used uninitialized
     whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
       if (attach_tc_prog(&tc_hook, -1, set_dst_prog_fd))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  .../bpf/prog_tests/test_tunnel.c:312:6: note: uninitialized use occurs =
here
        if (local_ip_map_fd >=3D 0)
            ^~~~~~~~~~~~~~~
  ...
  .../prog_tests/kprobe_multi_test.c:346:6: error: variable 'err' is used=
 uninitialized
      whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (IS_ERR(map))
            ^~~~~~~~~~~
  .../prog_tests/kprobe_multi_test.c:388:6: note: uninitialized use occur=
s here
        if (err) {
            ^~~

This patch fixed the above compilation errors.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 4 +++-
 tools/testing/selftests/bpf/prog_tests/test_tunnel.c       | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 816eacededd1..586dc52d6fb9 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -343,8 +343,10 @@ static int get_syms(char ***symsp, size_t *cntp)
 		return -EINVAL;
=20
 	map =3D hashmap__new(symbol_hash, symbol_equal, NULL);
-	if (IS_ERR(map))
+	if (IS_ERR(map)) {
+		err =3D libbpf_get_error(map);
 		goto error;
+	}
=20
 	while (fgets(buf, sizeof(buf), f)) {
 		/* skip modules */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools=
/testing/selftests/bpf/prog_tests/test_tunnel.c
index 071c9c91b50f..3bba4a2a0530 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -246,7 +246,7 @@ static void test_vxlan_tunnel(void)
 {
 	struct test_tunnel_kern *skel =3D NULL;
 	struct nstoken *nstoken;
-	int local_ip_map_fd;
+	int local_ip_map_fd =3D -1;
 	int set_src_prog_fd, get_src_prog_fd;
 	int set_dst_prog_fd;
 	int key =3D 0, ifindex =3D -1;
@@ -319,7 +319,7 @@ static void test_ip6vxlan_tunnel(void)
 {
 	struct test_tunnel_kern *skel =3D NULL;
 	struct nstoken *nstoken;
-	int local_ip_map_fd;
+	int local_ip_map_fd =3D -1;
 	int set_src_prog_fd, get_src_prog_fd;
 	int set_dst_prog_fd;
 	int key =3D 0, ifindex =3D -1;
--=20
2.30.2

