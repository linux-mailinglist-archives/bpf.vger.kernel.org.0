Return-Path: <bpf+bounces-32313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 883AF90B654
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 18:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10AA1C22F21
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 16:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791F014EC61;
	Mon, 17 Jun 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="SOrWozwy"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6851C6B5;
	Mon, 17 Jun 2024 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641681; cv=none; b=KUd/Z5AZFaOIi/cNoYGpw9+ZsU6xUGa8c2tyZfEKCi89kr0Dpuk7iKccgIvqn/nq6JdbRZVBYxwGScsAgBQ31BRCRIhYmwhBzKc04Yn5izCcbT7kwVfRWcSuf+qQz/B5TbVYYkIwlNdf1vfTkj0/YOLgdEEidBTvlwdu8nVDqC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641681; c=relaxed/simple;
	bh=MHbKouY4wdIM9d99e7Kv3wboV638BbknoChmKsnFmLM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Zgptm8uXqWzUc8RtXr1CEQ6Z/CJaOWYNCp1HGO2TNhm1zv2VW8vgdhbp369lmsQgqYxj7E+STNFZe86HPqlq8Fj3eMo94T7mz7kqYYsk15GEr6MqplUSJMmT0T/Os00s0dKIF0T3VwsdTYXGy/qXZNUN0zi7+0WGSWRGIFL+Ek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=SOrWozwy; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355091.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HBbXS8023300;
	Mon, 17 Jun 2024 16:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	DKIM202306; bh=YluCWb0ojQ+sLHWHo/Wdxu6CuCEISS/qXFHRcH7Ut98=; b=S
	OrWozwyW640x7ssxlxdrTsV0yJLlmqlrfPf2TkSqlSxcZbPA097fUWgWJ5meSRP5
	1BJz+lIjnCtF3wROzfQXM1nmqEn6I5jxr2BkIK0FtiemPgjbB1OGggoTXahR2Kon
	7ryzkoQDQ0cu9U6Td+yuvgiyfZ75aL2jbrEE0Xu9XIzu1iqBQKuMLltSeUkAUbrq
	m9cRLuCcm84al5g4Z+v3xA9OV+JFmSpyAkWQBw8RvzwMuXIgeE5XSsHygoxUf+83
	d4ooCCfbAvtbp/nidLF0wx6/7kADHUfK9znJ911h7tHaLxVQmAPDlFexws2JwNCi
	Jw7YFMOTb8ZYx7cTD/wRw==
Received: from va32lpfpp02.lenovo.com ([104.232.228.22])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3ysr2gjvh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 16:27:19 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp02.lenovo.com (Postfix) with ESMTPS id 4W2wJk6ffZz50DhP;
	Mon, 17 Jun 2024 16:27:18 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4W2wJk5Bvkz3p6jp;
	Mon, 17 Jun 2024 16:27:18 +0000 (UTC)
Date: Mon, 17 Jun 2024 11:27:17 -0500
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
Subject: [PATCH bpf-next v7 0/2] Support kCFI + BPF on arm64
Message-ID: <ptrugmna4xb5o5lo4xislf4rlz7avdmd4pfho5fjwtjj7v422u@iqrwfrbwuxrq>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: DCrRkzBGYObmSj7eeOhAY7az4W0sahWh
X-Proofpoint-ORIG-GUID: DCrRkzBGYObmSj7eeOhAY7az4W0sahWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 mlxlogscore=814 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170127

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

Changes in v6->v7
https://lore.kernel.org/all/illfkwuxwq3adca2h4shibz2xub62kku3g2wte4sqp7xj7cwkb@ckn3qg7zxjuv/
- Squash one of the commits to avoid code churn

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
2.43.0


