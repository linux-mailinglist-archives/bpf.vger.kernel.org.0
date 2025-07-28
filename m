Return-Path: <bpf+bounces-64515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2E7B13B8B
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 15:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890513BC0E3
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 13:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98DE2673A9;
	Mon, 28 Jul 2025 13:34:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CFF79CF;
	Mon, 28 Jul 2025 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709688; cv=none; b=rYgfJikcAokZfxy8UdDEy2rUSioEg4Nx2WxBKE3tX/up0KLFqx5Yp8WDLELCV6+vHNtTcvxF7Na8tR4lLX+qtX1fRUc6SsH4IGWVyHsxr6IS7m/EDw0SfU3+6vFwhASvX4h4toXx/1HgMWrh3erq7U7iP6ROv6nB7hWOO/gYoxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709688; c=relaxed/simple;
	bh=HFiRHNWsiAoYlJWsIjn8YxO5pOlUaNue7idFdNNkSDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buI2imWnzGRYKlvWFNIbN1SHK7Gg8dBs4bvLsN4Jfq/UtpBzXm4c8v2DiXq1aa792IHZiN/FUf8AHx/ZBr/LlpO2Deb/Zrg6pfFTc7OsQflac2VhSm7otClkRbNKfteSOsxIpNBtJKQlbReqAsl2ZzTYePBCVTnj/ktIQtpAiiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9b3a38286bb711f0b29709d653e92f7d-20250728
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:dc3ef287-03d7-4fe9-96e5-01525c80a00d,IP:10,
	URL:0,TC:0,Content:9,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:14
X-CID-INFO: VERSION:1.1.45,REQID:dc3ef287-03d7-4fe9-96e5-01525c80a00d,IP:10,UR
	L:0,TC:0,Content:9,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:14
X-CID-META: VersionHash:6493067,CLOUDID:9fc57bb33eeb64b8006299c9fdabc025,BulkI
	D:250728185608MS8GWG5L,BulkQuantity:2,Recheck:0,SF:17|19|23|43|64|66|74|78
	|80|81|82|83|102|841,TC:nil,Content:4|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT
	:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:
	0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 9b3a38286bb711f0b29709d653e92f7d-20250728
