Return-Path: <bpf+bounces-33808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4C19269BE
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 22:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283541F22A59
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 20:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9727019146E;
	Wed,  3 Jul 2024 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3P5r2kV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EEB183077;
	Wed,  3 Jul 2024 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040136; cv=none; b=MZHn0iefixhy4yQTi7yUk38VkKPETvYH7nh7v+zNXp3VDL3yeuOGzdp34n/+/4HXKENVBuUlhSkVlnJ7kC6kRCnec85ft1VrdZeFkLCiZ/65ErYO6CL2SguXADyEYCztQ1matz4PUTveSwmp7ltSFqAGFusXpXWfeC+7e/8/mIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040136; c=relaxed/simple;
	bh=eTvduNlpLOomYT36PTXnbHDb7w7kaGKwEbeQU5dsugE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duPvEpvlNSHy4V0wcQAsAm03c8/xNS5tavPWI8nJktCTVRbCmoV0UxFOlTfwzwY79wsT17ZKm1vR8o+az3pzuNhMNuYn/eBMerRYsEj7r8CwOLXh0k6DKLVB7ujM7AMwLMglgEOTSoQgqeVGJvTKJWJTDtR92/BQLxLbDrxG3gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3P5r2kV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70aaab1cb72so3923b3a.0;
        Wed, 03 Jul 2024 13:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720040134; x=1720644934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgwHTDQRiaUsgopB9FLptWkMjA1g7tpQpUPHiuaXo/4=;
        b=d3P5r2kVlU4GfrOHP7nAyg5buu/Q9q8rm79VEZfGvZK3G02c92801tdSoYAd7+WTrs
         tPMKold1sFrXR22nmDbw3dkwJOq6kvYXKlr93NSJEsSBhWOpsVzp9VBnqPXvYraxqhuN
         mZfmqY0YwhvqkPUWc4BLE/OxhtakE6y6UVWpwQ7Q+6eKixYzpbc8HBa9RgJnXVshndgV
         582led9rf6z3+A0kzbwnLYeH2aJRgVkf4ULFhLhKqBg9wcIw00eDAFuva9i1DHqXozzX
         6UPcykZzWY0D84ijXST7b+5SeQZV9vR+TtzxOd8ZCba+gAfAEARq1DxZQVuKueKG2zVK
         OHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720040134; x=1720644934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgwHTDQRiaUsgopB9FLptWkMjA1g7tpQpUPHiuaXo/4=;
        b=EJRiHuvGJHm7dP0ueOMJGSoAVV+zpJAcne+f6goMN5rjdIuu22ILLM66v+flXBS40L
         zhDVZpmzjZzgBskQPBJKb3NlyflJAngjqvwl+6iq9Wo2RvHPG43wXEZZRJyFMMCiPXza
         HzjToi0ikUwGCGo0yhcPKUy0YPqWSmDIpzjRMYs1MtBce4DUD2+ydSnXQYVaNWvhcdS4
         Di95wIhbVgGsCJzSRT6DP6F8bCsRKUqx59gKeIVMh9XEj9N7Ksxjltg9/2kQClNY5RIH
         2Ofun6laDc5UsTm4e8bzI6RumSCK3ogASPia+GdS/RpaTNtFKOlARuCBSaLL5Jowcra1
         PS3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNes7VR/xuwacul/0m1U1LRlS4DzaqhVsThqbL5kQUOI9AszSA/YTWXtwpEUtG+MN7xLX3RDjN2PEZ0K3xYegZCWad1RggM7hTRL6LDtdwReBGi1m01YPF5sZjEjQAJzJE/mvWRmYKl3n2eEROZPxIQw+3FLrTMuoEn+vnnHZQkqn+odkq
X-Gm-Message-State: AOJu0Yz49kNMahEQvGsThS9OFVtzyF3UReTcczxG87d8nilnw6NjRIng
	+0KWotoN8hPz5FCSXutD/Bj4jLmPTMWP4GWOQ1HdmuHfKovutLkFzC+F5TYG1CwmC+2KD0EZj9f
	QjA87Dn1k30hcUKucR68ujXXedh0=
