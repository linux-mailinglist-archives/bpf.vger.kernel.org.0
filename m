Return-Path: <bpf+bounces-59333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B65AC84F5
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 01:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4031F4E35E3
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 23:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD2563B9;
	Thu, 29 May 2025 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfFoDOMK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4561AAE28
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748560875; cv=none; b=iyWBzUQ60VtXLSF3ANCsFzIFQGEhzLqzqC5paFapb9Kzl1816Y1WyaEz6h1Dt4QgDTmZlvicGGyIb1f/TaXLPRM5Ox2L3cJ18iiTOJNDLQwQlkj6i4u2dt3cTBHIA4mBOFUTA7LI81Ln8FZcfxh2Y0gaR9SSjBC747LGM6imJFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748560875; c=relaxed/simple;
	bh=MZXk35VJ8Le9CqGjyhGh9Yojgg0lxJHjMlJqlcRjJzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p74qh4CnnLj2cAJWBFSXDGT17tCWrb1zaskKdobD8H3tnmFV6E2AAMy2JznFzsH+c3eW7pmSwKmdbxfkzDFZsFerQA0cobcmt2aSy6acEazDXj0FdMUfbaT+p8yqKQfW3EXM1xRhXPX2hjZ4JNqxGXD/08MSISR2BUnY275Sw9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vfFoDOMK; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4e45bfb885cso908562137.3
        for <bpf@vger.kernel.org>; Thu, 29 May 2025 16:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748560872; x=1749165672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZ3c+Wi2NmVMCqELDsVloOEHC7NYEmV32OBnWDhc4vg=;
        b=vfFoDOMKZY7Joks4oTwrMDcba7MBShiAvdujpZFzlRoMfP9u7MTkGOMDJ7C7DEL8dz
         RtfBBnmoCXC3kwmIivWKbjfeNlEo7rTCN786gQ3x00p9PzL13U9plakVkhE3h458hRel
         2ThqApGt08CSPw3qTTCQTRuK7VGGr92X3HSYyfBWke/jf2ctJ4tAkcUfu12kBXMuUca8
         ADqYgMfzMDqBY6bGoxgopycUi+dUZ23NmzdruzYeVHNHDZKMY1ACwSz0EfKpZfJyR2P6
         kUKfWbIjcbKBmfjUR6+R3sWOb2/OwDVyknYrglXmQNF54aW6eu1PtLwHPD/2dj5yJmJW
         ytFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748560872; x=1749165672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZ3c+Wi2NmVMCqELDsVloOEHC7NYEmV32OBnWDhc4vg=;
        b=e5rW1G4IER3+NKqpeHGkS9Iafiw4pM6Ez2uWt4v8mO5Z7xIbBgQm2yS2S0/B2G8pRg
         aYZZwFplS1bgMsqvBH702n8gvKVTPCM9XqtwBlEauG0edCmn0p/leKSoXz43hxBWYpTm
         SjuVHYLIXDs5MIIPvDs/Km0Wm4hRaaWf4JkHjAvL/PlP4dyA8hG5rDuMTM1yMDgtZi7d
         8ZAcBXOnpbfeRWyfgMExGoUDXLT3S2suEUKD4osuvV2oHw7GuTscvm6qyQ2PirSZeESQ
         eyPQgiV0KfjlTMXl9Fez51qHWg+MkXHK5TVMqeSycLImWTl9QqrtUic4YYITbk2qJkWE
         BAHw==
X-Forwarded-Encrypted: i=1; AJvYcCUtN4YuqRYWfhBQ75HHWOIPQ5nGq2bfkpwRsuFr2suN1XWud1vhTFxN8QZz3SWkQ86A0nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGUZItUjxCjElpV1XXDTmA+ddQGfw41FEgem5qmEg4ya6sz0CN
	FtSP12FvWzNiS8R3Vb7WJxabydGQSjEusgs5C3VySHsfUC85/04aCbrE26mI8T3UJ/GmQ2spK7b
	cSOCgWVTjGiPQM4Ud5RSQxzmZ73JC4sF5nXWGSE8r
