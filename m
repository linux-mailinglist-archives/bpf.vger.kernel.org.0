Return-Path: <bpf+bounces-27718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A8D8B12C7
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 20:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D79D1C2505C
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 18:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7502619BDC;
	Wed, 24 Apr 2024 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmdBBBoT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF8118E11
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984366; cv=none; b=clV5eAowutj3ii4uHouVbybKkZVEqWVMQIzrdO7I9B8WHblIxXlyQT8uoybCW3VKX6ju57aYjTwIeWP5VsWT4/k8H7IbItqIlPnxAjX3SqnlruHp0+IzM24M84JXGuLQAaYw8p6k+G4vH4qWM7dsu+NU8aj1vAewxsFXiEVgti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984366; c=relaxed/simple;
	bh=7boAwtnlT7ZM/NcGwX9Pjk9o5krI+9LeFeo2LNJgCdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpLsk6cIBDW2DHQ18LPMCit2SYl/dfvYFGPciHfdPcG6tASuZ0mYRqmSxwAyRAsSMVFGIjnUg6GZJA+fnKRUW5GE5fIfzLBABjga7cMoIiGGKZW/aa1y1qbuDnf34+y3hQUIP/zxEbwcGDiKapy71EAaNOTO3ZzDtKXFLTEwMGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmdBBBoT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41aa15ae26dso1080305e9.3
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 11:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713984362; x=1714589162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7boAwtnlT7ZM/NcGwX9Pjk9o5krI+9LeFeo2LNJgCdo=;
        b=EmdBBBoTRXY0jtjJkyAH0Fv5g5c66lu9AeEL1EwJrxPB7lJlMCyEdoNaibkQDoSvDE
         kwUqUOrIJ9CjfdNdOkp+MPAVblA9FMgU4JuWKaDG6Pk2a0CgT88nMgejX1IaQk2x7akJ
         v05+VpmGydYvPNHW/Y3eJgG1cLpy/J5oyf7HfDy83vM40jnTvC1n+/7W+nbWMXfEaHy4
         XTnX/2WSyV6uySTW4mgKm2VlbEuXJRM5DN4Wdd8VUM4y81UssbS0Scr4k7EE3foJdM9m
         qNafzhSqE9a1OCQB5eQhrLjgYDFgSUUIF2oACj84cqblhMQ4dCHkuC8egj+jGJcMevyq
         QFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713984362; x=1714589162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7boAwtnlT7ZM/NcGwX9Pjk9o5krI+9LeFeo2LNJgCdo=;
        b=ih0UY+SPOC6BRzBg7hzIp94JCEBGe04cjEPYPKGlO+jgJBiHLJpur/aBsyl6ZHlcN6
         fHOIwuoE3Sdyue3eJuP6g+c9ChjQirB2SFOT3UQ2ur6wq11JNrHTxuj8fdLbGBjJFcts
         wfD+cxS1mrY3WLydXCxSsoC8co/UX/PZMaMIghxAVSdU+W9MNe+tysqIVM02Q30UPpm3
         J50yC0zQ3vZPlU9L+Jhk/se58XZeEbhq75uftTL1RiNF2JcI195Re5tLZK3MylEEw4gt
         2ymEEYubF8AfGuF/cZBoTi4PznaXXqq02QjepRjRfsaJuk7qukQfg04H5JI/cYVC4OlL
         2LPA==
X-Forwarded-Encrypted: i=1; AJvYcCVWRzTNe4tiwDKd/8WKUA0Qn/Zk0d09HssY5Gbho7VWg2yeBoOpa3s+ZHfjLf+noSMHTyh1VV7H6/1d+XstjtovSvJn
X-Gm-Message-State: AOJu0YyTZH+PdSlzVD2KAU5zZc7tIms+3wIALgfrdo0SxaaFeZpBn/kb
	ph44YZncQ2ZnHPU5TX0KQ8EV+ylUrET1SibMEXhS3MhJ8rqcXfpOTbuX8+u5KSeH9u+kS5jexU+
	YDYkO1eNmGGfG/Fw9JTZtSwD+Tes=
