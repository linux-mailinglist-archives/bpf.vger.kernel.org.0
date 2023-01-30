Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF0968134A
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 15:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbjA3OcP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 09:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237611AbjA3Ob6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 09:31:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E071AF
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 06:30:23 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UASt3l009421;
        Mon, 30 Jan 2023 14:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=JMJF8ub/wkAFZIrPs/LjPtvvMQMkNicgrQRBj3xEHoM=;
 b=269IkWkegvBRqvFrZclcpyNWPI93ysfOQ4NTRc1OUs6VPsVNx5w/OOzALwk706jgtoYr
 5ENqCnR4Gc49YCchGPdeLLPZ80FxkVEFuZcYlsBBhGpoqrD0Fp+LvcSFS0HOXAoa3hp7
 Dw4++2VdHEYvsMGXbaMxGY+161JY7wqqwWc8OeSYRHU+vEWDO4F4mI5Xyy3ivKZ1zAz7
 zHvzm6r+UsBh/5IxKcgtRiDop+Kwre0SJWDzW0f3ydWH5PNs3eYCfzkj25gyDr27W8Wt
 hsnBjZwRpN/+F1smriDGloDsDzebk9hX7jyf24ouecWKvUYTaMRzVW6Mg74ib0WGj0Qv vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvn9tysj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 14:29:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30UDxHdf000723;
        Mon, 30 Jan 2023 14:29:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5462nr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 14:29:54 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30UETrIp020648;
        Mon, 30 Jan 2023 14:29:53 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-214-73.vpn.oracle.com [10.175.214.73])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nct5462kh-1;
        Mon, 30 Jan 2023 14:29:53 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org, yhs@fb.com, ast@kernel.org, olsajiri@gmail.com,
        eddyz87@gmail.com, sinquersw@gmail.com, timo@incline.eu
Cc:     daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 0/5] dwarves: support encoding of optimized-out parameters, removal of inconsistent static functions
Date:   Mon, 30 Jan 2023 14:29:40 +0000
Message-Id: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_13,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300140
X-Proofpoint-GUID: UhlwCWLKh11KW-BOBA4uUTP-JavFay13
X-Proofpoint-ORIG-GUID: UhlwCWLKh11KW-BOBA4uUTP-JavFay13
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
functions with inconsistent parameters - we see an overall
drop in the number of functions in vmlinux BTF, from
51150 to 49871.

Changes since v1 [2]

- Eduard noted that a DW_AT_const_value attribute can signal
  an optimized-out parameter, and that the lack of a location
  attribute signals optimization; ensure we handle those cases
  also (Eduard, patch 1).
- Jiri noted we can have inconsistencies between a static
  and non-static function; apply the comparison process to
  all functions (Jiri, patch 5)
- segmentation fault was observed when handling functions with
  > 10 parameters; needed parameter comparison loop to exit
  at BTF_ENCODER_MAX_PARAMETERS (patch 5)
- Kui-Feng Lee pointed out that having a global shared function
  tree would lead to a lot of contention; here a per-encoder 
  tree is used, and once the threads are collected the trees
  are merged. Performance numbers are provided in patch 5 
  (Kui-Feng Lee, patches 4/5)

Alan Maguire (5):
  dwarves: help dwarf loader spot functions with optimized-out
    parameters
  btf_encoder: refactor function addition into dedicated
    btf_encoder__add_func
  btf_encoder: rework btf_encoders__*() API to allow traversal of
    encoders
  btf_encoder: represent "."-suffixed functions (".isra.0") in BTF
  btf_encoder: delay function addition to check for function prototype
    inconsistencies

 btf_encoder.c  | 392 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 btf_encoder.h  |   6 -
 dwarf_loader.c | 125 ++++++++++++++++--
 dwarves.h      |   8 +-
 pahole.c       |  14 +--
 5 files changed, 464 insertions(+), 81 deletions(-)

-- 
1.8.3.1

