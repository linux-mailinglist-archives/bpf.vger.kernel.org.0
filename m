Return-Path: <bpf+bounces-20834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD5B8443FA
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904E61F2BEC3
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 16:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F079912AAD1;
	Wed, 31 Jan 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Agkxpnwk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909F11272C2
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718030; cv=none; b=k5LU1YcGzzyJ49clcAIBkPqZkUHFrMxae5ymTSm9gkefYQPQPoSCETQLTpf+3+9EZdXOZz1fyi72I9bZ4kP3whKcmfYYGf8hiboJ12fcqJ8zIpsLhrrgw7TaoAXx+LrSVXQumko2kMTmv9WP1LLYLVb9ltFvdgOniUe7p2zjKQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718030; c=relaxed/simple;
	bh=nMfKEQz6FTs1b/Jf5fBpnS2eBDLnQ05jKoNJrAe3mbk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t+9bgoDn7R0031E8s5yUTp4BU/fF3Kn9EmRpgCbeCYwFaLugpt/vbQ9aaUCzhE7mB7DBbHAswgfpg2rFtMDyg/asgoqVCMoysL7RRuwCnB+QP7h6LIX75TODRUcBWrhWSqBhttsP97VdL9S+gcF91EOABuUeoniiFcGs5v3rdLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Agkxpnwk; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VEx4IR022214;
	Wed, 31 Jan 2024 16:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=+w4VO/qZ9TcVi/JKyTpBqWOlu1ROBjOIAOLqZts+BmI=;
 b=AgkxpnwkLbCEnAe5+FCjpO2w3LCp5FCST5Er9LR4tyhrdKowwFEtttByWbxxQG+66Cf5
 X7mXMUD1WBPEnA577LocQPLOOm9mdt+/nosHWXxgEaRpsq0GYSckPMUzjmpkSM/+bVQ2
 zeWAkxwwn9PDFmNg4YYGlhGPNORc74/FHaI70Iysz0v7vpONcb/Vb00FxrsIekG/+2dR
 2HXwEyXxLUP8UVhJJuKsN1r8EvcYyd+y1gJGpFVhYJqiPZ5aelG3zxnqyEzh0rglu4gT
 8jdFGc69saWiUjQVgCukr7LG/ypTNm/ZWVHIIGLjVwRZWaaGSE4AklPn2RG2JNdx8FtF RQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8ej39r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 16:20:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VFTgKi025948;
	Wed, 31 Jan 2024 16:20:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr99awyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 16:20:08 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VGFbtn033723;
	Wed, 31 Jan 2024 16:20:08 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-217-87.vpn.oracle.com [10.175.217.87])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr99awvm-1;
	Wed, 31 Jan 2024 16:20:07 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 0/2] libbpf Userspace Runtime-Defined Tracing (URDT)
Date: Wed, 31 Jan 2024 16:20:01 +0000
Message-Id: <20240131162003.962665-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_09,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310126
X-Proofpoint-ORIG-GUID: IrBaJbjnPp8vwQLIE74XnlsijbROQ18s
X-Proofpoint-GUID: IrBaJbjnPp8vwQLIE74XnlsijbROQ18s

Adding userspace tracepoints in other languages like python and
go is a very useful for observability.  libstapsdt [1]
and language bindings like python-stapsdt [2] that rely on it
use a clever scheme of emulating static (USDT) userspace tracepoints
at runtime.  This involves (as I understand it):

- fabricating a shared library
- annotating it with ELF notes that describe its tracepoints
- dlopen()ing it and calling the appropriate probe fire function
  to trigger probe firing.

bcc already supports this mechanism (the examples in [2] use
bcc to list/trigger the tracepoints), so it seems like it
would be a good candidate for adding support to libbpf.

However, before doing that, it's worth considering if there
are simpler ways to support runtime probe firing.  This
small series demonstrates a simple method based on USDT
probes added to libbpf itself.

The suggested solution comprises 3 parts

1. functions to fire dynamic probes are added to libbpf itself
   bpf_urdt__probeN(), where N is the number of probe arguemnts.
   A sample usage would be
	bpf_urdt__probe3("myprovider", "myprobe", 1, 2, 3);

   Under the hood these correspond to USDT probes with an
   additional argument for uniquely identifying the probe
   (a hash of provider/probe name).

2. we attach to the appropriate USDT probe for the specified
   number of arguments urdt/probe0 for none, urdt/probe1 for
   1, etc.  We utilize the high-order 32 bits of the attach
   cookie to store the hash of the provider/probe name.

3. when urdt/probeN fires, the BPF_URDT() macro (which
   is similar to BPF_USDT()) checks if the hash passed
   in (identifying provider/probe) matches the attach
   cookie high-order 32 bits; if not it must be a firing
   for a different dynamic probe and we exit early.

Auto-attach support is also added, for example the following
would add a dynamic probe for provider:myprobe:

SEC("udrt/libbpf.so:2:myprovider:myprobe")
int BPF_URDT(myprobe, int arg1, char *arg2)
{
 ...
}

(Note the "2" above specifies the number of arguments to
the probe, otherwise it is identical to USDT).

The above program can then be triggered by a call to

 BPF_URDT_PROBE2("myprovider", "myprobe", 1, "hi");

The useful thing about this is that by attaching to
libbpf.so (and firing probes using that library) we
can get system-wide dynamic probe firing.  It is also
easy to fire a dynamic probe - no setup is required.

More examples of auto and manual attach can be found in
the selftests (patch 2).

If this approach appears to be worth pursing, we could
also look at adding support to libstapsdt for it.

Alan Maguire (2):
  libbpf: add support for Userspace Runtime Dynamic Tracing (URDT)
  selftests/bpf: add tests for Userspace Runtime Defined Tracepoints
    (URDT)

 tools/lib/bpf/Build                           |   2 +-
 tools/lib/bpf/Makefile                        |   2 +-
 tools/lib/bpf/libbpf.c                        |  94 ++++++++++
 tools/lib/bpf/libbpf.h                        |  94 ++++++++++
 tools/lib/bpf/libbpf.map                      |  13 ++
 tools/lib/bpf/libbpf_internal.h               |   2 +
 tools/lib/bpf/urdt.bpf.h                      | 103 +++++++++++
 tools/lib/bpf/urdt.c                          | 145 +++++++++++++++
 tools/testing/selftests/bpf/Makefile          |   2 +-
 tools/testing/selftests/bpf/prog_tests/urdt.c | 173 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_urdt.c | 100 ++++++++++
 .../selftests/bpf/progs/test_urdt_shared.c    |  59 ++++++
 12 files changed, 786 insertions(+), 3 deletions(-)
 create mode 100644 tools/lib/bpf/urdt.bpf.h
 create mode 100644 tools/lib/bpf/urdt.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/urdt.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_urdt.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_urdt_shared.c

-- 
2.39.3


