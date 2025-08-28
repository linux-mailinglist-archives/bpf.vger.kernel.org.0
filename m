Return-Path: <bpf+bounces-66861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B19ABB3A6B8
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51141884559
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 16:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7906A322DD1;
	Thu, 28 Aug 2025 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmLkujt8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54464322DC0
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756399395; cv=none; b=ErIpP/Wv8IWARJBovSq5H2QaEg09ZcAj4p8gzNswI0TEntlB8xFSRHApDjFfS9wH2kDEgGqnOnm3/QD41M6+SODIxoEJ/cTRAaCgnIjksT6BmK5ZnEjRBfLlOFO6Fit4yql5sm5+IJrvjv9QArz8PotU3RE320pZUb5IIWj9nhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756399395; c=relaxed/simple;
	bh=YkCFPOrVORVMZ30p2q/ahoxuX2kMU7tV3eotTF4/MKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLz/R9LuTqrKjAmndwcEOveNj7B/cTIs4M+NwAdZJkR5FLNdBPVr+0/Vbw67JvxdMoGUo/sCYTt4Gkvnk8qrNhTRu3YScdzvyvlFWqwxAxLVTFpfRagfIOQZzXsSW+1gDKMOJLe7QUSgYt/q/+M33++AKgvvO7ky+pYQ5aCoo+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmLkujt8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c79f0a5c5fso931072f8f.1
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 09:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756399391; x=1757004191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ihu5DsOEI1Ct6E7O+q59lruogc+/Ij/tmAfzxP9nY28=;
        b=jmLkujt8RTXBBc/+STXqySeKODTlk0QKs3Z0+V/+B3UZfE0RupUjpmMgWQGakI6h4c
         kDYKyqth9Iyc0IjETJUNUdRmvR27tRYWbC5QJvmEqS2lYNYO5zvd8kSJ+b0nd478R4ZH
         tlSurQgPnpRZ3YztxsyMoAQV0ciA8xgp8QhUW2NMP0L6YS8onTZmVe2Pe0inquhfuKBX
         9n4ALdILaWuemPLKT6J84VtIzbUPwuak9mgy/zxJ/A/LuUfJkyJFUL4VNjFXwmRiAGAx
         5vxHhdyl42cMFeP2VT5LnPENuwDot6h2OLeQZQ+x/H8Gc3nWe8pk6sfjWLtR8JZCaNn/
         AMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756399391; x=1757004191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ihu5DsOEI1Ct6E7O+q59lruogc+/Ij/tmAfzxP9nY28=;
        b=e1SBZsHdlvlunGPM/onXwo4mYNCVsTzRC+U+adlUKu0IJemgGa08Bm7p7hGYYIFaD6
         eAf/esNlXLsJp8BUmasTpAaPOEZaI85HERPJr9SswA4QaoOOMFhr/QpK4cN4u5R6h7MC
         sT32LX1PfgJUX1ssKi4NW7isrXYj+8YDb/s0H8qQX7u93Qp17Ums56MC9EW0bHUlC2X7
         it6koFWJaF60E+r5cQKOP00BlWtoMh1aGMHNNATr4myrSQNoqt3pyywjy/MQtFBLqLV9
         z6ahQT8kDSxvhSDm6Dj/euKM9V0pvgmNg8YEHGTKdMbiUQMSMtrY8pbCkAVQTp2N4XIo
         Ww0A==
X-Forwarded-Encrypted: i=1; AJvYcCWdJaS23ZjY/v8Un0AYvvwMyMKatrNCr1vYvZqizZEYMINncsmV7RK2mnkGPFpFC27D5+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkpDfS52tqBripNlKlXy5peMhQ7XWnCIkDWusQhVNwFnwAhxtD
	Wy1NRLCl1o3v/GlMdVF8sung8F1QWd+E4RHfvJuoGW0HvNO8KHL6ceBT9LDAKrb85RmtDT9cn4x
	zu+KQW5TweJ5RGg0SxiTTNtssFneQefM=
X-Gm-Gg: ASbGnct9690gpwt3mXcaPZJLEpzQDxX2wf1fpZtZ4fqlrbb8S7i8eLAc1gAhublBYbj
	TgolEzaO6fhs1AMy92S3RIXOWub9vFh0YPturFEy0RKYxG9djVDLRhVTTvQq2dtoCvnkgb08fTM
	lTDFs4hpuo5tm6nCPXK6pd1QJG3ZzyBAndOmbO9EUhAv1mQwsoZo0VQUhJ7iRhJW74QFhU0LuBT
	8E9RQi/5Nuc39oHBbzkrjkiN9YBlhG6P85gov4bUYlGSJA=
