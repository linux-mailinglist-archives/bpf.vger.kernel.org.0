Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E4E59C94C
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 21:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiHVTxc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 15:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiHVTxb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 15:53:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0A6CE1F
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 12:53:30 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MGNlR6024119
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 12:53:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=OOkbUYI84dj/Nf9KIXD6ThOXzXf94X325Tyj1Y9w52o=;
 b=QVodv45AmHVVfNJ3RKNvqxpbnibeDrtDfIEWVu7gtyYi+UqiRW52kjfTOJ16jlD7v4at
 Qg4z0IyN/w9iyg1CJv3xIYHqZf30GZf2sUUIkCJk5QYu1zudyRbx7UjOV/qoqV8JjlOV
 KPHoFIX3FZK9cYI7ozhA1LqYh5+MCr87/+0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j43hpdbt7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 12:53:30 -0700
Received: from twshared20276.35.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 12:53:28 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id E80026F9D4B5; Mon, 22 Aug 2022 12:53:14 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-nex] bpf: Fix an inconsitency between copies of bpf.h.
Date:   Mon, 22 Aug 2022 12:52:21 -0700
Message-ID: <20220822195221.1690013-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: a2IEmdgIMdm9WSokBT5H620zdSXQ2Xie
X-Proofpoint-ORIG-GUID: a2IEmdgIMdm9WSokBT5H620zdSXQ2Xie
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_12,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

struct bpf_lpm_trie_key is inconsistent in two copies of bpf.h.
It cuases a warning message during building the kernel.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 include/uapi/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 934a2a8beb87..1d6085e15fc8 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -79,7 +79,7 @@ struct bpf_insn {
 /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
 struct bpf_lpm_trie_key {
 	__u32	prefixlen;	/* up to 32 for AF_INET, 128 for AF_INET6 */
-	__u8	data[];	/* Arbitrary size */
+	__u8	data[0];	/* Arbitrary size */
 };
=20
 struct bpf_cgroup_storage_key {
--=20
2.30.2

