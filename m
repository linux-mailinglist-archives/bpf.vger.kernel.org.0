Return-Path: <bpf+bounces-28993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B848BF314
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 02:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E431F221F0
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 00:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D8E132C3F;
	Tue,  7 May 2024 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="2UtulqaN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391380BE5;
	Tue,  7 May 2024 23:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715125270; cv=none; b=Vq9Iu5lF7++eXzgq5JtVVQxLJrq1kmSb84xVoHp5qGdiw7oW+ae4pqzHhbaRQ9ZcHREftzSN0Fcmg8Sd7WCu9JpMMcGD9QevauXbNXj6XFmjJ1xCgggeebwA1z4gcjbVrkezJgRhF2zOTbSZxCGKMSuED0a2aiPQIvo17hUqcNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715125270; c=relaxed/simple;
	bh=DzIBNyM5bHb69k+2aGT791vy83w8DRLKb5e6PQS5kxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LQp2rDA3g1OCIQybaRoFILAD4AiFCi0DPs+M5xp6KYzEgo7Ok/Cjz2y4QjShCH+DRiYYF4pXMzR/skc8FKml18hQHS2fSq78p7ck7m9bGnD4kH/UQQmi7MJ6krQeEIKYKYVTBf3UkKu17WhfQeslyRykfoMfTlPEQK6hIVx7NhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=2UtulqaN; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355087.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447IKCU0011567;
	Tue, 7 May 2024 23:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	date:from:to:cc:subject:message-id:mime-version:content-type; s=
	DKIM202306; bh=VGziX56dHq14Bu+7ioE0T28erjDlFCIx9NNqQFIUAWE=; b=2
	UtulqaNFrOC5ntuxHe963dh2rlvjRFwvJuCuH/nNag5aPI5qzRVFhzB8mLXeox/c
	nWoVGHcMqheKzyi5Q2lDxbtuoY1ZEOWW9iE5LLb7T8eX9b+KGHb7h2d9x4U4JYP2
	8/Fp9pn5zWqWBkh2wtv2VNVivxvYQgZYGhYSwn36lbWwbH2kxq7h6MrSMdoK+Rfk
	aSlLpAYto3KGBMUaIOy9OLkmc+Nxvdqhmh1G7cFpFVQcmLBypZG7gg3d6i67cnsp
	a2+388UJncykhLYvx/fn9duUaljlEH9QzHmJK064zdtRWNvamyngYyB+7xHnCKji
	MPrK0O50W0+9ZUikSW2oA==
Received: from va32lpfpp01.lenovo.com ([104.232.228.21])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3xysg68ehu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 23:40:17 +0000 (GMT)
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp01.lenovo.com (Postfix) with ESMTPS id 4VYvsD1ZjlzgQ3M;
	Tue,  7 May 2024 23:40:16 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4VYvsC5rZXz2VZ3B;
	Tue,  7 May 2024 23:40:15 +0000 (UTC)
Date: Tue, 7 May 2024 18:40:14 -0500
From: Maxwell Bland <mbland@motorola.com>
To: "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 0/3]  Support kCFI + BPF on arm64
Message-ID: <fhdcjdzqdqnoehenxbipfaorseeamt3q7fbm7ghe6z5s2chif5@lrhtasolawud>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: 0FthpWwfiD2jFL969mXhLQWi8o5CI2vc
X-Proofpoint-GUID: 0FthpWwfiD2jFL969mXhLQWi8o5CI2vc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_15,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=699 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405070167

In preparation for the BPF summit, I took a look back on BPF-CFI patches
to check the status and found that there had been no updates for around
a month, so I went ahead and made the fixes suggested in v2.

This patchset handles emitting proper CFI hashes during JIT, which
can cause some of the selftests to fail, and handles removing the
__nocfi tag from bpf_dispatch_*_func on ARM, meaning Clang CFI 
checks will be generated:

0000000000fea1e8 <bpf_dispatcher_xdp_func>:
paciasp
stp     x29, x30, [sp, #-0x10]!
mov     x29, sp
+ ldur    w16, [x2, #-0x4]                           
+ movk    w17, #0x1881                               
+ movk    w17, #0xd942, lsl #16                      
+ cmp     w16, w17                                
+ b.eq    0xffff8000810016a0 <bpf_dispatcher_xdp_func+0x24>
+ brk     #0x8222   
blr     x2
ldp     x29, x30, [sp], #0x10
autiasp
ret

Where ^+ indicates the additional assembly.

Credit goes to Puranjay Mohan entirely for this, I just did some fixes,
hopefully that is OK.

Cc: stable@vger.kernel.org

Changes in v2->v3:
https://lore.kernel.org/all/20240324211518.93892-1-puranjay12@gmail.com/
- Simplify cfi_get_func_hash to avoid needless failure case
- Use DEFINE_CFI_TYPE as suggested by Mark Rutland

Changes in v1->v2:
https://lore.kernel.org/bpf/20240227151115.4623-1-puranjay12@gmail.com/
- Rebased on latest bpf-next/master

Mark Rutland (1):
  cfi: add C CFI type macro

Maxwell Bland (1):
  arm64/cfi,bpf: Use DEFINE_CFI_TYPE in arm64

Puranjay Mohan (1):
  arm64/cfi,bpf: Support kCFI + BPF on arm64

 arch/arm64/include/asm/cfi.h    | 23 ++++++++++++++++++++++
 arch/arm64/kernel/alternative.c | 18 +++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c   | 18 +++++++++++++++--
 arch/riscv/kernel/cfi.c         | 34 ++------------------------------
 arch/x86/kernel/alternative.c   | 35 +++------------------------------
 include/linux/cfi_types.h       | 23 ++++++++++++++++++++++
 6 files changed, 85 insertions(+), 66 deletions(-)
 create mode 100644 arch/arm64/include/asm/cfi.h


base-commit: 329a6720a3ebbc041983b267981ab2cac102de93
-- 
2.34.1


