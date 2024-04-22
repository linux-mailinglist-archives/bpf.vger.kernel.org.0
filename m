Return-Path: <bpf+bounces-27490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E000C8AD8F7
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 01:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167D21C214CB
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 23:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030A44436C;
	Mon, 22 Apr 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYEOPYoC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0F03D556
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828031; cv=none; b=l5sv28qvWBNYeORurlyXA+whQfXVOYZdNpn4cWXTC0gvlkG+xQ26Xs+N3x8nXqmLWi+nMUPbNXuT8CiIGUMkFe7qPEkghYsVkNYQX65KJayUkBzbEwRxV8qyuUd9KGF/4ARTMKEMMtjie8le2Qf48hhECxMLh3WgF+ZZV1oDKgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828031; c=relaxed/simple;
	bh=TPF77TKZX6honjKOjD5g86Reowi4MvTlZD3o0KMgT88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pf10o5z7MTPfty8KGvYdHlbwcYzar6kVp/fafX275smETsY73M3Bkne8TYPuAMTXYNrSjMClewvmdz0rGZB595duBbt/EDToW/eUUANvLlgkKcSWMY5Yvfflo+kRcSJKcFtIfAd38dHfD3MOM0nMbtJBRWHZJNxd7uM1zzItLWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYEOPYoC; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4dac3cbc8fdso1470267e0c.0
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 16:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713828029; x=1714432829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eySiNMxkeecKkQ3TWHOIb0X8Y98LF76dHdRUPEkwUk=;
        b=CYEOPYoCe5TAdA1Mb1jR5GFttz4V7lYyxYbyPMZHfGga2HAi6aWIPARIfXvkoQdob7
         dEVN2UQrNn573ariLjAzy6Q/shvOyL4f2Y0G8ZodKssALDmcvERSbDxYdlLQ4eGtuq0D
         L7FD9uxnmac0V2cukDt0IYXiI7VELNU2tsJmqAoBPdYCQNCMi6+9kQfVpcXvB99ZiRIp
         C4HChX6wbDr+sAsFSH4P15MkVfCOJDqlhk8yTH2yfleiQF5D1fLLGP9VDmmfpnYxw/O0
         79vXDUB+adaMS5F9DtUUwxKAaBuPqLBilPlBWtzHxxVDrK2qDlcguF1gA2qCf4bFplG9
         UHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713828029; x=1714432829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eySiNMxkeecKkQ3TWHOIb0X8Y98LF76dHdRUPEkwUk=;
        b=U09afNevoIb6FALh5DbgQHucekdbUkJkfWGee2BfLumwx2zyqxQEj8IJxjf2KMjFuE
         HVYKA5nY1Lkfy5uC5SW8d0RACnt8agBSvugJ6j4Dm+OEw2TuajTaEZUZTIsXuLYIAtzy
         Bwm5I6v3nipQgEVgpbNqGsZZIkNNXvlW9uH+cQVnAKqH0VysWnr6Oyt+uiYGwQJMvT4E
         lXqamR6fHXdW6t+4/VL2JfMKKiZiP43lnpvLRQjx1I1zK4BbSMVPMozWc/u9KrLXe1r+
         EiXXlWe2HVtSfOIirSoeUMqfIOdRr27OosWtxWd3WSzC75UdYdZhXeObxaNP1P4sg/eR
         pXMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJyiKZze8OFEU/rEWRUPJghBR9s9JGW7hTxZ8tId+xo6nM2mL5WWUPm1slChZo7cDYuFvmEpnEkgW1Hw9mkpam/aQP
X-Gm-Message-State: AOJu0YzrAGLyNTL1ylqGoY47ik6IpM6rBffbmn7CCygpZ58cFZ1EcD5s
	+csmrtKC0IlKjUhRw/CgR6btyjMuLMBiyZAtP08F/cZWHnCoobi7lQhbCAB+zdtY2boJGUS76fG
	TcO++dSegzwo1l1muqG6DCmduyii1Smdf3uw=
X-Google-Smtp-Source: AGHT+IGWmxYREt9rL2SWgyI7NPDjxUaCb71FsHYRXLCSPel6xobItp8bvI/nZLdhRCXfKJgX51Tn0v/JMiT+K6N+pM4=
X-Received: by 2002:a05:6122:916:b0:4da:a9d8:f719 with SMTP id
 j22-20020a056122091600b004daa9d8f719mr12390704vka.4.1713828028879; Mon, 22
 Apr 2024 16:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421234336.542607-1-sidchintamaneni@vt.edu>
 <ZiYWKbDKp2zHBz6S@krava> <CAADnVQLn+zCAGCcFeE3wUfGULXBs3xii2shYTmS1BQMN5ZNYbQ@mail.gmail.com>
