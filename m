Return-Path: <bpf+bounces-30409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C268CD925
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 19:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F2D1F21DE7
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778DD502BB;
	Thu, 23 May 2024 17:25:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A28A762C9;
	Thu, 23 May 2024 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716485136; cv=none; b=fppjtEDjphfvx594hLrAcvJibYfBzq4Y/CyKa0zoxEXKhx3D4suDK9O5HUXXgQRgKozfxCjogG04V+zNQbSPmwfW01iiErHraxGunPBBDxRUeFk3abNhaoCNpiJan5/fnlWzB0rYxFa0A293sKHTyIWYiN1ggq5LQLIISu6IuG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716485136; c=relaxed/simple;
	bh=8eUT9FM0v7qVS6YDmMIi10oeekmWY6u4aR80+EI5UXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkqzjUP1J+LAd/g0VV6yZTL23ArLsggTqdaB7Jcq4Vkio7VBlGkcuuvuPa6AUl4cLHm/8KiFRClnZp3lQ65SVjNXnEaI1OciNYOUGvs3rzGm+15fyIZLToHL6q7dNxaz0mlowXFRdh8Nt4bAGw8wxWQbZ4JzPaShRxj5Ke358Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885BAC2BD10;
	Thu, 23 May 2024 17:25:34 +0000 (UTC)
Date: Thu, 23 May 2024 13:25:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, bpf <bpf@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>, Jan Engelhardt <jengelh@inai.de>,
	Craig Small <csmall@enc.com.au>, linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH workqueue/for-6.10-fixes] workqueue: Refactor worker ID
 formatting and make wq_worker_comm() use full ID string
Message-ID: <Zk98B1FLIAt2SU4Y@home.goodmis.org>
References: <o89373n4-3oq5-25qr-op7n-55p9657r96o8@vanv.qr>
 <CAHk-=wjxdtkFMB8BPYpU3JedjAsva3XXuzwxtzKoMwQ2e8zRzw@mail.gmail.com>
 <ZkvO-h7AsWnj4gaZ@slm.duckdns.org>
 <CALOAHbCYpV1ubO3Z3hjMWCQnSmGd9-KYARY29p9OnZxMhXKs4g@mail.gmail.com>
 <CAHk-=wj9gFa31JiMhwN6aw7gtwpkbAJ76fYvT5wLL_tMfRF77g@mail.gmail.com>
 <CALOAHbAmHTGxTLVuR5N+apSOA29k08hky5KH9zZDY8yg2SAG8Q@mail.gmail.com>
 <CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com>

On Wed, May 22, 2024 at 09:32:03PM -0700, Linus Torvalds wrote:
> On Wed, 22 May 2024 at 19:38, Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > Indeed, the 16-byte limit is hard-coded in certain BPF code:
> 
> It's worse than that.
> 
> We have code like this:
> 
>     memcpy(__entry->comm, t->comm, TASK_COMM_LEN);

FYI, I would be happy to convert the tracing events over to dynamic strings.
It takes a 4 byte meta data that holds the offset and size of the string, then
the string itself (appended at the end of the event buffer) as well as the
space. The sched_switch and sched_waking events were created before the
dynamic string code was added, hence the hard coded size.

I'm not sure what fallout that would have for user space tools, as some
tooling does hardcode the parsing of the sched event. But I'm sure I can work
to fix those tools.

-- Steve


