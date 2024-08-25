Return-Path: <bpf+bounces-38027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC3395E2EE
	for <lists+bpf@lfdr.de>; Sun, 25 Aug 2024 12:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D87A6B21577
	for <lists+bpf@lfdr.de>; Sun, 25 Aug 2024 10:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8F113E41A;
	Sun, 25 Aug 2024 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBEjwUxk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD4D13C690;
	Sun, 25 Aug 2024 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724580917; cv=none; b=R0TOSuM6F2C21CXu7gO9XFw32QLTR08HhrvBSnwlQyk7zyXYPb1QrgtmEtn2EJ5KAzOQLbvUc7njQpM8K3uznMKOvu4QhGSuVjCgulq3Dv/OSpLv3cpEqvkbnshtb56ywPS7fgremCG8hgA4Dy48iHZYBtjwLnr7wIMqf28IcgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724580917; c=relaxed/simple;
	bh=OgVvYVX7Nh7kfTUBTqYQ9e/jiYo0TOw3Tg0uSrMDaOA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZIIs5+TfKWIM4abPCp6fQXhpWZZly+N+FRpDsPIY725/OOyKhzoPNx6/pRMQXpeUxJ2g3tgRh1ZVmYT6jtieOCys0luR8RWpC5+hGVHlp07bTvqw48WIQZxCOwTKeQo2gHPQJ+dtnRPRnXKxMvtJkSx5IJXYg3MvlG4ZXHz+T/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBEjwUxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68772C32782;
	Sun, 25 Aug 2024 10:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724580916;
	bh=OgVvYVX7Nh7kfTUBTqYQ9e/jiYo0TOw3Tg0uSrMDaOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rBEjwUxkk0uM01iXhsp01DvKNqJo83GSiitgk3wgruNF6EZVj+3ERU+wbjbt+hg06
	 iiiyIvzbkM8e7NYiUVknMskx3n4BaW3IoPPclCqYz73IP0XLHf/pehlMP1zy09QCht
	 4qtiHIHczW96GjiGdFb3Ky35/2sEl2Scp+nPn295HwcUdbwaxFARzduM7CvC2dVAQS
	 jk0MxGJHIrauGJaIx39URGMpoWlONQwjYqkgJosbnlOwUzd5N5ECbwSntHH3Q/fG0s
	 Z92q7PqZUeVQD7/YLSbQWU5LDxNyx5r8W6nr63p7iCXB5bNouwMGoCbITIMwvTq6uy
	 PYzYxGz6oPdsg==
Date: Sun, 25 Aug 2024 19:15:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, peterz@infradead.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, jolsa@kernel.org
Subject: Re: [PATCH v2] uprobes: make trace_uprobe->nhit counter a per-CPU
 one
Message-Id: <20240825191512.98a6ea20b4783345f4d5ba1b@kernel.org>
In-Reply-To: <20240813154055.GA7423@redhat.com>
References: <20240809192357.4061484-1-andrii@kernel.org>
	<20240813223014.1a5093ede1a5046aaedea34a@kernel.org>
	<20240813154055.GA7423@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 17:41:04 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 08/13, Masami Hiramatsu wrote:
> >
> > > @@ -62,7 +63,7 @@ struct trace_uprobe {
> > >  	struct uprobe			*uprobe;
> >
> > BTW, what is this change? I couldn't cleanly apply this to the v6.11-rc3.
> > Which tree would you working on? (I missed something?)
> 
> tip/perf/core
> 
> See https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/diff/kernel/trace/trace_uprobe.c?h=perf/core&id=3c83a9ad0295eb63bdeb81d821b8c3b9417fbcac

OK, let me consider to rebase on tip/perf/core.

Thank you,

> 
> Oleg.
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

