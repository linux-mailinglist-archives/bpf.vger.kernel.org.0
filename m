Return-Path: <bpf+bounces-8860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6590578B65D
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 19:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889A61C20859
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 17:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3160413AEE;
	Mon, 28 Aug 2023 17:25:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80DF134D3
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 17:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B60C433C8;
	Mon, 28 Aug 2023 17:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693243521;
	bh=cHslUYn6nGJzaG/ccmGM9JwQDO1Z4eOGY9fjyg0KRKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BJKk3zucPY3kCl69xKUKL1neO6G21sCRrzuAFubHQ28CtjnYoauJdQ5Y93naE1ju1
	 MbQxIOjnHTkDTVFw+fqsdvlwMuT8VetGBmFLNu0dSnviU3Q8WTgAra/IizIjXm4Swo
	 cunpZv6R/Cf5UmStluGWYVk88f18DOmJATra7QH2u4zo/MW9X0RJzXqJQ7jft+wCXl
	 35G7zLfm1Zdj8rD0dfbaxBPRgq3WgGN78aACrMOsZabrDCXwaAlEwZY7eOkGqQqFFe
	 5BII8nA7ljt+QsegOGdcvBaZs2EiTuniRaWIVN860tOjkpMcWFqOeu5cFmBHfE1Cgm
	 fRP+WElo/mvRw==
Date: Mon, 28 Aug 2023 19:25:08 +0200
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Matthew Wilcox <willy@infradead.org>, Nishanth Menon <nm@ti.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Neha Francis <n-francis@ti.com>
Subject: Re: [PATCH 1/2] Documentation: sphinx: Add sphinx-prompt
Message-ID: <20230828192508.0da12d72@sal.lan>
In-Reply-To: <87wmxf19rs.fsf@meer.lwn.net>
References: <20230824182107.3702766-1-nm@ti.com>
	<20230824182107.3702766-2-nm@ti.com>
	<87h6om4u6o.fsf@meer.lwn.net>
	<20230828125912.hndmzfkof23zxpxl@tidings>
	<87edjn2sj0.fsf@meer.lwn.net>
	<ZOyqhL32tuiMlS23@casper.infradead.org>
	<87wmxf19rs.fsf@meer.lwn.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 28 Aug 2023 09:12:07 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Mon, Aug 28, 2023 at 07:41:39AM -0600, Jonathan Corbet wrote:  
> >> I appreciate attempts to improve our documentation, and hope that you
> >> will continue to do so.  I am far from convinced, though, that this
> >> change clears the bar for mainline inclusion.  
> >
> > I'd ask that you reconsider.  Looking at patch 2, I prefer what is
> > written there.  I don't think it adds cognitive load when reading the
> > plain docs.  I find the "copy and paste from html" argument not very
> > convincing, but I do like "copy and paste from rst", which this enables.  
> 
> Do you really think that the benefit from that justifies adding a build
> dependency and breaking everybody's docs build until they install it?  I
> rather suspect I would hear back from people who feel otherwise if I did
> that... 

I agree with Jon: it needs at least a patch for scripts/sphinx-pre-install.
Adding dependencies there is not the easiest thing to do, as one needs to
test the change against all supported distros to ensure that the new package
name will be the same everywhere. Also, if I'm not mistaken, some developers
don't want to use pip to install packages, wanting instead to have the
distro-provided package.

Also, having an extra build dependency will surely break already-existing
CI automation. Making the new dependency optional would be a way to go,
but this will cause troubles at the html output after such change.

> > I also have a certain fond memory of how the plan9 people set up 'rc'
> > (their shell) so that ";" was both an empty statement, and the default
> > prompt.  So you could copy-paste lines starting with the ; prompt and
> > they'd work.  It's a small usabillity improvement, but it is there,
> > and wow is it annoying when you don't have it any more.  
> 
> Ah, OK, so what we really need is a bash patch :)

Probably the hardest part would be to do copy-and-paste on places
where there are both shell prompt commands and their results. I'm
pretty sure we have things like:

	some example::

		$ run_some_command
		comand results line 1
		comand results line 2
		comand results line 3
		...
		comand results line n

		$ run_another_command

does sphinx-prompt handle things like that, placing just:

	run_some_command
	run_another_command

at the paste buffer, ignoring any command result lines?

IMO, the above described usease is where having a prompt will help
to identify what should be copied/pasted and what are the command
results. I mean, if someone wants to just place the commands to
run, he could write, instead:

	Run those shell commands to do something::

		run_some_command
		run_another_command


Regards,
Mauro

