Return-Path: <bpf+bounces-46426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E619EA1AD
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 23:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21A7283EED
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 22:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4709B19DFA2;
	Mon,  9 Dec 2024 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJzi1V/y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B41219D090;
	Mon,  9 Dec 2024 22:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733782481; cv=none; b=rH7sde7TfDtHCB37uZIAwA1u7gwmPFRJd9tBq/1QIGyPPFJBlzi/Lj7Ee2dizxStd8sLj8R+VIpVEI8YhQ/8lcAFGk8QO4EVFy0UYREJXcva0Z2Qy7opbmEzAiVivTdQ6YUIKQrNylf5wn39Hwwo2eZ9AHLoBOxvmaqnUMoTNJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733782481; c=relaxed/simple;
	bh=ctMtbSdJ9UtL2i37puBE6kxTWBOMEMOYutMlVFU5DEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6Nh3GlhelJK3cojxJ1fbMpvbmi6HvyZ/nqiiRZrmXIyRdHONCpJ79b1RtjeZmFJyV87uOlYeJmb8oREL0fp9vd1L61sRICrIjHA/XXDpNK01rOIsYItz7JiV4mmxeloxx6moCmW51G2fXSCfWhngyHP06HtZYtSJdOC2+Mkj9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJzi1V/y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216426b0865so14999225ad.0;
        Mon, 09 Dec 2024 14:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733782479; x=1734387279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LP8O4t9MK6aIIv4YkT5r4nEwiFvdRUGWejSNxLVR5AY=;
        b=GJzi1V/ycFaOalOW7QJ8pKelwerrG+7SJUJ0x9yC0xocXiMV38L7Mbr028iE0mC3mC
         GeBovOUcAip0EllE5ivz5E+ZNZ6eICmV/MUxyNyNPcm92zopiynDggcfCbfOgf/nPvBB
         2J6w8HmqvLxoZvf1z/SaWeYdm5aIltgI2/KkXk627nyDxn0QY5MP0eSl4kv2qgoyvt4m
         dcyRAH7aGGB6XgoIhSQcBkBCgcLbXmYV1tuqVbA8hiDFM9h1VviNtILXtLYblB7RU122
         3G5FiW3BPRKWE2pC+fsWk7sbKObJAPrP8V6HZ9el36xuE5ZYJrgtNe3DinGB3FQ5FF7h
         Dx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733782479; x=1734387279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LP8O4t9MK6aIIv4YkT5r4nEwiFvdRUGWejSNxLVR5AY=;
        b=rKpBeMxayyYGkVlsN4HqRKbak4ulB29QCB7OAuU2i3ZRCP56OLCbD2dgwH2N0OTT78
         HZ/vn/5dj2zcCtBpjJIC9nRSwt9sZ21BfA3esEPwX7+zYgFT9DCZ2WWwGriY/RV9AcYv
         d+cWNVCfcc7d0dTDk1y3LQ4pyUYIl5yWriG5UuxcnsR1KTEm+rTP5MXefY2ZgomJ+q/n
         rzBtp035wUWBPkn2atYvNG+G5vlVfmUMSJ+Jn1oUFdddgClDwQxleqppS5KHIyYrxeL3
         TGJ/djp7/YoRWoVFnYpMi8usXMxIR1pInFEDukPyt0ajadDpnq4nhoJxv+MdJGPBXWbZ
         1npQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpZExae8a5ebH7Q6VAGj6nS5ujnV/IDEbDPrWQ4EP3ypQTmZ3vZ9Fr2Xixmegg3py3/VE=@vger.kernel.org, AJvYcCWo2J/bqqBE6pEESSxr9iARKDw0Vk537x+WRb32tz2sPCLvwOZyJh9El1fqhkNjPdG7XtBCG8BlW1vwVr4KUWF2aHrn@vger.kernel.org, AJvYcCWxvgM2/qd8t3bSGGx05eikyNRWNPId9VaRAayVdcFrxGSKXmiQlBqoS1pTyBg7GFXqdqPw4wCk@vger.kernel.org, AJvYcCXyqDF6OWP3dC9yAs887bU4s8uEoV241RNrN5WaOKhOgJWgqGncE8jhv/YLMuNyaCg0zWT7MDhVpaNB0AhG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0bb50ORst/7xYFAAMGxoXkwJ3qFDV5RO91vQ/1vvMKMeEu1X5
	1ewxfLDcSjaRMBqud4iUcwf/DY7eiU9/R2qMcA5KbVTGVnAka4OO9LyyXyEzYjZkyNkznVZBpGD
	6Khimxb7tUmPzSEAhLgN/tefR89k=
