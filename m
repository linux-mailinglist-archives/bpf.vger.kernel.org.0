Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAE5679E21
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 17:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjAXQBX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 11:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjAXQBW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 11:01:22 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80BD6593
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 08:01:21 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ODI0vT002753;
        Tue, 24 Jan 2023 13:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=gLdns4UREkod8woqBJzvjA41jZKQBiHxJ02pdsQWhmk=;
 b=LqyOC/fgHty8wKwhluikGzbZCz+medHLFiJmvKdCbtq66J2k109BfK/PwKv6NJ44o9xs
 H8/ECw+butNMK1mRoEvyiChn2vaPmDTJe0hWI7FsF75Dk70T1HbITBoN4FHUt2mjw+jI
 rnGLxs1dzacr6Vo01wwGiLU17AN+8vNCiK6K7+qYXOWimxvrLIIm6EBWolgA8wB03dvR
 v23z0mMy3y88Tln7W574UmuBKoWiGpI2HNP8x1E7UtQTb04MjlM2AwKtYGGGCunwTyiA
 HESiHNJDozJONfVLFrcaU+IgCRk+uQQ7ulsm0p7yezuM4e68XOO84q+7ZrFEXAPH1s/5 Dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n883c5bua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 13:45:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30OBmnFv021016;
        Tue, 24 Jan 2023 13:45:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86gbr5h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 13:45:36 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30ODjZ3p037951;
        Tue, 24 Jan 2023 13:45:35 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-161-98.vpn.oracle.com [10.175.161.98])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3n86gbr5fj-1;
        Tue, 24 Jan 2023 13:45:35 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org, yhs@fb.com, ast@kernel.org, olsajiri@gmail.com,
        timo@incline.eu
Cc:     daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 0/5] dwarves: support encoding of optimized-out parameters, removal of inconsistent static functions
Date:   Tue, 24 Jan 2023 13:45:26 +0000
Message-Id: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301240125
X-Proofpoint-ORIG-GUID: sRMDQOS05guglMfjH2UMgl0fO7zd2-f3
X-Proofpoint-GUID: sRMDQOS05guglMfjH2UMgl0fO7zd2-f3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

At optimization level -O2 or higher in gcc, static functions may be
optimized such that they have suffixes like .isra.0, .constprop.0 etc.
These represent

- constant propagation (.constprop.0);
- interprocedural scalar replacement of aggregates, removal of
  unused parameters and replacement of parameters passed by
  reference by parameters passed by value (.isra.0)

See [1] for details.

Currently BTF encoding does not handle such optimized functions
that get renamed with a "." suffix such as ".isra.0", ".constprop.0".
This is safer because such suffixes can often indicate parameters have
been optimized out.  This series addresses this by matching a
function to a suffixed version ("foo" matching "foo.isra.0") while
ensuring that the function signature does not contain optimized-out
parameters.  Note that if the function is found ("foo") it will
be preferred, only falling back to "foo.isra.0" if lookup of the
function fails.  Addition to BTF is skipped if the function has
optimized-out parameters, since the expected function signature
will not match. BTF encoding does not include the "."-suffix to
be consistent with DWARF. In addition, the kernel currently does
not allow a "." suffix in a BTF function name.

A problem with this approach however is that BTF carries out the
encoding process in parallel across multiple CUs, and sometimes
a function has optimized-out parameters in one CU but not others;
we see this for NF_HOOK.constprop.0 for example.  So in order to
determine if the function has optimized-out parameters in any
CU, its addition is not carried out until we have processed all
CUs and are about to merge BTF.  At this point we know if any
such optimizations have occurred.  Patches 1-4 handle the
optimized-out parameter identification and matching "."-suffixed
functions with the original function to facilitate BTF
encoding.

Patch 5 addresses a related problem - it is entirely possible
for a static function of the same name to exist in different
CUs with different function signatures.  Because BTF does not
currently encode any information that would help disambiguate
which BTF function specification matches which static function
(in the case of multiple different function signatures), it is
best to eliminate such functions from BTF for now.  The same
mechanism that is used to compare static "."-suffixed functions
is re-used for the static function comparison.  A superficial
comparison of number of parameters/parameter names is done to
see if such representations are consistent, and if inconsistent
prototypes are observed, the function is flagged for exclusion
from BTF.

When these methods are combined - the additive encoding of
"."-suffixed functions and the subtractive elimination of
functions with inconsistent parameters - we see a small overall
increase in the number of functions in vmlinux BTF, from
49538 to 50083.  It turns out that the inconsistent prototype
checking will actually eliminate some of the suffix matches
also, for cases where the DWARF representation of a function
differs across CUs, but not via the abstract origin late DWARF
references showing optimized-out parameters that we check
for in patch 1.

[1] https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html

Alan Maguire (5):
  dwarves: help dwarf loader spot functions with optimized-out
    parameters
  btf_encoder: refactor function addition into dedicated
    btf_encoder__add_func
  btf_encoder: child encoders should have a reference to parent encoder
  btf_encoder: represent "."-suffixed optimized functions (".isra.0") in
    BTF
  btf_encoder: skip BTF encoding of static functions with inconsistent
    prototypes

 btf_encoder.c  | 357 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 btf_encoder.h  |   2 +-
 dwarf_loader.c |  76 +++++++++++-
 dwarves.h      |   5 +-
 pahole.c       |   7 +-
 5 files changed, 390 insertions(+), 57 deletions(-)

-- 
1.8.3.1

