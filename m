Return-Path: <bpf+bounces-5380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CE4759E35
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 21:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651F6281045
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 19:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACCF111A9;
	Wed, 19 Jul 2023 19:02:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4049275D7
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 19:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A56C433C7;
	Wed, 19 Jul 2023 19:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689793357;
	bh=er8PxxiNwe2IP17ixZnzil4chz2FvKc+APjSl+8TXDs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pWUtnTPNmsjwXTpPaBC0Z9/mOjq3LuTqKWfMBJoM6L1xaQ/6DutWUE7UihQWvrjOM
	 Tlt/m2+k34AvI+OnS8IVwJYDIT7Wg1QUyb8RXm0qEZQclUPe4SquIXD/uYu1ECgdn2
	 bWmah2eD6OzU11aRhHlX3HGADw5lqciv64BEL1LHHAXotNmJ+/B9NtXUYIGjDZmHFd
	 VOZAQpM0VR9NqrwxtX4Ckh4Pk9aoqpQeKxog5vfZZcWFibfzbU7HmN/TJAzEKDyjOV
	 LLFsk7yj+JYGrSCieAhp2GnCjBIk3OOOtrQvBED3x7PT6YjFpq0jz8/cpUWT/7Z8fg
	 adGUALgXDVrAg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C6164CE092F; Wed, 19 Jul 2023 12:02:36 -0700 (PDT)
Date: Wed, 19 Jul 2023 12:02:36 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 5/5] checkpatch: Complain about unexpected uses of
 RCU Tasks Trace
Message-ID: <de2c81f5-70c6-4e81-88b4-d412c58d033e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
 <20230717180454.1097714-5-paulmck@kernel.org>
 <04e74fd214a01bee0fb5ac690730cb386536cced.camel@perches.com>
 <8477fd32-38a5-4d66-8deb-a61b0e290df5@paulmck-laptop>
 <a0f6e131-a649-1731-b096-46313a0460a9@joelfernandes.org>
 <351d0261-210a-44a3-ade6-59289f407db2@paulmck-laptop>
 <67766eb5a995634e001b842fe988a423cf3d0eab.camel@perches.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67766eb5a995634e001b842fe988a423cf3d0eab.camel@perches.com>

On Wed, Jul 19, 2023 at 11:44:17AM -0700, Joe Perches wrote:
> On Wed, 2023-07-19 at 11:27 -0700, Paul E. McKenney wrote:
> []
> > > > > 
> > Given perl's tendency to have corner cases in its corner cases, I
> > am guessing that the "^" character combined with the "/" character is
> > causing trouble here.  Especially given that I don't see any use of such
> > a pattern anywhere in checkpatch.pl except directly in a "~" expression,
> > and there are a lot of those.
> > 
> > So I will keep it as is unless I hear otherwise from Joe Perches.
> 
> I played with it a bit and can't think of anything better.
> 
> Code is always something that can be improved later so the
> way Paul has it now is fine with me.

Then I don't feel so bad not finding anything better myself.

Thank you, and if nothing else this exercise refreshed a few of my
perl neurons.  ;-)

							Thanx, Paul

