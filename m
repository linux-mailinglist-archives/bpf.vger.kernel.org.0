Return-Path: <bpf+bounces-46230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F699E63D8
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 03:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B49282614
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 02:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420E5146580;
	Fri,  6 Dec 2024 02:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="GnE4n1SO"
X-Original-To: bpf@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878A242A8B;
	Fri,  6 Dec 2024 02:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733450568; cv=none; b=rcXudLVH2cliQ0XhyjAw4K708w+ORsqS6JE17RggyKC8xiEohbr/cetRXxP5gJWxJj0n6I6cnJG8IZH/ALVWBSpRDEH1p8ufYbjL3eq7j3GP6g5Eu9zX+HOrOCwl3BUEHAKPAmER4vPwsXtgA3xupmaZvoPu7WfPencdFCjJ4xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733450568; c=relaxed/simple;
	bh=wkGNtB0WQS3OQNqJX4OLkMPAek5RAnOPOLpgg97nqYY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bJocy+uSH3M1ZyYwLDOJK12Jvxz4RoURYNE35ThUd8523BjrjaWF80LoCMAGpS5QCHkcEnxmbYQYXLbZIWuGLVEr5f2n/5kXuStG3sZow+VmkwXHMjX0WUp5xZkj3HuLj2U2P8jz+ogCne6lc6xehu4HwFnPQnNhoa+x8gkRS7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=GnE4n1SO; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1733450563;
	bh=TRPIrWGmVaaZDiqrJ8tXhEXp75+ez3kZv2elBpARgw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GnE4n1SOTdypVa0m84BkYidOHJ808HxcRkOzupVaKP4uaw9+Q/vBHmqvfsrb36SbD
	 zvn1s84O0Wdl3pmTEJfHGnP5W9gdjWaftoaVluZb2Z+LT9su08/q4FlStnKO5SBv2s
	 k/pbrb5j4ujR/R3JWv0MRuqZZo4BDjwmkogMsfTg=
Received: from NUC11-F41.. ([39.156.73.10])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 5A21214; Fri, 06 Dec 2024 10:01:26 +0800
X-QQ-mid: xmsmtpt1733450486tynsvza0n
Message-ID: <tencent_B497E42A7CAF94A35B88EB060E42A2593408@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJ3Mini784C6Tk6iEttLsaa8NuYR/ZhgRrEZsT2Se7TSGCd3ejnl
	 RPAy6nJxnyp0Z4jMayL3RTkwAipxnPpB3z25WHhzAELY5Eh+n4Re7OhuQSQ/3B6GUmRfxrtJOWLP
	 WmdRoPJzhdfHgh+LQHpCyXOj4CBddkeO7WoUftGzqogbV0FEi3Oak/Mm+KdXORH/Gw3ApXJpYAUM
	 hO9x8tV8iLgbAOKo2HsnFWHINyG9wydkMcngyH7cAG3FVgv8oMlszBcV2MRxnc3zY1rM7QxR+c0A
	 Pm8u+ZhdXED1t8UloQ+9oYR0XZvcIYnsiLg5HHcQxa2g4eJO10FccEOPktsknQlFCSDiT/1/vNbF
	 3zdWGAN0Z9GMcOBD+k3GaGZN8pidNpf0uuSbeJm29ghFtx1KkHdfzNjM7M5mfZvGvjUqJBEGynGH
	 YG8rcZpxcl0BAkVgJHZdqappLgTzOsNJv40riwhJc0E341vkmQDPbAxKHF4V9KpbgTLDwtwHjgo0
	 Bj9IaiZ2IqDS9fTR/iJ7TmEiTpzg3hSNIr9E0StQ+w+rZQasqjWL49b/uXrDo8VEAlNAX4d/mcUY
	 D0NUylXNLD5xR6TMKOvwB08GOa/EE1Xhek+t+xd4Ma99efO7DBX01CskL6/Tqkux7FNSdnzKKax7
	 VYFZeDQO2S5r5EAEcsQZkA0d0SkctEMcZmGsej/1w4QsbF5eQl80NK/M3UGcG3gsGtAoYJGC/vEK
	 VJ4BRZ8O7gY1JpEOgDjzu/Qw69DNt3fXCOlmMsW14zHyznmf1ugLrHsqUJytrJU49ZlMPZsuCxKo
	 3gZa+VcI9sW3YuTOU9RkEAdnODvOc0cxm2SibGDx9Dfbf9EO65OK/VGA9a9thJ23AFVsiG2xMuty
	 ZecpKjjphbslCMV7J+tgJPVNkyVkewnCqx8fVbV5Du0LCKBg6B20y9MiNUdWU9cAd/Cp/h4e9mRg
	 6uxHccz3s5AMjiNis4SAlp9BmeMe2iura/1v3RUOtlMcrvolLvcw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Rong Tao <rtoax@foxmail.com>
To: andrii.nakryiko@gmail.com,
	qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	rongtao@cestc.cn
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [TOOLING] (bpftool)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next v4 1/2] bpftool: Fix gen object segfault
Date: Fri,  6 Dec 2024 10:01:24 +0800
X-OQ-MSGID: <128433fc5276c75f491b9dcdfdd80c0058b69645.1733449395.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733449395.git.rongtao@cestc.cn>
References: <cover.1733449395.git.rongtao@cestc.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

If the input file and output file are the same, the input file is cleared
due to opening, resulting in a NULL pointer access by libbpf.

    $ bpftool gen object prog.o prog.o
    libbpf: failed to get ELF header for prog.o: invalid `Elf' handle
    Segmentation fault

    (gdb) bt
    #0  0x0000000000450285 in linker_append_elf_syms (linker=0x4feda0, obj=0x7fffffffe100) at linker.c:1296
    #1  bpf_linker__add_file (linker=0x4feda0, filename=<optimized out>, opts=<optimized out>) at linker.c:453
    #2  0x000000000040c235 in do_object ()
    #3  0x00000000004021d7 in main ()
    (gdb) frame 0
    #0  0x0000000000450285 in linker_append_elf_syms (linker=0x4feda0, obj=0x7fffffffe100) at linker.c:1296
    1296		Elf64_Sym *sym = symtab->data->d_buf;

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/bpf/bpftool/gen.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 5a4d3240689e..e5e3e8705cc7 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1879,6 +1879,8 @@ static int do_object(int argc, char **argv)
 	struct bpf_linker *linker;
 	const char *output_file, *file;
 	int err = 0;
+	int argc_cpy;
+	char **argv_cpy;
 
 	if (!REQ_ARGS(2)) {
 		usage();
@@ -1887,6 +1889,17 @@ static int do_object(int argc, char **argv)
 
 	output_file = GET_ARG();
 
+	argc_cpy = argc;
+	argv_cpy = argv;
+
+	/* Ensure we don't overwrite any input file */
+	while (argc_cpy--) {
+		if (!strcmp(output_file, *argv_cpy++)) {
+			p_err("Input and output files cannot be the same");
+			goto out;
+		}
+	}
+
 	linker = bpf_linker__new(output_file, NULL);
 	if (!linker) {
 		p_err("failed to create BPF linker instance");
-- 
2.47.1


