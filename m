Return-Path: <bpf+bounces-66765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4A0B39071
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 03:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B36680F40
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 01:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421021D5160;
	Thu, 28 Aug 2025 01:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n9O8rFBf"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029171B0F1E
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 01:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343023; cv=none; b=HfBUt0ZsqKjlfuBsR217izFPcPXAHedoUKcYNJZGIntNt1GYVaCa/mTmexSsLMm4d0jE+ltCJZUryKtcplRtbFs8OP2w/P7GpsxZmexpWb08pCs/7shqdRUeMfukZtagrK8ZkyJhnkWfF8J+DWJkjHExte2cT8vfGC8ZARLswtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343023; c=relaxed/simple;
	bh=b24uQsPaOHO5WcHk9xhEmDzHjmw2HswBoihdspk5wcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8OLMZ3Ee0f4W41vLndFNDPas/+NNcKc3IBpx6wiRq0hu2P8bXh/sOrIdQJSoPme3SkW3Lvj3yYHw8HhaCBV+YiA12gPHsJBaApCjrNZfMnupwBA/KE13ldCVVfRmT8hN730TLj6t5Y8NpwquwPrG709ok+rmgwh3nmIYRfFl90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n9O8rFBf; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756343009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4mNXbiX+NSPwA7+Q8DrgehkukiMG4HUmSlD8ae2wX4=;
	b=n9O8rFBfQ4lehqgRI0HW6JdV/AJdESHwtw1qkjaS6k31nWWYJ7AhCPk311eatnGIxsCzYL
	7Ta21nr2/EjGIOHth5kftSSA8nzm963DKTWZ4fWXkkpY5o/ErQ5GhzlPGDw3Y/Yv5g/GMA
	T592kIKywmxMHtM+v9gUF0WmAd+ougw=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject:
 Re: [PATCH bpf-next] bpf: remove unnecessary rcu_read_lock in
 kprobe_multi_link_prog_run
Date: Thu, 28 Aug 2025 09:03:07 +0800
Message-ID: <2797045.mvXUDI8C0e@7940hx>
In-Reply-To:
 <CAADnVQLBwjVhKFptO1_CEC9q1ugT1Cy2SiG5XgtD+kr7BTrr_A@mail.gmail.com>
References:
 <20250827123814.60217-1-dongml2@chinatelecom.cn>
 <CAADnVQLBwjVhKFptO1_CEC9q1ugT1Cy2SiG5XgtD+kr7BTrr_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/8/28 00:21 Alexei Starovoitov <alexei.starovoitov@gmail.com> write:
> On Wed, Aug 27, 2025 at 5:38=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Preemption is disabled in ftrace graph, which indicate rcu_read_lock. So
> > the rcu_read_lock is not needed in fprobe_entry(), and it is not needed
> > in kprobe_multi_link_prog_run() neither.
>=20
> kprobe_busy_begin() doing preempt_disable() is an implementation
> detail that might change.
> Having explicit rcu_read_lock() doesn't hurt.
> It's a nop anyway in PREEMPT_NONE.

Ok, I see. Thanks~

>=20
> pw-bot: cr
>=20
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  kernel/trace/bpf_trace.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 606007c387c5..0e79fa84a634 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2741,12 +2741,10 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_mu=
lti_link *link,
> >                 goto out;
> >         }
> >
> > -       rcu_read_lock();
> >         regs =3D ftrace_partial_regs(fregs, bpf_kprobe_multi_pt_regs_pt=
r());
> >         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
> >         err =3D bpf_prog_run(link->link.prog, regs);
> >         bpf_reset_run_ctx(old_run_ctx);
> > -       rcu_read_unlock();
> >
> >   out:
> >         __this_cpu_dec(bpf_prog_active);
> > --
> > 2.51.0
> >
>=20
>=20





