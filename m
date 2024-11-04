Return-Path: <bpf+bounces-43916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC0E9BBC72
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 18:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E30D282D04
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 17:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B7E1C9EAF;
	Mon,  4 Nov 2024 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at3Zikhm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC731C728E;
	Mon,  4 Nov 2024 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742814; cv=none; b=Q0lGiYRtWEgI/Vp9HiPiz2sLnE5V4Qese3GcNap6CPeqUd+FMCD+ZiFd5QMfZAIVPCh1nHiXTkyhHmkuJQmejSCeHVX+3+vDhXsS5f19Y481A/PmtgFOETrqB1Y+hbphBPd7UfxKDaH5acMboKjrm3LOn1gYzFC0TcnW1n44NdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742814; c=relaxed/simple;
	bh=mc6KjrSKGNhzk7zMiiT3xKlkLITmL/SlBW3uGdvqw9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SaGiR0aMYNJOaQ/3BZjaSUg3UIDVma7db7KaL+SGOQaWq9Wk1UX31PXXcfjrkMKvCQOALVkVkpSZd0e4EIeIBi/vEmMyNaDgl8ytSxJ1F+w/sqGm4FV+2iUyle1i1MjrGwxgq8M3uCsOQ7rsy4QR8VwJFxz1L1zmjP6892CwIqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=at3Zikhm; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so4109789f8f.3;
        Mon, 04 Nov 2024 09:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730742811; x=1731347611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1k5WhoBLORFq44ORkly4uvXN45EdFEcgS+aWmjd7Myg=;
        b=at3ZikhmArxoybHMYxlpuOY4qaGf37WltOoBukfNqfrEq3iXkoEQ5UP8LxwcRL+dXz
         y37rgrhaJy7Y8OP4CV4WYz9p2x4922IUkJEbz4PS69w05eh9nqQ0EGvptC3YjczSIeHy
         vJ4kOjgRSwHS4nWgpO2NTwMLaQXxnbleAE9W0LHatN4pm8pR/ln+ZCobexLrmhV7FVnh
         vD7jGefy1B0EDT4CLNMFZvEkY+2oCseSRRZbHNkY62WoskpxSdyIMESOyrhN4bR61ksu
         K4exEMkWNzu2F1pyYVRRoYPA3J38K2afstKVbl4y1GLm6dIQh8HXkxJgT0ttRju7CPRB
         Pybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730742811; x=1731347611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1k5WhoBLORFq44ORkly4uvXN45EdFEcgS+aWmjd7Myg=;
        b=Fffhq0z1dyE1K1fLyXuA/Fslio08vga5He4Hhknaam5nvM4h9Hc7nt+yV8TPcpm/aE
         JnJ/uOvbs2fZd3DF9a32JVIRUcXK77BFU+zGOcdCMJzyUHr2X9ueauWQZeqICLgN0w+y
         n0Jc6mx4Hzf0Y9nPvGWfI5HV1aX85SkmoyXBe/CkmEYsEgGV59rPZ1mYDo9Mr/H3QVGQ
         nucxjPCLmi/uM9651N9yTI5fk87/tgrHz216Eix8wXKQLxr3Cs9P3nPNW/+x9J8gLKYj
         X+CYOY4i8y1Xve3aXnW8AoTznukvu17vSRYuov9UUTE0rCGBOpUl7vaDy1O9gQcomuBQ
         nZWg==
X-Forwarded-Encrypted: i=1; AJvYcCVyj0vKrUypuwm0pkdWmbx0y5B5U793xWuwKs2rZE6wedKpKrZ7tBsYjjYMuZ3YZ2RVtqyKPN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5NbEtLucZERQT5fL1+l5KQMXT6dzZdpEjSRbjV0rtmkoli/G8
	sAwFvqcfLabSWIYmhXS6Q37/BHHWgPRzpmdnnZ86EggFQ4NFddxSOHU4+fUP/6QHmwly21gcdf/
	1kIZcNy05biV7BeN7bKij9Dp/et/JFw32
X-Google-Smtp-Source: AGHT+IHv0Bn/+yT08pQ+ksO2hruINo8XwU2hMW0YNh5G0swiEfX9j7Uor5USoaSA5Jcw9ouL2iCiZ12esL+qph4KWlI=
X-Received: by 2002:a05:6000:1566:b0:37d:43d4:88b7 with SMTP id
 ffacd0b85a97d-381c7a46499mr12792751f8f.3.1730742811229; Mon, 04 Nov 2024
 09:53:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101111948.1570547-1-xukuohai@huaweicloud.com>
 <CAADnVQKnJkJpWkuxC32UPc4cvTnT2+YEnm8TktrEnDNO7ZbCdA@mail.gmail.com> <5c16fb2f-efa2-4639-862d-99acbd231660@huaweicloud.com>
