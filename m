Return-Path: <bpf+bounces-61945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1362AEEFE9
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 09:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4CF1BC4FE2
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 07:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AEE14AD2D;
	Tue,  1 Jul 2025 07:41:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEE713D539
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751355695; cv=none; b=bmEeFJ5tTKTRhVy00uTkcblcE34mMoQjs4V+v9UK9D+vKjO1AB+teD37M0GigJx7Xk9y9CbygN9ci1pBv6fFxFQaeU7iaDsmXKzDr+Y0379jnxNCCj/weXGDBGxy+wCNCmymLf00I/O0WCS7nYWZcRCMyGEC3dKyieU5VrACOhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751355695; c=relaxed/simple;
	bh=YbkPdGfqTBwdTprJLWqbfukX7ZXp55n2cOX848G+puw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=g+CqIFFyY0mA4vo5/N63JyWvix7dk6IG/ilfzOf5MH5VJcKa0/OhXrZv8KDcULY82tqzeJXe1H400RHgGAIZGJaYu42OfLvgrCoPeHmzhPm9Kh6OweHPyqW0PF20JaG7C3k5oyXqgLIRJifPrfT0qqkOLBwI0OKiN/X2nP6U9Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c50e2638564e11f0b29709d653e92f7d-20250701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:af71147b-0b5b-435b-bbf9-2823b9009360,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.45,REQID:af71147b-0b5b-435b-bbf9-2823b9009360,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:4358672e0ed4c095b59b28f5ae483877,BulkI
	D:250701154120I4EG90VN,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: c50e2638564e11f0b29709d653e92f7d-20250701
X-User: jianghaoran@kylinos.cn
Received: from localhost.localdomain [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <jianghaoran@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 547445234; Tue, 01 Jul 2025 15:41:16 +0800
From: Haoran Jiang <jianghaoran@kylinos.cn>
To: loongarch@lists.linux.dev
Cc: bpf@vger.kernel.org,
	kernel@xen0n.name,
	chenhuacai@kernel.org,
	hengqi.chen@gmail.com,
	yangtiezhu@loongson.cn,
	jolsa@kernel.org,
	haoluo@google.com,
	sdf@fomichev.me,
	kpsingh@kernel.org,
	john.fastabend@gmail.com,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org
Subject: [PATCH 0/2] Fix two tailcall-related issues
Date: Tue,  1 Jul 2025 15:41:08 +0800
Message-Id: <20250701074110.525363-1-jianghaoran@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

1,Fix the jmp_offset calculation error in the emit_bpf_tail_call function.
2,Fix the issue that MAX_TAIL_CALL_CNT limit bypass in hybrid tailcall and BPF-to-BPF call

After applying this patch, testing results are as follows:

./test_progs --allow=tailcalls/tailcall_bpf2bpf_hierarchy_1
413/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
413     tailcalls:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

./test_progs --allow=tailcalls/tailcall_bpf2bpf_hierarchy_2
413/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
413     tailcalls:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

./test_progs --allow=tailcalls/tailcall_bpf2bpf_hierarchy_3
413/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
413     tailcalls:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Haoran Jiang (2):
  LoongArch: BPF: Optimize the calculation method of jmp_offset in the
    emit_bpf_tail_call function
  LoongArch: BPF: Fix tailcall hierarchy

 arch/loongarch/net/bpf_jit.c | 140 ++++++++++++++++++++---------------
 1 file changed, 80 insertions(+), 60 deletions(-)

-- 
2.43.0