In-Reply-To: <CAADnVQLn+zCAGCcFeE3wUfGULXBs3xii2shYTmS1BQMN5ZNYbQ@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Mon, 22 Apr 2024 19:20:18 -0400
Message-ID: <CAE5sdEgMB=hGjsCfSFkdS-b_YJDErobu=r1-xKvMkqZqLuW8=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] Add notrace to queued_spin_lock_slowpath
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, miloc@vt.edu, rjsu26@vt.edu, sairoop@vt.edu, 
	Dan Williams <djwillia@vt.edu>, Siddharth Chintamaneni <sidchintamaneni@vt.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Apr 2024 at 13:13, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 22, 2024 at 12:47=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> >
> > On Sun, Apr 21, 2024 at 07:43:36PM -0400, Siddharth Chintamaneni wrote:
> > > This patch is to prevent deadlocks when multiple bpf
> > > programs are attached to queued_spin_locks functions. This issue is s=
imilar
> > > to what is already discussed[1] before with the spin_lock helpers.
> > >
> > > The addition of notrace macro to the queued_spin_locks
> > > has been discussed[2] when bpf_spin_locks are introduced.
> > >
> > > [1] https://lore.kernel.org/bpf/CAE5sdEigPnoGrzN8WU7Tx-h-iFuMZgW06qp0=
KHWtpvoXxf1OAQ@mail.gmail.com/#r
> > > [2] https://lore.kernel.org/all/20190117011629.efxp7abj4bpf5yco@ast-m=
bp/t/#maf05c4d71f935f3123013b7ed410e4f50e9da82c
> > >
> > > Fixes: d83525ca62cf ("bpf: introduce bpf_spin_lock")
> > > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
> > > ---
> > >  kernel/locking/qspinlock.c                    |  2 +-
> > >  .../bpf/prog_tests/tracing_failure.c          | 24 +++++++++++++++++=
++
> > >  .../selftests/bpf/progs/tracing_failure.c     |  6 +++++
> > >  3 files changed, 31 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> > > index ebe6b8ec7cb3..4d46538d8399 100644
> > > --- a/kernel/locking/qspinlock.c
> > > +++ b/kernel/locking/qspinlock.c
> > > @@ -313,7 +313,7 @@ static __always_inline u32  __pv_wait_head_or_loc=
k(struct qspinlock *lock,
> > >   * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  =
:
> > >   *   queue               :         ^--'                             =
:
> > >   */
> > > -void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u3=
2 val)
> > > +notrace void __lockfunc queued_spin_lock_slowpath(struct qspinlock *=
lock, u32 val)
> >
> > we did the same for bpf spin lock helpers, which is fine, but I wonder
> > removing queued_spin_lock_slowpath from traceable functions could break
> > some scripts (even though many probably use contention tracepoints..)
> >
> > maybe we could have a list of helpers/kfuncs that could call spin lock
> > and deny bpf program to load/attach to queued_spin_lock_slowpath
> > if it calls anything from that list
>
> We can filter out many such functions, but the possibility of deadlock
> will still exist.
> Adding notrace here won't help much,
> since there are tracepoints in there: trace_contention_begin/end
> which are quite useful and we should still allow bpf to use them.
> I think the only bullet proof way is to detect deadlocks at runtime.
> I'm working on such "try hard to spin_lock but abort if it deadlocks."

I agree with the point that notracing all the functions will not
resolve the issue. I could also find a scenario where BPF programs
will end up in a deadlock easily by using bpf_map_pop_elem and
bpf_map_push_elem helper functions called from two different BPF
programs accessing the same map. Here are some issues raised by syzbot
[2, 3].

 I also believe that a BPF program can end up in a deadlock scenario
without any assistance from the second BPF program, like described
above. The runtime solution sounds like a better fit to address this
problem, unless there is a BPF program that should definitely run for
the performance or security of the system (like an LSM hook or a
nested scheduling type program as mentioned here [1]).

In those cases, the user assumes that these BPF programs will always
trigger. So, to address these types of issues, we are currently
working on a helper's function callgraph based approach so that the
verifier gets the ability to make a decision during load time on
whether to load it or not, ensuring that if a BPF program is attached,
it will be triggered.

[1] https://lore.kernel.org/all/a15f6a20-c902-4057-a1a9-8259a225bb8b@linux.=
dev/
[2] https://lore.kernel.org/lkml/0000000000004aa700061379547e@google.com/
[3] https://lore.kernel.org/lkml/0000000000004c3fc90615f37756@google.com/

PS. We are following a similar approach to solve the stackoverflow
problem with nesting.

Thanks,
Siddharth

