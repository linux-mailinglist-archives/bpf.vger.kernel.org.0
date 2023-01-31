Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EB7682CE9
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 13:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjAaMru (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 07:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjAaMrt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 07:47:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F401CC11
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 04:47:48 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V7xE8M011714;
        Tue, 31 Jan 2023 12:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=Srat8aQq6u1oYFVWPqAOTp6W6MIZgY1rqp7jXSC3hF4=;
 b=jIokTzlBBhlRF+Za1kabdaRe5KPs4Hq4Z9E0EEvjunJc6N6DIDKAouY/BB+yaElhBTX+
 it0HgcqV7zkVtHOZ+KtKMAIhQ0g9o8qIxeqw6hl1IaFXeTWAUqOlFpvI1wheNgBvLn0h
 Xf2dmML6srBOfo7AUl6288xY/wnmkP/bmwJ3NE5MolJ7DoKezj5IjHEVMtrYXiuUj/8/
 7sE0p2qVtot6TpOpAmFQ/k02q0x20Y/NPdEvruutemih/eclqryvqOwibLIUkzhF73QT
 YVUcPghZ9gf34ZAmg7Obd4CPbEZ+RVFEHJoEzFAjDaRc5o5AY1DphrozPSZUhA0xdx3q vQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvr8nf0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 12:47:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VCFEET005061;
        Tue, 31 Jan 2023 12:47:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct55u5fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 12:47:28 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30VClRuN038165;
        Tue, 31 Jan 2023 12:47:27 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-170-45.vpn.oracle.com [10.175.170.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nct55u5cq-1;
        Tue, 31 Jan 2023 12:47:27 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org, yhs@fb.com, ast@kernel.org, olsajiri@gmail.com,
        eddyz87@gmail.com, sinquersw@gmail.com, timo@incline.eu
Cc:     daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] dwarves: sync with libbpf-1.1
Date:   Tue, 31 Jan 2023 12:47:21 +0000
Message-Id: <1675169241-32559-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_07,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=963 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310112
X-Proofpoint-GUID: M4kXl3735bIxR7SFfZYOh8pLsLG85bOf
X-Proofpoint-ORIG-GUID: M4kXl3735bIxR7SFfZYOh8pLsLG85bOf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This will pull in BTF dedup improvements

082108f libbpf: Resolve unambigous forward declarations
de048b6 libbpf: Resolve enum fwd as full enum64 and vice versa
f3c51fe libbpf: Btf dedup identical struct test needs check for nested structs/arrays

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index 645500d..6597330 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 645500dd7d2d6b5bb76e4c0375d597d4f0c4814e
+Subproject commit 6597330c45d185381900037f0130712cd326ae59
-- 
1.8.3.1

