Return-Path: <bpf+bounces-9521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A31A9798ADB
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 18:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C952281B94
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 16:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B01913AE7;
	Fri,  8 Sep 2023 16:49:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D6D15B6
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 16:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684BBC433CC
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 16:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694191771;
	bh=wCpSSsmPvPqmN3lW8pXtvS2NRsKluohtKoynCT6eZjk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D2gb/JP2vd2XTglBpSA9Yz6uvTQka8CIWgDjQtow+/lCMLbrS60YdA+ufXqu9JlVy
	 YZx669qEOEl/U5XNLsuDW4t8g1h+Uden0yyo7VIm8Gu+L939uq+naCbUPL3HyG52tb
	 +ow363KmNLnuCg9Tr6GSs7CKcAwcH7T9opCl3rds2vNq8yZjtEcacMsLqvtdIuCdTq
	 p6wy/PUibjwsf28lgk7OafttO9V5C8uIC+lBL/B2ry7onYP7zjZUs0TV7FrEwRK5jW
	 LfVRQQgbOdO2Y79SYPH3J8lBvWS2Sztwyzuu2DLJLr7i6rzw0CMQ8U0A7Gz3mkmAUM
	 N2PE3aRX+7zfg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-501bd6f7d11so3709626e87.1
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 09:49:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YzNf8D/JK1h9O7Gp1xo/xs2Ah+G8INqdi+BDWqkTnawURy1k68Q
	sjfeoaI2a5meungjDLPq077gvDpGjY0Wp5wP7pE=
X-Google-Smtp-Source: AGHT+IED65yeyNfnYLNmr9oRTJsRhKlYk205cjIPBffb5tbZ20XConN6w2MeKi9R59Eqr/AB7aGWWSyhyPhXFPa7XvY=
X-Received: by 2002:a05:6512:ea1:b0:4ff:af45:1ef7 with SMTP id
 bi33-20020a0565120ea100b004ffaf451ef7mr2886796lfb.6.1694191769591; Fri, 08
 Sep 2023 09:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907071311.254313-1-jolsa@kernel.org> <20230907071311.254313-4-jolsa@kernel.org>
 <CAPhsuW4hX95fHZCDYnfzAwK43dbnGJUxHEF3bGdODWe_6MytnQ@mail.gmail.com> <ZPsI/4nX7IUpJ6Gr@krava>
In-Reply-To: <ZPsI/4nX7IUpJ6Gr@krava>
From: Song Liu <song@kernel.org>
Date: Fri, 8 Sep 2023 09:49:17 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4aiVoGwN7quqCUiXS7HrKtSyPbR4dsgoXw=wcgWuybew@mail.gmail.com>
Message-ID: <CAPhsuW4aiVoGwN7quqCUiXS7HrKtSyPbR4dsgoXw=wcgWuybew@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 3/9] bpf: Add missed value to kprobe perf link info
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Hou Tao <houtao1@huawei.com>, 
	Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 8, 2023 at 4:44=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Thu, Sep 07, 2023 at 11:40:46AM -0700, Song Liu wrote:
> > On Thu, Sep 7, 2023 at 12:13=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Add missed value to kprobe attached through perf link info to
> > > hold the stats of missed kprobe handler execution.
> > >
> > > The kprobe's missed counter gets incremented when kprobe handler
> > > is not executed due to another kprobe running on the same cpu.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >
> > [...]
> >
> > The code looks good to me. But I have two thoughts on this (and 2/9).
> >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index e5216420ec73..e824b0c50425 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -6546,6 +6546,7 @@ struct bpf_link_info {
> > >                                         __u32 name_len;
> > >                                         __u32 offset; /* offset from =
func_name */
> > >                                         __u64 addr;
> > > +                                       __u64 missed;
> > >                                 } kprobe; /* BPF_PERF_EVENT_KPROBE, B=
PF_PERF_EVENT_KRETPROBE */
> > >                                 struct {
> > >                                         __aligned_u64 tp_name;   /* i=
n/out */
> >
> > 1) Shall we add missed for all bpf_link_info? Something like:
> >
> > diff --git i/include/uapi/linux/bpf.h w/include/uapi/linux/bpf.h
> > index 5a39c7a13499..cf0b8b2a8b39 100644
> > --- i/include/uapi/linux/bpf.h
> > +++ w/include/uapi/linux/bpf.h
> > @@ -6465,6 +6465,7 @@ struct bpf_link_info {
> >         __u32 type;
> >         __u32 id;
> >         __u32 prog_id;
> > +       __u64 missed;
> >         union {
> >                 struct {
> >                         __aligned_u64 tp_name; /* in/out: tp_name buffe=
r ptr */
>
> hm, there's lot of links under bpf_link_info, can't really tell if
> all could gather 'missed' data.. like I don't think we have any for
> standard perf event or perf tracepoint

I thought about the same thing, but didn't get to a conclusion. So
I brought it up for more discussions. Personally, I don't have a
strong preference either way.

>
> >
> > 2) "missed" doesn't seem to fit well with other information in
> > struct bpf_link_info. Other information there are more like stable-ish
> > information; while missed is a stat that changes over time. Given we
> > have prog_id in bpf_link_info, do we really need "missed" here?
>
> right, OTOH there's recursion_misses/run_time_ns/run_cnt in bpf_prog_info

Agreed. bpf_prog_info also contains stats of the program.

> the bpf link has access to its attach layer, like perf event for kprobe
> in perf_link or fprobe for kprobe_multi link... so it's convenient to
> reach out from link for these stats and make them available through
> bpf_link_info
>
> also there's no other way to get these data for some links
>
> like we could perhaps add some perf event specific interface to retrieve
> these stats for kprobes, because we have access to the perf event in user
> space, but that's not the case for kprobe_multi link, because there's no
> other way to reach the fprobe object

Fair enough. I guess this is a good stat to have for the bpf link.

More question about kprobe_multi: Shall we (or can we) collect "missed" for=
 each
individual function we attach to?

Thanks,
Song

