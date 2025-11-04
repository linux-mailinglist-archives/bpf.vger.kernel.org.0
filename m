Return-Path: <bpf+bounces-73497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9050C32E99
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 21:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 695014E7065
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 20:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2662E7BD9;
	Tue,  4 Nov 2025 20:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jeKx5/Gn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9720E8488
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762288443; cv=none; b=X3EC5H+W00DWtPRNJXi4dh05vzSlu7WhCGRIU8f/SR68KWNYHW+9GqGaNjAVQdEeoXRkBoDCtea8wZhAxrBtKsIUw0OCug3FXiwPVQyXh00oKJTLY5g7VLE/TOIFOsUvEdEZ9sJENxgXR+l9Sb53xCB+zV/id67TSEwsQVooIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762288443; c=relaxed/simple;
	bh=e6bLHem1tIXaK18uOCxKUYRzA5Ow36mLbYDIMPXFeA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vDGaFb/7gHU4XndW298PPpXUfpJ8BuNz31Ze4bVgSY8gcR1bXphjaYa+/oHlBxmYn+C/07iWthN7cmG0ZYKUttx6wFHsIP3OI9Zfh9ys5rifKS1u5VoAmA+xaccAdK3qOL3LPP9qa/iLoD/58/vvgl4tEO0j58/vjDe5JF2YwUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jeKx5/Gn; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4KOjgj031194;
	Tue, 4 Nov 2025 20:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=TX5VepWRxaY945SBBrQ82BijN0kq1
	h1Qs3uUF5cHCk4=; b=jeKx5/GnuRYzTOJ91eQTXaMBg9yjjKjNlUDe7Y2d5MXQ2
	45yiLyKZxlkpG3rLzXyq8YRvJbEIKzNbBjai9tW9KtzARlTVdbSyKrEAiddUmA3V
	EfJSslizlXL51+luoAqcgJIxO3k0c7Aur31zqGYU+65nA/Ih2Zy5LZ5NKLS4jEGR
	hcIceOP+d4ETCpT/jjQg/cwCMpcWejUPCLzu9BrrUn40HMOfWiJ5yLIwXo/hjy+s
	cQLmlOy7CuTKbS/cxMEIdOdIfubrpodcqE3awtMGfNehl/+BcDfEB96fktFtLtQv
	nz+6jrDAZi+dA9c8oyHoe0FhX2jDOW7yGK7AfQfCA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7rgar0jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 20:33:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4KUnv5019388;
	Tue, 4 Nov 2025 20:33:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nkw95w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 20:33:33 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A4KXWvc039670;
	Tue, 4 Nov 2025 20:33:32 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-59-143.vpn.oracle.com [10.154.59.143])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a58nkw8un-1;
	Tue, 04 Nov 2025 20:33:32 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, ihor.solodrai@linux.dev,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 0/2] Multi-split BTF fixes and test
Date: Tue,  4 Nov 2025 20:33:07 +0000
Message-ID: <20251104203309.318429-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511040173
X-Authority-Analysis: v=2.4 cv=aqK/yCZV c=1 sm=1 tr=0 ts=690a631e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=yiKXGxLub-E0OzASjs4A:9 cc=ntf awl=host:12124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE3MSBTYWx0ZWRfX+2coUoxh+9/E
 n+ehD4ZHUz0WdOh2oKe19yGVWzr463OxpQKL1lytnEaj/SzOhgao5e/PwRv4DY2L4y2x8yvp708
 tcTKmQTLAXcvtf5FZT9a4fvFQGsNan/jERqHQ35ZofqqeyUgTlfzT2+TSnPlXYpXik+d8E5prnP
 g8Zq6yYVKQuTVmHgHGJLd9UU171vFvYNdujMfhBDYh4V8L3p4kvZ/3s4fZmuTE/duLMdOqaDGT4
 p/eUCaMvvHutCBjA104QU4UlFb4vpjFBg8bW0NEgJ6pgjTCQMT4Jm6jkA3rLqmAh8J/jOvWoO0F
 zCVWkxEHXOsRtGHZvQrNcOe925h2kKS8eJZgfuFgQ0KUGDfmguw0STW3Xc6rPaKYMMquih8Z3N7
 BbsNYkCGaJtOqPwPVKJT9mEd2L0LxqITMb/QOMA8HGYu/pglBEQ=
X-Proofpoint-ORIG-GUID: j4RHXVfkv68TgPhVd2EK518a-6lg6lCP
X-Proofpoint-GUID: j4RHXVfkv68TgPhVd2EK518a-6lg6lCP

This small series consists of a fix to multi-split BTF parsing
(patch 1) and a test which exercises (multi-)split BTF parsing
(patch 2).

Changes since v3 [1]
- add asserts to ensure number of types in original and parsed
  BTF are identical, and the calls to btf__type_by_id() return
  valid pointers (code review bot, patch 2)

Changes since v2 [2]

- fix Fixes: tag formatting (Andrii, patch 1)
- BPF code-review bot saw we were doing ASSERT_OK_PTR() on wrong
  BTF (not multisplit) in patch 2
- ensure cleanup is correctly handled for BTF, unlink in split
  tests (Andrii, patch 2)

Changes since v1 [3]

- BPF code-review bot spotted another place that the string offset
needed to be adjusted based upon base start string offset + header
string offset.
- added selftests to extend split BTF testing to parsing

[1] https://lore.kernel.org/bpf/20251028225544.1312356-1-alan.maguire@oracle.com/
[2] https://lore.kernel.org/bpf/20251028155709.1265445-1-alan.maguire@oracle.com/
[3] https://lore.kernel.org/bpf/20251023142812.258870-1-alan.maguire@oracle.com/

Alan Maguire (2):
  libbpf: Fix parsing of multi-split BTF
  selftests/bpf: Test parsing of (multi-)split BTF

 tools/lib/bpf/btf.c                           |  4 +-
 .../selftests/bpf/prog_tests/btf_split.c      | 87 ++++++++++++++++++-
 2 files changed, 87 insertions(+), 4 deletions(-)

-- 
2.39.3


