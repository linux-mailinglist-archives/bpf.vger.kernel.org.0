Return-Path: <bpf+bounces-69644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08123B9CC28
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 02:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE1F3834F0
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 00:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916721D555;
	Thu, 25 Sep 2025 00:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMCK7c6o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434D81C27
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 00:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758473; cv=none; b=i6GQe60Wjxy4QKftW/pqGvYw+txW9Y3eJ/HQpbcavpvyEW3CnUJmJqD9UL5nfFOAJ8FnmZRQ7wDBpJ1IlOLwPmQKFUwLNgg43PcizbiXWi7DxbIN2rREEwMq0MI6lVH0cmfsoi6PaalM3qM5zOSKp5BI69oVhl4oYvajdiBABD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758473; c=relaxed/simple;
	bh=vfqTlBsCykWU2/ICVUpbbBnnZrxFMXPnUnK/cJEJSkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuIEIIH2O6BNCfyn6SYGL8MkO0HnckdyVnNPBnWvxc6D+UUvm3wTcVSb24U7UgxfmDiKLAaI8CsWH2xZnnoVVxPv0B+XYB0QXdxPxWICjTJyg5jkGp1l89EhO5yI12yQnvC8D93MN3gvVCIMaFjESjrBKXFk5Gx4YMURfOvz4Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMCK7c6o; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3306d3ab2e4so445791a91.3
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 17:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758758470; x=1759363270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOOkSAipkXlUEZv41Dc6N7hcKEneGLgQRNGCyM6Wv1k=;
        b=gMCK7c6oHHfcPkLlrgRj9a3n2jMxjbaP0JCOvmOXsVuEj9KFMsC7+THFUSF96vGXxY
         o5baMo1ejuJrddL89q7yeWXKoPv18WiObiI4DFbXapcj+25l0nhI7lnGMaLbjFcc1lgE
         hT/ZWU2UoRHW+R1/aLHYLyCDNFEF2SoEI9ypLOlUZpcqnA1ScwYW8c4s4iTwmZsN3wa9
         rulhXlcWskj/jrC+Dw8RvhLSniWv1g6Y96V7J3XsbrrGR2s+VTpN71S/iebCvAjYLGN7
         GtYcmyQ+Eud20z26KRLdW0qMiGAhLiimoqbKhYdf6FJheenAa1v/qIP59YRDzQw2TMoP
         1+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758758470; x=1759363270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOOkSAipkXlUEZv41Dc6N7hcKEneGLgQRNGCyM6Wv1k=;
        b=BFgkxxYzR2duAlLvNpWyb0ZPHVUt0CAIn5Z1fUeomgNkuaT8gKEVuTy2Mw1Lvp3ooS
         g/Hz7W2USYtDuiKoeL7Ah7su9L5KTRmM3A9UC5yoqvhpqs01CGcigi6IaNA8eHcYcpeP
         rCo5fHWkmJ1/Hrt4Eod9TZ3O9rwkihb4Q7BpFxJVdySkeYqu+zBbu4/Yr2Ymc87jDC3e
         GMDv8lzCs/HwBfBf3zLsVcIj8lyQlELAV2ZXxEEy+ILymT362s+m5X8kFQMME7ALTjcF
         JybAEj/zr8DCUWbXA1LBA345R/9hYzi7KWIAs+KGJoAaCv8s0vZD4yxi79E+hArYLqd/
         WncA==
X-Gm-Message-State: AOJu0YyhTZMeizwVUL25ENpmgfI9ypWmwlkiz6R6bJT74C+iVZjWrbnl
	8jZGUt/KLJitm88mxkdlDY3SKT+JYtrw/OWgiQORg9itfTxOdNNtCcQq/MPPp0KQiy4Zv8osa6W
	61X04K8cMewSG6NEwvpUfnbfo9X/FCZ0=
