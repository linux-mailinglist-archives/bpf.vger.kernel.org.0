Return-Path: <bpf+bounces-27492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7248AD948
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 01:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF901F22B6A
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 23:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5747F45979;
	Mon, 22 Apr 2024 23:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POMptckr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E81444C9C
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 23:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829681; cv=none; b=IL9gsYQQsTSGL/ZTTv9c4MUEYdNwZcNothO/ki8V4JXpVLHAupwXOiP7p1JmhsmmdvkJCkHHN4nv+ED5rB3WtjwHZLtPjVhGwthRPBRbOhpqnkgBeewJ/MuvGz5hn7Mhsjs9rQuL/hSllGz+4oLAX9EXCEVtan/NXYEUCxIlhIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829681; c=relaxed/simple;
	bh=Ah8DXrQGiurSc8zrC01VGOUbXyVIHW5IRWR6qpNk2YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHqRFbdLo2aigUNWuR1HUfg8jw6jGNhmc9vrh3RIDREQrcj8oHPgHDmpxYsjcU08jbUlumht8OAECYKpIzGJHxz6umfdAZ16d/Ti7hVDKAae55YlXP0v1tym4/UizaTG/Pgcpc3L9/u/F+8rYOPeFpLRyARSA+ef3EVyBAGDKJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POMptckr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34388753650so2601272f8f.3
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 16:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713829678; x=1714434478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0U4gqdi/Ry/a7UldVubMo2KV9OlD1cfV9vx7ihiisSw=;
        b=POMptckrRrQdmxqD+1XpbtaxG+3liqLp/u7FBOsrFwZwsiHOP6X7MViwThU62ZrnRA
         M+8NYSGjR9/lEdjPkUr1bugXUeKulEXux5UiCCqvWzKAAzBKIgK87QkXvYmtUzAh9t0w
         pgMHXyOKVhM1OnMKs6hVfFXASL5M0v+nkq2VZmLtrRYuu19ZcwEmh1LXrzuc5mWsbZI9
         Jq3uDlbXfscNgqCfB8Rfc4OjQxglOcDkiPCBrTOX4uX/vYQt/JbjP+KDy5a/6Ahjxp+c
         WnFspthl+KDDaGWNBSXn9YzcokI224ycAxVmPnUFNanFe3CysyBMsh2Na6LdgaOOc5nN
         EOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713829678; x=1714434478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0U4gqdi/Ry/a7UldVubMo2KV9OlD1cfV9vx7ihiisSw=;
        b=BBsm+AoOHzHc5BfH4Hp/LesES2r0YwbhtHwhllB/BNeIGCnFL33pI0WTymyw0ekUVF
         jtc4ygbYMwl+h6zRlUO4nxN54x+MXoz78yAvOwGq7/KNRUR1ZAVqQfciZY7Pk82LO3Sr
         Tc/KhxhXlUxxOWP37wisr9u5P5ORhcUjlv/EIC2z/A28oJqtLVExzURAy6Y/MN/xRPGq
         rPpnaMPYLbBrlyiHHq7c/4lL8Rew6YCvEBgnEvysU41gmXQTDogzURchOuEwFyLuDB1m
         zxfEWg/CnNMhPLezGqtAbtP5NZq69G1lthk3dTqQWtOIkHqPGrB0u7Hh+g0X7v2yJjLr
         LDnA==
X-Forwarded-Encrypted: i=1; AJvYcCX5HjG0CTdkh1z3bW6lpE7QF+tGFYx3y30DNq9SWBnPxmilkXWZdE3dlT7GRSQcXKJVfuA4K2nxIe/NsXraFBCxCb/B
X-Gm-Message-State: AOJu0Yzj+QX7kMaV8v2zOrkzUHmGKBPunRuZ7ZgtVCqiQdFFqKJfw8so
	W/jhTMP+3Mxk4K0ut8SxvtteFWE7Dy5Xku77m6dpWqlc60Lda1SKkV8Gwbbit7he4R1/b/5xsZF
	8L2BQ1XuZYPTYCgg5YSqd82OTh+M=
X-Google-Smtp-Source: AGHT+IGEM508RLbiqVcYP9Mgw9EBP+wcm0Hs8eey4YjjvQKU6h/fE7Rrkv9rR97xD1MfjPRC8ObGYTC4hVk+RSmw0Fo=
X-Received: by 2002:a5d:5412:0:b0:343:dcbc:62df with SMTP id
 g18-20020a5d5412000000b00343dcbc62dfmr8115380wrv.50.1713829678176; Mon, 22
 Apr 2024 16:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421234336.542607-1-sidchintamaneni@vt.edu>
 <ZiYWKbDKp2zHBz6S@krava> <CAADnVQLn+zCAGCcFeE3wUfGULXBs3xii2shYTmS1BQMN5ZNYbQ@mail.gmail.com>
 <CAE5sdEgMB=hGjsCfSFkdS-b_YJDErobu=r1-xKvMkqZqLuW8=A@mail.gmail.com>
