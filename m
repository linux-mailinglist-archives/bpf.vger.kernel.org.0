Return-Path: <bpf+bounces-9573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCB57992D9
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 01:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF064281CC7
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 23:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BE07474;
	Fri,  8 Sep 2023 23:33:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167B76FDB
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 23:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87228C433CB
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 23:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694215983;
	bh=HYuAjSiaN2ZFjbpBvyv03JrV5dB/DfEcWmYrynsPdTQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Yu0Tgk0UJqyeSkWNQ2LI0iLQegT6B1IEBMvMwbyMYcWumCkeFsqnV/ZQy5WM59qcP
	 FmPL2Y4CPlDfHCH62HdY+OiG2H9mDEIYomRS9J6ip0pZ87Ad6aQd946bsY7z4DrpU3
	 zeYwRCqQd2lxzL8qF6tPMEkZfMFDuEdlLhvkg892NjkFrfEzt3y8wOKig/hUB9rfUM
	 M98Wc2VziSXoPR2Nl5t+WdeSm0DJ1JaYrBjhwfJPAsAvDjnPxTmh45BqSwky5NtYdT
	 XR9IhodUSh08O7lsUCPyaNBefz5KAsuez5QrLoRhhU2UQQRDSI690nEvlCv5LT2pl7
	 QzdD6JhnT1oCA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-501b9f27eb2so4537957e87.0
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 16:33:03 -0700 (PDT)
X-Gm-Message-State: AOJu0YyTzkJCzTnVAOvvkkEB1HFV2m3prde7ae3U+NbpCgpG+Z2823vE
	DPsvxHN2LWLulzbpfWbf8NOrqHIDki2+seQa698=
X-Google-Smtp-Source: AGHT+IHFQQN96wj6huPKlDNC9I+v8xt5rjzdwNWa7PghR6zq6IhzTfQUK3FKU2h1jl8ipEk55nxwPC5TZUXxRfHcxa4=
X-Received: by 2002:a05:6512:e85:b0:4fe:3291:6b50 with SMTP id
 bi5-20020a0565120e8500b004fe32916b50mr2735044lfb.7.1694215981777; Fri, 08 Sep
 2023 16:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907071311.254313-1-jolsa@kernel.org> <20230907071311.254313-4-jolsa@kernel.org>
 <CAPhsuW4hX95fHZCDYnfzAwK43dbnGJUxHEF3bGdODWe_6MytnQ@mail.gmail.com>
 <ZPsI/4nX7IUpJ6Gr@krava> <CAEf4Bzawf5_uq5bE_O8Y1GqxJhNd_zkOYTnDdPRy3n_0upXn2A@mail.gmail.com>
In-Reply-To: <CAEf4Bzawf5_uq5bE_O8Y1GqxJhNd_zkOYTnDdPRy3n_0upXn2A@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 8 Sep 2023 16:32:49 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4qzim9KDJZUD6-2xA42fr8tgQ9dh7odeAhiym-xsiuVg@mail.gmail.com>
Message-ID: <CAPhsuW4qzim9KDJZUD6-2xA42fr8tgQ9dh7odeAhiym-xsiuVg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 3/9] bpf: Add missed value to kprobe perf link info
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Hou Tao <houtao1@huawei.com>, 
	Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 8, 2023 at 4:22=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Sep 8, 2023 at 4:44=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
> >
> > On Thu, Sep 07, 2023 at 11:40:46AM -0700, Song Liu wrote:
> > > On Thu, Sep 7, 2023 at 12:13=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> =
wrote:
> > > >
> > > > Add missed value to kprobe attached through perf link info to
> > > > hold the stats of missed kprobe handler execution.
> > > >
> > > > The kprobe's missed counter gets incremented when kprobe handler
> > > > is not executed due to another kprobe running on the same cpu.
> > > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > >
> > > [...]
> > >
> > > The code looks good to me. But I have two thoughts on this (and 2/9).
> > >
> > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > index e5216420ec73..e824b0c50425 100644
> > > > --- a/include/uapi/linux/bpf.h
> > > > +++ b/include/uapi/linux/bpf.h
> > > > @@ -6546,6 +6546,7 @@ struct bpf_link_info {
> > > >                                         __u32 name_len;
> > > >                                         __u32 offset; /* offset fro=
m func_name */
> > > >                                         __u64 addr;
> > > > +                                       __u64 missed;
> > > >                                 } kprobe; /* BPF_PERF_EVENT_KPROBE,=
 BPF_PERF_EVENT_KRETPROBE */
> > > >                                 struct {
> > > >                                         __aligned_u64 tp_name;   /*=
 in/out */
> > >
> > > 1) Shall we add missed for all bpf_link_info? Something like:
> > >
> > > diff --git i/include/uapi/linux/bpf.h w/include/uapi/linux/bpf.h
> > > index 5a39c7a13499..cf0b8b2a8b39 100644
> > > --- i/include/uapi/linux/bpf.h
> > > +++ w/include/uapi/linux/bpf.h
> > > @@ -6465,6 +6465,7 @@ struct bpf_link_info {
> > >         __u32 type;
> > >         __u32 id;
> > >         __u32 prog_id;
> > > +       __u64 missed;
> > >         union {
> > >                 struct {
> > >                         __aligned_u64 tp_name; /* in/out: tp_name buf=
fer ptr */
> >
> > hm, there's lot of links under bpf_link_info, can't really tell if
> > all could gather 'missed' data.. like I don't think we have any for
> > standard perf event or perf tracepoint
>
> even if missed for all link types would make sense, we can't add any
> field before union, this would be a breaking change

Right...

It is also tricky to add it to the union, right? We cannot tell whether
the kernel supports missed stats based on sizeof(struct bpf_link_info).
I guess this is also problematic?

Thanks,
Song

[...]

