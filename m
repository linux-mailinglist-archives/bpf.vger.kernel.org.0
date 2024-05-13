Return-Path: <bpf+bounces-29641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279048C42DC
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 16:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21B62814CD
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 14:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB5F153818;
	Mon, 13 May 2024 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="Fi2QihlK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AAE50279;
	Mon, 13 May 2024 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609379; cv=none; b=NN0J1RYtdTfhTo+cbZCGfV5nmH9byoyc7f2B60t79FPoT+Kc/Y9tZErD/OznRVLI3pHjCna6II6jTMw6j+gAAIlO2e8RqEQ6c6Rzk0gRMu7LDdulL4mFZpbwuf8cUzyUoGhA66F4QbUu6IGWyadALtvg2sm/0x7DJCWA/CcJCTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609379; c=relaxed/simple;
	bh=FAfkXAwyjCo/QZMau5q8n1Mc9IC9NRMCuqxd0zsLphs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qxst9cVJLYxzx62Zf8kSbM+oIV29TeW9f8tfiQCrSUhutZtZv9Dp5hgrTimfiCFc4pYV9ARuFZURZcyHkmeoB1y99V9RL2YtBCocNcJ38kzBmRQwqTALZzVaEDeHVnvbwZe4yFpiUecJg5Q+ZuEI+a7GWLVbPzmsiThK/o7dqMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=Fi2QihlK; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355092.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DBvq9a025305;
	Mon, 13 May 2024 14:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	date:from:to:cc:subject:message-id:mime-version:content-type; s=
	DKIM202306; bh=/Pslq7UGfJig0rYvVspeuOhidIHs7ghS/8dTl5NO4KI=; b=F
	i2QihlKnLCPsYrzL7yGGg3CowRYvNN8yahEZByVxoeIbC7mV/uu4K9+gg3vDLEcC
	Qww4/HykhM1oxiM4Li2TSRdF5wh4YFfAL7abY9pGizw5sIAM4eazYJpH5CsglbcX
	XZXY5AMA7IcIzA+1TgPAJe8NmBPyN8MZRdz4KLzCk0Z6iMu2QI/QPGc+RIfX0I5y
	dQFBZ3Rt6+U4W8r2q/qm+wH3oGYsc11Q9M7Fs6ng6HzQxgN7ZIVe4Rb2gB6Cj9mR
	1XO7XrE0opzFzd2VORDf1/jeUnjy7YgqNKePoOhnmBsid6boZAUqDBa7LBhqXjUz
	RIqRFDp00ffDi/awxcPYQ==
Received: from va32lpfpp04.lenovo.com ([104.232.228.24])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3y3d7ps0xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 14:08:47 +0000 (GMT)
Received: from ilclmmrp01.lenovo.com (ilclmmrp01.mot.com [100.65.83.165])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp04.lenovo.com (Postfix) with ESMTPS id 4VdLv31TGxzg1bp;
	Mon, 13 May 2024 14:08:47 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp01.lenovo.com (Postfix) with ESMTPSA id 4VdLv26mbvz3nd87;
	Mon, 13 May 2024 14:08:46 +0000 (UTC)
Date: Mon, 13 May 2024 09:08:45 -0500
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
Subject: [PATCH bpf-next v4 0/3]  Support kCFI + BPF on arm64
Message-ID: <wtb6czzpvtqq23t4g6hf7on257dtxzdb4fa4nuq3dtq32odmli@xoyyrtthafar>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: vkgeap01RG7LlgWIsm2nTryLwdxI0CEw
X-Proofpoint-GUID: vkgeap01RG7LlgWIsm2nTryLwdxI0CEw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_10,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 impostorscore=0 clxscore=1015 mlxlogscore=400
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405130089

For the BPF summit meeting tomorrow, I might as well have a mergable
version. I took a look back on BPF-CFI patches to check the status and
found that there had been no updates for around a month, so I went ahead
and made the fixes suggested in v2.

E.g.
ffff80008021d5a4 <reuseport_array_lookup_elem>:   
ffff80008021d5a4: d503245f      bti     c         

Potentially this should be replaced by a proper paciasp + autiasp, but I
suppose if we can assume the verifier provides back-edge integrity.

Changes in v3->v4
https://lore.kernel.org/all/fhdcjdzqdqnoehenxbipfaorseeamt3q7fbm7ghe6z5s2chif5@lrhtasolawud/
- Fix authorship attribution

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



