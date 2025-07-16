Return-Path: <bpf+bounces-63495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB180B080AA
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 00:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2747B5668ED
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 22:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE3E2EE979;
	Wed, 16 Jul 2025 22:49:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB17295504;
	Wed, 16 Jul 2025 22:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752706174; cv=none; b=isguiukOTdQB4W/oqmR7qBPX3uEQny1gGn5tEVb4tJJ+y6on2sapSb8An7i53sGn9QEPxfi6icsTvFpBsRHqSF8YbIRraIHvEdPkXNvJ2y5JWlCTJOgW7l/ca+e7pNeL02QUFix4MjiaMAwyOIw6dfNghiZHtICVfUIKY7ny1Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752706174; c=relaxed/simple;
	bh=FgobWPPL5UJc6tkHmmcGVrP9O6ENfzQiu0LKmH5ZpE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LB3ILn6T/7StPdHN90W9hLE4A+DyjYZdnmdDXLfNMdaxOvC8j0Wt6TzgngN5ZvxKuLMflLW2R4+Nt7NKN2ecbLlGpSVKjXlnBaEK0RgNCe5gh1pG6CfLOs9/yW6U27Qhip+eaHAfhYb6ZGnl/nhAfA/n/+HBMGxEehpgdlh66rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 193E5140557;
	Wed, 16 Jul 2025 22:49:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id BACAB30;
	Wed, 16 Jul 2025 22:49:20 +0000 (UTC)
Date: Wed, 16 Jul 2025 18:49:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Menglong Dong
 <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>, Jiri
 Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>, Network Development
 <netdev@vger.kernel.org>, "Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: Inlining migrate_disable/enable. Was: [PATCH bpf-next v2 02/18]
 x86,bpf: add bpf_global_caller for global trampoline
Message-ID: <20250716184940.17b6b073@gandalf.local.home>
In-Reply-To: <CAADnVQ+5sEDKHdsJY5ZsfGDO_1SEhhQWHrt2SMBG5SYyQ+jt7w@mail.gmail.com>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
	<20250703121521.1874196-3-dongml2@chinatelecom.cn>
	<CAADnVQKP1-gdmq1xkogFeRM6o3j2zf0Q8Atz=aCEkB0PkVx++A@mail.gmail.com>
	<45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev>
	<3bccb986-bea1-4df0-a4fe-1e668498d5d5@linux.dev>
	<CAADnVQ+Afov4E=9t=3M=zZmO9z4ZqT6imWD5xijDHshTf3J=RA@mail.gmail.com>
	<20250716182414.GI4105545@noisy.programming.kicks-ass.net>
	<CAADnVQ+5sEDKHdsJY5ZsfGDO_1SEhhQWHrt2SMBG5SYyQ+jt7w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ufh5hsfdw5t91djwkb8yex8xz3cjq94s
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: BACAB30
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18aOmIcpJFcSov7N18CBrghm4Qd1QnVBRI=
X-HE-Tag: 1752706160-545995
X-HE-Meta: U2FsdGVkX18axJzQyde3/IMQq3kuGKLF/jWYLgUKd0VE15CKbNOoe0NrkFzGWrAODBtiUaMiEoGkYM1btK7OfGewpTQfnATc/DYa3A6F973lC32nEwDHI0gm8sLLX8GvT/i0vsY35qw4vDI7TAHCb+jjFnSCl7vdZ2ukoDqaSucuLY+fanJ7yfWY/yTvuaIClr/jRWLQkSEquZrwwvnP+LIV/MLl0bQxQvYHO9iskBweQKt9WcUgsj6g5O5Tw3bJuyMY8hY665TP9ceZrBak1nSEm6qRBu+dI2JTcwnYyxEcv4M3AcWYSYSy05+UhEPO99hq0Dq/Kr39Wd6QgjatMgmHakKG4yvpNqO7c/u1uefJzLjRmE3s7A==

On Wed, 16 Jul 2025 15:35:16 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> 4.
> Maybe we should extend clang/gcc to support attr(preserve_access_index)
> on x86 and other architectures ;)
> We rely heavily on it in bpf backend.
> Then one can simply write:
> 
> struct rq___my {
>   unsigned int nr_pinned;
> } __attribute__((preserve_access_index));
> 
> struct rq___my *rq;
> 
> rq = this_rq();
> rq->nr_pinned++;
> 
> and the compiler will do its magic of offset adjustment.
> That's how BPF CORE works.

GNU Cauldron in Porto, Portugal is having a kernel track (hopefully if it
gets accepted). I highly recommend you attending and recommending these
features. It's happening two days after Kernel Recipes (I already booked my
plane tickets).

 https://gcc.gnu.org/wiki/cauldron2025

Peter, maybe you can attend too?

-- Steve

