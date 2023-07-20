Return-Path: <bpf+bounces-5529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3941875B894
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 22:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7801281FDE
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 20:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A301BE80;
	Thu, 20 Jul 2023 20:15:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612AC1BE75
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 20:15:13 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6A2270B
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 13:15:11 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KFEW1l026282;
	Thu, 20 Jul 2023 20:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=QCkffxjLSXMYlTqiq7Ew1FhsGCO7/rkhkPmQpAd1OBQ=;
 b=2na+YBiRzvnJJOs0z+rWvwximD9yaugObjZSm48fICP6mifiHT58ExWiGzJp7HyX7vQW
 yqPeoVKsrj9pbjjhOjanPmwWNh5P5MhatL5B+C+AbHQQ+1BINDS9ciYdY7nwlE63Vgwy
 tsu+NbDadLBzbDeN+UrYujBCxBLSF536aNcxFj2mhaT+7OhapssvzKYxBtMcVxoxDMOt
 JDZ9xjeP7FF/tM6CH4e9dlGvYjodvBPIBhvszmXkUMcE7vA47Ycia823vtvzSB1lyogi
 HDYvlPABiEzuqZcmRjVrVwaXFqKCUyXWbHCc+26OQlOr1UjOjtBMGDJlKlx8QVXgKOoi sw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8aaq74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 20:14:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KJ3AJc000870;
	Thu, 20 Jul 2023 20:14:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw95ttc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 20:14:48 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36KKEmZW036089;
	Thu, 20 Jul 2023 20:14:48 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-199-137.vpn.oracle.com [10.175.199.137])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ruhw95tr1-1;
	Thu, 20 Jul 2023 20:14:47 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        jolsa@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 0/2] dwarves: detect BTF kinds supported by kernel
Date: Thu, 20 Jul 2023 21:14:41 +0100
Message-Id: <20230720201443.224040-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=719
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200172
X-Proofpoint-GUID: Dx9fiBSP7A89NBjNLCkiLMuNFHPG2e5f
X-Proofpoint-ORIG-GUID: Dx9fiBSP7A89NBjNLCkiLMuNFHPG2e5f
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When a newer pahole is run on an older kernel, it often knows about BTF
kinds that the kernel does not support, and adds them to the BTF
representation.  This is a problem because the BTF generated is then
embedded in the kernel image.  When it is later read - possibly by
a different older toolchain or by the kernel directly - it is not usable.

The scripts/pahole-flags.sh script enumerates the various pahole options
available associated with various versions of pahole, but in the case
of an older kernel is the set of BTF kinds the kernel can handle that
is of more importance.

Because recent features such as BTF_KIND_ENUM64 are added by default
(and only skipped if --skip_encoding_btf_* is set), BTF will be
created with these newer kinds that the older kernel cannot read.
This can be fixed by stable-backporting --skip options, but this is
cumbersome and would have to be done every time a new BTF kind is
introduced.

So this series attempts to detect the BTF kinds supported by the
kernel/modules so that this can inform BTF encoding for older
kernels.  We look for BTF_KIND_MAX - either as an enumerated value
in vmlinux DWARF (patch 1) or as an enumerated value in base vmlinux
BTF (patch 2).

The aim is to minimize overhead on older stable kernels when new BTF
kinds are introduced.  Kind encoding [1] solves the parsing problem
with BTF, but this approach is intended to ensure generated BTF is
usable when newer pahole runs on older kernels.

This approach requires BTF kinds to be defined via an enumerated type,
which happened for 5.16 and later.  Older kernels than this used #defines
so the approach will only work for 5.16 stable kernels and later currently.

[1] https://lore.kernel.org/bpf/20230616171728.530116-1-alan.maguire@oracle.com/

Alan Maguire (2):
  dwarves: auto-detect maximum kind supported by vmlinux
  btf_encoder: learn BTF_KIND_MAX value from base BTF when generating
    split BTF

 btf_encoder.c  | 36 ++++++++++++++++++++++++++++++++++
 btf_encoder.h  |  2 ++
 dwarf_loader.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 dwarves.h      |  2 ++
 pahole.c       |  2 ++
 5 files changed, 94 insertions(+)

-- 
2.39.3


