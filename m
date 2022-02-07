Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676954AB5F4
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 08:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbiBGHrU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 02:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbiBGHkP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 02:40:15 -0500
X-Greylist: delayed 1918 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 23:40:14 PST
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70036C043185
        for <bpf@vger.kernel.org>; Sun,  6 Feb 2022 23:40:13 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2175bUJP017304;
        Mon, 7 Feb 2022 07:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ZYDab5FROxSoyR9tlQXDJapTMMqZzHE2FqriDiRNXBE=;
 b=PzTia2k6FLvFgHeB5ISkRENGHOqMzrF1Vk1Jp9u16wjthMUFcvqqdGd37wAANEJ8GdIM
 sc58um2Q1ioQnwQtoUfqVeZehB3JZ/GWB36QE6Flkp+7a/xl0UugE5q/TGQp/mNRP8gh
 796xrtKQRaSXnZA7BMWMOTG1Mc008EpPzvmTuz4Zqpj9byL+HaueLVK9T3nSRE4R8Lbx
 S43TmN2N6a2yurgOv3EzxRWUzizaWv45hqTMQBZ0cpWIzXrt+5H/a/BPno18pstM+E8f
 SaZE/tWanGAT3GQ2G6aAOIUnzVBGtZaHavwUxRH6MCljTHy+U6iyEzKUFPbhcCzxjFfN dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e1hux1fj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 07:07:42 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21775KUs007215;
        Mon, 7 Feb 2022 07:07:41 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e1hux1fhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 07:07:41 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21772oFg000932;
        Mon, 7 Feb 2022 07:07:39 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3e1gv9rqye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 07:07:39 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2176vYdi50200962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Feb 2022 06:57:34 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 730ECA4060;
        Mon,  7 Feb 2022 07:07:36 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB4D0A4054;
        Mon,  7 Feb 2022 07:07:33 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.33.186])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Feb 2022 07:07:33 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     <bpf@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [RFC PATCH 0/3] powerpc64/bpf: Add support for BPF Trampolines
Date:   Mon,  7 Feb 2022 12:37:19 +0530
Message-Id: <cover.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3ruID0kvrUZ8BXvWVxcJoghY5QbjF2gX
X-Proofpoint-GUID: yfIzvwOreqEkqm6Pvu-db1moN4Ez-64z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_02,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=800 spamscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202070046
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is an early RFC series that adds support for BPF Trampolines on 
powerpc64. Some of the selftests are passing for me, but this needs more
testing and I've likely missed a few things as well. A review of the
patches and feedback about the overall approach will be great.

This series depends on some of the other BPF JIT fixes and enhancements
posted previously, as well as on ftrace direct enablement on powerpc
which has also been posted in the past.


- Naveen


Naveen N. Rao (3):
  ftrace: Add ftrace_location_lookup() to lookup address of ftrace
    location
  powerpc/ftrace: Override ftrace_location_lookup() for MPROFILE_KERNEL
  powerpc64/bpf: Add support for bpf trampolines

 arch/powerpc/kernel/kprobes.c      |   8 +-
 arch/powerpc/kernel/trace/ftrace.c |  11 +
 arch/powerpc/net/bpf_jit.h         |   8 +
 arch/powerpc/net/bpf_jit_comp.c    |   5 +-
 arch/powerpc/net/bpf_jit_comp64.c  | 619 ++++++++++++++++++++++++++++-
 include/linux/ftrace.h             |   5 +
 kernel/bpf/trampoline.c            |  27 +-
 kernel/trace/ftrace.c              |  14 +
 8 files changed, 670 insertions(+), 27 deletions(-)


base-commit: 33ecb3e590194051dc57eee1125c1d372b14c946
-- 2.34.1

