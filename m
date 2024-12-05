Return-Path: <bpf+bounces-46160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38EB9E550B
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 13:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADDC286A6C
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 12:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CA8217F31;
	Thu,  5 Dec 2024 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ClVuixGX"
X-Original-To: bpf@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A51865EB;
	Thu,  5 Dec 2024 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400559; cv=none; b=d5cPuaywYhO8d3HzWKhmsmHZ7fT8peJf9WD94FTTWlkdoQJU/JCHhvvHxr4tttRWxWn5ocGM9aztmj4y03vRPIT9lLzm3oPJWyoNrc5mKUgv5JkW6CnPrPHad853VWNTii4t1klnBsaTJB11KOJno4zzvWqp26XgNxyaGtVWAtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400559; c=relaxed/simple;
	bh=XztYH+cgYnKfDgYZq1P+8+QN2V5rVPrVgnapNtYaZZk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=gJbibuSVz4LFNMh1wNnKNrCIjxOV4nPi2yX3cfCkhkvCQ6jhbBN+iTIEC8LR0NejgzINQPhjb0Mn62jxKZFBUSkcI7fhm9/+MUfsHwwaWEglPazxTmvJiiuo0J4C2aOve2b2wgtBEhSo2IB1ya1HG+NHugH7l49OMZU8tbsevVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ClVuixGX; arc=none smtp.client-ip=43.163.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1733400552;
	bh=mlGhZqwkmrQ/Ts0isdmhYpIn2D1BQmWEXIWO5s7bnWw=;
	h=From:To:Cc:Subject:Date;
	b=ClVuixGXXOxxGJ6fvf8t4NRdp0SRrGEqew+EWBE5YvLoJ9/ATpULxJMB9Jh8Jb7GC
	 OHz9w4tQGjPsX7vBvjVBmMZM/2OWmnwAZnDbOrWhHjtHxFolOqY0MwgJUhrfNLDz8m
	 BjV9p1AfOxTkkgt+36HdRN8R8bRJ1jfT9o89lBn8=
Received: from NUC11-F41.. ([39.156.73.10])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 248A54BA; Thu, 05 Dec 2024 20:09:08 +0800
X-QQ-mid: xmsmtpt1733400548t234wh7yd
Message-ID: <tencent_A7A870BF168D6A21BA193408D5645D5D920A@qq.com>
X-QQ-XMAILINFO: NSObNE1Kae7ZUcUS5HLVc9zndADhH79CgWR8Sj4LsQN9WfgdnMi6FDCSxlX4Ys
	 l37dH+6wFOLV3WMRuoJAe7neqDMd+VkZi0tAuCf45Hp8RaCo1ftvy8Drf+rCXolqvCbuCQ0/i2FQ
	 Jy5TwxmvBu5grmNJFDaASqHCtnTb934BRUiHwAxPEGlALpxMAvbs/7CGNSfSFWzG8ocec74yzFAD
	 XKECCHZpg/6HgH6CpX1BzuU1j7MfrryhJ+Sz3MhVt4l0UUA22AkUX4UMU7nPjk27VnKQaIUJ4qIE
	 iL/kHRRi5cluXJKikMtJanvalYAn1N6OAMuxDG7GBJRo6nvflrzRB/vASv+X3iN0m8w4blWujN6N
	 H+9hQpgpm0TyqLDmonbjy1uY4mF0fhAsX5dXHPsWZl1dzDrXrEnt1/vHU0JHtOUewcob0mV1KVhw
	 qokDGTK6XsHiqRE/BhVIx3e64cjemtIJg1L2sHAc9iNm8d77cd9bqqBjiMJeOqWpREgxgTZdm6Jq
	 tFvTRzwkp/bDSicWZNlpZopNTi3p9iaCru0JLJ0HV/SWHnIwCDAtOuj5tGQkimoni1Bbk0n8rLIC
	 FLbxwv5eoP4mZUGSPec98ge7KUIIfu3bGAZlN3/gQwqPNyDSozTTylvYwi0SrV38pod0chQD5GVe
	 zbif9hG2ecjOxZeUx0acxZXuudCina5lfZts1gc2+IsOiwJj34Xksp4qykoBDEYjx/iwzsSz10DV
	 xcXMpY6jMCM7fojGNBH+vZXIk2z/i7o2GO871m/h1ykx91KIUrpKv2f2l6/TIcOfWz78idcT/CGe
	 ZvsxtAzmPirMBacvDNa8d9VzjjxCiuA1WnIUK08wQQvej1I2Kf/8V9r/fbdq87oLnMYZYnaQTQ9X
	 NsUC/wsLDjvc+hJgH88nNOG9OuNRii0FMQuwCRRH+j+d44nY04ejl8Hpw4RNC6naBhI3xFRlDFj+
	 bAkIWx2oGtgtyhY7Vnqv91IixGkHrNiabzwTYgmSU=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
Subject: [PATCH bpf-next v3] bpftool: Fix gen object segfault
Date: Thu,  5 Dec 2024 20:09:03 +0800
X-OQ-MSGID: <20241205120903.324194-1-rtoax@foxmail.com>
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
v2: https://lore.kernel.org/lkml/tencent_F62A51AFF6A38188D70664421F5934974008@qq.com/
v1: https://lore.kernel.org/lkml/tencent_410B8166C55CD2AB64BDEA8E92204619180A@qq.com/
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


