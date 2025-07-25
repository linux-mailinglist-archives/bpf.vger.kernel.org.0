Return-Path: <bpf+bounces-64361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D65B11C22
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 12:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127821889138
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 10:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6162D8773;
	Fri, 25 Jul 2025 10:19:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DCE2D6405;
	Fri, 25 Jul 2025 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438752; cv=none; b=pvkFjSkkbvip9eYA11ouAfWe5tSpQF0mjIl/VdTUTWD+UACN/qRthcmzcpEmB2SFo1kK+hAfA+HLmSdKXayDpBTKL3D+Z43ov4Jd6sYvfTFuuXsuW6CDCC0ida8claVDHpEBlFNhtgYLwCbxyxm9OKbMnhARUZIX8o+2zseTw+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438752; c=relaxed/simple;
	bh=qQ/yJCsQkmP5/e/dWKzazsGsjGQ8Clmwyi0em7Uy9DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipUqcDZEGN3D/4x3T8UsJE5C0CBNdnur3mAQGKVDfuYLAmRTCqc8mY3Bp2DsxkAj9crzKiteJ8dg3J7ptRbMu/Maaq7VpxrXJp+0UvuatignDYhyjOglIMa9cfZKyBta9aQcfONTX0HEoVXl83mt5vVr3gX6f0BtWO3DrjqySw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c8502472694011f0b29709d653e92f7d-20250725
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:3904e0f8-c2a3-4b9a-a6f8-dec81a948c30,IP:0,U
	RL:0,TC:0,Content:9,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:9
X-CID-META: VersionHash:6493067,CLOUDID:9bad97c22f5b24b1cbe184e7b452d44d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|50,EDM:
	-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: c8502472694011f0b29709d653e92f7d-20250725
X-User: duanchenghao@kylinos.cn
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 300724971; Fri, 25 Jul 2025 18:19:00 +0800
Date: Fri, 25 Jul 2025 18:18:57 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: Vincent Li <vincent.mc.li@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yangtiezhu@loongson.cn, hengqi.chen@gmail.com,
	chenhuacai@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, kernel@xen0n.name, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, bpf@vger.kernel.org,
	guodongtai@kylinos.cn, youling.tang@linux.dev,
	jianghaoran@kylinos.cn
Subject: Re: [PATCH v4 0/5] Support trampoline for LoongArch
Message-ID: <20250725101857.GA20688@chenghao-pc>
References: <20250724141929.691853-1-duanchenghao@kylinos.cn>
 <CAK3+h2zirm6cV2tAbd38RSYSF3=B1qZ+9jm_GZPsAPrMtaozmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK3+h2zirm6cV2tAbd38RSYSF3=B1qZ+9jm_GZPsAPrMtaozmg@mail.gmail.com>

On Thu, Jul 24, 2025 at 08:30:35AM -0700, Vincent Li wrote:
> On Thu, Jul 24, 2025 at 7:19 AM Chenghao Duan <duanchenghao@kylinos.cn> wrote:
> >
> > v4:
> > 1. Delete the #3 patch of version V3.
> >
> > 2. Add 5 NOP instructions in build_prologue().
> >    Reserve space for the move_imm + jirl instruction.
> >
> > 3. Differentiate between direct jumps and ftrace jumps of trampoline:
> >    direct jumps skip 5 instructions.
> >    ftrace jumps skip 2 instructions.
> >
> > 4. Remove the generation of BL jump instructions in emit_jump_and_link().
> >    After the trampoline ends, it will jump to the specified register.
> >    The BL instruction writes PC+4 to r1 instead of allowing the
> >    specification of rd.
> >
> > -----------------------------------------------------------------------
> > Historical Version:
> > v3:
> > 1. Patch 0003 adds EXECMEM_BPF memory type to the execmem subsystem.
> >
> > 2. Align the size calculated by arch_bpf_trampoline_size to page
> > boundaries.
> >
> > 3. Add the flush icache operation to larch_insn_text_copy.
> >
> > 4. Unify the implementation of bpf_arch_xxx into the patch
> > "0004-LoongArch-BPF-Add-bpf_arch_xxxxx-support-for-Loong.patch".
> >
> > 5. Change the patch order. Move the patch
> > "0002-LoongArch-BPF-Update-the-code-to-rename-validate_.patch" before
> > "0005-LoongArch-BPF-Add-bpf-trampoline-support-for-Loon.patch".
> >
> > URL for version v3:
> > https://lore.kernel.org/all/20250709055029.723243-1-duanchenghao@kylinos.cn/
> > ---------
> > v2:
> > 1. Change the fixmap in the instruction copy function to set_memory_xxx.
> >
> > 2. Change the implementation method of the following code.
> >         - arch_alloc_bpf_trampoline
> >         - arch_free_bpf_trampoline
> >         Use the BPF core's allocation and free functions.
> >
> >         - bpf_arch_text_invalidate
> >         Operate with the function larch_insn_text_copy that carries
> >         memory attribute modifications.
> >
> > 3. Correct the incorrect code formatting.
> >
> > URL for version v2:
> > https://lore.kernel.org/all/20250618105048.1510560-1-duanchenghao@kylinos.cn/
> > ---------
> > v1:
> > Support trampoline for LoongArch. The following feature tests have been
> > completed:
> >         1. fentry
> >         2. fexit
> >         3. fmod_ret
> >
> > TODO: The support for the struct_ops feature will be provided in
> > subsequent patches.
> >
> > URL for version v1:
> > https://lore.kernel.org/all/20250611035952.111182-1-duanchenghao@kylinos.cn/
> > -----------------------------------------------------------------------
> >
> > Chenghao Duan (4):
> >   LoongArch: Add larch_insn_gen_{beq,bne} helpers
> >   LoongArch: BPF: Update the code to rename validate_code to
> >     validate_ctx
> >   LoongArch: BPF: Add bpf_arch_xxxxx support for Loongarch
> >   LoongArch: BPF: Add bpf trampoline support for Loongarch
> >
> > Tiezhu Yang (1):
> >   LoongArch: BPF: Add struct ops support for trampoline
> >
> >  arch/loongarch/include/asm/inst.h |   3 +
> >  arch/loongarch/kernel/inst.c      |  60 ++++
> >  arch/loongarch/net/bpf_jit.c      | 521 +++++++++++++++++++++++++++++-
> >  arch/loongarch/net/bpf_jit.h      |   6 +
> >  4 files changed, 589 insertions(+), 1 deletion(-)
> >
> > --
> > 2.25.1
> >
> 
> Tested the whole patch series and it resolved the xdp-tool xdp-filter issue
> 
> [root@fedora ~]# xdp-loader status
> CURRENT XDP PROGRAM STATUS:
> 
> Interface        Prio  Program name      Mode     ID   Tag
>   Chain actions
> --------------------------------------------------------------------------------------
> lo                     xdp_dispatcher    skb      53   4d7e87c0d30db711
>  =>              10     xdpfilt_alw_all           62
> 320c53c06933a8fa  XDP_PASS
> dummy0                 <No XDP program loaded!>
> sit0                   <No XDP program loaded!>
> enp0s3f0               <No XDP program loaded!>
> wlp3s0                 <No XDP program loaded!>
> 
> you can add Tested-by: Vincent Li <vincent.mc.li@gmail.com>

Hi Vincent,

Okay, thank you very much for your support. The existing patch has
included "Tested-by: Vincent Li vincent.mc.li@gmail.com".

Brs Chenghao

