Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA124B2901
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 16:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351347AbiBKPVN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 10:21:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348681AbiBKPVN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 10:21:13 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41CACE1
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 07:21:11 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21BESl0E004497
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 07:21:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=RQ6NnodgpXvjbCRG7gnLe6alQ6BwPq7cvdhumld9KNA=;
 b=qPSew9NyOXwAx30aygCTV+pe6JpQ+Nc0+J9xpY1D4Goh5E0fqNGVGuUJPyt7cWzjOTvy
 LVxBe8W30xOp2bCL3LPBHgUhDuQv7XQQa0A4sz7swhOLTCr5ga3ThEsEH+sb9k88Yykw
 YM+y0OnO/NUkUe8xcipvAO5oXCQE3PgUhNc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e58y9wxef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 07:21:10 -0800
Received: from twshared18912.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 07:21:10 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 80884640F49C; Fri, 11 Feb 2022 07:20:59 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf v2 1/2] bpf: fix a bpf_timer initialization issue
Date:   Fri, 11 Feb 2022 07:20:59 -0800
Message-ID: <20220211152059.1584701-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220211152054.1584283-1-yhs@fb.com>
References: <20220211152054.1584283-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: UdLk6wIl2uivjlTe27bjnE1d7-gP-VAi
X-Proofpoint-ORIG-GUID: UdLk6wIl2uivjlTe27bjnE1d7-gP-VAi
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_05,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 mlxlogscore=498 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202110084
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

The patch in [1] intends to fix a bpf_timer related issue,
but the fix caused existing 'timer' selftest to fail with
hang or some random errors. After some debug, I found
an issue with check_and_init_map_value() in the hashtab.c.
More specifically, in hashtab.c, we have code
  l_new =3D bpf_map_kmalloc_node(&htab->map, ...)
  check_and_init_map_value(&htab->map, l_new...)
Note that bpf_map_kmalloc_node() does not do initialization
so l_new contains random value.

The function check_and_init_map_value() intends to zero the
bpf_spin_lock and bpf_timer if they exist in the map.
But I found bpf_spin_lock is zero'ed but bpf_timer is not zero'ed.
With [1], later copy_map_value() skips copying of
bpf_spin_lock and bpf_timer. The non-zero bpf_timer caused
random failures for 'timer' selftest.
Without [1], for both bpf_spin_lock and bpf_timer case,
bpf_timer will be zero'ed, so 'timer' self test is okay.

For check_and_init_map_value(), why bpf_spin_lock is zero'ed
properly while bpf_timer not. In bpf uapi header, we have
  struct bpf_spin_lock {
        __u32   val;
  };
  struct bpf_timer {
        __u64 :64;
        __u64 :64;
  } __attribute__((aligned(8)));

The initialization code:
  *(struct bpf_spin_lock *)(dst + map->spin_lock_off) =3D
      (struct bpf_spin_lock){};
  *(struct bpf_timer *)(dst + map->timer_off) =3D
      (struct bpf_timer){};
It appears the compiler has no obligation to initialize anonymous fields.
For example, let us use clang with bpf target as below:
  $ cat t.c
  struct bpf_timer {
        unsigned long long :64;
  };
  struct bpf_timer2 {
        unsigned long long a;
  };

  void test(struct bpf_timer *t) {
    *t =3D (struct bpf_timer){};
  }
  void test2(struct bpf_timer2 *t) {
    *t =3D (struct bpf_timer2){};
  }
  $ clang -target bpf -O2 -c -g t.c
  $ llvm-objdump -d t.o
   ...
   0000000000000000 <test>:
       0:       95 00 00 00 00 00 00 00 exit
   0000000000000008 <test2>:
       1:       b7 02 00 00 00 00 00 00 r2 =3D 0
       2:       7b 21 00 00 00 00 00 00 *(u64 *)(r1 + 0) =3D r2
       3:       95 00 00 00 00 00 00 00 exit

To fix the problem, let use memset for bpf_timer case in
check_and_init_map_value(). For consistency, memset is also
used for bpf_spin_lock case.

  [1] https://lore.kernel.org/bpf/20220209070324.1093182-2-memxor@gmail.com/

Fixes: 68134668c17f3 ("bpf: Add map side support for bpf timers.")
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fa517ae604ad..1a4c73742a1f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -209,11 +209,9 @@ static inline bool map_value_has_timer(const struct bp=
f_map *map)
 static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
 {
 	if (unlikely(map_value_has_spin_lock(map)))
-		*(struct bpf_spin_lock *)(dst + map->spin_lock_off) =3D
-			(struct bpf_spin_lock){};
+		memset(dst + map->spin_lock_off, 0, sizeof(struct bpf_spin_lock));
 	if (unlikely(map_value_has_timer(map)))
-		*(struct bpf_timer *)(dst + map->timer_off) =3D
-			(struct bpf_timer){};
+		memset(dst + map->timer_off, 0, sizeof(struct bpf_timer));
 }
=20
 /* copy everything but bpf_spin_lock and bpf_timer. There could be one of =
each. */
--=20
2.30.2

