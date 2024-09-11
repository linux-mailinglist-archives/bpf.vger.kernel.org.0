Return-Path: <bpf+bounces-39672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F12975DC9
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 01:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20106286276
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 23:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089FD1AC899;
	Wed, 11 Sep 2024 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaZCSVQO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F04A29;
	Wed, 11 Sep 2024 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726098832; cv=none; b=UF/PYpHeqgmWelTb7Qfx89nMEpWPvX/KXb8eD3+/GraMJe2ql8/zZgUwb9NYOjVtjBRkmpYQI2EC2TpkQ8/JbtLd77tjmPK0g3h60MTZB6LZZ6ZNEhFm+rcQRJe38OhgSgestueuQ+8kMWSvgIt8//Lx1jyXwXd+0dgyyoRj/10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726098832; c=relaxed/simple;
	bh=ewXwRnugXYXsCY1PEPRe8FMZ36d1aPzdmQ+2IRD3E9Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YW/IOWkDqN/RmUAr5U3XnbV4opOv1hxh+xzSrO4auybFv+9rVHnY3TMiDgNcj0U71o+Ed8VLnmVY4JA4uLTW6ulWn6GNKLx/k1eraFPgxDAomRHOvAKNE2u/rs9JVZrBqzgConUIyYu8Wsuj5laFrLweWiW9uBs2zGBL0MQXwek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaZCSVQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE15EC4CEC0;
	Wed, 11 Sep 2024 23:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726098832;
	bh=ewXwRnugXYXsCY1PEPRe8FMZ36d1aPzdmQ+2IRD3E9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kaZCSVQO0u6e+HbGwoP4zYmk/jYQzfn5J732qvCqqSPW8stpMt8w5hrBnXi7Dz3G/
	 NvbDtN5fKUKfkJCUd74GRfgrFSnZH6L03ekj8Jh4vF//7vX/vxDni+iZpwfVbG912M
	 ID1CzANATF3wV+55XPl03UjM6ErAAbr580xRA9QjF22hFoaoIFt0mxE4CfD0B9+HDv
	 HZLk6XMrUW+LQaYkOD4L8m79USeoTSJTXj9t0M7SFO1wSa3icN4Kp6u8vUabGBcBJL
	 8cpZhcywe6DIyWmmIIXKGy2kW54GVy+s6n61Sv0bThZA7smsZdiNPpAfdNorxykaIV
	 741p9enWKkYXw==
Date: Thu, 12 Sep 2024 08:53:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, Linux
 trace kernel <linux-trace-kernel@vger.kernel.org>, adubey@linux.ibm.com,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, KP Singh
 <kpsingh@chromium.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, Will Deacon <will@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Florent Revest <revest@chromium.org>, Puranjay
 Mohan <puranjay@kernel.org>
Subject: Re: Unsupported CONFIG_FPROBE and CONFIG_RETHOOK on ARM64
Message-Id: <20240912085346.154b18ca686c7c4595e93c9a@kernel.org>
In-Reply-To: <CAEf4BzaWtsAeXyDWh7kq8Qnyy=9u7iAVonmefNRvXnTfbv03yg@mail.gmail.com>
References: <CAEf4BzaYyEftmRmt6FswrTOsb9FuQMtzuDXD4OJMO7Ein2ZRGg@mail.gmail.com>
	<CAEf4BzasRqeAY3ZpBDbjyWSKUriZgUf4U_YoQNSSutKhX5g2kw@mail.gmail.com>
	<20240911091343.77c60bc2e5d96cbfd8787c19@kernel.org>
	<CAEf4BzbdxSbaK1V10j8t_rjG4ZnYsFQLqPrBSswR8KhjmC=5cg@mail.gmail.com>
	<20240912001848.d9629a1579ea3ef6531a9a0b@kernel.org>
	<CAEf4BzaWtsAeXyDWh7kq8Qnyy=9u7iAVonmefNRvXnTfbv03yg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 13:18:12 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> > > So while I get the desire to have a clean and nice
> > > end goal, and that it might take a bit longer to get everything right.
> > > But, maybe, landing a stop-gap solution meanwhile (especially as
> > > isolated and thus easily backportable as the patch [0] you referenced)
> > > is an OK path forward?
> >
> > I had not realized that the PSTATE register was not saved correctly
> > at that point. This is one reason why I decided to move in the
> > current fprobe-on-fgraph direction.
> 
> Sure, but you said yourself, the same problem exists with current
> kretprobe implementation, so this won't regress anything. And yes,
> your fprobe-on-fgraph series is supposed to fix this for good, which
> is great, but that's a separate topic.

It does not regress kretprobe, but introduces the same problem to
fprobe. And since fprobe-on-fgraph was boosted by this problem,
I think that is not a separate topic.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

