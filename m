Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEB438085B
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 13:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhENLV5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 May 2021 07:21:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhENLV5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 May 2021 07:21:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFEF261462
        for <bpf@vger.kernel.org>; Fri, 14 May 2021 11:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620991245;
        bh=d1QDAQZ60obWUxgQJmiEA+FKlikVqoTz4eCnAtLMGx8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RXWMpTEthVDf7TGL2KFsH80ibKBqS3kz8Z6qJZZUpP74QytGTgJ9nUN9CbTefIMeD
         QuAiWjvUsOYDq3yX4NOZXalN2a/ImEwO0vUE24RQvDUywCRYL8vZXozs6pyPpFwnqm
         TVZoV0pnxvEkE24YKaLz27gdpVBkb0Aj52hZ6dP/+gdcHETwurNmeq1CQIqcqfpWbZ
         jDBFLgVFkQ4P4lIdKRSl5d/2knY1Mb7MvbfCGBTa0bgnM0X7zd6Ab7DO6S1dV0FySt
         g2gdUbjs61xI4x/IMGXw8I3r/xJT6vjGc+44RJkriurANq7XqGyfb1/6doQGvEadXb
         4GH1ghIah6Rhg==
Received: by mail-lj1-f182.google.com with SMTP id v6so37428524ljj.5
        for <bpf@vger.kernel.org>; Fri, 14 May 2021 04:20:45 -0700 (PDT)
X-Gm-Message-State: AOAM533wqqqO50mZof5DWegtQdPlN43TXpuU/Fhm/LicE5BEaFZ5Cy8r
        vhk5puwP2hY39Hnkml9RJcFwMXpI03/GSkUZKI4vkw==
X-Google-Smtp-Source: ABdhPJywbIYJiOtwQcK9q0jpN9m/0wYFMB5SNRaut5ZEvlsGQDditQu2Uw4BAYelJKJGGVykhgGgnILgiBVJbxw3PAs=
X-Received: by 2002:a05:651c:285:: with SMTP id b5mr23795422ljo.348.1620991244001;
 Fri, 14 May 2021 04:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210512095823.99162-1-yunbo.xufeng@linux.alibaba.com>
 <20210512095823.99162-2-yunbo.xufeng@linux.alibaba.com> <20210512225504.3kt6ij4xqzbtyej5@ast-mbp.dhcp.thefacebook.com>
 <1b6dfe61-29ed-5d4d-fa1f-1bd46a4f5860@linux.alibaba.com>
In-Reply-To: <1b6dfe61-29ed-5d4d-fa1f-1bd46a4f5860@linux.alibaba.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 14 May 2021 13:20:32 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5vq_PtoeMx5x+-j6eiBfa16C-Cq9Pv6PzuTXjat7MySQ@mail.gmail.com>
Message-ID: <CACYkzJ5vq_PtoeMx5x+-j6eiBfa16C-Cq9Pv6PzuTXjat7MySQ@mail.gmail.com>
Subject: Re: [RFC] [PATCH bpf-next 1/1] bpf: Add a BPF helper for getting the
 cgroup path of current task
To:     xufeng zhang <yunbo.xufeng@linux.alibaba.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        John Fastabend <john.fastabend@gmail.com>, joe@cilium.io,
        quentin@isovalent.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 14, 2021 at 6:06 AM xufeng zhang
<yunbo.xufeng@linux.alibaba.com> wrote:
>
>
> =E5=9C=A8 2021/5/13 =E4=B8=8A=E5=8D=886:55, Alexei Starovoitov =E5=86=99=
=E9=81=93:
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
> KP,
>
> do you have any suggestion?

I haven't really tried this yet, but have you considered using task local
storage to identify the container?

- Add a task local storage with container ID somewhere in the container
  manager
- Propagate this ID to all the tasks within a container using task security
  blob management hooks (like task_alloc and task_free) etc.

>
> what I am thinking is the internal kernel object(cgroup id or ns.inum)
> is not so user friendly, we can get the container-context from them for
> tracing scenario, but not for LSM blocking cases, I'm not sure how
> Google internally resolve similar issue.
>
>
> Thanks!
>
> Xufeng
>