X-Gm-Gg: ASbGnctngmhlsxbjzQpp2VE/9F7ZTTcwhfhAM5R3LfZMHciPe9YAb3ViYXBo5Xf7Jpz
	2ku86qbgmDjJgdg4vXxlrVtt2nLdjLfbnmNcA302BrpeF7GxUQ5+8O019h4f4BN8m3+dIFOXYUC
	wf7+x62BLHGDyPL+FGNpoYt3d6UtqyXjYiDjxxLyOCkco4N5XLTV819gFz1yl5nEjA7qlqehbd0
	Q==
X-Google-Smtp-Source: AGHT+IHJIZrfAvpKY/5wr0qNDI7tJLIOAGcHH/s3hT0bGXWqKuDPpcR8PAvDf6R0gNbFcBlmC8YVS8YdBkpjGsynf/g=
X-Received: by 2002:a05:6102:26c8:b0:4c1:9526:a636 with SMTP id
 ada2fe7eead31-4e6e410cc07mr1777490137.15.1748560872289; Thu, 29 May 2025
 16:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-3-blakejones@google.com> <CAP-5=fVn++LYR6PcRMf9wcBooALVHX2y=i_C6cLsDipN2EDsOg@mail.gmail.com>
In-Reply-To: <CAP-5=fVn++LYR6PcRMf9wcBooALVHX2y=i_C6cLsDipN2EDsOg@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Thu, 29 May 2025 16:21:01 -0700
X-Gm-Features: AX0GCFuI08MI_TydsQLHChdJJOb9OX44_XJRJWvHC2fCjLT41nw5dVTKyiiOFDs
Message-ID: <CAP_z_CguNu7KGL+-=WD-8LfZiKaLEe=R=Z6jgtXTr21AzKQNtw@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf: collect BPF metadata from existing BPF programs
To: Ian Rogers <irogers@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	James Clark <james.clark@linaro.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Thu, May 29, 2025 at 10:47=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
> > +               bpf_metadata_event =3D &metadata->event->bpf_metadata;
> > +               *bpf_metadata_event =3D (struct perf_record_bpf_metadat=
a) {
> > +                       .header =3D {
> > +                               .type =3D PERF_RECORD_BPF_METADATA,
> > +                               .size =3D metadata->event_size,
>
> nit: Could we set the header.size in bpf_metadata_alloc to remove
> metadata->event_size. The code generally doesn't pass a pair of
> perf_event + size around as the size should be in the header.

I can do this initialization of metadata->event->bpf_metadata in
bpf_metadata_alloc(). I'll need to do a bit more work in
synthesize_perf_record_bpf_metadata() before I can get rid of
metadata->event_size, because it needs to allocate an additional
machine->id_hdr_size bytes (see below); I'd just have it get the
value out of metadata->event->header.size instead. Sound good?

Blake

> > +static int synthesize_perf_record_bpf_metadata(const struct bpf_metada=
ta *metadata,
> > +                                              const struct perf_tool *=
tool,
> > +                                              perf_event__handler_t pr=
ocess,
> > +                                              struct machine *machine)
> > +{
> > +       union perf_event *event;
> > +       int err =3D 0;
> > +
> > +       event =3D calloc(1, metadata->event_size + machine->id_hdr_size=
);
> > +       if (!event)
> > +               return -1;
> > +       memcpy(event, metadata->event, metadata->event_size);
> > +       memset((void *)event + event->header.size, 0, machine->id_hdr_s=
ize);
> > +       event->header.size +=3D machine->id_hdr_size;
> > +       for (__u32 index =3D 0; index < metadata->nr_prog_names; index+=
+) {
> > +               memcpy(event->bpf_metadata.prog_name,
> > +                      metadata->prog_names[index], BPF_PROG_NAME_LEN);
> > +               err =3D perf_tool__process_synth_event(tool, event, mac=
hine,
> > +                                                    process);
> > +               if (err !=3D 0)
> > +                       break;
> > +       }
> > +
> > +       free(event);
> > +       return err;
> > +}

