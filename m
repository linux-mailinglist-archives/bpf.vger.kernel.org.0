Return-Path: <bpf+bounces-7921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEBA77E7A7
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 19:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0A71C20FC0
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 17:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A63174C2;
	Wed, 16 Aug 2023 17:32:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0439410949
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 17:32:54 +0000 (UTC)
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5C52D67
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 10:32:40 -0700 (PDT)
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37G6RIIR022984;
	Wed, 16 Aug 2023 17:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=default; bh=CsgnZ8E2J
	DOY/TilRwrPWv227qh6UzwN0BYvMhkFhw8=; b=Tbj7frwV/oGGyCkGP5Jc0gyvA
	poe9vSw2pYxHbXxNCR316dftlgEY2hHwiRvbYTYYbIcsJEQx4orRVRX5Lfss5wRJ
	K/zqnAhDrWngYJiv0pqvn9Aep+yUeUGxr2sbXj6RSgskCzwD7DWgCU/aqx/yg5sC
	p/YPAOHYxWr7qQrQeNl9yMptpJYeMbiCv9A468yPmjiw7HlfE6Z6nrDUNwqI64Jb
	y0ZUZi2qb1mybsYUxp2Ru/tJ4dgZeWlJ5LO0s/Hyl8T1bW2+XjW7M3rzhacnK9ts
	az48xrYL4YZNwbgBkQ18yrrVil/F28qpCYBOl21NepvpAzO5FDlRE12Hbt9HQ==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3sgs6nhadp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Aug 2023 17:32:21 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Wed, 16 Aug 2023 17:32:19 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Kelly
	<martin.kelly@crowdstrike.com>
Subject: [PATCH bpf] libbpf: soften BTF map error
Date: Wed, 16 Aug 2023 10:30:32 -0700
Message-ID: <20230816173030.148536-1-martin.kelly@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.11.122]
X-ClientProxiedBy: 04wpexch03.crowdstrike.sys (10.100.11.93) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: lxg284taqTGroUcLvYa4OFBhfMaNawfO
X-Proofpoint-GUID: lxg284taqTGroUcLvYa4OFBhfMaNawfO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_18,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308160154
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For map-in-map types, the first time the map is loaded, we get a scary
error looking like this:

libbpf: bpf_create_map_xattr(map_name):ERROR: strerror_r(-524)=22(-524). Retrying without BTF.

On the second try without BTF, everything works fine. However, as this
is logged at error level, it looks needlessly scary to users. Soften
this to be at debug level; if the second attempt still fails, we'll
still get an error as expected.

Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b14a4376a86e..0ca0c8d01707 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5123,7 +5123,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 
 		err = -errno;
 		cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
-		pr_warn("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
+		pr_debug("bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
 			map->name, cp, err);
 		create_attr.btf_fd = 0;
 		create_attr.btf_key_type_id = 0;
-- 
2.34.1


