Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF0669B75D
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 02:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjBRBPu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 20:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBRBPt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 20:15:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE5F2528C
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 17:15:45 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HLiGVA014910;
        Fri, 17 Feb 2023 23:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=4S0jmue+U0pG7RxaYOiN3qEUH7tyl1v3uD9yL0nefl0=;
 b=yScWsqvsB2CRXXn0iOnuvvIUipiEI26pkGR51NHS1ClqApMHcGr9Q8lJyc/IuAnXlA01
 o8Um9gOL+IYAIgegcsYN7ORiaYraiavIbGFgIhz0K4Rxv1O8xpLZDU0Wgm7BIRlHSJ/A
 QNMvgoQJzyZBdiRsIITBse7+bcdS4DDFhHpdOJ64TcF/2APg0xLw+tT3cCklBpXSxZCW
 Wy1NknAXi3osG4NbBECqljSwWvvPGfYTSzIXohvrUzG/NQpGznaXQGAiIlfVJ49xNGhE
 CA3BPCL5q8+hiFiK6j8kTzeeI4HmC3QZ3YIUshau5PxSVo922m/kuL6op36riAJGS5Up SQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1xbf67y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 23:10:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HKjQsc015285;
        Fri, 17 Feb 2023 23:10:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fas7rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 23:10:39 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31HNAcmK007180;
        Fri, 17 Feb 2023 23:10:39 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-171-27.vpn.oracle.com [10.175.171.27])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3np1fas7py-1;
        Fri, 17 Feb 2023 23:10:38 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org, olsajiri@gmail.com, ast@kernel.org
Cc:     daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        eddyz87@gmail.com, sinquersw@gmail.com, timo@incline.eu,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 0/4] dwarves: change BTF encoding skip logic for functions
Date:   Fri, 17 Feb 2023 23:10:29 +0000
Message-Id: <1676675433-10583-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_15,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170202
X-Proofpoint-ORIG-GUID: TRabWfPaRpC2AMEzJ3-3pRQw-YQUTBr-
X-Proofpoint-GUID: TRabWfPaRpC2AMEzJ3-3pRQw-YQUTBr-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It has been observed [1] that the recent dwarves changes
that skip BTF encoding for functions that have optimized-out
parameters are too aggressive, leading to missing kfuncs
which generate warnings and a BPF selftest failure.

Here a different approach is used; we observe that
just because a function does not _use_ a parameter,
it does not mean it was not passed to it.  What we
are really keen to detect are cases where the calling
conventions are violated such that a function will
not have parameter values in the expected registers.
In such cases, tracing and kfunc behaviour will be
unstable.  We are not worried about parameters being
optimized out, provided that optimization does not
lead to other parameters being passed via
unexpected registers.

So this series attempts to detect such cases by
examining register (DW_OP_regX) values for
parameters where available; if these match
expectations, the function is deemed safe to add to
BTF, even if parameters are optimized out.

Using this approach, the only functions that
BTF generation is suppressed for are

1. those with parameters that violate calling
   conventions where present; and
2. those which have multiple inconsistent prototypes.

With these changes, running pahole on a gcc-built
vmlinux skips

- 1164 functions due to multiple inconsistent function
  prototypes.  Most of these are "."-suffixed optimized
  fuctions.
- 331 functions due to unexpected register usage

For a clang-built kernel, the numbers are

- 539 functions with inconsistent prototypes are skipped
- 209 functions with unexpected register usage are skipped

One complication is that functions that are passed
structs (or typedef structs) can use multiple registers
to pass those structures.  Examples include
bpf_lsm_socket_getpeersec_stream() (passing a typedef
struct sockptr_t) and the bpf_testmod_test_struct_arg_1
function in bpf_testmod.  Because multiple registers
are used to represent the structure, this throws
off expectations for any subsequent parameter->register
mappings.  To handle this, simply exempt functions
that have struct (or typedef struct) parameters from
our register checks.

Note to test this series on bpf-next, the following
commit should be reverted (reverting the revert
so that the flags are added to BTF encoding when
using pahole v1.25):

commit 1f5dfcc78ab4 ("Revert "bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25"")

With these changes we also see tracing_struct now pass:

$ sudo ./test_progs -t tracing_struct
#233     tracing_struct:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Further testing is needed - along with support for additional
parameter index -> DWARF reg for more platforms.

Future work could also add annotations for optimized-out
parameters via BTF tags to help guide tracing.

[1] https://lore.kernel.org/bpf/CAADnVQ+hfQ9LEmEFXneB7hm17NvRniXSShrHLaM-1BrguLjLQw@mail.gmail.com/

Alan Maguire (4):
  dwarf_loader: mark functions that do not use expected registers for
    params
  btf_encoder: exclude functions with unexpected param register use not
    optimizations
  pahole: update descriptions for btf_gen_optimized,
    skip_encoding_btf_inconsistent_proto
  pahole: update man page for options also

 btf_encoder.c      |  24 +++++++---
 dwarf_loader.c     | 109 ++++++++++++++++++++++++++++++++++++++++++---
 dwarves.h          |   5 +++
 man-pages/pahole.1 |   4 +-
 pahole.c           |   4 +-
 5 files changed, 129 insertions(+), 17 deletions(-)

-- 
2.31.1

