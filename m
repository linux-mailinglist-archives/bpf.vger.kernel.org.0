Return-Path: <bpf+bounces-44135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A03099BF32A
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 17:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3199C1F21514
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 16:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E890204926;
	Wed,  6 Nov 2024 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcLEEX1U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A0B202F6C;
	Wed,  6 Nov 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730910340; cv=none; b=q0JqaiUCUXK1TtADQib+vGZiideCJVTCjxARX07PyPlnl12F/cjRH6uQF8Rg6By0M4XrDHKtdUepvuM1yTHfZ+OYM1ssGiLitQF5z6UM0hQSuVYoOTdwTAC1sTa4r6m6+E05HllE6R5SOLw8nopeRmBY+K1SiLoLvDswj8eQdAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730910340; c=relaxed/simple;
	bh=nTn7OyYR8+3QNfGTfcCXswxFf7/1Ob2OUBMC6woIoxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcRTn25qBUZRZ/1ME/h8U7CnVkyDx65FKlD2uYIjwVG5ojji/lth2GwdT/Sn1F8O9jH3B8omoOVRQ3dYE/wFh8A7O3bAyr+FgMTJORAip22J92+4ih5fsnKJIoR3SSWhObbmxBxdk2YL32hWo8Ka4Mi9TXx+f6LTKIi7+jeKAMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcLEEX1U; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7f3e30a43f1so19098a12.1;
        Wed, 06 Nov 2024 08:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730910338; x=1731515138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+0dv4IU+YC5q2KRQYq8uwpngy1gJkMWrxKCi3WhUWU=;
        b=hcLEEX1UggKoB8FmNqghQmTYLn/ADffiO25E1bEBTvu+fuhZ1+KvI8CmxeJWI6I1ri
         xzaeEF0/EVgVXx46fcs5YKeerfSrhNzww8KNu7hZXh0cP4J/MLjMeBi56Pd3WwsUt6rO
         0u+pz2DIA81on4G78ysbh+rLf8RP2yO1KOuJXvpyObKbp2ZoYjcXp8IsCgLT8ry1Niqc
         VcLQ9SS3mcanmsWaO2KZkRNJM8tFgESd90nYS3JpGDOzEnodhgDh1HhQse2e7SrgVnvB
         u7xqpheYk/OdbbKcP4ivmxlyR11hGsSRv6UzdFpwcQ48ZY8JRIVpTwaAp0I1daAht7NJ
         ChaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730910338; x=1731515138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+0dv4IU+YC5q2KRQYq8uwpngy1gJkMWrxKCi3WhUWU=;
        b=VJczpskhKIcC+MO/sVqsHH+WhKOyFNPNADgf/Ll1Jy276igThcK0YiqoGzmcuBddD0
         8TnjuDtM/btBISdQpeVzXq0+g30zseHZ5qJavR7d2res26Zp+7sdVwZnEZU6kawgNKo3
         BxV3u4c+mI9TbpH6j6F8zNNj+iIUnvW/omvJfJayyljdq6hNtWwZ4SYde7AsPNvVQA6U
         y43B0NFtl1BgCkWF16OnZtjclDkneOU6MI55jHr1CzQ5hkO47tiJ2OvOb38Qe5A8uji3
         5dWrEvkKZMeByyvCMKku5tqe5lK5uGUuXm9oM6nO4C11Ltv+NG157WJuj37LKrg0UHO/
         +20A==
