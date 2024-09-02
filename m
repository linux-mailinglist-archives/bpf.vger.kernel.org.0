Return-Path: <bpf+bounces-38705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15125968977
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 16:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E9A283F54
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 14:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B5121018A;
	Mon,  2 Sep 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlqDdG08"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A988319E992;
	Mon,  2 Sep 2024 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286133; cv=none; b=J4wfBji9R+2R2f3taPExzzF4XMYroHMzc9T4uwkBOe1E9Xu7u2jFBxZHrq4Q49CBnlYrNw00LwLSanuhL5AqvCjmkYDcPV+gMT0tJK/98YoYTspV4BGh5P47aNr0aBbOAcwnfN0XDVXjZcEXi1ZkQTN6QPCV9mbo7ZnF05NhceY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286133; c=relaxed/simple;
	bh=1veHNHEwLmZrEaVhmnBY7wrWSGEeHi+8/W3xIx+CqaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aA5VFcC8NmACLxhg0yzb7OjmYDYBLo5AoaIgT6+RN0GcPT1NSurS2xDmALONxQT5tr8pjglXqYiqGdWBbgyw+Jj/g9QAICWb5q7DnGbGJyOnsfUl/9cTOg8Qw2cmsTCpfUMTYnV1hNk84PvItwJGwbW9e4gSfqD0JVT0ZPyZslc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlqDdG08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3A2C4CEC2;
	Mon,  2 Sep 2024 14:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725286133;
	bh=1veHNHEwLmZrEaVhmnBY7wrWSGEeHi+8/W3xIx+CqaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlqDdG08aB0PUTwZ+CDybwQ51eAiu6wmXZ9qqypbObOKhvyUTTALmb3KsSN5Nafjy
	 p0G5WA40R4jbvl0RGV9F3DCQBDtgNzspI3BED0RGWnacawwRv5xKVEK5a3b3mAHrV+
	 hds1AzaIwZAp0XO9kxJPz8+Pi/iAa6R0m4tzPxzmsWDXtTLR+sQfkldDDzb01J9viA
	 2l0vn+rJLxfoM/OevVvZNnzE/prODNrghuEVXcx0SEd22Zz/WW3X965uEka6rxzjHg
	 pX2T9HxLtm5QeqWUvPEwVCefKB8bPUfSa0YAjGU2pcbNzXsNNDr4F1c0T4WvYWXrzM
	 HIwfcKiUdO7PA==
Date: Mon, 2 Sep 2024 11:08:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@meta.com>,
	"dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: FYI: CI regression on big-endian arch (s390) after recent pahole
 changes
Message-ID: <ZtXG8TTMXTzXUkRg@x1>
References: <6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com>
 <442C7AEC-2919-4307-8700-F7A0B60B5565@fb.com>
 <322d9bac47bc3732b77cf2cf23d69f2c4665bc36.camel@gmail.com>
 <860fe244-157b-46cf-9b41-ee9fd36f9c1e@oracle.com>
 <ZtHG9YwwG5kwiRFt@x1>
 <CAEf4Bza9OJckdJ4=nask2m+bJsiDszvoLoaf+GhVFu8CNarb=g@mail.gmail.com>
 <ZtIwXdl_WyYmdLFx@x1>
 <CAEf4BzY5kx9HayBCViuXf0i7DyvFgcRObvnA1u3bqot2WjfyGg@mail.gmail.com>
 <2bd94dc7-172f-49c0-87c8-e3c51c840082@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2bd94dc7-172f-49c0-87c8-e3c51c840082@oracle.com>

On Fri, Aug 30, 2024 at 11:34:40PM +0100, Alan Maguire wrote:
> On 30/08/2024 23:20, Andrii Nakryiko wrote:
> > On Fri, Aug 30, 2024 at 1:49 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >> On Fri, Aug 30, 2024 at 08:56:08AM -0700, Andrii Nakryiko wrote:
> >> +++ b/lib/bpf
> >> @@ -1 +1 @@
> >> -Subproject commit 6597330c45d185381900037f0130712cd326ae59
> >> +Subproject commit 686f600bca59e107af4040d0838ca2b02c14ff50
> >> ⬢[acme@toolbox pahole]$

> >> Right?

> > Yes, and I'm doing another Github sync today.

So, I just commited this locally:

⬢[acme@toolbox pahole]$ git show
commit 5fd558301891d1c0456fcae79798a789b499c1f9 (HEAD -> master)
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Sep 2 11:05:06 2024 -0300

    libbpf: Sync with master, i.e. what will become 1.5.0
    
    To pick this distilled BPF fix:
    
      fe28fae57a9463fbf ("libbpf: Ensure new BTF objects inherit input endianness")
    
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/lib/bpf b/lib/bpf
index 686f600bca59e107..caa17bdcbfc58e68 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 686f600bca59e107af4040d0838ca2b02c14ff50
+Subproject commit caa17bdcbfc58e68eaf4d017c058e6577606bf56
⬢[acme@toolbox pahole]$

Ack?
 
> > Separate question, I think pahole supports the shared library version
> > of libbpf, as an option, is that right? How do you guys handle missing
> > APIs for distilled BTF in such a case?
 
> Good question - at present the distill-related code is conditionally
> compiled if LIBBPF_MAJOR_VERSION >=1 and LIBBF_MINOR_VERSION >= 5; so if
> an older shared library libbpf+headers is used, the btf_feature is
> simply ignored as if we didn't know about it. See [1] for the relevant
> code in btf_encoder.c. This problem doesn't arise if we're using the
> synced libbpf.
 
> There might be a better way to handle this, but I think that's enough to
> ensure we avoid compilation failures at least.

I guess this is good enough,

- Arnaldo
 
> [1]
> https://github.com/acmel/dwarves/blob/fd14dc67cb6aaead553074afb4a1ddad10209892/btf_encoder.c#L1766

