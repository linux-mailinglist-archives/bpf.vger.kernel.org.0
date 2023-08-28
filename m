Return-Path: <bpf+bounces-8846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A8478B29F
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 16:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2BD280E02
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 14:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADE812B80;
	Mon, 28 Aug 2023 14:09:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E1511C9D
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 14:09:32 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472F2114;
	Mon, 28 Aug 2023 07:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hwS7Tr7cwvM8RoL5HlUQtUZrL4nEzt4+7EbQ2IC3lY8=; b=QItc5MAX+cz4JCtjY2sEKO+9xj
	IGIr+1a8yA4sbCHCD8vkT418hvpskmNi9ButFChI0IuFkAoyCtQmqMlrDLyaMBn096v2sfA42KPrG
	3Xk8fEkCqusisXtiwvRKsO6lUwakiJDdIqyNmk7I9j7yXJmYz7kvHbXesSq7U6DqFq8RJ242+lR4x
	S3meOEy5y/jnHMK1TyqY2I6T4jm7pM9mQU7TuIIvkke8sKJlvJevNUoyfaepI7obnL9pgoAxmCmnM
	vo5516VDjYn+XUJNcWZqZwqY1vDzqS4RmQ9id7cIKBC8VoX0ZCUWIydGGF9oM0tB8zxtELpkf2hp3
	iyUk59bQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qacvU-000fif-Tn; Mon, 28 Aug 2023 14:09:08 +0000
Date: Mon, 28 Aug 2023 15:09:08 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Nishanth Menon <nm@ti.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Mattijs Korpershoek <mkorpershoek@baylibre.com>,
	Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
	Neha Francis <n-francis@ti.com>
Subject: Re: [PATCH 1/2] Documentation: sphinx: Add sphinx-prompt
Message-ID: <ZOyqhL32tuiMlS23@casper.infradead.org>
References: <20230824182107.3702766-1-nm@ti.com>
 <20230824182107.3702766-2-nm@ti.com>
 <87h6om4u6o.fsf@meer.lwn.net>
 <20230828125912.hndmzfkof23zxpxl@tidings>
 <87edjn2sj0.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edjn2sj0.fsf@meer.lwn.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 28, 2023 at 07:41:39AM -0600, Jonathan Corbet wrote:
> Youtube references aren't a great way to explain the value of a patch;
> you'll find that maintainers will, in general, lack the time or
> inclination to follow them up.  The patch should explain itself.

I agree that the way this has been presented is awful.

> > prompt:: bash $ is clearly readable that this is prompt documentation
> > in fact, dropping the "$" in the example logs, one can easily copy paste
> > the documentation from rst files as well.
> 
> .. prompt:: is clutter.  It also adds a bit of extra cognitive load to
> reading that part of the documentation.
> 
> Quick copy-paste of multiple lines of privileged shell commands has
> never really been a requirement for the kernel docs; why do we need that
> so badly?
> 
> I appreciate attempts to improve our documentation, and hope that you
> will continue to do so.  I am far from convinced, though, that this
> change clears the bar for mainline inclusion.

I'd ask that you reconsider.  Looking at patch 2, I prefer what is
written there.  I don't think it adds cognitive load when reading the
plain docs.  I find the "copy and paste from html" argument not very
convincing, but I do like "copy and paste from rst", which this enables.

I also have a certain fond memory of how the plan9 people set up 'rc'
(their shell) so that ";" was both an empty statement, and the default
prompt.  So you could copy-paste lines starting with the ; prompt and
they'd work.  It's a small usabillity improvement, but it is there,
and wow is it annoying when you don't have it any more.

