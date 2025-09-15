Return-Path: <bpf+bounces-68436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6BDB5860A
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558C83A9296
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 20:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF92296BA9;
	Mon, 15 Sep 2025 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlGnhdTg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1CE2747B
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757968110; cv=none; b=gZaDx51fTNk9SySALqH8DaT5zTvfq+Apo79fWuoPaIH3Ebvk7bu8ccdevY9sHSD4uNDJfEDkS+n8AXiKXqZvXWkxUSG93FLHgdzdty8rA3f0/zAtPFNPkbjPhDVrMJJgE+d+E2zQsD3DJPezLi+VSjYX8BRzNuGjSZkiwCdQHEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757968110; c=relaxed/simple;
	bh=3h6tJUg4j2nn3vxRoTa5kAkqO6S4thiPp0OJrs5F9Fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgG0vcLA/Crhoa8boJyGCik6fFNeImlusX3TvdOSvAxnG2atfLmyEhlHalo7oZhV7ijGwm7RHgZZxXzCIbnZPbLMZaHITVo4UPbOWFm2+Z8YC5mGdXyP5C9WxY57sePqfxYhd6EpAuQneBynS/03fVIzEruZ7PuAJXEADe8oAD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlGnhdTg; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4c3d8bd21eso3011084a12.2
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 13:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757968107; x=1758572907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hx9j4xTRBe3JemMHi5j5jN8ZX/IFSMtDaNxOsS9XoS8=;
        b=QlGnhdTg0IA5dozpCvC66hhTavfN3PSwOloozmgEES8x9x7BImaeE3sOXEW/tQeTDa
         J+LhFBQ2mGpEPAawBIrXCxLhBfjebqyvvCHTMna72tqWU8XHTcqL1CsGoiJLRp4L5r3f
         1ytyC4btoCVuWSaMk6z3ZUmAciqK0RBO8l0Z6BSZrC/rOQHApT9CNT+b3BVW5jGnhf8c
         LHybnnG/Jcu+YsbgFG9xA25YNdp/27ypyFz5m0en7FDRoQlU5lRJ3vf/s9UVenfJbhxo
         VrRFP7LmBpRnLWbPVjrxTZHfazJvz8x0sBJfBoZJqTcaDkwbb4RH+0vLztaIlwWC9Nm/
         lBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757968107; x=1758572907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hx9j4xTRBe3JemMHi5j5jN8ZX/IFSMtDaNxOsS9XoS8=;
        b=BX2rCrWL7nDc82wW28zRlw0BRyhkUQgx54Wts4ELPO43bnpObup3TBDg0xYKseTScU
         dovRhhiMKpsidxy9tNDujg/sC+7juqXsN47OdAgv3rQFahSbvtLKkMmKWkhmYk0C/1KA
         0oQKSbF3NaRNzJWkg7+2PXr/JfhocXEKIXhuDjdlIhrIL45lEKauQAyeSAWH67IulhJE
         +/T4IwBDMW9v2pFqzkT6V139PYkK9FwKokoVoWY38lz4z/YOwEnf8wOKrPspr+nsHXcQ
         GraQgHBX1jAnrTMvmacgNecolbqgEmdiRwr7RwbeEvnNBGmiPSULhTVw1cj9dGqAAhUR
         ppVg==
X-Forwarded-Encrypted: i=1; AJvYcCUX7Xy58Mzbp1uNpQwv2RlJpuw1dSPejXjB0GhCs+f6VpvUOD+d3DWqDIackh/nmICOylM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb0bt6hbf2awbupt7WCt9od5PC40+6Pvb4poaY4oMTfwNRHcx5
	q/31jv0M2SqKfO50ObbuiPZ1ReAVQBiF1qzv8U2THIJ3z80w5RxRrveJjU6TO9PURJBQXWvNix6
	quMtQTJ3LMnSDnRe4B+WEnNKda7XRYXQ=
X-Gm-Gg: ASbGncs58iMvdDCbMGsR6BlWoQ1Qwu9aA9jKxRCkFhLMvuSa6G53/ZFw1oB8k0KpqJT
	drxyF/0yplThnA/xUGJVdAziy9TPWtMUyapYTosNsQSIqUnmAKzZtNPnJS1e9N2LWLlVxODgZVk
	pBvMnVr9V+gKSyz6gp9ehGFjgp9mxVZ7IT05zSh3YWzKTqX6soNuA36zqs/47EKU/xVj3/TFLAY
	Wv3zF+PyVswij8kPK1GTOU=
