Return-Path: <bpf+bounces-2734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B34773374A
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 19:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AF628178C
	for <lists+bpf@lfdr.de>; Fri, 16 Jun 2023 17:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5091ACDE;
	Fri, 16 Jun 2023 17:17:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F80182D2
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 17:17:57 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E401FF7
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 10:17:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GCiFkw021230;
	Fri, 16 Jun 2023 17:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=ofksVGtv1YHDpdh9zF1bPvRuuhG9PZdQ6tK4/97CyF4=;
 b=Dq0q2G/meaw0007q84gFpXn2+nvecb2j6JWBNUTF+Ycr4NKkkeALtf3f8Aq+YsPilwdB
 P8xVZqneIG/Dm9eycqgQSnetUP9Q20UPKr49DWHcq3UO27p2cDXef+RCZvpgGdIZzm3D
 Ow1DH7MemTXHmpwcs49J4X5FDeW93DzAgKyBkOLwkZocSwlIa659RulDVgG/qnaM/dDZ
 DBETQgW6fUtL2Kpzla7Rq7zcj6Xc6LJy9MNENY57f0MC3McToH9Q8+zEJlscxhXR3amu
 VSS0zkpqO2sogu1Seaza8jN3F/Ljz+3iirUveKQDHNnPfUzbtf1ogS1ReU6V4eNcx9Kg rA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdvh1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jun 2023 17:17:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35GGFIX0012436;
	Fri, 16 Jun 2023 17:17:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmert6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jun 2023 17:17:33 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35GHGqPW007608;
	Fri, 16 Jun 2023 17:17:32 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-209-206.vpn.oracle.com [10.175.209.206])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3r4fmert3d-1;
	Fri, 16 Jun 2023 17:17:32 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        quentin@isovalent.com, jolsa@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 0/9] bpf: support BTF kind layout info, CRCs
Date: Fri, 16 Jun 2023 18:17:18 +0100
Message-Id: <20230616171728.530116-1-alan.maguire@oracle.com>
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
 definitions=2023-06-16_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160155
X-Proofpoint-ORIG-GUID: qotuyinw-vhTCoSB-nzbn_krWNnURmEw
X-Proofpoint-GUID: qotuyinw-vhTCoSB-nzbn_krWNnURmEw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

By separating parsing BTF from using all the information
it provides, we allow BTF to encode new features even if
they cannot be used.  This is helpful in particular for
cases where newer tools for BTF generation run on an
older kernel; BTF kinds may be present that the kernel
cannot yet use, but at least it can parse the BTF
provided.  Meanwhile userspace tools with newer libbpf
may be able to use the newer information.

The intent is to support encoding of kind layouts
optionally so that tools like pahole can add this
information.  So for each kind we record

- kind-related flags
- length of singular element following struct btf_type
- length of each of the btf_vlen() elements following

In addition we make space in the BTF header for
CRC32s computed over the BTF along with a CRC for
the base BTF; this allows split BTF to identify
a mismatch explicitly.

The ideas here were discussed at [1], with further
discussion at [2].

Future work can take more advantage of these features
such as

- using base CRC to identify base/module BTF mismatch
  explicitly
- using absence of a base BTF CRC as evidence that
  BTF is standalone

...and new BTF kind addition should present less
trouble, provided the kinds are optional.  BTF
parsing _will_ still fail if a non-optional
kind is encountered, as the assumption is that
such kinds are needed.  To take a few examples,
the tag kinds are optional, however enum64
is required, so BTF containing an enum64
(that did not know about enum64) would be
rejected.  This makes sense as if for example
a struct contained an enum64 we would not
be able to fully represent that struct unless
we knew about enum64s.

Patch 1 is the UAPI changes, patches 2-3 provide
libbpf support for handling and using kind layouts.
Patch 4 adds kernel support for handling and using
kind layouts.  Patch 5 adds libbpf support to add
kind layouts and CRCs based on options passed
to btf__new_empty_opts().   Patch 6 updates
pahole flags for kernel/module BTF generation
to generate kind layout/CRCs if that support
is available.  Patch 7 adds bpftool support
to dump BTF metadata (header + kind layout).
Patch 8 documents this.  Patch 9 is a set
of selftests covering encoding/decoding of
BTF kind layout information, and patch 10
is a dwarves patch to add kind layout encoding
and CRC support via btf__new_empty_opts().

Changes since RFC

- Terminology change from meta -> kind_layout
  (Alexei and Andrii)
- Simplify representation, removing meta header
  and just having kind layout section (Alexei)
- Fixed bpftool to have JSON support, support
  prefix match, documented changes (Quentin)
- Separated metadata opts into add_kind_layout
  and add_crc
- Added additional positive/negative tests
  to cover basic unknown kind, one with an
  info_sz object following it and one with
  N elem_sz elements following it.
- Updated pahole-flags to use help output
  rather than version to see if features
  are present

[1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@oracle.com/

Alan Maguire (9):
  btf: add kind layout encoding, crcs to UAPI
  libbpf: support handling of kind layout section in BTF
  libbpf: use kind layout to compute an unknown kind size
  btf: support kernel parsing of BTF with kind layout
  libbpf: add kind layout encoding, crc support
  btf: generate BTF kind layout for vmlinux/module BTF
  bpftool: add BTF dump "format meta" to dump header/metadata
  bpftool: update doc to describe bpftool btf dump .. format meta
  selftests/bpf: test kind encoding/decoding

 include/uapi/linux/btf.h                      |  24 ++
 kernel/bpf/btf.c                              | 102 +++++--
 scripts/pahole-flags.sh                       |   7 +
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  16 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/btf.c                       |  93 +++++-
 tools/include/uapi/linux/btf.h                |  24 ++
 tools/lib/bpf/btf.c                           | 272 +++++++++++++++---
 tools/lib/bpf/btf.h                           |  11 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/btf_kind.c       | 187 ++++++++++++
 11 files changed, 670 insertions(+), 69 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

-- 
2.39.3


