Return-Path: <bpf+bounces-7498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7229D7782D9
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 23:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3B9281E40
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 21:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B97123BFD;
	Thu, 10 Aug 2023 21:50:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0322F0C
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 21:50:16 +0000 (UTC)
X-Greylist: delayed 2410 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Aug 2023 14:50:14 PDT
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CDF2D4D
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 14:50:14 -0700 (PDT)
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37AJBp9V019346;
	Thu, 10 Aug 2023 21:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=default; bh=vRl8VUDqK
	+kxu1qqP1KTRlJIk3Qeh/ckZJFSE82UaUo=; b=Ct3N48n5DsSvpsl/BetFK8hMQ
	JRnAlvuXnUOAnH8nqH73VD4eGGZOI/chvYp8VnJY4pa6u1H6UGcwPkgwgUMx7DMc
	DGGDKA+UYJqQdx2QfI6NwP31JBqHS4Yvj0Q6CpFLPg8NFR7TxUWiyDYsXnHs4nK0
	iZ41y5EHLTwiadKRGYTLEUK7E6LfJ9L9uxNdLMvE+JkUc0FR++W6Uyt+DtAQbocN
	L1IzstH7qUyWBQP16MQ0VSvTQS0rAehyeW8awcJ9Iq4AM9ic2Ot3Ytxqx7VEFRcL
	uHJdqd48FN8UL7ynUcr79oWyQCacCpfA4vFd60zMbRLpp73iWKIq4eStZ0IZA==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 3sd5uc87h6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Aug 2023 21:10:01 +0000 (GMT)
Received: from LL-556NGK3.crowdstrike.sys (10.100.11.122) by
 04wpexch06.crowdstrike.sys (10.100.11.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Thu, 10 Aug 2023 21:09:59 +0000
From: Martin Kelly <martin.kelly@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Marco Vedovati <marco.vedovati@crowdstrike.com>
Subject: [PATCH] libbpf: set close-on-exec flag on gzopen
Date: Thu, 10 Aug 2023 14:09:45 -0700
Message-ID: <20230810210945.100430-1-martin.kelly@crowdstrike.com>
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
X-Proofpoint-GUID: hJHAs87P-nKVbdLWHBPp4LoLwiQLrYCJ
X-Proofpoint-ORIG-GUID: hJHAs87P-nKVbdLWHBPp4LoLwiQLrYCJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=855 mlxscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308100182
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