In-Reply-To: <CAE5sdEgMB=hGjsCfSFkdS-b_YJDErobu=r1-xKvMkqZqLuW8=A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Apr 2024 16:47:46 -0700
Message-ID: <CAADnVQK+yZVcDTKNEKNdyJ9kaCHffcp9Wd0QLvipM9RykvByVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] Add notrace to queued_spin_lock_slowpath
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, miloc@vt.edu, rjsu26@vt.edu, sairoop@vt.edu, 
	Dan Williams <djwillia@vt.edu>, Siddharth Chintamaneni <sidchintamaneni@vt.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 4:20=E2=80=AFPM Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> On Mon, 22 Apr 2024 at 13:13, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Apr 22, 2024 at 12:47=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com>=
 wrote:
> > >
> > > On Sun, Apr 21, 2024 at 07:43:36PM -0400, Siddharth Chintamaneni wrot=
e:
> > > > This patch is to prevent deadlocks when multiple bpf
> > > > programs are attached to queued_spin_locks functions. This issue is=
 similar
> > > > to what is already discussed[1] before with the spin_lock helpers.
> > > >
> > > > The addition of notrace macro to the queued_spin_locks
> > > > has been discussed[2] when bpf_spin_locks are introduced.
> > > >
> > > > [1] https://lore.kernel.org/bpf/CAE5sdEigPnoGrzN8WU7Tx-h-iFuMZgW06q=
p0KHWtpvoXxf1OAQ@mail.gmail.com/#r
> > > > [2] https://lore.kernel.org/all/20190117011629.efxp7abj4bpf5yco@ast=
-mbp/t/#maf05c4d71f935f3123013b7ed410e4f50e9da82c
> > > >
> > > > Fixes: d83525ca62cf ("bpf: introduce bpf_spin_lock")
> > > > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
> > > > ---
> > > >  kernel/locking/qspinlock.c                    |  2 +-
> > > >  .../bpf/prog_tests/tracing_failure.c          | 24 +++++++++++++++=
++++
> > > >  .../selftests/bpf/progs/tracing_failure.c     |  6 +++++
> > > >  3 files changed, 31 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.=
c
> > > > index ebe6b8ec7cb3..4d46538d8399 100644
> > > > --- a/kernel/locking/qspinlock.c
> > > > +++ b/kernel/locking/qspinlock.c
> > > > @@ -313,7 +313,7 @@ static __always_inline u32  __pv_wait_head_or_l=
ock(struct qspinlock *lock,
> > > >   * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'=
  :
> > > >   *   queue               :         ^--'                           =
  :
> > > >   */
> > > > -void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, =
u32 val)
> > > > +notrace void __lockfunc queued_spin_lock_slowpath(struct qspinlock=
 *lock, u32 val)
> > >
> > > we did the same for bpf spin lock helpers, which is fine, but I wonde=
r
> > > removing queued_spin_lock_slowpath from traceable functions could bre=
ak
> > > some scripts (even though many probably use contention tracepoints..)
> > >
> > > maybe we could have a list of helpers/kfuncs that could call spin loc=
k
> > > and deny bpf program to load/attach to queued_spin_lock_slowpath
> > > if it calls anything from that list
> >
> > We can filter out many such functions, but the possibility of deadlock
> > will still exist.
> > Adding notrace here won't help much,
> > since there are tracepoints in there: trace_contention_begin/end
> > which are quite useful and we should still allow bpf to use them.
> > I think the only bullet proof way is to detect deadlocks at runtime.
> > I'm working on such "try hard to spin_lock but abort if it deadlocks."
>
> I agree with the point that notracing all the functions will not
> resolve the issue. I could also find a scenario where BPF programs
> will end up in a deadlock easily by using bpf_map_pop_elem and
> bpf_map_push_elem helper functions called from two different BPF
> programs accessing the same map. Here are some issues raised by syzbot
> [2, 3].

ringbuf and stackqueue maps should probably be fixed now
similar to hashmap's __this_cpu_inc_return(*(htab->map_locked...)
approach.
Both ringbug and queue_stack can handle failure to lock.
That will address the issue spotted by these 2 syzbot reports.
Could you work on such patches?

The full run-time solution will take time to land and
may be too big to be backportable.
I'll certainly cc you on the patches when I send them.

>  I also believe that a BPF program can end up in a deadlock scenario
> without any assistance from the second BPF program, like described
> above. The runtime solution sounds like a better fit to address this
> problem, unless there is a BPF program that should definitely run for
> the performance or security of the system (like an LSM hook or a
> nested scheduling type program as mentioned here [1]).

Right. Certain bpf progs like tcp-bpf don't even have a recursion
run-time counter, because they have to nest and it's safe to nest.

> In those cases, the user assumes that these BPF programs will always
> trigger. So, to address these types of issues, we are currently
> working on a helper's function callgraph based approach so that the
> verifier gets the ability to make a decision during load time on
> whether to load it or not, ensuring that if a BPF program is attached,
> it will be triggered.

callgraph approach? Could you share more details?

>
> [1] https://lore.kernel.org/all/a15f6a20-c902-4057-a1a9-8259a225bb8b@linu=
x.dev/
> [2] https://lore.kernel.org/lkml/0000000000004aa700061379547e@google.com/
> [3] https://lore.kernel.org/lkml/0000000000004c3fc90615f37756@google.com/
>
> PS. We are following a similar approach to solve the stackoverflow
> problem with nesting.

Not following. The stack overflow issue is being fixed by not using
the kernel stack. So each bpf prog will consume a tiny bit of stack
to save frame pointer, return address, and callee regs.

