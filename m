Return-Path: <bpf+bounces-70726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4FABCCD37
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 14:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DB53B8785
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 12:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE557288C3B;
	Fri, 10 Oct 2025 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OxBDD2Lh"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E391C2882AC
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760097940; cv=none; b=PfzcgC0mQ7AcLOQeqjgDypwA5u37ntRqXlguK1XapPzXXkw0yw9GIpeIi9zJ0Vq0APlCE2mX9x0JcJsMxWBnzDOill3r40rV7tixa9aEMF2m5WWqZqeMKwTZ3y1+UQFk8LieNbGBtzZ/+ZJkaVuJcbR3vTVL8JP5iFSQergyrTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760097940; c=relaxed/simple;
	bh=c6FZUJ87VJV2SHBTZSiSrj04fSF+beoy53iVYqVx7Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCUl+DAObOInKeZbD+aymYuJdQcpv9gtPQ/V4Jlm6RXnuZb+ndveuAaWH6CONqF+bgdQVXFdFSWETx933vn6vZaxbJkhoCZGvYsdupnQ1QcAAEy/GQcyP7SZD25QmJa5r2wEyoFq/MCOOZwKwnIRYzXAoBUjsVD6zA1hG05yWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OxBDD2Lh; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760097925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6FZUJ87VJV2SHBTZSiSrj04fSF+beoy53iVYqVx7Kw=;
	b=OxBDD2LhJsyZXu9L/ho5qTLiT68ifM8pf3HU68POPo3jwWfqIWz06A05E/9S04tx1i/yOW
	NMoQuwa61y7+K1uzP6lXulfDO2XOXX5Vn4PtOD+qX9ZP1Yb6Ntqbdtevu/0KBH7Idr+r/u
	oy6WGNjQMEcEc9TFA2yEdEA63OH1s3Y=
From: Menglong Dong <menglong.dong@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Leon Hwang <hffilwlqm@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
Subject:
 Re: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe fault to BPF
 stderr
Date: Fri, 10 Oct 2025 20:05:10 +0800
Message-ID: <3349652.5fSG56mABF@7950hx>
In-Reply-To:
 <CAP01T77agpqQWY7zaPt9kb6+EmbUucGkgJ_wEwkPFpFNfxweBg@mail.gmail.com>
References:
 <20250927061210.194502-1-menglong.dong@linux.dev>
 <0adc5d8a299483004f4796a418420fe1c69f24bc.camel@gmail.com>
 <CAP01T77agpqQWY7zaPt9kb6+EmbUucGkgJ_wEwkPFpFNfxweBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/9 04:08, Kumar Kartikeya Dwivedi wrote:
> On Wed, 8 Oct 2025 at 21:34, Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> > On Wed, 2025-10-08 at 19:08 +0200, Kumar Kartikeya Dwivedi wrote:
> > > On Wed, 8 Oct 2025 at 18:27, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Wed, Oct 8, 2025 at 7:41=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.=
com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 2025/10/7 14:14, Menglong Dong wrote:
> > > > > > On 2025/10/2 10:03, Alexei Starovoitov wrote:
> > > > > > > On Fri, Sep 26, 2025 at 11:12=E2=80=AFPM Menglong Dong <mengl=
ong8.dong@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Introduce the function bpf_prog_report_probe_violation(), w=
hich is used
> > > > > > > > to report the memory probe fault to the user by the BPF std=
err.
> > > > > > > >
> > > > > > > > Signed-off-by: Menglong Dong <menglong.dong@linux.dev>
> > > > >
> > > > > [...]
> > > > >
[......]
> > >
> > > Yeah, agreed that this would be useful, particularly in this case. I'm
> > > wondering how we'll end up implementing this.
> > > Sounds like it needs to be tied to the program's invocation, so it
> > > cannot be per-cpu per-program, since they nest. Most likely should be
> > > backed by run_ctx, but that is unavailable in all program types. Next
> > > best thing that comes to mind is reserving some space in the stack
> > > frame at a known offset in each subprog that invokes this helper, and
> > > use that to signal (by finding the program's bp and writing to the
> > > stack), the downside being it likely becomes yet-another arch-specific
> > > thing. Any other better ideas?
> >
> > Another option is to lower probe_read to a BPF_PROBE_MEM instruction
> > and generate a special kind of exception handler, that would set r0 to
> > -EFAULT. (We don't do this already, right? Don't see anything like that
> > in verifier.c or x86/../bpf_jit_comp.c).
> >
> > This would avoid any user-visible changes and address performance
> > concern. Not so convenient for a chain of dereferences a->b->c->d,
> > though.
>=20
> Since we're piling on ideas, one of the other things that I think
> could be useful in general (and maybe should be done orthogonally to
> bpf_errno)
> is making some empty nop function and making it not traceable reliably
> across arches and invoke it in the bpf exception handler.
> Then if we expose prog_stream_dump_stack() as a kfunc (should be
> trivial), the user can write anything to stderr that is relevant to
> get more information on the fault.

Thanks for all the ideas! So we have following approaches
on this problem:

may_goto(Kumar)
=2D-------------------------
Hmm......I haven't figure how this work on this problem yet.

"may_goto" is a condition break, does it mean that we introduce
a "condition_fault"? Will it need the supporting of the compiler?

I'm not sure if this is the right understanding: save the fault
type(PROBE_FAULT, AREA_READ_FAULT, AREA_WRITE_FAULT) to
the stack or the run_ctx, and the "if (condition_fault)" will be
replace with "if (__stack or run_ctx)".

save errno to r0(Eduard)
=2D----------------------------------
Save the errno to r0 in the exception handler of BPF_PROBE_MEM,
and read r0 with a __kfun in BPF program. (Not sure if I understand
it correctly).

This sounds effective, but won't this break the usage of r0? I mean,
the r0 can be used by the BPF program somewhere.

trace error event(Kumar)
=2D-----------------------------------
Call a empty and traceable function in the exception handler.

This maybe the simplest way, and I think the only shortcoming
is that there may be some noise, as the the BPF program can
receive the fault event from other BPF users.

And maybe it's better to pass the bpf prog to the arguments of
the empty function, therefore users can do some filter. Or, we
can introduce a tracepoint for this propose.

And I think this is the similar way that Leon suggested later.

bpf errno(Leon)
=2D---------------------
introduce a percpu variable, save the -EFAULT to it in the
exception handler. Introduce the __kfunc to read, set and
clear the errno.

output the error information directly to STDERR(Menglong)
=2D------------------------------------------------------------------------=
=2D------------
As it described.

Ah......it seems we have many approaches here, and most
of them work. Do we have any ideas on these ideas?

Thanks!
Menglong Dong

>=20
> It is then up to the user to decide the rate of messages for such
> faults etc. and get more information if needed.
>=20





