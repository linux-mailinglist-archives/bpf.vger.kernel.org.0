Return-Path: <bpf+bounces-12368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB13F7CB90D
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 05:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C4A1C20CAC
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 03:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973278838;
	Tue, 17 Oct 2023 03:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca9gWVD3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB918493;
	Tue, 17 Oct 2023 03:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39403C433C9;
	Tue, 17 Oct 2023 03:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697512328;
	bh=0Sc52fvrh+1ReL7Iv+Sgdmsk1YhK0rif0JdH+z7Kbig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ca9gWVD3DkGJWbF7EFUPFRdyqoniZX3qtjAOMWLZLCNqkj3RSWg1fxF9T7B9opp6Y
	 an/2X6MVvW/h9hiBdLU48J3p+Ny0xhrOj5NG/m20QBymP4pkzNx8TXsUquYITehJNR
	 ED7xTuhKjr4YKRU7YRcC+6SvgeHmCfG8orBI8tf5jwDc6LpGfcvKyf4XerqN5+vK9b
	 g4ZPylqMZC7uECwvNJpyNiSwgkcs/xASe1BIQyMsHrHWhkmk2NNQrYBBbD/1actWoN
	 3iOsUhZnCIgcgkGOKSwOsFA9PzL+BxWQdrxyQXW1JbFy/h2m8mOFR2hW4FBgIVqM++
	 asyQXLa32+RSA==
Date: Mon, 16 Oct 2023 20:12:06 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	kernel-team@meta.com, tytso@mit.edu, roberto.sassu@huaweicloud.com
Subject: Re: [PATCH bpf-next 2/5] bpf, fsverity: Add kfunc
 bpf_get_fsverity_digest
Message-ID: <20231017031206.GA1907@sol.localdomain>
References: <20231013182644.2346458-1-song@kernel.org>
 <20231013182644.2346458-3-song@kernel.org>
 <20231015070714.GF10525@sol.localdomain>
 <CAPhsuW42L6cfyxLR30kc1zSWQr8_JyxoUv1EuRVZpoAix3bm8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW42L6cfyxLR30kc1zSWQr8_JyxoUv1EuRVZpoAix3bm8A@mail.gmail.com>

On Mon, Oct 16, 2023 at 01:10:40PM -0700, Song Liu wrote:
> On Sun, Oct 15, 2023 at 12:07 AM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> [...]
> > > + */
> > > +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_dynptr_kern *digest_ptr)
> > > +{
> > > +     const struct inode *inode = file_inode(file);
> > > +     struct fsverity_digest *arg = digest_ptr->data;
> >
> > What alignment is guaranteed here?
> 
> drnptr doesn't not provide alignment guarantee for digest_ptr->data.
> If we need alignment guarantee, we need to add it here.

So technically it's wrong to cast it to struct fsverity_digest, then.

> >
> > Also, it looks like I'm being signed up to maintain this.  This isn't a stable
> > UAPI, right?  No need to document this in Documentation/?
> 
> BPF kfuncs are not UAPI. They are as stable as exported symbols.
> We do have some documents for BPF kfuncs, for example in
> Documentation/bpf/cpumasks.rst.
> 
> Do you have a recommendation or preference on where we should
> document this? AFAICT, we can either add it to fsverity.rst or somewhere
> in Documentation/bpf/.

The BPF documentation seems like the right place.

- Eric

