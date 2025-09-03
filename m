Return-Path: <bpf+bounces-67366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6ACB42DB2
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 01:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6459D565AB2
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 23:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029F62EC573;
	Wed,  3 Sep 2025 23:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4fj7CYq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354DC288D6
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756943650; cv=none; b=Uag8PxA80pGvJXx8OUXU+gzlM7zRaNgtnI/D6HEoAhtRwBS8Goq9R0ek8+fen2WV2tCcfp715WNlcFdupIDsm3WmgPvjKFGzWL/C2BLdK6E/QCg7ynxZVIeyirXr8Z+qpzyOVLAINs6YPYMXwicnQIXUpzU60h+ZLkNa74mUlsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756943650; c=relaxed/simple;
	bh=wGdS++qIVh90z69ux1JySIF4o5UbJCYEUUxbrv0v9Lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKWGUVMwIdcon1cX6+a+Bm2heAy7svD+KuQ8yDVNPspapR0dX2LAIS3vhkzG5293HNr84KvvYecqfbGxkSaboB437X+A4AX1cqKJFt/6E3YvP/NLcGQ9wHLuXSMF3a+TkyIHtpAYoI3Mf7ypUROK1RiKbEdyxX+Br+vaDq+UIe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4fj7CYq; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-327ceef65afso442298a91.0
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 16:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756943648; x=1757548448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9ckkGRsvv0bM+6Xri5W5j6AEsz8eWxKcVzTnc2ewkE=;
        b=K4fj7CYquyW9LbioCg+yKuceg7oVxTj1p0oyeQdzESCdYCNdp/aUbBoQ4tsw5l/9j1
         PzOTUtVeKvk/GvRCu/iMOqdvBXh4iG3iRviSm2BbPr32d7oOzjcuxHMT46AUB0KFwF6l
         sOn0Eg7hP70aeGMbI7Y935hR4NX4Eww8iyOggSGE4K1hzhfyyCQqAy5MlFAVsZcqLwRt
         egxUQ56Z3zDE7q4eUuFCa9jY6fcegEvrzHs8l5nSbyhWTcAEOZ5mFYLd62+bs5j9UIsJ
         FS0IMSpoAI3HztPwfF5FDRls5ExXlcfbDY0FjHsZos0D9kcuU6bpHlP3ERbsZL6wR+SZ
         /NQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756943648; x=1757548448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9ckkGRsvv0bM+6Xri5W5j6AEsz8eWxKcVzTnc2ewkE=;
        b=c40a8ebRX51iuecmSjefJyyKMQ+MbNF8fZgJmACqIFRfUO836A/HFob3QA6v0ygBvZ
         /Ouxw/TxeuEzkng01dvlWsIsIp+vpMjyt6A0/oYBoiUg0f6ybLKWLORHzb0JNYypXvwH
         fIj0qyFEueVqkkgbWVQmjuCl1Bd08qOuzSaL/R8Gwrn2FuDl7OmpvwW43AtvWyONhFMv
         4UHOZ5MmyMPeS6MT9Ygya46o0U4S7p+yxQDPKOlDF9dOchtopQ39MstNPmW5qEeu0FNd
         ijqrvZ+ArXiHmsBnBwtF2XohyDTuNrZHXIbmGm8brC9UmV6tbkzKO3BIJ4UEwACwSrKv
         Fgkg==
X-Gm-Message-State: AOJu0YxwRtZ4dMw4kIbqHnWfLjSfIysQIz1K/h0b8VhviwmXN5EgN+2y
	ZhXkWtbJZj+wNKMeQZ6w7vJwaf5cj9lKIqL8kPWAWAvbHZ7N8wYeYbzjXdt1/CcMD3O5npYs+yM
	1G7HC8bdCXpqxBSUvYaFnQCvUxToj9VU=
X-Gm-Gg: ASbGncvJ2VpiRvQPkPhAEr9MgidAeMarMhjgnAbBTJteHTXJj4wKGDNAFOzevHoZrhO
	0hXByan8zIJqe/VW3Aip8Ayenti0J3IqSDg847L7B3aogNIjys+6wqEBheMourDIpbqYD+phRPd
	9D+vixa+dunuOHL295vEVvn90ZDS7olyxDFXLETbbFGkrCaWXCLlKYaIsmUsPa1gutUhtX4I0ue
	EL6WcAjw4Eobj5VdKCQv1w=