X-Google-Smtp-Source: AGHT+IF6oyVAl/JiRojRD/DtMp2qFHQ3L/APKprmojqiTQwxgw7wypSactyhX7v1ueJk88imFReNNpcLhUi/taphE+s=
X-Received: by 2002:a05:600c:45cc:b0:41a:a298:2369 with SMTP id
 s12-20020a05600c45cc00b0041aa2982369mr2332594wmo.11.1713984362541; Wed, 24
 Apr 2024 11:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421234336.542607-1-sidchintamaneni@vt.edu>
 <ZiYWKbDKp2zHBz6S@krava> <CAADnVQLn+zCAGCcFeE3wUfGULXBs3xii2shYTmS1BQMN5ZNYbQ@mail.gmail.com>
 <CAE5sdEgMB=hGjsCfSFkdS-b_YJDErobu=r1-xKvMkqZqLuW8=A@mail.gmail.com>
 <CAADnVQK+yZVcDTKNEKNdyJ9kaCHffcp9Wd0QLvipM9RykvByVw@mail.gmail.com> <CAE5sdEgcVssirq8GYPgEqdGiP7LMyo7JkU_YZsFbAwxb9tPhvA@mail.gmail.com>
In-Reply-To: <CAE5sdEgcVssirq8GYPgEqdGiP7LMyo7JkU_YZsFbAwxb9tPhvA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Apr 2024 11:45:51 -0700
Message-ID: <CAADnVQ+n18VzZb7rbd3vSaO-TA3KPLZRtcdpEMAGsXN3MCMhWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] Add notrace to queued_spin_lock_slowpath
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, miloc@vt.edu, rjsu26@vt.edu, sairoop@vt.edu, 
	Dan Williams <djwillia@vt.edu>, Siddharth Chintamaneni <sidchintamaneni@vt.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 4:58=E2=80=AFPM Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> > > I agree with the point that notracing all the functions will not
> > > resolve the issue. I could also find a scenario where BPF programs
> > > will end up in a deadlock easily by using bpf_map_pop_elem and
> > > bpf_map_push_elem helper functions called from two different BPF
> > > programs accessing the same map. Here are some issues raised by syzbo=
t
> > > [2, 3].
> >
> > ringbuf and stackqueue maps should probably be fixed now
> > similar to hashmap's __this_cpu_inc_return(*(htab->map_locked...)
> > approach.
> > Both ringbug and queue_stack can handle failure to lock.
> > That will address the issue spotted by these 2 syzbot reports.
> > Could you work on such patches?
>
> Just seen your latest patches related to this. Yes, I will work on the
> fixes and send the patches.

Great.

> > > In those cases, the user assumes that these BPF programs will always
> > > trigger. So, to address these types of issues, we are currently
> > > working on a helper's function callgraph based approach so that the
> > > verifier gets the ability to make a decision during load time on
> > > whether to load it or not, ensuring that if a BPF program is attached=
,
> > > it will be triggered.
> >
> > callgraph approach? Could you share more details?
>
> We are generating a call graph for all the helper functions (including
> the indirect call targets) and trying to filter out the functions and
> their callee's which take locks. So if any BPF program tries to attach
> to these lock-taking functions and contains these lock-taking
> functions inside the helper it is calling, we want to reject it at
> load time. This type of approach may lead to many false positives, but
> it will adhere to the principle that "If a BPF program is attached,
> then it should get triggered as expected without affecting the
> kernel." We are planning to work towards this solution and would love
> your feedback on it.

I can see how you can build a cfg across bpf progs and helpers/kfuncs
that they call, but not across arbitrary attach points in the kernel.
So attaching to qspinlock_slowpath or some tracepoint won't be
recognized in such callgraph. Or am I missing it?

In the past we floated an idea to dual compile the kernel.
Once for native and once for bpf isa, so that all of the kernel code
is analyzable. But there was no strong enough use case to do it.

> > Not following. The stack overflow issue is being fixed by not using
> > the kernel stack. So each bpf prog will consume a tiny bit of stack
> > to save frame pointer, return address, and callee regs.
>
> (IIRC), in the email chain, it is mentioned that BPF programs are
> going to use a new stack allocated from the heap. I think with a
> deeper call chain of fentry BPF programs, isn't it still a possibility
> to overflow the stack?

stack overflow is a possibility even without bpf. That's why the stack
is now virtually mapped with guard pages.

> Also, through our call graph analysis, we found
> that some helpers have really deeper call depths. If a BPF program is
> attached at the deepest point in the helper's call chain, isn't there
> still a possibility to overflow it? In LPC '23 [1], we presented a
> similar idea of stack switching to prevent the overflow in nesting and
> later realized that it may give you some extra space and the ability
> to nest more, but it is not entirely resolving the issue (tail calls
> will even worsen this issue).

The problem with any kind of stack switching is reliability of stack
traces. Kernel panics must be able to walk the stack. Even when
there are bugs. Full stack switch makes it risky.
Then livepatching depends on reliable stack walks.
That's another reason to avoid stack switch.

>
> [1] https://lpc.events/event/17/contributions/1595/attachments/1230/2506/=
LPC2023_slides.pdf

