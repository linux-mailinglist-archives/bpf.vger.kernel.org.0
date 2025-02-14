Return-Path: <bpf+bounces-51526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48119A356E0
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 07:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E693AED34
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 06:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7235F1E0DE4;
	Fri, 14 Feb 2025 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhbmlIxf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBD81DD9AC;
	Fri, 14 Feb 2025 06:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513609; cv=none; b=myCxFgppj5ZrPJnFehIk2HvXstrE2RmrzzTjiK/lIo+sqf8crg6AId/x+Xnw0W4YU5TIsmQa2s2MsKk5p+F09Rd/lT5GW/IrnQnN1LXOV2OTsZ7zV2zLTNkkC/ZXUJDKDtumqikWdeyrFJfBtCc6p9UfOStEWzBQ09/KY506SBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513609; c=relaxed/simple;
	bh=M/IfKMARvy7OnAIimsX8a+OBwC2TBkGTgxztfxP5tq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ox9CNn/9tnh2BIrP/l5FLzdtKEP0Sfq2IwioCi5u9D/SXINbi0PcMCGLKlzs6PVQQggmlPcUxxJU+OCc8Ur2jDXBwZlKjtMxtHGI2OU7UMkCuuWAyhnSkNZ8lFEbEP1LxgsUNH2K7q53Sr5xUCNO6xpv3U/APzMI1aoFJwr8bM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhbmlIxf; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-855183fdcafso77220139f.1;
        Thu, 13 Feb 2025 22:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739513606; x=1740118406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yn7uZ0D3zuGU7f00rV4GEje0dzUp+CwR7Y7WlH/Y0y8=;
        b=jhbmlIxflizcT+c4wc7T3h9qhd5JgDIYU/eQLpSjGFgTFLPgDaGloAxFgxm0rjXfxT
         ZRZOtzou3egjsZM7ZlNnzfl+h6HD+gY5o3mmfOkZpNfPqOc5LpsCjYV66B9RR9f2+Yxg
         eo679Lywktd69RzjYEgNWzbz985T3nFSySUwt5kQiPDmj6VneJNhdCjX/umBkEIpMf3y
         HxKskAaBO09sOwJKoYW9IE91K7PDcWk7nR+B1PkS0G9z9bHI6zLzSWyE41m04XR2OIxu
         v25+CgQ4BPcM/XJzfsI44htdH1nMqjHupUJlVqtB+Ue1J77woupnbMFCUBObuT2+UzsF
         +9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739513606; x=1740118406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yn7uZ0D3zuGU7f00rV4GEje0dzUp+CwR7Y7WlH/Y0y8=;
        b=H8px8Rrw0cqW5rexd0I8/jF5HC4XKJw23/ZQQklbpagcFt64IJXGtfsZhQm4KiIKlb
         IypAnG1weYQpNJ4v+9yKrDTQdQ/oxcdZV53T4DyGyOj9eR+MsJrDh/ui2kSRbSwXhSNG
         E69ZRLgJkkvHCwYqFpg+U/GRBSgiDAQXAgJjLyWE3Zr/4r0oMxp5P+aCIr7VwQZzc87M
         kk0dxzgxGijKBpfz8BGJw/CKjX7klTsxVrwPBNbqs8QTjjgopj6jQn6AzfLjRacxKD4M
         uN2dMXGF0RoDVbfqhowLG/jR30ya3cnFRcZ728o/5gMxFjCNYZk9UM/YCVv6r1jWiV0J
         +Aog==
X-Forwarded-Encrypted: i=1; AJvYcCWQ+0V7dRA4ENCsOEM6rO/FipnJK9URCZ9d5qMzbnvu/wplZdMc0P9QSZlBpFVyiS6QyyaFqCoN@vger.kernel.org, AJvYcCWp6LVYQ2nBoPsVz8VBewHZ1kiJQED95syEl4IWQlBzEzy5mKMns47URFFuer90NvqCedA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxER9Oj9oxlfa03aIlMKhq1Em7Mn7za0peQXQJnRV/bUYMAkDse
	f3OyLjSJEAD0KUUFg2VKz9GMfuopvhVtccFGwsW84QA9zPAz3TQLL6YfmvqHevSwWzA77SynX/w
	5ahMWElZcWyHY0VHkyBsYApragzI=
X-Gm-Gg: ASbGncs6jo1zKd+lQQP9h+MFfV6fRYoO5EfMcDTBkE0O+S7gOxT8zjl3VKTZaYJ5TEX
	Qg6ID6YOlBZLkjrWuHFQTTZApeHgdE14s5gJsoHaNhcKTr79Wa0IdIi9ICU+34UHzI19vPpwo
