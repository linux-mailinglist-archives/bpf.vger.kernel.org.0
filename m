Return-Path: <bpf+bounces-32416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC4490D929
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 18:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4546F1C229D1
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 16:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BABB5588F;
	Tue, 18 Jun 2024 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mgow4xIi"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D5C46521
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727937; cv=none; b=So5KlwVR4skJknJYpXRlJadKdxwA7YuRHreuJFce/OM6ZJCGvSDFqzg99MpOyTbIgVa+xx6T1glIEIL9vw7i+bWuejgM56UvWI5DYP52ydkR+obp7M1HlSOWYAr1/bfHv1+pKOQj4gVwKg2OtdtA8mNKe+gGS3wq4oq3vEm3Nls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727937; c=relaxed/simple;
	bh=bXnld3R7QAvvT4to1wcl6D+AXu+GpHjCcAm5/bPgRfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tyVMlmekLk4EPUxE5S0/RlTBx+DOvIBlOfvRxgDQvha/pWTv10qcmHkULlJ0fFN3ZU+3o4l58IRb0S7j1/iKJjpJb7/schZUfnqULjHAHpCVPptifGw1HposWYR5yBswhjzRVD0ynCDCKG9dRfajZfAkXlvw/kwdyWemDu7OkkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mgow4xIi; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IGMDVn004258;
	Tue, 18 Jun 2024 16:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=HOCKk58Wvm0upV
	9SzkZ5XUFWbYxzgWIiTlzqMnrs/74=; b=mgow4xIi1W2rGETc67svpVJoSQc+oi
	ui52l+18KZ76feNvEqBuUnH6VLexqobcFW/DAoSksJmSdIae+EynwX/w7ZeUCdoB
	QdQH6E26fUwuUwpF8n62eLeYpxJHSIa5t/ZQdecKR7V5jfEJ996hvKvdEO5pQbSs
	tK7xFiJqXCZRYheRyE3fGv4nMQTmR+PTvwTmv+Z0j2ZLbx0xPXeG1qYPtjrg/uhm
	oFi2/WqDpQir2aVHHm0AGrD7IK8yTeEEM8lU35mwz2fhYQzCYVz4TSN9AZiZBnIT
	s6QOhkprX6O5xC6TlxLagWeiJQ2ElZFsdA+jK/DuADW4GjQAejhqex2w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1cc5a10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 16:25:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IFps1E034687;
	Tue, 18 Jun 2024 16:24:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d8c0cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 16:24:56 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45IGOt3s028167;
	Tue, 18 Jun 2024 16:24:55 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-223-50.vpn.oracle.com [10.175.223.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ys1d8c08e-1;
	Tue, 18 Jun 2024 16:24:55 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com
Cc: acme@redhat.com, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com,
        bentiss@kernel.org, tanggeliang@kylinos.cn, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 0/5] bpf: resilient split BTF followups
Date: Tue, 18 Jun 2024 17:24:44 +0100
Message-ID: <20240618162449.809994-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=814 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180123
X-Proofpoint-ORIG-GUID: Lq4ZWpHuLKoSPc28MHK99r6iaPiWbVLS
X-Proofpoint-GUID: Lq4ZWpHuLKoSPc28MHK99r6iaPiWbVLS

Follow-up to resilient split BTF series [1],

- cleaning up libbpf relocation code (patch 1);
- adding 'struct module' support for base BTF data (patch 2);
- sharing libbpf relocation code with the kernel (patch 3);
- adding a kbuild --btf_features flag to generate distilled base
  BTF in the module-specific case where KBUILD_EXTMOD is true
  (patch 4); and
- adding test coverage for module-based kfunc dtor (patch 5)

Generation of distilled base BTF for modules requires the pahole patch
at [2], but without it we just won't get distilled base BTF (and thus BTF
relocation on module load) for bpf_testmod.ko.

[1] https://lore.kernel.org/bpf/20240613095014.357981-1-alan.maguire@oracle.com/
[2] https://lore.kernel.org/bpf/20240517102714.4072080-1-alan.maguire@oracle.com/

Alan Maguire (5):
  libbpf: BTF relocation followup fixing naming, loop logic
  module, bpf: store BTF base pointer in struct module
  libbpf,bpf: share BTF relocate-related code with kernel
  kbuild,bpf: add module-specific pahole flags for distilled base BTF
  selftests/bpf: add kfunc_call test for simple dtor in bpf_testmod

 include/linux/btf.h                           |  64 +++++++
 include/linux/module.h                        |   2 +
 kernel/bpf/Makefile                           |  10 +-
 kernel/bpf/btf.c                              | 176 ++++++++++++-----
 kernel/module/main.c                          |   5 +-
 scripts/Makefile.btf                          |   5 +
 scripts/Makefile.modfinal                     |   2 +-
 tools/lib/bpf/Build                           |   2 +-
 tools/lib/bpf/btf.c                           | 162 ----------------
 tools/lib/bpf/btf_iter.c                      | 177 ++++++++++++++++++
 tools/lib/bpf/btf_relocate.c                  |  97 ++++++----
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  46 +++++
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |   9 +
 .../selftests/bpf/prog_tests/kfunc_call.c     |   1 +
 .../selftests/bpf/progs/kfunc_call_test.c     |  14 ++
 15 files changed, 513 insertions(+), 259 deletions(-)
 create mode 100644 tools/lib/bpf/btf_iter.c

-- 
2.31.1


