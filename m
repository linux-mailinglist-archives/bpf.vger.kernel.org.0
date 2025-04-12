Return-Path: <bpf+bounces-55818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 085A4A86DD9
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 16:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365E519E637B
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6FB1E5B8B;
	Sat, 12 Apr 2025 14:45:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F2813C67C;
	Sat, 12 Apr 2025 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744469121; cv=none; b=W7ViCuij5ctQoKopnSuxG4Arvip9lokqTVeM+9uVxbZKj8Omh27xeZuxI7wfNnGEZZiLvwCncSxG2T3rRhoTouGZYn9F9HEC0Uumk7IWEl0QnY3dHjctCLtbQw5cFroPRkyi1173EP/lZhewkJgBNl9MZiiSYj5Uoqt83PH8rDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744469121; c=relaxed/simple;
	bh=0z/z7q4ki/s8UOAgcSC8gyFRaO52Y/ZjXGFFPh0ypbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRDVXEsWqKJavoXaYkuyrvCvcTU/WyLIoqgyXgH75p6w69UqGEI7Q9XO11qvfHo0D4LuBoggMLVIOyej7Zw0a2yUhz0zZSH5VN+iwDbQ9i0epjd/aWCA32nrBbVBnIgpqU9OvbTkZxgY4x9d6aguWjk4E/daqusdnFWbXhNCAOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C764AC4CEE3;
	Sat, 12 Apr 2025 14:45:19 +0000 (UTC)
Date: Sat, 12 Apr 2025 10:45:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Menglong Dong
 <dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf] ftrace: fix incorrect hash size in
 register_ftrace_direct()
Message-ID: <20250412104518.2b4598d3@batman.local.home>
In-Reply-To: <CADxym3bAXpqC3awWBTm+zc4Wn348=7cYVCN_+em=b5qPimUTYQ@mail.gmail.com>
References: <20250412133348.92718-1-dongml2@chinatelecom.cn>
	<20250412100939.7f8dbbb7@batman.local.home>
	<CADxym3bAy4aV=UJU9ge0vw055C2DzC=zubjhOBSay_88CkW+hQ@mail.gmail.com>
	<CADxym3bAXpqC3awWBTm+zc4Wn348=7cYVCN_+em=b5qPimUTYQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Apr 2025 22:36:56 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> > Yeah, this seems to make more sense. And I'll send a V2
> > later.
> >
> > BTW, Should we still keep the "size = min(size, 32)" logic  
> 
> Oops, I mean "size =  max(size, 32); size = fls(size);" here :/
> 
> > to avoid the hash bits being too small, just like the origin
> > logic in "dup_hash"?
> >

If you have 5 functions, why do you need more that 5 buckets?

	size = 5;
	size = max(5, 32); // size = 32
	size = fls(size); // size = 5
	alloc_ftrace_hash(size);

		size = 1 << size; // size = 32
		hash->buckets = kcalloc(size, ...);

Now you have 32 buckets for 5 functions. Why waste the memory?

If you add more functions, the hash bucket size will get updated.

-- Steve

