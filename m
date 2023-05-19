Return-Path: <bpf+bounces-959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA257099A4
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 16:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B23281CEF
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 14:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA7210968;
	Fri, 19 May 2023 14:27:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CC6C2F6
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 14:27:52 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC02116
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 07:27:50 -0700 (PDT)
Received: from letrec.thunk.org (c-73-212-78-46.hsd1.md.comcast.net [73.212.78.46])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34JER2M1026820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 May 2023 10:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1684506426; bh=gRhknx204/04plo5YxlLLBmQajZd/f4TJcHaesam/oU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Btr4tl09YPwR8JYPaeuwimZ7SNzMtlaD4xnNue2ndEF/4k07p6wnvX8b28WIRaTuB
	 IG0ir8rQyFmydj830OaYMbPhppg8PuSaq/GiQYrdqVY0oDjGV16TBal6Od8bSA1wqv
	 mNW+T35r7o0d4TJKlX6eINTvTLTDGXBZwwga6XhMQtRnYj3huGuJJZ1jADeafTZcYv
	 U5A8tb6b3jC1h2Ahzz58gluuHJ/lNi655rHsLn0fpRlMThcTcHsEGfThWoyBBz27nT
	 IYfwpyX3KL25woYCW9OOKwlTohhhq4W/yJzn2zLTtXdYjTru8DXiIjHcp5H0pe1LQQ
	 AQgZdHJAmgjnw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
	id 341428C03FE; Fri, 19 May 2023 10:27:02 -0400 (EDT)
Date: Fri, 19 May 2023 10:27:02 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: fd == 0 means AT_FDCWD BPF_OBJ_GET commands
Message-ID: <ZGeHNsKxea5UK+Ai@mit.edu>
References: <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner>
 <20230517120528.GA17087@lst.de>
 <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
 <20230518-erdkugel-komprimieren-16548ca2a39c@brauner>
 <20230518162508.odupqkndqmpdfqnr@MacBook-Pro-8.local>
 <20230518-tierzucht-modewelt-eb6aaf60037e@brauner>
 <20230518182635.na7vgyysd7fk7eu4@MacBook-Pro-8.local>
 <CAHk-=whg-ygwrxm3GZ_aNXO=srH9sZ3NmFqu0KkyWw+wgEsi6g@mail.gmail.com>
 <20230519044433.2chdcze3qg2eho77@MacBook-Pro-8.local>
 <20230519-betiteln-fluor-6c0417842143@brauner>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519-betiteln-fluor-6c0417842143@brauner>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 19, 2023 at 10:13:09AM +0200, Christian Brauner wrote:
> > I'm well aware that any file type is allowed to be in FDs 0,1,2 and
> > some user space is using it that way, like old inetd:
> > https://github.com/guillemj/inetutils/blob/master/src/inetd.c#L428
> > That puts the same socket into 0,1,2 before exec-ing new process.

This is a *feature*.  I've seen, and actually written shell scripts
which have been wired into /etc/inetd.conf. amd so the fact that shell
script can send stdout out to a incoming TCP connection.  It should be
possible to implement the finger protocol (RFC 1288) as a shell or
python script, *precisely* because having inetd connect a socket to
FDs 0, 1, and 2 is a good and useful thing to do.

> > My point that the kernel has to assist user space instead of
> > stubbornly sticking to POSIX and saying all FDs are equal.

This is not a matter of adhering to Posix.  It's about the fundamental
Unix philosophy.  Not everything needs to be implemented in a
complicated C++ program....


> > To explain the motivation a bit of background:
> > "folly" is a core C++ library for fb apps. Like libstdc++ and a lot more.
> > Until this commit in 2021:
> > https://github.com/facebook/folly/commit/cc9032a0e41a0cba9aa93240c483cfceb0ff44ea
> > the user could launch a new process with flag "folly::Subprocess::CLOSE".
> > It's useful for the cases when child doesn't want to inherit stdin/out/err.

Yeah, sorry, that's just simple bug in the Folly library (which I
guess was well named).  Closing all of the file descriptors and then
opening 0, 1, and 2 using /dev/null is a pretty basic.  In fact,
there's a convenient daemon(3) will do this for you.  No muss, no
fuss, no dirty dishes.

> I'm sorry but I really don't think this is a good idea. We're not going
> to run BPF programs in core file code. That stuff is sensitive and
> complex enough as it is without having to take into account that a bpf
> program can modify behavior. It's also completely unclear whether that's
> safe to do as this would allow to change fd allocation across the whole
> kernel.
> 
> This idea that fd 0, 1, and 2 or any other fd deserve special treatment
> by the kernel needs to die; and quickly at that.

+1.

Making fundamentally violent changes to core Unix design and
philosophy just to accomodate incompetent user space programmers is
IMHO a really bad idea.

						- Ted

