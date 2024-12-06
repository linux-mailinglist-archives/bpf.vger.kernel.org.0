Return-Path: <bpf+bounces-46288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CD19E75B9
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 17:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E3D28BC45
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 16:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B93B206F1A;
	Fri,  6 Dec 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQDiG0VT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC487154BEA
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502031; cv=none; b=LNhgIhryO5PUL0CGcpmMj0YAlVqCWeTYH4BQ/5a9/NMbjDgGuTcDto1CFaL3JRJfDV5kf1F1T7f/o07tNHosdtDgKVHBCfwf7yxZ9sB0EwjqlfMR2l+uTHhdMcb5Cj7tVSK80y2w88aYD+d11I9RXISvpNM84mYmoQgCuPvtV+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502031; c=relaxed/simple;
	bh=m0BuUUIKMF7nrZqbezJTaOZWSA+T+WqhauG+PbXjneA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vF1EXGCs5kKV5/gmw0JgHHUHDGDJUl05sknVJkTSOdnb42IWAr6PQ/Tc4+UczaHiPj7LUAIe54g0EZTzJQCovtspxe9RP8cLq5rPCapygMnNZ6wxPVhBDzufmKdDTGnfuSUm30SL3HZBs2keLjFEgqCE7Bdg6CI4QnUFEt2dzI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQDiG0VT; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so998643f8f.2
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 08:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733502028; x=1734106828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0BuUUIKMF7nrZqbezJTaOZWSA+T+WqhauG+PbXjneA=;
        b=aQDiG0VTc3R0JTvKkTcnjIfYpJC6m21coduownBHTEXEIcVD6j0XcednFVMhfvnNrM
         r7WU8sORnP4yXscT0E8UYQkQDFAtpVsf/PeyBpLoRzSd+D2g57Cc23PvFxy6n7+2BQOl
         9UxTpaqo4QE3JBtNDQFn3wkXgpK9+LLFN+NyLcRqQgJmfTUTtUu4o/GL3cqC+Ozfp61K
         Txmqz5DJPhgkukR+KihZjamwgaGJXlbEhGeYDfzaEL9JXXQCx1Bu9ub4u0/8NourfWID
         WJLwMN25fV0hqzKNMx3do9NCNzgg5pHBU0scWOnMCE+N8Xkp+sQJz2LA0JugnhxcZX6+
         sTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733502028; x=1734106828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0BuUUIKMF7nrZqbezJTaOZWSA+T+WqhauG+PbXjneA=;
        b=Z82+16RlVeEWs/aBxLniPmOxWmL6EzYoppF9bJUy3izgRCNTzta7pIXc8m2/fzIsgx
         0SSt7KA2JQdlA5vCLuARRjgROJ7QZ0hyxJq94XLbnopqiQzWfVJAGc9KLX11shkfEIdt
         02I2CSWbVH+itDBvT+UvrvMS8+/td2yldQWyL2b5a7EgtmoE2i5hrsfXKgg8KOJodKjO
         PLViij3dejzHwZcEvVUFtBXSrMFsPGlWKREGEuqDhieQAGD/0dp6emy2+/GAgkE1cxiI
         1cwyZGJ7mxFOH0hybUTz6os3wD42L12hZDLn2aV4l9iOihynT6V6/CGwib/FzH03/Qbc
         07yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVojEFswsTbuwYJqQYqwRCQBXoN2AQ8TFm1sTlDPyjZYUhQfYgdDfzuj+8NkI5+5dOScdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr9mKdlRI6fNNU2MtUr8dndBzr+EL8y7KgmhQb7Zn9Ta89hWUq
	mF+rHdM3v6iKzeo0t8cBNoZRUjDd1oJnM4bC8PVuaI6Lnl7FPQa0SFYw9GuoLoj28bj/wIzg3U9
	fjwougM0WnJmryGKhc0QZjv6aB38=
X-Gm-Gg: ASbGncusAdDZVJoOhRQkZe4WOgemGQYAZLORSrpNxSQGhdsUGOv54J1o20SINhC3PFO
	hxRHI3Wj1euvbMP2aevD7Kso0Oo/HansWDv6VGy2j5jqS5oQ=
