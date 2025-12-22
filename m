Return-Path: <bpf+bounces-77279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB26CD487A
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 02:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 693803007ECA
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 01:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE98A322A1F;
	Mon, 22 Dec 2025 01:50:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EA03C0C;
	Mon, 22 Dec 2025 01:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766368229; cv=none; b=QXJezDAT1V/ROFCDv3D/75vW0jcvMjA/0HHrbNy+hJi6UId1HsvkiYaokw7VIMuE5Pv4+SwkyU2/tCwYs+XtybNXa2p7VsB1J2A0o3/NBBjBtvhfkDmUXOyKGekkLd3+yDV0XjJcClQwMpig/+2/kkrGvQam0oR2f5azyS5PGVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766368229; c=relaxed/simple;
	bh=Oc8Fi0rIXk1g5QN6HUUP0SiT3rmvZTkFtPm1zj+TXdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msGaY3qfvm94q5u1DuDNyBfe+jekHET2n1qDWnAlkzNpA9nDCs4dZP3wZYd5xPG0EOyLAdGZPvyacR18McMnJkcH8w4EJxFO5sQPFXSh+n83iBW+4myeLLOl7NlcYbPxosTpeGqrXuxyDph1l6+Zv4EHlb89NBDkgneyJPYSF68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8e9fd87cded811f0a38c85956e01ac42-20251222
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, UD_TRUSTED, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_COMM, GTI_C_CI, GTI_FG_IT
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:8cf28f5d-305d-4cad-9f3a-beaba38ef46f,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:8cf28f5d-305d-4cad-9f3a-beaba38ef46f,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:63a9c8397fb1ad5ae67631b9b7bbcbd3,BulkI
	D:251220220743X67KSFCW,BulkQuantity:2,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:1,File:nil
	,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8e9fd87cded811f0a38c85956e01ac42-20251222
X-User: duanchenghao@kylinos.cn
Received: from localhost [(183.242.174.21)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1683954580; Mon, 22 Dec 2025 09:50:13 +0800
Date: Mon, 22 Dec 2025 09:50:10 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: yangtiezhu@loongson.cn, rostedt@goodmis.org, mhiramat@kernel.org,
	mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name,
	zhangtianyang@loongson.cn, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	bpf@vger.kernel.org, youling.tang@linux.dev, jianghaoran@kylinos.cn,
	vincent.mc.li@gmail.com, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/7] LoongArch: BPF: Enhance the bpf_arch_text_poke()
 function
Message-ID: <20251222015010.GA119291@chenghao-pc>
References: <20251217061435.802204-1-duanchenghao@kylinos.cn>
 <20251217061435.802204-7-duanchenghao@kylinos.cn>
 <CAEyhmHRbacxpfTkPJq4MerBupH0bJkFfx8xGUvHMvGOzDDJUow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEyhmHRbacxpfTkPJq4MerBupH0bJkFfx8xGUvHMvGOzDDJUow@mail.gmail.com>

On Sat, Dec 20, 2025 at 10:07:25PM +0800, Hengqi Chen wrote:
> On Wed, Dec 17, 2025 at 2:15 PM Chenghao Duan <duanchenghao@kylinos.cn> wrote:
> >
> > Enhance the bpf_arch_text_poke() function to enable accurate location
> > of BPF program entry points.
> >
> > When modifying the entry point of a BPF program, skip the move t0, ra
> > instruction to ensure the correct logic and copy of the jump address.
> >
> > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > ---
> >  arch/loongarch/net/bpf_jit.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> > index 3dbabacc8856..0c16a1b18e8f 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -1290,6 +1290,10 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
> >                        void *new_addr)
> 
> The signature of bpf_arch_text_poke() was changed in v6.19 ([1]), please rebase.
> 
>   [1]: https://github.com/torvalds/linux/commit/ae4a3160d19cd16b874737ebc1798c7bc2fe3c9e

Thank you for your review and for pointing out the API change in v6.19.

I believe my patch series already accounts for this. It was developed on
top of commit ae4a3160d19c ("bpf: specify the old and new poke_type for bpf_arch_text_poke"),
so all modifications to bpf_arch_text_poke() call sites within my
patches should already be using the updated signature.

Please let me know if you find any inconsistencies or if further
adjustments are needed.

Best regards,
Chenghao

> 
> >  {
> >         int ret;
> > +       unsigned long size = 0;
> > +       unsigned long offset = 0;
> > +       char namebuf[KSYM_NAME_LEN];
> > +       void *image = NULL;
> >         bool is_call;
> >         u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
> >         u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
> > @@ -1297,9 +1301,18 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
> >         /* Only poking bpf text is supported. Since kernel function entry
> >          * is set up by ftrace, we rely on ftrace to poke kernel functions.
> >          */
> > -       if (!is_bpf_text_address((unsigned long)ip))
> > +       if (!__bpf_address_lookup((unsigned long)ip, &size, &offset, namebuf))
> >                 return -ENOTSUPP;
> >
> > +       image = ip - offset;
> > +       /* zero offset means we're poking bpf prog entry */
> > +       if (offset == 0)
> > +               /* skip to the nop instruction in bpf prog entry:
> > +                * move t0, ra
> > +                * nop
> > +                */
> > +               ip = image + LOONGARCH_INSN_SIZE;
> > +
> >         is_call = old_t == BPF_MOD_CALL;
> >         ret = emit_jump_or_nops(old_addr, ip, old_insns, is_call);
> >         if (ret)
> > --
> > 2.25.1
> >

