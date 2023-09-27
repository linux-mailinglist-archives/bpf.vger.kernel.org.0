Return-Path: <bpf+bounces-10916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DC47AF9D4
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 07:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5F4582815BA
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 05:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5F713ADF;
	Wed, 27 Sep 2023 05:13:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E8D33CC
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 05:13:55 +0000 (UTC)
X-Greylist: delayed 1375 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 22:13:53 PDT
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E93449D0
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 22:13:53 -0700 (PDT)
Received: from pps.filterd (m0272704.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R4TdZK010007;
	Wed, 27 Sep 2023 04:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=campusrelays;
 bh=2uueXQ6bzaWd5cmzrdq45cutbftXx2Yy91hfDlZrIys=;
 b=Obpw/PcdRUTY7wbMqxTcFCWie7ZrE9wzcLzARd72PnzXOQGavpQlrzgGaqmCwMQ1sgFD
 ADqRSCdu8gVO/aJivY3rL1HkyaLTUAnlz4fx4E9ozORz8lqYwT0PNcwg4NZ6q2c2jUFC
 k3H9rz5GCP52WzV0Gu3dO04XddNTVPyvVOcJkbaS2agYv5EMxwrTA9e1h4HFkNvHrPyI
 EnhMO6+q7iD5hYWVvnkxxnhQ0ybxdHYExKAXAiZhYQ50/6rRC2ns1/QzlejbuWNlCgbl
 /jQu71QnRE7fSL5X89b38V/MxFuR1WkQQRNaDydzCFyxI7y4otghXw0kZn0mFxWR9Qks 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3tbf41veax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Sep 2023 04:50:42 +0000
Received: from m0272704.ppops.net (m0272704.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38R4oYT4016491;
	Wed, 27 Sep 2023 04:50:41 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0b-00007101.pphosted.com (PPS) with ESMTP id 3tbf41vea5-2;
	Wed, 27 Sep 2023 04:50:41 +0000
From: ruowenq2@illinois.edu
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        jinghao7@illinois.edu, keescook@chromium.org,
        Ruowen Qin <ruowenq2@illinois.edu>, Mimi Zohar <zohar@linux.ibm.com>,
        Jinghao Jia <jinghao@linux.ibm.com>
Subject: [PATCH bpf-next v3 1/1] samples/bpf: Add -fsanitize=bounds to userspace programs
Date: Tue, 26 Sep 2023 23:50:30 -0500
Message-ID: <20230927045030.224548-2-ruowenq2@illinois.edu>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230927045030.224548-1-ruowenq2@illinois.edu>
References: <20230927045030.224548-1-ruowenq2@illinois.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mkmP6cQ04UE2ali87eslm1jvYkp4HVFg
X-Proofpoint-ORIG-GUID: CG2Wzqo_SXCzmK03vuMJJ7ryr0XqGeV9
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1011
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309270038
X-Spam-Score: 0
X-Spam-OrigSender: ruowenq2@illinois.edu
X-Spam-Bar: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ruowen Qin <ruowenq2@illinois.edu>

The sanitizer flag, which is supported by both clang and gcc, would make
it easier to debug array index out-of-bounds problems in these programs.

Make the Makfile smarter to detect ubsan support from the compiler and
add the '-fsanitize=bounds' accordingly.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
Signed-off-by: Ruowen Qin <ruowenq2@illinois.edu>
---
 samples/bpf/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 6c707ebcebb9..90af76fa9dd8 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -169,6 +169,9 @@ endif
 TPROGS_CFLAGS += -Wall -O2
 TPROGS_CFLAGS += -Wmissing-prototypes
 TPROGS_CFLAGS += -Wstrict-prototypes
+TPROGS_CFLAGS += $(call try-run,\
+	printf "int main() { return 0; }" |\
+	$(CC) -Werror -fsanitize=bounds -x c - -o "$$TMP",-fsanitize=bounds,)
 
 TPROGS_CFLAGS += -I$(objtree)/usr/include
 TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
-- 
2.42.0


