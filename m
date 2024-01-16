Return-Path: <bpf+bounces-19678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0B582FB2A
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 22:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2482B26572
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 21:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F35316159B;
	Tue, 16 Jan 2024 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raJ01tAN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B3A16158C;
	Tue, 16 Jan 2024 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435341; cv=none; b=RDnmx5xZz9NYoDTlmP6AIuyk6+nbuWsHvfwQ9PzRU9H2tTz7tWwGFHGpmYwaGOzf7AunPHwwjDhGFx1580DwV2fO4pMYGTaq7dJtC79c105Mh8gYJSMNRR2sgrOcWGGJd+IU4Skb/8mq7ASI1e4j9FcRfNcFGmF+2rZ5Trg8uEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435341; c=relaxed/simple;
	bh=aFF4onUYBjyhL4uqBhwQ6C5AcbXlCbw6n+8MO+6DstQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=PrvyayiD5sYbf3V5IjcfA+DP0VOMEnZfW3baO6qYV9cVNAL1nr6ymNc0aLsDo7SXQ+flWpAa0hdmLg7XIN68EWGxGi8W5pNHA2ENZPbJWF8N9EJsxrEP62DWSK48ZKaiGBVd6gkMZGt896cIL8iIKtGYG5+1/lcxrQvegJPBid0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raJ01tAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F65C433C7;
	Tue, 16 Jan 2024 20:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435341;
	bh=aFF4onUYBjyhL4uqBhwQ6C5AcbXlCbw6n+8MO+6DstQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=raJ01tAN2KuuF+vKXX99P0qUaDrdrPb3u//dCBMtQ0yns4wyaL1pSI+ILs8N4XwRp
	 bEh01YsqJOj2O9BTpNCPi+umnMI8mo0PgDNt7jEKzHR6HwHFMzh/g4aDA9J9QASDtf
	 E2N0EXb+gNoqQtRCSmwnAuIOuvNYg6IroLtcBCMkyoUm0KKYQaWiaLvMq0H5MWucRJ
	 LjcBuV91tdx2VY+5elzzBGrNFp+WepdlJd58MQD+SC2Jj0apZX9IZ7T4dZznD+8uHI
	 nfVbXNeyXv7xmfwgUDwTJvpNMWWhqLJ/EmNK97YxOEiIRyv4WbBbrT2PPeqNu0mTKF
	 /1ogE96zKqXVg==
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
Subject: [PATCH AUTOSEL 5.10 38/44] libbpf: Fix NULL pointer dereference in bpf_object__collect_prog_relos
Date: Tue, 16 Jan 2024 15:00:07 -0500
Message-ID: <20240116200044.258335-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 015ed8253f73..0cbb1b43065f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3514,6 +3514,8 @@ bpf_object__collect_prog_relos(struct bpf_object *obj, GElf_Shdr *shdr, Elf_Data
 	__u32 insn_idx;
 	GElf_Sym sym;
 	GElf_Rel rel;
+	if (!scn_data)
+		return -LIBBPF_ERRNO__FORMAT;
 
 	relo_sec_name = elf_sec_str(obj, shdr->sh_name);
 	sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
-- 
2.43.0