X-Google-Smtp-Source: AGHT+IEvnmcwUpnPpc1RXTcC+b84+eF3E0aNNoT3FnBhasKPXec+DrnimCBRAo2ud7BcXhGK2b3dJoI+WmRbVDkkfqY=
X-Received: by 2002:a05:6a00:ccf:b0:705:de1d:f7f9 with SMTP id
 d2e1a72fcca58-70aaac1ee08mr19029918b3a.0.1720040133887; Wed, 03 Jul 2024
 13:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701223935.3783951-1-andrii@kernel.org> <20240702102353.GG11386@noisy.programming.kicks-ass.net>
 <20240702115447.GA28838@noisy.programming.kicks-ass.net> <CAEf4BzaQUzQdba2=F2NoV7=Th98fxz2EN62QX2Ej92bazt1GAg@mail.gmail.com>
 <20240702191857.GJ11386@noisy.programming.kicks-ass.net> <CAEf4BzZuEicv3DkYA8HYG10QnBURK4SFddhTbA06=eOKQr82PA@mail.gmail.com>
 <20240703080736.GL11386@noisy.programming.kicks-ass.net>
In-Reply-To: <20240703080736.GL11386@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jul 2024 13:55:21 -0700
Message-ID: <CAEf4BzYbkXHw-wZ=+0pCnGFVD-zuuhC-b=5Uz+w9F_RuPEFMOw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	oleg@redhat.com, mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org, 
	clm@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 1:07=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Tue, Jul 02, 2024 at 09:47:41PM -0700, Andrii Nakryiko wrote:
>
> > > As you noted, that percpu-rwsem write side is quite insane. And you'r=
e
> > > creating this batch complexity to mitigate that.
> >
> >
> > Note that batch API is needed regardless of percpu RW semaphore or
> > not. As I mentioned, once uprobes_treelock is mitigated one way or the
> > other, the next one is uprobe->register_rwsem. For scalability, we
> > need to get rid of it and preferably not add any locking at all. So
> > tentatively I'd like to have lockless RCU-protected iteration over
> > uprobe->consumers list and call consumer->handler(). This means that
> > on uprobes_unregister we'd need synchronize_rcu (for whatever RCU
> > flavor we end up using), to ensure that we don't free uprobe_consumer
> > memory from under handle_swbp() while it is actually triggering
> > consumers.
> >
> > So, without batched unregistration we'll be back to the same problem
> > I'm solving here: doing synchronize_rcu() for each attached uprobe one
> > by one is prohibitively slow. We went through this exercise with
> > ftrace/kprobes already and fixed it with batched APIs. Doing that for
> > uprobes seems unavoidable as well.
>
> I'm not immediately seeing how you need that terrible refcount stuff for

Which part is terrible, please be more specific. I can switch to
refcount_inc_not_zero() and leave performance improvement on the
table, but why is that a good idea?

> the batching though. If all you need is group a few unregisters together
> in order to share a sync_rcu() that seems way overkill.
>
> You seem to have muddled the order of things, which makes the actual
> reason for doing things utterly unclear.

See -EGAIN handling in uprobe_register() code in current upstream
kernel. We manage to allocate and insert (or update existing) uprobe
in uprobes_tree. And then when we try to register we can post factum
detect that uprobe was removed from RB tree from under us. And we have
to go on a retry, allocating/inserting/updating it again.

This is quite problematic for batched API, in which I split the whole
attachment into few independent phase:

  - preallocate uprobe instances (for all consumers/uprobes)
  - insert them or reuse pre-existing ones (again, for all consumers
in one batch, protected by single writer lock on uprobes_treelock);
  - then register/apply for each VMA (you get it, for all consumers in one =
go).

Having this retry for some of uprobes because of this race is hugely
problematic, so I wanted to make it cleaner and simpler: once you
manage to insert/reuse uprobe, it's not going away from under me.
Which is why the change to refcounting schema.

And I think it's a major improvement. We can argue about
refcount_inc_not_zero vs this custom refcounting schema, but I think
the change should be made.

Now, imagine I also did all the seqcount and RCU stuff across entire
uprobe functionality. Wouldn't that be mind bending a little bit to
wrap your head around this?

