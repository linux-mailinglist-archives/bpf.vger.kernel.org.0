Return-Path: <bpf+bounces-38604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60A0966AD7
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 22:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6BD1F23121
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 20:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48F41BF81E;
	Fri, 30 Aug 2024 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV/HdtQK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8B81BF33A;
	Fri, 30 Aug 2024 20:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050977; cv=none; b=Q3VYaMlc2OgtkWg5meP/2furX+oCrBCA3TmofKKwQ/4oNA6M11GPTDZdmTysrw4rJV7T8Z3UCRfAB7888aaIK1rwG1pb4hQ8JFdbVXT/dyRNfriVsFakk0hVSZBjwGrE9QPkoTQUB+pHuzezbo9E33XaIowhWNfV7eqLz03bBU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050977; c=relaxed/simple;
	bh=jSCw3hQQ/gHXS6sCJcdg7efLE4NjUVxqveuVsrCc5t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ai2kFwMGt+xtINJ0cADZoEttxY3u0BZRd/15y+oHv3DLP9t1glA36C2mEByVCJ0pajqWQ1KUimkeA/NuV4jpkKVD0kM3ODQdmZU//lmYB+pf76q5bJOSVH7JwXcz8i6DDejoO4EnGqb7iSYK3bU7DYFCWo3YdUXeeciPi/ZR6Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pV/HdtQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451F4C4CEC2;
	Fri, 30 Aug 2024 20:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725050976;
	bh=jSCw3hQQ/gHXS6sCJcdg7efLE4NjUVxqveuVsrCc5t0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pV/HdtQKYTWakqKxzXRz2xOPI9Pjf8roUf1mnZ3lIKheUEyoK0NvYbKAGPul1v+VQ
	 O33A06vktFYnq5ml7O3kzqNLq7++2RBQLYVPggQmgWlTM7WVh6C0LTIF8ytL594KEZ
	 gQ8tOU3LnlYLVuBGXBrX82zK3ISIW5Ivli6Le6qoDy1PPQH3l6lo9sYeqrfjEs0rR3
	 5YdolJksH+jxE4vVqZkXSR+FDu1I/lhOWflkMOiFwaaR5guXfE1FHoOKqhPHSShgIe
	 UcdcC49DWu+WdBwPqsO+KE2C2SWXR9BtjpRG0S/oOnX2SfEZfYRPeq66U6EhQPc6V0
	 er0mnLh8tzSmQ==
Date: Fri, 30 Aug 2024 17:49:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@meta.com>,
	"dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: FYI: CI regression on big-endian arch (s390) after recent pahole
 changes
Message-ID: <ZtIwXdl_WyYmdLFx@x1>
References: <6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com>
 <442C7AEC-2919-4307-8700-F7A0B60B5565@fb.com>
 <322d9bac47bc3732b77cf2cf23d69f2c4665bc36.camel@gmail.com>
 <860fe244-157b-46cf-9b41-ee9fd36f9c1e@oracle.com>
 <ZtHG9YwwG5kwiRFt@x1>
 <CAEf4Bza9OJckdJ4=nask2m+bJsiDszvoLoaf+GhVFu8CNarb=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza9OJckdJ4=nask2m+bJsiDszvoLoaf+GhVFu8CNarb=g@mail.gmail.com>

On Fri, Aug 30, 2024 at 08:56:08AM -0700, Andrii Nakryiko wrote:
> On Fri, Aug 30, 2024 at 6:19 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Fri, Aug 30, 2024 at 11:05:30AM +0100, Alan Maguire wrote:
> > > Arnaldo: apologies but I think we'll either need to back out the
> > > distilled stuff for 1.28 or have a new libbpf resync that captures the
> > > fixes for endian issues once they land. Let me know what works best for
> > > you. Thanks!
> >
> > It was useful, we got it tested more widely and caught this one.
> >
> > Andrii, what do you think? Can we get a 1.5.1 with this soon so that we
> > do a resying in pahole and then release 1.28?
> 
> Did you mean 1.4.6? We haven't released v1.5 just yet.
> 
> But yes, I'm going to cut a new set of bugfix releases to libbpf
> anyways, there is one more skeleton-related fix I have to backport.
> 
> So I'll try to review, land, and backport the fix ASAP.

Well, Alan sent patches updating libbpf to 1.5.0, so I misunderstood, I
think he meant what is to become 1.5.0, so even better, I think its just
a matter of updating the submodule sha:

⬢[acme@toolbox pahole]$ git show b6def578aa4a631f870568e13bfd647312718e7f
commit b6def578aa4a631f870568e13bfd647312718e7f
Author: Alan Maguire <alan.maguire@oracle.com>
Date:   Mon Jul 29 12:13:16 2024 +0100

    pahole: Sync with libbpf-1.5
    
    This will pull in BTF support for distilled base BTF.
    
    Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
    Cc: Alexei Starovoitov <ast@kernel.org>
    Cc: Andrii Nakryiko <andrii@kernel.org>
    Cc: Eduard Zingerman <eddyz87@gmail.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: bpf@vger.kernel.org
    Cc: dwarves@vger.kernel.org
    Link: https://lore.kernel.org/r/20240729111317.140816-2-alan.maguire@oracle.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/lib/bpf b/lib/bpf
index 6597330c45d18538..686f600bca59e107 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 6597330c45d185381900037f0130712cd326ae59
+Subproject commit 686f600bca59e107af4040d0838ca2b02c14ff50
⬢[acme@toolbox pahole]$

Right?

- Arnaldo

