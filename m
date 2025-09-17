Return-Path: <bpf+bounces-68600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9557B7C9FE
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08DB2A3524
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 01:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EDD21CC56;
	Wed, 17 Sep 2025 01:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPoOiqCj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49EF6ADD
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 01:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758072569; cv=none; b=mT8DAkH7mqhlOpDiLUUQ5B+JqDPsyznkhQAlpbfRRlwNBDlcrlxKjKL57nYpiOHqZiO/PftSfbAsOe3ew0bPiuLaD7yss0EWk89/a3Ch7uHWJ0XWQR43DCmoQFOhPxTXitK5g2BlHiOLrqfJY54i4X/uZjdsRVb82aP7LBi9CKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758072569; c=relaxed/simple;
	bh=h3Z5XBCUX9Dv2HU1H9TfoRrMA8iokD6T9vv05gDJaVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+RDrMsNXazlQ6a0c3h9tJuqfZktgX/QXNI4qUV2tHGPbBJHkjVgVDksMHgoTSCqfQf9KnckJj/Hd6gA7wC9L3HGJDlDk7WodzoIOHnWEoxYBqy/PoCkI49ALOJb3cxgkZWaKnTnjykIm2c5Ko3TpIf8bx3cJ/bYx8Z/OHlEzUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPoOiqCj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso4297847f8f.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 18:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758072566; x=1758677366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g02scMvbk75kZ0Cp+7G6/bKYH1FANYju2c3jRvcZJZU=;
        b=OPoOiqCjygeljr4KR8DiGtu8k7Psx8O8LvNGrRv0gt9YLa+IbWM3PCrENdfwxNhxYQ
         WRutVU660VunScw/vMt0Ni4hUZ3zwLfuvnKrkAbrtORuIZDt4mqY9VyC3NUkwOWA8t3m
         8oXgkIrlrhdilsLQrA5a6Qbn0mV+aeO2idtF88qHF33Q4ZMosWzjZ+krVr/2SVho1B0M
         MBvZm6dhhOy0MopEUbsRoI1Xcqx79BnwlY8AINt4oLXIX8SDoJX4NSkUVAVC0tkyFJIY
         eO9s8PmaXFg0Oa1EV7k6rghJgdiU/Cvl7/ZE6Rk6hmIena6CqkwK5Nv8kaoiU11d9dYD
         IR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758072566; x=1758677366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g02scMvbk75kZ0Cp+7G6/bKYH1FANYju2c3jRvcZJZU=;
        b=mynzmMrG43K+4saKcvtl3sRp45Nj4+leKNvqqBazl3QREHzbr7sZg7NNuCKIwRUDp/
         iu65qMqH1rs9zA/MnTIYy6KiHn3MvTuZXovgfbCUtajuXN40zwsv5P01WNz6c7KAAQCj
         PmJVln2FlWtnaKflaCYi2RM0vv8wIu+akKkievXHWn5+T2Tacvr4ZoQGaAoYu0QTDebl
         e8XM11mrGeDJl959zFVk0thglAtSFsW1UMDdIaQ49VY7i0QgAODx3ZDeHB1BAQyP7DBK
         sx+W+6SdfdNSRpx9BzmKLueQtK+2DZqzKEpUFd9p5aClNHKwa//AkyGpzhk+aLw0h8GN
         c0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVPRx1n8guVnoNfbB2XlMpZ8xYzLL5oyj0EEikvTNng6Sxm3HIrkD2To5dU++1OEbLP98o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytif/nP9/qIg0A5LXJ4ltuXm3K6BO1z9hEuu44oQIikubm8Pv5
	qL5YEX9EQU8IKcOBmb6s97yXXpfkMtbeqFfZiZV4LQ7dwfaZDr57MvAL+x/mbmsJyhO+MZ0sMtN
	tipxKwxsbn8iy4fPJzWWS1+IzAN7GDZQ=
X-Gm-Gg: ASbGnctivhvXDpomGZAyGY5aABgUTmmDk97rYsT36kL4q7IBKlkSgu0w8dgl3gS158F
	u/ezSqo3sVR2noh6KChNpGjdGPci7F3pwdiPyEQ4B/5u9nsFE5LeyWmivDcrnoW/jjeyqiYaeE/
	zzw40BezPqTSyZLXWMdscXupALJUjDPdzh2Xozo/DEeUt4pRcqpDuViN1k2SFvJAWBKQuvdCkWv
	HuOhLPBka5ZJN+BC8vJFeSQXPMmjTBeNCETQleKYide1E8=
X-Google-Smtp-Source: AGHT+IEGu2CFDwBKeE+Za3mS59QmE9EyUvSMozSD5HGBC7qiRicgAaOBdHaPM1rrChotGV0D3S7jMHBFx3v53S+dHWI=
X-Received: by 2002:a5d:5f50:0:b0:3ec:a019:393a with SMTP id
 ffacd0b85a97d-3ecdf9c1ecfmr306816f8f.18.1758072566073; Tue, 16 Sep 2025
 18:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828060354.57846-1-menglong.dong@linux.dev>
 <20250828060354.57846-3-menglong.dong@linux.dev> <20250916110712.GI3245006@noisy.programming.kicks-ass.net>
 <5041847.31r3eYUQgx@7940hx>
In-Reply-To: <5041847.31r3eYUQgx@7940hx>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Sep 2025 18:29:14 -0700
X-Gm-Features: AS18NWCywD3v3_flXeHPv7j2zezoyngM7asF-x_7Gtru8Ru5a7BomoXllOy3-Rw
Message-ID: <CAADnVQ+KzOiDeq5WrM-08js7XEH_CU0D9cb+a5iV_JsMm+RyWA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] sched: make migrate_enable/migrate_disable inline
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	tzimmermann@suse.de, simona.vetter@ffwll.ch, 
	Jani Nikula <jani.nikula@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 6:26=E2=80=AFPM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
> On 2025/9/16 19:07 Peter Zijlstra <peterz@infradead.org> write:
> > On Thu, Aug 28, 2025 at 02:03:53PM +0800, Menglong Dong wrote:
> >
> > > +/* The "struct rq" is not available here, so we can't access the
> > > + * "runqueues" with this_cpu_ptr(), as the compilation will fail in
> > > + * this_cpu_ptr() -> raw_cpu_ptr() -> __verify_pcpu_ptr():
> > > + *   typeof((ptr) + 0)
> > > + *
> > > + * So use arch_raw_cpu_ptr()/PERCPU_PTR() directly here.
> > > + */
> >
> > Please fix broken comment style while you fix that compile error.
>
> It's a little embarrassing. The compile error is caused by the commit
> 1b93c03fb319 ("rcu: add rcu_read_lock_dont_migrate()") in bpf-next tree,
> which uses migrate_enable/migrate_disable in include/linux/rcupdate.h
> but include the <linux/preempt.h>.
>
> I can fix it by replace the linux/preempt.h with linux/sched.h, but shoul=
d
> I fix it in this series? I mean, the commit 1b93c03fb319 doesn't exist in
> the tip for now :/

If it's just a different include then go for it.
Make sure there are no nasty build issues during the merge window.