X-Gm-Gg: ASbGncsYiPjLqGAGTRmQODl+wz16kkrCgSfdS0mrpUGgCcQwOAVYZGapjIhmiOxcEmu
	CVmhOoOhThyGhS7A+UgzSK0m5LGfhFLYr27N/bbFFw3o1s9r8FV0=
X-Google-Smtp-Source: AGHT+IGLj7LGh63DRLA0b+hxsTITITsXsK3vIKzA6WzrcPmd+hER2Q7S9YDS2C34e7DnbNwpXWs/R8AfAEY/aN+xX5E=
X-Received: by 2002:a17:903:2284:b0:216:28c4:61c6 with SMTP id
 d9443c01a7336-2166a005890mr37159465ad.34.1733782479259; Mon, 09 Dec 2024
 14:14:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-bpf-fix-uprobe-uaf-v2-1-4c75c54fe424@google.com>
 <CAEf4BzYxaKd8Gv5g8PBY6zaQukYKSjjtaSgYMjJxL-PZ0dLrbQ@mail.gmail.com>
 <CAG48ez3i5haHCc8EQMVNjKnd9xYwMcp4sbW_Y8DRpJCidJotjw@mail.gmail.com>
 <CAEf4BzYkGQ0sw9JEeAMLAfcQbzxwg46c487kBD_LcbZSaTKD5Q@mail.gmail.com>
 <CAG48ez1LRsuew4y_KQxPHNipA68hhm+iJohHbk6=1cwv5QPCxQ@mail.gmail.com>
 <CAG48ez2+3TTbWNNO4aqxFAX8Cd4COaayRxoy1V2xvM9oS2_ygQ@mail.gmail.com>
 <CAEf4BzbhDkFq9DB2VKxsHmffynQBvbD_RVKTUm3zCqvO_e1dug@mail.gmail.com> <CAG48ez2LW9zyiptNq8jApD3zeS05wvNPs-jj2zOeaCDQbZnD4g@mail.gmail.com>
In-Reply-To: <CAG48ez2LW9zyiptNq8jApD3zeS05wvNPs-jj2zOeaCDQbZnD4g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Dec 2024 14:14:27 -0800
Message-ID: <CAEf4BzbVqfWZUJUkUwJvfaGViwiP8cnVAYAWX67LP-ejPvmAPA@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix prog_array UAF in __uprobe_perf_func()
To: Jann Horn <jannh@google.com>
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

On Mon, Dec 9, 2024 at 10:22=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Sat, Dec 7, 2024 at 12:15=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Fri, Dec 6, 2024 at 3:14=E2=80=AFPM Jann Horn <jannh@google.com> wro=
te:
> > > On Fri, Dec 6, 2024 at 11:43=E2=80=AFPM Jann Horn <jannh@google.com> =
wrote:
> > > > On Fri, Dec 6, 2024 at 11:30=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > On Fri, Dec 6, 2024 at 2:25=E2=80=AFPM Jann Horn <jannh@google.co=
m> wrote:
> > > > > >
> > > > > > On Fri, Dec 6, 2024 at 11:15=E2=80=AFPM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > On Fri, Dec 6, 2024 at 12:45=E2=80=AFPM Jann Horn <jannh@goog=
le.com> wrote:
> > > > > > > >
> > > > > > > > Currently, the pointer stored in call->prog_array is loaded=
 in
