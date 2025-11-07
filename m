Return-Path: <bpf+bounces-73985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A750C41936
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 21:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29C2F4E48A3
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 20:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799F0309EEC;
	Fri,  7 Nov 2025 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlRbMDUM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B28280332
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546915; cv=none; b=QqZ0sXRpLKO55i0KZYINUMtbEYhLniy+CW1ScXSEsPTU+yJkSUGoA+EXhs/jZ7vfSj+9OxkMd0/dO7o/UruTmphf4XpY6sg8KNbyCUZTVdfIQNUmlQ80Jkzs1IL+RhPsX2LEkHLN680Ur2ncmhQu6POE+jvM0DRx22LszHHRHEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546915; c=relaxed/simple;
	bh=zyW5yphNvLSjpOXbYDEoZEzBehukBlEIyK8n4rkcPrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8fYd7vNqjMacSOXEtogc6UA8kMMjdy0ytU9kJ2m44FXkVQ9Iz6M85kPnQK6UrNjmcRstp/6mWbsk40mcZcHoKwI4Rk7FIodmWOOKSvTAVV1hFkh3bo4GcRUGCiqbQVFc9uYULrEu/jdGwhVyYbDoKrSFo+ZHbUfyso8cg17lYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlRbMDUM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so751862f8f.3
        for <bpf@vger.kernel.org>; Fri, 07 Nov 2025 12:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762546912; x=1763151712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqNt2MUmVvIAxfk8yZxvLikqeOQAm+K9A7PGyUfH/+4=;
        b=OlRbMDUMc6RFM5ooAgC4c/CPDZ3lMmuDI/ONHNkZtUOE5ds2PuUH6Qc79xZr34Rca4
         hTA3sMOjNz+a64OG6BbXTnZIx/M8llHO0FmdwwFD3zVDKkU84HM5v1EO3CzfxqWzci07
         ufIBG7ESJ4zkR4dIqzcT3mFwYZqLuEeT8Ya/0+lx5aBvjZLkmSraTAWu8jIWfzHgTBf6
         eKfMFPa/A/VLfVRVVXZIFs8gwSPR2Cro85ekE9biLJEuWw1rVGDy0Kt661CI3na7nzwP
         es2bxNw+ozVEHMgwM0racI43ygqOrfyp3qBaHzHnXscE9qHH9SFOHa+p/VBY+ajb+pC/
         ZAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762546912; x=1763151712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MqNt2MUmVvIAxfk8yZxvLikqeOQAm+K9A7PGyUfH/+4=;
        b=O5rFrHxJcDz40l5kwQMOzeDaBWGnSKIOpAOYTXvuxZ4HNkkZledYvT0m0AehanaElX
         jiq/9cck6cR3fjB5rDu/mmNbUE6PnGzisvKBu6S2190US2MViNG2/JeiBYcRiBB/7Yvd
         VKeEbg/SSmIXQol37GKqao7aCb5C485Q/nmNok7eSRBZisJoMK6HpuqqxKIOUel2gtfn
         MSDhOwEEYw8J0xhxz+CyTfaWY+9tgJAAouF43VXKlbwQZ1Vnrs6AVulGKjEU7s8sWSfv
         H90kpsXfzQAyqHzp53rujH4asjTo5p0zqxv7MNbGAqpuI/cDpUO2Jp2Fmy9jHM5vaa5e
         SNFQ==
X-Gm-Message-State: AOJu0YxJXm4+0hWO6167NutD/UTD3uOMPDNRQ3YlN3nNLTlkv31Jey2Y
	UZeu1LTUr+mrbetHXVjf8fhEpoXKdxHvlDJjusofhWMhrbAW6vKnpG7xtG/pu0Lc88Xzz/PJHw8
	jvytQ9DKX7XtQNEMV2hSE7Uzewhd0E8M=
X-Gm-Gg: ASbGncuEuafJOd4h6QeYSsgHu5FZbXQcUWaOlrYGwSL8XwtuDpY7ED8qYTfbWghzq1Y
	jWmNNL8Ax8ZixvoRtYdlthwlklY0vT3+LLR1QK1t8vauyeKI16AD42LbF5/zmBfLo4RIU0jWEp5
	fcRyuTZWRMUoJQ6ITfg4Icwh+RyWCaOjpZMG0Oq+GB3my1KleHDRc+CsgjJRy3pmsV5OdTm1PWU
	6LoMWN1vg3PYUgo5Nasf6e2eLfaGhU6o+g1bHBafuDpq05z7hq/6QCuQv2aB+VM+tT0lX66VPg8
	IsZGQP4QQdthmp9EGg==
