Return-Path: <bpf+bounces-19351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5BA82A58D
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 02:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6629CB24102
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 01:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A989BECB;
	Thu, 11 Jan 2024 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="STBrG1bG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0Dvct0On"
X-Original-To: bpf@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F63EA3;
	Thu, 11 Jan 2024 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 8E7543200B0F;
	Wed, 10 Jan 2024 20:27:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 10 Jan 2024 20:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1704936437;
	 x=1705022837; bh=QgJ9yQRRKlfBjz+XKZdFtWiCEuEshUHPGj0G2dnzzCg=; b=
	STBrG1bGxG9KECg8tUylREuoybIu6frA/RDhI3qlD+TatlhS6DPr2KUWx0dMGbNf
	8FtyvtQH/a8KTQTlx+KUhvDrr7ga5ficqg5mD7QZ/9he/7pFqHtsp+X2l0CkSlem
	zTAmGBcDdglWUzWnmPaQQahUgpdik0lA6W5LlKq2YwCZ59LtPDwkj2RNstPlfxxG
	DW9Vbz8Mwz7/imCPxxOOz4xZV4pb6cVvXKL1nDY2ti/0ouQzt55WLfLgJcoo8y2P
	nWWAkNXMFtZ988jgVKTgvI3UFoZF8b7O3ZuR11plDJHf2Epz4gYbyXmUq58YDvxr
	uDeu6uI+6AkEgXjRqIWMYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704936437; x=
	1705022837; bh=QgJ9yQRRKlfBjz+XKZdFtWiCEuEshUHPGj0G2dnzzCg=; b=0
	Dvct0OnhZVG/wGSy5gsSBaBR2WiUmUsEDzpaq9C5wsA2wO1SBr5FrmLV6FizRxA4
	tHCee13S7hioNUNMUD2Uh93ZQWcyETroPMgZ1vTlScZt5jlFZEhN7NLLUrjuovc6
	npL8mzK48TRW6+SFDgYL/Hc+J34J0DYIbs+QB1U3l8Twsw86Nhr88JXXVcnFX749
	tTvx4NWSeX9SUYWT7oDn3DvwbN6MLxI9g+XBer6Us4vXNY8Hm1FaBoKoYBMjU6DE
	BjJewqTmZh2KQeFrJr7wFnup3Vhid8GjWLaDUtty8k0YyDRyxklPCFQeaNUuT7/h
	YhWtc186QJTDTSsHRqHBg==
X-ME-Sender: <xms:9EOfZTnFiT7AviZswKwRoNkqrNbj8K9ez2XidvJwx7Nx1u1e80Ykeg>
    <xme:9EOfZW1LXO6vlqrCeXly_C375UszVuS4LP7sxzRr7hTmSdTnnGEx2YFjRchuYPHhp
    mj56LC33bTiE8Qz4g>
X-ME-Received: <xmr:9EOfZZpj7G4EBoIDdZPP1G8Ghrr8J9_-ua4DQSZ1yKssDtk5vBMDA2x03SAAJo1-12-gXBxnWo7dwYJ6JDM_eUyxxSR71cIJM8QqcvY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeivddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedtgfeuueeukeeikefgieeukeffleetkeekkeeggeffvedt
    vdejueehueeuleefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:9EOfZbkw_j6esdY-P5EQ-USwoRWWJdGmc-_AHlRimuap2ul0VFxsnw>
    <xmx:9EOfZR250MbUOKnCud3XjKDWXIZ2TvGPqsLVUZO5yiLhPXh1l4gZcA>
    <xmx:9EOfZat70XpuFS1_voSC5eeoW9fDQfSfcxREJ-DOuVRhcFX_nBg0sg>
    <xmx:9UOfZd5I1RjT6oTaaRHIeb_QGmP9nvTavRkHt3Am6RrI2wkwTdaxyg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 20:27:15 -0500 (EST)
Date: Wed, 10 Jan 2024 18:27:13 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Lorenz Bauer <lorenz.bauer@isovalent.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, alexei.starovoitov@gmail.com, olsajiri@gmail.com, 
	quentin@isovalent.com, alan.maguire@oracle.com, memxor@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 2/3] bpf: btf: Add BTF_KFUNCS_START/END macro
 pair
Message-ID: <446p3sgkjndfa45dqfy7a3nu5nfbczn55eazpkup6b46zi5vnw@eu7us32trhcc>
References: <cover.1704565248.git.dxu@dxuuu.xyz>
 <ae0a144d9ade8bf096317cc86367ed1f5468af25.1704565248.git.dxu@dxuuu.xyz>
 <CAN+4W8isJzy=J_CciNqwUa5o7wu+RQ1_cvPYXt7_OkgjPycsDw@mail.gmail.com>
 <hn3ukzscwlquov6k2nw3omi4vmwo44d7yqyqtrn57xgtpqvrau@db2rdabczwph>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hn3ukzscwlquov6k2nw3omi4vmwo44d7yqyqtrn57xgtpqvrau@db2rdabczwph>

On Mon, Jan 08, 2024 at 10:59:53AM -0700, Daniel Xu wrote:
> On Mon, Jan 08, 2024 at 10:14:13AM +0100, Lorenz Bauer wrote:
> > On Sat, Jan 6, 2024 at 7:25 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > >
> > > This macro pair is functionally equivalent to BTF_SET8_START/END, except
> > > with BTF_SET8_KFUNCS flag set in the btf_id_set8 flags field. The next
> > > commit will codemod all kfunc set8s to this new variant such that all
> > > kfuncs are tagged as such in .BTF_ids section.
> > >
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > ---
> > >  include/linux/btf_ids.h | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> > > index dca09b7f21dc..0fe4f1cd1918 100644
> > > --- a/include/linux/btf_ids.h
> > > +++ b/include/linux/btf_ids.h
> > > @@ -8,6 +8,9 @@ struct btf_id_set {
> > >         u32 ids[];
> > >  };
> > >
> > > +/* This flag implies BTF_SET8 holds kfunc(s) */
> > > +#define BTF_SET8_KFUNCS                (1 << 0)
> > 
> > Nit: could this be an enum so that the flag is discoverable via BTF?
> 
> Sure, makes sense.

I took a look - don't think we can make it an enum. See
include/linux/btf.h:

      /* These need to be macros, as the expressions are used in assembler input */
      #define KF_ACQUIRE      (1 << 0) /* kfunc is an acquire function */
      #define KF_RELEASE      (1 << 1) /* kfunc is a release function */
      [..]

Could do some redefines but maybe not worth it. The new flag is a pretty
deep impl detail anyways.

Thanks,
Daniel

