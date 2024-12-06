Return-Path: <bpf+bounces-46299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 601E29E77C5
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078231886DC4
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8852A1FD7B1;
	Fri,  6 Dec 2024 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TveFug1/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DF62206A5;
	Fri,  6 Dec 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733508031; cv=none; b=KEwNXUSb5gxnISRuSNIxbTWDCTp1kbLkXA5uaT8qaWKfwyBFQh/CA0Ul2v7nL9s6K4wjFudOPhKSRWR3yyH7kg2lLM7cBNf2tykfnHTwjaHxfLDoq3vaFYPgqKP703QMks6UtpyA3CxwdbIvjStD1cvRJ2JmPzFvb7fltcDnUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733508031; c=relaxed/simple;
	bh=H8+ijCMiA6ukFvtvHgi/sIc/1ThgkN6eZOLvjTyrHao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eExobWL5w5ohCPgvsZCo2+6RY7I5ZlsThmskO5i6BhfTh1Tkc9+cOGgt2ao+FPjx3BQm/ElIcEJlqiTwTpTHY0pNw+rFk2z+RtB1hILiBihXeE7YGRkZFQy/TSYlh5kPzr2sbG3Ozz5/e4W9cxkVG8BYVDYmvgdpx7hdC+9wk8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TveFug1/; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ef6c56032eso846175a91.2;
        Fri, 06 Dec 2024 10:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733508029; x=1734112829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34RpqiH9mb1FjMoXjg/XFvDnF3uQltArdmOLNrd2+ic=;
        b=TveFug1/KLRCFee/7Jl8qNP2dXRD3IZiudPRz9OwvHkgDp6eANBqp1wwy3ZcsvI6c3
         cR+BLDdAjtFlNsPp/Zu9FNEjLYQCxRdnOt0fyMpYQ1FRZN03PlDeALwbLna7rPOVhhW5
         vgOV0wsttPPal/3acF89kDG5NqItTnTpgOo0lcxaNfvqaEtlIzZzcY61UZRSZy1ZGZB0
         lB/1p4bUoPjQVPdYSqEl+r22IIfQmBecDPjku7fqU3eZtPxdnkx2c75D5R1fBggA4n9a
         5nK5xxcjfS9YSIq0PgwQjdNbj3mijpBlNr84RjQLWoPxowrarfu7GuI40TY61qktk40f
         cToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733508029; x=1734112829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34RpqiH9mb1FjMoXjg/XFvDnF3uQltArdmOLNrd2+ic=;
        b=VajDTg681XMf9hQyerteA0qaBPnbZCNMQ8OhqBup7ILuawhpiHkRddxZBFDQzRQzKE
         Cju/Jq1SvXYFxq/e6r/d/p3W7WLQY4yGikhzTwizR4QUZNmqOhohJ1G8JscwjI1tGCfo
         54QK8sTqzNfJXNoRG3kuVBQ9JgZwxCpNnOcHZRIT3Iq9FJdfVLg0WIp0tQCRDaMiXQFA
         KaRgl93qfpnWX12qs/JYrTHT2TWg0vN5YVEVatGvxWl8AFMP0GkbYU+UxqTyMleQ7OTf
         j8RTxmQmR6u8s8EFJiUQMv+onzbsq4fLILjTCm9qWfJId3iBPmpa4xOM1u5H2LLl5w8E
         k7kw==
X-Forwarded-Encrypted: i=1; AJvYcCUlfgUq5bGpXu08gpn341iO0PQlh2BUg2oH6YiuG2hv3zyKECokzBrNg1dM7r0UAONgq2zt5rzDK8o+x5p1@vger.kernel.org, AJvYcCW5mT9N0jE887QXxinDjMl5xQwB1MjcK5J4L2R2GolHY4/z/JTIpQPZ3RbKM8D1GdY3ilw=@vger.kernel.org, AJvYcCXwr3qrjqIHdc6YeYKdpUcVkLF4PW70jp2Ju5sMatrDqfVwRlUpD/tFaopWlYx1rlwklKK4BfouDf7fteYtev8p1EyD@vger.kernel.org
X-Gm-Message-State: AOJu0YyROJ1zekL9r4zsG+7ybejfVEUMZEj8UrZKDQoSgQQnDaVFJtya
	flZTIfb/HmGd2i34sZZrqQnu+P2q92b3U+/60+zFlk+OviSjeYR1rouTGtMWlsjGzPy6IT4lMGF
	K4K6dJDt9sr9JhlwTNwE6rG478AU=