X-Google-Smtp-Source: AGHT+IGj2KE1gT8pEyHu+n/A3zv79AtOAYB57MXlrfm9jFg8mDJ2qjXJpKO+XmgWLxAzqwyQvJ6zp4HIW2s4Gi8dR4c=
X-Received: by 2002:a05:6000:220f:b0:429:8bfe:d842 with SMTP id
 ffacd0b85a97d-42b2dc16accmr164053f8f.4.1762546911639; Fri, 07 Nov 2025
 12:21:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com>
 <20251105-timer_nolock-v2-5-32698db08bfa@meta.com> <CAADnVQK250aA9TjoJWwBtRP+e7j254d4CQ=_2Sr=0N0O2G0E2g@mail.gmail.com>
 <6334ac51-eb49-4ec7-b111-75f5a260ba60@gmail.com>
In-Reply-To: <6334ac51-eb49-4ec7-b111-75f5a260ba60@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Nov 2025 12:21:38 -0800
X-Gm-Features: AWmQ_blfhoU8YeeJOOlAV_wNt45CttgFQL3XvHe8uP-RsD2HnOnRJJ30fj5YHnM
Message-ID: <CAADnVQLY1Vm19ZD7GMXDWzCzubx0ORBQYX8rh=BiH5YfA2QXvg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/5] bpf: remove lock from bpf_async_cb
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 7:58=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 11/7/25 03:15, Alexei Starovoitov wrote:
> > On Wed, Nov 5, 2025 at 7:59=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> +
> >> +       guard(rcu)();
> >> +
> >> +       t =3D READ_ONCE(async->timer);
> >> +       if (!t)
> >> +               return -EINVAL;
> >> +
> >> +       /*
> >> +        * Hold ref while scheduling timer, to make sure, we only canc=
el and free after
> >> +        * hrtimer_start().
> >> +        */
> >> +       if (!bpf_async_tryget(&t->cb))
> >> +               return -EINVAL;
> >>
> >>          if (flags & BPF_F_TIMER_ABS)
> >>                  mode =3D HRTIMER_MODE_ABS_SOFT;
> >> @@ -1489,8 +1512,8 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_ker=
n *, timer, u64, nsecs, u64, fla
> >>                  mode |=3D HRTIMER_MODE_PINNED;
> >>
> >>          hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> > This doesn't pass the smell test for me.
> > I've seen your reply to Eduard, but
> > fundamentally RCU is a replacement for refcnt.
> > Protecting an object with both rcu and refcnt
> > is extremely unusual and likely indicates that
> > something is wrong with rcu or refcnt usage.
> > The comment says that extra tryget/put is there to prevent
> > the race between timer_start and timer_cancel+free,
> > but hrtimer_start/hrtimer_cancel can handle the race.
> > Nothing wrong with calling them in parallel.
> > The current bpf_timer implementation
> > prevents the race, but it's accidental. hrtimer logic can
> > deal with it just fine. So tryget/put prevents uaf,
> tryget/put is not for preventing uaf in bpf_timer_start(),
> but in timer callback. it serializes or mutually excludes
> hrtimer_cancel() and hrtimer_start() : hrtimer_cancel() (from
> cancel_and_free())
> is either called before the hrtimer_start(), in which case
> we don't even attempt to start the timer, as it is freed,
> or hrtimer_cancel() is called after hrtimer_start(), which
> is good. Relying just on synchronization inside hrtimer
> functions, won't do it, we still hay end up
> hrtimer_start() on the timer that just has been freed,
> so the callback potentially does UAF.
> Potentially this can be rewritten without refcnt, by just checking
> the state, but I thought refcnt just makes this cleaner.

It feels to me that once irq_work delegation is done for timers
the same thing as in task_work will be necessary:
BPF_TW_PENDING -> BPF_TW_SCHEDULING
task_work_add
BPF_TW_SCHEDULING -> BPF_TW_SCHEDULED

and at that point the alternative with refcnt is only additional
cognitive load to analyze and think through.

