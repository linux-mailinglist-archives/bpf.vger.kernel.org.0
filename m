Return-Path: <bpf+bounces-19200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6518276EC
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 19:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4710B1C2186A
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 18:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E986D55C08;
	Mon,  8 Jan 2024 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Rx4swttZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l7TL9Wfz"
X-Original-To: bpf@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ED655775;
	Mon,  8 Jan 2024 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 45C743200D46;
	Mon,  8 Jan 2024 12:59:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 08 Jan 2024 12:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1704736796;
	 x=1704823196; bh=pNIZiWpwLsHDep+0m+KAN+8thOCgoQ7cLNAuzaNkgag=; b=
	Rx4swttZoBqP4k0C3+opoVb8qkKfsAa8lfwJ0rZMJxOsqXyjPxVdT2bsT7Z+P0OE
	C75X10/GaNzr7mbZ/MfxWAtd7Zdu2v2h+vwxAhOnPz+ZY4BCyV4EmwmoNo5apX6M
	AhlKeJRupGulf9j+pGVKLnlrjsmR2KG1SeUuDOv2Wj4jZwWy4oVTd9Dv5bP/au2Z
	vb3YW9wSwlb8wcb+T4qtjISJs0lV98wYzACSfmnhtX2Uq9HkB5YEwfSSih+fVzo6
	Gvc0mEeCVrTtTm5nx60/4Te/WsMsLvhFQVyzLXf8SoH8w04M05wrwkQN4rdKdCxq
	7yswvz+MtzPmgukyCA3K2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704736796; x=
	1704823196; bh=pNIZiWpwLsHDep+0m+KAN+8thOCgoQ7cLNAuzaNkgag=; b=l
	7TL9WfzzkC8KTjGzrmx5twRcM+F7fNrdAWppedfCKOrUSJhgTxoZapYWYhH856J1
	hAZornn23OdVyzcvX83Qf5YoTohWo13G3OII9XescaxTzhKngDxJVeK0dn8QwKuU
	i2kDCu+4zqEXtWxjTY0bgcKO+DqmPmdkW/jbXOtRinT/R6ZTh3FwQsANa4GYJYCB
	36s9Xaeg2fqHa9HgE+DqqSH9ym8aT5qLzab/kwFlobBwiGsjHBRQDtqt5o/LSb/2
	uU3m3sBfjXCRiS2cqQljDQxHVMrtDxiRODvlggeOTNjmGi2EgWpdWTsIUYBAhOK1
	fdDu0dWAqat9SFWFYIqug==
X-ME-Sender: <xms:HDicZVFn287Wpybs115sHq_B3zb7sWVpBMhwvGIQ1ZmCwkAvQEOdkw>
    <xme:HDicZaXf3_aWQixsLHEMzvjjsitusBn6lYcDFdDB5ac7CfNK2cD_fVXCavb5cImcz
    SzDzuT9MqoTmbqkvg>
X-ME-Received: <xmr:HDicZXLPvHmseHSVhWr84iRqcQw9Rz-pZWA80aiSWOBd0wrAeLWTnA_guaxbej5qgcs4jgV2BuSMWzLGWKzAoUTDfJswb69aETu6v-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehjedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefs
    tddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueekffelteekkeekgeegffev
    tddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:HDicZbErwNUiEcSPERba9fNpnUavuPsT4XgYi2h47UeqY5BzfOaamQ>
    <xmx:HDicZbVkg6s9M6k2UJvR_LUUDCcWNRNEAyiNQM8xT8_Tom0axnr-6g>
    <xmx:HDicZWMbL2Hsl81L_lfx46enuO38QVxwVPc54yT_6fZ3Y73bQs7vgw>
    <xmx:HDicZdYYCxb4RGdthMRNbQsZezIGsyZpmAkbXGM3wMyZDL1zJ4rnvg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 12:59:54 -0500 (EST)
Date: Mon, 8 Jan 2024 10:59:53 -0700
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
Message-ID: <hn3ukzscwlquov6k2nw3omi4vmwo44d7yqyqtrn57xgtpqvrau@db2rdabczwph>
References: <cover.1704565248.git.dxu@dxuuu.xyz>
 <ae0a144d9ade8bf096317cc86367ed1f5468af25.1704565248.git.dxu@dxuuu.xyz>
 <CAN+4W8isJzy=J_CciNqwUa5o7wu+RQ1_cvPYXt7_OkgjPycsDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN+4W8isJzy=J_CciNqwUa5o7wu+RQ1_cvPYXt7_OkgjPycsDw@mail.gmail.com>

On Mon, Jan 08, 2024 at 10:14:13AM +0100, Lorenz Bauer wrote:
> On Sat, Jan 6, 2024 at 7:25 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > This macro pair is functionally equivalent to BTF_SET8_START/END, except
> > with BTF_SET8_KFUNCS flag set in the btf_id_set8 flags field. The next
> > commit will codemod all kfunc set8s to this new variant such that all
> > kfuncs are tagged as such in .BTF_ids section.
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  include/linux/btf_ids.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> > index dca09b7f21dc..0fe4f1cd1918 100644
> > --- a/include/linux/btf_ids.h
> > +++ b/include/linux/btf_ids.h
> > @@ -8,6 +8,9 @@ struct btf_id_set {
> >         u32 ids[];
> >  };
> >
> > +/* This flag implies BTF_SET8 holds kfunc(s) */
> > +#define BTF_SET8_KFUNCS                (1 << 0)
> 
> Nit: could this be an enum so that the flag is discoverable via BTF?

Sure, makes sense.

> Also, isn't this UAPI if pahole interprets this flag?

Not sure. I guess it'd fall under same category as any of the structs
the kernel lays out in .BTF_ids, like `struct btf_id_set8`. IMO it's
not, as that's kinda confusing to call anything in ELF uapi. Eg I don't
think people would consider layout of `.data..percpu` section uapi.

Thanks,
Daniel