X-Forwarded-Encrypted: i=1; AJvYcCWYHibFYzYhICRKpM/oPjOTl6VNkj5vJryIn3/vs6C/+T3E2yvHAnuu8Kj5bg+6TdtTgaf5dTiRIfv1/BkJVUXw7MQG@vger.kernel.org, AJvYcCWfWMCoRPGF5Fl2OX4IKERtCDxzLmx66BN+X9heJXGdZDvLuNPnsOg7QIpHEsAh1iMYB+4hytOs+9q9y3U9@vger.kernel.org, AJvYcCXdGVvt0LzSwdUVZjWIu9z6JII5IxfxBPtgLgbI2UvZr0eFVgtfBbGD8ti3gIAMga8F18I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSMo4+FkXE77fOvFkvHv70CfZeEffnve70+VLzyqk85jrjSw/j
	fgf+ztNFyZ8luhxsDhdmo60isJ+eWjK8cEdEIbn+6Ut9n1gyhL91YLRATy6TwV8YXsrd7tDNqzi
	2ZhPZ0AbDIObe2qqQI28z6Fq6n0A=
X-Google-Smtp-Source: AGHT+IEuC+sjDmRRM+7Ip58qlQhuXlW7P6FZrMFM5HQZMRFIR/40DNXrCLAlmXLitRtFdIMOx0fEHkj8wHjs3x34hLg=
X-Received: by 2002:a17:90b:2681:b0:2c8:647:1600 with SMTP id
 98e67ed59e1d1-2e94c2b082fmr27691282a91.9.1730910337781; Wed, 06 Nov 2024
 08:25:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903174603.3554182-1-andrii@kernel.org> <20240903174603.3554182-5-andrii@kernel.org>
 <20241106-transparent-athletic-ammonite-586af8@leitao>
In-Reply-To: <20241106-transparent-athletic-ammonite-586af8@leitao>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Nov 2024 08:25:25 -0800
Message-ID: <CAEf4Bza3+WYN8dstn1v99yeh+G0cjAeRQy8d5GAbvvecLmbO0A@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] uprobes: travers uprobe's consumer list locklessly
 under SRCU protection
To: Breno Leitao <leitao@debian.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 4:03=E2=80=AFAM Breno Leitao <leitao@debian.org> wro=
te:
>
> Hello Andrii,
>
> On Tue, Sep 03, 2024 at 10:45:59AM -0700, Andrii Nakryiko wrote:
> > uprobe->register_rwsem is one of a few big bottlenecks to scalability o=
f
> > uprobes, so we need to get rid of it to improve uprobe performance and
> > multi-CPU scalability.
> >
> > First, we turn uprobe's consumer list to a typical doubly-linked list
> > and utilize existing RCU-aware helpers for traversing such lists, as
> > well as adding and removing elements from it.
> >
> > For entry uprobes we already have SRCU protection active since before
> > uprobe lookup. For uretprobe we keep refcount, guaranteeing that uprobe
> > won't go away from under us, but we add SRCU protection around consumer
> > list traversal.
>
> I am seeing the following message in a kernel with RCU_PROVE_LOCKING:
>
>         kernel/events/uprobes.c:937 RCU-list traversed without holding th=
e required lock!!
>
> It seems the SRCU is not held, when coming from mmap_region ->
> uprobe_mmap. Here is the message I got in my debug kernel. (sorry for
> not decoding it, but, the stack trace is clear enough).
>
>          WARNING: suspicious RCU usage
>            6.12.0-rc5-kbuilder-01152-gc688a96c432e #26 Tainted: G        =
W   E    N
>            -----------------------------
>            kernel/events/uprobes.c:938 RCU-list traversed without holding=
 the required lock!!
>
> other info that might help us debug this:
>
> rcu_scheduler_active =3D 2, debug_locks =3D 1
>            3 locks held by env/441330:
>             #0: ffff00021c1bc508 (&mm->mmap_lock){++++}-{3:3}, at: vm_mma=
p_pgoff+0x84/0x1d0
>             #1: ffff800089f3ab48 (&uprobes_mmap_mutex[i]){+.+.}-{3:3}, at=
: uprobe_mmap+0x20c/0x548
>             #2: ffff0004e564c528 (&uprobe->consumer_rwsem){++++}-{3:3}, a=
t: filter_chain+0x30/0xe8
>
> stack backtrace:
>            CPU: 4 UID: 34133 PID: 441330 Comm: env Kdump: loaded Tainted:=
 G        W   E    N 6.12.0-rc5-kbuilder-01152-gc688a96c432e #26
