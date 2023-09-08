Return-Path: <bpf+bounces-9578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AA27992E5
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 01:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7221C20CB8
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 23:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FD5747E;
	Fri,  8 Sep 2023 23:44:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E737466
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 23:44:34 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5C818E
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 16:44:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52e5900cf77so3414004a12.2
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 16:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694216671; x=1694821471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8aaiPzmyB8SkSZWJlvSQHyGnGbgrddC1UWeu4OSW4c=;
        b=lS6MZ27EY2v7lc+A45Pnk1HYX7UxHpbUf++h4YJEGI7ZFeZNVsQ0J6ky7LZwEe/YbR
         QMtfEu8HLDxQPqyCvDPYEs2HopIHzJkv20dAkMtDPZvLbHP7p3i5WSOCR4HLZ3Boomay
         5Wh4EppevEPgzdzjqNDiOmdOCtPIbvVpd7yNMV8PE4VvI4DfnRnkwqtwNlmmH4WJNHqz
         1vC1q2stQl+6GYhW2yJT3QOoUpbi6JdEC/LX00g+l4FEgRY3G4B6TOUxcMhQAbsC27OR
         tKm6y+zM3SalG1fY5pB45tMJJ7Br6R9kxjS9uLs+MAp/FC10/f9oxR2EHFBL7TrsXgSv
         Pnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694216671; x=1694821471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8aaiPzmyB8SkSZWJlvSQHyGnGbgrddC1UWeu4OSW4c=;
        b=XyT1xCLRDrDiI07bKaT+d6xqzgm3Lc3F6n8GB5ogx76jqllfNmEJ9AaitbU7VNAFUn
         5as/Q+D3KbwjcBo4Yshlsqhmd1suBzRRaQEIkm1gfbOHdO9zbbk70ln5XvZHIyJo4oz1
         AF86qw4RXcYovrAVRlqTJrIKMv3RIvE/iMHx23m+xysns9FS/S/RFrvIeizVdinkOspn
         9H4BvNloiiO9/OeDwxqXfHiGQt7hzq2DKlmYQNst5j1HOUil7E6R+XIoq12joYuaDAjw
         rU1NpU+ItqR/gLFNJozpUOWvrbTzbdbAN8iePui/fCWOE1XgtIhJV4VFKQJ/Oc2oiw5v
         A8yA==
X-Gm-Message-State: AOJu0Ywj6MvbuIVp05D3QJOGHIjTjc0RYu8wp8JqCEknONiB5Qi071sI
	BAYQiWZ+T1hDI7izGf0GtT1878CX3pfgZ8O84RA=
X-Google-Smtp-Source: AGHT+IFSvzjyrZoi8AJMtH768tKgVb+WPYCGWHdD0OF+Zne4iBnZRmMWx8mViNG3ia81AZdWkreoHAK6fXf03jtScNw=
X-Received: by 2002:a05:6402:1b01:b0:52e:1d58:a709 with SMTP id
 by1-20020a0564021b0100b0052e1d58a709mr2402822edb.40.1694216671513; Fri, 08
 Sep 2023 16:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907071311.254313-1-jolsa@kernel.org> <20230907071311.254313-4-jolsa@kernel.org>
 <CAPhsuW4hX95fHZCDYnfzAwK43dbnGJUxHEF3bGdODWe_6MytnQ@mail.gmail.com>
 <ZPsI/4nX7IUpJ6Gr@krava> <CAEf4Bzawf5_uq5bE_O8Y1GqxJhNd_zkOYTnDdPRy3n_0upXn2A@mail.gmail.com>
 <CAPhsuW4qzim9KDJZUD6-2xA42fr8tgQ9dh7odeAhiym-xsiuVg@mail.gmail.com>
In-Reply-To: <CAPhsuW4qzim9KDJZUD6-2xA42fr8tgQ9dh7odeAhiym-xsiuVg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Sep 2023 16:44:20 -0700
Message-ID: <CAEf4BzYEpc+sD3N6LwHoYAqj9UWzF2ahN=SqXaz7q7Q2JGabxw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 3/9] bpf: Add missed value to kprobe perf link info
To: Song Liu <song@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Hou Tao <houtao1@huawei.com>, 
	Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 8, 2023 at 4:33=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Fri, Sep 8, 2023 at 4:22=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Sep 8, 2023 at 4:44=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > >
> > > On Thu, Sep 07, 2023 at 11:40:46AM -0700, Song Liu wrote:
> > > > On Thu, Sep 7, 2023 at 12:13=E2=80=AFAM Jiri Olsa <jolsa@kernel.org=
> wrote:
> > > > >
> > > > > Add missed value to kprobe attached through perf link info to
> > > > > hold the stats of missed kprobe handler execution.
> > > > >
> > > > > The kprobe's missed counter gets incremented when kprobe handler
> > > > > is not executed due to another kprobe running on the same cpu.
> > > > >
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > >
> > > > [...]
> > > >
> > > > The code looks good to me. But I have two thoughts on this (and 2/9=
).
> > > >
> > > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > > index e5216420ec73..e824b0c50425 100644
> > > > > --- a/include/uapi/linux/bpf.h
> > > > > +++ b/include/uapi/linux/bpf.h
> > > > > @@ -6546,6 +6546,7 @@ struct bpf_link_info {
> > > > >                                         __u32 name_len;
> > > > >                                         __u32 offset; /* offset f=
rom func_name */
> > > > >                                         __u64 addr;
> > > > > +                                       __u64 missed;
> > > > >                                 } kprobe; /* BPF_PERF_EVENT_KPROB=
E, BPF_PERF_EVENT_KRETPROBE */
> > > > >                                 struct {
> > > > >                                         __aligned_u64 tp_name;   =
/* in/out */
> > > >
> > > > 1) Shall we add missed for all bpf_link_info? Something like:
> > > >
> > > > diff --git i/include/uapi/linux/bpf.h w/include/uapi/linux/bpf.h
> > > > index 5a39c7a13499..cf0b8b2a8b39 100644
> > > > --- i/include/uapi/linux/bpf.h
> > > > +++ w/include/uapi/linux/bpf.h
> > > > @@ -6465,6 +6465,7 @@ struct bpf_link_info {
> > > >         __u32 type;
> > > >         __u32 id;
> > > >         __u32 prog_id;
> > > > +       __u64 missed;
> > > >         union {
> > > >                 struct {
> > > >                         __aligned_u64 tp_name; /* in/out: tp_name b=
uffer ptr */
> > >
> > > hm, there's lot of links under bpf_link_info, can't really tell if
> > > all could gather 'missed' data.. like I don't think we have any for
> > > standard perf event or perf tracepoint
> >
> > even if missed for all link types would make sense, we can't add any
> > field before union, this would be a breaking change
>
> Right...
>
> It is also tricky to add it to the union, right? We cannot tell whether
> the kernel supports missed stats based on sizeof(struct bpf_link_info).
> I guess this is also problematic?

right, just checking size won't be reliable (it would be if missed is
added to largest substruct of a union). If it's important to know if
kernel reports missed, one would need to do a more proper feature
detection


>
> Thanks,
> Song
>
> [...]