X-Google-Smtp-Source: AGHT+IFpL+ELt/VhaUBraeQ1dGpMs2U4iDl12lgD59gDyeKHBh6iL2Kv/23JAqvyMdLujjkptV+cgg2kF4oIixUy0Rs=
X-Received: by 2002:a92:d244:0:b0:3d1:48ad:1616 with SMTP id
 e9e14a558f8ab-3d18cc9db8emr32884885ab.5.1739513606076; Thu, 13 Feb 2025
 22:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213004355.38918-1-kerneljasonxing@gmail.com>
 <20250213004355.38918-3-kerneljasonxing@gmail.com> <Z66DL7uda3fwNQfH@mini-arch>
 <CAL+tcoATv6HX5G6wOrquGyyj8C7bFgRZNnWBwnPTKD1gb4ZD=g@mail.gmail.com>
 <039bfa0d-3d61-488e-9205-bef39499db6e@linux.dev> <CAL+tcoBAv5QuGeiGYUakhxBwVEsut7Gaa-96YOH03h57jtTVaQ@mail.gmail.com>
 <86453e67-d5dc-4565-bdd6-6383273ed819@linux.dev>
In-Reply-To: <86453e67-d5dc-4565-bdd6-6383273ed819@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 14 Feb 2025 14:12:49 +0800
X-Gm-Features: AWEUYZnaoZNOJ9KPLKMWbV__ceQ22CwJ1v_QKaf-0LWEjL_6tN_kHOz3VbQDkhU
Message-ID: <CAL+tcoApvV0vyiTKdaMWMp8F=ZWSodUg0zD+eq_F6kp=oh=hmA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] bpf: add TCP_BPF_RTO_MAX for bpf_setsockopt
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org, 
	ncardwell@google.com, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 1:41=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/13/25 7:09 PM, Jason Xing wrote:
> > On Fri, Feb 14, 2025 at 10:14=E2=80=AFAM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> >>
> >> On 2/13/25 3:57 PM, Jason Xing wrote:
> >>> On Fri, Feb 14, 2025 at 7:41=E2=80=AFAM Stanislav Fomichev<stfomichev=
@gmail.com> wrote:
> >>>> On 02/13, Jason Xing wrote:
> >>>>> Support bpf_setsockopt() to set the maximum value of RTO for
> >>>>> BPF program.
> >>>>>
> >>>>> Signed-off-by: Jason Xing<kerneljasonxing@gmail.com>
> >>>>> ---
> >>>>>    Documentation/networking/ip-sysctl.rst | 3 ++-
> >>>>>    include/uapi/linux/bpf.h               | 2 ++
> >>>>>    net/core/filter.c                      | 6 ++++++
> >>>>>    tools/include/uapi/linux/bpf.h         | 2 ++
> >>>>>    4 files changed, 12 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation=
/networking/ip-sysctl.rst
> >>>>> index 054561f8dcae..78eb0959438a 100644
> >>>>> --- a/Documentation/networking/ip-sysctl.rst
> >>>>> +++ b/Documentation/networking/ip-sysctl.rst
> >>>>> @@ -1241,7 +1241,8 @@ tcp_rto_min_us - INTEGER
> >>>>>
> >>>>>    tcp_rto_max_ms - INTEGER
> >>>>>         Maximal TCP retransmission timeout (in ms).
> >>>>> -     Note that TCP_RTO_MAX_MS socket option has higher precedence.
> >>>>> +     Note that TCP_BPF_RTO_MAX and TCP_RTO_MAX_MS socket option ha=
ve the
> >>>>> +     higher precedence for configuring this setting.
> >>>> The cover letter needs more explanation about the motivation.
> >>
> >> +1
> >>
> >> I haven't looked at the patches. The cover letter has no word on the u=
se case.
>
> The question was your _use case_ in bpf. Not what the TCP_RTO_MAX_MS does=
. Your
> current use case is to have bpf setting it after reading the tcp header o=
ption,
> like the selftest in patch 3?

Oops, I misunderstood the real situation of the tcp header option
test. My intention is to bpf_setsockopt() just like setget_sockopt
does.

Thanks for reminding me. I will totally remove the header test in the
next version.

>
> >
> > I will add and copy some words from Eric's patch series :)
>
>
> >>> I am targeting the net-next tree because of recent changes[1] made by
> >>> Eric. It probably hasn't merged into the bpf-next tree.
> >>
> >> There is the bpf-next/net tree. It should have the needed changes.
> >
> > [1] was recently merged in the net-next tree, so the only one branch I
> > can target is net-next.
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.gi=
t/commit/?id=3Dae9b3c0e79bc
> >
> > Am I missing something?
>
> There is a net branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

But this branch hasn't included the rto max feature. I was trying to
say that what I wrote is based on the rto max feature which only
exists in the net-next tree for now.

I wonder whether I need to introduce a new flag like this patch or
reuse the TCP_RTO_MAX_MS socket option for bpf?

Thanks,
Jason