X-Google-Smtp-Source: AGHT+IFDBgFIRrBQ4+GCler/FFkUzNk45hG0lYBlnw5as2aGmC9n18hmi9Tqi8MNsEsACLjDQUEWP8ajvpSYCT2xJU0=
X-Received: by 2002:a17:90b:2245:b0:32b:90a5:ed2c with SMTP id
 98e67ed59e1d1-32b90a5f1f2mr1261339a91.20.1756943648295; Wed, 03 Sep 2025
 16:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827164509.7401-1-leon.hwang@linux.dev> <20250827164509.7401-3-leon.hwang@linux.dev>
 <CAEf4BzaUw868nNG3ngMci4fLPDGsaffQ-O3YrPOEo7N5QEkM_w@mail.gmail.com> <DCJ8H98X6UL4.3O75SJOM2WWRG@linux.dev>
In-Reply-To: <DCJ8H98X6UL4.3O75SJOM2WWRG@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Sep 2025 16:53:53 -0700
X-Gm-Features: Ac12FXwg8YTGYgpE0lvp9j-IWowIQoLX7W8WOGvJYCWHCi_9N_AjLKNOh2UT5w0
Message-ID: <CAEf4BzZOVtHu6NMFpEToC5C_Rf1qZ=HLqN5UntG-+PxG2dOn5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/7] bpf: Introduce BPF_F_CPU and
 BPF_F_ALL_CPUS flags
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 7:27=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> On Thu Aug 28, 2025 at 7:18 AM +08, Andrii Nakryiko wrote:
> > On Wed, Aug 27, 2025 at 9:45=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
>
> [...]
>
> >>
> >> +#ifdef CONFIG_BPF_SYSCALL
> >> +static inline void bpf_percpu_copy_to_user(struct bpf_map *map, void =
__percpu *pptr, void *value,
> >> +                                          u32 size, u64 flags)
> >> +{
> >> +       int current_cpu =3D raw_smp_processor_id();
> >> +       int cpu, off =3D 0;
> >> +
> >> +       if (flags & BPF_F_CPU) {
> >> +               cpu =3D flags >> 32;
> >> +               copy_map_value_long(map, value, cpu !=3D current_cpu ?=
 per_cpu_ptr(pptr, cpu) :
> >> +                                   this_cpu_ptr(pptr));
> >> +               check_and_init_map_value(map, value);
> >
> > I'm not sure it's the question to you, but why would we
> > "check_and_init_map_value" when copying data to user space?... this is
> > so confusing...
> >
>
> After reading its code, I think it's to hide some kernel details from
> user space, e.g. refcount, list nodes, rb nodes.

we don't copy those details, so there is nothing to hide, so no, I
think it's just weird that we do this, unless there is some
non-obvious reasoning behind this

>
> >> +       } else {
> >> +               for_each_possible_cpu(cpu) {
> >> +                       copy_map_value_long(map, value + off, per_cpu_=
ptr(pptr, cpu));
> >> +                       check_and_init_map_value(map, value + off);
> >> +                       off +=3D size;
> >> +               }
> >> +       }
> >> +}
> >> +
> >> +void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
> >> +
> >> +static inline void bpf_percpu_copy_from_user(struct bpf_map *map, voi=
d __percpu *pptr, void *value,
> >> +                                            u32 size, u64 flags)
> >> +{
>
> [...]
>
> >> +}
> >> +#endif
> >
> > hm... these helpers are just here with no way to validate that they
> > generalize existing logic correctly... Do a separate patch where you
> > introduce this helper before adding per-CPU flags *and* make use of
> > them in existing code? Then we can check that you didn't introduce any
> > subtle differences? Then in this patch you can adjust helpers to
> > handle BPF_F_CPU and BPF_F_ALL_CPUS?
> >
>
> Get it.
>
> I'll send a separate patch later.

separate patch as part of the patch set to show the value of this refactori=
ng :)

>
> Thanks,
> Leon

