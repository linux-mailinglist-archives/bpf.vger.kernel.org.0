Return-Path: <bpf+bounces-1538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C88718AFE
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 22:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2439E2815DA
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 20:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37E43C0B3;
	Wed, 31 May 2023 20:21:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E9334CE2
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 20:21:23 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7CA10F
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 13:21:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJptRj027834;
	Wed, 31 May 2023 20:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=bW7uVAB1eKVC26qw09qUpVlYLn8Bai2uuihUzyci9G0=;
 b=F8rVRZ1ebpyy/UX91LGLGPwilZd8p6YrJ36odJhTNB002tOouXRk2M39oiO0rhCe3qRQ
 kWvfhvxttMnWRTf5phwwT96FSgsJU/PcoK1IvUaRIG/oo97N9v8FJ8KiU/74pseu+sNc
 0CYGhml/MgARGajvb4FFhg7mFM+rR9n1AuU9LYf2q56KNwSQXTSWvXYH8q4miqw9g58p
 +2fOd4cdyedATYIZr8S4mGAhuh8yKYkQ2zsZqHP4qsXo/IEQhpPGuxh9zZXbUsJ5bpVe
 EBfn4KOO7Gauq9FNCnu588LJCXtX78P1Lpo0jK8xM+BMMu7NSt+XFOuKmEsZgjderAuM zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhwweuba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 20:20:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJrqIl019761;
	Wed, 31 May 2023 20:20:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6djdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 May 2023 20:20:36 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34VKKaEL000653;
	Wed, 31 May 2023 20:20:36 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-201-40.vpn.oracle.com [10.175.201.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qu8a6djab-1;
	Wed, 31 May 2023 20:20:35 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, acme@kernel.org
Cc: martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
        mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 0/8] bpf: support BTF kind metadata to separate
Date: Wed, 31 May 2023 21:19:27 +0100
Message-Id: <20230531201936.1992188-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_14,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310172
X-Proofpoint-ORIG-GUID: EtgnOQoMmOfjlLKPEd9a1Z_NSItw349g
X-Proofpoint-GUID: EtgnOQoMmOfjlLKPEd9a1Z_NSItw349g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

BTF kind metadata provides information to parse BTF kinds.
By separating parsing BTF from using all the information
it provides, we allow BTF to encode new features even if
they cannot be used.  This is helpful in particular for
cases where newer tools for BTF generation run on an
older kernel; BTF kinds may be present that the kernel
cannot yet use, but at least it can parse the BTF
provided.  Meanwhile userspace tools with newer libbpf
may be able to use the newer information.

The intent is to support encoding of kind metadata
optionally so that tools like pahole can add this
information.  So for each kind we record

- a kind name string
- kind-related flags
- length of singular element following struct btf_type
- length of each of the btf_vlen() elements following

In addition we make space in the metadata for
CRC32s computed over the BTF along with a CRC for
the base BTF; this allows split BTF to identify
a mismatch explicitly.

The ideas here were discussed at [1]. One additional
change is here that I believe will help BTF debugging;
support for adding a description string to BTF
metadata.  It can be used by pahole to describe
the version used, options etc.

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
libbpf support for handling and using metadata.
Patch 4 adds kernel support for handling and using
metadata.  Patch 5 adds libbpf support to add
metadata.  Patch 6 adds BTF encoding flag
--btf_gen_meta for kernel/module BTF encoding.
Patch 7 adds bpftool support to dump header
and metadata info.  Patch 8 is a selftest
that validates metadata encoding and tests
that an unknown (optional) kind can be skipped
over without BTF failure.

Finally patch 9 is a patch for dwarves
to use the libbpf APIs to encode metadata.
dwarves has to be built with the updated
libbpf for this to work.

Changes tested on x86_64, aarch64.  BTF metadata
validation likely needs some tidying up but
wanted to get it out ASAP so probably still
rough around the edges.

[1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/

Alan Maguire (8):
  btf: add kind metadata encoding to UAPI
  libbpf: support handling of metadata section in BTF
  libbpf: use metadata to compute an unknown kind size
  btf: support kernel parsing of BTF with metadata, use it to parse BTF
    with unknown kinds
  libbpf: add metadata encoding support
  btf: generate metadata for vmlinux/module BTF
  bpftool: add BTF dump "format meta" to dump header/metadata
  selftests/bpf: test kind encoding/decoding

 include/uapi/linux/btf.h                      |  29 ++
 kernel/bpf/btf.c                              | 102 +++++-
 scripts/pahole-flags.sh                       |   2 +-
 tools/bpf/bpftool/btf.c                       |  46 +++
 tools/include/uapi/linux/btf.h                |  29 ++
 tools/lib/bpf/btf.c                           | 297 +++++++++++++++---
 tools/lib/bpf/btf.h                           |  11 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/btf_kind.c       | 138 ++++++++
 9 files changed, 595 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

-- 
2.31.1


