Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A33875C8F1
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2019 07:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbfGBFqy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jul 2019 01:46:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41712 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbfGBFqy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Jul 2019 01:46:54 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x625jIh1010633
        for <bpf@vger.kernel.org>; Mon, 1 Jul 2019 22:46:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=F7DB+7gf0K3QCbq7V50rpdH9bvZe2aJ1bU7On+a3fmk=;
 b=ZOqCnAawg77EGx4nq61uQNHM0Cwho3IRgp8F0n5o0I4xHxCPq6c6f4mWuBJ898GJ1ZiG
 /B+FHgz2uLu+z8qX/EFETvTrPd3hXEqBzvhqZgIXIwwzWwsASWew1FWv5/4KOmS9m6VQ
 +hUMFkUVKx8jRSPq7OA0w1BTb0+v4S76E+U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2tfns4a9rn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 22:46:53 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 1 Jul 2019 22:46:52 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id A6CBE8614A2; Mon,  1 Jul 2019 22:46:49 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>
CC:     Andrii Nakryiko <andriin@fb.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] libbpf: fix GCC8 warning for strncpy
Date:   Mon, 1 Jul 2019 22:46:47 -0700
Message-ID: <20190702054647.1686489-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907020064
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

GCC8 started emitting warning about using strncpy with number of bytes
exactly equal destination size, which is generally unsafe, as can lead
to non-zero terminated string being copied. Use IFNAMSIZ - 1 as number
of bytes to ensure name is always zero-terminated.

Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index bf15a80a37c2..9588e7f87d0b 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -327,7 +327,7 @@ static int xsk_get_max_queues(struct xsk_socket *xsk)
 
 	channels.cmd = ETHTOOL_GCHANNELS;
 	ifr.ifr_data = (void *)&channels;
-	strncpy(ifr.ifr_name, xsk->ifname, IFNAMSIZ);
+	strncpy(ifr.ifr_name, xsk->ifname, IFNAMSIZ - 1);
 	err = ioctl(fd, SIOCETHTOOL, &ifr);
 	if (err && errno != EOPNOTSUPP) {
 		ret = -errno;
-- 
2.17.1

