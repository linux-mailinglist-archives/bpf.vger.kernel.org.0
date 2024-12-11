Return-Path: <bpf+bounces-46644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF469ED244
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 17:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729C41889A50
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 16:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E002D1DDC09;
	Wed, 11 Dec 2024 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SIUFWaIB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE31246340
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935249; cv=none; b=KKj+Q4p2isHIeeszTxp29bB8I8UtwYYUepaEH3uLRsqkMDJTzcUZQIphV/EzF+ZAFPk5t9fcREH39veydgD7upI+ly4LTmA9/SRAIh76n/UtiY7HuTK/R/1fUylLYC01orKT16jbBmdaLKjRMYBQSzejEmKxHcTIwv+I2ibDwlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935249; c=relaxed/simple;
	bh=yDvDnDpnFgs/2yKkDcq8a+Gv16FOxI2GOSyu92awndU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aA6P3VF06bguIMHldl1vNWX6+LtWldUJZLLoaU8uzh4UtTChQYjmaKtvIHuTrdRY/9cmJhUif5G6GINiA8Kk5BECp2RPZnWjqkEZF9LKeWLnbIzpUa3cf/Xboo6MoKJ5cNoSwT7RkTnXqKAys+y5qwxXnb/fMWVperI2K1O/g6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SIUFWaIB; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBFHmAF020765
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 08:40:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=aBin0LCVvfodmsouR5
	cAVhvEFqKsF24ZxjhpbwsNkyk=; b=SIUFWaIB1nuOTLDS67VD0bn6yArW65/DNR
	X+KDa+t0va/aPMA7QNgyNSQpnCGSYDxpIsdfxTP7B9lAiOwguVaKavlNYGgcyo+G
	WsFRm2QCmCVRwxxhH6dujLJN064n/7vxVpYyNONTNY7hBOloNd4DHKKH0hfnXQfX
	EB5lr+LxdK3Bp/Y4t1sh/M/pRT07dEHZpKdrp3KKd5cs37e/SIcp+3GTXi71tuXr
	GB79IDBlojw9wjC5PKKRuDFOeJe2eyq0iHBTI1dRPK2Ke/33NXoE3qvdsMbV8hGC
	eaQA7P6pVBWhkMkEbP5RYeU1tr1qO7lKi7fz2W6X0Jyzme8b+2Tw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43fbt59cma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 08:40:46 -0800 (PST)
Received: from twshared11082.06.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Dec 2024 16:40:45 +0000
Received: by devbig020.cln3.facebook.com (Postfix, from userid 546475)
	id 82D4ED41CD2B; Wed, 11 Dec 2024 08:40:33 -0800 (PST)
From: Alastair Robertson <ajor@meta.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: Alastair Robertson <ajor@meta.com>
Subject: [PATCH bpf-next v3 0/2] libbpf: Extend linker API to support in-memory ELF files
Date: Wed, 11 Dec 2024 08:40:28 -0800
Message-ID: <20241211164030.573042-1-ajor@meta.com>
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
X-Proofpoint-GUID: mQFhVU_QHeDYi86nv0QyIEQwfodyijzh
X-Proofpoint-ORIG-GUID: mQFhVU_QHeDYi86nv0QyIEQwfodyijzh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

This gives API consumers the option of using anonymous files/memfds to
avoid writing temporary ELFs to disk, which will be useful for performing
linking as part of bpftrace's JIT compilation.

v3:
- Removed "filename" option. Now always generate our own filename for
  passed-in FDs and buffers.
- Use a common function (bpf_linker_add_file) for shared
  implementation of bpf_linker__add_file, bpf_linker__add_fd and
  bpf_linker__add_buf.

Alastair Robertson (2):
  libbpf: Pull file-opening logic up to top-level functions
  libbpf: Extend linker API to support in-memory ELF files

 tools/lib/bpf/libbpf.h   |   5 +
 tools/lib/bpf/libbpf.map |   4 +
 tools/lib/bpf/linker.c   | 228 ++++++++++++++++++++++++++++++---------
 3 files changed, 184 insertions(+), 53 deletions(-)

--=20
2.43.5


