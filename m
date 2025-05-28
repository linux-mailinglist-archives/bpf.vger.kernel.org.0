Return-Path: <bpf+bounces-59040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3ECAC5E32
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD77D9E8159
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 00:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB40D839F4;
	Wed, 28 May 2025 00:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+1If3ze"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902A3487BE
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 00:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748392097; cv=none; b=NxfBPA9dfm/W1lWX5mFUMg6kQ5okjGvfZLK5tPvMnbXVPtb7yMd25XEfJrXJriMARPe3anU0NDeh/NedgjpoWL+KE0e+LdVX2vsj/KVnevfx2A9ScYOpVDzpVvjRF0nbG/3a5vp1fRPyRJLa5wB+d7L2vI3ZvpiAwcE/l4Sh40g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748392097; c=relaxed/simple;
	bh=/lgHHIOkvIWI+qG+PEVonlbqXP6osS1m3ltdPLSNj60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGMhfyyVIVFwVu1oo0xBRTPLI/IKOf6HeDtTObRWjKelti8OXTpSNwsMbIcJLY9ANWS2WIRbMFyl3BYeCIUZjDMKbs68Kzrq5O1C8Zg/nKSbAYp2FyOopUe46WNsPYMpSz4nu/GZxVuE7h3gMm5sZFNokotHLzZEogE2reEdN44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+1If3ze; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ad891bb0957so204220066b.3
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 17:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748392094; x=1748996894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UbkznIz+VnahHAIIK9MLoFCeuAmNRpum1t0dHH6jR+Q=;
        b=c+1If3zewmQU/htYfCNM/wwapLdQgQ2qyuOfSj/zQQB5/0DlnnOm7pKfz1nYpiB4JC
         pgeKmH6E5zpJC/HwzrKvXaTwkUy+8a9FXueK7yR351Wm0zc2xr4S6qc+inSdp6uke3lw
         tgJt3YsT9EVGyBNyAlNXw9UOACkhQzCDBq3LC9AEpuaBY8ROSFExA/8WAwdNf2WyP/oO
         x4uXmliEKo5eCVopnUOfLPSu0gJ0o1ge/ZleCK4XhjutEzDT2cajFmF2zJ+VIW09olUQ
         Ry104WxE8ufYWHXP8/f9sSxl3q/d8zbgI0nwR1a1ledmjSoFIe1bjtDSUuRfJX7YFUYn
         nH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748392094; x=1748996894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbkznIz+VnahHAIIK9MLoFCeuAmNRpum1t0dHH6jR+Q=;
        b=JPwPUW6Wjx2T4NLdowAwslr8rGr7NQQvJ9yJO9/qObluCL5fE1HQ4t+A8G0aSrf/8B
         CVzMHlyFPhJcPqPOGN+LCAK1qBNWlicX1qnGRDcelnzEX3gzNvPqM2utDKNpUoUUPEMm
         rUXCrN+1I9wMW+coPf3y4dOVWIzS41s7cRAsf+tGkBIaliJODBLIE+eD7Cd9LnpnMgI5
         iWxLN1UhT1nas5BLu2g3YsUs5ZZUPbDC3H8wVcyel24OYQ/ADW0xHLJlK9LzGP/KG/O4
         vpkBsZUH6D6IK/PTvvLZsXLxYI740xvpTXh+Fmgq8FLGbhGdWHAjYfElv/bAfQ9LQ/jH
         528w==
X-Gm-Message-State: AOJu0YzCsd5Fy+iCuhsxBtuyZG71x+GU+L677Mn1IDm+FdzpwlOR4p9G
	GSKxPn4vdnfmO9z2Tp391PIL1AUqpd038LFbqu3sDjTOIlQ6d4trvGdfTS56RekB+f93HZrx8dl
	bSzc5BzLXjVlV0UiRhJdctpQ6MeUjiLA=