X-Google-Smtp-Source: AGHT+IFB9jLAlImggz/z83GEjTovbKEndJ217lGWmvQWs/n8zr01hDObpGbwsTRZOhpk6ZZXkE47cT3x3Xd/JQ36DC4=
X-Received: by 2002:a17:903:19e8:b0:267:776b:a315 with SMTP id
 d9443c01a7336-267776ba382mr47397585ad.32.1757968106886; Mon, 15 Sep 2025
 13:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
 <20250905164508.1489482-5-mykyta.yatsenko5@gmail.com> <c67790c49ae9ce4e1f34df324ab0b217ab867f03.camel@gmail.com>
 <ac73378d-290c-4ab0-a604-6de693ce6c6f@gmail.com> <CAEf4BzZBRkqb0VQM1ejV=O=HKPi3NL4yK+=_PGeWezpgLb1vQw@mail.gmail.com>
 <bd078587-04a8-4573-bb5d-117196677468@gmail.com>
In-Reply-To: <bd078587-04a8-4573-bb5d-117196677468@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 15 Sep 2025 13:28:12 -0700
X-Gm-Features: Ac12FXyOIj-zxCOAo8hP9gHqnEcCheTFAP4NIgQE0efbNsOJ0_bQohnrWSiuSqs
Message-ID: <CAEf4BzYV4TdRViitoJ2QvyJYozaD6tSNmkJaNWRGkCEFg1qjOg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf: bpf task work plumbing
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 1:20=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 9/15/25 21:12, Andrii Nakryiko wrote:
> > On Mon, Sep 15, 2025 at 8:59=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> On 9/6/25 00:09, Eduard Zingerman wrote:
> >>> On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:
> >>>
> >>> [...]
> >>>
> >>>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> >>>> index 3d080916faf9..4130d8e76dff 100644
> >>>> --- a/kernel/bpf/arraymap.c
> >>>> +++ b/kernel/bpf/arraymap.c
> >>> [...]
> >>>
> >>>> @@ -439,12 +439,14 @@ static void array_map_free_timers_wq(struct bp=
f_map *map)
> >>>>       /* We don't reset or free fields other than timer and workqueu=
e
> >>>>        * on uref dropping to zero.
> >>>>        */
> >>>> -    if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE=
)) {
> >>>> +    if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE=
 | BPF_TASK_WORK)) {
> >>> I think that hashtab.c:htab_free_internal_structs needs to be renamed
> >>> and called here, thus avoiding code duplication.
> >> Sorry for the delayed follow up on this, just was trying to do it. I'm
> >> not sure if it is possible
> >> to reuse anything from hashtab in arraymap at the moment, there is no
> >> header file for hashtab.
> >> If we are going to introduce a new file to facilitate code reuse betwe=
en
> >> maps, maybe we should go for
> >> map_intern_helpers.c/h or something like that. WDYT?
> > no need for new files, just use include/linux/bpf.h (internal header)
> > and kernel/bpf/helpers.c or kernel/bpf/syscall.c (whichever makes more
> > sense and contains other map-related helpers)
> Thanks, I've just sent v4 without this. Will include in v5 or send
> refactoring in a separate patch.

I'd suggest a follow up patch with more refactoring, let's give people
a chance to review (and hopefully ack and land) v4 as is, thanks!

> >
> >>>>               for (i =3D 0; i < array->map.max_entries; i++) {
> >>>>                       if (btf_record_has_field(map->record, BPF_TIME=
R))
> >>>>                               bpf_obj_free_timer(map->record, array_=
map_elem_ptr(array, i));
> >>>>                       if (btf_record_has_field(map->record, BPF_WORK=
QUEUE))
> >>>>                               bpf_obj_free_workqueue(map->record, ar=
ray_map_elem_ptr(array, i));
> >>>> +                    if (btf_record_has_field(map->record, BPF_TASK_=
WORK))
> >>>> +                            bpf_obj_free_task_work(map->record, arr=
ay_map_elem_ptr(array, i));
> >>>>               }
> >>>>       }
> >>>>    }
> >>> [...]
> >>>
> > [...]
>

