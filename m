Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B81F3802C2
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 06:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhENEV5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 May 2021 00:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbhENEV4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 May 2021 00:21:56 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA28C061574;
        Thu, 13 May 2021 21:20:40 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2so41357772lft.4;
        Thu, 13 May 2021 21:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/HACQmlceYlYcP2ZTBmulx+QhiBT9GSoKT1qEpJT5BM=;
        b=iWkPUUa3uetg3wikEAiftynvERcZmFEgZ4nja3IEXjeaaN3tN3d5KsIb7iwX3YFGxf
         bggkU4A8Twh2hqsotNA/sO6UEyTvHnGEemasmlpjU5jD+sNd21hz1wE6y3pwKScOWw4p
         W0ISs2Vb33m0gUOeuOCGS31B80A5Zipx3vwsNyw9EaZaJxaiChjJuxd9j8Iw2pub8e5a
         zlCLs1y5IDN0UAW8a/IbYFq1/ca38Q7wrEIXUg7eKnKPUvGjVUy6oiDWS49IN/mczcCM
         kAeDieNlTOPm/xmcEyTmtdSv/UEzO2gADpwXPdnPU9fakSw8Mg0lnFEwVPGO1ifwft3A
         EdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/HACQmlceYlYcP2ZTBmulx+QhiBT9GSoKT1qEpJT5BM=;
        b=fWtUEEIX3PSfnfYAY7XJbYoq98+MlwbQ/k9t7++mH72Q+S+xPYLvjcZqRxDaX8kt/g
         R++7hEMNoXmmax6ADtIemC7/z2bTHMOq42CgDMtcw/APrvF7D40hdJ+0MfRpGDEumGSq
         2YtEk97m0GuCXMWSgjAdVpYYWL0Oap1n5NHRGjiFP5XydY7r3T4Yw7e9jQJ0W5QTaEjw
         i12j0Z/i56qMgahSfYZswPQFSWp7puVlzIOfTbYQbvYwgb2YSS5bVkmR4RRCx6ven0hV
         FaRYy6c9g61Z32w9A/VJUX3TlGO/CZ/dP5GLTER8LONtwer/U+d4YhiLi2Wfc9H8q+OF
         rNFg==
X-Gm-Message-State: AOAM533tnHAUeNwUEXNX3Iqm4VoBCj1GzWEtfFzlODwlmSuzjYDt0Z6G
        PqBqL9hPAsQNBTJGuHDc3J4V82NWnFoIi4ihptzjySEl3xU=
X-Google-Smtp-Source: ABdhPJzyDKMVwl8UoI7/n1bpjFLa8FtRrPk7thWt0fa/ZsOoikaU11D4E76oqn3c0WE6KQ2lDMZ7BvBkAojlDoNN3VU=
X-Received: by 2002:ac2:5b1a:: with SMTP id v26mr31252723lfn.534.1620966039076;
 Thu, 13 May 2021 21:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210512095823.99162-1-yunbo.xufeng@linux.alibaba.com>
 <20210512095823.99162-2-yunbo.xufeng@linux.alibaba.com> <20210512225504.3kt6ij4xqzbtyej5@ast-mbp.dhcp.thefacebook.com>
 <9ae7e503-8f49-a7a4-3e18-0288c7989484@linux.alibaba.com>
In-Reply-To: <9ae7e503-8f49-a7a4-3e18-0288c7989484@linux.alibaba.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 13 May 2021 21:20:27 -0700
Message-ID: <CAADnVQK1s4US2LPe4+XsQBEjH8iG8Jdh58n6X1yXAafDAw+M4Q@mail.gmail.com>
Subject: Re: [RFC] [PATCH bpf-next 1/1] bpf: Add a BPF helper for getting the
 cgroup path of current task
To:     xufeng zhang <yunbo.xufeng@linux.alibaba.com>
Cc:     KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Joe Stringer <joe@cilium.io>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 13, 2021 at 1:57 AM xufeng zhang
<yunbo.xufeng@linux.alibaba.com> wrote:
>
> =E5=9C=A8 2021/5/13 =E4=B8=8A=E5=8D=886:55, Alexei Starovoitov =E5=86=99=
=E9=81=93:
>
> > On Wed, May 12, 2021 at 05:58:23PM +0800, Xufeng Zhang wrote:
> >> To implement security rules for application containers by utilizing
> >> bpf LSM, the container to which the current running task belongs need
> >> to be known in bpf context. Think about this scenario: kubernetes
> >> schedules a pod into one host, before the application container can ru=
n,
> >> the security rules for this application need to be loaded into bpf
> >> maps firstly, so that LSM bpf programs can make decisions based on
> >> this rule maps.
> >>
> >> However, there is no effective bpf helper to achieve this goal,
> >> especially for cgroup v1. In the above case, the only available inform=
ation
> >> from user side is container-id, and the cgroup path for this container
> >> is certain based on container-id, so in order to make a bridge between
> >> user side and bpf programs, bpf programs also need to know the current
> >> cgroup path of running task.
> > ...
> >> +#ifdef CONFIG_CGROUPS
> >> +BPF_CALL_2(bpf_get_current_cpuset_cgroup_path, char *, buf, u32, buf_=
len)
> >> +{
> >> +    struct cgroup_subsys_state *css;
> >> +    int retval;
> >> +
> >> +    css =3D task_get_css(current, cpuset_cgrp_id);
> >> +    retval =3D cgroup_path_ns(css->cgroup, buf, buf_len, &init_cgroup=
_ns);
> >> +    css_put(css);
> >> +    if (retval >=3D buf_len)
> >> +            retval =3D -ENAMETOOLONG;
> > Manipulating string path to check the hierarchy will be difficult to do
> > inside bpf prog. It seems to me this helper will be useful only for
> > simplest cgroup setups where there is no additional cgroup nesting
> > within containers.
> > Have you looked at *ancestor_cgroup_id and *cgroup_id helpers?
> > They're a bit more flexible when dealing with hierarchy and
> > can be used to achieve the same correlation between kernel and user cgr=
oup ids.
>
>
> Thanks for your timely reply, Alexei!
>
> Yes, this helper is not so common, it does not works for nesting cgroup
> within containers.
>
> About your suggestion, the *cgroup_id helpers only works for cgroup v2,
> however, we're still using cgroup v1 in product=EF=BC=8Cand even for cgro=
up v2,
> I'm not sure if there is any way for user space to get this cgroup id
> timely(after container created, but before container start to run)=E3=80=
=82
>
> So if there is any effective way works for cgroup v1?

https://github.com/systemd/systemd/blob/main/NEWS#L379
