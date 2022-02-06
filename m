Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7580C4AB06A
	for <lists+bpf@lfdr.de>; Sun,  6 Feb 2022 16:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244265AbiBFPzZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Feb 2022 10:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiBFPzT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Feb 2022 10:55:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665D2C06173B
        for <bpf@vger.kernel.org>; Sun,  6 Feb 2022 07:55:18 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2168D2e8026527;
        Sun, 6 Feb 2022 14:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=7iZpFHGvImMlDxL1HWf2s/mna/rDNGpoZZoiI0/EgDI=;
 b=Q4gEiEP4Lj+HChcxpVcKkNJ0EulzobBR6b5aB2J6kJTmQcJ9nrldOTm1/jAmK1E+r5Gy
 QwJnHhUNpZMl46myQoigvshQKYyLheVL2gXw0VdHJOj/OX1fPkfJsEaL6jw2uAtUAu21
 /OF77cAUrD/o/WLpFM+dOZfC+Kukk3ma1nSzo4hNrAiyXryH9I5guklnZF5NIvm8VhRf
 I7nW+rwVEzguI+rzgufrD6r0X9Uin+ltf4CxYuX6X9wFYsVj//3T0D6AZNJGZRWWAsEE
 MVngi0TLmAb3jeMFHEO9eTqxGAFkSxqzRzFA17eo8Yj3d+eWbrncklwsIkWuG5NiavGs qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e23an8v0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 14:54:06 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 216EmxjV006734;
        Sun, 6 Feb 2022 14:54:05 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e23an8v06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 14:54:05 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 216Em9Jv017124;
        Sun, 6 Feb 2022 14:54:03 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3e1gv8x11p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 14:54:03 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 216Es0qt40894966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Feb 2022 14:54:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45E4911C050;
        Sun,  6 Feb 2022 14:54:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE99B11C04A;
        Sun,  6 Feb 2022 14:53:59 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  6 Feb 2022 14:53:59 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 0/2] Fix bpf_perf_event_data ABI breakage
Date:   Sun,  6 Feb 2022 15:53:48 +0100
Message-Id: <20220206145350.2069779-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pCtuykMWeFTGxTP9TloU4MDtQq15aipA
X-Proofpoint-ORIG-GUID: uwtM9W3pCMtGDcEcxnq0DuzwzkIWnCKL
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-06_04,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202060108
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf CI noticed that my recent changes broke bpf_perf_event_data ABI
on s390 [1]. Testing shows that they introduced a similar breakage on
arm64. The problem is that we are not allowed to extend user_pt_regs,
since it's used by bpf_perf_event_data.

This series fixes these problems by removing the new members and
introducing user_pt_regs_v2 instead.

[1] https://github.com/libbpf/libbpf/runs/5079938810

Ilya Leoshkevich (2):
  s390/bpf: Introduce user_pt_regs_v2
  arm64/bpf: Introduce struct user_pt_regs_v2

 arch/arm64/include/asm/ptrace.h      |  1 +
 arch/arm64/include/uapi/asm/ptrace.h |  7 +++++++
 arch/s390/include/asm/ptrace.h       |  1 +
 arch/s390/include/uapi/asm/ptrace.h  | 10 ++++++++--
 tools/lib/bpf/bpf_tracing.h          | 10 ++++++----
 5 files changed, 23 insertions(+), 6 deletions(-)

-- 
2.34.1

