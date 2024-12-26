Return-Path: <bpf+bounces-47641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 930009FCDD5
	for <lists+bpf@lfdr.de>; Thu, 26 Dec 2024 22:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC2318833CF
	for <lists+bpf@lfdr.de>; Thu, 26 Dec 2024 21:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2512218B46E;
	Thu, 26 Dec 2024 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icmTzly/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9948533E1;
	Thu, 26 Dec 2024 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735247975; cv=none; b=QXQADb+LMee58Nxmy9NJSdO/qrqXdyVaXbI+4Zl53WK/kGHKbHln4D98veN0uMcp+KtFsVNedPFFeh/mE74DeFTTvwvWdYnaQIrx0mv/4hTNPc79Q06diHDXrnIZBHeE0qRQsfSjkVCRjjmLRtVunmSwtmNQ3xzpWL2j8r2QPxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735247975; c=relaxed/simple;
	bh=oXezXdLl02Y1+/BmoYocjDwKBbLKHaxLDcFwjZf4zNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMYCTP/cDhGVnYXDot08HgfH/z4zFWuU8s3uNCgqNHe6qtlfEIONv2CKHeSJkbCDE7xQv2GmJE9jiEbnoH6K2nRebcqdmRgc84aF1L/SrWimgTteofjxoyy+xP6DErE/VBKxyyLxSpH7A7bsyvO2ZNC7iQo0sbIDWF86EBkEwCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icmTzly/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D100BC4CED1;
	Thu, 26 Dec 2024 21:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735247975;
	bh=oXezXdLl02Y1+/BmoYocjDwKBbLKHaxLDcFwjZf4zNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=icmTzly/uM9WxmeMG5TwyFhtRfKcDqVJXA7K3SLGdT3R0JQeAQOe4bevxMd2IR+ix
	 i8bMmydunJimhp69xMgxUvgxKFmYjXs2pMysZ3wstfB5i+x03s2+nJQ6oTbwlL+AUd
	 Ve+T8PxNxisksULxZSjZy5UMfIkDJkeny1Xvsg6+MFidxm+iOtx0f4hOmAR6XsFRCA
	 7veiATgJaDz9pUEeijJimmbM5uhPjJHdHlRSMa6591jpbDYk4Qi/tl/Ke6Oj28Mw3J
	 N9ARCaktgu570peEVoF0gCgVa38Ud0a+7O5yen4EfiEQDyKRSsiA3ZxmdS1JCPYk9N
	 tWIx8hWvS7uIA==
Date: Thu, 26 Dec 2024 18:19:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org,
	arnaldo.melo@gmail.com, bpf@vger.kernel.org, kernel-team@fb.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH dwarves v1 2/2] tests: verify that pfunct prints
 btf_decl_tags read from BTF
Message-ID: <Z23IZBu5yp9LnJ4_@x1>
References: <20241211021227.2341735-1-eddyz87@gmail.com>
 <20241211021227.2341735-2-eddyz87@gmail.com>
 <e7247151-ad60-402c-a3f8-ce976ea03dc0@oracle.com>
 <Z23Gmu_ot8svVJnx@x1>
 <Z23HIVBLFmFZ2KFB@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z23HIVBLFmFZ2KFB@x1>

On Thu, Dec 26, 2024 at 06:14:12PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Dec 26, 2024 at 06:11:57PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Dec 12, 2024 at 07:50:57PM +0000, Alan Maguire wrote:
> > > On 11/12/2024 02:12, Eduard Zingerman wrote:
> > > > When using BTF as a source, pfunct should now be able to print
> > > > btf_decl_tags for programs like below:
> > > > 
> > > >   #define __tag(x) __attribute__((btf_decl_tag(#x)))
> > > >   __tag(a) __tag(b) void foo(void) {}
> > > > 
> > > > This situation arises after recent kernel changes, where tags 'kfunc'
> > > > and 'bpf_fastcall' are added to some functions. To avoid dependency on
> > > > a recent kernel version test this by compiling a small C program using
> > > > clang with --target=bpf, which would instruct clang to generate .BTF
> > > > section.
> > > > 
> > > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > 
> > > nit: the test is great but it would be good to print out a description
> > > even in non-verbose mode; when I run it via ./tests I see
> > > 
> > >   5: Ok
> > > 
> > > could we just echo the comment below, i.e.
> > > 
> > > 5 : Check that pfunct can print btf_decl_tags read from BTF: Ok
> > > 
> > > ?
> 
> To clarify, I'm doing as Alan suggests and adding that message when the
> test succeeds.

Running just this test:

root@number:/home/acme/git/pahole# tests/pfunct-btf-decl-tags.sh
Check that pfunct can print btf_decl_tags read from BTF: Ok
root@number:/home/acme/git/pahole#
  
> > > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > > Tested-by: Alan Maguire <alan.maguire@oracle.com>
> > 
> > Thanks, applied.
> > 
> > - Arnaldo
> > 

