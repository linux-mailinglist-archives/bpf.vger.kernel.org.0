Return-Path: <bpf+bounces-39519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FC5974260
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 20:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013681F26498
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 18:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AD21A4F1E;
	Tue, 10 Sep 2024 18:40:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F5214A088;
	Tue, 10 Sep 2024 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993616; cv=none; b=I0tZTPoRen4B6uFVkrP2BCbffOID/pumHw2eqKY0hb0ehZBhrTXvWZw7YK3F6qvcRzkz/Ed2vgMIM5hR0sY12MaGv/VZKfFOg0Q8ByJTkLE6AGizKvV8ggIIKkQBTzSglFK212Z6OE+ADSyOhzTs6LCKDIPHKu6gMAe0+ByxvtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993616; c=relaxed/simple;
	bh=fzhPJFooZn6ziiB8dUyp4xNuOymY0Ow5XTpP8LzxOr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvL3KE38lQ5vi7bQvOxM/OTKYeONk07yTKZermtzYqHo96uqeiT6+bbtKTKbHKQyZHOaYU7+HRbMj+hr3rhwYjIWnHjvkOrEWrOt1woMIkiBxuk8Q5Md18+N2LG38SlwadWLJkciy3h8ACOhJiNPN95WFaIl6K5B5mLa2S5A7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD08C4CEC3;
	Tue, 10 Sep 2024 18:40:13 +0000 (UTC)
Date: Tue, 10 Sep 2024 14:40:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, bpf <bpf@vger.kernel.org>, Linux
 trace kernel <linux-trace-kernel@vger.kernel.org>, adubey@linux.ibm.com,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, KP Singh
 <kpsingh@chromium.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Florent Revest
 <revest@chromium.org>, Puranjay Mohan <puranjay@kernel.org>
Subject: Re: Unsupported CONFIG_FPROBE and CONFIG_RETHOOK on ARM64
Message-ID: <20240910144015.643dc6da@gandalf.local.home>
In-Reply-To: <CAEf4BzasRqeAY3ZpBDbjyWSKUriZgUf4U_YoQNSSutKhX5g2kw@mail.gmail.com>
References: <CAEf4BzaYyEftmRmt6FswrTOsb9FuQMtzuDXD4OJMO7Ein2ZRGg@mail.gmail.com>
	<CAEf4BzasRqeAY3ZpBDbjyWSKUriZgUf4U_YoQNSSutKhX5g2kw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 11:23:29 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> Masami, Steven,
> 
> Does Linus have to be in CC to get any reply here? Come on, it's been
> almost a full week.

And we are busy getting ready for Plumbers. Go ahead Cc Linus, I'm sure he
doesn't care, and you will likely just annoy him unless this is a
regression. 

> 
> Maybe ARM64 folks have some context?... And hopefully desire to see
> this through so that ARM64 doesn't stick out as a lesser-supported
> platform as far as tracing goes compared to loongarch, s390x, and
> powerpc (which just landed rethook support, see [2]).
> 
> Note that there was already an implementation (see [1]), but for some
> reason it never made it.
> 
>   [1] https://lore.kernel.org/bpf/164338038439.2429999.17564843625400931820.stgit@devnote2/
>   [2] https://lore.kernel.org/bpf/172562357215.467568.2172858907419105155.b4-ty@ellerman.id.au/

Masami's fprobe work is near the top of my priority list, but there's been
bugs reported that always take precedence over features. There's been fires
to put out that has caused this to be delayed.

There! I replied.

-- Steve