> > > > > > > > __uprobe_perf_func(), with no RCU annotation and no RCU pro=
tection, so the
> > > > > > > > loaded pointer can immediately be dangling. Later,
> > > > > > > > bpf_prog_run_array_uprobe() starts a RCU-trace read-side cr=
itical section,
> > > > > > > > but this is too late. It then uses rcu_dereference_check(),=
 but this use of
> > > > > > > > rcu_dereference_check() does not actually dereference anyth=
ing.
> > > > > > > >
> > > > > > > > It looks like the intention was to pass a pointer to the me=
mber
> > > > > > > > call->prog_array into bpf_prog_run_array_uprobe() and actua=
lly dereference
> > > > > > > > the pointer in there. Fix the issue by actually doing that.
> > > > > > > >
> > > > > > > > Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by c=
haining gps")
> > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > > > > > ---
> > > > > > > > To reproduce, in include/linux/bpf.h, patch in a mdelay(100=
00) directly
> > > > > > > > before the might_fault() in bpf_prog_run_array_uprobe() and=
 add an
> > > > > > > > include of linux/delay.h.
> > > > > > > >
> > > > > > > > Build this userspace program:
> > > > > > > >
> > > > > > > > ```
> > > > > > > > $ cat dummy.c
> > > > > > > > #include <stdio.h>
> > > > > > > > int main(void) {
> > > > > > > >   printf("hello world\n");
> > > > > > > > }
> > > > > > > > $ gcc -o dummy dummy.c
> > > > > > > > ```
> > > > > > > >
> > > > > > > > Then build this BPF program and load it (change the path to=
 point to
> > > > > > > > the "dummy" binary you built):
> > > > > > > >
> > > > > > > > ```
> > > > > > > > $ cat bpf-uprobe-kern.c
> > > > > > > > #include <linux/bpf.h>
> > > > > > > > #include <bpf/bpf_helpers.h>
> > > > > > > > #include <bpf/bpf_tracing.h>
> > > > > > > > char _license[] SEC("license") =3D "GPL";
> > > > > > > >
> > > > > > > > SEC("uprobe//home/user/bpf-uprobe-uaf/dummy:main")
> > > > > > > > int BPF_UPROBE(main_uprobe) {
> > > > > > > >   bpf_printk("main uprobe triggered\n");
> > > > > > > >   return 0;
> > > > > > > > }
> > > > > > > > $ clang -O2 -g -target bpf -c -o bpf-uprobe-kern.o bpf-upro=
be-kern.c
> > > > > > > > $ sudo bpftool prog loadall bpf-uprobe-kern.o uprobe-test a=
utoattach
> > > > > > > > ```
> > > > > > > >
> > > > > > > > Then run ./dummy in one terminal, and after launching it, r=
un
> > > > > > > > `sudo umount uprobe-test` in another terminal. Once the 10-=
second
> > > > > > > > mdelay() is over, a use-after-free should occur, which may =
or may
> > > > > > > > not crash your kernel at the `prog->sleepable` check in
> > > > > > > > bpf_prog_run_array_uprobe() depending on your luck.
> > > > > > > > ---
> > > > > > > > Changes in v2:
> > > > > > > > - remove diff chunk in patch notes that confuses git
> > > > > > > > - Link to v1: https://lore.kernel.org/r/20241206-bpf-fix-up=
robe-uaf-v1-1-6869c8a17258@google.com
> > > > > > > > ---
> > > > > > > >  include/linux/bpf.h         | 4 ++--
> > > > > > > >  kernel/trace/trace_uprobe.c | 2 +-
> > > > > > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > > > > > >
> > > > > > >
> > > > > > > Looking at how similar in spirit bpf_prog_run_array() is mean=
t to be
> > > > > > > used, it seems like it is the caller's responsibility to
> > > > > > > RCU-dereference array and keep RCU critical section before ca=
lling
> > > > > > > into bpf_prog_run_array(). So I wonder if it's best to do thi=
s instead
> > > > > > > (Gmail will butcher the diff, but it's about the idea):
> > > > > >
> > > > > > Yeah, that's the other option I was considering. That would be =
more
> > > > > > consistent with the existing bpf_prog_run_array(), but has the
> > > > > > downside of unnecessarily pushing responsibility up to the call=
er...
> > > > > > I'm fine with either.
> > > > >
> > > > > there is really just one caller ("legacy" singular uprobe handler=
), so
> > > > > I think this should be fine. Unless someone objects I'd keep it
> > > > > consistent with other "prog_array_run" helpers
> > > >
> > > > Ack, I will make it consistent.
> > > >
> > > > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > > > index eaee2a819f4c..4b8a9edd3727 100644
> > > > > > > --- a/include/linux/bpf.h
> > > > > > > +++ b/include/linux/bpf.h
> > > > > > > @@ -2193,26 +2193,25 @@ bpf_prog_run_array(const struct bpf_p=
rog_array *array,
> > > > > > >   * rcu-protected dynamically sized maps.
> > > > > > >   */
> > > > > > >  static __always_inline u32
> > > > > > > -bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu =
*array_rcu,
> > > > > > > +bpf_prog_run_array_uprobe(const struct bpf_prog_array *array=
,
> > > > > > >                           const void *ctx, bpf_prog_run_fn ru=
n_prog)
> > > > > > >  {
> > > > > > >         const struct bpf_prog_array_item *item;
> > > > > > >         const struct bpf_prog *prog;
> > > > > > > -       const struct bpf_prog_array *array;
> > > > > > >         struct bpf_run_ctx *old_run_ctx;
> > > > > > >         struct bpf_trace_run_ctx run_ctx;
> > > > > > >         u32 ret =3D 1;
> > > > > > >
> > > > > > >         might_fault();
> > > > > > > +       RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu=
 lock held");
> > > > > > > +
> > > > > > > +       if (unlikely(!array))
> > > > > > > +               goto out;
> > > > > > >
> > > > > > > -       rcu_read_lock_trace();
> > > > > > >         migrate_disable();
> > > > > > >
> > > > > > >         run_ctx.is_uprobe =3D true;
> > > > > > >
> > > > > > > -       array =3D rcu_dereference_check(array_rcu, rcu_read_l=
ock_trace_held());
> > > > > > > -       if (unlikely(!array))
> > > > > > > -               goto out;
> > > > > > >         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
> > > > > > >         item =3D &array->items[0];
> > > > > > >         while ((prog =3D READ_ONCE(item->prog))) {
> > > > > > > @@ -2229,7 +2228,6 @@ bpf_prog_run_array_uprobe(const struct
> > > > > > > bpf_prog_array __rcu *array_rcu,
> > > > > > >         bpf_reset_run_ctx(old_run_ctx);
> > > > > > >  out:
> > > > > > >         migrate_enable();
> > > > > > > -       rcu_read_unlock_trace();
> > > > > > >         return ret;
> > > > > > >  }
> > > > > > >
> > > > > > > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace=
_uprobe.c
> > > > > > > index fed382b7881b..87a2b8fefa90 100644
> > > > > > > --- a/kernel/trace/trace_uprobe.c
> > > > > > > +++ b/kernel/trace/trace_uprobe.c
> > > > > > > @@ -1404,7 +1404,9 @@ static void __uprobe_perf_func(struct t=
race_uprobe *tu,
> > > > > > >         if (bpf_prog_array_valid(call)) {
> > > > > > >                 u32 ret;
> > > > > > >
> > > > > > > +               rcu_read_lock_trace();
> > > > > > >                 ret =3D bpf_prog_run_array_uprobe(call->prog_=
array,
> > > > > > > regs, bpf_prog_run);
> > > > > >
> > > > > > But then this should be something like this (possibly split acr=
oss
> > > > > > multiple lines with a helper variable or such):
> > > > > >
> > > > > > ret =3D bpf_prog_run_array_uprobe(rcu_dereference_check(call->p=
rog_array,
> > > > > > rcu_read_lock_trace_held()), regs, bpf_prog_run);
> > > > >
> > > > > Yeah, absolutely, forgot to move the RCU dereference part, good c=
atch!
> > > > > But I wouldn't do the _check() variant here, literally the previo=
us
> > > > > line does rcu_read_trace_lock(), so this check part seems like ju=
st
> > > > > unnecessary verboseness, I'd go with a simple rcu_dereference().
> > > >
> > > > rcu_dereference() is not legal there - that asserts that we are in =
a
> > > > normal RCU read-side critical section, which we are not.
> > > > rcu_dereference_raw() would be, but I think it is nice to document =
the
> > > > semantics to make it explicit under which lock we're operating.
> >
> > sure, I don't mind
> >
> > > >
> > > > I'll send a v3 in a bit after testing it.
> > >
> > > Actually, now I'm still hitting a page fault with my WIP v3 fix
> > > applied... I'll probably poke at this some more next week.
> >
> > OK, that's interesting, keep us posted!
>
> If I replace the "uprobe/" in my reproducer with "uprobe.s/", the
> reproducer stops crashing even on bpf/master without this fix -
> because it happens that handle_swbp() is already holding a
> rcu_read_lock_trace() lock way up the stack. So I think this fix
> should still be applied, but it probably doesn't need to go into
> stable unless there is another path to the buggy code that doesn't
> come from handle_swbp(). I guess I probably should resend my patch
> with an updated commit message pointing out this caveat?
>
> The problem I'm actually hitting seems to be a use-after-free of a
> "struct bpf_prog" because of mismatching RCU flavors. Uprobes always
> use bpf_prog_run_array_uprobe() under tasks-trace-RCU protection. But
> it is possible to attach a non-sleepable BPF program to a uprobe, and
> non-sleepable BPF programs are freed via normal RCU (see
> __bpf_prog_put_noref()). And that is what happens with the reproducer
> from my initial post
> (https://lore.kernel.org/all/20241206-bpf-fix-uprobe-uaf-v1-1-6869c8a1725=
8@google.com/)
> - I can see that __bpf_prog_put_noref runs with prog->sleepable=3D=3D0.
>
> So I think that while I am delaying execution in
> bpf_prog_run_array_uprobe(), perf_event_detach_bpf_prog() NULLs out
> the event->tp_event->prog_array pointer and does
> bpf_prog_array_free_sleepable() followed by bpf_prog_put(), and then
> the BPF program can be freed since the reader doesn't hold an RCU read
> lock. This seems a bit annoying to fix - there could legitimately be
> several versions of the bpf_prog_array that are still used by
> tasks-trace-RCU readers, so I think we can't just NULL out the array
> entry and use RCU for the bpf_prog_array access on the reader side. I
> guess we could add another flag on BPF programs that answers "should
> this program be freed via tasks-trace-RCU" (separately from whether
> the program is sleepable)?

Yes, we shouldn't NULL anything out.

This is the same issue we've been solving recently for sleepable
tracepoints, see [0] and other patches in the same patch set. We
solved it for sleepable (aka "faultable") tracepoints, but uprobes
have the same problem where the attachment point is sleepable by
nature (and thus protected by RCU Tasks Trace), but BPF program itself
is non-sleepable (and thus we only wait for synchronize_rcu() before
freeing), which causes a disconnect.

We can easily fix this for BPF link-based uprobes, but legacy uprobes
can be directly attached to perf event, so that's a bit more
cumbersome. Let me think what should be the best way to handle this.

Meanwhile, I agree, please send your original fix (with changes we
discussed), it's good to have them, even if they don't fix your
original issue. I'll CC you on fixes once I have them.

  [0] https://lore.kernel.org/all/20241101181754.782341-1-andrii@kernel.org=
/

