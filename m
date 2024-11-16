Return-Path: <bpf+bounces-45019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D08C9CFFEC
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 17:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBB7287EAC
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 16:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37A018E35D;
	Sat, 16 Nov 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTAl+eYU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972AE126C01;
	Sat, 16 Nov 2024 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731775384; cv=none; b=kV5m2z0p7j4evXv+3KSCQJ0YVnJNXHQqRoML/lElRGDUBYbEppd7KdyC6kt5mLglgxXa+6ItDlvpA5EZmm8wnOdkc/FBXPSaQBisIaNYad2mYN5I1L/PwUhPcbVv5+8tbWLM7CW1WGTyzY0BbxbAYUirp2NGIRPsIf0tKo5SE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731775384; c=relaxed/simple;
	bh=pYjbgnkOs1b1lmociUmZeMIJViJjLIkw8QLnkNEo5dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwrY75F9iaRF61WPJv7l770W2WWMj1ERWOCwFfSe/xAD5kMtraWqTyiT5PkrHyU1cG64Q4HexQHZ5VySIhAl8i3NvBVTak70T4g9NZvJqqxYfPWjEjL1YRuWRg7MYIFnbxgh2lymK+BpIYqx7eOME+BcVO9xaF9AdWbniArZeRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTAl+eYU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43169902057so23327215e9.0;
        Sat, 16 Nov 2024 08:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731775381; x=1732380181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYjbgnkOs1b1lmociUmZeMIJViJjLIkw8QLnkNEo5dA=;
        b=gTAl+eYUcBuv1ZNUA7z4sAhwZ4wbJotSlBuluRFqYSBUb7SH0CtZwjD/Pg2r5sAT6Q
         0H1sCMRaXOunWFG05uSguxvFDCcEN19VPYSsV8lHGW9WB9tVuvf7wy6pt6l06Tgzpdqr
         kScG7sGZ/8awnW/SSn+xfg51gjBK9GFbUK/PgKjDxirKjnuK3fnyyXVHdDA7nshl5jFk
         ys2nUEjAcNzmXfx1f+DCHG0ZaL6e72lcMG+LPOzUhgB7yN18YIecFGDhr7ckl4qPM4XI
         S9zjIQW/eKMi2QcolLsytdHLiB4qL4hweMm7Mc2dTcbQj1/mkZlbYVFI1Y8Vid0qVefb
         2GUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731775381; x=1732380181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYjbgnkOs1b1lmociUmZeMIJViJjLIkw8QLnkNEo5dA=;
        b=RfrrzwL7qO4yqzuX+NhH+Vq2gwZPqu6j6DMjlpdCCZUyZSq1zmuSbOu9dowVVYlZuV
         6gIjFFChumThC3oST+FKYapsVrufcQdcYak3ZfqBbz7GHcPLv1LXEtOSlWBooMp+7wGJ
         lV9zzfcqW7iYNBX/QwtSmx2M4EdBcqUSYa26wSIB4t0PpB1Tv2tH9lb8hGCaiu5CE55F
         7kUZhpG/TsVtJjtjjc66OMrMeNRKNOyBeK6PRaBxf1uGPABCCLf8I9yjyo0jmUJATLsS
         NNv+CNVv12wCKhGBv7MkET0/AgSXeT+JEOcY6fKosx6xplRDtf/PpOFn4bkWTD3528DW
         3NhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhtNsIn87LHLFJg4QxJuxAuhPBpBoNGcXq5KhSy0HRXEAf0WjjYaKaqjo4Yr2StnOn1N8IADIt0Nfc01WI@vger.kernel.org, AJvYcCXXqAGGWgc0yUfOw1oy86rgKg6muHzoOH9uv1/Di9/IEFLOC4FxKZSBwp6fhPhOJDbnafU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ps7p4YbnDStW4R9AvrUENp8+ve8WAIFp4QDAhZ3gxzslyAHu
	myGYo/6DjKUmBc/H0aLE37qrEPe8NmEm9/K/YXo3xnp1sUxG1L9dVSaQACtCN3bDSZGZxK4DpVC
	/JthMdlSgUm1t7P1dVV9O0j6S/cc=
X-Google-Smtp-Source: AGHT+IHZuIblvCjZxwjk9MUHPMHsNmj3JdzxQOOvtr63PNRuKmUVsEBKip1QMj+H+7R1Ymgzl0upNJPmM4UPzjOeT6U=
X-Received: by 2002:a5d:64c8:0:b0:382:2276:c93c with SMTP id
 ffacd0b85a97d-38225a8a36cmr6494006f8f.44.1731775380800; Sat, 16 Nov 2024
 08:43:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108063214.578120-1-kunwu.chan@linux.dev> <87v7wsmqv4.ffs@tglx>
 <1e5910b1-ea54-4b7a-a68b-a02634a517dd@linux.dev> <87sersyvuc.ffs@tglx>
 <20241116092102.O_30pj9W@linutronix.de> <CAADnVQ+ToRZ6ZQL44Z9TAn6c=ecqrDgrnJenH7-miHJSWe7Nsw@mail.gmail.com>
 <1ed46394-f065-4e8b-8f37-c450b0c1b3a9@t-8ch.de>
In-Reply-To: <1ed46394-f065-4e8b-8f37-c450b0c1b3a9@t-8ch.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 16 Nov 2024 08:42:49 -0800
Message-ID: <CAADnVQJBGKioLA0JuyCQdD-jRKn2bpb7A7r6Yo4drBb9G1tvbg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Convert lpm_trie::lock to 'raw_spinlock_t'
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Kunwu Chan <kunwu.chan@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, clrkwllms@kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 8:15=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> On 2024-11-16 08:01:49-0800, Alexei Starovoitov wrote:
> > On Sat, Nov 16, 2024 at 1:21=E2=80=AFAM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2024-11-15 23:29:31 [+0100], Thomas Gleixner wrote:
> > > > IIRC, BPF has it's own allocator which can be used everywhere.
> > >
> > > Thomas Wei=C3=9Fschuh made something. It appears to work. Need to tak=
e a
> > > closer look.
> >
> > Any more details?
> > bpf_mem_alloc is a stop gap.
>
> It is indeed using bpf_mem_alloc.
> It is a fairly straightforward conversion, using one cache for
> intermediate and one for non-intermediate nodes.

Sounds like you're proposing to allocate two lpm specific bpf_ma-s ?
Just use bpf_global_ma.
More ma-s means more memory pinned in bpf specific freelists.
That's the main reason to teach slub and page_alloc about bpf requirements.
All memory should be shared by all subsystems.
Custom memory pools / freelists, whether it's bpf, networking
or whatever else, is a pain point for somebody.
The kernel needs to be optimal for all use cases.

> I'll try to send it early next week.

Looking forward.

> > As Vlastimil Babka suggested long ago:
> > https://lwn.net/Articles/974138/
> > "...next on the target list is the special allocator used by the BPF
> > subsystem. This allocator is intended to succeed in any calling
> > context, including in non-maskable interrupts (NMIs). BPF maintainer
> > Alexei Starovoitov is evidently in favor of this removal if SLUB is
> > able to handle the same use cases..."
> >
> > Here is the first step:
> > https://lore.kernel.org/bpf/20241116014854.55141-1-alexei.starovoitov@g=
mail.com/

