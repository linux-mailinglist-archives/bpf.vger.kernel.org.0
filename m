Return-Path: <bpf+bounces-46334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062CC9E7BE1
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 23:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB631882479
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 22:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A6D1FBEAF;
	Fri,  6 Dec 2024 22:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zoa8Ya8c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C7E22C6C3
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 22:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733525034; cv=none; b=QWU5ywu2HRvt5g+uajQRGhKTfBb9e79SWgTHHAMrXY17FxfuLbWyAs+FAUot1sHrNeUWQSKfv+l0pCqa6PmuxIp2JVg2S5sgIUan/ReDkfJv2/9XWuv5ksyYtKm2VIi9tcKiT3NI1cGGBVlgWpf7JqsCVlmEfTCvSOZIR/otDhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733525034; c=relaxed/simple;
	bh=GRqnO46nzid8krfEuysxeIgBaxe3w35yymvOILNQ/94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0/xP11IGzo77VIUxvO2b02704yNVJIqx6sreS2P4jf31haKaTHLsZKZb+Wto4iJKAa+1qwR2w/QVwOERRKU6zVgaHhyuEQrTZuK6a3U+PP6p5p/d40xPixlauQ1O9OaRF123oO1irZU2J7QzDX15IufienuWIvwxWIr1/VT9Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zoa8Ya8c; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d1228d66a0so433a12.1
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 14:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733525031; x=1734129831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pywEdegimLQlBn+t8T2abCZBtIJoyKsgIBCkU4hsymM=;
        b=zoa8Ya8coF87HkvbpsJCQ1knVyXyt6qC+XvRusxA9UuF+t3szoXPT6sBQXBX06ESx5
         sDz+ZYHdAsUMZYY1wER8kZiExQFZkjJdmO28mp8RvgPFK0Hudf+J2GuMCfcYxggIYuct
         wng0kxGmn9TBO/fa4cbmO5RwUguGWQ/d03uom/86TvrVRTTKRQIDXjgKXw5lRARIoREk
         KWFHKEp8Nb7xX3gfiWKq5uxSpMfCj7aj75iGC+GmWVWlVKrXHJARefs0zIuaYXdiqk9+
         D1m8UY9uL78XKY/Ez1hyOfeDo9b+nJur0zXmnQgu1FeJkXzLcKEZCL4UfvFBDCb3UBaX
         F00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733525031; x=1734129831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pywEdegimLQlBn+t8T2abCZBtIJoyKsgIBCkU4hsymM=;
        b=nB5cwSCql0NfZ8oRtBQO1RaTX32aqBL3KVc2qGmL83pwjyzeVVTp7YN7YYiLRC5kRf
         pgZsSTt9m+9Kld00QE4rqojTPUpwyDWG/l95xKODFmfK9FBIEnyYnGdgNm7JJDb+plae
         /05NqowCtVs7sYRYyHgHxm3ul865cBrJVzOF6sh83C+9TSuvnSB/cNfn6Y/lk2/QrWKs
         yb2mQv/Tux8XUmJNCjPW22DfhAsSqIXCXKfIvyh7FEwrFO/cswo17go0wNVzLjhmJKl8
         XrtS1roRBGNMqgqu8vhMe1+As7voGtEVjhcdxVZ3YO87/iiRuCGKazuddob52d0LmOu8
         9DTA==
X-Forwarded-Encrypted: i=1; AJvYcCUrw+IHk6mjn5XDf6gBGrhgzKLB3aurwj5521PW7ShPEFvHvlxvmbI8XotmLI7o7OQbpZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZlTvgTFE4Ch6NNqKNsUY5F61JrxDigZY+2cppSVWKHLkeNE/E
	6SAo/uHnVngOTzJ6LoUbYarD/ZA6IU+zlk91Y7dB92xgh9YAv1GHC9Mpff1ByZo9/2H5LbPnWiQ
	Zzt0KQwpWPXOcnrqpIsie2r/iauWK/uoTboXR
X-Gm-Gg: ASbGnctp/9mNyjEvHPksIE1V1ublIN9XncSmVGCIv9kdWwV4fc6+unhUo4wNYQrKFOd
	gx5pYQpQOJ56hzf7RHhBzhYhoyBgt7b4sNwoI7dzegJeIhwVzCdBQ9LClcPU=
