Return-Path: <bpf+bounces-909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A494F7087BB
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 20:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930781C2118B
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 18:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5693D390;
	Thu, 18 May 2023 18:21:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEC73D380
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 18:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B492C433D2;
	Thu, 18 May 2023 18:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684434087;
	bh=JeaxbkuWjwZjOj/8xBrqDMU4bzm1ZxYSOQBV9Omoj6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l+n1ZZaf8KSyy+5W1ITMXKACA7y4huoXz7dGx3yo8esrq+NDCaEL8ohO3uuQofWf/
	 CxdSViX0j2t4Yk+0g2pwXoz+6crY8ShIONHocv8/nroLogXTFctHOB0YxMiyysuVP1
	 lZYDTNeU+BWl+UVtMMbTKYb0vXrvU9jvWBH12Pa80DE3rMIUMd17vR/7prMeB1RwMR
	 PSZiI52s6MpC5ft4Y8ylbtPh7BnNGRtDqQJGt6WvW+QIAUH1z2nAOhaZYUo/kGanZH
	 SuJ1seaGQw6FMNEp21RPPqJSleUr45QsZWWuVLdprXr8GicabDyuDUdMfreeldPbt1
	 crjAC3KnBg7ew==
Date: Thu, 18 May 2023 20:21:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <20230518-gebrechen-tulpen-7be50e0f5b1a@brauner>
References: <20230516001348.286414-2-andrii@kernel.org>
 <20230516-briefe-blutzellen-0432957bdd15@brauner>
 <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
 <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner>
 <20230517120528.GA17087@lst.de>
 <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
 <20230518-erdkugel-komprimieren-16548ca2a39c@brauner>
 <20230518162508.odupqkndqmpdfqnr@MacBook-Pro-8.local>
 <20230518-tierzucht-modewelt-eb6aaf60037e@brauner>
 <CAHk-=wgmRTogGmR8E_SYOiHFpz8cY+0xj7nBpv9UwGU6k-UPAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgmRTogGmR8E_SYOiHFpz8cY+0xj7nBpv9UwGU6k-UPAA@mail.gmail.com>

On Thu, May 18, 2023 at 10:33:30AM -0700, Linus Torvalds wrote:
> On Thu, May 18, 2023 at 10:20 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > That's just completely weird. We can see what Linus thinks but I think
> > that's a somewhat outlandish proposal that I wouldn't support.
> 
> I have no idea of the background here.
> 
> But fd 0 is in absolutely no way special. Anything that thinks that a
> zero fd is invalid or in any way different from (say) fd 5 is
> completely and utterly buggy by definition.
> 
> Now, fd 0 can obviously be invalid in the sense that it may not be
> open, exactly the same way fd 100 may not be open. So in *that* sense
> we can have an invalid fd 0, and system calls might return EBADF for
> trying to access it if somebody has closed it.
> 
> If bpf thinks that 0 is not a file descriptor, then bpf is simply
> wrong. No ifs, buts or maybes about it. It's like saying "1 is not a
> number". It's nonsensical garbage.
> 
> But maybe I misunderstand the issue.

TL;DR bpf has considerd fd 0 to be an invalid fd value for a long time.
We can't exactly follow the motiviation:
https://lore.kernel.org/bpf/CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com
and it's probably to late to change this.

Yes, passing fds in extensible structs is inconvenient because you need
to pass an indicator alongside an fd to indicate that the zero value is
anactual file descriptor. Because unknown fields need to be initialzied
to zero so that old kernels can ignore larger structs. So what we
usually have to do:

mount_setattr()

attr.set |= MOUNT_ATTR_IDMAP;
attr.userns_fd = 0;

We just found out about fd 0 being invalid because a new bpf feature
proposal now tried to reuse fd 0 to mean AT_FDCWD when passed through a
new bpf feature; which I said isn't acceptable.

