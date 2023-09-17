Return-Path: <bpf+bounces-10239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE2E7A3E02
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 23:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA721C20852
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 21:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA6DF50D;
	Sun, 17 Sep 2023 21:43:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01235EAFB
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 21:43:05 +0000 (UTC)
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34BAA8
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 14:43:04 -0700 (PDT)
Received: from pps.filterd (m0166258.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38HAeZZA011217;
	Sun, 17 Sep 2023 21:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=campusrelays;
 bh=qOmkD/3E0lYHuxf5m0DEPc2l2u/is83e69G9PscbsFo=;
 b=FFSdgRY/8NTdlnprCY535GIMavBJccEQtmxbo5E3E01D8Ed0so0cvWIt/T5F5OBkHb9s
 pUi/pwYI9wa4ZrhD62fepv4G1S7k60332JeMs2xe0wI4n8cDsIu26/dvW8++luwlw5Vk
 Lm6lKQKD4x1nL1LTzx6w0kgxWjWYgl7yHuRDG+m/Fa1gwblcctWKJtEG3vQJ7eKut484
 RwjS7c7n3U9gFSeYe+B3j056gt6+YDNTuBKXKUMB9iHWe61eGiXzZ1mE/3HgkeyaeqPj
 CgGJja6A9xVddXJg6WC4+a1/tzx9HL0JTOG6EL3HZ5zD33L/DdhsxXcFRpTkhgQkIaDw Og== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3t52qqrd2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Sep 2023 21:42:42 +0000
Received: from m0166258.ppops.net (m0166258.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38HLgcsu002067;
	Sun, 17 Sep 2023 21:42:42 GMT
Received: from localhost.localdomain (oasis.cs.illinois.edu [130.126.137.13])
	by mx0b-00007101.pphosted.com (PPS) with ESMTP id 3t52qqrd22-2;
	Sun, 17 Sep 2023 21:42:42 +0000
From: Jinghao Jia <jinghao7@illinois.edu>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        jinghao@linux.ibm.com, Mimi Zohar <zohar@linux.ibm.com>,
        Ruowen Qin <ruowenq2@illinois.edu>,
        Jinghao Jia <jinghao7@illinois.edu>
Subject: [PATCH bpf v2 1/3] samples/bpf: Add -fsanitize=bounds to userspace programs
Date: Sun, 17 Sep 2023 16:42:18 -0500
Message-ID: <20230917214220.637721-2-jinghao7@illinois.edu>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917214220.637721-1-jinghao7@illinois.edu>
References: <20230917214220.637721-1-jinghao7@illinois.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eObNq71F796rNYy9NGPdLwvmCfJVky_5
X-Proofpoint-GUID: Ywoic6CA8cpkYmSd3ohH8d_Td4FCZOqg
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1011 impostorscore=0 phishscore=0
 mlxlogscore=835 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309170201
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jinghao Jia <jinghao@linux.ibm.com>

The sanitizer flag, which is supported by both clang and gcc, would make
it easier to debug array index out-of-bounds problems in these programs.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
Signed-off-by: Ruowen Qin <ruowenq2@illinois.edu>
Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
---
 samples/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 4ccf4236031c..21d2edffce3c 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -169,6 +169,7 @@ endif
 TPROGS_CFLAGS += -Wall -O2
 TPROGS_CFLAGS += -Wmissing-prototypes
 TPROGS_CFLAGS += -Wstrict-prototypes
+TPROGS_CFLAGS += -fsanitize=bounds
 
 TPROGS_CFLAGS += -I$(objtree)/usr/include
 TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
-- 
2.42.0


