Return-Path: <bpf+bounces-18876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F62B82333C
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 18:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C138C1F24960
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 17:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F345C1C291;
	Wed,  3 Jan 2024 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gUmXCJg7"
X-Original-To: bpf@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBAE1C688
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-86.bstnma.fios.verizon.net [173.48.116.86])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 403HU3DV013800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 12:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1704303006; bh=USdQat260eBLfxQ3g2Q+1HywsmmiJHmKprEB7G5xl2g=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=gUmXCJg7WolnfBfOrvsZDcXUwDKyDntyrb7dvFgeRPLyy84y1dP4LdOfKrEjVh3Ov
	 CqoImsyb3prmRUYeBbEC00I/GZzyFgNtxvf4rKH5/I46sqisMYbUuvu3xJOiWdOSR+
	 dajeIDmLbHt3P2dBnKGns95dIl1E/U+3BbmMHvY5HjNk2QZAEOzOoqUIXlVU9CNeiY
	 3ZtKLHQhJvTIhx+0yVZmErrSVKFBdD+puvGN25gVVstLQOfOF69G9SmCIaiz8IJNu6
	 JYS4QRvH0CY6MUiZodldbBsIw4qsUpIOXigHrRsE6CL8kXBkX/vpsSywLMDy3MkEAK
	 6KZBlFPNeWXDg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id EA1F115C17F9; Wed,  3 Jan 2024 12:30:02 -0500 (EST)
Date: Wed, 3 Jan 2024 12:30:02 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: =?utf-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>, brauner@kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: proposal to refine capability checks when _rlimit_overlimit() is
 true
Message-ID: <20240103173002.GB136592@mit.edu>
References: <1a8ed7bd.c96e.18ccd4ee4d1.Coremail.mengjingzi@iie.ac.cn>
 <2024010353-legwarmer-flap-869d@gregkh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024010353-legwarmer-flap-869d@gregkh>

On Wed, Jan 03, 2024 at 07:11:18AM +0100, Greg KH wrote:
> On Wed, Jan 03, 2024 at 11:12:28AM +0800, 孟敬姿 wrote:
> > Hi!
> > 
> > We observed a potential refinement in the kernel/fork.c line 2368.
> > Currently, both CAP_SYS_ADMIN and CAP_SYS_RESOURCE are checked when
> > the limit is over system limit. We suggest considering an adjustment
> > to utilize CAP_SYS_RESOURCE exclusively. Here's our rationale for this
> > suggestion:
> 
> As I said when you proposed changing CAP permissions on the tty ioctls,
> have you tried this and seen what actually breaks by doing so?  Please
> audit the userspace code out there to ensure that what you are
> attempting to propose actually would work, and then, if so, submit a
> patch to do so.  Attempts of "wouldn't it be nice", don't go very far as
> it shows that the work to do so hasn't actually been done.

It's not just a matter of "auditing the userspace code", but how
systems might be set up.  So doing this could very easily cause
various systems to break based on how system administrators might have
set up their system.

What capabilities are used to add appropriate permissions is
fundamentally making a potential user space interface, and so it is
incredibly risky.  So any time we make such changes, we need to make a
very careful cost/benefit analysis.

						- Ted