X-Google-Smtp-Source: AGHT+IHDQVfHkcxj3EkmsWip00CMYEUCFtVLkjpcqJa5yD7Gsgu+7zsj/7QcER+C0Vg0c2XbRSPzUVtAWJ0uZW8Ngx0=
X-Received: by 2002:a05:6000:288a:b0:3a4:fea6:d49f with SMTP id
 ffacd0b85a97d-3c5dcc0dec3mr17435812f8f.49.1756399391329; Thu, 28 Aug 2025
 09:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a08c7c19-1831-481f-9160-0583d850347a@linux.dev>
 <CAADnVQJz9ekB_LjSjRzJLmM_fvdCbeA+pFY20xviJ-qgwFtXWw@mail.gmail.com>
 <8dcc144e-3142-4e0d-a852-155781e41eb4@linux.dev> <CAADnVQLDG=Oavh9He=ivXm9MPwsqWHttbTYQh1-EZuHpwujaBA@mail.gmail.com>
 <b3463ffa-c2cb-43c8-a0d2-92bad49e3c23@linux.dev> <93e75cff-871f-4b49-868c-11fea0eec396@paulmck-laptop>
 <DCE3PPX8IFF4.FE1BC8HMP4Y7@linux.dev>
In-Reply-To: <DCE3PPX8IFF4.FE1BC8HMP4Y7@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 28 Aug 2025 09:43:00 -0700
X-Gm-Features: Ac12FXyfAJbbXawvQ_oGPZBMDHXcZztbNppc9A9fnrXK78iujgxo4XkuaHy6Tf0
Message-ID: <CAADnVQ+G73vyC77tSo3AFcBT5FiBFbojfddnpYi5yRcqOxQiDQ@mail.gmail.com>
Subject: Re: [BUG] Deadlock triggered by bpfsnoop funcgraph feature
To: Leon Hwang <leon.hwang@linux.dev>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 6:39=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On Thu Aug 28, 2025 at 7:50 PM +08, Paul E. McKenney wrote:
> > On Thu, Aug 28, 2025 at 10:40:47AM +0800, Leon Hwang wrote:
> >> On 28/8/25 08:42, Alexei Starovoitov wrote:
> >> > On Tue, Aug 26, 2025 at 7:58=E2=80=AFPM Leon Hwang <leon.hwang@linux=
.dev> wrote:
>
> [...]
>
> >> >
> >> > bpf infra is trying hard not to crash it, but debug kernel is a diff=
erent
> >> > category. rcu_read_lock_held() doesn't exist in production kernels.
> >> > You can propose adding "notrace" for it, but in general that doesn't=
 scale.
> >> > Same with rcu_lockdep_current_cpu_online().
> >> > It probably deserves "notrace" too.
> >>
> >> Indeed, it doesn't scale.
> >>
> >> When I run
> >> ./bpfsnoop -k "htab_*_elem" --output-fgraph --fgraph-debug
> >> --fgraph-exclude
> >> 'rcu_read_lock_*held,rcu_lockdep_current_cpu_online,*raw_spin_*lock*,k=
vfree,show_stack,put_task_stack',
> >> the kernel doesn=E2=80=99t panic, but the OS eventually stalls and bec=
omes
> >> unresponsive to key presses.
> >>
> >> It seems preferable to avoid running BPF programs continuously in such
> >> cases.
> >
> > Agreed, when adding code to the Linux kernel, whether via a patch, via
> > a BPF program, or by whatever other means, you are taking responsibilit=
y
> > for the speed, scalability, and latency effects of that code.
> >
> > Nevertheless, I am happy to add a few "notrace" modifiers
> > if needed.  Do you guys need them for rcu_read_lock_held() and
> > rcu_lockdep_current_cpu_online()?
> >
>
> I think it would be better to add "notrace" to following functions:
>
> ./bpfsnoop -k 'rcu_read_*lock_*held*,rcu_lockdep_*' --show-func-proto
> bool rcu_lockdep_current_cpu_online(); [traceable]
> int rcu_read_lock_any_held(); [traceable]
> int rcu_read_lock_bh_held(); [traceable]
> int rcu_read_lock_held(); [traceable]
> int rcu_read_lock_sched_held(); [traceable]

Agree. Seems like an easy way to remove a footgun.

Independently it would be good to make noinstr/notrace to include __cpuidle
functions. I think right now it's allowed to attach to default_idle()
which is causing issues.

