Return-Path: <bpf+bounces-7503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19067778392
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 00:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF041C20D68
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 22:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3C025149;
	Thu, 10 Aug 2023 22:22:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D5722F02
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 22:22:48 +0000 (UTC)
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84392717
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 15:22:47 -0700 (PDT)
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37AIxtMQ016096;
	Thu, 10 Aug 2023 21:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=default; bh=vRl8VUDqK
	+kxu1qqP1KTRlJIk3Qeh/ckZJFSE82UaUo=; b=VfpVl4ez0iK6YvMT3bD9MXOyR
	BwwDrx6dLQwL8OD68z6zEHZCkUkXcKbh3nHO4MGXlc0LPY3dhwF9Hxqy73n2br0a
	G/P0lK4HSK8lNWObz0KSAPGYWou/2XBhqplX3ngMD00wtBJM9QioP2fVf00keawp
	LLqDv4dRU1MBK361fnMmLulsiA0GFfcDmWwcKHdqNcOumyP3LADdNuQPIfQ/d9d4
	U5hsFpTWJm3XR8awgzm7bc7gZwnED8U3aAT6HFZEO0b08ithKQ4gbSvlxaJ4668K
	t72owpJG7gbhArhJrsKbTk90A9Ge5mF+M2Yri+l9t3T8iDA0vjt1j0/XUXimQ==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3sbx1adj68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Aug 2023 21:45:50 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 10 Aug 2023 21:45:48 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Martin Kelly <martin.kelly@crowdstrike.com>,
        Marco Vedovati
	<marco.vedovati@crowdstrike.com>
Subject: [PATCH bpf-next] libbpf: set close-on-exec flag on gzopen
Date: Thu, 10 Aug 2023 14:43:53 -0700
Message-ID: <20230810214350.106301-1-martin.kelly@crowdstrike.com>
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
X-ClientProxiedBy: 04WPEXCH10.crowdstrike.sys (10.100.11.114) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: tqf7gHNHzwnhE0Arr1uK0kDhFVfiLtPX
X-Proofpoint-GUID: tqf7gHNHzwnhE0Arr1uK0kDhFVfiLtPX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=834
 suspectscore=0 mlxscore=0 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308100187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Marco Vedovati <marco.vedovati@crowdstrike.com>

Enable the close-on-exec flag when using gzopen

This is especially important for multithreaded programs making use of
libbpf, where a fork + exec could race with libbpf library calls,
potentially resulting in a file descriptor leaked to the new process.

Signed-off-by: Marco Vedovati <marco.vedovati@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 17883f5a44b9..b14a4376a86e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1978,9 +1978,9 @@ static int bpf_object__read_kconfig_file(struct bpf_object *obj, void *data)
 		return -ENAMETOOLONG;
 
 	/* gzopen also accepts uncompressed files. */
-	file = gzopen(buf, "r");
+	file = gzopen(buf, "re");
 	if (!file)
-		file = gzopen("/proc/config.gz", "r");
+		file = gzopen("/proc/config.gz", "re");
 
 	if (!file) {
 		pr_warn("failed to open system Kconfig\n");
-- 
2.34.1


