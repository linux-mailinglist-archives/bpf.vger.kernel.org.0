Return-Path: <bpf+bounces-61749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39708AEB7DF
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 14:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566A05624B7
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 12:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E742D3EEB;
	Fri, 27 Jun 2025 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+XLj1Fs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC45C2676D9;
	Fri, 27 Jun 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751027963; cv=none; b=KnmdLttc19iFycxZ3l0O7tBLyaxEn58K4tFIiaDVSZfdMHHHg6+qUzVC3B42b00nKMx2otjxGW8LXkPX6DIF5t9JipGnTpKOQPUOunI5s3fmBN0/XQGgIdUD2MrUX6CtsZAnKeVsPWtSdEx2WY3qeT4V5jOdCJgEUtwxqm071RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751027963; c=relaxed/simple;
	bh=q+W9clFXyqixdZYt2TKB/ms9dW6S3Soe+H6EaggnXfw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfG9W0VIwZKncc3ZlzT+PyYRpj9lUYv70iK9pq77n9DvH54WtnihasP/OuQsTgaxCXNUfpFn7yaCOpKNV6ZyCqqmmeoCepp9Nz/NaR6mJQsoBD30NXEuWKNXiZSjGY+4aeuTtYuMyo9tx9OqbMi9GJyxaaY1cPtq47I524aItDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+XLj1Fs; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae35f36da9dso92894566b.0;
        Fri, 27 Jun 2025 05:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751027960; x=1751632760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a3IxdIJGANIbuM0EwIBljBl1VLujBY16tfZJpkoeXXk=;
        b=c+XLj1Fs/P3QwX9MH/dOYr9j1T5vbAOfZx1nZ3oGJpR41GD827DXCPxVZ41ZffYGXf
         kVYPCXyfyELnZe8Z7o2amsjp4Vw9liP79UVYutBU9p0tJaT0ysgIUs83SQya0SneCu1t
         H+33xHPzQbamSsUzwNaj7gPSiUBCuSiqmmHIKpcGcZXsmIusqxtpG+XdgnUJ+XfrG7nI
         8FUnznmZJ77yObXzzC53ZMriUb2aiLESlLEqImGsrPP9HsfgKmIeLcYhTGbpn4le8ucZ
         pT8XYOX8lWr8e7MmrxnPugPeg/MoRy0++ZwtRMIb2cWtG2II7tEFloKrt3M5z8Q+/8ck
         gHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751027960; x=1751632760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3IxdIJGANIbuM0EwIBljBl1VLujBY16tfZJpkoeXXk=;
        b=EfLexMmAQ1B3LIkLL21MtJHbcQRsaKh8iQk6s1KG8S/5vdiWCRiucvV6V0zuHlzds1
         82DunL+KZrJ9csNSXfyYzUs8FeufXO2D0BjcK55anPVqWcUR2gJmSfU8BqzYEuNduJW4
         qiAmfZytu4EKKrGAbgwbDq9anx9a/Lk40nQPEy5JV8UJN7QcQhY/yiycJNrkvmDqOz67
         Ij4j6LV7d7i8sQFm3Gsl9Atd/QvByxQM7/xHgNir2Oivky9AORIFTrcE96Z4inWLFHiI
         d3+cyQZe8A0wz5d+UWwv0FLpdOS5jCRFuBaGs3nqQfS9ZFlM+zlPvffo8J73BIbrECOO
         TlCA==
X-Forwarded-Encrypted: i=1; AJvYcCUZU63IvQVVuOrF7n/4HgYKWSgLv8R1Gi9dRgBw5iE97ab+5zL1fqxjBO3QaGeqTeVIDX5CGcrKoYkPCb0g@vger.kernel.org, AJvYcCWMyMTs8WBYkYwdBRCOJdIcMUYemR6TLzGOUHJcCvJ/gA8zdn56v6y+6Ba2HS7Pfs/HP2TQYZFNp8jigrr9jxLQ0Hvu@vger.kernel.org, AJvYcCXVjwV3gWDNwp94XBIxkdCLpv/KOURiJOsOuMQZreoOLPs0HHg3nYZHqeuXSb1iWznMTRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO1O3Bq5P1F7dw9hay5bsNkXmXzvr8YV6O0VAb8mw0W0STxe3Q
	aauSjgI3B/xmZCTTeCA1gVe8as9Ae3PU2Q1Fp0SAZgOGd1Q8vVNrvLF8
X-Gm-Gg: ASbGncsMz5kitBjegtkEuZhgMSqsipNcK+13tm/UgHAh1PyXKpiguwCWt71H9k5LBDE
	KZGa43+3NRrOEydxOYEWq+8hUWurlcZ4v2qDig6U600cEtrWuoK8nRx6lnqtiFDwAzZE0fvzxT/
	GP0M5ZoxJrjHL4I3HVL7Jk5tVYtTfX6UtXN9t3bCnCYpjCDHWI1p6sRpDipV7aYBOgDpx+qGeav
	1A/kAzzekw3i2sDXgNr3TAaapBBjoOCt55i8przV/ykyeyD6GdewpoOP5kbf752lqbkreduW6sf
	XfybDUIaZ/n7s/HHwlzF6assqN8oY2zj9pOjTfl3hLxrbop+ww==
X-Google-Smtp-Source: AGHT+IHsUZwSKf4TCEtGmaNkzr1qxFlEhEznA0V4fLhYIVRCyABvF+HRyhv/Eswv2pgIOA9WIQQi5A==
X-Received: by 2002:a17:907:948e:b0:ae3:5e70:32fc with SMTP id a640c23a62f3a-ae35e70374cmr189812066b.29.1751027959614;
        Fri, 27 Jun 2025 05:39:19 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca2bdasm118832466b.171.2025.06.27.05.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 05:39:19 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 27 Jun 2025 14:39:16 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv3 perf/core 08/22] uprobes/x86: Add mapping for optimized
 uprobe trampolines
