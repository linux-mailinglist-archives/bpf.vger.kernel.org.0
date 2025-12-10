Return-Path: <bpf+bounces-76390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 718B5CB20CD
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 07:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E0DD30CCA57
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 06:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9C22FC874;
	Wed, 10 Dec 2025 06:09:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D4821CC44;
	Wed, 10 Dec 2025 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765346947; cv=none; b=MVqPjhNZCOiCyb5WFjcOWRcpXfU8uZBGrVdiaOXSMguDIp76LKi93Gftr7IeaPy2OYl5L0t2xP0nRUiC8izI7zcLOQfu41oQzZI9IwF1xjb+x83XKHl+0Tlc4Fy+0X/0FupojCLe89jzJGPV/S1MAYQR71dVXWyg3Wrf4sCLnow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765346947; c=relaxed/simple;
	bh=vseF7ujM/iBxpCgZ/r+q5YLkXVzyTb8ndIAJNd5QafA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYq22BPrKO4bVgCYml2se40VPrVL0RqrzW2RxTneWGejMZwpCW1pn4x3UJaYaWHgfBLjA+6AEFSxpO7wF7HO53kNbpl2UXD/ZhUQ+WulLZ2PnM3LBQePktjsFU1cm5LJ83soCbX4GO5Z5Q1f/FXaqBXiBzLfjexGpxVOWKdw3Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b321d1bcd58e11f0a38c85956e01ac42-20251210
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:4f777785-ed55-4ba9-8de3-a8f7a3a7aee6,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:6009662373f6ac72260c8b7c16b4250b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|850|898,TC:nil,Content:0
	|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b321d1bcd58e11f0a38c85956e01ac42-20251210
X-User: duanchenghao@kylinos.cn
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1660171310; Wed, 10 Dec 2025 14:08:51 +0800
Date: Wed, 10 Dec 2025 14:08:49 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: yangtiezhu@loongson.cn, chenhuacai@kernel.org, kernel@xen0n.name,
	zhangtianyang@loongson.cn, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	bpf@vger.kernel.org, guodongtai@kylinos.cn, youling.tang@linux.dev,
	jianghaoran@kylinos.cn, vincent.mc.li@gmail.com
Subject: Re: [PATCH v1 0/2] Fix the failure issue of the module_attach test
 case
Message-ID: <20251210060849.GB691118@chenghao-pc>
References: <20251209093405.1309253-1-duanchenghao@kylinos.cn>
 <CAEyhmHSPQLd2ivmzcNxDcKJW8143HLi_=syo_8iBPSxWE35pog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEyhmHSPQLd2ivmzcNxDcKJW8143HLi_=syo_8iBPSxWE35pog@mail.gmail.com>

On Wed, Dec 10, 2025 at 12:10:46PM +0800, Hengqi Chen wrote:
> One minor question, I wonder how you debug these issues ?
> 

There were initially two issues:
1. When monitoring the function addresses of kernel modules in the
module_attach test case, kernel panic would occur.
2. Illegal address access in the module_attach and subprogs_extable
test cases would lead to kernel panic.

These two issues were debugged by combining different methods for
different scenarios, including gdb, kgdb, embedding break instructions
in assembly code, and printing stack and register data.

Chenghao
> On Tue, Dec 9, 2025 at 5:34 PM Chenghao Duan <duanchenghao@kylinos.cn> wrote:
> >
> > The following test cases under the tools/testing/selftests/bpf/
> > directory have passed the test：
> >
> > ./test_progs -t module_attach
> > ./test_progs -t module_fentry_shadow
> > ./test_progs -t subprogs
> > ./test_progs -t subprogs_extable
> > ./test_progs -t tailcalls
> > ./test_progs -t struct_ops -d struct_ops_multi_pages
> > ./test_progs -t fexit_bpf2bpf
> > ./test_progs -t fexit_stress
> > ./test_progs -t module_fentry_shadow
> > ./test_progs -t fentry_test/fentry
> > ./test_progs -t fexit_test/fexit
> > ./test_progs -t fentry_fexit
> > ./test_progs -t modify_return
> > ./test_progs -t fexit_sleep
> > ./test_progs -t test_overhead
> > ./test_progs -t trampoline_count
> >
> > Chenghao Duan (2):
> >   LoongArch: Modify the jump logic of the trampoline
> >   LoongArch: BPF: Enable BPF exception fixup for specific ADE subcode
> >
> >  arch/loongarch/kernel/mcount_dyn.S          | 14 +++++---
> >  arch/loongarch/kernel/traps.c               |  7 +++-
> >  arch/loongarch/net/bpf_jit.c                | 37 +++++++++++++++------
> >  samples/ftrace/ftrace-direct-modify.c       |  8 ++---
> >  samples/ftrace/ftrace-direct-multi-modify.c |  8 ++---
> >  samples/ftrace/ftrace-direct-multi.c        |  4 +--
> >  samples/ftrace/ftrace-direct-too.c          |  4 +--
> >  samples/ftrace/ftrace-direct.c              |  4 +--
> >  8 files changed, 56 insertions(+), 30 deletions(-)
> >
> > --
> > 2.25.1
> >

