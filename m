Return-Path: <bpf+bounces-48090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B580DA03EED
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5220E1885E7E
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546121EC01E;
	Tue,  7 Jan 2025 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUk3bIPF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494A1E0DAF;
	Tue,  7 Jan 2025 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736252191; cv=none; b=c5GRzdks5HQyesQmgC5pk7MPaj98idmogcGK25ggLdJ1mmVnckb8rM6IHJcQEE4huBvVCM2USM9TBSPuKHrun87eAFWiB4Ayc5YqK/h/Xh4QJPMbr3+D8erhtmWGaLmxILgc/Nxk3c8UsLuAjSKQSuMm/13Yo/nxLkgn2WPALko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736252191; c=relaxed/simple;
	bh=Bd/Mz1ZsFzuVF1GvARZd4apNGJyzPz/32LoonyXU8mU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8ykbg0XWdT2SmlqfUhM4xq2QHfrHgcNmWmpOmCC3H4w6YxeIrtXbNfJjPaRYJD7iLAexgO9Lebb3jTp3u1MyDGnv/7crpibQL95HHTSNZrW0N5bjK1eTEqVaNM3EIjiFW5nWTPoJzyu/ahHfpySWNkYrMhaNybaDAwyBzmcrko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUk3bIPF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa66ead88b3so537755466b.0;
        Tue, 07 Jan 2025 04:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736252188; x=1736856988; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aMDvUN0bn8LvCq/dO2IXJIhY7/MF43jvaDflMADuggM=;
        b=SUk3bIPFC1SaE1QUqd9odmsy01lSKffxr1yFkx8KIHtM/xH4vihjc/3fZg9F4OnKdF
         0HaW5vuYVu3lyluiug0oNbGHj+3g/79NUAtE0r/bKbfcarWcSBa0BHXFRvPMun2ZclJs
         0jLf00lfmFY0xgbZJ92/oWzvcqXyXV5brPPJWNOfrRV1vAyl03zx9LGX2+aPtb2IGKpA
         ZAtXKPValXHPnRYiXptI71cs6jH67welndFlhDaavqqecuRzJQBa2njVac7UmGE9hrOw
         mdOLSJAvzppr7NVAw6xWq5qNNAQxjyAUqXYkP2tqpk4o4CBGpFzRTn1Eo9pz1Lf6ujjz
         UpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736252188; x=1736856988;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aMDvUN0bn8LvCq/dO2IXJIhY7/MF43jvaDflMADuggM=;
        b=V/YcoBWl+rKjMLVrVW+2tydSEJUKZiEvT/f4mrE4sztWfec1a3rhLpBpaU4GLiv1I7
         zw6vvxZJlPi6PKo79IWjrJdyLQaVpsyLx6oYo/GywKlVE2OwZsZdegpKZRAdpQYuT2X/
         4btBwjKA2hnMh6/JJ+dP7Pj1+p1ZsZtJTAnVcKnSVYV3E6QbyjhzrX2K6haOZm2Si8Q9
         yZ5CCBPKlbF8aFJU82XqaV1DBQavrlvfVrd+XDvOioR6inm5Ef9JtMXtuUGOIDo3HxvC
         CnZXemq8jK6FnBwsKQhZ92m1SIU0Wz1AV7Fk3uQmZWkLlHVl9b/NY+LX8EN8pOU0JzmG
         ok1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrCXncCQFPcv7j0m4N/ETQ/1pWVNO7Yq7K2mhZn52ybwMNywz51XvhnyBwDT4uQByHmek=@vger.kernel.org, AJvYcCXGmGxo54bJhNrEnlfEW2rvFhZcv4Z3CA10FJfDUimpZJLDmD5EPrK4fiQk3jvFTO7O6uIsvKbw@vger.kernel.org
X-Gm-Message-State: AOJu0YwwC4Tn1xZWInstbli/7aoprHiC6vaxjauNWDpLHt2+K5vgbCoJ
	btzsnGdqVgERhD0bEH536e04ifkGpLj+VthCudOlcxT/XWuOnml7
