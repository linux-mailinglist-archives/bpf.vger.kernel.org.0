Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E838C636778
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 18:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbiKWRmj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 12:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbiKWRmh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 12:42:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5AA7658
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 09:42:34 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANGsDrf025969;
        Wed, 23 Nov 2022 17:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=ISnMpz4GDnj59HDrjsrUxq0VTXXinPKeR8agIqnK8Q8=;
 b=Z3G/1aCLG4ubI+dBVR7XK5W8l1itg6NaDptu0s7ydjyQ2oP2Inhe0SL9Yd1TPrHHFyYA
 hKCFkEqkiQBZovTn1F+aOllqqKlG3tAyV/97Ecoa/Hz1HTEFu0fQ9r2hADuHzHQ6GjOq
 yOMeO+Q8zP82QjhaJWq3G7FI8n6DzcRs9AOWfmmQ/+2hnGR8Ksxv+h5rpjks9LoUXeEJ
 sk0TK/F07aBNNZ1iieZngVQa6A+N2BAzKDb+N+879IOjMMUtYCDDSwKFBbskLi7Fq/PT
 EBwBRWefd1KKhTkWnlLrXBFQDz5ZqbzP7RXheW+/8WxPDxpj2wkCCNthgpSXkTNKdWSy ng== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxrfb47av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 17:42:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ANH1ZFO015688;
        Wed, 23 Nov 2022 17:41:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk74a77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 17:41:57 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ANHfvqA028233;
        Wed, 23 Nov 2022 17:41:57 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-201-76.vpn.oracle.com [10.175.201.76])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kxnk74a4g-1;
        Wed, 23 Nov 2022 17:41:57 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        haiyue.wang@intel.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 0/5] bpf: making BTF self-describing
Date:   Wed, 23 Nov 2022 17:41:47 +0000
Message-Id: <1669225312-28949-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_10,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211230130
X-Proofpoint-GUID: qsFhyVs6TP-RRaDdwYx0wcMMEVTy8bIw
X-Proofpoint-ORIG-GUID: qsFhyVs6TP-RRaDdwYx0wcMMEVTy8bIw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

One problem with the BPF Type Format (BTF) is that it is hard
to extend.  BTF consists of a set of kinds, each representing
an aspect of type or variable information such as an integer,
struct, array and so on.  The problem is that at the time BTF
is encoded, we do not provide information about the kinds we
have used, so when the encoded BTF is later parsed, the tools
that parse it must know about all the kinds used at encoding
time in order to parse the BTF.  If an unknown kind is found,
we have no way of knowing what size it is, so have to give
up parsing since we cannot skip past it due to the unknown
size.

So if BTF is created with a newer toolchain which has a new
kind in it, but later parsed with an older toolchain, it
is unparseable.  Ideally we would like such BTF to be
capable of parsing, so we need a mechanism to encode info
about the kinds used at encoding time that is then easily
accessible to parsing operations.  The alternative is
the current situation, where encoding has to be pessimistic
and we have to skip various kind encodings to avoid parsing
failures.

Here we propose a scheme to encode kind information such
that parsing can proceed.  The following steps are
involved:

1. a libbpf function is introduced btf__add_kinds() which
   adds kind information
2. that kind information is encoded in BTF as a set of
   structures representing the kind encodings
3. tools will call btf__add_kinds() at BTF encoding time
   to add this kind encoding information
4. at parsing time, if an unrecognized kind is found, the
   kind encoding is used to determine the size of the
   kind representation and parsing proceeds

Steps 1 and 2 are accomplished in patches 1 and 2.
Patches 3 and 4 tackle step 4 for userspace and kernel.
Finally patch 5 tests BTF kind encoding and decoding.

To support BTF kind encoding for kernel BTF, pahole
would have to be updated to call btf__add_kinds(). 
[1] and [2] can be used to try this out.

More details are provided in the individual patches.

One potential application of this approach would be a
stable backport of patches 1 and 3; this would allow
older kernels to use latest pahole without adding
additional "skip" directives when new kinds are
added.

So assuming something like this landed, how would it
effect adding a new kind?  Once that kind was available
in the libbpf that dwarves uses, it would mean that
BTF would contain instances of that new kind.  However
if an older libbpf (that had support for parsing kind
descriptions) encountered it, parsing would still work;
the new information encoded would not be available
however.

So the result would be that a new kind would be able
to be added without breaking BTF parsing.

[1] https://github.com/alan-maguire/dwarves/tree/btf-kind-encoding
[2] https://github.com/alan-maguire/libbpf/tree/btf-kind-encoding

Alan Maguire (5):
  bpf: add kind/metadata prefixes to uapi/linux/btf.h
  libbpf: provide libbpf API to encode BTF kind information
  libbpf: use BTF-encoded kind information to help parse unrecognized
    kinds
  bpf: parse unrecognized kind info using encoded kind information (if
    present)
  selftests/bpf: test kind encoding/decoding

 include/uapi/linux/btf.h                          |   7 +
 kernel/bpf/btf.c                                  |  87 +++++-
 tools/include/uapi/linux/btf.h                    |   7 +
 tools/lib/bpf/btf.c                               | 357 ++++++++++++++++++++++
 tools/lib/bpf/btf.h                               |  10 +
 tools/lib/bpf/libbpf.map                          |   1 +
 tools/testing/selftests/bpf/prog_tests/btf_kind.c | 234 ++++++++++++++
 7 files changed, 696 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

-- 
1.8.3.1

