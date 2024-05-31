Return-Path: <bpf+bounces-31046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5C78D66D9
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 18:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1390328E8BA
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 16:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5D815AAB6;
	Fri, 31 May 2024 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lor0OLn5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436BC36AF8
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173039; cv=none; b=jAO6xJMYPOL6yBCuE6EiISCEodq/HB4p5SIIUfabBKAodBFFH9eMpjCYNIN5lItTjDIiX//3tAvjXIcduSWck88Qe/1QAC39FFgKWn0+C/+OLeL8G3U1gC1wb2aPDkcuPb1lWq0NY/ANyK1zlyoH5sMgB3s8f8VSEmb4WZAuYWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173039; c=relaxed/simple;
	bh=m5F7yuv4I2zRf4rf/u4uG4G6zEDoXT/mEhANzCs48Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja5K4HppbKwGmVDtmNe5CtmLu6qUAxTHBc6EbUsFgsyeerAjGsx8ad/4y3i03Qz4GvxiFAByFct3DMllYQDPNU1HzcR/w2xKVnvAxrMtSNPkSFEDxcwOxGm3DmBkVy2F+KDUM1Mvn5o0wCB9MuSht8uXy0gLz+PDvH3BJk6bgV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lor0OLn5; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6bce380eb9cso1676923a12.0
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717173037; x=1717777837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUsxHpp8YkIrW+FWTyPWrcHku77RuSKXqNO4d4a0Zkg=;
        b=lor0OLn5vjpMEpnu4oiiQaHBSFa3jYE5AZGSPTBsiMAscmKL1HQ0tCRwJRSxoIfpC1
         XZhx1cPxbyb4cdayRNO7bqVvH0Moo9KfJoym6mot4wIkX0waZE9S7hOVhpNeUvw5Tpyw
         iJ11N+XBJNCuusmtHYu1vXI0F8NAtnG5VKan55MF4sNZY2utKZTh58a/p4I0Z76H06KY
         9APdim9QPHXejPFcFHBPoNYtZC6MJ1nOkGelEZ6l8f2YCS919eon7UhMdgIUYHKH5+/u
         bUBHYFKP2DzL8UgDvpUYNBoSXvIUgP8g+hZDB+G0+q6Yz1SwvP/ZHKxtIbV6KuhTb3FG
         gFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717173037; x=1717777837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUsxHpp8YkIrW+FWTyPWrcHku77RuSKXqNO4d4a0Zkg=;
        b=cVoo9rE01BFDxE3oPvnyTgyCXP7t07VfJ58zXvc69UpPGB9SwuTBIjhxWh4Mz7idX4
         Npd2fU68CtrFV6zSwnWwjaUCVp2cKMImpu1allU/V44BmzvtZ7ITAEyHH3itGAKxqbZ2
         8TG7IgMQ/2Z58XMXTMDoporbVwkeWV9MF54B2UlY2vNCZKazGoqfqHDpLEUywe7fJddv
         RypV9pjKHAeqzAy4I/cykFfFyw+5tXSi7KPfYa24NQ6LTh3kkRyxNLHJb41UN9TpC8Lu
         y0Xhm1KqGUpxyb7nIRULPqdyfAXc9/3ys4HiZnG0i5qFJTzo9hKn4SZq3fjAsskTAvR5
         rg6A==
X-Gm-Message-State: AOJu0YxZkcFTWhKDBuasHv0VaIvlWnVaGBn696nezGC9Qyy6a+u3LO0p
	smxamIgTGHKM34Qo0ZTl0LHS5t5NY1CIzgnM5Ur6GLEBl5VBS0g9l7cX6O+x0ffywKthqyeRODl
	SJUngw6QkHVPPkR6R7kkPw1q4lgo=
X-Google-Smtp-Source: AGHT+IHXvPNVBLjF/g+fVqOTwRm1Pks0fW/I4Kjituko1o3u20eb7Ob2OPvACAjj6G1ClaPoCNrny8hZvK3V6XD4Tl0=
X-Received: by 2002:a17:90b:116:b0:2bd:e316:ae2d with SMTP id
 98e67ed59e1d1-2c1dc5711a4mr2263311a91.16.1717173037319; Fri, 31 May 2024
 09:30:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529131028.41200-1-tadakentaso@gmail.com> <CAEf4Bzbt4FMqAOioJYZpuYDrtiFiT+STMqs_Z8ZhTNLD3AZxzg@mail.gmail.com>
 <0cec01b4-1ae5-40ea-bccf-f29c41e2cf74@gmail.com>
In-Reply-To: <0cec01b4-1ae5-40ea-bccf-f29c41e2cf74@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 31 May 2024 09:30:24 -0700
Message-ID: <CAEf4BzYGUEGx-BSXtaMRGA3GOW9h+nmYFg2U38g6YbWK9waYSA@mail.gmail.com>
Subject: Re: [PATCH] bpftool: Query only cgroup-related attach types
To: Kenta Tada <tadakentaso@gmail.com>
Cc: bpf@vger.kernel.org, qmo@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 6:04=E2=80=AFAM Kenta Tada <tadakentaso@gmail.com> =
wrote:
>
> On 2024/05/31 6:20, Andrii Nakryiko wrote:
> > On Wed, May 29, 2024 at 6:10=E2=80=AFAM Kenta Tada <tadakentaso@gmail.c=
om> wrote:
> >>
> >> When CONFIG_NETKIT=3Dy,
> >> bpftool-cgroup shows error even if the cgroup's path is correct:
> >>
> >> $ bpftool cgroup tree /sys/fs/cgroup
> >> CgroupPath
> >> ID       AttachType      AttachFlags     Name
> >> Error: can't query bpf programs attached to /sys/fs/cgroup: No such de=
vice or address
> >>
> >> From strace and kernel tracing, I found netkit returned ENXIO and this=
 command failed.
