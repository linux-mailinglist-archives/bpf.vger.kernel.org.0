Return-Path: <bpf+bounces-51201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F27F7A31BD2
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 03:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D17188562D
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 02:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A3F78F4E;
	Wed, 12 Feb 2025 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SIRgrEVz"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798DB38F83
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 02:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326761; cv=none; b=SGFd2Jbega+v3843E3xPzCscwxyZaF5+QoNap4vKACQn/QsqA512f5JYgANetjkUbtkpr6wogtPDgTYOS9v56mbyIhbIuwxXXGKGImGaIH/apeSkmcEdH5aq8wYnwCChgFF46CL+yWSXugrUhIlqC4+lH092NdUA2pFl3IW9CVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326761; c=relaxed/simple;
	bh=VS0GffbrCQ31gQJcynN1JNxjAg9dZ33xog1XQraBx1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJBwWEooIJ+4ppwy+enWEHFwQRAFMrKjth/+OGbWtGSECeU9kt6mIrNDbHByhiHHVgQwjmnpKNDn2hdw/6V5CdmVR2Jcw/tFG3MRFDGWSS237U+dkshoTM55Z6A0rIAWQBWNc6c6S/IzidCnacWRfPuByqqIjsyLKcJSHIkG7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SIRgrEVz; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 11 Feb 2025 18:19:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739326753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/PrdOYf+cocVZXALOGcooQ2F4OMml7rld1/5kS0xM4=;
	b=SIRgrEVzouk2U29247DrdXzcPbTxZbnaW97zmnUqFCx90sKyxOcwTXA/l7SOCLmSkHVrxz
	KQhP/vY+y0Ie+chX4Rv1HEvECTyghRepdlqZ/yDvVUOvwwEnKe8WgnyPnQD84C3IDoWHEC
	9syG0KTu0G05wfS2zh0jAeaS83ZtZ7k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jordan Rome <linux@jordanrome.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Potapenko <glider@google.com>
Subject: Re: [bpf-next v7 1/3] mm: add copy_remote_vm_str
Message-ID: <mvrphlxx4r5mj7cmzsvmx3v6wcuo3pvjpfb5sva2jcmh34ye2p@dzfxxaymvnk3>
References: <20250210221626.2098522-1-linux@jordanrome.com>
 <CAEf4BzYjsLnrCV9PK8gmyiFw8idXea5ckPRvCqhFbyEU5Wcd9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYjsLnrCV9PK8gmyiFw8idXea5ckPRvCqhFbyEU5Wcd9w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 11, 2025 at 02:07:31PM -0800, Andrii Nakryiko wrote:
> On Mon, Feb 10, 2025 at 2:23 PM Jordan Rome <linux@jordanrome.com> wrote:
> >
> > Similar to `access_process_vm` but specific to strings.
> > Also chunks reads by page and utilizes `strscpy`
> > for handling null termination.
> >
> > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > ---
> >  include/linux/mm.h |   3 ++
> >  mm/memory.c        | 119 +++++++++++++++++++++++++++++++++++++++++++++
> >  mm/nommu.c         |  73 +++++++++++++++++++++++++++
> >  3 files changed, 195 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 7b1068ddcbb7..aee23d84ce01 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2486,6 +2486,9 @@ extern int access_process_vm(struct task_struct *tsk, unsigned long addr,
> >  extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
> >                 void *buf, int len, unsigned int gup_flags);
> >
> > +extern int copy_remote_vm_str(struct task_struct *tsk, unsigned long addr,
> > +               void *buf, int len, unsigned int gup_flags);
> > +
> >  long get_user_pages_remote(struct mm_struct *mm,
> >                            unsigned long start, unsigned long nr_pages,
> >                            unsigned int gup_flags, struct page **pages,
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 539c0f7c6d54..e9d8584a7f56 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -6803,6 +6803,125 @@ int access_process_vm(struct task_struct *tsk, unsigned long addr,
> >  }
> >  EXPORT_SYMBOL_GPL(access_process_vm);
> >
> > +/*
> > + * Copy a string from another process's address space as given in mm.
> > + * If there is any error return -EFAULT.
> > + */
> > +static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
> > +                             void *buf, int len, unsigned int gup_flags)
> > +{
> > +       void *old_buf = buf;
> > +       int err = 0;
> > +
> > +       *(char *)buf = '\0';
> 
> LGTM overall:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> But note that all this unconditional buf access will be incorrect if
> len == 0. So either all of that has to be guarded with `if (len)`,
> just dropped, or declared unsupported, depending on what mm folks
> think. BPF helper won't ever call with len == 0, so that's why my ack.

I think early return 0 on len == 0 should be fine.

