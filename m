Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B699606563
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 18:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiJTQHj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 12:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiJTQHi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 12:07:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211265B12F
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 09:07:37 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KFchYU021094
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 09:07:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=CDIOdYwxE335uZcm1fUP27HXFZyAVkI08gGx/E7ExRA=;
 b=oPv6lrUhCAFT9l5BCeG0jC1ksXtA/nV33KY/QTAby/x9wOSRkZbUCy5OPnvxPA0EhBKD
 8s7OwJTNDpS6NBXPYundlRpU8kYbddVkCXKoxp1WlShnnNA9vws0dNy/XzDijgxI129q
 O1YrCtYO8Qd+JEMcJp2t2/nNMR9P58mus0o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kawj0722j-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 09:07:36 -0700
Received: from twshared9269.07.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 09:07:35 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 86B4EF43AEE1; Thu, 20 Oct 2022 09:07:25 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v5 bpf-next 4/4] selftests/bpf: Add write to hashmap to array_map iter test
Date:   Thu, 20 Oct 2022 09:07:21 -0700
Message-ID: <20221020160721.4030492-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221020160721.4030492-1-davemarchevsky@fb.com>
References: <20221020160721.4030492-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pheydeR6HRshaGHuswgkyX47QPLuzwoh
X-Proofpoint-ORIG-GUID: pheydeR6HRshaGHuswgkyX47QPLuzwoh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_07,2022-10-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Modify iter prog in existing bpf_iter_bpf_array_map.c, which currently
dumps arraymap key/val, to also do a write of (val, key) into a
newly-added hashmap. Confirm that the write succeeds as expected by
modifying the userspace runner program.

Before a change added in an earlier commit - considering PTR_TO_BUF reg
a valid input to helpers which expect MAP_{KEY,VAL} - the verifier
would've rejected this prog change due to type mismatch. Since using
current iter's key/val to access a separate map is a reasonable usecase,
let's add support for it.

Note that the test prog cannot directly write (val, key) into hashmap
via bpf_map_update_elem when both come from iter context because key is
marked MEM_RDONLY. This is due to bpf_map_update_elem - and other basic
map helpers - taking ARG_PTR_TO_MAP_{KEY,VALUE} w/o MEM_RDONLY type
flag. bpf_map_{lookup,update,delete}_elem don't modify their
input key/val so it should be possible to tag their args READONLY, but
due to the ubiquitous use of these helpers and verifier checks for
type =3D=3D MAP_VALUE, such a change is nontrivial and seems better to
address in a followup series.

Also fixup some 'goto's in test runner's map checking loop.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 20 ++++++++++++------
 .../bpf/progs/bpf_iter_bpf_array_map.c        | 21 ++++++++++++++++++-
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
index c39d40f4b268..6f8ed61fc4b4 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -941,10 +941,10 @@ static void test_bpf_array_map(void)
 {
 	__u64 val, expected_val =3D 0, res_first_val, first_val =3D 0;
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
-	__u32 expected_key =3D 0, res_first_key;
+	__u32 key, expected_key =3D 0, res_first_key;
+	int err, i, map_fd, hash_fd, iter_fd;
 	struct bpf_iter_bpf_array_map *skel;
 	union bpf_iter_link_info linfo;
-	int err, i, map_fd, iter_fd;
 	struct bpf_link *link;
 	char buf[64] =3D {};
 	int len, start;
@@ -1001,12 +1001,20 @@ static void test_bpf_array_map(void)
 	if (!ASSERT_EQ(skel->bss->val_sum, expected_val, "val_sum"))
 		goto close_iter;
=20
+	hash_fd =3D bpf_map__fd(skel->maps.hashmap1);
 	for (i =3D 0; i < bpf_map__max_entries(skel->maps.arraymap1); i++) {
 		err =3D bpf_map_lookup_elem(map_fd, &i, &val);
-		if (!ASSERT_OK(err, "map_lookup"))
-			goto out;
-		if (!ASSERT_EQ(i, val, "invalid_val"))
-			goto out;
+		if (!ASSERT_OK(err, "map_lookup arraymap1"))
+			goto close_iter;
+		if (!ASSERT_EQ(i, val, "invalid_val arraymap1"))
+			goto close_iter;
+
+		val =3D i + 4;
+		err =3D bpf_map_lookup_elem(hash_fd, &val, &key);
+		if (!ASSERT_OK(err, "map_lookup hashmap1"))
+			goto close_iter;
+		if (!ASSERT_EQ(key, val - 4, "invalid_val hashmap1"))
+			goto close_iter;
 	}
=20
 close_iter:
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c b=
/tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c
index 6286023fd62b..c5969ca6f26b 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c
@@ -19,13 +19,20 @@ struct {
 	__type(value, __u64);
 } arraymap1 SEC(".maps");
=20
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 10);
+	__type(key, __u64);
+	__type(value, __u32);
+} hashmap1 SEC(".maps");
+
 __u32 key_sum =3D 0;
 __u64 val_sum =3D 0;
=20
 SEC("iter/bpf_map_elem")
 int dump_bpf_array_map(struct bpf_iter__bpf_map_elem *ctx)
 {
-	__u32 *key =3D ctx->key;
+	__u32 *hmap_val, *key =3D ctx->key;
 	__u64 *val =3D ctx->value;
=20
 	if (key =3D=3D (void *)0 || val =3D=3D (void *)0)
@@ -35,6 +42,18 @@ int dump_bpf_array_map(struct bpf_iter__bpf_map_elem *=
ctx)
 	bpf_seq_write(ctx->meta->seq, val, sizeof(__u64));
 	key_sum +=3D *key;
 	val_sum +=3D *val;
+
+	/* workaround - It's necessary to do this convoluted (val, key)
+	 * write into hashmap1, instead of simply doing
+	 *   bpf_map_update_elem(&hashmap1, val, key, BPF_ANY);
+	 * because key has MEM_RDONLY flag and bpf_map_update elem expects
+	 * types without this flag
+	 */
+	bpf_map_update_elem(&hashmap1, val, val, BPF_ANY);
+	hmap_val =3D bpf_map_lookup_elem(&hashmap1, val);
+	if (hmap_val)
+		*hmap_val =3D *key;
+
 	*val =3D *key;
 	return 0;
 }
--=20
2.30.2

