Return-Path: <bpf+bounces-46229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAFD9E63D6
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 03:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD2C16A115
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 02:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47799146017;
	Fri,  6 Dec 2024 02:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="fVLmBoKP"
X-Original-To: bpf@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8241428684;
	Fri,  6 Dec 2024 02:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733450520; cv=none; b=stUgiT5WWRXGHXRUAeius1i2PlsdLP75FytkGPzaUWV3PeD4CJBxoIlf0zUKyDBip5Gn0cr8T8Gy7RwvyKNWagfi4uiM3+6gajZEWQi+xEV1efkWhhrKvzLavHqw6YdzK8Lg0GuLkH9Y95fL0IC2e0qIPv+9AM5qMmb88o8oeQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733450520; c=relaxed/simple;
	bh=yte/P6IfsxWYuATcLIj5mbBTp6vjiDLPzwOmfO7iACI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jlsAgqoMdld1Dyiznp460zbyie4yD23G+qxNG2nPjag9D5Gdk3KKHKPWroJr9uAAdk0Y8sbzAp+WgDG4SdYXNmGqSOJeoDaMQla420ZdJ1mlM/FZ5oH8t9DAhuT2L+qLGB8hDAc/guFY3+YTLGEVrxvyAaX57ut+ruVdxAQPNwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=fVLmBoKP; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1733450499;
	bh=6vUOr8MtWlCU0Q+z2XXJh7WEQMJ73j5q0TRg4qBeawM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fVLmBoKPwbaEe+YeoIXgFdYE4qUlP4f6ltgwXwn1bUHqkSgkVnqKshFwWonHlZu5w
	 T2LR9w3Mo133Vfv526l8fdTGhMB4r7zXIszM6I0COWKb/5RsWebt91lPJ0cCTVTp5c
	 V18SYRM0pM4oaWOfNwlSPYsRvha+U2ydrA6wXx2o=
Received: from NUC11-F41.. ([39.156.73.10])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 641F6E9; Fri, 06 Dec 2024 10:01:36 +0800
X-QQ-mid: xmsmtpt1733450496taqmzdsp7
Message-ID: <tencent_4C02217218D4082166DD5C52A8D8BF228F0A@qq.com>
X-QQ-XMAILINFO: NAuAIaytDrXpkNArbYHasb+WGckfmUjYanZkVlntwh2zSHLn+UvXCjWfM3+a/b
	 yEg4ysfdrLdXNYAxCZUHT2dc3PlC0FASsCsgsoX4urFCrD6m1fg5+31jQUreFxgdgjrtxX9aOikt
	 pqS4K45/IH/t2kkRYAM3iH7LwPRl7rUtyR+sLAMABXpc73ULyUBOBtNjPCwGSp2mrBQ2ch7iMF82
	 RmgCTRTle6Dy//OIUVvED5JbSq2bPe8HCEH+8MUZVMjtX3eO75BclRwgVBESar6StAeWw176IG2z
	 7vSFUV+jLMMNj40+MsXYtKM+t6cSsaGbnggbBn4+WjHi7lOFX8Q1oTTNNA7weJQEJpL70F+c+PS9
	 ntdcLAORF+Z0bNVCArEofjHYbuNh/GIJv1+lYgHxVFkkLSEwKnydhR6f6/cHrSHh22vf7Lrnduba
	 NzUhUQOE9JoVSOvxDBlPpNR7dYWFOP1I+O8qzQBQk4NvsApeJ5q4UMOfMcWRgb0Uhf62cqyWqeLS
	 Vd0hKSgnc+IawX/BNWXnbFkhbJhVX0a1jyiOH9d6rB0MrCWhTxLarsNsNSP6jO+DMhOBE8j43dnp
	 KKEP4GGnktLcVxA+nRexTvG1E2lhQjA96z2TMEmVOKGdnEqByhMqP5Lg3UyHyMFxrexwyOYuUnQD
	 /T1gqk4SpSkYGekejq4uEn9ZLUgEKi1xeDnfxRtvnvl6m9Qoqbyz/57m2Xnw+7S6eDf9wxNhEigq
	 JWMQRqekEzfgUuTF9dRqWbxL/J1YNmOBe0XLl+UtBESWsgiO4CEw8STc+6b+R0Yx2Ku4VA6uJebO
	 8kIILlhXZq0IJAdCkvtx4tIcaCxpm6jhXwAFDhU+Qa5BIypT3xlp0zloGfYCxGDnH+tPE2nxotOa
	 Fr0qlJrGda4tF8mHAKTlROskZy/PeIm969W953oW7w2TRou4Rk4dEOmNMBUYUIqdey2gqCRTPg
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
Subject: [PATCH bpf-next v4 2/2] libbpf: linker: Avoid using object file as both input and output
Date: Fri,  6 Dec 2024 10:01:34 +0800
X-OQ-MSGID: <b3e465b940b06162b9bca9f58b3dcabe507bd184.1733449395.git.rongtao@cestc.cn>
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

When the target file is used as input and output at the same time, the
input file will read a null value, resulting in a segmentation fault.

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
    1296                Elf64_Sym *sym = symtab->data->d_buf;

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/lib/bpf/linker.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index cf71d149fe26..0b117cc5b6e4 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -448,6 +448,11 @@ int bpf_linker__add_file(struct bpf_linker *linker, const char *filename,
 	if (!linker->elf)
 		return libbpf_err(-EINVAL);
 
+	if (!strcmp(filename, linker->filename)) {
+		pr_warn_elf("Input and output files cannot be the same");
+		return libbpf_err(-EINVAL);
+	}
+
 	err = err ?: linker_load_obj_file(linker, filename, opts, &obj);
 	err = err ?: linker_append_sec_data(linker, &obj);
 	err = err ?: linker_append_elf_syms(linker, &obj);
-- 
2.47.1


