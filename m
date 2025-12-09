Return-Path: <bpf+bounces-76355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F84DCAF765
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 10:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 586B9300EDF6
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 09:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C362F6582;
	Tue,  9 Dec 2025 09:34:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816E82DF709;
	Tue,  9 Dec 2025 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765272858; cv=none; b=aV3LTbw72Ak/1w06CGCUMh/B5lP7OtOXID3VY/d7rcWka/og3xt9b+pTnjDVpFVVVNqISuItitDf0CuZnBXzvrUfMB4E+Bs4znlrApM52Ksh5AdmLGHp6wn+wAZZW4fOilLZ6iX9YyPpnU2STQLMrZI6WypKFamfK/ZImKtmT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765272858; c=relaxed/simple;
	bh=fq0kF1EvKP9hjnbJqW2rVL2HP5LSEd+1RK1iaONOv58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eU2MakUpYmmNKYiODp+EaynNAxB+uypMzZNl0g/Er8kSOtYjCrO1L39zuybZV03kpHjosbv1VXpp/0rnEev0eqO8l631XHAcvib48QUMgJm4NNJCfD1xlLKQzPbrndyGXZPCTJkIKTfNZXBWx49fsECOImDvZ36DZJRMQGZ90G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3758b3a4d4e211f0a38c85956e01ac42-20251209
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:b3b646d4-0e95-4e9a-aa3e-09e7e6863052,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:b3b646d4-0e95-4e9a-aa3e-09e7e6863052,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:ff37c8aa96a1ac8419f908ae314710f9,BulkI
	D:251209173411YNCWQX09,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3758b3a4d4e211f0a38c85956e01ac42-20251209
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1118287210; Tue, 09 Dec 2025 17:34:10 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: yangtiezhu@loongson.cn,
	hengqi.chen@gmail.com,
	chenhuacai@kernel.org
Cc: kernel@xen0n.name,
	zhangtianyang@loongson.cn,
	masahiroy@kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	guodongtai@kylinos.cn,
	duanchenghao@kylinos.cn,
	youling.tang@linux.dev,
	jianghaoran@kylinos.cn,
	vincent.mc.li@gmail.com
Subject: [PATCH v1 0/2] Fix the failure issue of the module_attach test case
Date: Tue,  9 Dec 2025 17:34:03 +0800
Message-Id: <20251209093405.1309253-1-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

Chenghao Duan (2):
  LoongArch: Modify the jump logic of the trampoline
  LoongArch: BPF: Enable BPF exception fixup for specific ADE subcode

 arch/loongarch/kernel/mcount_dyn.S          | 14 +++++---
 arch/loongarch/kernel/traps.c               |  7 +++-
 arch/loongarch/net/bpf_jit.c                | 37 +++++++++++++++------
 samples/ftrace/ftrace-direct-modify.c       |  8 ++---
 samples/ftrace/ftrace-direct-multi-modify.c |  8 ++---
 samples/ftrace/ftrace-direct-multi.c        |  4 +--
 samples/ftrace/ftrace-direct-too.c          |  4 +--
 samples/ftrace/ftrace-direct.c              |  4 +--
 8 files changed, 56 insertions(+), 30 deletions(-)

-- 
2.25.1