X-Gm-Gg: ASbGncsl0Kis83BuStPeoXWoPCaj2mUeVXD4w1PgUrVk36v0qgFJv8RThmPiLbVoUhA
	eVg2tfXa/ZU2lEsca8AXQeoKFa9dA8+ydyxCWIZAyOAH755E=
X-Google-Smtp-Source: AGHT+IHCNWhxq7so09pbzCCKHYLOVnFH/73MSxeGbWicpEb+f1NdFQzOJpUKEvhEDi5mDeEJAuKV7y0BazV2xTlwol0=
X-Received: by 2002:a17:90b:3dcb:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-2ef6965464amr5173915a91.6.1733508028565; Fri, 06 Dec 2024
 10:00:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206002417.3295533-1-andrii@kernel.org> <20241206002417.3295533-5-andrii@kernel.org>
 <Z1MFBVRuUnuYKo8c@krava>
In-Reply-To: <Z1MFBVRuUnuYKo8c@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Dec 2024 10:00:16 -0800
Message-ID: <CAEf4BzaESrHfAXZrN0VbjQvxLJ0ij0ujKpsp2T6iQtbisYPa=A@mail.gmail.com>
Subject: Re: [PATCH perf/core 4/4] uprobes: reuse return_instances between
 multiple uretprobes within task
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@kernel.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liaochang1@huawei.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 6:07=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Thu, Dec 05, 2024 at 04:24:17PM -0800, Andrii Nakryiko wrote:
>
> SNIP
>
> > +static void free_ret_instance(struct uprobe_task *utask,
> > +                           struct return_instance *ri, bool cleanup_hp=
robe)
> > +{
> > +     unsigned seq;
> > +
> >       if (cleanup_hprobe) {
> >               enum hprobe_state hstate;
> >
> > @@ -1897,8 +1923,22 @@ static void free_ret_instance(struct return_inst=
ance *ri, bool cleanup_hprobe)
> >               hprobe_finalize(&ri->hprobe, hstate);
> >       }
> >
> > -     kfree(ri->extra_consumers);
> > -     kfree_rcu(ri, rcu);
> > +     /*
> > +      * At this point return_instance is unlinked from utask's
> > +      * return_instances list and this has become visible to ri_timer(=
).
> > +      * If seqcount now indicates that ri_timer's return instance
> > +      * processing loop isn't active, we can return ri into the pool o=
f
> > +      * to-be-reused return instances for future uretprobes. If ri_tim=
er()
> > +      * happens to be running right now, though, we fallback to safety=
 and
> > +      * just perform RCU-delated freeing of ri.
> > +      */
> > +     if (raw_seqcount_try_begin(&utask->ri_seqcount, seq)) {
> > +             /* immediate reuse of ri without RCU GP is OK */
> > +             ri_pool_push(utask, ri);
>
> should the push be limitted somehow? I wonder you could make uprobes/cons=
umers
> setup that would allocate/push many of ri instances that would not be fre=
ed
> until the process exits?

So I'm just relying on the existing MAX_URETPROBE_DEPTH limit that is
enforced by prepare_uretprobe anyways. But yes, we can have up to 64
instances in ri_pool.

I did consider cleaning this up from ri_timer() (that would be a nice
properly, because ri_timer fires after 100ms of inactivity), and my
initial version did use lockless llist for that, but there is a bit of
a problem: llist doesn't support popping single iter from the list
(you can only atomically take *all* of the items) in lockless way. So
my implementation had to swap the entire list, take one element out of
it, and then put N - 1 items back. Which, when there are deep chains
of uretprobes, would be quite an unnecessary CPU overhead. And I
clearly didn't want to add locking anywhere in this hot path, of
course.

So I figured that at the absolute worst case we'll just keep
MAX_URETPROBE_DEPTH items in ri_pool until the task dies. That's not
that much memory for a small subset of tasks on the system.

One more idea I explored and rejected was to limit the size of ri_pool
to something smaller than MAX_URETPROBE_DEPTH, say just 16. But then
there is a corner case of high-frequency long chain of uretprobes up
to 64 depth, then returning through all of them, and then going into
the same set of functions again, up to 64. So depth oscillates between
0 and full 64. In this case this ri_pool will be causing allocation
for the majority of those invocations, completely defeating the
purpose.

So, in the end, it felt like 64 cached instances (worst case, if we
actually ever reached such a deep chain) would be acceptable.
Especially that commonly I wouldn't expect more than 3-4, actually.

WDYT?

>
> jirka
>
> > +     } else {
> > +             /* we might be racing with ri_timer(), so play it safe */
> > +             ri_free(ri);
> > +     }
> >  }
> >
> >  /*

[...]

