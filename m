Return-Path: <bpf+bounces-19504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A6182C957
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 05:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BD8286209
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 04:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F0DDF5D;
	Sat, 13 Jan 2024 04:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="RQYdftzx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LzIjSppJ"
X-Original-To: bpf@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D545CE545
	for <bpf@vger.kernel.org>; Sat, 13 Jan 2024 04:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 817645C0049;
	Fri, 12 Jan 2024 23:31:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 12 Jan 2024 23:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1705120264; x=1705206664; bh=Sieo6rj2IO
	zWxuVY4hzmUhiwVklKRGQf79DgiXi+11I=; b=RQYdftzxnv0IspC1MZ+CXrN4hC
	ey+Ri8hRj+FpQ4eLzIC8GWm0XwPfbuGF28liKnUXniApVK/VdSdjW4MUc3CJJzKm
	XNgmRvskpmSYtIWK2UJkP/5o0PPHC1tnB3k/IKIcNevysmmSVZ3f+81KmGvVgGtI
	N/nbyDZoWdl2CM19u7KsvfSzwxTycynhIDSCJ9wtW+MvKg65zBiIL+IXNmBnOkQG
	L/X2X6g9QmCBnMIG1YFDpWFDsvnKhCYZJRzb1ejb5bKJFJuwd5FQGN1KkqOffETe
	8EJhym5F987e7yhf975R7b2uB2WVmWq1xgHA5QRfN1Hl+XzB+bGjrzNExzdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1705120264; x=1705206664; bh=Sieo6rj2IOzWxuVY4hzmUhiwVklK
	RGQf79DgiXi+11I=; b=LzIjSppJT8nDfpPIhAXDYU4GwBjNjjvOMbETpgg3JyLJ
	CXgciYuBeyxqHTxikdRHDKXFwVhZs6i5m/jZcEd1Vj+Nqqch28GZgf9/lVVN/Bho
	+QjFfJBJtpAyRwkhN+76OYqKjyEODKIW/3O8YYhll78r77zAYacU83IF1LGq4F80
	Kj2VFfO627iXSD/nJ1SOrCT5jydTXzXZDZ3M3rRy5VrP/ZnKboQWoqrH4d+dDSW0
	8i6qk5mXLj6myXCaeFB3+KXJCJlnm7UsgleJwvChwpqIjdUCdNtfB3Uslghe/EU8
	b4+d1kapmtpxhIPqH5ifWim0+ckSXJrIR1ZmcRapsw==
X-ME-Sender: <xms:CBKiZT5IAS1Qen9Gez9cphi3CJaHcL5e-NPwzN5Odd7x9jQF_aoFvQ>
    <xme:CBKiZY6SkfV-CPBi5vIb6vypmotcSprql0y0Uq7U9J0_oBHJVBc6AbXIBcx9pgWE0
    7wJ5sSDgld6VmM3Mg>
X-ME-Received: <xmr:CBKiZadS7475l_1Myw_i9Ecg18iMjbVsE9HcOGeHtkQ6bXVn37G1A0U6kQwJblnSUf7GDjnBIS30st0y-TSW2db7IDA2JGKtixABTGs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:CBKiZUKn_yhR0J6Nnx8lpyPfohdSBSZDSMdRalIB4HcC0tnlyKT-JA>
    <xmx:CBKiZXJHO85c0HP-nlEzI4XF_QJfWQWOhkwSn-MY9BdJqzrSd_9SAw>
    <xmx:CBKiZdxzbEv3fu5vLCvbimzAh10vIl2SfkweJeC4Y_KvtkmZHplqLA>
    <xmx:CBKiZdgU3JC7LOABQLEq0hDg3MKCDATX1KgyIVhh5tP62-nhCxuKdQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jan 2024 23:31:03 -0500 (EST)
Date: Fri, 12 Jan 2024 21:31:02 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: acme@kernel.org, quentin@isovalent.com, andrii.nakryiko@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v2] pahole: Inject kfunc decl tags into BTF
Message-ID: <ro3ntwmijtaug5rwc2uhnfbp3vmes4t3eivn4gyaogpfqemqhi@rzptj2yxljoh>
References: <85caea4c48659502544329e6cd8b41c12ab50dfc.1704929857.git.dxu@dxuuu.xyz>
 <ZaFlx89aXd7eEO1P@krava>
 <kdnf3vegkn5r3rndtbxlthbzbq4in5gr2lke6jrlx3yczpyj3n@ne3m2yo7r5od>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kdnf3vegkn5r3rndtbxlthbzbq4in5gr2lke6jrlx3yczpyj3n@ne3m2yo7r5od>

On Fri, Jan 12, 2024 at 01:41:41PM -0700, Daniel Xu wrote:
> Hi Jiri,
> 
> Thanks for reviewing!
> 
> On Fri, Jan 12, 2024 at 05:16:07PM +0100, Jiri Olsa wrote:
> > On Wed, Jan 10, 2024 at 06:14:25PM -0700, Daniel Xu wrote:
> > 
> > are .BTF_ids records guaranteed to be sorted by address? so we are
> > sure that the set will be followed by its records?
> 
> I think so, unless I am misunderstanding something. The asm directives
> are basically laying out the btf_id_set8 datastructures by hand.  So if
> the entries don't adhere to the exact layout then lots more will break
> right?
> 
> > 
> > I thought we'd need to find size for each set and then check each
> > .BTF_ids record if it belongs to the set
> 
> Not sure I'm following. How would the check be done differently than in
> the patch?

Ah I got it. Current code iterates through all symbols. Indeed a good
question whether or not order is guaranteed. I think it should be
possible to process each set8 more reliably. Lemme think on it.