X-Google-Smtp-Source: AGHT+IEcFVlYVUQgcKyQVRnm4YZqN1F0sexw3RaThTUV7zXbpxDXVpQFQ7RHn+UrMij61DBoRTmSNblJ4FWJz1a95EY=
X-Received: by 2002:a50:eb44:0:b0:5d0:b6ff:5277 with SMTP id
 4fb4d7f45d1cf-5d3dabe69e1mr31910a12.2.1733525030223; Fri, 06 Dec 2024
 14:43:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-bpf-fix-uprobe-uaf-v2-1-4c75c54fe424@google.com>
 <CAEf4BzYxaKd8Gv5g8PBY6zaQukYKSjjtaSgYMjJxL-PZ0dLrbQ@mail.gmail.com>
 <CAG48ez3i5haHCc8EQMVNjKnd9xYwMcp4sbW_Y8DRpJCidJotjw@mail.gmail.com> <CAEf4BzYkGQ0sw9JEeAMLAfcQbzxwg46c487kBD_LcbZSaTKD5Q@mail.gmail.com>
In-Reply-To: <CAEf4BzYkGQ0sw9JEeAMLAfcQbzxwg46c487kBD_LcbZSaTKD5Q@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 6 Dec 2024 23:43:14 +0100
Message-ID: <CAG48ez1LRsuew4y_KQxPHNipA68hhm+iJohHbk6=1cwv5QPCxQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix prog_array UAF in __uprobe_perf_func()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Delyan Kratunov <delyank@fb.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:30=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Fri, Dec 6, 2024 at 2:25=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
> >
> > On Fri, Dec 6, 2024 at 11:15=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Fri, Dec 6, 2024 at 12:45=E2=80=AFPM Jann Horn <jannh@google.com> =
wrote:
> > > >
> > > > Currently, the pointer stored in call->prog_array is loaded in
> > > > __uprobe_perf_func(), with no RCU annotation and no RCU protection,=
 so the
