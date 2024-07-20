Return-Path: <bpf+bounces-35139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA01D937EAF
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 04:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934471F22007
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 02:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11C06FC3;
	Sat, 20 Jul 2024 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6IM0uM3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD00C3D6D
	for <bpf@vger.kernel.org>; Sat, 20 Jul 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721440834; cv=none; b=XOJxWy/hRHTD+yMe13IUemcC1giW4X+dP+uRfWB3iu4/RQpnSUNILfpgkhGxml5aMC9Qb2g6982khE+2oaOtcH8RSn/YrpQ01ELJh58JK9dEcMVwMKVKfLHdGNMMDQZZ8vr2efMnHruBPQL/EvdffEFRTlIQ72RpJjwl+Ee7hHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721440834; c=relaxed/simple;
	bh=W9Wyn9IkBqsCH5HFCoMVrJKRL2CuGjPIr9ifISudcIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8YkF2F8A1DtLvEG5vMjjX766Zv0Lz/IAWgj3NmnKsFTKV7aT7ZN6wpd3scfccZjdOBaa72i5V0GQnOMOq6xp4RA9UiAq3f4mN2WmkFmEIuVi2qiGTAjVkFd+AzBj8fB0MQJPf0RMCOhKj1JyEoaTL3PiUETpGZBWKZ7ncJuFR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6IM0uM3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36799fb93baso1167354f8f.0
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 19:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721440830; x=1722045630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gseY9Agfg3MTsSrbU2gcWcYgPFV+g0RpX+IKAljJqEI=;
        b=J6IM0uM3cYyDu9xfd+E7CwfeGk62qcaNZlXyWEmhJu7J8UPKrGG95bi9phzruCPH/1
         e9gUa7LnA1HA5cmRUXA3ya6S/pcv9FwZT1gPUq/wnj9EGjODUldyJNBgIvX9M8Hfd5LN
         RTsfmA4OTufODSRF0IUXuLKPZ8mO8rcHO6Hq3VtC+0Lwlrkr80RxrB2Z4Rhei6NOTkUO
         9tGhQrmB/ciuGihRmdQeKbpHjiLnW0x90vY6aXrOMBGDTcps7UTMq2es7ml+Eq1dBL1g
         XefBvNh7Rwsm3bAsUMd/YDZG4zSl/Orv1xVB0w6m+aNLSBDv/L0gYa0VMk7i9WuEAhbE
         Nrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721440830; x=1722045630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gseY9Agfg3MTsSrbU2gcWcYgPFV+g0RpX+IKAljJqEI=;
        b=rFLh1x+SoO0tCY0LsSVliziajYod2e9Xzf4Rk/0Ds50jLx0WS7RtlEBapv5zOg1NN6
         WLaVN0qToG7QA9oUGqMyAvq0yztLHdQ93IhTHDHdBNs+ZVEQT2XyF37cu2r6Z7sOWSnM
         xunxvESys/6D18Fk0PF0sJS3lcWKodXevrm42t91C04mFNLuti1dWAYnZKF1hFcNscqD
         kutIhLqVTohdO7F/ZzooxtZSJnJmKrIaO99fcEXhizrxu/Hgk000I3B7ZgR+aZ8EFLzG
         FIfKagrgHyN4EVV1FwKWzic6ExJPJKQWpJthSN5h0NxWH9y89WiCPT2iX1sMCbxe8+lc
         Psiw==
X-Gm-Message-State: AOJu0YxYIAG+8L3hDVclFx9jqOidpueuOwJfSz5sjfmkaZVu6M/83M81
	E1m+maZ8eEFZzSkxU4QM+6bb2pqEiHL4yffZ/P9VJwR3mOQ6HN4wr2E7CLAYGfSt3OfvIaJsgKm
	2KrjpKPGpW+We5VdbDPjizjuHb7c=
X-Google-Smtp-Source: AGHT+IENCJmivACm9Dw/yMEOpOLiPrM9Sm8FunWBlQjWxS3PjUBwrkkVbpDq6eQD6ajKAKgdJRMYfjqMwLzbsSftr3A=
X-Received: by 2002:adf:f646:0:b0:367:98e6:362b with SMTP id
 ffacd0b85a97d-369bb2e95acmr129023f8f.42.1721440830006; Fri, 19 Jul 2024
 19:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715230201.3901423-1-eddyz87@gmail.com> <20240715230201.3901423-3-eddyz87@gmail.com>
 <CAADnVQJ7MAtt-EZLorjuyhoOFijyff7tNDy4-up0L6pjnrZHvg@mail.gmail.com> <b660e0becf9b629a4d236ec5c03b8cc0dcdc2502.camel@gmail.com>
In-Reply-To: <b660e0becf9b629a4d236ec5c03b8cc0dcdc2502.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Jul 2024 19:00:18 -0700
Message-ID: <CAADnVQLp=NVoPPn0_mUvQEVuXMr6YB-WmY0pQoFMrOY=+H2Ydw@mail.gmail.com>
Subject: Re: [bpf-next v3 02/12] bpf: no_caller_saved_registers attribute for
 helper calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 10:34=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2024-07-15 at 18:51 -0700, Alexei Starovoitov wrote:
> > On Mon, Jul 15, 2024 at 4:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > @@ -21771,6 +22058,12 @@ int bpf_check(struct bpf_prog **prog, union =
bpf_attr *attr, bpfptr_t uattr, __u3
> > >         if (ret =3D=3D 0)
> > >                 ret =3D check_max_stack_depth(env);
> > >
> > > +       /* might decrease stack depth, keep it before passes that
> > > +        * allocate additional slots.
> > > +        */
> > > +       if (ret =3D=3D 0)
> > > +               ret =3D remove_nocsr_spills_fills(env);
> >
> > Probably should be before check_max_stack_depth() above :)
>
> I thought about it, unfortunately, that would be a half-measure.
> There are two places where verifier reports stack depth errors:
> - check_stack_access_within_bounds() checks for access outside
>   [-MAX_BPF_STACK..0) region within one subprogram;
> - check_max_stack_depth() checks accumulated stack depth across
>   subprogram calls.
>
> It is possible to move remove_nocsr_spills_fills() before
> check_max_stack_depth(), but check_stack_access_within_bounds() would
> still report errors for nocsr stack slots, because
> check_nocsr_stack_contract() and check_stack_access_within_bounds()
> are both invoked during main verification pass and contract validation
> is not yet finished.

Agree that it's a half measure, but it's still better than doing it
after check_max_stack_depth().

We can also allow check_stack_access_within_bounds() to go above 512
for nocsr pattern. If spill/fill is later removed then great,
if not then it's not a big deal to go slightly above 512 especially
considering that private stack is coming in soon.

