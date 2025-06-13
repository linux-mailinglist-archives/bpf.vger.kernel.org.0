Return-Path: <bpf+bounces-60569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B49BAD80F9
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 04:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199B53B8344
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 02:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9558A2222B6;
	Fri, 13 Jun 2025 02:27:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8630221D94;
	Fri, 13 Jun 2025 02:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749781643; cv=none; b=iNixb0JgWjBXexLYMIRgJtGJ9/kI1VZyqZZMWNVOEzz751R34SnEpzwGkzJA6RLopzGSnSY2gQRPyyeXdWThbJc8HgTOJBbtESw1QR0q2ZFMYr5EklcriNJtGIe0UTvy2alAmmhiDO+D9z3ssBu+1IRF6oeVr5cEcngu1QLRbXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749781643; c=relaxed/simple;
	bh=5yip3kb/uXHDzziQvUnC/6AazHd/eRmyu6rm2WrhVm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gAwlkYOaN5sFS/4DrCqnv9OW6m7ZY6MyFRjL/AtXNjEHc0MFQEpKHzhPy/ETQMVv07aBWqHAgkg+wFEkdF0CtR0168CaXXBpO4rkdOof6MZVw0Xj6oxTx8UTM/jyWFct7G7gZz0WWcA/kIR/6dW05pvXGZKfQG1dXtDyS9h7M1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 3AA385C626;
	Fri, 13 Jun 2025 02:26:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id BB20930;
	Fri, 13 Jun 2025 02:26:53 +0000 (UTC)
Date: Thu, 12 Jun 2025 22:26:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH v2] xdp: tracing: Hide some xdp events under
 CONFIG_BPF_SYSCALL
Message-ID: <20250612222652.229eaa9c@batman.local.home>
In-Reply-To: <CAADnVQKEosaLbpLg4Zk_CcDSKT+Jzb3ScKQWBA51vLHt-AoQ8A@mail.gmail.com>
References: <20250612182023.78397b76@batman.local.home>
	<CAADnVQKEosaLbpLg4Zk_CcDSKT+Jzb3ScKQWBA51vLHt-AoQ8A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: BB20930
X-Stat-Signature: 951scg5cjfx8jkqraazt7kz8q97i8m78
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/tkEmgrH76JFA6D39uy7avEvTqIygOF6w=
X-HE-Tag: 1749781613-255969
X-HE-Meta: U2FsdGVkX19pH4pVTyeC9rmZu58S+wheISxQ2eujOYvLAd3K9X5UXYOcvHtT9H31sN5LMrVshnuKZHpsyJFf6QjgaxZJndjAF0YphG1J4ROgjzeKrCP3mRNzf3n/nIVYTksOvt8uBkIHYQ/UFxRx18HnP7FjlUUFadrcZUBMw7vdy62g2SA2wgFtYdaHt50JFzdaTlO+Xzy+XO103nsQieyb2xQcF0oBSBcaPegZFX8z4yYDATVI9GB59JZr89IBTfNWO304+jAS73Ef6dA8TA/WS9Qi6JmjxELBm0nV5T5EPpWMV0/XXX7qg5LoTOsnpyAgILMw+SVNXIJLcAgpMS90XZz0447ZykWDXx+xAPIH4GrqqxzggvMLxFdADwRrdHPtP2QKNOGl98vZKp7CojGbVho2QVVQJjEjg5BRTZg=

On Thu, 12 Jun 2025 19:16:33 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Thu, Jun 12, 2025 at 3:20=E2=80=AFPM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > From: Steven Rostedt <rostedt@goodmis.org>
> >
> > The events xdp_cpumap_kthread, xdp_cpumap_enqueue and xdp_devmap_xmit a=
re
> > only called when CONFIG_BPF_SYSCALL is defined.  As each event can take=
 up
> > to 5K regardless if they are used or not, it's best not to define them
> > when they are not used. Add #ifdef around these events when they are not
> > used.
> >
> > Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> > Changes since v1: https://lore.kernel.org/20250612101612.3d4509cc@batma=
n.local.home
> >
> > - Rebased on top of bpf-next =20
>=20
> We can certainly take it, but you mentioned you're working
> on some patches that will warn when tracepoint is not used.
> So do you need this to land sooner than the next merge window ?

No. I plan on sending that code near the end of the next merge window
to let these patches get in before they start to add warnings.

I'm also going to wait till near the end of this cycle before I add
that code to linux-next to keep the warnings happening there too soon.

So, please take it. That way there's less likelihood of another
conflict.

Thanks,

-- Steve

