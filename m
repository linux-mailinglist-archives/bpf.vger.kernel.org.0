Return-Path: <bpf+bounces-48367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D2EA06F91
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 08:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B0D3A1809
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 07:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E310E214A70;
	Thu,  9 Jan 2025 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0eH39eGh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534661714D7;
	Thu,  9 Jan 2025 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409449; cv=none; b=NTR3Ba3HyRSz0Zqo184RmiYFdurJqOkuH9luuCOt810U7SUzbFjgGgmMGObSf/TK8e8TIrNyqsvoHs8VyPk+Kts9QpgY2Pi+KHS6kAJNELw1dxmiWs5JF4ZS8NvrXSdTe5aKPVPfPNGk91j2oX+9bDuEXIp8VsVCzhM8K+jFJuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409449; c=relaxed/simple;
	bh=la/AGYY75gNYY12SISkKn5wPrr5eGjIcyo23Hqc0rAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwwk98C8N6dIa/jGoVGbQzBpCBw6Mi/MvK9uXNZaEA0h3XHia89YnN8opwubwbgk2wetuCnzmaV2soPEI+XOb1tUevObFvXmP6TwhhB954dnIXxSlBXikAkZWdLT0Uikz3OOwfRQGw3L4SzDSjJ+40Q+VoHcNCL6BXAI1AgRtFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0eH39eGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B10C4CED2;
	Thu,  9 Jan 2025 07:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736409447;
	bh=la/AGYY75gNYY12SISkKn5wPrr5eGjIcyo23Hqc0rAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0eH39eGhMX8OPsBsF7mpcicMTjnKnyc/btU0UDMpYSoY0cwPEtwdkrCg9jt9cqc72
	 xwWOru/ApEbXd3aWI4vXRsBtmP8wiHiw+BjJC1kck32CnkKzl8kcjeNvjlJNVSiE8Q
	 lNHzio/+K8tM2k5MTABboHo3dwIFP5ucwxktGhNA=
Date: Thu, 9 Jan 2025 08:56:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
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
Message-ID: <2025010914-gangly-trodden-aa96@gregkh>
References: <20241228-sysfs-const-bin_attr-simple-v2-0-7c6f3f1767a3@weissschuh.net>
 <CAADnVQ+E0z8mY4BF9qamPh1XV9qs2jZ03bfYz2tVw8E4nFVWBw@mail.gmail.com>
 <0cbfd352-ee3b-4670-afae-8e56d888e8c3@t-8ch.de>
 <CAADnVQJMV-zRcDKftZ-MbKEJQ7XGmPteMYCS0Bm5siBEXUK=Fw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJMV-zRcDKftZ-MbKEJQ7XGmPteMYCS0Bm5siBEXUK=Fw@mail.gmail.com>

On Wed, Jan 08, 2025 at 09:45:45AM -0800, Alexei Starovoitov wrote:
> On Tue, Dec 31, 2024 at 2:30 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > On 2024-12-30 16:50:41-0800, Alexei Starovoitov wrote:
> > > On Sat, Dec 28, 2024 at 12:43 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
> > > >
> > > > Most users use this function through the BIN_ATTR_SIMPLE* macros,
> > > > they can handle the switch transparently.
> > > >
> > > > This series is meant to be merged through the driver core tree.
> > >
> > > hmm. why?
> >
> > Patch 1 changes the signature of sysfs_bin_attr_simple_read().
> > Before patch 1 sysfs_bin_attr_simple_read() needs to be assigned to the
> > callback member .read, after patch 1 it's .read_new.
> > (Both callbacks work exactly the same, except for their signature,
> > .read_new is only a transition mechanism and will go away again)
> >
> > > I'd rather take patches 2 and 3 into bpf-next to avoid
> > > potential conflicts.
> > > Patch 1 looks orthogonal and independent.
> >
> > If you pick up 2 and 3 through bpf-next you would need to adapt these
> > assignments. As soon as both patch 1 and the modified 2 and 3 hit
> > Linus' tree, the build would break due to mismatches function pointers.
> > (Casting function pointers to avoid the mismatch will blow up with KCFI)
> 
> I see. All these steps to constify is frankly a mess.
> You're wasting cpu and memory for this read vs read_new
> when const is not much more than syntactic sugar in C.
> You should have done one tree wide patch without doing this _new() hack.
> 
> Anyway, rant over. Carry patches 2,3. Hopefully they won't conflict.
> But I don't want to see any constification patches in bpf land
> that come with such pointless runtime penalty.

The "pointless" penalty will go away once we convert all instances, and
really, it's just one pointer check, sysfs files should NOT be a hot
path for anything real, and one more pointer check should be cached and
not measurable compared to the real logic behind the binary data coming
from the hardware/kernel, right?

sysfs is NOT tuned for speed at all, so adding more checks like this
should be fine.

thanks,

greg k-h

