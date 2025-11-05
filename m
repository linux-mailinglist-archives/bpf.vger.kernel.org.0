Return-Path: <bpf+bounces-73568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF28C33E12
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 04:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E097B18C599C
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 03:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D00264636;
	Wed,  5 Nov 2025 03:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FVw/zyN3"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9797F223DF9
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 03:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762314528; cv=none; b=K58266tGs2VEXljcWxKMwZkeYOIIyOdNDcMq7xHsu23os8GPQhZNoIMjJPVnuuHrG1dh+okXznSWA9BquDARiMvpdnUhiikc6BFu4kHTzhe2LYpBT/quTOZix9gjhmZ/stk8fsgPIyT0lteGS5HfPpnOaNHc49klkMyO9msYKsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762314528; c=relaxed/simple;
	bh=lprbrqeDCWBBKYZswyl5JnNTLCbN4xBuZvfW1guI8/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltMdYZZAvbTOSEefCzUNL/WgmZGKWwEO0Y17C4nQeDXojIYb541AkElFSk7bmMrfysNJTZJGLMMjVO8C3bnydLmt03iq9kaordh+LJHgRIwgSXiIHYBG+wtUEDTcFQ1n37HAym7sCrc2fhiIbncPGDnPtFo9mVuBSDZWy9KGBVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FVw/zyN3; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762314522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLgfXQlNwClqEIZ980jRLCrkzhFoUxSQggGknTOmJw0=;
	b=FVw/zyN3BWn6LKvr9d6JUlvchkmjPPA6kvl7pij6s/oQFuTFeneHUImkduUFa85Y0yJ0qC
	juQLlfVb+ZW4GuChQaFNuIiDj2XiBZXyFRUDrWp8NoRj2pb0+sIyPjs1MJIZMfLRJHNynb
	4F3u/lLNhQQVj7mOxZihSk/uzhOCWI0=
From: Menglong Dong <menglong.dong@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Leon Hwang <leon.hwang@linux.dev>, jiang.biao@linux.dev,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject:
 Re: [PATCH bpf-next v3 4/7] bpf,x86: add tracing session supporting for
 x86_64
Date: Wed, 05 Nov 2025 11:48:27 +0800
Message-ID: <2328886.iZASKD2KPV@7950hx>
In-Reply-To:
 <CAADnVQKV_a7NxvWwXDgRab_gakwJ=VadZ0=eC5sHwutVyM0rmg@mail.gmail.com>
References:
 <20251026030143.23807-1-dongml2@chinatelecom.cn>
 <CAEf4Bzas7Or4yPzqdHqEcgVpTDx2j26dR5oRnSg7bepr-uDqHw@mail.gmail.com>
 <CAADnVQKV_a7NxvWwXDgRab_gakwJ=VadZ0=eC5sHwutVyM0rmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/5 10:43, Alexei Starovoitov wrote:
> On Tue, Nov 4, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Nov 3, 2025 at 3:29=E2=80=AFAM Menglong Dong <menglong.dong@lin=
ux.dev> wrote:
> > >
> > > On 2025/11/1 01:57, Alexei Starovoitov wrote:
> > > > On Thu, Oct 30, 2025 at 8:36=E2=80=AFPM Menglong Dong <menglong8.do=
ng@gmail.com> wrote:
> > > > >
> > > > > On Fri, Oct 31, 2025 at 9:42=E2=80=AFAM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Sat, Oct 25, 2025 at 8:02=E2=80=AFPM Menglong Dong <menglong=
8.dong@gmail.com> wrote:
> > > > > > >
> > > > > > > Add BPF_TRACE_SESSION supporting to x86_64. invoke_bpf_sessio=
n_entry and
> > > > > > > invoke_bpf_session_exit is introduced for this purpose.
> > > > > > >
> > > > > > > In invoke_bpf_session_entry(), we will check if the return va=
lue of the
> > > > > > > fentry is 0, and set the corresponding session flag if not. A=
nd in
> > > > > > > invoke_bpf_session_exit(), we will check if the corresponding=
 flag is
> > > > > > > set. If set, the fexit will be skipped.
> > > > > > >
> > > > > > > As designed, the session flags and session cookie address is =
stored after
> > > > > > > the return value, and the stack look like this:
> > > > > > >
> > > > > > >   cookie ptr    -> 8 bytes
> > > > > > >   session flags -> 8 bytes
> > > > > > >   return value  -> 8 bytes
> > > > > > >   argN          -> 8 bytes
> > > > > > >   ...
> > > > > > >   arg1          -> 8 bytes
> > > > > > >   nr_args       -> 8 bytes
> >
> > Let's look at "cookie ptr", "session flags", and "nr_args". We can
> > combine all of them into a single 8 byte slot: assign each session
> > program index 0, 1, ..., Nsession. 1 bit for entry/exit flag, few bits
> > for session prog index, and few more bits for nr_args, and we still
> > will have tons of space for some other additions in the future. From
> > that session program index you can calculate cookieN address to return
> > to user.

Yeah, it should work, and I thought this way too. I didn't do it
this way, because I have to adopt the usage of "nr_args" in all the
arch, which makes this series looks complicated. We can do it this
way if we still use this solution.

> >
> > And we should look whether moving nr_args into bpf_run_ctx would
> > actually minimize amount of trampoline assembly code, as we can
> > implement a bunch of stuff in pure C. (well, BPF verifier inlining is
> > a separate thing, but it can be mostly arch-independent, right?)

If we still on this way, it worth a try.

>=20
> Instead of all that I have a different suggestion...
>=20
> how about we introduce this "session" attach type,
> but won't mess with trampoline and whole new session->nr_links.
> Instead the same prog can be added to 'fentry' list
> and 'fexit' list.
> We lose the ability to skip fexit, but I'm still not convinced
> it's necessary.
> The biggest benefit is that it will work for existing JITs and trampoline=
s.
> No new complex asm will be necessary.
> As far as writable session_cookie ...
> let's add another 8 byte space to bpf_tramp_run_ctx

I'm OK with this approach too. In fact, the session cookie can
also be used to store the information that if skip the fexit, and
the user can do the skipping by themselves.

However, we need to implement bpf_session_is_return() to tell
if the current prog is fexit, as we attach the prog to both the
entry and exit of the target function. And it still need to be done
in the trampoline, and maybe we can reuse the nr_args for this
purpose :/

If we don't want to modify the trampoline, I think a way
is that we don't introduce tracing session, and simply add the
"session cookie", and all the fentry and fexit is able to read/write
it.

Wait a minutes......we can directly make the attach cookie writable?
Things become weird now........

> and only allow single 'fsession' prog for a given kernel function.

Maybe we don't need to limit it to give the user more choice?
=46or example, progA use the first 4-bytes, and progB use the
last 4-bytes. Hmm...it's a little dangerous, things may mess up
if they don't talk it over beforehand.

Thanks!
Menglong Dong

> Again to avoid changing all trampolines.
> This way the feature can be implemented purely in C and no arch
> specific changes.
> It's more limited, but doesn't sound that the use case for multiple
> fsession-s exist. All this is on/off tracing. Not something
> that will be attached 24/7.
>=20
>=20