X-Gm-Gg: ASbGncvQPT1MhHlMhf4LIX3JQYSBVU7qedSz4i6kTBfd9xfUIjK85khs0FZq5FSt2CO
	9FuZ5ZFWJ6HxCF4+hMqrpUjz2Md2cEEyukjlGLUbJBjaNtthwg18LSwDp1IbpmBBSF/b0vrhxDZ
	P3vEDEwkCHIp6iasUvfHkuPVZPWPlhnP8RJPhKVy4JhBxv8NmohLSNE2hfNelWkKBPiLXT2VRm3
	MumUInMz7R/KZZvrnHnaReb7uSeSICYKpxFfbnPEH0=
X-Google-Smtp-Source: AGHT+IH3soO0JU9jw+R+FlinzZrtuhTOEKZT6ZmnfxMnpvjo3BePGcI5v1frWA4eaJleTMxhY0wEkg==
X-Received: by 2002:a17:907:9412:b0:aaf:c19b:728b with SMTP id a640c23a62f3a-aafc19b72c9mr1194727766b.51.1736252187612;
        Tue, 07 Jan 2025 04:16:27 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aaf5d1b602bsm1037318766b.178.2025.01.07.04.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:16:27 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 7 Jan 2025 13:16:25 +0100
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Eric Dumazet <edumazet@google.com>,
	bpf <bpf@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: [RFC PATCH bpf-next 1/2] libbpf: Add support for dynamic
 tracepoint
Message-ID: <Z30bGYeyGQL2UpnX@krava>
References: <20250105124403.991-1-laoar.shao@gmail.com>
 <20250105124403.991-2-laoar.shao@gmail.com>
 <CAADnVQ+ga1ir9XCDxPiU_-eYzKHTQsiod9Sz4_o3XeqGW2rq4A@mail.gmail.com>
 <CALOAHbD+w3niwBojP=-81Wrqj1V9ppLgTfuZjb=AxXjx51MGRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbD+w3niwBojP=-81Wrqj1V9ppLgTfuZjb=AxXjx51MGRA@mail.gmail.com>

On Mon, Jan 06, 2025 at 10:32:15AM +0800, Yafang Shao wrote:
> On Mon, Jan 6, 2025 at 8:16 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sun, Jan 5, 2025 at 4:44 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > Dynamic tracepoints can be created using debugfs. For example:
> > >
> > >    echo 'p:myprobe kernel_clone args' >> /sys/kernel/debug/tracing/kprobe_events
> > >
> > > This command creates a new tracepoint under debugfs:
> > >
> > >   $ ls /sys/kernel/debug/tracing/events/kprobes/myprobe/
> > >   enable  filter  format  hist  id  trigger
> > >
> > > Although this dynamic tracepoint appears as a tracepoint, it is internally
> > > implemented as a kprobe. However, it must be attached as a tracepoint to
> > > function correctly in certain contexts.
> >
> > Nack.
> > There are multiple mechanisms to create kprobe/tp via text interfaces.
> > We're not going to mix them with the programmatic libbpf api.
> 
> It appears that bpftrace still lacks support for adding a kprobe/tp
> and then attaching to it directly. Is that correct?
> What do you think about introducing this mechanism into bpftrace? With
> such a feature, we could easily attach to inlined kernel functions
> using bpftrace.

so with the 'echo .. > kprobe_events' you create kprobe which will be
exported through tracefs together with other tracepoints and bpftrace
sees it as another tracepoint.. but it's a kprobe :-\

how about we add support for kprobe section like SEC("kprobe/SUBSYSTEM/PROBE"),
so in your case above it'd be SEC("kprobe/kprobes/myprobe")

then attach_kprobe would parse that out and use new new probe_attach_mode
for bpf_program__attach_kprobe_opts to attach it correctly

cc-ing Viktor

jirka

