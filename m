Return-Path: <bpf+bounces-19533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1CE82D98E
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 14:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A1A1F221DC
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 13:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94FE171A3;
	Mon, 15 Jan 2024 13:09:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1868168B7;
	Mon, 15 Jan 2024 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TDBrS6l0YzWmc4;
	Mon, 15 Jan 2024 20:52:56 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id CF9FB180017;
	Mon, 15 Jan 2024 20:53:55 +0800 (CST)
Received: from ultra.huawei.com (10.90.53.71) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Mon, 15 Jan 2024 20:53:54 +0800
From: Pu Lehui <pulehui@huawei.com>
To: <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<netdev@vger.kernel.org>
CC: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Luke
 Nelson <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
	<pulehui@huaweicloud.com>
Subject: [PATCH bpf-next v3 0/6] Zbb support and code simplification for RV64 JIT
Date: Mon, 15 Jan 2024 12:54:21 +0000
Message-ID: <20240115125427.2914015-1-pulehui@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100009.china.huawei.com (7.221.188.135)

Add Zbb support [0] to optimize code size and performance of RV64 JIT.
Meanwhile, adjust the code for unification and simplification. Tests
test_bpf.ko and test_verifier have passed, as well as the relative
testcases of test_progs*.

Link: https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/bitmanip-1.0.0-38-g865e7a7.pdf [0]

v3:
- Change to early-exit code style and make code more explicit.

v2:
https://lore.kernel.org/bpf/20230919035839.3297328-1-pulehui@huaweicloud.com
- Add runtime detection for Zbb instructions.
- Correct formatting issues detected by checkpatch.

v1:
https://lore.kernel.org/bpf/20230913153413.1446068-1-pulehui@huaweicloud.com


Pu Lehui (6):
  riscv, bpf: Unify 32-bit sign-extension to emit_sextw
  riscv, bpf: Unify 32-bit zero-extension to emit_zextw
  riscv, bpf: Simplify sext and zext logics in branch instructions
  riscv, bpf: Add necessary Zbb instructions
  riscv, bpf: Optimize sign-extention mov insns with Zbb support
  riscv, bpf: Optimize bswap insns with Zbb support

 arch/riscv/net/bpf_jit.h        | 134 ++++++++++++++++++++
 arch/riscv/net/bpf_jit_comp64.c | 210 +++++++++++---------------------
 2 files changed, 205 insertions(+), 139 deletions(-)

-- 
2.34.1


