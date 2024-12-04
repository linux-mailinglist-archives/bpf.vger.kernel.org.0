Return-Path: <bpf+bounces-46081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7834B9E3F7E
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 17:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A94B62623
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 16:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928BA20D507;
	Wed,  4 Dec 2024 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JkEoIxBE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9225520C49E
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328683; cv=none; b=HcgbGvNPtRXzeN/d9WHJmd37N6YjCDa+gB8EU0bCkLkJ8uAvb7fMz8XNWKFUkidxEAIyWRLjX9UupSgsHFXNOkfrHHip9B6t0Ky1ob33f83rkxhqraPNYh32stmrYIb+WfVsOE1/tMEYD29iaD+1neNmV7T5GLjA1MDVIjVYvHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328683; c=relaxed/simple;
	bh=2917zy/RIikJzMs87oEYSpnccXkV2V2DyLnYp7ff3QE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L0KawmOE4rOyapdiIzk8Z+RM+wQCDBE0z8cdYhT1ltDzSUNvZDZaTKisvxJggNMin8UGEeFtnMZy7mUiSG1dQ3KIWe64Sdio4SiDr9YyxWNR+UEocevosTZztFlTXWQcfju0zL6A9XYJ2hfYA061HuFechYJ+N9Lt3BFtr3YbNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JkEoIxBE; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4B4FhXm0003743
	for <bpf@vger.kernel.org>; Wed, 4 Dec 2024 08:11:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=efSlFiNxtaVaKDZYEv
	g3LyXFTS14fgKPiwdFnKKZ6uA=; b=JkEoIxBEXatW6XYHe+pajAbcl8rpVhUvTq
	koMR/jix9i+OlWwY7rv2CyJJ5Hpy7lFQJNpXsgtK0dCmCzqXZG5Jfk689RQsKXmH
	fsHpxpcCPQ2B8+jB9RIi/hmIq0/7MgJgq9h378PXVTW0F56br6aZ2F8poPh6VdtM
	BssbCNKmahzCbWZzAj9dgvQhUQTL3MMWYKIIuhHkhPbXPRPCMa0Z9Z/bV/jY9Yj7
	mgx+5kiPw8jqHK7iUqQrFfE5SbQyDlW1Gri/XHccsU0ztusPdaW7girD0sBNHawC
	TaAoVAfbKBDdWtN7jTevE/KwVaWQaVi2inI4Lq+KVcxSJ4+W4fkg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 43aky3jhah-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 08:11:19 -0800 (PST)
Received: from twshared9216.15.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Dec 2024 16:11:18 +0000
Received: by devbig020.cln3.facebook.com (Postfix, from userid 546475)
	id AED13D093695; Wed,  4 Dec 2024 08:11:06 -0800 (PST)
From: Alastair Robertson <ajor@meta.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: Alastair Robertson <ajor@meta.com>
Subject: [PATCH bpf-next v2 0/2] libbpf: Extend linker API to support in-memory ELF files
Date: Wed, 4 Dec 2024 08:10:59 -0800
Message-ID: <20241204161101.1148347-1-ajor@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gszCWCkvND9Zq9HHT5nyltbajv_vhNQA
X-Proofpoint-GUID: gszCWCkvND9Zq9HHT5nyltbajv_vhNQA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

This gives API consumers the option of using anonymous files/memfds to
avoid writing temporary ELFs to disk, which will be useful for performing
linking as part of bpftrace's JIT compilation.

v2:
- Split into two commits
- Replace non-required "name" parameters with new optional opt->filename
  field
- Implement bpf_linker__add_file/bpf_linker__add_buf on top of
  bpf_linker__add_fd
- Remove bpf_linker__finalize_fd and instead have libbpf keep track of
  whether the linker's fd is owned by the linker

Alastair Robertson (2):
  libbpf: Pull file-opening logic up to top-level functions
  libbpf: Extend linker API to support in-memory ELF files

 tools/lib/bpf/libbpf.h   |  12 ++-
 tools/lib/bpf/libbpf.map |   3 +
 tools/lib/bpf/linker.c   | 207 ++++++++++++++++++++++++++++++---------
 3 files changed, 176 insertions(+), 46 deletions(-)

--=20
2.43.5


