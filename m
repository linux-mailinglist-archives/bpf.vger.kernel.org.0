Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DC360E574
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 18:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiJZQa1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 12:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbiJZQa0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 12:30:26 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7013A46D
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 09:30:24 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QFxhmD022688
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 09:30:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=JXbg6bjtILwpyroTFKdeNa3p3gaLAH9rKB7vrVLAWPM=;
 b=B/EHpJSSUyJdoMCNxefNisJr5HPEehXv1vuGp0j5j8Hx2avzTBdG9nruKG7o5B9XNZ1B
 j8L5cfDmA+Xq+ZqKfKVN+GNhc4LGidqyB+/Dbp/yzEYgYmL+dcJVgaLiSzKi1v+VHjUR
 kTQM6k1YnBBZueBgs+AXLdIhpPMyxsfzMXo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kf5af29w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 09:30:24 -0700
Received: from twshared9088.05.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 09:30:23 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id A771A11375D2B; Wed, 26 Oct 2022 09:30:14 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix bpftool synctypes checking failure
Date:   Wed, 26 Oct 2022 09:30:14 -0700
Message-ID: <20221026163014.470732-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ZzuI8bnAtZtghNSBzj_ekHX3OxlpIdOJ
X-Proofpoint-ORIG-GUID: ZzuI8bnAtZtghNSBzj_ekHX3OxlpIdOJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_06,2022-10-26_01,2022-06-22_01
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

kernel-patches/bpf failed with error:
  Running bpftool checks...
  Comparing /data/users/ast/net-next/tools/include/uapi/linux/bpf.h (bpf_=
map_type) and
            /data/users/ast/net-next/tools/bpf/bpftool/map.c (do_help() T=
YPE):
            {'cgroup_storage_deprecated', 'cgroup_storage'}
  Comparing /data/users/ast/net-next/tools/include/uapi/linux/bpf.h (bpf_=
map_type) and
            /data/users/ast/net-next/tools/bpf/bpftool/Documentation/bpft=
ool-map.rst (TYPE):
            {'cgroup_storage_deprecated', 'cgroup_storage'}
The selftests/bpf/test_bpftool_synctypes.py runs checking in the above.

The failure is introduced by Commit c4bcfb38a95e("bpf: Implement cgroup s=
torage available
to non-cgroup-attached bpf progs"). The commit introduced BPF_MAP_TYPE_CG=
ROUP_STORAGE_DEPRECATED
which has the same enum value as BPF_MAP_TYPE_CGROUP_STORAGE.

In test_bpftool_synctypes.py, one test is to compare uapi bpf.h map types=
 and
bpftool supported maps. The tool picks 'cgroup_storage_deprecated' from b=
pf.h
while bpftool supported map is displayed as 'cgroup_storage'. The test fa=
ilure
can be fixed by explicitly replacing 'cgroup_storage_deprecated' with 'cg=
roup_storage'
in uapi bpf.h map types.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/test_bpftool_synctypes.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_bpftool_synctypes.py b/tool=
s/testing/selftests/bpf/test_bpftool_synctypes.py
index a6410bebe603..9fe4c9336c6f 100755
--- a/tools/testing/selftests/bpf/test_bpftool_synctypes.py
+++ b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
@@ -501,6 +501,14 @@ def main():
     source_map_types =3D set(bpf_info.get_map_type_map().values())
     source_map_types.discard('unspec')
=20
+    # BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED and BPF_MAP_TYPE_CGROUP_STO=
RAGE
+    # share the same enum value and source_map_types picks
+    # BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED/cgroup_storage_deprecated.
+    # Replace 'cgroup_storage_deprecated' with 'cgroup_storage'
+    # so it aligns with what `bpftool map help` shows.
+    source_map_types.remove('cgroup_storage_deprecated')
+    source_map_types.add('cgroup_storage')
+
     help_map_types =3D map_info.get_map_help()
     help_map_options =3D map_info.get_options()
     map_info.close()
--=20
2.30.2

