Return-Path: <bpf+bounces-76701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB33CC1DB3
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 10:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D48843003111
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 09:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F9F339B56;
	Tue, 16 Dec 2025 09:48:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669E219A8E;
	Tue, 16 Dec 2025 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765878517; cv=none; b=lhp9QnbAS+fQabEotOEoAjBDY3yfmSWDvTgmlS6EZBwqXxFELvFwCaxYyXPdHkia1erqEpGEoKJkTLs8KvIk9iTwSbwAaHnDXEhIM2QAXw85eMFSD+2TrA6nHdASVYsNCy7QFigpKI8zMjGgILST4Zgfmc+VUw91xSYaonxe1mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765878517; c=relaxed/simple;
	bh=Lyp5EVdRhkXL9YMqt9xiKb+dQhxlaXgXocuaoB3CDiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MrsL2CPvQS27iy1Yl6kYQkEctQniXm9bXudArmCFgRCT4KqEfNkTeEH0nam5Oj7AtQWZZa+K/GK4eQ669DumnUs4/9BeKQhjgiP6U5rBl6GFX9enpboGsP/ZUapS75uVXVaQFoPw8gpg5k9TTXPnxH+etGbxKmLZvNaU/KA+zds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5a767c0eda6411f0a38c85956e01ac42-20251216
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:76ed3b63-034c-4dc7-8a1d-9d5f828fb046,IP:10,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-INFO: VERSION:1.3.6,REQID:76ed3b63-034c-4dc7-8a1d-9d5f828fb046,IP:10,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:bb65bf60d50fb4307a15bf1a2a13dbc4,BulkI
	D:251216174821A00CE3L4,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5a767c0eda6411f0a38c85956e01ac42-20251216
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(183.242.174.21)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1146435086; Tue, 16 Dec 2025 17:48:19 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: yangtiezhu@loongson.cn,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	hengqi.chen@gmail.com,
	chenhuacai@kernel.org
Cc: kernel@xen0n.name,
	zhangtianyang@loongson.cn,
	masahiroy@kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	duanchenghao@kylinos.cn,
	youling.tang@linux.dev,
	jianghaoran@kylinos.cn,
	vincent.mc.li@gmail.com,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Fix the failure issue of the module_attach test case
Date: Tue, 16 Dec 2025 17:47:49 +0800
Message-Id: <20251216094753.1317231-1-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v3:
1. Adjust the position of fixup_exception() in the patch "LoongArch:
Enable exception fixup for specific ADE": move its invocation to within
the code block wrapped by irqentry_enter()/irqentry_exit().

2. Add the relevant test items to the patch commit log.

3. Adjust the sequence of patches

With the exception of the patch "LoongArch: Enable exception fixup for
specific ADE", no source code changes have been made in the other
patches.

--------------------------Changelog------------------------------------
v2:
links: https://lore.kernel.org/all/20251212091103.1247753-1-duanchenghao@kylinos.cn/
Referring to Tiezhu's suggestion, split the v1 patch titled
"LoongArch: Modify the jump logic of the trampoline" into three parts:
 (1) ftrace code
 (2) sample test
 (3) bpf code
The code logic and implementation remain unchanged.

v1:
links: https://lore.kernel.org/all/20251209093405.1309253-1-duanchenghao@kylinos.cn/
The following test cases under the tools/testing/selftests/bpf/
directory have passed the test：

./test_progs -t module_attach
./test_progs -t module_fentry_shadow
./test_progs -t subprogs
./test_progs -t subprogs_extable
./test_progs -t tailcalls
./test_progs -t struct_ops -d struct_ops_multi_pages
./test_progs -t fexit_bpf2bpf
./test_progs -t fexit_stress
./test_progs -t module_fentry_shadow
./test_progs -t fentry_test/fentry
./test_progs -t fexit_test/fexit
./test_progs -t fentry_fexit
./test_progs -t modify_return
./test_progs -t fexit_sleep
./test_progs -t test_overhead
./test_progs -t trampoline_count

Chenghao Duan (4):
  LoongArch: ftrace: Refactor register restoration in
    ftrace_common_return
  LoongArch: Enable exception fixup for specific ADE subcode
  LoongArch: BPF: Enhance trampoline support for kernel and module
    tracing
  LoongArch: ftrace: Adjust register stack restore order in direct call
    trampolines

 arch/loongarch/kernel/mcount_dyn.S          | 14 +++++---
 arch/loongarch/kernel/traps.c               |  9 ++++-
 arch/loongarch/net/bpf_jit.c                | 38 +++++++++++++++------
 samples/ftrace/ftrace-direct-modify.c       |  8 ++---
 samples/ftrace/ftrace-direct-multi-modify.c |  8 ++---
 samples/ftrace/ftrace-direct-multi.c        |  4 +--
 samples/ftrace/ftrace-direct-too.c          |  4 +--
 samples/ftrace/ftrace-direct.c              |  4 +--
 8 files changed, 59 insertions(+), 30 deletions(-)

-- 
2.25.1