X-Gm-Gg: ASbGncsw3/bAsvatti7xCWrcmZpXicL/eBVaJP2o7BoxWvNrp3+6M3N82IMyW0nhUI+
	MhsPYdW6xndeWk4Rfzq2dbO+iPgZAza660Au0SKSGTtc/kOIPrZwThjaQiw53owCwUXQrsDm3Hf
	tapW+iTUoUg5fUFVglAvCuEdaNZtUohr3o5NzoitFEooHblHZgIKzWBvelz8/RqdA/sr0=
X-Google-Smtp-Source: AGHT+IH2ebS7V+NoAQxAz4BCA4juCoaWBvA+bxEQ9JjbmnJ1hb85ry87K74fQCUm2q9cqikV6S5CXsF7W/BBlSnZWRQ=
X-Received: by 2002:a17:907:7fa2:b0:ad8:9e80:6bc6 with SMTP id
 a640c23a62f3a-ad89e807bf2mr73706466b.22.1748392093759; Tue, 27 May 2025
 17:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-5-memxor@gmail.com>
 <CAP01T76sCLH8qCrEqr=oYLW3CpbZA-+ifbA3DOCXT93Lk0LN5Q@mail.gmail.com> <m2o6vd4ml8.fsf@gmail.com>
In-Reply-To: <m2o6vd4ml8.fsf@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 28 May 2025 02:27:37 +0200
X-Gm-Features: AX0GCFvzELftal0yZKYZTA7YGPLxJy-aW8X_27da4bKYPKhc_n1tnLPT2XvMVu8
Message-ID: <CAP01T76h+=QCerjcJZy_LE6UgF6Gu1mmfLbi10OJjDRK=JrrpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 04/11] bpf: Hold RCU read lock in bpf_prog_ksym_find
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 May 2025 at 02:15, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> [...]
>
> >> --- a/kernel/bpf/core.c
> >> +++ b/kernel/bpf/core.c
> >> @@ -782,7 +782,11 @@ bool is_bpf_text_address(unsigned long addr)
> >>
> >>  struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
> >>  {
> >> -       struct bpf_ksym *ksym = bpf_ksym_find(addr);
> >> +       struct bpf_ksym *ksym;
> >> +
> >> +       rcu_read_lock();
> >> +       ksym = bpf_ksym_find(addr);
> >> +       rcu_read_unlock();
> >>
> >>         return ksym && ksym->prog ?
> >>                container_of(ksym, struct bpf_prog_aux, ksym)->prog :
> >
> > This isn't right, we need to have the read section open around ksym
> > access as well.
> > We can end the section and return the prog pointer.
> > The caller is responsible to ensure prog outlives RCU protection, or
> > otherwise hold it if necessary for prog's lifetime.
> >
> > We're using this to pick programs who have an active stack frame, so
> > they aren't going away.
> > But the ksym access itself needs to happen under correct protection.
> >
> > I can fix it in a respin, whatever is best.
>
> Are rcu_read_{lock,unlock} necessary in core.c:search_bpf_extables()
> after this change?

Don't think so, in general, it would be necessary to hold the RCU read
lock to make sure the program does not go away.
There is a requirement to hold it to traverse the latch tree itself,
and then for accesses on the prog require its lifetime to be valid.
Except in case of search_bpf_extables (and all other current users),
the prog being found should have an active frame on that CPU, so it's
not going away.

Alternatively, we can add WARN_ON_ONCE(rcu_read_lock_held()) as a requirement.

> Also, helpers.c:bpf_stack_walker.c does not have lock/unlock in it,
> this patch needs a fixes tag for commit f18b03fabaa9 ("bpf: Implement BPF exceptions")?

So far this is probably not a bug because programs run in an RCU read
section already (perhaps it is a problem in case of sleepable ones).
It felt odd to me while looking at the code.

I feel like the rcu_read_lock being dropped and then returning a prog
pointer will be a bit confusing and a footgun, so it might be better
to go with WARN_ON_ONCE.

