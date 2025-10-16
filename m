Return-Path: <bpf+bounces-71153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C85BE56A2
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 22:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64ED54E6DE0
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2902A2DFF1D;
	Thu, 16 Oct 2025 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuE1nlka"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381CB2DCC08
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 20:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647176; cv=none; b=BofXxW+qhVrSgvN5UxDaetNO6ahbWijpX9f71AZocX6tU/sThtY5SDkYzggPVDNaBnv9cPG4v6xwVMux4ZjrLGrV4NPrVyIq4VzxqXNN9+upccn9qRpfuPSJ0CFqw85kOxDWA1TEZ1Je8X18gIllC33h4V8L8Jb/h9WxPix7sY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647176; c=relaxed/simple;
	bh=j47gUxbffwQzSI5QkRAi1UGxgKVvkhYsy8R9Lk2cIp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bg42g+hVpTuAWawJFyn/SLuSxpfVdAuee50HKznrQnREuA5L7ET/+UntvQ7xtZkvdv3UPAUufxbPPUHBJ/q/z3Vl953DMMKdzMQ0vwH5e06BK2r3YPnKWY9aeQzywx0Rn2NtMbQOwpK643U6J9xMG3hfZ4EV+TMhxcupXgtgRak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuE1nlka; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33ba37b3ff7so1140451a91.1
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 13:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760647174; x=1761251974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsEecsSQDVQd72weWcRmXLR+hYEbzg7jxqkKrhdHLo8=;
        b=MuE1nlkaMBgUExM+2ri3mzDg0HeqleVSO5rzkIiI51vVivw8OR8Dl/jtYYRRJYuOyY
         92kOxdZA5ZBR+9KXQN2AF7OhzphkmOBNFE2CBWkDusrQnNwSyLxjC4XzJSXT4Ws9nPii
         RrVOfXLmp7np+HzkqUw+qs2BWN/SvTOXUJKK/lA1s9PyUp+Z7jcVuQpWoZLA36KFJP+t
         uN6WJNWQIDl1xLgDPiy3DO65xrEQPv/xijIHEPd+pbpDbNUCZhyMJCIJ9cICrFIRkeQ9
         eWgWIjSIAh5KHkJxq2asnlVDXevBqgZdLtj2OHLSuAHtlyGJQ1xbx7PCk3Izz9Jq9uZb
         fKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647174; x=1761251974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsEecsSQDVQd72weWcRmXLR+hYEbzg7jxqkKrhdHLo8=;
        b=IhczC6u0dYy7HiDAYSSad8BAblSZ9zW0NbDKcsKFIys4pM7z+gIO9B4/aekWLcNtlj
         2Fiyx9z1CK57aCJbQhUP0W1/LjtLb6KPZ1BfdEwA4xQOR4po5KBXXmbFSiY2iftUkBVE
         dh1w2DoqWQMy/Xwo2zZGb0AfK5qo6DGLY4SJAHAdki0CXK+VtDJ3eBNVda0aEbxqMKNW
         cqA0HJcZx9iIN26Ahk/iyf8mfy93u375jx3M46/3HPQlIRCgFd1KyoikC2Qo62tvfhPG
         BY69kOQ1yx3WTxR4K+kEnfWy/CSYMTkiPhqLzRrmvdI8WqOixf+gMeoNy8rQSEU+pkPs
         nsNg==
X-Forwarded-Encrypted: i=1; AJvYcCWtju6RfrfEvn0U3uDSg2cMcmLBDtmlu4Fe3MPu8syE8V9ORr60rNKMJz4erg5wQb7/dVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlJpq1Ytzud+mbSL/Lho3dDHr92xB7rZIfCHn3GR4owD5kduH5
	MW2xK4PHg0s/hkHzyovogS6JSRemn35dI5fsWRrvmWxNUwDgLtoFDZkzaqa8U82t+kH4crM3z4f
	8yx7fOgHlVexq9VBqHgMl7wjJ6UkxjMg=
