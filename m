Return-Path: <bpf+bounces-9571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E49A7992CA
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 01:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F2F281C2E
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 23:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630167469;
	Fri,  8 Sep 2023 23:22:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B18111B
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 23:22:20 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881BF18E
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 16:22:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a9d6b98845so657635066b.0
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 16:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694215338; x=1694820138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HXslcqZ97y4u2tI3SoLGMH53tzZ/ng21NHDLQSLumw=;
        b=RwkQigXCJvV8c5cYuNc2a/07DaVuU92FIWIQ8cIoH2wqdQcUjDkcn4Qt7snF666+b+
         8EbPMkCjNlzkYvHKHrL1pjHAwrDZpNlBaNZ/tignIBuCJzDxuKT+ecwRfqbVksDjF53t
         cOqTNwJOMG87O+jkjH8PueHDXFGw6v1S7N/HWZvqXhm3RqR1CCvzNdHPFuu2TE494E8f
         jU5gVVJsNHxe4958Ax6mc+SFWFDNT3oTZYTTKK9mQK5moBA7RsfILSe/Hln5Nf/fnxE3
         la/uw2f/xVbnGVtbLcN2OXYbfh0Hr8XBDogbBhzdi+HrFfVvLXjs3s2rzBA+nz/FmdG8
         z3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694215338; x=1694820138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HXslcqZ97y4u2tI3SoLGMH53tzZ/ng21NHDLQSLumw=;
        b=mcLCp0BczeTeMuvdHVV6dZ5+r7ZcqatULOzkhu5jbMPqMUB3AoLEroO0T39JuBR9du
         AmbHDLnfC020r7Kkf/n213aNnQiTkW9lm7/Pnn/QE5afYEYdkHxJPnQjKRT5XsfzhO/s
         e0++zR6tR1TFDwtWsuGUWBC6KZdENTvvSs2VGd0t0Y/NjmdNak+7c6y5i4vSZGV+6jHt
         yA26dmafKTqPMUIi1CcTkP1idMK7SfZ/b9FZrhF/xiSDavVfVGYVJ2ljXy/oCB93O3k0
         fOhPaVWVKDf2gh5GDZuIqJ7lN98B2i2hf3A6A9W1hp3UffXRQAOff6pjCbTLVpCg5IuG
         7q6Q==
X-Gm-Message-State: AOJu0YyMalhqNfqBSx+RE0bXILuzB04in/ztejEnLatbGykRpGjcwI4b
	cC8/1anv0C6h68CQw8vy5LCHlFv7EgvjPCAD5ggxU/QM
X-Google-Smtp-Source: AGHT+IFX8cmkcFBm8xtMJ5w3GbsacwXWhFSXh/BQgbk9CoY1oWZXcu5jj+fu2Pkr3hB2uahLi6ji2gslSAVwvesdKAY=
X-Received: by 2002:a17:907:7714:b0:9a5:d710:dea5 with SMTP id
 kw20-20020a170907771400b009a5d710dea5mr5127703ejc.17.1694215337912; Fri, 08
 Sep 2023 16:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907071311.254313-1-jolsa@kernel.org> <20230907071311.254313-4-jolsa@kernel.org>
 <CAPhsuW4hX95fHZCDYnfzAwK43dbnGJUxHEF3bGdODWe_6MytnQ@mail.gmail.com> <ZPsI/4nX7IUpJ6Gr@krava>
In-Reply-To: <ZPsI/4nX7IUpJ6Gr@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Sep 2023 16:22:05 -0700
Message-ID: <CAEf4Bzawf5_uq5bE_O8Y1GqxJhNd_zkOYTnDdPRy3n_0upXn2A@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 3/9] bpf: Add missed value to kprobe perf link info
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Hou Tao <houtao1@huawei.com>, 
	Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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

even if missed for all link types would make sense, we can't add any
field before union, this would be a breaking change

>
> >
> > 2) "missed" doesn't seem to fit well with other information in
> > struct bpf_link_info. Other information there are more like stable-ish
> > information; while missed is a stat that changes over time. Given we
> > have prog_id in bpf_link_info, do we really need "missed" here?
>
> right, OTOH there's recursion_misses/run_time_ns/run_cnt in bpf_prog_info
>
> the bpf link has access to its attach layer, like perf event for kprobe
> in perf_link or fprobe for kprobe_multi link... so it's convenient to
> reach out from link for these stats and make them available through
> bpf_link_info

but what's confusing to me is that missed counter is per-program (at
least in your patch #1), but you report it on  a link. But the same
BPF program can be attached multiple times through independent links.
So each link will report a shared misses count, which is quite
confusing.

Have you thought about counting misses per link instead of per
program? Is it possible?

>
> also there's no other way to get these data for some links
>
> like we could perhaps add some perf event specific interface to retrieve
> these stats for kprobes, because we have access to the perf event in user
> space, but that's not the case for kprobe_multi link, because there's no
> other way to reach the fprobe object
>
> jirka
>

