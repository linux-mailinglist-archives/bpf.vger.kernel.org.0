Return-Path: <bpf+bounces-39398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CDA972759
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 04:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287432858F4
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 02:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05B914EC58;
	Tue, 10 Sep 2024 02:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxMb8dV9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EAD13B28D;
	Tue, 10 Sep 2024 02:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725936728; cv=none; b=hv4jT7b68Cu0IFgouFXWAj3WGXGr5DomskXJUHFd9hE8AFtysPwl9vtQ2YzzYrfWnY0nTe9lbJiD5UaYm30ACbpL36nQvZoVKkSbdpmvAVmk/BY2lNMbw0VjeD0b/va1XRw1DMMJWGXYJ2OjlZ3ZPWNezy2OuyHuHJdhdxPk+Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725936728; c=relaxed/simple;
	bh=WpMA1kEs9Y7I7e4gxgXkW3C671npPx44YdItCYUBqJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6ReZYDC14cbZDClGyRJrnubSvTZASLVcKwB9+7KhJQl23vdMxJ5qPeDkTrEcZm3Fy3bXF6E0EugvcXmYwnVwTL7kCdVLW+w1MSI7XEbPYydbRW3gKrbMNp0ROODO8md8GDxa7DCjeUVHm8nH12qHhqHkpxyTtYnCHgK5lGK9tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxMb8dV9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374c4d4f219so135856f8f.1;
        Mon, 09 Sep 2024 19:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725936725; x=1726541525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQttAVB45yzTKj++0cYWkihAYzlOnNEiTmI1J5Prwyg=;
        b=mxMb8dV9oRH1Ex8ix81NRV8dorTy5q++qsAy6xIsnn2VK7N1lXj7dijK9LeFZTQbuI
         1skGncGteRDBk+h+JbcOEtUi6YbmmI+c+bKcHwYfDfrTfnu13GqbI6hdxcgnLrfgo81o
         AaF0zZFyNBw00gtLzHEJk7bRTe6E27NHf3yrDuuk31VsS3XGENsoUqP3311IlPxr8v3q
         bst/gxbexgFcIbk+Dtb+n7I6Yk6QiPtcvey3a3sLR4yGrM1T3KzlQWAesu8JX6BNQzbN
         idEa83OLv1lG7z41SVgsvKkos4i8ufG42/Ni111kKDgompv80tud0uDx/8s51UCz2Ywm
         D5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725936725; x=1726541525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQttAVB45yzTKj++0cYWkihAYzlOnNEiTmI1J5Prwyg=;
        b=Sby+iZ+fPplgX9SsyFVcJs6eG1mPeROi0FtRo303kqlucetyV1yZvsyFqUZNwZ/3TS
         L592nAaH9lZBoer6wVESEr5PG0p0nVFLMAIshLOpKPf3ADldisn6Jpxfril2L2V3eoOa
         JCx8ze6fEXZ+8rVDuSScpdY9+U1+jhA51A2E35ED1/nB8+hh0fDefVs8ZeVD7F7Y3+hA
         cHsVK9y77X06RuzZ8g7dD8q85OkZK4f07Omybm9A9axYCHPTYqR/bFGDK0/czHcHTEQG
         LAxw54KyGMSWPnaz5oZDNTTB2pw+OeyLsR7jareHHCtCTC2B/6+YR+BQKbAzZZcHIQoC
         9kJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5juLvRE9DALUoWH7/AdTFBuQ7oekzAVe0nR44knMqYOI5CFY9OcxxK2nNNr0Vx57LDUdjW88qwJMqJxjH@vger.kernel.org, AJvYcCXOZUIvsg5WUmg/A77PmmbVEKmzaoFxoi/rDLgdcAVu7dt44ibn2KDTBBYp15fkzixJ5OY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2mz0ZnQTFD8teK1BjxMZOjz70Z1MCoM7HGBLTVQ4efj4jBVLV
	tZmrO7YV/qldZ+lF53f+CxuuYg/FRTHClnpaV1tccjCqzljQPtUBkQWXmXZhHaecTzHOnLWJzz5
	G0ISyx4RKwKNlh5M0OkoQzbOgGOw=