Message-ID: <aF6Q9NgCJx5p0MNJ@krava>
References: <20250605132350.1488129-1-jolsa@kernel.org>
 <20250605132350.1488129-9-jolsa@kernel.org>
 <20250625172122.ad1e955ae2bc3957d9fb8546@kernel.org>
 <aFwS2EENyOFh7IbY@krava>
 <20250627150145.15cdec0f4991a99f997a8168@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627150145.15cdec0f4991a99f997a8168@kernel.org>

On Fri, Jun 27, 2025 at 03:01:45PM +0900, Masami Hiramatsu wrote:

SNIP

> > > 
> > > > +			return tramp;
> > > > +	}
> > > > +
> > > > +	tramp = create_uprobe_trampoline(vaddr);
> > > > +	if (!tramp)
> > > > +		return NULL;
> > > > +
> > > > +	*new = true;
> > > > +	hlist_add_head(&tramp->node, &state->head_tramps);
> > > > +	return tramp;
> > > > +}
> > > > +
> > > > +static void destroy_uprobe_trampoline(struct uprobe_trampoline *tramp)
> > > > +{
> > > > +	hlist_del(&tramp->node);
> > > > +	kfree(tramp);
> > > 
> > > Don't we need to unmap the tramp->vaddr?
> > 
> > that's tricky because we have no way to make sure the application is
> > no longer executing the trampoline, it's described in the changelog
> > of following patch:
> > 
> >     uprobes/x86: Add support to optimize uprobes
> > 
> >     ...
> > 
> >     We do not unmap and release uprobe trampoline when it's no longer needed,
> >     because there's no easy way to make sure none of the threads is still
> >     inside the trampoline. But we do not waste memory, because there's just
> >     single page for all the uprobe trampoline mappings.
> > 
> 
> I think we should put this as a code comment.

ok

> 
> >     We do waste frame on page mapping for every 4GB by keeping the uprobe
> >     trampoline page mapped, but that seems ok.
> 
> Hmm, this is not right with the current find_nearest_page(), because
> it always finds a page from the farthest +2GB range until it is full.
> Thus, in the worst case, if we hits uprobes with the order of
> uprobe0 -> 1 -> 2 which is put as below;
> 
> 0x0abc0004  [uprobe2]
> ...
> 0x0abc2004  [uprobe1]
> ...
> 0x0abc4004  [uprobe0]
> 
> Then the trampoline pages can be allocated as below.
> 
> 0x8abc0000  [uprobe_tramp2]
> [gap]
> 0x8abc2000  [uprobe_tramp1]
> [gap]
> 0x8abc4000  [uprobe_tramp0]
> 
> Using true "find_nearest_page()", this will be mitigated. But not
> allocated for "every 4GB". So I think we should drop that part
> from the comment :)

I think you're right, it's better to start with nearest page,
will change it in new version

SNIP

> > > > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > > > index 5080619560d4..b40d33aae016 100644
> > > > --- a/include/linux/uprobes.h
> > > > +++ b/include/linux/uprobes.h
> > > > @@ -17,6 +17,7 @@
> > > >  #include <linux/wait.h>
> > > >  #include <linux/timer.h>
> > > >  #include <linux/seqlock.h>
> > > > +#include <linux/mutex.h>
> > > >  
> > > >  struct uprobe;
> > > >  struct vm_area_struct;
> > > > @@ -185,6 +186,9 @@ struct xol_area;
> > > >  
> > > >  struct uprobes_state {
> > > >  	struct xol_area		*xol_area;
> > > > +#ifdef CONFIG_X86_64
> > > 
> > > Maybe we can introduce struct arch_uprobe_state{} here?
> > 
> > ok, on top of that Andrii also asked for [1]:
> >   - alloc 'struct uprobes_state' for mm_struct only when needed
> > 
> > this could be part of that follow up? I'd rather not complicate this
> > patchset any further
> > 
> > [1] https://lore.kernel.org/bpf/CAEf4BzY2zKPM9JHgn_wa8yCr8q5KntE5w8g=AoT2MnrD2Dx6gA@mail.gmail.com/
> 
> Hmm, OK. But if you need to avoid #ifdef CONFIG_<arch>,
> you can use include/asm-generic to override macros.
> 
> struct uprobes_state {
>  struct xol_area *xol_area;
>  uprobe_arch_specific_data
> };
> 
> 
>  --- include/asm-generic/uprobes.h
> 
> #define uprobe_arch_specific_data
> 
>  --- arch/x86/include/asm/uprobes.h
> 
> #undef uprobe_arch_specific_data
> #define uprobe_arch_specific_data \
> 	struct hlist_head	head_tramps;

ok

SNIP

> > > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > > index 1ee8eb11f38b..7108ca558518 100644
> > > > --- a/kernel/fork.c
> > > > +++ b/kernel/fork.c
> > > > @@ -1010,6 +1010,7 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
> > > >  {
> > > >  #ifdef CONFIG_UPROBES
> > > >  	mm->uprobes_state.xol_area = NULL;
> > > > +	arch_uprobe_init_state(mm);
> > > >  #endif
> > > 
> > > Can't we make this uprobe_init_state(mm)?
> > 
> > hum, there are other mm_init_* functions around, I guess we should keep
> > the same pattern?
> > 
> > unless you mean s/arch_uprobe_init_state/uprobe_init_state/ but that's
> > arch code.. so probably not sure what you mean ;-)
> 
> Ah, I misunderstood. Yeah, this part is good to me.

ok, thanks

jirka

