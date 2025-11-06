Return-Path: <bpf+bounces-73833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F83EC3B03B
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 13:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956FE465CB4
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70572820AC;
	Thu,  6 Nov 2025 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="glN6v52Q"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAD932ABCA;
	Thu,  6 Nov 2025 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433187; cv=none; b=sAbmT+3Wc6S2OoOrTpic9nKpAZL+GLc+meOBkUkDglPf8iFskHOH0tnUm8AKgKcjUB8GluZUkAH7WcSHSiCNHNihOH1ABmkKJO2YFTojsjGmdYd/4xr1H7hGhBOe+jP7An2ewaJAQJq8Gb5g9+r7PHgdBsFf/mcJfolsPd6QPzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433187; c=relaxed/simple;
	bh=DaWuUrr9V7H8CTZeEaqMvjlBRxJfnfmBQp/S4tXoorM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nybQWIH0PStZgwtfGv/1pUqRs/y4+B66grTnp+YGqUyTuyrkm43jk044YiNn4FDDqrLbVntZ3gHbKx8TdNJAh92cesrLxnc4kXgUATHeD6fn43kmYatKDYZT+bDtybXIYMhNY/LGAQCoihqkwXpKse1IcsgyfNlWdps+oKm2zyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=glN6v52Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A68HL5C000721;
	Thu, 6 Nov 2025 12:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=zfRoPEbvu32R9S8LXqwUMMWSUoyqc1tbbe+dM0gVC
	y8=; b=glN6v52Qb4iNRYka3Yyy8D9Ny0GpOZjzyMJ8WpzUV5azZKJ1jeuTEoVt3
	MKCQQcJGBvSilc46gGxM3DqZZ2949NUd1LrqjmpgEVuV779KQKqb15s7JuUtWdgt
	Oc1qXuOvQw68f35nZB3bHIDd3H7Niiu53CA5z4XRgf44/6b/W66mYLQrNVFB52td
	DgOMstxczUjNJtMm/sdFlxuuhMYLvU28Rm3m1wh1y+qZgoTjfQ/YlRswQ2FRTsOa
	4ibBpS8Oi5ypc0igo2q7zjSByOVb4MrfGIbJ1EC93vb8XFNaFic5nG3VsrL1OLG+
	AIK7EsxUIpSbSXxvjbc22CIqd+RiQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vuq459-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 12:46:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6C5ZgH009877;
	Thu, 6 Nov 2025 12:46:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5x1kncen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 12:46:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A6Ck2u145089152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Nov 2025 12:46:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3728020043;
	Thu,  6 Nov 2025 12:46:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A1B720040;
	Thu,  6 Nov 2025 12:46:01 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.27.154])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Nov 2025 12:46:01 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/2] scripts/gdb/symbols: make BPF debug info available to GDB
Date: Thu,  6 Nov 2025 13:43:40 +0100
Message-ID: <20251106124600.86736-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RoYRZSKI-6pZOJJoUthk7h7gmXA4XuIL
X-Proofpoint-GUID: RoYRZSKI-6pZOJJoUthk7h7gmXA4XuIL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX8pLRdQw0XMRA
 nUL3QgVSPOoT3dxvYAt0gng95lOCUIFr9iNc9Ll95x0KJvVD+UNTUafrJ+J/F1Nvf/FFJ2Jfzit
 GJNHRej7LbeZ8V2tY+O91S7OqMOQMO1dwOxctTZoMs6ARg5SAD/lK4rDj4pn8nf+cnAqyIYBMXd
 MheV/3D/n1CxjMGf5MRfGYyvp+a4f3RE2Sxq9i+aP0a5W5EcgUzzhOtLi67JMIWFZf23Is6Xys+
 tGLbU/ZAzP15hthVa4Gy432VBNComsEtIoSUDH4dZYHpuKOJW22zNcPQvk5RIbv6oOvhun0xXZC
 Xy5sWS3C/slajj1vuLyQCzwz1Ee634JBW76SRX1bx8wwJWxJFBMvD0E7wO+BRDss5IsmY1/iE1r
 CNDolTtuwZWOHbrNiiI4fuMVpymUVg==
X-Authority-Analysis: v=2.4 cv=U6qfzOru c=1 sm=1 tr=0 ts=690c988f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=kNVtBLC0NxUZ2hMEPw8A:9 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511010021

v1: https://lore.kernel.org/bpf/20250710115920.47740-1-iii@linux.ibm.com/
v1 -> v2: Hide the feature behind the -bpf flag for performance reasons
          (Jan).
          Fix running lx-symbols twice.


Hi,

This series greatly simplifies debugging BPF progs when using QEMU
gdbstub by providing symbol names, sizes, and line numbers to GDB.

Patch 1 adds radix tree iteration, which is necessary for parsing
prog_idr. Patch 2 is the actual implementation; its description
contains some details on how to use this.

Best regards,
Ilya

Ilya Leoshkevich (2):
  scripts/gdb/radix-tree: add lx-radix-tree-command
  scripts/gdb/symbols: make BPF debug info available to GDB

 scripts/gdb/linux/bpf.py          | 253 ++++++++++++++++++++++++++++++
 scripts/gdb/linux/constants.py.in |   3 +
 scripts/gdb/linux/radixtree.py    | 139 +++++++++++++++-
 scripts/gdb/linux/symbols.py      | 105 +++++++++++--
 4 files changed, 481 insertions(+), 19 deletions(-)
 create mode 100644 scripts/gdb/linux/bpf.py

-- 
2.51.1


