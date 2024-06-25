Return-Path: <bpf+bounces-33079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B599916F4F
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 19:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A4B2830AD
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 17:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893511779B1;
	Tue, 25 Jun 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="IwGJRg5k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X+jg41gl"
X-Original-To: bpf@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D12179949
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336738; cv=none; b=AMq1Rolchc9BUUGTFNSIhG+EYpVKkKkGcsh8duPc5qdEmNEi9WZS2mGt0iPxgbwJtgT+Fb+rntNR2XMeXyakyFAi2OdA7s+ruxHGrwAiQ1Bvt0C593A8kuQTx70VPXjrTrMlo88Exte3bJ0JThO/BNzkEQqjt86HHhRxgm4We9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336738; c=relaxed/simple;
	bh=Q34eG6+6jdbzDMT2Gi9xyAA0CPWzqS/rucZSZIpzFdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDpPzDFRC6pokLTy5WOMpmJ7StzKhypDKn8zohdfpID5CLBeWwvcbvQZpOmQgBgt94RsDaOelVMihYw/Q/yGicgD0JLCfML1bm1r79B7buteiGI6reGBIRPa0npXRRUuQbCe9ZcXuXjCbSbKpPDf1n8T3wjiCk+DWLYBr8vkniU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=IwGJRg5k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X+jg41gl; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id A60AC1380115;
	Tue, 25 Jun 2024 13:32:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 25 Jun 2024 13:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1719336735;
	 x=1719423135; bh=qG4u5KLGDo+FgoXV0sRGH1xHnUqNMrmuYu9h1bt4UKA=; b=
	IwGJRg5k3l316wk/a4d6xEM8qKQcu4+CAq3eW7yg9l4Ezqy9oYQthISmnt3hFyNi
	h+CBkqm6Fu1gPobuFAY1I5kcIFzPbelO0TZmCvIk+A11z4ZFPcx9SwQF2bAbp2ib
	GYRf3MJwS6b81Uu+r75OuSeWNxOsfCUud/w8LEhe0oaJXGTu/Of/NFQfGSrnnKE9
	sUU9DtvYo/NNxTOA4fxBZpoznEEK8ABFxnIY8WXrKIoCJz92F8kEQowV65KPxJKD
	Hw5T2mJ1knEkJxnsmlC9w6lYbIpivilxQKAdsiDxro7gOeav1KZ+HVKUfHT7YBhS
	+rm7xF+3l0/6RQM9a8tAmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719336735; x=
	1719423135; bh=qG4u5KLGDo+FgoXV0sRGH1xHnUqNMrmuYu9h1bt4UKA=; b=X
	+jg41glqim+F/uKJC0CyiX4ynqg7AHb1tdJiyb+PxsgJnqgCEiiBMtIOBF1Evmze
	e3kCe32ZBuJahihYb9tIG9WYWE1M8I61VHJGLroLYTDgkrpidLc6PUqaDG3c0qgw
	eLxy+w1PzaXIoA8bz9cGmddbEB9ulCgZVN4i0V+Qz+2bxNLk/QFVRjbn5BAzjM7b
	mP1N5ft0Hd8sxavyp4FSA00YPXyhkGn3PLBJ65XHTgpwYwmUbpUqyYLUnUXyvBbU
	BIYKsZhSYP2eSXo+97pgzt/DurwUDkxYpqL07HBKASdM+i5azJotJP3lA5GHM/sK
	FzxeV53fkcCdNo3Q6Fcuw==
X-ME-Sender: <xms:H_96Zu6fvt6fNu6WiVT68QtEkufFmraj68TX8l--L6xzhR0Gkgrxpw>
    <xme:H_96Zn4IODbQtQd3wWcBgLmhJ2hN4JaVl7Z_v-c1T1vywk-9JVV08LsxidcQCsGRY
    2PvADk_kSgE82uAFg>
X-ME-Received: <xmr:H_96ZtcpBX1W3gJTmBMgf5o0SwGfjWIPn-gPvti-TrJpB8uD0D52eSxRVFtQ0ARh5plWHpHR6MFQbD4tJfHnFogjMR-I5IfBPNmQglY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddtgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculddvfedmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddt
    tdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepuedufedtkeegvdehueffueelvdetieehudehfeehkeegkedt
    gfefudekudevgffgnecuffhomhgrihhnpegrrhgthhhlihhnuhigrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhu
    uhdrgiihii
X-ME-Proxy: <xmx:H_96ZrJm4Se3p2Q1jQQqBmWe8GiCxW1xu7GworZjagaOA1Q5rXANgg>
    <xmx:H_96ZiJqmMFv4iTg9Zqc-KBLGWrbxOdUPj5Xup9sGuckc4O8E-EW6A>
    <xmx:H_96ZsxYfjGYHTvNrCCCwTm5iyGt7AmpWRPtpDRvajS70nic1Qjlww>
    <xmx:H_96ZmKoQM3SAfnFH1JwHt81TRC7yo3cyFdM52Zsow-KBbWNL85_Mg>
    <xmx:H_96Zki5HCY6u1gQqBrwmvLrEuYJR7gSTn0cpYbzdngyNqIgZuZtmYWo>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jun 2024 13:32:14 -0400 (EDT)
