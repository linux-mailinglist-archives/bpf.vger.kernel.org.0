Return-Path: <bpf+bounces-27447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE058AD32A
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 19:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AA7CB221DB
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 17:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350C3153BDF;
	Mon, 22 Apr 2024 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZOHWWUi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F4D2EB11
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713806004; cv=none; b=oXGhzm01MS4Q4CcuewnOYud4GEGmXi+f8hciALn+vGFaanb4bXKbm0Jc8/KeR3pCVNW19GjTml7T4S4mJaIRPK5KgNtkCURvQl9e4O+lAEPilPF81I4rLn2vozBdzAx0/UqoaPgSErkMeg+0emMTKbm5Jdsav7VV7WGu6SiF22k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713806004; c=relaxed/simple;
	bh=yQ8WsS6WmOJlpsUrofBoR69H9anrZtUGcZfvetoRA7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9o2b2wpNC5RlyvzCnJgu1Fb3i07aib+5Et4KkYrFwNozwb+SYt+0gxLi6cPm0a+i1KRXqPKVXDnrkjZGdAcIvRL/ur5j6Y3EVUE9MXWECVPPim3XE4PsMtzjQogdIfHNXoloIQOAqqylcUxLKzmpCm6AnfbT6PGcu5CTPYmU74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZOHWWUi; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34a7e47d164so2606568f8f.3
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713806001; x=1714410801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSa+TwAE5uh2NNMy+B7XnS273gY/2sYt0XFoE+HwQ9c=;
        b=NZOHWWUi49BO01lDcbD5tLGAkLv52ENLKpZQIaCzj7olVYcene+QA9U+7UQXTihD6E
         +Rz+6+wAq/oSCgkJEvUfYLu/+yH7isK9AivjwaGZ9Qo0ZEqDh0e0ySxagfqe+oZcuQGR
         HQ0Yc3Q48mmtm6JEwjF33TIDTy8tT3WGZ5BqdV+LaWhsm0AzUjRcXeFwN4u/lxIfssX4
         exCEjk+BPJrOmgadOsdZoA1SooMoQ7W1j+jx/CrcCr2uMCsjOhZrkO5DkYhmOROcSEmJ
         FQKxSZpVO+xeFcH9ZGUhjQZhhSLTG2psdVjrBuROtbf+ZzqJuaFX6XpZxTQBWpG8t9pe
         kbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713806001; x=1714410801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSa+TwAE5uh2NNMy+B7XnS273gY/2sYt0XFoE+HwQ9c=;
        b=HDW+xlxJTdC/U/qu8ojJidX24lRloXpW1FGruzVP1WNmbk86Nwr6DmWrtfB+INBGkU
         XssjJPsTIzxPT0uIfURdwnOWfNqxkaiq1kxP7jVNJPGTBeZx4+CFu/cswUDww1VZYEQv
         46324IE3NYJ1yicxVM9PzWOn6v01IxAK6PGpOltKe6YQHmI0LzZQii7mC9hYjxScPpUq
         GN/+k7TZ3aQCT8vZOeqR0ytqRB96J+Vi+Wq/qs+l1pqoWFSGBEWQq6RtmnW9TE+xUJuW
         MExsUXjDnxz173wS0w7hd2T9E1EIxpfnDM8+41c2FCC85nW56Csj7I9zbQeEqizvmYth
         G2JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDpNxAlwKnOsUc+4kdqLDoQx1CXFdG7BnJ4bNIhZRyMumzUamuFwIijRRd3G0ycFP8CP5YrY+a+/MH3JWL3eJJJwxG
X-Gm-Message-State: AOJu0Yw4ICGl+fZYO39vzEZLFA9vJpJKrwP81/n7l4vAqXgd0zCG6n5/
	DTQphuUUXYTsh/yePdwC4mIWhFYKk0zM3xzEQRSZsHjy10EDJumMEXd0HvPCAJhZlXbCjX5vbi9
	UdkNKLnaMjM3zPZ+API+9e5UDedE=
X-Google-Smtp-Source: AGHT+IHd3WEc7RzE21Jp+ILSN0rDmc/1adCXGv4zqmFIklJu/OGTZCxsLPJ1nC/dZHqtAFRrYmaZ/Whq8+RGNDVz5oU=
X-Received: by 2002:a5d:604d:0:b0:346:b452:1740 with SMTP id
 j13-20020a5d604d000000b00346b4521740mr8367920wrt.3.1713806001225; Mon, 22 Apr
 2024 10:13:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421234336.542607-1-sidchintamaneni@vt.edu> <ZiYWKbDKp2zHBz6S@krava>
In-Reply-To: <ZiYWKbDKp2zHBz6S@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Apr 2024 10:13:09 -0700
Message-ID: <CAADnVQLn+zCAGCcFeE3wUfGULXBs3xii2shYTmS1BQMN5ZNYbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] Add notrace to queued_spin_lock_slowpath
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, miloc@vt.edu, rjsu26@vt.edu, sairoop@vt.edu, 
	Dan Williams <djwillia@vt.edu>, Siddharth Chintamaneni <sidchintamaneni@vt.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 12:47=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Sun, Apr 21, 2024 at 07:43:36PM -0400, Siddharth Chintamaneni wrote:
> > This patch is to prevent deadlocks when multiple bpf
> > programs are attached to queued_spin_locks functions. This issue is sim=
ilar
> > to what is already discussed[1] before with the spin_lock helpers.
> >
> > The addition of notrace macro to the queued_spin_locks
> > has been discussed[2] when bpf_spin_locks are introduced.
> >
> > [1] https://lore.kernel.org/bpf/CAE5sdEigPnoGrzN8WU7Tx-h-iFuMZgW06qp0KH=
WtpvoXxf1OAQ@mail.gmail.com/#r
> > [2] https://lore.kernel.org/all/20190117011629.efxp7abj4bpf5yco@ast-mbp=
/t/#maf05c4d71f935f3123013b7ed410e4f50e9da82c
> >
> > Fixes: d83525ca62cf ("bpf: introduce bpf_spin_lock")
> > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
> > ---
> >  kernel/locking/qspinlock.c                    |  2 +-
> >  .../bpf/prog_tests/tracing_failure.c          | 24 +++++++++++++++++++
> >  .../selftests/bpf/progs/tracing_failure.c     |  6 +++++
> >  3 files changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> > index ebe6b8ec7cb3..4d46538d8399 100644
> > --- a/kernel/locking/qspinlock.c
> > +++ b/kernel/locking/qspinlock.c
> > @@ -313,7 +313,7 @@ static __always_inline u32  __pv_wait_head_or_lock(=
struct qspinlock *lock,
> >   * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
> >   *   queue               :         ^--'                             :
> >   */
> > -void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 =
val)
> > +notrace void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lo=
ck, u32 val)
>
> we did the same for bpf spin lock helpers, which is fine, but I wonder
> removing queued_spin_lock_slowpath from traceable functions could break
> some scripts (even though many probably use contention tracepoints..)
>
> maybe we could have a list of helpers/kfuncs that could call spin lock
> and deny bpf program to load/attach to queued_spin_lock_slowpath
> if it calls anything from that list

We can filter out many such functions, but the possibility of deadlock
will still exist.
Adding notrace here won't help much,
since there are tracepoints in there: trace_contention_begin/end
which are quite useful and we should still allow bpf to use them.
I think the only bullet proof way is to detect deadlocks at runtime.
I'm working on such "try hard to spin_lock but abort if it deadlocks."