In-Reply-To: <5c16fb2f-efa2-4639-862d-99acbd231660@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Nov 2024 09:53:20 -0800
Message-ID: <CAADnVQLvpwLp=t1oz3ic-EKnaio2DhOCanmuBQ+8nSf-jzBePw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Add kernel symbol for struct_ops trampoline
To: Xu Kuohai <xukuohai@huaweicloud.com>, Martin KaFai Lau <martin.lau@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Kui-Feng Lee <thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 3:55=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com>=
 wrote:
>
> >>                  *(unsigned long *)(udata + moff) =3D prog->aux->id;
> >> +
> >> +               /* init ksym for this trampoline */
> >> +               bpf_struct_ops_ksym_init(prog, image + trampoline_star=
t,
> >> +                                        image_off - trampoline_start,
> >> +                                        ksym++);
> >
> > Thanks for the patch.
> > I think it's overkill to add ksym for each callsite within a single
> > trampoline.
> > 1. The prog name will be next in the stack. No need to duplicate it.
> > 2. ksym-ing callsites this way is quite unusual.
> > 3. consider irq on other insns within a trampline.
> >     The unwinder won't find anything in such a case.
> >
> > So I suggest to add only one ksym that covers the whole trampoline.
> > The name could be "bpf_trampoline_structopsname"
> > that is probably st_ops_desc->type.
> >
>
> IIUC, the "whole trampoline" for a struct_ops is actually the page
> array st_map->image_pages[MAX_TRAMP_IMAGE_PAGES], where each page is
> allocated by arch_alloc_bpf_trampoline(PAGE_SIZE).
>
> Since the virtual addresses of these pages are *NOT* guaranteed to
> be contiguous, I dont think we can create a single ksym for them.
>
> And if we add a ksym for each individual page, it seems we will end
> up with an odd name for each ksym.

I see. Good point. Ok. Let's add ksym for each callback.

> Given that each page consists of one or more bpf trampolines, which
> are not different from bpf trampolines for other prog types, such as
> bpf trampolines for fentry, and since each bpf trampoline for other
> prog types already has a ksym, I think it is not unusual to add ksym
> for each single bpf trampoline in the page.
>
> And, there are no instructions between adjacent bpf trampolines within
> a page, nothing between two trampolines can be interrupted.
>
> For the name, bpf_trampoline_<struct_ops_name>_<member_name>, like
> bpf_trampoline_tcp_congestion_ops_pkts_acked, seems appropriate.

Agree. This naming convention makes sense.
I'd only shorten the prefix to 'bpf_tramp_' or even 'bpf__'
(with double underscore).
It's kinda obvious that it's a trampoline and it's an implementation
detail that doesn't need to be present in the name.

>
> >>          }
> >>
> >>          if (st_ops->validate) {
> >> @@ -790,6 +829,8 @@ static long bpf_struct_ops_map_update_elem(struct =
bpf_map *map, void *key,
> >>   unlock:
> >>          kfree(tlinks);
> >>          mutex_unlock(&st_map->lock);
> >> +       if (!err)
> >> +               bpf_struct_ops_map_ksyms_add(st_map);
> >>          return err;
> >>   }
> >>
> >> @@ -883,6 +924,10 @@ static void bpf_struct_ops_map_free(struct bpf_ma=
p *map)
> >>           */
> >>          synchronize_rcu_mult(call_rcu, call_rcu_tasks);
> >>
> >> +       /* no trampoline in the map is running anymore, delete symbols=
 */
> >> +       bpf_struct_ops_map_ksyms_del(st_map);
> >> +       synchronize_rcu();
> >> +
> >
> > This is substantial overhead and why ?
> > synchronize_rcu_mult() is right above.
> >
>
> I think we should ensure no trampoline is running or could run before
> its ksym is deleted from the symbol table. If this order is not ensured,
> a trampoline can be interrupted by a perf irq after its symbol is deleted=
,
> resulting a broken stacktrace since the trampoline symbol cound not be
> found by the perf irq handler.
>
> This patch deletes ksyms after synchronize_rcu_mult() to ensure this orde=
r.

But the overhead is prohibitive. We had broken stacks with st_ops
for long time, so it may still hit 0.001% where st_ops are being switched
as the comment in bpf_struct_ops_map_free() explains.

As a separate clean up I would switch the freeing to call_rcu_tasks.
Synchronous waiting is expensive.

Martin,

any suggestions?

