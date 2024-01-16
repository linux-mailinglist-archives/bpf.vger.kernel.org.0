Return-Path: <bpf+bounces-19671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C2782FA8A
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 22:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DFE28B6DC
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 21:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A576157884;
	Tue, 16 Jan 2024 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7gXedWl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8356A15705A;
	Tue, 16 Jan 2024 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435195; cv=none; b=hww6w+AjteQU18nyLuBmsJRTp4bT8JC+fQ+c7WyFyignbhwC2wQo+AMkdjrrbCCw850S6a0Ntb/jBxyuOx28WNgGc91NKJetg5fVbgAejmX+Sd00ilnYnL/tq9br87W7Zs3K9TYbq2QWVGFDC3j8ou1Ejex+eL0J0zrVy+LeQ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435195; c=relaxed/simple;
	bh=bMV+Mknuey4DGbeGPW6uw/5Bx7q6eaBdAV2ch1vVZxA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=ntKp011iShAEVmkjcZWK8mQ9fYqVCT8DirfzDaJ4KZJ0TDSSic+SiXV/716GeEnloC0CN9SdaeoLMGUiLcEb2owqF0KLGjHiq8JIQToW45tAClR2LztsF2W2uNLR17lfiO/HXX6p20Gs8Dc5+/b469+ozYViaF2fyITwn66XV+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7gXedWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E861BC43394;
	Tue, 16 Jan 2024 19:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435195;
	bh=bMV+Mknuey4DGbeGPW6uw/5Bx7q6eaBdAV2ch1vVZxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q7gXedWlb5L6z2ZowrovDUgP96dREA1A9h1x/ypNYGrCLVazbpRMsBG+Y/oAPyS1Y
	 pB6t/KdxdtkforiP9dd00toHkNHZ7wR6pgLPwkiGVWTNfjhC82CemsPpLhk4kKXszh
	 crweG+izflGIKVgJ6BiHc84w+nLsKA6DyLRK9nFsC5Ok7FI9RpblHzKUX1eqmtnTmX
	 2JhbFh4j0SuSjedC2VOTUSmFGTNiz/q+ROltNicco2UmXpetAMeEpgPTcWBdBD39OW
	 EV1O4jgrkpDuMREhJt3WkLCX48VVWAnTQJC8xzrKO8Q8u+hCqQaRHsvfiFDnCoi3uV
	 ADTXcJ8SbrU0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mingyi Zhang <zhangmingyi5@huawei.com>,
	Xin Liu <liuxin350@huawei.com>,
	Changye Wu <wuchangye@huawei.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 39/47] libbpf: Fix NULL pointer dereference in bpf_object__collect_prog_relos
Date: Tue, 16 Jan 2024 14:57:42 -0500
Message-ID: <20240116195834.257313-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Mingyi Zhang <zhangmingyi5@huawei.com>

[ Upstream commit fc3a5534e2a8855427403113cbeb54af5837bbe0 ]

An issue occurred while reading an ELF file in libbpf.c during fuzzing:

	Program received signal SIGSEGV, Segmentation fault.
	0x0000000000958e97 in bpf_object.collect_prog_relos () at libbpf.c:4206
	4206 in libbpf.c
	(gdb) bt
	#0 0x0000000000958e97 in bpf_object.collect_prog_relos () at libbpf.c:4206
	#1 0x000000000094f9d6 in bpf_object.collect_relos () at libbpf.c:6706
	#2 0x000000000092bef3 in bpf_object_open () at libbpf.c:7437
	#3 0x000000000092c046 in bpf_object.open_mem () at libbpf.c:7497
	#4 0x0000000000924afa in LLVMFuzzerTestOneInput () at fuzz/bpf-object-fuzzer.c:16
	#5 0x000000000060be11 in testblitz_engine::fuzzer::Fuzzer::run_one ()
	#6 0x000000000087ad92 in tracing::span::Span::in_scope ()
	#7 0x00000000006078aa in testblitz_engine::fuzzer::util::walkdir ()
	#8 0x00000000005f3217 in testblitz_engine::entrypoint::main::{{closure}} ()
	#9 0x00000000005f2601 in main ()
	(gdb)

scn_data was null at this code(tools/lib/bpf/src/libbpf.c):

	if (rel->r_offset % BPF_INSN_SZ || rel->r_offset >= scn_data->d_size) {

The scn_data is derived from the code above:

	scn = elf_sec_by_idx(obj, sec_idx);
	scn_data = elf_sec_data(obj, scn);

	relo_sec_name = elf_sec_str(obj, shdr->sh_name);
	sec_name = elf_sec_name(obj, scn);
	if (!relo_sec_name || !sec_name)// don't check whether scn_data is NULL
		return -EINVAL;

In certain special scenarios, such as reading a malformed ELF file,
it is possible that scn_data may be a null pointer

Signed-off-by: Mingyi Zhang <zhangmingyi5@huawei.com>
Signed-off-by: Xin Liu <liuxin350@huawei.com>
Signed-off-by: Changye Wu <wuchangye@huawei.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20231221033947.154564-1-liuxin350@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f87a15bbf53b..0c201f07d8ae 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3803,6 +3803,8 @@ bpf_object__collect_prog_relos(struct bpf_object *obj, GElf_Shdr *shdr, Elf_Data
 
 	scn = elf_sec_by_idx(obj, sec_idx);
 	scn_data = elf_sec_data(obj, scn);
+	if (!scn_data)
+		return -LIBBPF_ERRNO__FORMAT;
 
 	relo_sec_name = elf_sec_str(obj, shdr->sh_name);
 	sec_name = elf_sec_name(obj, scn);
-- 
2.43.0