Date: Tue, 25 Jun 2024 11:32:13 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: APIs for qp-trie //Re: Question: Is it OK to assume the address
 of bpf_dynptr_kern will be 8-bytes aligned and reuse the lowest bits to save
 extra info ?
Message-ID: <43e5lpnt2ak7445gtun5fo7q4myczxgloboenaqbajibh2log6@bdmft6r5zbri>
References: <b3fab6ae-1425-48a5-1faa-bb88d44a08f1@huaweicloud.com>
 <CAADnVQKoriZJn7B2+7O6h+Ebg_0VgViU-XXGMQ0ky6ysEJLFkw@mail.gmail.com>
 <3ec5eed2-fe42-5eef-f8b6-7d6289e37ed8@huaweicloud.com>
 <CAADnVQKJOc-qxFQmc8An6gp6Bq07LSGLTezQeQRX82TS-H4zvg@mail.gmail.com>
 <57e3df33-f49b-5c8b-82b3-3a8c63a9b37e@huaweicloud.com>
 <CAADnVQ+2JoqJJvinPvKA+4Nm8F9rTrpXBdq4SmbTeq_9bw=mwg@mail.gmail.com>
 <a3eb33c4-b84f-5386-291c-c43d77b39c48@huaweicloud.com>
 <CAEf4BzZPno3m+G0v8ybxb=SMNbmqofCa5aa_Ukhh2OnZO9NxXw@mail.gmail.com>
 <00605f3d-7cf9-cf83-b611-a742f44a80aa@huaweicloud.com>
 <CAEf4BzYWWrrEGcHjVSOMeBvsO0ymk56S4iMG_WSwQJc6rxwmzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYWWrrEGcHjVSOMeBvsO0ymk56S4iMG_WSwQJc6rxwmzw@mail.gmail.com>

On Mon, Jun 24, 2024 at 08:55:43PM GMT, Andrii Nakryiko wrote:
> On Mon, Jun 24, 2024 at 7:12 AM Hou Tao <houtao@huaweicloud.com> wrote:
> >
> > Hi,
> >
> > Sorry to resurrect the old thread to continue the discussion of APIs for
> > qp-trie.
> >
> > On 8/26/2023 2:33 AM, Andrii Nakryiko wrote:
> > > On Tue, Aug 22, 2023 at 6:12 AM Hou Tao <houtao@huaweicloud.com> wrote:
> > >> Hi,
> > >>
> >
> > SNIP
> >
> > >> updated to allow using dynptr as map key for qp-trie.
> > >>> And that's the problem I just mentioned.
> > >>> PTR_TO_MAP_KEY is special. I don't think we should hack it to also
> > >>> mean ARG_PTR_TO_DYNPTR depending on the first argument (map type).
> > >> Sorry for misunderstanding your reply. But before switch to the kfuncl
> > >> way, could you please point me to some code or function which shows the
> > >> specialty of PTR_MAP_KEY ?
> > >>
> > >>
> > > Search in kernel/bpf/verifier.c how PTR_TO_MAP_KEY is handled. The
> > > logic assumes that there is associated struct bpf_map * pointer from
> > > which we know fixed-sized key length.
> > >
> > > But getting back to the topic at hand. I vaguely remember discussion
> > > we had, but it would be good if you could summarize it again here to
> > > avoid talking past each other. What is the bpf_map_ops changes you
> > > were thinking to do? How bpf_attr will look like? How BPF-side API for
> > > lookup/delete/update will look like? And then let's go from there?
> > > Thanks!
> > >
> > > .
> >
> > The APIs for qp-trie are composed of the followings 5 parts:
> >
> > (1) map definition for qp-trie
> >
> > The key is bpf_dynptr and map_extra specifies the max length of key.
> >
> > struct {
> >     __uint(type, BPF_MAP_TYPE_QP_TRIE);
> >     __type(key, struct bpf_dynptr);
> 
> I'm not sure we need `struct bpf_dynptr` as the key type. We can just
> say that key_size has to be zero, and actual keys are variable-sized.
> 
> Alternatively, we can treat key_size as "maximum key size", any
> attempt to use longer keys will be rejected.
> 
> But in either case "struct bpf_dynptr" as key type seems wrong to me.

I have some half-baked thoughts here. FYI I haven't thought thru the
details yet.

bpftrace has some right-sizing issues with strings. Consider the case
where we read a string from userspace. We have to first bring the string
into kernel memory (via bpf_probe_read_user()) in order to do anything.
So we must size the buffer the string gets read into.

Size it too small and you get a truncated string. Size it too large and
we'll waste memory. Especially if we want to key a map with a string.

I wonder if dynptrs can be used to provide a native string type for bpf
programs.

Ptr+len implementation seems like a natural fit. It might not help with
bpftrace multi-keys [0] but for single string key it could be useful.


[0]: https://man.archlinux.org/man/extra/bpftrace/bpftrace.8.en#Associative_Arrays

