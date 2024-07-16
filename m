Return-Path: <bpf+bounces-34906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9A2932348
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 11:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCEBDB21A5A
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 09:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B389197A72;
	Tue, 16 Jul 2024 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNdby14H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C8655896;
	Tue, 16 Jul 2024 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123157; cv=none; b=pL7OM9S63cDJMiYbgvt4RNLQebMTpM6p1uJbNbzZ69MW2EqGwmhfCT4m26NLpZ1PxrzWMSMexMujqtI4cU9qDx7+kI20NEWDcNTgOigqDcWlATRy07mO+XGtpsTlb6SCWfmBXwRI28futFZ7OAYtiYgzFoLyTOSPrcvRGovfCQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123157; c=relaxed/simple;
	bh=SqXgNm6FhzAJA14mBWUxDsVvY4d+YHMpCRQGynbdfDE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NefZ1agLAdW5rZ/JgVceYEh6XQnH5+CRAL72VpKqunYzk8IQDRExqU9uZ9Ju1K+TuGBYystYD9/nrohrSZth0Ti3uxuVoegQa/Qa9/Y2QPdOUqpCjd9sUgzWNJ4Oj/oCNio1hRHb0aqMxOLGjWbHwsRq1kjEBm6xbzOf9VjDbpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNdby14H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA146C116B1;
	Tue, 16 Jul 2024 09:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721123156;
	bh=SqXgNm6FhzAJA14mBWUxDsVvY4d+YHMpCRQGynbdfDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gNdby14HQ2ApZ0VAhsv66j6UvRn5Salr683iDSupG4UaBeZz3im4hmb7e8qgpkmF8
	 ZqLreb1UdfoR7cJHu4k1Umj3o18fFw+vlSVBn6dpVUaLH4GhcwjILYRKe68LDxB5fe
	 qkRE1k5avvu8yT+D/M3yf1ZClg6IQl6Xpzzw6VG74nZ1x7ADbWIJjbTXnee65e7c0c
	 ItzKSFgmm3+5+V9pV61+RHXrjqatLO/ofe96tkY+QqksRD2V0KB36GNhKkkSspT3Zx
	 c15TfackFDw9V/0UOa0m9nfvayW+mh54Gsr+qeQQoG3WVlpklIYGwP/RMN4jtIeEkt
	 YWiPHW4xxHGxg==
Date: Tue, 16 Jul 2024 18:45:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Naveen N Rao <naveen@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bpf@vger.kernel.org, Daniel Borkmann
 <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 2/2] MAINTAINERS: Update powerpc BPF JIT maintainers
Message-Id: <20240716184551.a16cfd72b3f31148b0e9170a@kernel.org>
In-Reply-To: <92e61201-2ee4-458d-988d-a476018a05dc@linux.ibm.com>
References: <fb6ef126771c70538067709af69d960da3560ce7.1720944897.git.naveen@kernel.org>
	<24fea21d9d4458973aadd6a02bb1bf558b8bd0b2.1720944897.git.naveen@kernel.org>
	<92e61201-2ee4-458d-988d-a476018a05dc@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Tue, 16 Jul 2024 12:36:11 +0530
Hari Bathini <hbathini@linux.ibm.com> wrote:

> 
> 
> On 14/07/24 2:04 pm, Naveen N Rao wrote:
> > Hari Bathini has been updating and maintaining the powerpc BPF JIT since
> > a while now. Christophe Leroy has been doing the same for 32-bit
> > powerpc. Add them as maintainers for the powerpc BPF JIT.
> > 
> > I am no longer actively looking into the powerpc BPF JIT. Change my role
> > to that of a reviewer so that I can help with the odd query.
> > 
> > Signed-off-by: Naveen N Rao <naveen@kernel.org>
> 
> Acked-by: Hari Bathini <hbathini@linux.ibm.com>

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

But this should go through powerpc tree or bpf tree.

Thank you,

> 
> > ---
> >   MAINTAINERS | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 05f14b67cd74..c7a931ee7a2e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3878,8 +3878,10 @@ S:	Odd Fixes
> >   F:	drivers/net/ethernet/netronome/nfp/bpf/
> >   
> >   BPF JIT for POWERPC (32-BIT AND 64-BIT)
> > -M:	Naveen N Rao <naveen@kernel.org>
> >   M:	Michael Ellerman <mpe@ellerman.id.au>
> > +M:	Hari Bathini <hbathini@linux.ibm.com>
> > +M:	Christophe Leroy <christophe.leroy@csgroup.eu>
> > +R:	Naveen N Rao <naveen@kernel.org>
> >   L:	bpf@vger.kernel.org
> >   S:	Supported
> >   F:	arch/powerpc/net/


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