> > > > loaded pointer can immediately be dangling. Later,
> > > > bpf_prog_run_array_uprobe() starts a RCU-trace read-side critical s=
ection,
> > > > but this is too late. It then uses rcu_dereference_check(), but thi=
s use of
> > > > rcu_dereference_check() does not actually dereference anything.
> > > >
> > > > It looks like the intention was to pass a pointer to the member
> > > > call->prog_array into bpf_prog_run_array_uprobe() and actually dere=
ference
> > > > the pointer in there. Fix the issue by actually doing that.
> > > >
> > > > Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by chaining =
gps")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > ---
> > > > To reproduce, in include/linux/bpf.h, patch in a mdelay(10000) dire=
ctly
> > > > before the might_fault() in bpf_prog_run_array_uprobe() and add an
> > > > include of linux/delay.h.
> > > >
> > > > Build this userspace program:
> > > >
> > > > ```
> > > > $ cat dummy.c
> > > > #include <stdio.h>
> > > > int main(void) {
> > > >   printf("hello world\n");
> > > > }
> > > > $ gcc -o dummy dummy.c
> > > > ```
> > > >
> > > > Then build this BPF program and load it (change the path to point t=
o
> > > > the "dummy" binary you built):
> > > >
> > > > ```
> > > > $ cat bpf-uprobe-kern.c
> > > > #include <linux/bpf.h>
> > > > #include <bpf/bpf_helpers.h>
> > > > #include <bpf/bpf_tracing.h>
> > > > char _license[] SEC("license") =3D "GPL";
> > > >
> > > > SEC("uprobe//home/user/bpf-uprobe-uaf/dummy:main")
> > > > int BPF_UPROBE(main_uprobe) {
> > > >   bpf_printk("main uprobe triggered\n");
> > > >   return 0;
> > > > }
> > > > $ clang -O2 -g -target bpf -c -o bpf-uprobe-kern.o bpf-uprobe-kern.=
c
> > > > $ sudo bpftool prog loadall bpf-uprobe-kern.o uprobe-test autoattac=
h
> > > > ```
> > > >
> > > > Then run ./dummy in one terminal, and after launching it, run
> > > > `sudo umount uprobe-test` in another terminal. Once the 10-second
> > > > mdelay() is over, a use-after-free should occur, which may or may
> > > > not crash your kernel at the `prog->sleepable` check in
> > > > bpf_prog_run_array_uprobe() depending on your luck.
> > > > ---
> > > > Changes in v2:
> > > > - remove diff chunk in patch notes that confuses git
> > > > - Link to v1: https://lore.kernel.org/r/20241206-bpf-fix-uprobe-uaf=
-v1-1-6869c8a17258@google.com
> > > > ---
> > > >  include/linux/bpf.h         | 4 ++--
> > > >  kernel/trace/trace_uprobe.c | 2 +-
> > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > >
> > >
> > > Looking at how similar in spirit bpf_prog_run_array() is meant to be
> > > used, it seems like it is the caller's responsibility to
> > > RCU-dereference array and keep RCU critical section before calling
> > > into bpf_prog_run_array(). So I wonder if it's best to do this instea=
d
> > > (Gmail will butcher the diff, but it's about the idea):
> >
> > Yeah, that's the other option I was considering. That would be more
> > consistent with the existing bpf_prog_run_array(), but has the
> > downside of unnecessarily pushing responsibility up to the caller...
> > I'm fine with either.
>
> there is really just one caller ("legacy" singular uprobe handler), so
> I think this should be fine. Unless someone objects I'd keep it
> consistent with other "prog_array_run" helpers

Ack, I will make it consistent.

> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index eaee2a819f4c..4b8a9edd3727 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -2193,26 +2193,25 @@ bpf_prog_run_array(const struct bpf_prog_arra=
y *array,
> > >   * rcu-protected dynamically sized maps.
> > >   */
> > >  static __always_inline u32
> > > -bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_r=
cu,
> > > +bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
> > >                           const void *ctx, bpf_prog_run_fn run_prog)
> > >  {
> > >         const struct bpf_prog_array_item *item;
> > >         const struct bpf_prog *prog;
> > > -       const struct bpf_prog_array *array;
> > >         struct bpf_run_ctx *old_run_ctx;
> > >         struct bpf_trace_run_ctx run_ctx;
> > >         u32 ret =3D 1;
> > >
> > >         might_fault();
> > > +       RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock he=
ld");
> > > +
> > > +       if (unlikely(!array))
> > > +               goto out;
> > >
> > > -       rcu_read_lock_trace();
> > >         migrate_disable();
> > >
> > >         run_ctx.is_uprobe =3D true;
> > >
> > > -       array =3D rcu_dereference_check(array_rcu, rcu_read_lock_trac=
e_held());
> > > -       if (unlikely(!array))
> > > -               goto out;
> > >         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> > >         item =3D &array->items[0];
> > >         while ((prog =3D READ_ONCE(item->prog))) {
> > > @@ -2229,7 +2228,6 @@ bpf_prog_run_array_uprobe(const struct
> > > bpf_prog_array __rcu *array_rcu,
> > >         bpf_reset_run_ctx(old_run_ctx);
> > >  out:
> > >         migrate_enable();
> > > -       rcu_read_unlock_trace();
> > >         return ret;
> > >  }
> > >
> > > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.=
c
> > > index fed382b7881b..87a2b8fefa90 100644
> > > --- a/kernel/trace/trace_uprobe.c
> > > +++ b/kernel/trace/trace_uprobe.c
> > > @@ -1404,7 +1404,9 @@ static void __uprobe_perf_func(struct trace_upr=
obe *tu,
> > >         if (bpf_prog_array_valid(call)) {
> > >                 u32 ret;
> > >
> > > +               rcu_read_lock_trace();
> > >                 ret =3D bpf_prog_run_array_uprobe(call->prog_array,
> > > regs, bpf_prog_run);
> >
> > But then this should be something like this (possibly split across
> > multiple lines with a helper variable or such):
> >
> > ret =3D bpf_prog_run_array_uprobe(rcu_dereference_check(call->prog_arra=
y,
> > rcu_read_lock_trace_held()), regs, bpf_prog_run);
>
> Yeah, absolutely, forgot to move the RCU dereference part, good catch!
> But I wouldn't do the _check() variant here, literally the previous
> line does rcu_read_trace_lock(), so this check part seems like just
> unnecessary verboseness, I'd go with a simple rcu_dereference().

rcu_dereference() is not legal there - that asserts that we are in a
normal RCU read-side critical section, which we are not.
rcu_dereference_raw() would be, but I think it is nice to document the
semantics to make it explicit under which lock we're operating.

I'll send a v3 in a bit after testing it.

