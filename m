Return-Path: <bpf+bounces-12383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7493E7CBA52
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 07:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0360F281815
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 05:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE56FC150;
	Tue, 17 Oct 2023 05:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8pdVmYW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CF27497;
	Tue, 17 Oct 2023 05:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7894EC433C7;
	Tue, 17 Oct 2023 05:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697521599;
	bh=m5LpdaG4f66VMAb3UY3k5aiyDLslELQ/vGC63Fq37hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z8pdVmYWVJVh5JxS0TFitm4TvGodej9NloolCvCPVhtnK4BRfk0t/l1VNqEc44fHS
	 OXJkAqJ1k45PFpTnx323weVk01TSIm+c1jyXsbkMIFGXVhsOJvw557llAb3+SDQsHT
	 jcb3H9T0YniVM6M/I9cOGNpXvHiT+GzEMWBHx2cd1wiu+1bTEJElV+yD+fatKP51ym
	 JXu1YFGmPVcXTpLYNu54HG0s9YtK8Mqm2AMiwflltGACBY5Lg/ilifL484bufZWPmw
	 BiKDvxd0wvcOlUn/Eq9kSAoXSULWClA46z5FoktvGC6my1wECyRNv38s4sW2XUwHjH
	 hRk6GFRa70Ycw==
Date: Mon, 16 Oct 2023 22:46:37 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	kernel-team@meta.com, tytso@mit.edu, roberto.sassu@huaweicloud.com
Subject: Re: [PATCH bpf-next 2/5] bpf, fsverity: Add kfunc
 bpf_get_fsverity_digest
Message-ID: <20231017054637.GH1907@sol.localdomain>
References: <20231013182644.2346458-1-song@kernel.org>
 <20231013182644.2346458-3-song@kernel.org>
 <20231015070714.GF10525@sol.localdomain>
 <CAPhsuW42L6cfyxLR30kc1zSWQr8_JyxoUv1EuRVZpoAix3bm8A@mail.gmail.com>
 <20231017031206.GA1907@sol.localdomain>
 <CAPhsuW4u2GNL8BmEPPtYjc1KtP4Dx+wqtX1fc2eMPYB_6LmrRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4u2GNL8BmEPPtYjc1KtP4Dx+wqtX1fc2eMPYB_6LmrRA@mail.gmail.com>

On Mon, Oct 16, 2023 at 10:35:16PM -0700, Song Liu wrote:
> On Mon, Oct 16, 2023 at 8:12 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Mon, Oct 16, 2023 at 01:10:40PM -0700, Song Liu wrote:
> > > On Sun, Oct 15, 2023 at 12:07 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > > >
> > > [...]
> > > > > + */
> > > > > +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr_kern *digest_ptr)
> > > > > +{
> > > > > +     const struct inode *inode = file_inode(file);
> > > > > +     struct fsverity_digest *arg = digest_ptr->data;
> > > >
> > > > What alignment is guaranteed here?
> > >
> > > drnptr doesn't not provide alignment guarantee for digest_ptr->data.
> > > If we need alignment guarantee, we need to add it here.
> >
> > So technically it's wrong to cast it to struct fsverity_digest, then.
> 
> We can enforce alignment here. Would __aligned(2) be sufficient?
> 

Do you mean something like the following:

	if (!IS_ALIGNED((uintptr_t)digest_ptr->data, __alignof__(*arg)))
		return -EINVAL;