X-Gm-Gg: ASbGncuV2W/Qwnsct9k3hQmYgORfW4XvjPovZKGG/OTVpzXZdQAny3NIMd3wy8JrnUT
	0d4wMnG0aHQhuE0xpbFduWm0U/keFO0v5QTth0qMxFYt5fbzkl29TD8yMi0A3aEjZn+wISCbZA1
	jBHu7Pv9nrUHnM1PLjEiI3+koj9u4y0l3NDC6NnIP20HN/samEizPlM9x8xw3UWZZaZVbQudV3F
	uV7VPjtFksDxOAToIla6iDWMxlQHRAYKMr0LlWzp2XfO3kLI+FjqjySIAM/LUmjrafovAJuiV8c
	ai+U7YWtOfU=
X-Google-Smtp-Source: AGHT+IHDr5J0KFk161wPAYc7kYj7KAxZHJ299Vu5BgTI/wRioKfbYD47CRXPhpJbNq7ELZ17QmNTDJWYHON81DsIz/o=
X-Received: by 2002:a17:90b:54c6:b0:32e:dcc6:cd3f with SMTP id
 98e67ed59e1d1-33b9e28a808mr6232546a91.14.1760647174299; Thu, 16 Oct 2025
 13:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014100128.2721104-1-chen.dylane@linux.dev>
 <20251014100128.2721104-3-chen.dylane@linux.dev> <aO4-jAA5RIUY2yxc@krava> <CAADnVQLoF49pu8CT81FV1ddvysQzvYT4UO1P21fVxnafnO5vrQ@mail.gmail.com>
In-Reply-To: <CAADnVQLoF49pu8CT81FV1ddvysQzvYT4UO1P21fVxnafnO5vrQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Oct 2025 13:39:20 -0700
X-Gm-Features: AS18NWA45dPZ_Bqm8aVj24uKxev9XFt4-GQ7iuJ9EiK13dkTykni87M8kGxIHSA
Message-ID: <CAEf4BzbAt_3co0s-+DspnHuJryG2DKPLP9OwsN0bWWnbd5zsmQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/2] bpf: Pass external callchain entry to get_perf_callchain
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 8:02=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 14, 2025 at 5:14=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Tue, Oct 14, 2025 at 06:01:28PM +0800, Tao Chen wrote:
> > > As Alexei noted, get_perf_callchain() return values may be reused
> > > if a task is preempted after the BPF program enters migrate disable
> > > mode. Drawing on the per-cpu design of bpf_perf_callchain_entries,
> > > stack-allocated memory of bpf_perf_callchain_entry is used here.
> > >
> > > Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> > > ---
> > >  kernel/bpf/stackmap.c | 19 +++++++++++--------
> > >  1 file changed, 11 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > > index 94e46b7f340..acd72c021c0 100644
> > > --- a/kernel/bpf/stackmap.c
> > > +++ b/kernel/bpf/stackmap.c
> > > @@ -31,6 +31,11 @@ struct bpf_stack_map {
> > >       struct stack_map_bucket *buckets[] __counted_by(n_buckets);
> > >  };
> > >
> > > +struct bpf_perf_callchain_entry {
> > > +     u64 nr;
> > > +     u64 ip[PERF_MAX_STACK_DEPTH];
> > > +};
> > > +

we shouldn't introduce another type, there is perf_callchain_entry in
linux/perf_event.h, what's the problem with using that?

> > >  static inline bool stack_map_use_build_id(struct bpf_map *map)
> > >  {
> > >       return (map->map_flags & BPF_F_STACK_BUILD_ID);
> > > @@ -305,6 +310,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, reg=
s, struct bpf_map *, map,
> > >       bool user =3D flags & BPF_F_USER_STACK;
> > >       struct perf_callchain_entry *trace;
> > >       bool kernel =3D !user;
> > > +     struct bpf_perf_callchain_entry entry =3D { 0 };
> >
> > so IIUC having entries on stack we do not need to do preempt_disable
> > you had in the previous version, right?
> >
> > I saw Andrii's justification to have this on the stack, I think it's
> > fine, but does it have to be initialized? it seems that only used
> > entries are copied to map
>
> No. We're not adding 1k stack consumption.

Right, and I thought we concluded as much last time, so it's a bit
surprising to see this in this patch.

Tao, you should go with 3 entries per CPU used in a stack-like
fashion. And then passing that entry into get_perf_callchain() (to
avoid one extra copy).

>
> pw-bot: cr

