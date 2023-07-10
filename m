Return-Path: <bpf+bounces-4604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E67B74D728
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 15:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE061C203BE
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD4211C93;
	Mon, 10 Jul 2023 13:13:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0A10975
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 13:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84296C433C8;
	Mon, 10 Jul 2023 13:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688994836;
	bh=Aq5NTYUAm+GogYfTUt9zhLH9os56FOgEi5F1VAGReu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bB5Lt+64qLrNU5bbE25iJAKgGKuCgLkDTPPnfD+KqZsrhYSoORfIrtcOzMQq9A8jL
	 enmC+gWK1rjDBb1EkJvhgouqcpcgWuCc78dXEGBS1hfoDkny5pUWGVYH5npxzb8vnI
	 GNCMCqkUHJsFNNNMitKBUlqUp9aOMKFFPvr+Py0XFaL946Bnx2sEVtj3K6x81s09mZ
	 496lKWQtDmvyxbKT7OhhcmaaGmkHVqr+q9AkrUpkyOSPxAQID3jHVK0UUiWumyES4V
	 f2DLWXdQClUcBjUzU1DO5wNARDn/X+WC+aljtun+GYcdWW7oimeb5EBZqHj9g5XnrF
	 EMqrD4UqkimgA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id DFB3A40516; Mon, 10 Jul 2023 10:13:53 -0300 (-03)
Date: Mon, 10 Jul 2023 10:13:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
	mykolal@fb.com
Subject: Re: [PATCH dwarves] pahole: avoid adding same struct structure to
 two rb trees
Message-ID: <ZKwEEd1Ercz8kkId@kernel.org>
References: <20230525235949.2978377-1-eddyz87@gmail.com>
 <ZHnxsyjDaPQ7gGUP@kernel.org>
 <a15b83ebc750df7edd84b76d30a72c50e016e80f.camel@gmail.com>
 <ZHovRW1G0QZwBSOW@kernel.org>
 <c9c1e04b10f0a13a3af9e980d04ce08d3304ac3a.camel@gmail.com>
 <ZH3nalodXmup6pEF@kernel.org>
 <2b4372428cd1e56de3b79791160cdd3afdc7df6a.camel@gmail.com>
 <ZH4vZjaQnCGOzY/w@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH4vZjaQnCGOzY/w@kernel.org>
X-Url: http://acmel.wordpress.com

Em Mon, Jun 05, 2023 at 03:54:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jun 05, 2023 at 05:39:19PM +0300, Eduard Zingerman escreveu:
> > On Mon, 2023-06-05 at 10:47 -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Fri, Jun 02, 2023 at 09:08:51PM +0300, Eduard Zingerman escreveu:
> > > > On Fri, 2023-06-02 at 15:04 -0300, Arnaldo Carvalho de Melo wrote:
> > > > > Em Fri, Jun 02, 2023 at 04:52:40PM +0300, Eduard Zingerman escreveu:
> > > > > > Right, you are correct.
> > > > > > The 'structures__tree = RB_ROOT' part is still necessary, though.
> > > > > > If you are ok with overall structure of the patch I can resend it w/o bzero().
> > > 
> > > > > Humm, so basically this boils down to the following patch?
> > > 
> > > > > +++ b/pahole.c
> > > > > @@ -674,7 +674,12 @@ static void print_ordered_classes(void)
> > > > >  		__print_ordered_classes(&structures__tree);
> > > > >  	} else {
> > > > >  		struct rb_root resorted = RB_ROOT;
> > > > > -
> > > > > +#ifdef DEBUG_CHECK_LEAKS
> > > > > +		// We'll delete structures from structures__tree, since we're
> > > > > +		// adding them to ther resorted list, better not keep
> > > > > +		// references there.
> > > > > +		structures__tree = RB_ROOT;
> > > > > +#endif
> > >  
> > > > But __structures__delete iterates over structures__tree,
> > > > so it won't delete anything if code like this, right?
> > >  
> > > > >  		resort_classes(&resorted, &structures__list);
> > > > >  		__print_ordered_classes(&resorted);
> > > > >  	}
> > > 
> > > Yeah, I tried to be minimalistic, my version avoids the crash, but
> > > defeats the DEBUG_CHECK_LEAKS purpose :-\
> > > 
> > > How about:
> > > 
> > > diff --git a/pahole.c b/pahole.c
> > > index 6fc4ed6a721b97ab..e843999fde2a8a37 100644
> > > --- a/pahole.c
> > > +++ b/pahole.c
> > > @@ -673,10 +673,10 @@ static void print_ordered_classes(void)
> > >  	if (!need_resort) {
> > >  		__print_ordered_classes(&structures__tree);
> > >  	} else {
> > > -		struct rb_root resorted = RB_ROOT;
> > > +		structures__tree = RB_ROOT;
> > >  
> > > -		resort_classes(&resorted, &structures__list);
> > > -		__print_ordered_classes(&resorted);
> > > +		resort_classes(&structures__tree, &structures__list);
> > > +		__print_ordered_classes(&structures__tree);
> > >  	}
> > >  }
> > >  
> > 
> > That would work, but I still think that there is no need to replicate call

I'm going thru the pile of stuff from before my vacations, can I take
the above as an Acked-by in addition to your Reported-by?

- Arnaldo

> > to __print_ordered_classes, as long as the same list is passed as an argument,
> > e.g.:
> > 
> > @@ -670,14 +671,11 @@ static void resort_classes(struct rb_root *resorted, struct list_head *head)
> >  
> >  static void print_ordered_classes(void)
> >  {
> > -       if (!need_resort) {
> > -               __print_ordered_classes(&structures__tree);
> > -       } else {
> > -               struct rb_root resorted = RB_ROOT;
> > -
> > -               resort_classes(&resorted, &structures__list);
> > -               __print_ordered_classes(&resorted);
> > +       if (need_resort) {
> > +               structures__tree = RB_ROOT;
> > +               resort_classes(&structures__tree, &structures__list);
> >         }
> > +       __print_ordered_classes(&structures__tree);
> >  }
> 
> Right, that can be done as a follow up patch, further simplifying the
> code.
> 
> I'm just trying to have each patch as small as possible.

