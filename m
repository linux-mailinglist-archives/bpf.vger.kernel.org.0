Return-Path: <bpf+bounces-18906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786E38235FD
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3EB2B2385D
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CDE1CFAE;
	Wed,  3 Jan 2024 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACJjIat5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A4D1CF94
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-336c5b5c163so511476f8f.1
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 11:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704311913; x=1704916713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xryLNAnrxpzmTFUBCfZm3vgiW0SRxkTAQX2lt9EK6zA=;
        b=ACJjIat5hUp7bTBz+vEIs8YT/muVoeT5Z595Hltok6SJuidv3OyZD+aALJJdRaFYtx
         NH25UVkFE/uV6sLZduF/til0NxA5vl3/ZmxIxRpzCe2UAw1sUPawWcfD64kHY2niG5xh
         QWT9qqZtYFAwuJScjIiXNTItoMvKlVF0LKZdfuEoN30lCSPaeY3K1IW+9MHBJ849UnTP
         nDBMtTDAXOkAIo9qcpflfX4K/Y2TMVceBrfvafqbef5Lgz+xs6hVrew8V3U0DQ+UZYn8
         egivaqzXMc1zRNhrqjBuzNw1oI7PoloMZxdCU3IZS4rAJ9IhrhLXd1rTFNjQCeLsgh5c
         OrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704311913; x=1704916713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xryLNAnrxpzmTFUBCfZm3vgiW0SRxkTAQX2lt9EK6zA=;
        b=OhudYI3QfcfOKMYwM5lj7FQxIgDi0xzZquafkE7TAT7IM0TP/gOSXCwism4VO1KlT9
         dKwm/Xk6lkPdTrxI0V6sn4MflnnamfC8Tc6Tk1DJjFQQWJLapotct1suKi745NQvXLVB
         cMeUBYZuNSh2RQ8eK6Of2gVBsq7JGZbakrFp0TatXPf6v/7MHRR/KUbgA89wuErEfBPL
         TP8vu2Dr53yygeUZCkrUSEfiUgtWTqMk0P9C47XDSymE7ovDjllM8rtSLzyyzCBCfM0y
         275PlWWhlz7BpCliZwvXwzCcX9IT8Clg15Ce6F+KRHyMlLURgvPq8yzHAq2SB0GglOdM
         V88Q==
X-Gm-Message-State: AOJu0YyaChklXXgJP3VRjDhGdo7pvEQYN8WTHQILpSDYarNCakbAZ9ps
	hB99QR8/trZvpb8IKj1uLpYRgttMz9IADms3VrU=
X-Google-Smtp-Source: AGHT+IEl+Hh16PmqiHtiS4j42YhrV3+HG0tbnmhRhicQ1hpq+lNIFR2pmtqakJW58rLikxIOEhdpnoKUIlgUOGBblyo=
X-Received: by 2002:adf:d1e4:0:b0:336:7472:a40b with SMTP id
 g4-20020adfd1e4000000b003367472a40bmr1070088wrd.0.1704311913135; Wed, 03 Jan
 2024 11:58:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227100130.84501-1-lulie@linux.alibaba.com>
 <CAADnVQ+8GJSqUSBH__tTy-gEz9LMY5pPex-p-ijtr+OkFoqW1A@mail.gmail.com> <f5edeba8-4a17-415f-8c85-73eedc65a99f@linux.alibaba.com>
In-Reply-To: <f5edeba8-4a17-415f-8c85-73eedc65a99f@linux.alibaba.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Jan 2024 11:58:20 -0800
Message-ID: <CAADnVQLk=mJ3MsZo_nXBvOfNycA7Orxn3oacnznZfxK5e5NwMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] bpf: introduce BPF_MAP_TYPE_RELAY
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Joanne Koong <joannelkoong@gmail.com>, 
	Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>, 
	Hou Tao <houtao@huaweicloud.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, guwen@linux.alibaba.com, 
	hengqi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 3:20=E2=80=AFAM Philo Lu <lulie@linux.alibaba.com> =
wrote:
>
>
>
> On 2023/12/28 02:02, Alexei Starovoitov wrote:
> > On Wed, Dec 27, 2023 at 2:01=E2=80=AFAM Philo Lu <lulie@linux.alibaba.c=
om> wrote:
> >>
> >> The patch set introduce a new type of map, BPF_MAP_TYPE_RELAY, based o=
n
> >> relay interface [0]. It provides a way for persistent and overwritable=
 data
> >> transfer.
> >>
> >> As stated in [0], relay is a efficient method for log and data transfe=
r.
> >> And the interface is simple enough so that we can implement and use th=
is
> >> type of map with current map interfaces. Besides we need a kfunc
> >> bpf_relay_output to output data to user, similar with bpf_ringbuf_outp=
ut.
> >>
> >> We need this map because currently neither ringbuf nor perfbuf satisfi=
es
> >> the requirements of relatively long-term consistent tracing, where the=
 bpf
> >> program keeps writing into the buffer without any bundled reader, and =
the
> >> buffer supports overwriting. For users, they just run the bpf program =
to
> >> collect data, and are able to read as need. The detailed discussion ca=
n be
> >> found at [1].
> >
> > Hold on.
> > Earlier I mistakenly assumed that this relayfs is a multi producer
> > buffer instead of per-cpu.
> > Since it's actually per-cpu I see no need to introduce another per-cpu
> > ring buffer. We already have a perf_event buffer.
> >
> I think relay map and perfbuf don't conflict with each other, and relay
> map could be a better choice in some use cases (e.g., constant tracing).
> In our application, we output the tracing records as strings into relay
> files, and users just read it through `cat` without any process, which
> seems impossible to be implemented even with pinnable perfbuf.
>
> Specifically, the advantages of relay map are summarized as follows:
> (1) Read at any time without extra process: As discussed before, with
> relay map, bpf programs can keep writing into the buffer and users can
> read at any time.

Just add this ability to perf ring buf.

> (2) Custom data format: Unlike perfbuf processing data entry by entry
> (or event), the data format of relay is up to users. It could be simple
> string, or binary struct with a header, which provides users with high
> flexibility.

perf ring buf allows any format as well.

> (3) Better performance: Due to the simple design, relay outperforms
> perfbuf in current bench_ringbufs (I added a relay map case to
> `tools/testing/selftests/bpf/benchs/bench_ringbufs.c` without other
> changes). Note that relay outputs data directly without notification,
> and the consumer can get a batch of samples using read() at a time.

performance is irrelevant, since relay is unusable from bpf due
to dead lock issue I explained in the other email.
It's really a nack.

