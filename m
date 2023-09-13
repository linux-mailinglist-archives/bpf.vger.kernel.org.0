Return-Path: <bpf+bounces-9915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D828579EB0C
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 16:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFE92819F7
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 14:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A701F186;
	Wed, 13 Sep 2023 14:27:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F79C1A713
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 14:27:23 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C629C91
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 07:27:22 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DBmVw5005599;
	Wed, 13 Sep 2023 14:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=yMCb7FEvvY+PNR9uhCksPnCjEPStfr+w8WzbFup9AME=;
 b=0h/lnIf9h6TlJ5s8x1uG8Vpks80s2ujUmHS7Ir+BCvywoco3thFgu7lYbDHJZlUsJv8m
 iAu//McUiQts7EjzENnOqG/erLBsgXChEbCukuYemTguaApRvrJrWtocwgw81e19YSq+
 RlvCqkZ+gf8DOUgJ8O4Dt+U/dWz6yJife6spdEB/tkqgbvid2NuYsBlmPAeNykd+HQcX
 aGk/+fKIpX2f1jJE73UnWyf/LDbZC/x35S2gNRzT0Q34KLAN5yovpC3ybbX267DCfNpa
 8F+I4YgylgjgOik6aGum0zZCT3ao+TJjDNpsc893D2cVfwXxsj+wm309M/hpSNNhbSWT cQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y9kt57d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Sep 2023 14:26:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DD7j7a014638;
	Wed, 13 Sep 2023 14:26:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5dkhg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Sep 2023 14:26:52 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38DENxAI005305;
	Wed, 13 Sep 2023 14:26:51 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-188-149.vpn.oracle.com [10.175.188.149])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3t0f5dkhdj-1;
	Wed, 13 Sep 2023 14:26:51 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        jolsa@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com, mykolal@fb.com,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 0/3] dwarves: detect BTF kinds supported by kernel
Date: Wed, 13 Sep 2023 15:26:43 +0100
Message-Id: <20230913142646.190047-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_08,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=986 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130118
X-Proofpoint-GUID: ebq5goK8LeQwTcAwVl8Yk9IvjTHdBW2R
X-Proofpoint-ORIG-GUID: ebq5goK8LeQwTcAwVl8Yk9IvjTHdBW2R

When a newer pahole is run on an older kernel, it often knows about BTF
kinds that the kernel does not support, and adds them to the BTF
representation.  This is a problem because the BTF generated is then
embedded in the kernel image.  When it is later read - possibly by
a different older toolchain or by the kernel directly - it is not usable.

The scripts/pahole-flags.sh script enumerates the various pahole options
available associated with various versions of pahole, but in the case
of an older kernel is the set of BTF kinds the _kernel_ can handle that
is of more importance.

Because recent features such as BTF_KIND_ENUM64 are added by default
(and only skipped if --skip_encoding_btf_* is set), BTF will be
created with these newer kinds that the older kernel cannot read.
This can be (and has been) fixed by stable-backporting --skip options,
but this is cumbersome and would have to be done every time a new BTF kind
is introduced.

So this series attempts to detect the BTF kinds supported by the
kernel/modules so that this can inform BTF encoding for older
kernels.  We look for BTF_KIND_MAX - either as an enumerated value
in vmlinux DWARF (patch 1) or as an enumerated value in base vmlinux
BTF (patch 3).  Knowing this prior to encoding BTF allows us to specify
skip_encoding options to avoid having BTF with kinds the kernel itself
will not understand.

The aim is to minimize pain for older stable kernels when new BTF
kinds are introduced.  Kind encoding [1] can solve the parsing problem
with BTF, but this approach is intended to ensure generated BTF is
usable when newer pahole runs on older kernels.

This approach requires BTF kinds to be defined via an enumerated type,
which happened for 5.16 and later.  Older kernels than this used #defines
so the approach will only work for 5.16 stable kernels and later currently.

With this change in hand, adding new BTF kinds becomes a bit simpler,
at least for the user of pahole.  All that needs to be done is to add
internal "skip_new_kind" booleans to struct conf_load and set them
in dwarves__set_btf_kind_max() if the detected maximum kind is less
than the kind in question - in other words, if the kernel does not know
about that kind.  In that case, we will not use it in encoding.

The approach was tested on Linux 5.16 as released, i.e. prior to the
backports adding --skip_encoding logic, and the BTF generated did not
contain kinds > BTF_KIND_MAX for the kernel (corresponding to
BTF_KIND_DECL_TAG in that case).

Changes since RFC [2]:
 - added --skip_autodetect_btf_kind_max to disable kind autodetection
   (Jiri, patch 2)

[1] https://lore.kernel.org/bpf/20230616171728.530116-1-alan.maguire@oracle.com/
[2] https://lore.kernel.org/bpf/20230720201443.224040-1-alan.maguire@oracle.com/

Alan Maguire (3):
  dwarves: auto-detect maximum kind supported by vmlinux
  pahole: add --skip_autodetect_btf_kind_max to disable kind autodetect
  btf_encoder: learn BTF_KIND_MAX value from base BTF when generating
    split BTF

 btf_encoder.c      | 37 +++++++++++++++++++++++++++++++++
 btf_encoder.h      |  2 ++
 dwarf_loader.c     | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 dwarves.h          |  3 +++
 man-pages/pahole.1 |  4 ++++
 pahole.c           | 10 +++++++++
 6 files changed, 108 insertions(+)

-- 
2.39.3


