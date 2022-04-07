Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37B34F8905
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 00:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiDGVql (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 17:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiDGVqk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 17:46:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D52B8A6EA
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 14:44:38 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237Kh7Ya006494;
        Thu, 7 Apr 2022 21:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=wz1wzAGXfkQxw4sG6H0wUQiSSwvo4QOyCqfBnEfYoWo=;
 b=WmtaNmJ8NRfPu2krkFxGptcQDICuucvDIAKMNIZA+y+LMpd5TYYe/MwwimGyZaMEwCoj
 glUa3oKkbryjvtWAbQezx63AH8WelPf9ztp9ihDEYhGN/duRdMHSpp/TYmu7MzzbiiV/
 1xaZU06Y70i6gkBpBaJcA/iUc/prJGVgMfI8oGBo9gLoOjipHOo2KiHWn9OwH1MyAoy8
 0oOLjLH4LcC/N4H1jKSA4VQaHXj92hnGBZ2QY2oMU63h4YBhcZV+/WKGb+0EkVIHwnSL
 1E9fpZ96+OvILBqcoTeAVCrWKrFKHpYqFffpmpboSGWwEjK4dVhBY6XwISa3L6dMQzkr sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fa44wncyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 21:44:19 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 237LF3D1031587;
        Thu, 7 Apr 2022 21:44:19 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fa44wncye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 21:44:18 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 237Lc6Mq008276;
        Thu, 7 Apr 2022 21:44:17 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3f6e492k5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 21:44:17 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 237LiLZg47448480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Apr 2022 21:44:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CFB54C040;
        Thu,  7 Apr 2022 21:44:13 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB80F4C044;
        Thu,  7 Apr 2022 21:44:12 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.171.82.41])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Apr 2022 21:44:12 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 0/3] Add USDT support for s390
Date:   Thu,  7 Apr 2022 23:44:08 +0200
Message-Id: <20220407214411.257260-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fW1AphVYXtPPytuBaXnLeh6zWh2VW2-r
X-Proofpoint-ORIG-GUID: u0W1jih9iFMUt8ECfLoDd-Hqob0tWYXY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_05,2022-04-07_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=946
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds USDT support for s390, making the "usdt" test pass
there. Patch 1 is a collection of minor cleanups, patch 2 adds
BPF-side support, patch 3 adds userspace-side support.

Ilya Leoshkevich (3):
  libbpf: Minor style improvements in USDT code
  libbpf: Make BPF-side of USDT support work on big-endian machines
  libbpf: Add s390-specific USDT arg spec parsing logic

 tools/lib/bpf/usdt.bpf.h |  7 ++--
 tools/lib/bpf/usdt.c     | 69 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 68 insertions(+), 8 deletions(-)

-- 
2.35.1