>            Tainted: [W]=3DWARN, [E]=3DUNSIGNED_MODULE, [N]=3DTEST
>            Hardware name: Quanta S7GM 20S7GCU0010/S7G MB (CG1), BIOS 3D22=
 07/03/2024
>            Call trace:
>             dump_backtrace+0x10c/0x198
>             show_stack+0x24/0x38
>             __dump_stack+0x28/0x38
>             dump_stack_lvl+0x74/0xa8
>             dump_stack+0x18/0x28
>             lockdep_rcu_suspicious+0x178/0x2c8
>             filter_chain+0xdc/0xe8
>             uprobe_mmap+0x2e0/0x548
>             mmap_region+0x510/0x988
>             do_mmap+0x444/0x528
>             vm_mmap_pgoff+0xf8/0x1d0
>             ksys_mmap_pgoff+0x184/0x2d8
>
>
> That said, it seems we want to hold the SRCU, before reaching the
> filter_chain(). I hacked a bit, and adding the lock in uprobe_mmap()
> solves the problem, but, I might be missing something, since I am not fam=
iliar
> with this code.
>
> How does the following patch look like?
>
> commit 1bd7bcf03031ceca86fdddd8be2e5500497db29f
> Author: Breno Leitao <leitao@debian.org>
> Date:   Mon Nov 4 06:53:31 2024 -0800
>
>     uprobes: Get SRCU lock before traverseing the list
>
>     list_for_each_entry_srcu() is being called without holding the lock,
>     which causes LOCKDEP (when enabled with RCU_PROVING) to complain such
>     as:
>
>             kernel/events/uprobes.c:937 RCU-list traversed without holdin=
g the required lock!!
>
>     Get the SRCU uprobes_srcu lock before calling filter_chain(), which
>     needs to have the SRCU lock hold, since it is going to call
>     list_for_each_entry_srcu().
>
>     Signed-off-by: Breno Leitao <leitao@debian.org>
>     Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list lockles=
sly under SRCU protection")
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4b52cb2ae6d62..cc9d4ddeea9a6 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1391,6 +1391,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
>         struct list_head tmp_list;
>         struct uprobe *uprobe, *u;
>         struct inode *inode;
> +       int srcu_idx;
>
>         if (no_uprobe_events())
>                 return 0;
> @@ -1409,6 +1410,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
>
>         mutex_lock(uprobes_mmap_hash(inode));
>         build_probe_list(inode, vma, vma->vm_start, vma->vm_end, &tmp_lis=
t);
> +       srcu_idx =3D srcu_read_lock(&uprobes_srcu);

Hey Breno,

Thanks for catching that (production testing FTW, right?!).

But I think you a) adding wrong RCU protection flavor (it has to be
rcu_read_lock_trace()/rcu_read_unlock_trace(), see uprobe_apply() for
an example) and b) I think this is the wrong place to add it. We
should add it inside filter_chain(). filter_chain() is called from
three places, only one of which is already RCU protected (that's the
handler_chain() case). But there is also register_for_each_vma(),
which needs RCU protection as well.

So can you resend the patch as a stand-alone patch, switch to RCU
Tasks Trace flavor, and add the protection inside filter_chain()?
Thank you!

P.S. pending_list traversal that you (accidentally) protect as well in
your patch doesn't need RCU protection, so there is no problem with
moving into filter_chain() for RCU stuff.

>         /*
>          * We can race with uprobe_unregister(), this uprobe can be alrea=
dy
>          * removed. But in this case filter_chain() must return false, al=
l
> @@ -1422,6 +1424,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
>                 }
>                 put_uprobe(uprobe);
>         }
> +       srcu_read_unlock(&uprobes_srcu, srcu_idx);
>         mutex_unlock(uprobes_mmap_hash(inode));
>
>         return 0;
>

