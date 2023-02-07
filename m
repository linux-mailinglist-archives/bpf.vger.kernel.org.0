Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6CD68DEB6
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 18:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjBGRQZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 12:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjBGRQB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 12:16:01 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264353E0BF
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 09:15:29 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317Gn2Vb024853;
        Tue, 7 Feb 2023 17:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=QVj1N9wQkg1msBdPCItscAdHbUQyTFo8pWGCbl2jKT0=;
 b=1akwGE7cXGbVDuB/HpLfX84rzN8H9M6rzdo6tAZAed5QnYhwCHJw7IQHTmaPA8KWqNBb
 EFi6+8K5k83rBqEnZ8dcLCCVyxYFQtRiQIvw2YzO7W6pPMevT6AU/acnBPm0kP/8kRqY
 kkhSDKBhJLSx1d6vqsphZiGqsvThF5AVAVQyLpUObFFHgnUr4YYl0eupXW/AwfT19uyT
 HueEmuzklJcD/OeySMStUsge9wwm2yjpNp8uykHWr8TxWNsNDoVGXZSNOMJEku7EHTD5
 GQs5wd39335comwcUqewTDHVz6x05oqqQkGkfkWz1n+u2+aV4VHOB1OGsafS556IGvZw 3w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nheytx5h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 17:15:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 317GYMJ1007789;
        Tue, 7 Feb 2023 17:15:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt6e7m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 17:15:07 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 317HF7gM007936;
        Tue, 7 Feb 2023 17:15:07 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-168-65.vpn.oracle.com [10.175.168.65])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3nhdt6e7g6-1;
        Tue, 07 Feb 2023 17:15:06 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 0/8] dwarves: support encoding of optimized-out parameters, removal of inconsistent static functions
Date:   Tue,  7 Feb 2023 17:14:54 +0000
Message-Id: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_09,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070153
X-Proofpoint-GUID: 0xRe9qstIMgjVjnAyBe3AKmIg3HB8LW0
X-Proofpoint-ORIG-GUID: 0xRe9qstIMgjVjnAyBe3AKmIg3HB8LW0
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
such optimizations have occurred.  Patches 1-5 handle the
optimized-out parameter identification and matching "."-suffixed
functions with the original function to facilitate BTF
encoding.  This feature can be enabled via the
"--btf_gen_optimized" option.

Patch 6 addresses a related problem - it is entirely possible
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
51529 to 50246.  Skipping inconsistent functions is enabled
via "--skip_encoding_btf_inconsistent_proto".

Changes since v2 [2]
- Arnaldo incorporated some of the suggestions in the v2 thread;
  these patches are based on those; the relevant changes are
  noted as committer changes.
- Patch 1 is unchanged from v2, but the rest of the patches
  have been updated:
- Patch 2 separates out the changes to the struct btf_encoder
  that better support later addition of functions.
- Patch 3 then is changed insofar as these changes are no
  longer needed for the function addition refactoring.
- Patch 4 has a small change; we need to verify that an
  encoder has actually been added to the encoders list
  prior to removal
- Patch 5 changed significantly; when attempting to measure
  performance the relatively good numbers attained when using
  delayed function addition were not reproducible.
  Further analysis revealed that the large number of lookups
  caused by the presence of the separate function tree was
  a major cause of performance degradation in the multi
  threaded case.  So instead of maintaining a separate tree,
  we use the ELF function list which we already need to look
  up to match ELF -> DWARF function descriptions to store
  the function representation.  This has 2 benefits; firstly
  as mentioned, we already look up the ELF function so no
  additional lookup is required to save the function.
  Secondly, the ELF representation is identical for each
  encoder, so we can index the same function across multiple
  encoder function arrays - this greatly speeds up the
  processing of comparing function representations across
  encoders.  There is still a performance cost in this
  approach however; more details are provided in patch 6.
  An option specific to adding functions with "." suffixes
  is added "--btf_gen_optimized"
- Patch 6 builds on patch 5 in applying the save/merge/add
  approach for all functions using the same mechanisms.
  In addition the "--skip_encoding_btf_inconsistent_proto"
  option is introduced.
- Patches 7/8 document the new options in the pahole manual
  page.
  
Changes since v1 [3]

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

[1] https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
[2] https://lore.kernel.org/bpf/1675088985-20300-1-git-send-email-alan.maguire@oracle.com/
[3] https://lore.kernel.org/bpf/1674567931-26458-1-git-send-email-alan.maguire@oracle.com/

Alan Maguire (8):
  dwarf_loader: Help spotting functions with optimized-out parameters
  btf_encoder: store type_id_off, unspecified type in encoder
  btf_encoder: Refactor function addition into dedicated
    btf_encoder__add_func
  btf_encoder: Rework btf_encoders__*() API to allow traversal of
    encoders
  btf_encoder: Represent "."-suffixed functions (".isra.0") in BTF
  btf_encoder: support delaying function addition to check for function
    prototype inconsistencies
  dwarves: document --btf_gen_optimized option
  dwarves: document --skip_encoding_btf_inconsistent_proto option

 btf_encoder.c      | 360 +++++++++++++++++++++++++++++++++++++--------
 btf_encoder.h      |   6 -
 dwarf_loader.c     | 130 +++++++++++++++-
 dwarves.h          |  11 +-
 man-pages/pahole.1 |  10 ++
 pahole.c           |  30 +++-
 6 files changed, 468 insertions(+), 79 deletions(-)

-- 
2.31.1

