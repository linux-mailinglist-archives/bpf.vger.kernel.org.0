Return-Path: <bpf+bounces-54161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F91A63F59
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 06:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0513ABDDD
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 05:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB41E218AA5;
	Mon, 17 Mar 2025 05:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mrabfq0n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6749F155757;
	Mon, 17 Mar 2025 05:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742188538; cv=none; b=axH4jte59WrdUhTUrKQfc68vRV2Jylerkq22e6FrWtjydls8Q4SgQo7fL7lGDDRtjQUmO1MaESPYL8ZlUJnLr1Ts4b6CzZaQN07SBbJ47szctP8sKj1E4uwEK5siDM9SGxgeciLAd/rli5mMwdyGJGyb+XkCsRh7jGLsmYO9/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742188538; c=relaxed/simple;
	bh=biacf0Mv1ywcq2xxM8wpuuvYXaqqgfMZO8M0hMECUXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z05jwcC1fFJuC5OgmzAGVBjDLW29xORtIj6cFQGRVbzHRdi/EtLN6cNjsChMHyIdZMSugb2nLbQXjGaciXYNgCkgZY+eMipMAxQ+8jMkQOtzHU+vNVBqhJ71M7XPxrjb7SW9U8AA6YbZ45BohMEWnbTg778toLNxbbV93+QiqO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mrabfq0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C15FC4CEEE;
	Mon, 17 Mar 2025 05:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742188538;
	bh=biacf0Mv1ywcq2xxM8wpuuvYXaqqgfMZO8M0hMECUXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mrabfq0nkgmzjoQMx+mb2o6w/XKoScCIqS945IV0N/PxyQLvXLYUT2MWA16HC42Lq
	 LQsz2Sch2SLYd648Twi6ThOwcIWiEMQFaoQTggw/pGpkUvUXieAgRb502uIrRX5eq3
	 LWrO1Bcm5A+OxcFMIfRhGCR1nTwq0Fa2I4YAU4pY=
Date: Mon, 17 Mar 2025 06:14:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Linxuan <chenlinxuan@deepin.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Jann Horn <jannh@google.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Yi Lai <yi1.lai@intel.com>, Daniel Borkmann <daniel@iogearbox.net>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH stable 6.6 v2] lib/buildid: Handle memfd_secret() files
 in build_id_parse()
Message-ID: <2025031743-haunt-masculine-afb4@gregkh>
References: <84B05ADD5527685D+20250317011604.119801-2-chenlinxuan@deepin.org>
 <2025031759-sacrifice-wreckage-9948@gregkh>
 <CAC1kPDNNBj3Hd6s72mA3qxwxC0B69aE7qhM+Az5msvjPy41N5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC1kPDNNBj3Hd6s72mA3qxwxC0B69aE7qhM+Az5msvjPy41N5w@mail.gmail.com>

On Mon, Mar 17, 2025 at 01:04:41PM +0800, Chen Linxuan wrote:
> Greg KH <greg@kroah.com> 于2025年3月17日周一 12:20写道：
> >
> > On Mon, Mar 17, 2025 at 09:16:04AM +0800, Chen Linxuan wrote:
> > > [ Upstream commit 5ac9b4e935dfc6af41eee2ddc21deb5c36507a9f ]
> > >
> > > >>From memfd_secret(2) manpage:
> > >
> > >   The memory areas backing the file created with memfd_secret(2) are
> > >   visible only to the processes that have access to the file descriptor.
> > >   The memory region is removed from the kernel page tables and only the
> > >   page tables of the processes holding the file descriptor map the
> > >   corresponding physical memory. (Thus, the pages in the region can't be
> > >   accessed by the kernel itself, so that, for example, pointers to the
> > >   region can't be passed to system calls.)
> > >
> > > We need to handle this special case gracefully in build ID fetching
> > > code. Return -EFAULT whenever secretmem file is passed to build_id_parse()
> > > family of APIs. Original report and repro can be found in [0].
> > >
> > >   [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
> > >
> > > Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader abstraction")
> > > Reported-by: Yi Lai <yi1.lai@intel.com>
> > > Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> > > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > Link: https://lore.kernel.org/bpf/20241017175431.6183-A-hca@linux.ibm.com
> > > Link: https://lore.kernel.org/bpf/20241017174713.2157873-1-andrii@kernel.org
> > > [ Chen Linxuan: backport same logic without folio-based changes ]
> > > Cc: stable@vger.kernel.org
> > > Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
> > > Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>
> > > ---
> > > v1 -> v2: use vma_is_secretmem() instead of directly checking
> > >           vma->vm_file->f_op == &secretmem_fops
> > > ---
> > >  lib/buildid.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/lib/buildid.c b/lib/buildid.c
> > > index 9fc46366597e..34315d09b544 100644
> > > --- a/lib/buildid.c
> > > +++ b/lib/buildid.c
> > > @@ -5,6 +5,7 @@
> > >  #include <linux/elf.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/pagemap.h>
> > > +#include <linux/secretmem.h>
> > >
> > >  #define BUILD_ID 3
> > >
> > > @@ -157,6 +158,10 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
> > >       if (!vma->vm_file)
> > >               return -EINVAL;
> > >
> > > +     /* reject secretmem */
> >
> > Why is this comment different from what is in the original commit?  Same
> > for your other backports.  Please try to keep it as identical to the
> > original whenever possible as we have to maintain this for a very long
> > time.
> >
> > thanks,
> >
> > greg k-h
> >
> >
> 
> Original comment is in a function named freader_get_folio(),
> but folio related changes has not been backported yet.

That's fine, but the logic is the same so keep the original code as
close as possible.  Otherwise it looks like this is a totally different
change and we would have to reject it for obvious reasons.

thanks,

greg k-h

