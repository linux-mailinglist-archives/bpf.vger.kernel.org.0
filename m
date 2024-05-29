Return-Path: <bpf+bounces-30858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7464C8D3D22
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 18:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC811C21764
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 16:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07C1187322;
	Wed, 29 May 2024 16:54:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CCC1C6B2;
	Wed, 29 May 2024 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717001666; cv=none; b=UlS3OmLxOsggF7z4IuDo1/nbK0nqbeCNAWKRvpG9nGibEFXvK9B/LFAZLed0c2Xi+A+NRHo3izL0Vjg68f/OVz/kJTlWsAV8tIcmLc1cONZLUZnEUMWM4LoqGYPrNhtOF+gd4ErVEdCEp6dT5kejLdN2iGxSniDL8ng0ENTgvwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717001666; c=relaxed/simple;
	bh=LAl8vHzfRbppB/pNLfLE/513EmF3jGEalkh5FEUirqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDbCSbUWFX1LAjYVPltKC3BSqQLL1Mtz4FggAtJ9lrmy6WMPMfxwDG+6TqVmLxsFbzMjCQfERhMss3A67RUCMN1x2yh3zD86UYaQC897eMLa40aJHkbYpNdN3s5Opk7D9OaePSlfafJfEBIwQNAp7/Eqdjy9Ua+qe9siwga42Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2bf59381a11so1986457a91.1;
        Wed, 29 May 2024 09:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717001664; x=1717606464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWI2NSpe+7WLerE4yFBKsFEJGp0TLAv3d84f3/3z3NA=;
        b=SU7aaCp5oHVgzxCBIgBR8wOi35ro2RItX5fsNkckcLwhr1k2B4LunKWTxnzuJOgwrg
         4LdTDhlMtggUlUSnldyRDRKehF/Z8/QHta7RGpPMUvQMB5OLIO2/0oJ78dkzgVRforlC
         sBHQdLRdKIg1buFUdXkKbxcVucuxL1gKKFqXvmmeDFpaYQoMNYwwzCKxDNPPG69IawAR
         sP0g9Jm8fCV4IcUw8pl3bnoA1uMa4FzVkjsV0ltEhKnq49QI/9XM/xDo00LJZ3MQihX2
         ig6gkgMUZc149uswIjgbmGz+OAdHWfBeBEv3YVrt3jPcdwUXQgm2FI+VB06hl0sAYpje
         pYsw==
X-Forwarded-Encrypted: i=1; AJvYcCXf2A/I0PfRfz+j4PbSGwhJI7J0iJ9rPWSBfAgJviHjMYCl2o9QzSmtlMdg+1H4p3+v2N70QgXOgSo9MpI9bDLnLEEH6YQai8fmPAKlVSLueW2lYSLZ6wyQvjdeqq9TykwL
X-Gm-Message-State: AOJu0Yyt3S036nUYAavFH5Dedw1PzueAfAQ3cyCo9zlrtgaSAezZsi/R
	sncCHrZYLOQ7UUQD8CaxOCp7ePlc0A5K1O+bzMwVXGg+imwNSHu8T8xY4gYXigyal8hLLUdybw+
	T/ecH0x5cjQScSX3YjFO+VGY1PfY=
X-Google-Smtp-Source: AGHT+IGEmPeOuMcdoDkBlv8Mys5lgspI2S4rqBjz/+agGh7fGyxt8IHBR+NFxhATNgVAXKiTMD7CvbjWQk6m/bg2CyE=
X-Received: by 2002:a17:90a:a409:b0:2bf:9981:e0bc with SMTP id
 98e67ed59e1d1-2bf9981e16fmr9700999a91.27.1717001664337; Wed, 29 May 2024
 09:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529065311.1218230-1-namhyung@kernel.org> <Zlbn3DOGrzHlw95h@krava>
In-Reply-To: <Zlbn3DOGrzHlw95h@krava>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 29 May 2024 09:54:11 -0700
Message-ID: <CAM9d7ci0g+ObA7w-tXU9cyjzRUFgXjZ4b9Atx2+oV4Anhraeyg@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Allocate bpf_event_entry with node info
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org, 
	Aleksei Shchekotikhin <alekseis@google.com>, Nilay Vaish <nilayvaish@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Wed, May 29, 2024 at 1:31=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, May 28, 2024 at 11:53:11PM -0700, Namhyung Kim wrote:
> > It was reported that accessing perf_event map entry caused pretty high
> > LLC misses in get_map_perf_counter().  As reading perf_event is allowed
> > for the local CPU only, I think we can use the target CPU of the event
> > as hint for the allocation like in perf_event_alloc() so that the event
> > and the entry can be in the same node at least.
>
> looks good, is there any profile to prove the gain?

No, at this point.  I'm not sure if it'd help LLC hit ratio but
I think it should improve the memory latency.

Thanks,
Namhyung

>
> >
> > Reported-by: Aleksei Shchekotikhin <alekseis@google.com>
> > Reported-by: Nilay Vaish <nilayvaish@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> > ---
> > v2) fix build errors
> >
> >  kernel/bpf/arraymap.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> > index feabc0193852..067f7cf27042 100644
> > --- a/kernel/bpf/arraymap.c
> > +++ b/kernel/bpf/arraymap.c
> > @@ -1194,10 +1194,17 @@ static struct bpf_event_entry *bpf_event_entry_=
gen(struct file *perf_file,
> >                                                  struct file *map_file)
> >  {
> >       struct bpf_event_entry *ee;
> > +     struct perf_event *event =3D perf_file->private_data;
> > +     int node =3D -1;
> >
> > -     ee =3D kzalloc(sizeof(*ee), GFP_KERNEL);
> > +#ifdef CONFIG_PERF_EVENTS
> > +     if (event->cpu >=3D 0)
> > +             node =3D cpu_to_node(event->cpu);
> > +#endif
> > +
> > +     ee =3D kzalloc_node(sizeof(*ee), GFP_KERNEL, node);
> >       if (ee) {
> > -             ee->event =3D perf_file->private_data;
> > +             ee->event =3D event;
> >               ee->perf_file =3D perf_file;
> >               ee->map_file =3D map_file;
> >       }
> > --
> > 2.45.1.288.g0e0cd299f1-goog
> >

