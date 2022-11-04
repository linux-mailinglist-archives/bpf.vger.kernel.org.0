Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2177A619C54
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 16:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiKDP6z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 11:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiKDP6t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 11:58:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08562317E5
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 08:58:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4FLQ9m029129;
        Fri, 4 Nov 2022 15:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=Tzg+y8Arecy5oC9mI8NldI4hde2ymkPOfE0y3a/hA8Q=;
 b=1E5BEdmr8YKlAHrero9HCVEaZFcsSyCBVjA9nqcGH4Ct5/VSkEAiaBIRUDGLUCHu8QNU
 tu1iHLaD5NHqrEs7fbJMzBjB2rfJ0CTVDgikuVZuIPMQqNUb0aM64wW6Qt6WneBDCQAf
 QC4UhC2k1nBJ0zWXbDcxc7A1MN29Xx4F0W4RxmsKGym2PgXvg79tHpSuRH/dPxllM0Vq
 WWDKtPagBE0atk+rYOB1hxOCEarjOQzOGFQHEF9htKj5o6fJwDc2lZfToRxSoWVDUmcW
 1YETafngYHBGqhqGFovSQXHH3fkjjJrUK4kcNj/IfgdY3mkNJgKa4u2DMT25Hhft7wqi Pw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgv2ar3p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 15:58:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4EfwRT023006;
        Fri, 4 Nov 2022 15:58:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kmpwnpeay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 15:58:19 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A4FwITi025431;
        Fri, 4 Nov 2022 15:58:18 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-178-135.vpn.oracle.com [10.175.178.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kmpwnpe7w-1;
        Fri, 04 Nov 2022 15:58:18 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     andrii@kernel.org, ast@kernel.org, martin.lau@linux.dev,
        daniel@iogearbox.net
Cc:     song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 0/2] bpf: standalone BTF support for modules
Date:   Fri,  4 Nov 2022 15:58:05 +0000
Message-Id: <1667577487-9162-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=674 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040104
X-Proofpoint-ORIG-GUID: Bjw69RpDh9vVYHtgOX7FqGNU9P6X715P
X-Proofpoint-GUID: Bjw69RpDh9vVYHtgOX7FqGNU9P6X715P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Split BPF Type Format (BTF) information for modules provides a
major space saving, but if a module is built less frequently
than the underlying kernel which it bases its BTF upon, the
associated references become invalid and either the module
will fail to load (CONFIG_BTF_ALLOW_MODULE_MISMATCH=n) or
it will load without BTF available in /sys/kernel/btf
(CONFIG_BTF_ALLOW_MODULE_MISMATCH=y).  This problem was
first raised in [1], so there is more discussion there.

This series represents a simple proof-of-concept for handling
standalone BTF - where the BTF for the module is not
generated relative to base vmlinux BTF.  The core problem
with this is that all the tooling presumes split BTF for
modules, so on module BTF load, we rework the BTF to appear
as split BTF.  It does not change in form - it still is
only self-referential - but is compatible with split BTF
interpretation.

Building a module with standalone BTF is done via

 make BTF_BASE= M=path/2/module

The detection of standalone BTF on module load is likely much
too simplistic - we simply fall back to assuming standalone
BTF if the BTF associated with the module appears to be invalid.
However this approach seems to work well in practice.

Tests etc are needed but wanted to get the proof-of-concept
out for others to provide feedback early.

[1] https://lore.kernel.org/bpf/YfK18x%2FXrYL4Vw8o@syu-laptop/

Alan Maguire (2):
  bpf: support standalone BTF in modules
  bpf: allow opt-out from using split BTF for modules

 kernel/bpf/btf.c          | 132 ++++++++++++++++++++++++++++++++++++++++++++++
 scripts/Makefile.modfinal |   4 +-
 2 files changed, 135 insertions(+), 1 deletion(-)

-- 
1.8.3.1

