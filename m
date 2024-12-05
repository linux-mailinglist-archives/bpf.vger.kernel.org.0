Return-Path: <bpf+bounces-46140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E7B9E512A
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 10:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD83318825B2
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 09:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5C51D63C3;
	Thu,  5 Dec 2024 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="SvfL/sF6"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E7F1D5179;
	Thu,  5 Dec 2024 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390484; cv=none; b=LwKF1u2Dg0sZ9u3vHSUNmyQyEFAAHB1NJab/hMsZOsc1C7i2VVUV1s/y55pr+DEpQGS5wct6c/0BPUvZxvngzKLCVX9dROqOy6SIi0zSossUAzYSWscMDXwareOw1VmjBYrJXSs9PwiwMihNQ/ENDbOHbQpyJn0z1VEQJ/FzkxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390484; c=relaxed/simple;
	bh=qsOP8aq+4BKgNXqhMscjUMHdRrJjlpm5TslU9YrmAa0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=W0yycdHDGXW/1jj+o5zgycFm8FBX2vt4RmSjovgEDD6uv5tu5WL/Rh0dVdhEMbZThOL/ub7E0a2nhIs0EA2Q4mkydUxiiVQF9xnrbJFmWk37PsWTuuxqfhC9z4jdMhBOn1X6BGmJql778wR2UreIms/0t69sani529/I7sNmEfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=SvfL/sF6; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1733390468;
	bh=wZ9o74dxtdDPeqV/igIwQwn2t+PH3uItK3WPGvDiVnM=;
	h=From:To:Cc:Subject:Date;
	b=SvfL/sF6uYGrhiE7TwXS+3mCdIjgk8XfkMyOfkkg5BYJEF9JbLmZbnpxXQOh29vDe
	 uef2C7lab0P5w1GfDulzIqxtxI0cn7gJnjFL0jNWMmqpDjIpFdRcPYFwdyrSyra+UD
	 6IEXLGSGtfLCp04boZs0Gyi2aMOxmvp2whhWnU8k=
Received: from NUC11-F41.. ([39.156.73.10])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 2248902B; Thu, 05 Dec 2024 17:08:36 +0800
X-QQ-mid: xmsmtpt1733389716tmi4of4es
Message-ID: <tencent_410B8166C55CD2AB64BDEA8E92204619180A@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntuj07DxHonYAwENPjq4EuWHyc2G6NkcfArv9/2UF+RGgDoV3nsHZ/
	 XMjZL7AasqNrreLIKj1RD82HY/ERt2WpVIPKjUa/CyREVCTllyw6KQCDk43sNm7q1ZsISOdg5xED
	 q8ntMYxOQud6yF0Y+qDNcyTXKsGvr9GzXjgOXMIEf3uDBklyUSDMxcYzmyt38OJGqstIpOjxQ5RS
	 c6nIux1GBe1tB8b1vt4ApBrbbeVnD468cr5AkSk/LcBoIBA6TEyfAmyXkv5u3cnh+nuMbv57EKjD
	 O390n3MRgmDTgov7lhRxkWX+6eSHsItWqzt8ToNEzLjcCVYlmtsGVMx+EPBNC7geXD/je21vzvWn
	 damafsKYkiSLWNLwNVG6fDDcc9Te7F0mdfQJ8lo2IsbRvo3wSb9VB38naRTY8sk1JrCMziz2woHX
	 Up4eTcxXrS/G2UFiwh6Ch2IiT9HCvMrcehmM0zL8FqHECLh2MyHSxjD0TBedtjOfWmLfDcRpvJJs
	 bNxXA/s2GZEfADSF0/QZJABICOt9uYa6oLOfqY7ZHgMXQZMakUowelsnujSlOyio/5o5nDsdEC1E
	 W0QGnYu0GgG5CQMJCIeSZVRTeoJV21ExpnNAgVpp9+8V+hm+Lisgkamv7HGNY69l/uiITUQxllcH
	 O7Y/LZks7jyE8bV97IUslvaBMyzYldP2xEvFQy/m0EVAHzQImSSAtoz/zWw83r28RwHwS1IFN5Q9
	 Nge8qc1gdaDvJ7pH8pNPLcldbKp2f2Y3IxAB96eQWz3TI/YtTEB5kOCOO+xmYRHRFpJE4X5KcYnp
	 Rb4voynCs30iNbB+LI97MHop7wdkdGLkF4GunygRV99RWN7SJrw/N5c0WAxOiu8Cjy4OX8KSyrgB
	 wg7L6N4jri6165SXKdl23zSWSWev1ce3KP5G6fHJLi/93kvaoyqMMiI+g4OpOdRZxv3KptRPgOrp
	 PZAs/nWgrVJznDx8+J1p54n2HDZtP2
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Rong Tao <rtoax@foxmail.com>
To: rongtao@cestc.cn,
	qmo@kernel.org,
	ast@kernel.org
Cc: rtoax@foxmail.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
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
Subject: [PATCH bpf-next] bpftool: Fix gen object segfault
Date: Thu,  5 Dec 2024 17:08:34 +0800
X-OQ-MSGID: <20241205090835.248041-1-rtoax@foxmail.com>
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

    $ sudo ./bpftool gen object prog.o prog.o
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
 tools/bpf/bpftool/gen.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 5a4d3240689e..4cd135726758 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1896,6 +1896,11 @@ static int do_object(int argc, char **argv)
 	while (argc) {
 		file = GET_ARG();
 
+		if (!strcmp(file, output_file)) {
+			p_err("Input/Output file couldn't be same.");
+			goto out;
+		}
+
 		err = bpf_linker__add_file(linker, file, NULL);
 		if (err) {
 			p_err("failed to link '%s': %s (%d)", file, strerror(errno), errno);
-- 
2.47.1