X-Google-Smtp-Source: AGHT+IEPh9ScgrXAKldrieTgqRzsP4QbioBjV/CKb84XXP+ccZWvtBKZhTSspJrQZLTBQWY5KwWzVjo4FgDdHs6ZTf4=
X-Received: by 2002:adf:f792:0:b0:378:7de9:3716 with SMTP id
 ffacd0b85a97d-378895c4aa9mr7523902f8f.8.1725936724600; Mon, 09 Sep 2024
 19:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909224903.3498207-1-andrii@kernel.org> <20240909224903.3498207-2-andrii@kernel.org>
In-Reply-To: <20240909224903.3498207-2-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Sep 2024 19:51:53 -0700
Message-ID: <CAADnVQLB2b5Uh-qthnCOfJk+v+ty1nQh6LjMDkzjt1BPtGOVZA@mail.gmail.com>
Subject: Re: [PATCH 1/3] uprobes: allow put_uprobe() from non-sleepable
 softirq context
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 3:49=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Currently put_uprobe() might trigger mutex_lock()/mutex_unlock(), which
> makes it unsuitable to be called from more restricted context like softir=
q.
>
> Let's make put_uprobe() agnostic to the context in which it is called,
> and use work queue to defer the mutex-protected clean up steps.
>
> To avoid unnecessarily increasing the size of struct uprobe, we colocate
> work_struct in parallel with rb_node and rcu, both of which are unused
> by the time we get to schedule clean up work.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/events/uprobes.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index a2e6a57f79f2..377bd524bc8b 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -27,6 +27,7 @@
>  #include <linux/shmem_fs.h>
>  #include <linux/khugepaged.h>
>  #include <linux/rcupdate_trace.h>
> +#include <linux/workqueue.h>
>
>  #include <linux/uprobes.h>
>
> @@ -54,14 +55,20 @@ DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
>  #define UPROBE_COPY_INSN       0
>
>  struct uprobe {
> -       struct rb_node          rb_node;        /* node in the rb tree */
> +       union {
> +               struct {
> +                       struct rb_node          rb_node;        /* node i=
n the rb tree */
> +                       struct rcu_head         rcu;
> +               };
> +               /* work is used only during freeing, rcu and rb_node are =
unused at that point */
> +               struct work_struct work;
> +       };
>         refcount_t              ref;
>         struct rw_semaphore     register_rwsem;
>         struct rw_semaphore     consumer_rwsem;
>         struct list_head        pending_list;
>         struct list_head        consumers;
>         struct inode            *inode;         /* Also hold a ref to ino=
de */
> -       struct rcu_head         rcu;
>         loff_t                  offset;
>         loff_t                  ref_ctr_offset;
>         unsigned long           flags;
> @@ -620,11 +627,28 @@ static inline bool uprobe_is_active(struct uprobe *=
uprobe)
>         return !RB_EMPTY_NODE(&uprobe->rb_node);
>  }
>
> +static void uprobe_free_deferred(struct work_struct *work)
> +{
> +       struct uprobe *uprobe =3D container_of(work, struct uprobe, work)=
;
> +
> +       /*
> +        * If application munmap(exec_vma) before uprobe_unregister()
> +        * gets called, we don't get a chance to remove uprobe from
> +        * delayed_uprobe_list from remove_breakpoint(). Do it here.
> +        */
> +       mutex_lock(&delayed_uprobe_lock);
> +       delayed_uprobe_remove(uprobe, NULL);
> +       mutex_unlock(&delayed_uprobe_lock);
> +
> +       kfree(uprobe);
> +}
> +
>  static void uprobe_free_rcu(struct rcu_head *rcu)
>  {
>         struct uprobe *uprobe =3D container_of(rcu, struct uprobe, rcu);
>
> -       kfree(uprobe);
> +       INIT_WORK(&uprobe->work, uprobe_free_deferred);
> +       schedule_work(&uprobe->work);
>  }
>
>  static void put_uprobe(struct uprobe *uprobe)

It seems put_uprobe hunk was lost, since the patch is not doing
what commit log describes.