X-User: duanchenghao@kylinos.cn
Received: from localhost [(39.144.190.111)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1752925043; Mon, 28 Jul 2025 21:34:37 +0800
Date: Mon, 28 Jul 2025 21:34:18 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yangtiezhu@loongson.cn, chenhuacai@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	bpf@vger.kernel.org, guodongtai@kylinos.cn, youling.tang@linux.dev,
	jianghaoran@kylinos.cn, vincent.mc.li@gmail.com
Subject: Re: [PATCH v4 5/5] LoongArch: BPF: Add struct ops support for
 trampoline
Message-ID: <20250728133418.GC1439240@chenghao-pc>
References: <20250724141929.691853-1-duanchenghao@kylinos.cn>
 <20250724141929.691853-6-duanchenghao@kylinos.cn>
 <CAEyhmHQKBQbidX_SpUF1ZPv7vkkhSR_UuRvxznyb6y5GYQS3qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEyhmHQKBQbidX_SpUF1ZPv7vkkhSR_UuRvxznyb6y5GYQS3qw@mail.gmail.com>

On Mon, Jul 28, 2025 at 06:55:52PM +0800, Hengqi Chen wrote:
> On Thu, Jul 24, 2025 at 10:22 PM Chenghao Duan <duanchenghao@kylinos.cn> wrote:
> >
> > From: Tiezhu Yang <yangtiezhu@loongson.cn>
> >
> > Use BPF_TRAMP_F_INDIRECT flag to detect struct ops and emit proper
> > prologue and epilogue for this case.
> >
> > With this patch, all of the struct_ops related testcases (except
> > struct_ops_multi_pages) passed on LoongArch.
> >
> > The testcase struct_ops_multi_pages failed is because the actual
> > image_pages_cnt is 40 which is bigger than MAX_TRAMP_IMAGE_PAGES.
> >
> > Before:
> >
> >   $ sudo ./test_progs -t struct_ops -d struct_ops_multi_pages
> >   ...
> >   WATCHDOG: test case struct_ops_module/struct_ops_load executes for 10 seconds...
> >
> > After:
> >
> >   $ sudo ./test_progs -t struct_ops -d struct_ops_multi_pages
> >   ...
> >   #15      bad_struct_ops:OK
> >   ...
> >   #399     struct_ops_autocreate:OK
> >   ...
> >   #400     struct_ops_kptr_return:OK
> >   ...
> >   #401     struct_ops_maybe_null:OK
> >   ...
> >   #402     struct_ops_module:OK
> >   ...
> >   #404     struct_ops_no_cfi:OK
> >   ...
> >   #405     struct_ops_private_stack:SKIP
> >   ...
> >   #406     struct_ops_refcounted:OK
> >   Summary: 8/25 PASSED, 3 SKIPPED, 0 FAILED
> >
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >  arch/loongarch/net/bpf_jit.c | 71 ++++++++++++++++++++++++------------
> >  1 file changed, 47 insertions(+), 24 deletions(-)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> > index ac5ce3a28..6a84fb104 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -1603,6 +1603,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
> >         struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
> >         struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
> >         struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
> > +       bool is_struct_ops = flags & BPF_TRAMP_F_INDIRECT;
> >         int ret, save_ret;
> >         void *orig_call = func_addr;
> >         u32 **branches = NULL;
> > @@ -1678,18 +1679,31 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
> >
> >         stack_size = round_up(stack_size, 16);
> >
> > -       /* For the trampoline called from function entry */
> > -       /* RA and FP for parent function*/
> > -       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -16);
> > -       emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
> > -       emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
> > -       emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 16);
> > -
> > -       /* RA and FP for traced function*/
> > -       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_size);
> > -       emit_insn(ctx, std, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_size - 8);
> > -       emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size - 16);
> > -       emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size);
> > +       if (!is_struct_ops) {
> > +               /*
> > +                * For the trampoline called from function entry,
> > +                * the frame of traced function and the frame of
> > +                * trampoline need to be considered.
> > +                */
> > +               emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -16);
> > +               emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
> > +               emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
> > +               emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 16);
> > +
> > +               emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_size);
> > +               emit_insn(ctx, std, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_size - 8);
> > +               emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size - 16);
> > +               emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size);
> > +       } else {
> > +               /*
> > +                * For the trampoline called directly, just handle
> > +                * the frame of trampoline.
> > +                */
> > +               emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_size);
> > +               emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, stack_size - 8);
> > +               emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size - 16);
> > +               emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size);
> > +       }
> >
> 
> The diff removes code added in patch 4/5, this should be squashed to
> the trampoline patch if possible.

This patch was provided by Tiezhu Yang, and there was a discussion about
it at the time.
https://lore.kernel.org/all/cd190c8a-a7b9-53de-d363-c3d695fe3191@loongson.cn/

> 
> >         /* callee saved register S1 to pass start time */
> >         emit_insn(ctx, std, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off);
> > @@ -1779,21 +1793,30 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
> >
> >         emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off);
> >
> > -       /* trampoline called from function entry */
> > -       emit_insn(ctx, ldd, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_size - 8);
> > -       emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size - 16);
> > -       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_size);
> > +       if (!is_struct_ops) {
> > +               /* trampoline called from function entry */
> > +               emit_insn(ctx, ldd, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_size - 8);
> > +               emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size - 16);
> > +               emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_size);
> > +
> > +               emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
> > +               emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
> > +               emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, 16);
> >
> > -       emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, 8);
> > -       emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
> > -       emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, 16);
> > +               if (flags & BPF_TRAMP_F_SKIP_FRAME)
> > +                       /* return to parent function */
> > +                       emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA, 0);
> > +               else
> > +                       /* return to traced function */
> > +                       emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T0, 0);
> > +       } else {
> > +               /* trampoline called directly */
> > +               emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, stack_size - 8);
> > +               emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size - 16);
> > +               emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_size);
> >
> > -       if (flags & BPF_TRAMP_F_SKIP_FRAME)
> > -               /* return to parent function */
> >                 emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA, 0);
> > -       else
> > -               /* return to traced function */
> > -               emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T0, 0);
> > +       }
> >
> >         ret = ctx->idx;
> >  out:
> > --
> > 2.25.1
> >