X-Gm-Gg: ASbGncstwneHA0T0tGLlgBcwa8McoD9vAdkRO3OvxUgl7ABIqvo8PVG/SlQwOo1kIE0
	u3InGvQSPcfGVcRwUWKUFuIuJSTbcO9n2dDemxLgUCAWxxFmljIen3jZ+t1wzmIBsKcFMugjv7h
	bweStFP4LXZlnK6oAQT9+BN+oqs4tmgkCUQ3JHlWAcZK8qJBnT/cZYNHvRDX+4aw6U3aMj9TSE3
	7z1gDnNVg5IILmfIl/SCsZ5vEKRMpgHBw==
X-Google-Smtp-Source: AGHT+IEmC7jztJd9qdlCLLqYQpgzvWm6zcSREndHVRhgCUj1bI+htTA9jEhwcGZGnsn9ULZYPguQ40IPqsR1l9er4s4=
X-Received: by 2002:a17:90b:1c81:b0:334:29f0:a7e4 with SMTP id
 98e67ed59e1d1-3342a2bf175mr1484486a91.21.1758758469768; Wed, 24 Sep 2025
 17:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911163328.93490-1-leon.hwang@linux.dev> <20250911163328.93490-4-leon.hwang@linux.dev>
 <CAEf4BzaRYeT4wzU7uCuYLF-7THnXL2KgbF3kkg-8fLE3phM-5w@mail.gmail.com> <b16183df-2915-4369-a0ae-ea484924ad79@linux.dev>
In-Reply-To: <b16183df-2915-4369-a0ae-ea484924ad79@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Sep 2025 17:00:55 -0700
X-Gm-Features: AS18NWA5tYPqPw9qCALwBtbytqL9JTAsYT5M3cexOOn6LrK7Zze_w3ioL6Xslcs
Message-ID: <CAEf4BzYv6auU970HQ_8VMd-jiNC7ArKRewpSZ1tpCZj4A9WE7w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 3/6] bpf: Add common attr support for
 prog_load and btf_load
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, menglong8.dong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 8:50=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2025/9/18 05:12, Andrii Nakryiko wrote:
> > On Thu, Sep 11, 2025 at 9:33=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> The log buffer of common attributes would be confusing with the one in
> >> 'union bpf_attr' for BPF_PROG_LOAD and BPF_BTF_LOAD.
> >>
> >> In order to clarify the usage of these two 'log_buf's, they both can b=
e
> >> used for logging if:
> >>
> >> * They are same, including 'log_buf', 'log_level' and 'log_size'.
> >> * One of them is missing, then another one will be used for logging.
> >>
> >
> > I agree with the logic above, but I'm not sure whether we need to
> > plumb common_attrs all the way into bpf_vlog_init, tbh. There are only
> > two commands that can have log specified through both bpf_attr and
> > bpf_common_attrs. I'd have those two commands check and resolve the
> > log buffer pointer, size and flags on their own (sure, a bit of
> > duplicated logic, but we won't have any new command having to do that,
> > so that's fine in my book).
> >
> > And then I'd keep bpf_vlog_init completely unaware of common_attrs
> > (which eventually have more stuff in it that's irrelevant to logging).
> >
>
> To avoid modifying bpf_vlog_init directly, one option would be to
> introduce a new helper, e.g. bpf_vlog_init2 or
> bpf_vlog_init_with_cattrs, to handle the case with common_attrs.
>
> This way, bpf_vlog_init_with_cattrs could be used for BPF_PROG_LOAD and
> BPF_BTF_LOAD, while the existing bpf_vlog_init remains unchanged and
> could be used for BPF_MAP_CREATE.
>
> That would avoid duplicating the log handling logic, while also keeping
> the separation between the two cases clear.

We  are talking about duplicating 1-2 if conditions. One-time thing,
we won't be having any more commands going forward that will allow
specifying log in two different ways. Let's not add a zoo of
bpf_vlog_xxx constructors

>
> > This seems cleaner than plumbing this through so deeply.
> >
> >> If they both have 'log_buf' but they are not same, a log message will =
be
> >> written to the log buffer of 'union bpf_attr'.
> >>
> >
> > Meh, whatever, this is unlikely user error, just error out with
> > -EINVAL or something. Let's not invent "log here, but not here" logic.
> >
>
> In that case, we can return -EUSERS, as Alexei suggested earlier.
>

TIL about -EUSERS, works for me

> Thanks,
> Leon

