Return-Path: <bpf+bounces-34395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9CE92D413
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 16:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F7B2878B9
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 14:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA70A19046A;
	Wed, 10 Jul 2024 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9rSFHlV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD1619149A;
	Wed, 10 Jul 2024 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621090; cv=none; b=bzIg8aq2rA//ECojy/QAVKSbeIyyFJJHLeH0OtC2pbihPhX9P1RNfa6MGYmO1qs/YmoVwQuyc287+zYcaEYe9h+3af3aR6tkTysgKSKUvI1esNZnxWDwvf/RhFX8L9Y1htWeiFobAB+Top7IoMWG7vz7ljhNqCuMB2m7/ye4YEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621090; c=relaxed/simple;
	bh=XVX/KvlxE+0731pVnrMM9W2VyBZuLWY3aWe544qpR9M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=t/5suQ1iSOx5iAjuuXTtJaGGDLuvxQPLghU3rItdq/sGBa90REamKG5Pvu0zMD8j9mr67tC0D02GikG5xZsuJdxSo/cz44XYF2h87wYvQlTFv5T5iEjRwm1DzKqI4nUTiEpmBm4zUa0uIuKxca1hO2s3sAQMB4xLsRa0L5od/oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9rSFHlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FF6C4AF14;
	Wed, 10 Jul 2024 14:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720621090;
	bh=XVX/KvlxE+0731pVnrMM9W2VyBZuLWY3aWe544qpR9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S9rSFHlV1tfK77N+pAYuRHHA1WShTnMX+3zTvzco0OhqiPJUxazGuCd4cMBsKkqYJ
	 I+yzew/xd4G80uVVl8ynmXLuPMiTphQ4nLHIqbHgBDh16WBWi3nHFNFlASrz37lV2v
	 aTBgIibT5Bpyv5c92N+yp37C2pbdQqO4SHurPZa5Vs5lpz3+7BKjVBM0JPMv6PGXAP
	 8ZjblD4jb4OV8DzWcXaB+ejJGQJQ55esaz5HT8fjZUQs1gXKSx9lqR6SRt5f9fuxpc
	 BZkeQJ6QoPrIVEU7GVgDwNzvVCJmIitmuKkh4raDXNuMeCIVrcw9WYHKCkQJ9ef1E7
	 O570hbp29F7lA==
Date: Wed, 10 Jul 2024 23:18:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, mhiramat@kernel.org,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next] bpf: kprobe: remove unused declaring of
 bpf_kprobe_override
Message-Id: <20240710231805.868703dc681815bb2257b0ac@kernel.org>
In-Reply-To: <Zo6I47BQlLnNN3R-@krava>
References: <20240710085939.11520-1-dongml2@chinatelecom.cn>
	<Zo6I47BQlLnNN3R-@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 15:13:07 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Wed, Jul 10, 2024 at 04:59:39PM +0800, Menglong Dong wrote:
> > After the commit 66665ad2f102 ("tracing/kprobe: bpf: Compare instruction
> 
> should be in Fixes: tag probably ?

Yes, I'll add a Fixed tag.

> 
> > pointer with original one"), "bpf_kprobe_override" is not used anywhere
> > anymore, and we can remove it now.
> > 
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> 
> lgtm, cc-ing Masami
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks!

> 
> jirka
> 
> > ---
> >  include/linux/trace_events.h | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index 9df3e2973626..9435185c10ef 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -880,7 +880,6 @@ do {									\
> >  struct perf_event;
> >  
> >  DECLARE_PER_CPU(struct pt_regs, perf_trace_regs);
> > -DECLARE_PER_CPU(int, bpf_kprobe_override);
> >  
> >  extern int  perf_trace_init(struct perf_event *event);
> >  extern void perf_trace_destroy(struct perf_event *event);
> > -- 
> > 2.39.2
> > 
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

