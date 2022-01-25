Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CB749A8B7
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 05:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3416242AbiAYDLU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 22:11:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17394 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S3416053AbiAYByZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Jan 2022 20:54:25 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20P0RGfS028827
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 17:09:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=cZ7dE9K7NFKl0Eao6Kf+YTNeplswBO0zXWdQwqJU2GM=;
 b=E9PgURm7IODVItED2KCIycKGlv6JLX1teAZmSDcnekK9HeqIcVB7hfNchlX3gzgUciyR
 aBz1IINLzuw4UBvW2+x5gHENZPTGkfYJgd/PU5GMlC/shMmUNk0Qtin+dvM3whdpvjAD
 o1do/qBmP1+QzAkRfBArbGTixxitpsvVxeM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dsrtsx166-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 17:09:29 -0800
Received: from twshared13036.24.prn2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 17:09:29 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 56BC122A5949; Mon, 24 Jan 2022 17:09:25 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <christyc.y.lee@gmail.com>
CC:     <bpf@vger.kernel.org>, <kernel-team@fb.com>,
        Christy Lee <christylee@fb.com>
Subject: [PATCH bpf-next] libbpf: mark bpf_object__open_xattr() deprecated
Date:   Mon, 24 Jan 2022 17:09:17 -0800
Message-ID: <20220125010917.679975-1-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: x6jDBHzkbNIrcJUYFL396pxk7Y4qoksN
X-Proofpoint-ORIG-GUID: x6jDBHzkbNIrcJUYFL396pxk7Y4qoksN
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_10,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Mark bpf_object__open_xattr() as deprecated, use
bpf_object__open_file() instead.

  [0] Closes: https://github.com/libbpf/libbpf/issues/287

Signed-off-by: Christy Lee <christylee@fb.com>
---
 tools/lib/bpf/libbpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 94670066de62..55dba4c38a04 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -183,6 +183,7 @@ bpf_object__open_mem(const void *obj_buf, size_t obj_bu=
f_sz,
 LIBBPF_API struct bpf_object *
 bpf_object__open_buffer(const void *obj_buf, size_t obj_buf_sz,
 			const char *name);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_object__open_file() instead")
 LIBBPF_API struct bpf_object *
 bpf_object__open_xattr(struct bpf_object_open_attr *attr);
=20
--=20
2.30.2

