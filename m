Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3F54AE689
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 03:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbiBICjY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 21:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244877AbiBICS2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 21:18:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B545C06157B
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 18:18:28 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218N8HPA007659;
        Wed, 9 Feb 2022 02:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=G36e1GlUMz4HnXJrrtI8RoYJZ5RNWsX9SXL7AOEIuVY=;
 b=lb+ow+ZubMLt+1kl3nNEIQSyC59p9i8r4ZAT4lKWMZrbNLmBwy3oPUkry6VGupDEoAvl
 MYDEWGRJ92pHMA+vP8yIgTNOMm+UssBbBg2E25rWaVCVPq/bYRYZBLQASZYbFX5c3dOM
 aaoaZXR+DQOssbHqar9WFwYHyDsYMtaThOR4wsDe4d1FScDOYz+is+s4Fmz8qnMu7POx
 SxWSlhCLUSfKvXElCfSn5MUDzfW1ueS12P/WXFYWf0MpjhGkv/np7DtLaQK+hF9ebH1v
 kISfCEwfAMrt7OBXY1lf4z1sby+oGutNsJcteokdSGkGXPylx5UVIkRJJa/aY9Y1SuIn lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3ny8xyve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 02:17:53 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2192C0mx024342;
        Wed, 9 Feb 2022 02:17:53 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3ny8xyut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 02:17:53 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2192DCXH003158;
        Wed, 9 Feb 2022 02:17:51 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3e1gv9h609-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 02:17:50 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2192Hlcu18612560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Feb 2022 02:17:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AF32A4060;
        Wed,  9 Feb 2022 02:17:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D19B9A4054;
        Wed,  9 Feb 2022 02:17:46 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Feb 2022 02:17:46 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v5 00/10] Fix accessing syscall arguments
Date:   Wed,  9 Feb 2022 03:17:35 +0100
Message-Id: <20220209021745.2215452-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5MVaKDPc_iGPc4BSLsBGktceAm3TLgln
X-Proofpoint-ORIG-GUID: 14YHf-E0jjEgrtDvbdeaAY6BpT6LQxf4
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_08,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090014
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf now has macros to access syscall arguments in an
architecture-agnostic manner, but unfortunately they have a number of
issues on non-Intel arches, which this series aims to fix.

v1: https://lore.kernel.org/bpf/20220201234200.1836443-1-iii@linux.ibm.com/
v1 -> v2:
* Put orig_gpr2 in place of args[1] on s390 (Vasily).
* Fix arm64, powerpc and riscv (Heiko).

v2: https://lore.kernel.org/bpf/20220204041955.1958263-1-iii@linux.ibm.com/
v2 -> v3:
* Undo args[1] change (Andrii).
* Rename PT_REGS_SYSCALL to PT_REGS_SYSCALL_REGS (Andrii).
* Split the riscv patch (Andrii).

v3: https://lore.kernel.org/bpf/20220204145018.1983773-1-iii@linux.ibm.com/
v3 -> v4:
* Undo arm64's and s390's user_pt_regs changes.
* Use struct pt_regs when vmlinux.h is available (Andrii).
* Use offsetofend for accessing orig_gpr2 and orig_x0 (Andrii).
* Move libbpf's copy of offsetofend to a new header.
* Fix riscv's __PT_FP_REG.
* Use PT_REGS_SYSCALL_REGS in test_probe_user.c.
* Test bpf_syscall_macro with userspace headers.
* Use Naveen's suggestions and code in patches 5 and 6.
* Add warnings to arm64's and s390's ptrace.h (Andrii).

v4: https://lore.kernel.org/bpf/20220208051635.2160304-1-iii@linux.ibm.com/
v4 -> v5:
* Go back to v3.
* Do not touch arch headers.
* Use CO-RE struct flavors to access orig_x0 and orig_gpr2.
* Fail compilation if non-CO-RE macros are used to access the first
  syscall parameter on arm64 and s390.
* Fix accessing frame pointer on riscv.

Ilya Leoshkevich (10):
  selftests/bpf: Fix an endianness issue in bpf_syscall_macro test
  libbpf: Add PT_REGS_SYSCALL_REGS macro
  selftests/bpf: Use PT_REGS_SYSCALL_REGS in bpf_syscall_macro
  libbpf: Fix accessing syscall arguments on powerpc
  libbpf: Fix riscv register names
  libbpf: Fix accessing syscall arguments on riscv
  selftests/bpf: Skip test_bpf_syscall_macro:syscall_arg1 on arm64 and
    s390
  libbpf: Allow overriding PT_REGS_PARM1{_CORE}_SYSCALL
  libbpf: Fix accessing the first syscall argument on arm64
  libbpf: Fix accessing the first syscall argument on s390

 tools/lib/bpf/bpf_tracing.h                   | 42 ++++++++++++++++++-
 .../bpf/prog_tests/test_bpf_syscall_macro.c   |  4 ++
 .../selftests/bpf/progs/bpf_syscall_macro.c   |  9 +++-
 3 files changed, 51 insertions(+), 4 deletions(-)

-- 
2.34.1

