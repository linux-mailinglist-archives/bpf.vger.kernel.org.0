Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E52769E3EF
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 16:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjBUPtb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 10:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjBUPta (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 10:49:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24DE2687B
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 07:49:29 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LDjciF010022;
        Tue, 21 Feb 2023 15:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=h8gLyOKgWOzBbgREtt0FhiS1IKIljZxmgHm2keuXkeE=;
 b=CQM5Sk3YdzBdIz9HRK/ZkyRchJlLNmOpqva1tjIrULqti2FRMxc1zaWCRVwEvf6qLN2F
 WQCLuWZcJmbYiL0+wkH/b/lnCzJkJE7OmqCehzKiendjvVIv4KCAV/0Lb8/sLFozlAMc
 l3KLpGwQJ7of5tb/yw+F233yVpfyLJ5X4m3zfCuRMwgJWR00tP66odG+su6Syl3WI5m+
 y+GOq+PdiJ03GYKGQL0ycGzTxVXnNWoZtcENRyVqc4vBesbH1+Ha83dlGmvMUYL+4CAv
 Y4YEQGMooFmuC65zqmkInQ+LTJK+zbl8hKdhD86UcVvNqmkAHtCYuFilmtGvOGEQ/kvN Kg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpja5fx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 15:48:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LF5Uba040929;
        Tue, 21 Feb 2023 15:48:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn458xty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 15:48:49 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31LFmmpC007236;
        Tue, 21 Feb 2023 15:48:48 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-204-58.vpn.oracle.com [10.175.204.58])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ntn458xqw-1;
        Tue, 21 Feb 2023 15:48:48 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 0/3] dwarves: improvements/fixes to BTF function skip logic
Date:   Tue, 21 Feb 2023 15:48:39 +0000
Message-Id: <1676994522-1557-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302210131
X-Proofpoint-ORIG-GUID: vfWS2wfXnUTwdkctf9efBL4z-Fy7HPqq
X-Proofpoint-GUID: vfWS2wfXnUTwdkctf9efBL4z-Fy7HPqq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As discussed in [1], there are a few issues with how we determine
whether to skip functions for BTF encoding:

- when detecting unexpected registers, functions which have
  struct parameters need to be skipped as they can use
  multiple registers to pass the struct, and as a result
  later parameters use unexpected registers.  However,
  struct detection does not always work; it needs to be fixed for
  const struct parameters and cases where a parameter references
  the original parameter (which has the type info) via abstract
  origin (patch 1)
- when looking for unexpected registers, location lists are not
  supported.  Fix that by using dwarf_getlocations() (patch 2).
- when marking parameters as using unexpected registers, we should
  stick to the case where we expect register x and register y is
  used; other cases such as optimized-out parameters are no
  guarantee that we were not _passed_ the correct parameters
  (patch 3).

This series can be applied on top of the dwarves "next" branch,
as a follow-on to [2]

[1] https://lore.kernel.org/bpf/20230220190335.bk6jzayfqivsh7rv@macbook-pro-6.dhcp.thefacebook.com/
[2] https://lore.kernel.org/bpf/1676675433-10583-1-git-send-email-alan.maguire@oracle.com/

Alan Maguire (3):
  dwarf_loader: fix detection of struct parameters
  dwarf_loader: fix parameter location retrieval for location lists
  dwarf_loader: only mark parameter as using an unexpected register when
    it does

 dwarf_loader.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

-- 
2.31.1

