Return-Path: <bpf+bounces-33086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35320917123
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 21:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD932B23323
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 19:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9821617C9F1;
	Tue, 25 Jun 2024 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJyAer/p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA591870;
	Tue, 25 Jun 2024 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719343967; cv=none; b=SkPknsgRd1EtKCjWmwewXPnQc7xQAPSgHBqZz/NFDGrpw/PuwbKSqor6M96LjpWArubHB314xZDLS2PykyddXiOANGI/nEia7f+3skvRc8V3hGUr7yisl8G1kjM/4UqT4Bw/fHg04YHmN2sdfCj1xCZdI5Y6VMjOrelHXfcHNr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719343967; c=relaxed/simple;
	bh=DnQRoEdyrthluBz9ZjrBw/F5UHcR54p5iM+G1c/J+Pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmM6mZqgEHKRWyz/a/CK9vqaOKKHrD4v6pV8NpUYBzDIwVBVHPrKK4rzkkKRE2z7OPGtrDmQT04pX0EEH0DVKDTeF5vgqptOcHlTYo5Rmvlz+0z6ri4R789EO7+xExMgOAKybam7MnOzhT1T7HUnCjpqnVtWpk59vvGlDfx8cNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJyAer/p; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3626c29d3f0so3249864f8f.1;
        Tue, 25 Jun 2024 12:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719343964; x=1719948764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnQRoEdyrthluBz9ZjrBw/F5UHcR54p5iM+G1c/J+Pk=;
        b=fJyAer/pDY5fGKu9YNewC+lK2waQjdxgJIiHT6PASwWVnWSnBjvS7fU7RKSdpZ+/ul
         aiXgrLnC06UBuWtely/iAAiNBin67uwU8WBxI0jZ32wNTQfFhgJ100rmkMxWiPYoRCDg
         602afHeV9kvWBhEpPZJYieI57+9+ar+lmFPelGL8PL4N470F+MRHLUThuM0mJCcpG+f/
         ROVyigqav9gttk75ddcL89w9+TFRPgAosUpErAKbOdh2rYIZQIltqmFNC+OMofvQ/QRl
         m3LHeufbNLXAFnMKHN1cyAvd2951fk/XVxsGq7hwcNKUHBdiLdC35Rg9tsL3zkLus5nA
         OZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719343964; x=1719948764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnQRoEdyrthluBz9ZjrBw/F5UHcR54p5iM+G1c/J+Pk=;
        b=F/RMJPMPRU7Jnr0GZjTFl0qmxLxS0GRorOkS1nFc8itr784lNm2kwFP/BgwfpMTETn
         fCz0O9PQ8AGBVHEWQLZBG5kWj1mO1HhmhjA29UXbCS1mFSO26xgGidZgSNMPiuOba8Fq
         vtAC9xCtcgiB4KAHoTV8n10rnXWScCfhE03e8Kcxg61R3Bw4CJHvTpljpq2EE4woz7p8
         fnRoaacdbHNxJ6C2DMv5zS7K4sJPiBDr28mkcGYqfQiVlGZW8wOJtbVoGGBsZuORtmD8
         bj/jio8RiezEhoOrUoqdKpAo2X1lSUi0kJfjNlMqty0Auf9DtiQz7lBZ3/EfSlNdN3IN
         2yNA==
X-Forwarded-Encrypted: i=1; AJvYcCWD5OfBu7kBgwXImIj+8t8gP55rBs1oambeh65oPFVSKcj9quXTYpv9Woe2SI9LUaabe3mbtrPzinvO2EP0rlu8hEiSxj+8cpBQDXIaLkm9rvqh8nUW3o9obMZ3Yi+xZdNS
X-Gm-Message-State: AOJu0YwFY5WETS8x9p7UtCj/HLANVGyavCAxzShE0ykhopZTrRFFihug
	Q2fQWxrRB0KvFBRwpcYOiHvA5FUjYYjG1bP6JkCVdbb+oZWn8OpS8DiZNIumf2vJK0roUKir/Q4
	RK6w7RxePqbHDArarVHY+DA6k24MAM44T
X-Google-Smtp-Source: AGHT+IGA86k5Aqfzg1le+Qv8IuoHTByGOF845ffJiYzXEtp4V2fWk+JkfntcfCyGbuVvdTK0J+kUAuM7H96JAi68ttc=
X-Received: by 2002:adf:e7c9:0:b0:367:62a:edb0 with SMTP id
 ffacd0b85a97d-367062af25emr1484375f8f.44.1719343963702; Tue, 25 Jun 2024
 12:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <345098dc-8cb4-4808-98cf-fa9ab3af4fc4@I-love.SAKURA.ne.jp>
 <87ed8lxg1c.fsf@jogness.linutronix.de> <60704acc-61bd-4911-bb96-bd1cdd69803d@I-love.SAKURA.ne.jp>
 <87ikxxxbwd.fsf@jogness.linutronix.de> <ea56efca-552f-46d7-a7eb-4213c23a263b@I-love.SAKURA.ne.jp>
In-Reply-To: <ea56efca-552f-46d7-a7eb-4213c23a263b@I-love.SAKURA.ne.jp>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Jun 2024 12:32:32 -0700
Message-ID: <CAADnVQ+hxHsQpfOkQvq4d5AEQsH41BHL+e_RtuxUzyh-vNyYEQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: defer printk() inside __bpf_prog_run()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: John Ogness <john.ogness@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 9:05=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/06/26 0:47, John Ogness wrote:
> > On 2024-06-26, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> >> On 2024/06/25 23:17, John Ogness wrote:
> >>> On 2024-06-25, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrot=
e:
> >>>> syzbot is reporting circular locking dependency inside __bpf_prog_ru=
n(),
> >>>> for fault injection calls printk() despite rq lock is already held.
> >>>>
> >>>> Guard __bpf_prog_run() using printk_deferred_{enter,exit}() (and
> >>>> preempt_{disable,enable}() if CONFIG_PREEMPT_RT=3Dn) in order to def=
er any
> >>>> printk() messages.
> >>>
> >>> Why is the reason for disabling preemption?
> >>
> >> Because since kernel/printk/printk_safe.c uses a percpu counter for de=
ferring
> >> printk(), printk_safe_enter() and printk_safe_exit() have to be called=
 from
> >> the same CPU. preempt_disable() before printk_safe_enter() and preempt=
_enable()
> >> after printk_safe_exit() guarantees that printk_safe_enter() and
> >> printk_safe_exit() are called from the same CPU.
> >
> > Yes, but we already have cant_migrate(). Are you suggesting there are
> > configurations where cant_migrate() is true but the context can be
> > migrated anyway?
>
> No, I'm not aware of such configuration.
>
> Does migrate_disable() imply preempt_disable() ?
> If yes, we don't need to also call preempt_disable().
> My understanding is that migration is about "on which CPU a process runs"
> and preemption is about "whether a different process runs on this CPU".
> That is, disabling migration and disabling preemption are independent.
>
> Is migrate_disable() alone sufficient for managing a percpu counter?
> If yes, we don't need to also call preempt_disable() in order to manage
> a percpu counter.

If you want to add printk_deferred_enter() it
probably should be in should_fail_ex(). Not here.
We will not be wrapping all bpf progs this way.

pw-bot: cr

