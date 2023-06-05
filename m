Return-Path: <bpf+bounces-1814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EE47227CD
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 15:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA5D1C20B46
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 13:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056391D2B3;
	Mon,  5 Jun 2023 13:47:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F969156EB
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 13:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC7EC433D2;
	Mon,  5 Jun 2023 13:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685972845;
	bh=OHXz1OKPeLqjsvKzYaWmG3JfzQJvaSjKi8PweDxzETQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IFLdiaFa6dJxabXAjCiytv0nBxnWvbaR+SfmFBkl+itxfKR10Qii37ivsTQFZCoXd
	 DfqDLBMg16twIFpPieJu3aNZn+5MRrc5OLFUMcDFjcSSIcFulAUd0BKdIiKOhcPJmM
	 R49TQlmdInwA6JQHNxk+FvvIRweuHmW3lRKG0v9SjMMzlaW9V3kBg5pbnlNxPfF75j
	 owdIGTbC1ib2hJmqKWNuEz0csqyVMYghBjayulIL9qPMcj2LU8A8ihfNoT4YifWuWM
	 Aep7EunZs6Tw8JLFIKeMzARgi5UzO6rzFy0aMdnZSFpc+uzB9wT5Wq6PE7W3/p4NQ1
	 YJMXAo4YhBztQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 0C32940692; Mon,  5 Jun 2023 10:47:23 -0300 (-03)
Date: Mon, 5 Jun 2023 10:47:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
	mykolal@fb.com
Subject: Re: [PATCH dwarves] pahole: avoid adding same struct structure to
 two rb trees
Message-ID: <ZH3nalodXmup6pEF@kernel.org>
References: <20230525235949.2978377-1-eddyz87@gmail.com>
 <ZHnxsyjDaPQ7gGUP@kernel.org>
 <a15b83ebc750df7edd84b76d30a72c50e016e80f.camel@gmail.com>
 <ZHovRW1G0QZwBSOW@kernel.org>
 <c9c1e04b10f0a13a3af9e980d04ce08d3304ac3a.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c1e04b10f0a13a3af9e980d04ce08d3304ac3a.camel@gmail.com>
X-Url: http://acmel.wordpress.com

Em Fri, Jun 02, 2023 at 09:08:51PM +0300, Eduard Zingerman escreveu:
> On Fri, 2023-06-02 at 15:04 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Jun 02, 2023 at 04:52:40PM +0300, Eduard Zingerman escreveu:
> > > Right, you are correct.
> > > The 'structures__tree = RB_ROOT' part is still necessary, though.
> > > If you are ok with overall structure of the patch I can resend it w/o bzero().

> > Humm, so basically this boils down to the following patch?

> > +++ b/pahole.c
> > @@ -674,7 +674,12 @@ static void print_ordered_classes(void)
> >  		__print_ordered_classes(&structures__tree);
> >  	} else {
> >  		struct rb_root resorted = RB_ROOT;
> > -
> > +#ifdef DEBUG_CHECK_LEAKS
> > +		// We'll delete structures from structures__tree, since we're
> > +		// adding them to ther resorted list, better not keep
> > +		// references there.
> > +		structures__tree = RB_ROOT;
> > +#endif
 
> But __structures__delete iterates over structures__tree,
> so it won't delete anything if code like this, right?
 
> >  		resort_classes(&resorted, &structures__list);
> >  		__print_ordered_classes(&resorted);
> >  	}

Yeah, I tried to be minimalistic, my version avoids the crash, but
defeats the DEBUG_CHECK_LEAKS purpose :-\

How about:

diff --git a/pahole.c b/pahole.c
index 6fc4ed6a721b97ab..e843999fde2a8a37 100644
--- a/pahole.c
+++ b/pahole.c
@@ -673,10 +673,10 @@ static void print_ordered_classes(void)
 	if (!need_resort) {
 		__print_ordered_classes(&structures__tree);
 	} else {
-		struct rb_root resorted = RB_ROOT;
+		structures__tree = RB_ROOT;
 
-		resort_classes(&resorted, &structures__list);
-		__print_ordered_classes(&resorted);
+		resort_classes(&structures__tree, &structures__list);
+		__print_ordered_classes(&structures__tree);
 	}
 }
 

