Return-Path: <bpf+bounces-18420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E101781A781
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 21:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749641F23AB3
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 20:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D76348788;
	Wed, 20 Dec 2023 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="kKjxRhPJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="12FlTals"
X-Original-To: bpf@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF8E4879E
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 2B9475C039E;
	Wed, 20 Dec 2023 15:12:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 20 Dec 2023 15:12:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1703103135;
	 x=1703189535; bh=MiCarwXy7gpl1SRxgIJdsA5C5UsMskqS6g7fT1sRzZk=; b=
	kKjxRhPJ8pAoybWTBjQBtRVaRDIFMSPPxK8tV4lA5vnJlBzlomXDzGT9dmW4Mw71
	bL9ixwSVUtq0EMaJJW85mMWaSlU7ofx++ajRWZCFfP+YTe2agnsNVjUwcgFxBoR/
	VitJkfm5egBE+7vqlCOFhL3Y4da2vGdAhzx6MeXs2S86sB0gQVxxfi7norLxVfVX
	ZBWwi/5NqUokCADFOMxaI6yNO3flIpOYSUt68oj378e851LKxUPZFTJ1DY0/7mZa
	ie7+XR/IjyjdpHGNK20wiNlYJQQXlzxjnFhFY5BAY5W4hO1XPcsUcSE5MN/NJqxK
	6+b6Q1X1agHw/v9y1fdnLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703103135; x=
	1703189535; bh=MiCarwXy7gpl1SRxgIJdsA5C5UsMskqS6g7fT1sRzZk=; b=1
	2FlTals7Ipb3mcyENVflfsk+dJZdkzLkJCHnxgt86beYydiu3S765OAFjcSv4owg
	DFlARQAH34cyLMeird8rFH4BtdrJmDe5KSHBGHYZr3OwpEYtRN1SqnNqVReNEkbn
	CiY3tvCigDdxeIVC1X+i/UtT5fQnThO9LOHb5E95Lk36OS5Lz5NTz0tPl3kFxAiS
	IOCZ//rxphc3QsFg5XlGBQbwNJBk0g0fieQMovIDLR0BZcw2pwLzw9tVyZmHYwXH
	XMF29xVcgieYybjCo19ww7Hylt51et4YSHt4MGvK09kfe4/YVyrrj6F7NmIHRieO
	mCKculgymhJnbL9ng0OFA==
X-ME-Sender: <xms:nkqDZczIE6hIYkEJY69vdx4QWxcYlXj_5CRa0F0TUuRgt6NfqPANYw>
    <xme:nkqDZQTj2aJBnBO1B-532o1aVDA8cvwTarVuECeGVhoJHoGFpE_8pU6blvtyPn8tK
    E1f5On_u1ExqpOuXg>
X-ME-Received: <xmr:nkqDZeWYy8-cAbBIumAJZNMMpHmltGLGFepGSZ2dGRb2dVgtHKMU9fNmF4l5YbeK1vHC65xcAfBBtMHYb22-YJQkjdPBvdcLpdI0YH4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefs
    tddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueekffelteekkeekgeegffev
    tddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:nkqDZahDDTNdkrcNIIImi72DS4-Pdap1KGPdbqRGAKbYbKuMqFFPmQ>
    <xmx:nkqDZeCCkvLOlbf7M3DZZcfi83ZNmtpKZSYlM0-hXerEZw0kx3Tvng>
    <xmx:nkqDZbKVXVHzCIanKBW8PN81yxARv45xw9UruVcVgTsl_S02T0nawQ>
    <xmx:n0qDZZM_bLNqOlxYwwzp_0s8EM4jpgDIcg5TJwU41TIMU8852iHC_w>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Dec 2023 15:12:14 -0500 (EST)
Date: Wed, 20 Dec 2023 13:12:13 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Quentin Monnet <quentin@isovalent.com>, 
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Dynamic kfunc discovery
Message-ID: <u46rtj6fbsbjiic4d2vs6gm3humqainrox7ik7rzknw6bn3bs3@n2wpzc36meck>
References: <67b0a25f-b75b-453c-9dde-17adf527a14a@app.fastmail.com>
 <CAADnVQLYafmCffxbpxcTFf09W6XqgXCRH6V4gpRL+82+OMMVMA@mail.gmail.com>
 <ZYKu1oysidMOHbbE@krava>
 <4hfjkuvoprm5qawiscm6yd64ffhuf7ig2onm2zqc2bb2r7bbvv@u774my22jfn6>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4hfjkuvoprm5qawiscm6yd64ffhuf7ig2onm2zqc2bb2r7bbvv@u774my22jfn6>

On Wed, Dec 20, 2023 at 09:44:10AM -0700, Daniel Xu wrote:
> Hi Jiri,
> 
> On Wed, Dec 20, 2023 at 10:07:34AM +0100, Jiri Olsa wrote:
> > On Tue, Dec 19, 2023 at 07:15:42PM -0800, Alexei Starovoitov wrote:
> > > On Tue, Dec 19, 2023 at 9:29 AM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I was chatting w/ Quentin [0] about how bpftool could:
> > > >
> > > > 1. Support a "feature dump" of all supported kfuncs on running kernel
> > > > 2. Generate vmlinux.h with kfunc prototypes
> > > >
> > > > I had another idea this morning so I thought I'd bounce it around
> > > > on the list in case others had better ones. 3 vague ideas:
> > > >
> > > > 1. Add a BTF type tag annotation in __bpf_kfunc macro. This would
> > > >    let bpftool parse BTF to do discovery. It would be fairly clean and
> > > >    straightforward, except that I don't think GCC supports these type
> > > >    tags. So only clang-built-linux would work.
> > > >
> > > > 2. Do the same thing as above, except rather than tagging src code,
> > > >    teach pahole about the .BTF_ids section in vmlinux. pahole could then
> > > >    construct BTF with the appropriate type tags.
> > 
> > I thought it'd be nice to have this in BTF, but to generate the .BTF_ids
> > section we need the BTF data (for BTF IDs), so that might be tricky
> 
> Isn't .BTF_ids already present in vmlinux before getting to
> resolve_btfids? It looks to me like all resolve_btfids does is patch
> symbols to the read BTF ID values.
> 
> To inject BTF type tags from pahole, I don't think it needs a patched
> .BTF_ids section, right? After pahole has generated all the regular
> entries, it could walk .BTF_ids and try to match up symbol names with
> BTF function entries. And then inject the BTF type tag.

I have a working prototype. Will send out a patch later today.

[...]

