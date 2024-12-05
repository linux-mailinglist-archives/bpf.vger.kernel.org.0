Return-Path: <bpf+bounces-46155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650339E53D6
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 12:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29F42865A8
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 11:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF658207E14;
	Thu,  5 Dec 2024 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="TzuCPCUr"
X-Original-To: bpf@vger.kernel.org
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03071F668E;
	Thu,  5 Dec 2024 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397820; cv=none; b=h7ZPsKjw8BgLW4Rc4TLiJiTdNiMBGnf2AQ7SaQGDQcV/6pbr/hOaTX5HYdIsbLQqHBYZnFLgQXjBbh+/Yr1n4PXzFHV7iQV+KG4TYfPQnCt8hKU1IDUNyD3xLQPY1p+wShpoF+aqJgDzM6RUCxCBHJibn7ZwzleMByLt5Ij+iSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397820; c=relaxed/simple;
	bh=ljlY1k2q+/fI6CNwKjeSaqRz8l+fZjDVuE0tsdt1VjQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=nkCiWtCVZdp9DkoyrzhkdMXqCgY94FSo9hLXxebAnNH9RJbTO9ASJku8AdxOLDtZJ+rKPjZ1HUubSPPZGg2w2PyP+ZXNG3XeJ0RhdqAxE/2fT1U+c4tgZU1OF09sEVVGi1cHTnHC2Yi1M1w5cZdJleyuptlti0cofR2X3QA7/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=TzuCPCUr; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1733397808;
	bh=CWlEUFJ9FSB6B95LIRTbSG1ozUjX+vZQxlDLRuOMo8c=;
	h=From:To:Cc:Subject:Date;
	b=TzuCPCUrfQybGa53hGLcCPm+CKT46VdrKjcI3WFNy8Jtc3i98nZCK8iEyg51IIlrm
	 6efJYdYK+sqjwXgMnFz2UDZ5BXB4tNNl9/vI6Vkh0LClJHkNrg8JGRuLITfLWjbuUd
	 cDxbAcOapNxyw9Hv5FQ5hGrm6Loedio4ajdCTXbw=
Received: from NUC11-F41.. ([39.156.73.10])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 2B13D4E0; Thu, 05 Dec 2024 19:10:49 +0800
X-QQ-mid: xmsmtpt1733397049ts0bwkeoh
Message-ID: <tencent_F62A51AFF6A38188D70664421F5934974008@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70mzeAOdqisJZc4qoxlPnWZNFd2f5QhD8shWaBqSNIuRhBFcf9n1
	 DFvucvxiS3L1heCnwq/eqHSIs3+kKMrr58fpj/Pcmqhig/2/S21JIbSfguzD3jAqYzWDoRPcCB02
	 c79cobqbFI7aJy9aQbynAgz9BsxDGeAn992BujD9X9VSotZl7DPB2B7KyY0qp3avUd2nEUHcgBDt
	 FD4iytXR3kO9pL9wgMR44RpuUyGQpccYTcKK7R99UkuqmqMN1vDY6VnJZNzlWzU8vQDYmuWqjVQw
	 7XRDjE8WzWFlmnVWWNWv436q+z0c2jFbOIS9gH7iHexXYX8IDzWS/SYZXUWJp3/PdtR/Iw1B9/QL
	 1IVkEs4bdlpddwwjocE7I3Vh2ckG9WVyouimCVIiiPVek9MpvxL6QUqVXRS6D9VeXp3k6GR3CzlU
	 zyI3zF2bWJ1dLaYKTmX87lsyINjTS/hcs/+ih3iJ7pR7N2WwxI71hMGtftAKvIezFQEpyKPrpy3I
	 E8VPGvRksNWOpwVNvXUb1Temc0vHGPUe6f58jLHvxB86bDp826ufOwaHRPUJTMpcT9i0hVjEP/0x
	 vObvTmQGvboOZ9Hy2zEz2KaligV9TGW/s69y186xj6zUZXtTdp/mR+/CXUTbQdhuVwFOQir82RGp
	 jnKO09icfNXWsqDdmbEf7Iis0o2HD0MUcGiPMndsziPFh9O/qFI2HTiAMsOZLkWcDN3nFIuW0vqe
	 SI3cxe8nD/gjoc0PrlLnxsucUc4PO8dJ6xF/zig5/0amy9oGxs8+4zBJyyp040YC6nZqXi74znKl
	 WNyTaZr3Ezap+PZqbdHDUaiP3X05rR7ZAw1yUnytUalgM920Th94qKsBYq3hawS5eO+AXmYNGJWZ
	 dDk34PWR9MtfmSeG5ULW/DDd4ZYSvtLP8m4uaAWCnJ1cQ89FL1v9Lyk1auK22DXsrBbZPjO/yR4z
	 x/0I+mZyLBJyvoj0rRbSaEnFudpeFe
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Rong Tao <rtoax@foxmail.com>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	rongtao@cestc.cn
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
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
Subject: [PATCH bpf-next v2] bpftool: Fix gen object segfault
Date: Thu,  5 Dec 2024 19:10:35 +0800
X-OQ-MSGID: <20241205111036.278172-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.47.1
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
v1: https://lore.kernel.org/lkml/tencent_410B8166C55CD2AB64BDEA8E92204619180A@qq.com/
---
 tools/bpf/bpftool/gen.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 5a4d3240689e..506d205138db 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1879,6 +1879,8 @@ static int do_object(int argc, char **argv)
 	struct bpf_linker *linker;
 	const char *output_file, *file;
 	int err = 0;
+	int argc_cpy = argc;
+	char **argv_cpy = argv;
 
 	if (!REQ_ARGS(2)) {
 		usage();
@@ -1887,6 +1889,14 @@ static int do_object(int argc, char **argv)
 
 	output_file = GET_ARG();
 
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


