Return-Path: <bpf+bounces-31732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 338BE90287E
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 20:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30171F2246C
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 18:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E13E137747;
	Mon, 10 Jun 2024 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="Moz7MRho"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEFB15A8;
	Mon, 10 Jun 2024 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718043551; cv=none; b=qe6hCwlZCb8+arJ/28aa8ANP/S8p3CC9jAm5Mfand8iU/wm3D0H3fYNaNUU6BbTCBjP2xBMTvFUIWrAAJVDgLg7VcAF2jSD7QMuNy8V2o8VdUGH5P+1kcWo0t3kTS/6s4vw1hLvfnWF6O/EUCWo24U0fisNR2A9AvIm+4ljlePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718043551; c=relaxed/simple;
	bh=iSlArSiy4r9V/ntgrh4SI4jK9M/oixVSelyA9EMIjfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p2cjuRyc5PqV4tSahZbBqFrxAmWDAQIFUPKZiIA5Y+LZYy4jkuApiHXbJIMQSByUAGocQkJPNZ5uhlAfzlLZDTSTMr3SXEj2qm9QkEZRxC6UsxQW3AaLpEadSEPJTf8bRTaC+Utef/86R5j8OqfO/YQbK5UBaUIwH+iJPPW27Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=Moz7MRho; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355088.ppops.net [127.0.0.1])
	by m0355088.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 45AAbPfO004869;
	Mon, 10 Jun 2024 18:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	DKIM202306; bh=2Gnp3PO7oU3dzU8H0CiRDGU9SqVqHXr7nHqbHwRrpoI=; b=M
	oz7MRhosPGhg66J2FpX91d/Fd6iJDWcj9oOHohIQSaSGEFQB5hFH1O7eqTHa1rMJ
	HYr89M1Di5KgHj8v43foF1qvcVWpqhbuexZLBJDZ4EvAiEbz73T9yClI/lcPr+VZ
	7zwRRw+iVlhfmQL2in6kR5aR7+EDDLKFK0QYVKrHOyt5j+ZQ3DbAkTt1+TA7HTZk
	Ky5piOrntaVrExD8EAJTgX7bmoI1ELAPr/ypx++GArwQlPf09L5YyxHqRiiPIcvf
	mhSd3ECuulVM1VJyStjitFC1v4M5/39aks7RiUykZstBklIwzXOEe8G5jwYcXZUf
	WKAZKSe+mBWWvidaUx5IQ==
Received: from va32lpfpp03.lenovo.com ([104.232.228.23])
	by m0355088.ppops.net (PPS) with ESMTPS id 3yn4ft2b9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 18:18:45 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp03.lenovo.com (Postfix) with ESMTPS id 4Vyg6X686lz4xlJP;
	Mon, 10 Jun 2024 18:18:44 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4Vyg6X4pfQz3p6jp;
	Mon, 10 Jun 2024 18:18:44 +0000 (UTC)
Date: Mon, 10 Jun 2024 13:18:43 -0500
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
Subject: [PATCH bpf-next v5 0/3] Support kCFI + BPF on arm64
Message-ID: <mafwhrai2nz3u4wn4fu72kvzjm6krs57klc3qqvd2sz2mham6d@x4ukf6xqp4f4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: 6ZfICFZVn1vTS0dbMdV5CMaxemFOaXVN
X-Proofpoint-ORIG-GUID: 6ZfICFZVn1vTS0dbMdV5CMaxemFOaXVN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_04,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406100138

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
 arch/riscv/kernel/cfi.c         | 34 ++------------------------------
 arch/x86/kernel/alternative.c   | 35 +++------------------------------
 include/linux/cfi_types.h       | 23 ++++++++++++++++++++++
 6 files changed, 87 insertions(+), 67 deletions(-)
 create mode 100644 arch/arm64/include/asm/cfi.h

--

Sorry for the extreme delay Puranjay and other maintainers on the
submission for this. The past month I was on incident response rotation
here at Moto and my hands were full with scripting build scanning steps
and other product deployment nonsense. Better late than never, though,
if these changes have not been merged yet. (-:

Tested on a cortex-a76 qemu instance and self-tests are matching the
baseline bpf-next success rate (Summary: 509/3700 PASSED, 77 SKIPPED, 37
FAILED).

Thanks for your review and regards,
Maxwell

2.39.2