> >> I think this AttachType(BPF_NETKIT_PRIMARY) is not relevant to cgroup.
> >>
> >> bpftool-cgroup should query just only cgroup-related attach types.
> >>
> >> Signed-off-by: Kenta Tada <tadakentaso@gmail.com>
> >> ---
> >>  tools/bpf/bpftool/cgroup.c | 47 +++++++++++++++++++++++++++++++++----=
-
> >>  1 file changed, 41 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> >> index af6898c0f388..bb2703aa4756 100644
> >> --- a/tools/bpf/bpftool/cgroup.c
> >> +++ b/tools/bpf/bpftool/cgroup.c
> >> @@ -19,6 +19,39 @@
> >>
> >>  #include "main.h"
> >>
> >> +static const bool cgroup_attach_types[] =3D {
> >> +       [BPF_CGROUP_INET_INGRESS] =3D true,
> >> +       [BPF_CGROUP_INET_EGRESS] =3D true,
> >> +       [BPF_CGROUP_INET_SOCK_CREATE] =3D true,
> >> +       [BPF_CGROUP_INET_SOCK_RELEASE] =3D true,
> >> +       [BPF_CGROUP_INET4_BIND] =3D true,
> >> +       [BPF_CGROUP_INET6_BIND] =3D true,
> >> +       [BPF_CGROUP_INET4_POST_BIND] =3D true,
> >> +       [BPF_CGROUP_INET6_POST_BIND] =3D true,
> >> +       [BPF_CGROUP_INET4_CONNECT] =3D true,
> >> +       [BPF_CGROUP_INET6_CONNECT] =3D true,
> >> +       [BPF_CGROUP_UNIX_CONNECT] =3D true,
> >> +       [BPF_CGROUP_INET4_GETPEERNAME] =3D true,
> >> +       [BPF_CGROUP_INET6_GETPEERNAME] =3D true,
> >> +       [BPF_CGROUP_UNIX_GETPEERNAME] =3D true,
> >> +       [BPF_CGROUP_INET4_GETSOCKNAME] =3D true,
> >> +       [BPF_CGROUP_INET6_GETSOCKNAME] =3D true,
> >> +       [BPF_CGROUP_UNIX_GETSOCKNAME] =3D true,
> >> +       [BPF_CGROUP_UDP4_SENDMSG] =3D true,
> >> +       [BPF_CGROUP_UDP6_SENDMSG] =3D true,
> >> +       [BPF_CGROUP_UNIX_SENDMSG] =3D true,
> >> +       [BPF_CGROUP_UDP4_RECVMSG] =3D true,
> >> +       [BPF_CGROUP_UDP6_RECVMSG] =3D true,
> >> +       [BPF_CGROUP_UNIX_RECVMSG] =3D true,
> >> +       [BPF_CGROUP_SOCK_OPS] =3D true,
> >> +       [BPF_CGROUP_DEVICE] =3D true,
> >> +       [BPF_CGROUP_SYSCTL] =3D true,
> >> +       [BPF_CGROUP_GETSOCKOPT] =3D true,
> >> +       [BPF_CGROUP_SETSOCKOPT] =3D true,
> >> +       [BPF_LSM_CGROUP] =3D true,
> >> +       [__MAX_BPF_ATTACH_TYPE] =3D false,
> >> +};
> >> +
> >>  #define HELP_SPEC_ATTACH_FLAGS                                       =
  \
> >>         "ATTACH_FLAGS :=3D { multi | override }"
> >>
> >> @@ -187,14 +220,16 @@ static int cgroup_has_attached_progs(int cgroup_=
fd)
> >>         bool no_prog =3D true;
> >>
> >>         for (type =3D 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
> >
> > instead of iterating over all possible attach types and then checking
> > if attach type is cgroup-related, why not have an array of just cgroup
> > attach types and iterate it directly?
> >
> > pw-bot: cr
>
> The size of the bool array is smaller than saving each attachment type as=
 the value in an integer array.
> But either is fine.

Those few bytes don't matter, it's about it being a cleaner approach.
You only iterate meaningful types, instead of iterating everything and
skipping some. In the grand scheme of things it's not that important,
but I'd go with the list approach as more natural to understand.

>
> I think the problem is that we don't increase the list of cgroup attach t=
ypes in multiple files.
> Do you have any plans to add the new API to check whether the attach type=
 is cgroup-related in libbpf?
> I want to call the new API in this patch.

I'm not convinced we need this API. cgroup-specific attach types are
just one possible subset of attach types, not sure it's a good idea to
add a dedicated filtering API for that in libbpf.

>
> >
> >
> >> -               int count =3D count_attached_bpf_progs(cgroup_fd, type=
);
> >> +               if (cgroup_attach_types[type]) {
> >> +                       int count =3D count_attached_bpf_progs(cgroup_=
fd, type);
> >>
> >> -               if (count < 0 && errno !=3D EINVAL)
> >> -                       return -1;
> >> +                       if (count < 0 && errno !=3D EINVAL)
> >> +                               return -1;
> >>
> >> -               if (count > 0) {
> >> -                       no_prog =3D false;
> >> -                       break;
> >> +                       if (count > 0) {
> >> +                               no_prog =3D false;
> >> +                               break;
> >> +                       }
> >>                 }
> >>         }
> >>
> >> --
> >> 2.43.0
> >>
>