X-Google-Smtp-Source: AGHT+IGHhrenPLN3enuv5Z9kUrf3Anxygv1kfIHQwAIBwNZLT1hFLXh/vl7iyO9PlcpO/g+RbTTdwA1E3cSuKQAVCCM=
X-Received: by 2002:a5d:6d89:0:b0:386:62f:cf18 with SMTP id
 ffacd0b85a97d-3862b3e84b5mr2416077f8f.49.1733502028025; Fri, 06 Dec 2024
 08:20:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
 <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
 <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
 <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com>
 <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com>
 <CAADnVQJ7WuFge8YZ-g07VK6XhmMCf1RHa0B64O0_S4TLzu0yUg@mail.gmail.com> <CAEf4BzZPFy1XXf=2mXVpdVw70rJjgUfPnDOzWb5ZXrJF1=XqUA@mail.gmail.com>
In-Reply-To: <CAEf4BzZPFy1XXf=2mXVpdVw70rJjgUfPnDOzWb5ZXrJF1=XqUA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Dec 2024 08:20:17 -0800
Message-ID: <CAADnVQL-0SAvibeS45arBoZcwYjQjVnsrMeny=xzptOdUOwdjQ@mail.gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, andrii <andrii@kernel.org>, 
	Nick Zavaritsky <mejedi@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 8:13=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Dec 6, 2024 at 8:08=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Dec 5, 2024 at 10:23=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Dec 5, 2024 at 8:07=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > > >
> > > > On Thu, 2024-12-05 at 17:44 -0800, Alexei Starovoitov wrote:
> > > > > On Thu, Dec 5, 2024 at 4:29=E2=80=AFPM Eduard Zingerman <eddyz87@=
gmail.com> wrote:
> > > > > >
> > > > > > so I went ahead and the fix does look simple:
> > > > > > https://github.com/eddyz87/bpf/tree/skb-pull-data-global-func-b=
ug
> > > > >
> > > > > Looks simple enough to me.
> > > > > Ship it for bpf tree.
> > > > > If we can come up with something better we can do it later in bpf=
-next.
> > > > >
> > > > > I very much prefer to avoid complexity as much as possible.
> > > >
> > > > Sent the patch-set for "simple".
> > > > It is better then "dumb" by any metric anyways.
> > > > Will try what Andrii suggests, as allowing calling global sub-progr=
ams
> > > > from non-sleepable context sounds interesting.
> > > >
> > >
> > > I haven't looked at your patches yet, but keep in mind another gotcha
> > > with subprograms: they can be freplace'd by another BPF program
> > > (clearly freplace programs were a successful reduction of
> > > complexity... ;)
> > >
> > > What this means in practice is whatever deductions you get out of
> > > analyzing any specific original subprogram might be violated by
> > > freplace program if we don't enforce them during freplace attachment.
> > >
> > >
> > > Anyways, I came here to say that I think I have a much simpler
> > > solution that won't require big changes to the BPF verifier: tags. We
> > > can shift the burden to the user having to declare the intent upfront
> > > through subprog tags. And then, during verification of that global
> > > subprog, the verifier can enforce that only explicitly declared side
> > > effects can be enacted by the subprogram's code (taking into account
> > > lazy dead code detection logic).
> > >
> > > We already take advantage of declarative tags for global subprog args
> > > (__arg_trusted, etc), we can do the same for the function itself. We
> > > can have __subprog_invalidates_all_pkt_pointers tag (and yes, I do
> > > insist on this laconic name, of course), and during verification of
> > > subprogram we just make sure that subprog was annotated as such, if
> > > one of those fancy helpers is called directly in subprog itself or
> > > transitively through any of *actually* called subprogs.
> >
> > tags for args was an aid to the verifier. Nothing is broken without the=
m.
> > Here it's about correctness.
> > So we cannot use tags to solve this case.
>
> Hm.. Just like without an arg tag, verifier would conservatively
> assume that `struct task_struct *task` global subprog argument is just
> some opaque memory, not really a task, and would verify that argument
> and code working with it as such. If a user did something that
> required extra task_struct semantics, then that would be a
> verification error. Unless the user added __arg_trusted, of course.
>
> Same thing here. We *assume* that global subprog doesn't have this
> packet pointers side effect. If later during verification it turns out
> it does have this effect -- this is an error and subprog gets
> rejected. Unless the user provided
> __subprog_invalidates_all_pkt_pointers, of course. Same thing.

So depending on the order of walking the progs, compiler layout,
static vs global the extra tag is either mandatory or not.
That is horrible UX. I really don't like moving the burden to the user
when the verifier can see it all.
arg_ctx is different. The verifier just doesn't have the knowledge.

