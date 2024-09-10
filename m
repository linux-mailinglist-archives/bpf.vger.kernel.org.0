Return-Path: <bpf+bounces-39525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E47A9742CC
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 20:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E9F1F28717
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 18:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE2B1A4F34;
	Tue, 10 Sep 2024 18:54:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363471A3BCA;
	Tue, 10 Sep 2024 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994472; cv=none; b=fBfnzZrpHYJyxcD8hzLOwvzxEqe1fB+rmQmzfoPdM4GjOLM3ffgXS+wAzkib5KvwRxJS66rrkDNs20UHt9L28FoWYOwL8xR5NHZKz4DWlmJz3TzXruAeWRKyTxG2YrtBDisAeMODIXRlExeTspjoxYfuMvH+dngjaMEGOCmFqHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994472; c=relaxed/simple;
	bh=WC4pBiIUDalgyXWe+fvymc628DQH06NWE+NGwbJbeaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ooe+1jwa67KHvln4cSH7lV24TN/MlELkvYhPWAKeWkm7fHgzdczZAxrvIGxQHzAUANWyppxLCA1AW0M0UyI1aYOzB/i58T/oSWxBiihWb5YEqhzzcfZdCKBwix8QjgOk+mWtTZZwYQfRrT9+f995aXIB/WWCVgBgM0biLmJ96t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D72BC4CEC3;
	Tue, 10 Sep 2024 18:54:30 +0000 (UTC)
Date: Tue, 10 Sep 2024 14:54:31 -0400
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
Message-ID: <20240910145431.20e9d2e5@gandalf.local.home>
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

> Does Linus have to be in CC to get any reply here? Come on, it's been
> almost a full week.

Just FYI, an email like this does piss people off. You are getting upset
for waiting "almost a full week"? A full week is what we tell people to
wait if they don't get a response. And your email was directed to multiple
people. Then pointing out myself and Masami because we didn't respond? We
are not arm64 maintainers, and that email looked more directed at them.

Funny part is, I was just about to start reviewing Masami's fprobe patches
when I read this. Now I feel reluctant to. I'll do it anyway because they
are Masami's patches, but if they were yours, I would have pushed it off a
week or two with that attitude.

Again, just letting you know.

-- Steve

