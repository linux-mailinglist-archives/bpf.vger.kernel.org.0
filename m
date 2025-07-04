Return-Path: <bpf+bounces-62368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8D6AF8777
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 07:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3792B1C46A3F
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 05:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B478020E314;
	Fri,  4 Jul 2025 05:53:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E038320E31C
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 05:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751608403; cv=none; b=SUoM+YXcBgGIl3gfqekMS13VYTMxuQClO1Dvv6+y9Ug8Itu5lPT6DYMGfFxbHHV3FKipb3IiHudrIGcKP+M2MgJyWTWmJRl6oM50btgx+ZL9y/DrRMu3QZwEJPaQ7EcdgaWFX+7Wg5T/vPaqJv6si1zA/5aiy9buyO/mpKtKW9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751608403; c=relaxed/simple;
	bh=jgEXT8fYe2Y2QTug74CbjKJ3+y9lQkj+xtT41ZFnaW8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LSDIMO1etjHhob7iSvQl8TdI4fY08XPAkgFgiDEoeYxSg4uhPSoY6z0iQD8BC2ePSKPBRulCknTUD/Ngb0XnlmAG66ppvhmK3yDrwQTkJU4toQekbzrJUtCT+e3dVzwhHaOv+Da6DA+dKjyaRIVdXINNTYGlqZCi1VoBgiBs9CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2c07e45c589b11f0b29709d653e92f7d-20250704
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:6dcc7f53-85e6-4411-ac67-9789e5393235,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.45,REQID:6dcc7f53-85e6-4411-ac67-9789e5393235,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:976dd741281dd8707e4a238e7fffc18a,BulkI
	D:250704135314VXWHIXIU,BulkQuantity:0,Recheck:0,SF:17|19|24|44|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|51,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 2c07e45c589b11f0b29709d653e92f7d-20250704
X-User: jianghaoran@kylinos.cn
Received: from [172.30.70.211] [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <jianghaoran@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2026487818; Fri, 04 Jul 2025 13:53:13 +0800
Message-ID: <d61697244565d2c423fdd965decc4fcd0a3a8f74.camel@kylinos.cn>
Subject: =?gb2312?Q?=BB=D8=B8=B4=A3=BA=5BPATCH?= 0/2] Fix two
 tailcall-related issues
From: jianghaoran <jianghaoran@kylinos.cn>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, kernel@xen0n.name, 
 chenhuacai@kernel.org, yangtiezhu@loongson.cn, jolsa@kernel.org,
 haoluo@google.com,  sdf@fomichev.me, kpsingh@kernel.org,
 john.fastabend@gmail.com,  yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, martin.lau@linux.dev,  andrii@kernel.org,
 daniel@iogearbox.net, ast@kernel.org
Date: Fri, 04 Jul 2025 13:52:47 +0800
In-Reply-To: <CAEyhmHSzfMr0J4t7v7cC7roTfybJRqHF_iumFMCYm_iqzJkGOQ@mail.gmail.com>
References: <20250701074110.525363-1-jianghaoran@kylinos.cn>
	 <CAEyhmHSzfMr0J4t7v7cC7roTfybJRqHF_iumFMCYm_iqzJkGOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2kord0k2.4.25.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit





在 2025-07-03星期四的 20:31 +0800，Hengqi Chen写道：
> On Tue, Jul 1, 2025 at 3:41 PM Haoran Jiang <
> jianghaoran@kylinos.cn
> > wrote:
> > 1,Fix the jmp_offset calculation error in the
> > emit_bpf_tail_call function.
> > 2,Fix the issue that MAX_TAIL_CALL_CNT limit bypass in hybrid
> > tailcall and BPF-to-BPF call
> > 
> > After applying this patch, testing results are as follows:
> > 
> > ./test_progs --allow=tailcalls/tailcall_bpf2bpf_hierarchy_1
> > 413/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
> > 413     tailcalls:OK
> > Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > 
> > ./test_progs --allow=tailcalls/tailcall_bpf2bpf_hierarchy_2
> > 413/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
> > 413     tailcalls:OK
> > Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > 
> > ./test_progs --allow=tailcalls/tailcall_bpf2bpf_hierarchy_3
> > 413/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
> > 413     tailcalls:OK
> > Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> > 
> 
> Thanks for the fixes. Will review this series soon.
> BTW, do you test other tailcall test cases ?
> 
> Cheers,
> ---
> Hengqi
> 

tailcall_1/tailcall_2/tailcall_3/tailcall_4/tailcall_5/tailcall_6/t
ailcall_bpf2bpf_1/tailcall_bpf2bpf_2/tailcall_bpf2bpf_3/tailcall_bp
f2bpf_4/tailcall_bpf2bpf_5/tailcall_bpf2bpf_6
/tailcall_bpf2bpf_hierarchy_1/tailcall_bpf2bpf_hierarchy_2/tailcall
_bpf2bpf_hierarchy_3/tailcall_failure
These test cases passed

tailcall_bpf2bpf_fentry/tailcall_bpf2bpf_fexit/tailcall_bpf2bpf_fen
try_fexit/tailcall_bpf2bpf_fentry_entry/tailcall_bpf2bpf_hierarchy_
fentry/tailcall_bpf2bpf_hierarchy_fexit
/tailcall_bpf2bpf_hierarchy_fentry_fexit/tailcall_bpf2bpf_hierarchy
_fentry_entry/tailcall_freplace/tailcall_bpf2bpf_freplace
These test cases depend on the trampoline capability, which is
currently under review in the Linux kernel.

These two patches are relatively independent. Could we prioritize
reviewing the fixes above first? 
Trampoline-dependent changes will be implemented after
trampoline  is merged.

thanks

> 
> > Haoran Jiang (2):
> >   LoongArch: BPF: Optimize the calculation method of jmp_offset in the
> >     emit_bpf_tail_call function
> >   LoongArch: BPF: Fix tailcall hierarchy
> > 
> >  arch/loongarch/net/bpf_jit.c | 140 ++++++++++++++++++++---------------
> >  1 file changed, 80 insertions(+), 60 deletions(-)
> > 
> > --
> > 2.43.0
> > 


