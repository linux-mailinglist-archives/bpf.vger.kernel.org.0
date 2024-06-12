Return-Path: <bpf+bounces-31936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1869056CC
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 17:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93CA1C21565
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F3B17F4FE;
	Wed, 12 Jun 2024 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="xC/AhsGg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C78617E90D;
	Wed, 12 Jun 2024 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205945; cv=none; b=qeFLX3Rmh5N/9SZ7y1kPAlL+Fb/EhP9JRo2ILRyQYS2L6gQkyE5k6hBQTpBvhgQKXPNvt3rMRU71hjJbzsTtHSXgwPFjxnVG9ipIqFI2db/LCbeNOMnXPTT/lgr/RLX7mHSKcI53Uk0LQiRl96bxKkreMeXZVvt2yX0sA+k4a8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205945; c=relaxed/simple;
	bh=1e8r/pvg4fjFrlQ0hRQpudGRd6zFpIJjeF5GWMXYND4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YIRQHKX5l4Z90d3QRqYXTTr2FYBUP8D8jniht/e1tYLAFRbtbfkEqvR0tFIaflIlphLiM3f8iDAzt8y92vhOyQcA6lfkYTB5WGivf3j+Zd5MZfTZ4ydyzWgo1A3OzeyeAWMTHFtqmy7Ieth+dIMUX5CntGbBbewR6Vus2ysIg58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=xC/AhsGg; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355085.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CD7orp007922;
	Wed, 12 Jun 2024 15:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	DKIM202306; bh=Nif5h10AV3M6Q2YnmVp8PmeGHT2QNIT0qX59Shur4c4=; b=x
	C/AhsGgjbGdZOGKcS60dYzydPWImOrXmF15UJRfi1f8rquwSRjOzYdq/n7rorDjG
	gz4+fXDt3GciYodoj+hyedxsYUyqksynfNJpgXGKoUKKQ1q8iwEe4ObaL4PHfIuA
	bTJn+CvKWLGrJ22QZ7sfToigLLnyHyuB+bowbFrGPUqtDvpL+dX6tRYb1XMRTsk9
	xWO+RcNvGC8jgIbalrY+iaFdDnFNdNjfwU42gn0WoVimisury/vvZ+YDgA9ZW8yg
	iIUOojN7EctYOiVN+7FFgARDPEBZfnFKOH6B7Cep6JIJ/yy8TPtqvCv2YSa5803e
	4BzAM0IwPB86hdMlXIUDA==
Received: from va32lpfpp03.lenovo.com ([104.232.228.23])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3yn5tffjty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 15:24:58 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp03.lenovo.com (Postfix) with ESMTPS id 4Vzq952VhBz4ygs5;
	Wed, 12 Jun 2024 15:24:57 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4Vzq950sT2z3p6jp;
	Wed, 12 Jun 2024 15:24:57 +0000 (UTC)
Date: Wed, 12 Jun 2024 10:24:56 -0500
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
Subject: [PATCH bpf-next v6 0/3] Support kCFI + BPF on arm64
Message-ID: <illfkwuxwq3adca2h4shibz2xub62kku3g2wte4sqp7xj7cwkb@ckn3qg7zxjuv>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: lc9IdRiRRKi7tGObDRgEm7AaeqVO78U7
X-Proofpoint-GUID: lc9IdRiRRKi7tGObDRgEm7AaeqVO78U7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 bulkscore=0 clxscore=1015 mlxlogscore=756 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120110

Adds CFI checks to BPF dispatchers on aarch64.

E.g.
	<bpf_dispatcher_*_func>:
	paciasp
	stp x29, x30, [sp, #-0x10]!
	mov x29, sp
	+ ldur w16, [x2, #-0x4]
	+ movk w17, #0x1881
	+ movk w17, #0xd942, lsl #16
	+ cmp w16, w17
	+ b.eq <bpf_dispatcher_*_func+0x24>
	+ brk #0x8222
	blr x2
	ldp x29, x30, [sp], #0x10
	autiasp
	ret

Changes in v5->v6
https://lore.kernel.org/all/mafwhrai2nz3u4wn4fu72kvzjm6krs57klc3qqvd2sz2mham6d@x4ukf6xqp4f4/
- Add include for cfi_types, fixing riscv compile error
- Fix authorship sign-off information

Changes in v4->v5
https://lore.kernel.org/all/wtb6czzpvtqq23t4g6hf7on257dtxzdb4fa4nuq3dtq32odmli@xoyyrtthafar/
- Fix failing BPF selftests from misplaced variable declaration

Changes in v3->v4
https://lore.kernel.org/all/fhdcjdzqdqnoehenxbipfaorseeamt3q7fbm7ghe6z5s2chif5@lrhtasolawud/
- Fix authorship attribution.

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
 arch/arm64/net/bpf_jit_comp.c   | 21 +++++++++++++++++---
 arch/riscv/kernel/cfi.c         | 35 +++------------------------------
 arch/x86/kernel/alternative.c   | 35 +++------------------------------
 include/linux/cfi_types.h       | 23 ++++++++++++++++++++++
 6 files changed, 88 insertions(+), 67 deletions(-)
 create mode 100644 arch/arm64/include/asm/cfi.h

-- 

I had one job, make it compile for riscv. Fixed. Thank you again to the
maintainers for their review.

Normally I would wait a week before submitting a new version, but with
the delays on v5, I am submitting sooner to bolster confidence.

2.43.0

