Return-Path: <bpf+bounces-55921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D95A892D7
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 06:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E77B3B185C
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 04:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4180621770C;
	Tue, 15 Apr 2025 04:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="RfztJYjC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RRnISE4n"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441AE2DFA24;
	Tue, 15 Apr 2025 04:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744691307; cv=none; b=tJXQ3iA5KM+bIcNBjyNPN4LZDViVThu0MxrAMoQcCTQvewdtb4oZOHE9LEwXQjd0L4VGejczxrk0a6k7hZIyIq6GAD1fALoav01GwmnhwDdPrIKZzCjsCX2WbCUMGWtoCYwlDZR9kVO4+f8JwhdbMC0yXbKUFKyI2BONx87fIy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744691307; c=relaxed/simple;
	bh=BLI3YfnWAHJOUhbBY3e6np91yu0rO7qc94WPcdthOJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvdZSvLSpkEsmh2ur5fdj36q4Sk15ek0VKfVl6XyKRRTb0IXV2ePX/Uw503VjEdhBgRx4O8+pLLMSyHffx2czHTyi6EWfP2Z7zTIm80gH3vg0ZqtJnhJQbg1BH1RN9EoPxyHMejG/PktVjJaFI2QtT1rcXoHn1/5DOu95cznIXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=RfztJYjC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RRnISE4n; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 30E721140331;
	Tue, 15 Apr 2025 00:28:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 15 Apr 2025 00:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744691304; x=1744777704; bh=TraBLcZP/W
	kRwFzc/HDxXsASf124ua7scK+cLVWMvrA=; b=RfztJYjCu3eKdbZEmUyz4yB3Nj
	xMBVNRb8Fjv05nWTyvyVUPAQdl5aZkPPMoF0zncJXJ6ZWfibN5JfGI8NntpKwBh2
	2zk4lcdWFJuDmhPQbq/2dRc8qbpVCFdKt3athIndIzBAExD6j11BFnsLHqXLm8aT
	cLEBao6qwHPToEN/O+IDGPPGChcYYsedNWkAyGHINYwSPHLTw2G/2uNFLTxfqOjv
	lN7TLi8oEQGcNQQGAHI4TXtvcwYxc8sUuV1Q9LEGGgPcoPwxnbNXI/zaUTO0dKgS
	xwZAhQXosWucFqqdslLSruIzNXvzhD3Oflg6A19QJpf0d3edKOU6hDzbmSug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744691304; x=1744777704; bh=TraBLcZP/WkRwFzc/HDxXsASf124ua7scK+
	cLVWMvrA=; b=RRnISE4n4nAxaiKc30R5JARuB7bFDco+guWvSx3zpALqmVM8Z8y
	zng4ogSMCa54Z9FiMsl9nXRvgnEGMwZsDVSh8b0BmhWtq52lIBNvSwnr7yrFpdw0
	llDK5SdxLe7bryhyeMSouQ0y30JxI+hJaDoWmgexEXCo6yzcZilPc5oRBVgOPziP
	lEJOdMtStRpuUtFadUiCINjoTuJRX/gMnh6lMMM+Oa5TvI8Wz3cf8+iZHRDSctXx
	GYftxcbzW9IZPFhyi7AX0dog4E2PdImf0tdTSzyylDo8gi9BsvFdKv3dBZMGeg4e
	cv+vVBIkARgcxnqjN2x6Z021NI6cbEJqQyA==
X-ME-Sender: <xms:Z-D9Z_lmfbutonPx8xQ0CALldOt-ek1kR-Kt6WZK3eLmmPjrpxtc2A>
    <xme:Z-D9Zy2qaqJ5mK1FbHsB6TiowKzG9U16bEhZZvDfxyAb_0OCXrisn4liQXmzRVw6Q
    eLraM3mYPz6tviYbA>
X-ME-Received: <xmr:Z-D9Z1o7K9v9MBVS2cpBpIAzvVH8tN8NZy1tjEgHZdRNMW1Hw1KgbCAFpNWTImQYyc7W9Ktw56IJW2pUZszc7jVaYwAkwgnW5kSI9DyZgsJJMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddvhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefu
    kfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheef
    ffekuedukeehudffudfffffggeeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghr
    tghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthhfohhmih
    gthhgvvhesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepug
    grnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepjhhohhhnrdhfrghs
    thgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghuse
    hlihhnuhigrdguvghvpdhrtghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghh
    honhhgrdhsohhngheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:Z-D9Z3mNljDIj_X3GO9RTIscU3PPsSwk_k3ehrGxuhihun8ytdANQw>
    <xmx:Z-D9Z922BIle5eSB5V7364xPS1sa8bVETOPKbUWH_K1m4mFEyGT4LQ>
    <xmx:Z-D9Z2sG702wjCpfEi_koYAhvrSEdm87OXsfAM8e02k_MnWAcDqEkA>
    <xmx:Z-D9ZxVvyxXO4swyWo1qKtGIVtRLHAgZ5eiI3J1kmF-6whd2RqCRlw>
    <xmx:aOD9Z93h1EKqDKIEL5SG6M5Is8otipT5-G5PIZw62bHDk4DWs6v5z7js>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 00:28:21 -0400 (EDT)
Date: Mon, 14 Apr 2025 22:28:20 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC bpf-next 10/13] bpf: verifier: Add indirection to
 kallsyms_lookup_name()
Message-ID: <qesoniwddyi2qrjxavxlfvmy5lq6fmenrp5zvz347dnknuf7yb@wi3agqebvgqm>
References: <cover.1744169424.git.dxu@dxuuu.xyz>
 <7540678e9a46c13f680f2aacab28bb88446583f5.1744169424.git.dxu@dxuuu.xyz>
 <Z_aDSipnuvNAhHbE@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_aDSipnuvNAhHbE@mini-arch>

On Wed, Apr 09, 2025 at 07:25:14AM -0700, Stanislav Fomichev wrote:
> On 04/08, Daniel Xu wrote:
> > kallsyms_lookup_name() cannot be exported from the kernel for policy
> > reasons, so add this layer of indirection to allow the verifier to still
> > do kfunc and global variable relocations.
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  include/linux/bpf.h   |  2 ++
> >  kernel/bpf/core.c     | 14 ++++++++++++++
> >  kernel/bpf/verifier.c | 13 +++++--------
> >  3 files changed, 21 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 44133727820d..a5806a7b31d3 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2797,6 +2797,8 @@ static inline int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
> >  }
> >  const struct bpf_kfunc_desc *
> >  find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset);
> > +unsigned long bpf_lookup_type_addr(struct btf *btf, const struct btf_type *func,
> > +				   const char **name);
> >  int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
> >  		       u16 btf_fd_idx, u8 **func_addr);
> >  
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index e892e469061e..13301a668fe0 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -1639,6 +1639,20 @@ find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
> >  }
> >  EXPORT_SYMBOL_GPL(find_kfunc_desc);
> >  
> > +unsigned long bpf_lookup_type_addr(struct btf *btf, const struct btf_type *t,
> > +				   const char **name)
> > +{
> > +	unsigned long addr;
> > +
> > +	*name = btf_name_by_offset(btf, t->name_off);
> > +	addr = kallsyms_lookup_name(*name);
> > +	if (!addr)
> > +		return -ENOENT;
> > +
> > +	return addr;
> > +}
> > +EXPORT_SYMBOL_GPL(bpf_lookup_type_addr);
> 
> Let's namespecify all these new exports? EXPORT_SYMBOL_NS_GPL

Ah didn't know about this. Makes sense - will do.

Thanks,
Daniel

