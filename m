Return-Path: <bpf+bounces-48369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E39AA06FC6
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 09:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240611889251
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 08:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED135214A95;
	Thu,  9 Jan 2025 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FrrMBTfz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634B8A2D;
	Thu,  9 Jan 2025 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736410374; cv=none; b=NYAylXSH6kVOhhImgVwrSRsLDkawO+YuH6GfcM/dJIo6hKkvmCBlZfvuZDO5/jFq1E0IM1p5mNt+T/8ErkCLPo4LlX8zvWB/c+SOM1Gu5391J8MtiwHKaGdUD5cO9Xd5r3fMFIzEHQlEso8racX3Uy1ToXoIEF4EfDtkadj/eHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736410374; c=relaxed/simple;
	bh=uVCQv/CBIXNIpASM0DI4JtJeCT5olizPHDkJTyHS+lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7vRqFPaw5pVfXpB/BP5wLoI9Xd84cH9DDeGDFVR2DQa6Q28yxorXl2OlLwBpqqJOQ45AGWEChkK5vV26qpYnJTdpT8Zxbx9qwxnZWJgc7CxRv4D/iyNgSB0xaGSUXHaPHcgLkn1HWoSH+PZSjo6Te/GVOpd4QAeWXI3OPBBm3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FrrMBTfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6212CC4CEDF;
	Thu,  9 Jan 2025 08:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736410374;
	bh=uVCQv/CBIXNIpASM0DI4JtJeCT5olizPHDkJTyHS+lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrrMBTfzNtXQ/slQQIzUvLn/JvqfmTWbbmaxK147f17gHXA9dgG/DAqaiIEE4V0p2
	 XjJL7CrL6beOUzI/i24yH1b84FJ18kcrPu8+IbC2WVaZ7Csc8bysfffEO9l0H1kcfK
	 ew/fnE1srRQnYw6SESiPp8ZceBF9N2bNnElaSX4A=
Date: Thu, 9 Jan 2025 09:12:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-modules@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] sysfs: constify bin_attribute argument of
 sysfs_bin_attr_simple_read()
Message-ID: <2025010930-resurrect-attest-94c9@gregkh>
References: <20241228-sysfs-const-bin_attr-simple-v2-0-7c6f3f1767a3@weissschuh.net>
 <CAADnVQ+E0z8mY4BF9qamPh1XV9qs2jZ03bfYz2tVw8E4nFVWBw@mail.gmail.com>
 <0cbfd352-ee3b-4670-afae-8e56d888e8c3@t-8ch.de>
 <CAADnVQJMV-zRcDKftZ-MbKEJQ7XGmPteMYCS0Bm5siBEXUK=Fw@mail.gmail.com>
 <2025010914-gangly-trodden-aa96@gregkh>
 <Z3-DcbY60SxoM0dN@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3-DcbY60SxoM0dN@infradead.org>

On Thu, Jan 09, 2025 at 12:06:09AM -0800, Christoph Hellwig wrote:
> On Thu, Jan 09, 2025 at 08:56:37AM +0100, Greg Kroah-Hartman wrote:
> > The "pointless" penalty will go away once we convert all instances, and
> > really, it's just one pointer check, sysfs files should NOT be a hot
> > path for anything real, and one more pointer check should be cached and
> > not measurable compared to the real logic behind the binary data coming
> > from the hardware/kernel, right?
> > 
> > sysfs is NOT tuned for speed at all, so adding more checks like this
> > should be fine.
> 
> Hey, when I duplicated the method to convert sysfs over to a proper
> seq_file based approach that avoids buffer overflows you basically
> came up with the same line that Alexei had here.

I did?  Sorry about that, I don't remember that.

> And that is a lot
> more useful than constification. Not that I mind the latter, but it
> would be better if it could be done without leaving both variants
> in for long.

I agree, we should get the read_new stuff out in the next kernel cycle I
hope.

As for seq_file for sysfs, is that for binary attributes only, or for
all?  I can't recall that at all.

thanks,

greg k-h

