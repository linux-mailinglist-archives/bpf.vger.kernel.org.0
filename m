Return-Path: <bpf+bounces-31740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00360902965
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 21:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E428281773
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 19:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A5B14D45A;
	Mon, 10 Jun 2024 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="gPqWTyCL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD5C2230F;
	Mon, 10 Jun 2024 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718048095; cv=none; b=eoNpzWaJpPUSV2L/w1edUJmGEzF2XCIeVuUqHqSarNI/gqv+yZtfyLlZOOZECmEo1Ov/Jl9pHhja1DPlhnXDO7su8nfhr5esGXzN7nu7C55jch46Z8YtWXMHOAtn6DIeijNhP/0OKhVII1PY3ZtCwDYKsm5Rs7xDPEEg5HtaAI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718048095; c=relaxed/simple;
	bh=iSlArSiy4r9V/ntgrh4SI4jK9M/oixVSelyA9EMIjfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i18shE8UW+8Eu2cTt3TXhkwRIXCqa1EqGwQUcAFRgrur7owmwdUIXp6x/S0rCTW7AOEKOwtopvzPSraIdiaWiYcnIcohvHsZIO2Ky+E6ONNOxOKkf8KRrbfpGkoGAC6qZxyZU5UUDMQzqEKeM4KV245DRQ8n0oW2rBeFKujQBtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=gPqWTyCL; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355087.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ABZrwt014133;
	Mon, 10 Jun 2024 18:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	DKIM202306; bh=2Gnp3PO7oU3dzU8H0CiRDGU9SqVqHXr7nHqbHwRrpoI=; b=g
	PqWTyCL08I1N1ID/+RSvgaTdHLhCFmZrFRumuHAWaXMs5xfa16+338NCZVNm+KHb
	DjGeQ68GayAEF4bQHJeTAMBTf6bbhjwiORLA8/MpXRycRk7rc5t3rgCaFiOI2e1I
	LCaw8Q28thG5bjACawtrE0oHoIeMwqPEyDgn0M2TR6D3fVo4Oc0kOfElIqEeaJnv
	stQuTB1zOY0doh15A5tCYUKf2uuD8g4I44+pGonMyPZ08VSTguPQHeQX9XrxoPEH
	zJcwz9SpZ5X/rDtbv1CxSnwZu9V5iUe1F8DRVIfxodzMUPiHFoAeQniJW+r2uMi0
	joDM2Omegj6pLM4hhZUbw==
Received: from va32lpfpp03.lenovo.com ([104.232.228.23])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3yn45gt5mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 18:05:04 +0000 (GMT)
Received: from va32lmmrp01.lenovo.com (va32lmmrp01.mot.com [10.62.177.113])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp03.lenovo.com (Postfix) with ESMTPS id 4Vyfpl4n6rz4xlJn;
	Mon, 10 Jun 2024 18:05:03 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp01.lenovo.com (Postfix) with ESMTPSA id 4Vyfpl0VB7z2VZRs;
	Mon, 10 Jun 2024 18:05:03 +0000 (UTC)
Date: Mon, 10 Jun 2024 13:05:01 -0500
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
X-Proofpoint-ORIG-GUID: yExqa3DDXgG_6TxFLeimNwxPhcMuFVJh
X-Proofpoint-GUID: yExqa3DDXgG_6TxFLeimNwxPhcMuFVJh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_04,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1011 mlxlogscore=999
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406100136

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


