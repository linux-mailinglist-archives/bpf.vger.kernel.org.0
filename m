Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B773148F032
	for <lists+bpf@lfdr.de>; Fri, 14 Jan 2022 19:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243551AbiANSzi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jan 2022 13:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiANSzi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Jan 2022 13:55:38 -0500
Received: from mail-pf1-x463.google.com (mail-pf1-x463.google.com [IPv6:2607:f8b0:4864:20::463])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A2DC061574
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 10:55:38 -0800 (PST)
Received: by mail-pf1-x463.google.com with SMTP id f144so2775567pfa.6
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 10:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to:cc;
        bh=Hy5aZ4Roey3EFS/MVuvVyRUa8ToAzix3WO2/RHWO60I=;
        b=JomTLyLauO5E7uPwXAHC1AnsyeUdcSG3jt6DRgdh19mhRNH/Vosst72PUmj9THNYSb
         Y+WlhVKiV7zg5kDAtGOXbPIvcm0ys3PPFBgdnZ14N6bXDwxG6Rvz69QjmETUWCP5kUaB
         NrUCZXeQTYH2m7l7wKoTEMHX358Ae/R8fenJ6i28BcD1FDaWhbniKgrlV8djVyF5kMvs
         eUAoZQDkLgCjSX7rn6GUbS/fVELwRYqS9ya+8Pk3M2pTJZZy8y1Vrfb2KEnpn2/B3Qgf
         BPTXKICXwecMufGaq98QBxQvzfyHY7JCeCxbg0q0FjJg18UUiAS4GYrIqwZfWznapDQ0
         CoZA==
X-Gm-Message-State: AOAM533avqlHszQlXPXmiX8UTGe3zxvGPqhZfQkzfpuYh48SXVoC6wmN
        J43gyfdMn1l8UesSi8cwpzjou46bIjbQYXO5Dn2XvlQ7s/5yEw==
X-Google-Smtp-Source: ABdhPJyC+bEa+ewvUhtkCtD8WOf8JUXnLjtBQB1HllccGpK78uWj3JF+afj1qHa6TTSpWWtV1AJWMfYb+aVT
X-Received: by 2002:a63:be49:: with SMTP id g9mr8989700pgo.375.1642186537643;
        Fri, 14 Jan 2022 10:55:37 -0800 (PST)
Received: from netskope.com ([163.116.131.7])
        by smtp-relay.gmail.com with ESMTPS id lx2sm2372107pjb.13.2022.01.14.10.55.37
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 10:55:37 -0800 (PST)
X-Relaying-Domain: riotgames.com
Received: by mail-pg1-f198.google.com with SMTP id j37-20020a634a65000000b00349a11dc809so2361025pgl.3
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 10:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hy5aZ4Roey3EFS/MVuvVyRUa8ToAzix3WO2/RHWO60I=;
        b=YwWkfmnbohf8+9NcQ8MXUDzEzi1jb/TVO/GiB3NRMq+k2WWwXsHRzOBnrzTR/5nK5m
         qtRwrrByNyDa0X9hePyHkSdgLIALPbKCFv/BZwKNbGx0cCVusuCoO8J3RCgVRPU7AdMW
         HPWz9T0KpoAKL9MyULbPJsRIVd65/2w58R6yU=
X-Received: by 2002:aa7:9510:0:b0:4bd:ce79:d158 with SMTP id b16-20020aa79510000000b004bdce79d158mr10108449pfp.24.1642186536544;
        Fri, 14 Jan 2022 10:55:36 -0800 (PST)
X-Received: by 2002:aa7:9510:0:b0:4bd:ce79:d158 with SMTP id
 b16-20020aa79510000000b004bdce79d158mr10108421pfp.24.1642186536257; Fri, 14
 Jan 2022 10:55:36 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4Bza+WO5U+Kw=S+GvQBgu5VHfPL29u7eLSQq34jvYzGnbBA@mail.gmail.com>
 <CAADnVQLGxjvOO3Ae3mGTWTyd0aHnACxYoF8daNi+z56NQyYQug@mail.gmail.com>
 <CAEf4BzZ4c1VwPf9oBRRdN7jdBWrk4pg=mw_50LMjLr99Mb0yfw@mail.gmail.com>
 <CAADnVQ+BiMy4TZNocfFSvazh-QTFwMD-3uQ9LLiku7ePLDn=MQ@mail.gmail.com>
 <CAC1LvL0CeTw+YKjO6r0f68Ly3tK4qhDyjV0ak82e0PpHURVQOw@mail.gmail.com>
 <Yd82J8vxSAR9tvQt@lore-desk> <8735lshapk.fsf@toke.dk> <47a3863b-080c-3ac2-ff2d-466b74d82c1c@redhat.com>
 <Yd/9SPHAPH3CpSnN@lore-desk> <CAADnVQJaB8mmnD1Z4jxva0CqA2D0aQDmXggMEQPX2MRLZvoLzA@mail.gmail.com>
 <YeC8sOAeZjpc4j8+@lore-desk> <CAADnVQ+=0k1YBbkMmSKSBtkmiG8VCYZ5oKGjPPr4s9c53QF-mQ@mail.gmail.com>
 <e86ccea8-af77-83bf-e90e-dce88b26f07c@redhat.com>
In-Reply-To: <e86ccea8-af77-83bf-e90e-dce88b26f07c@redhat.com>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Fri, 14 Jan 2022 10:55:24 -0800
Message-ID: <CAC1LvL3M9OaSanES0uzp=vvgK23qPGRPpcAR6Z_Vqcvma3K5Qg@mail.gmail.com>
Subject: Re: [PATCH v21 bpf-next 18/23] libbpf: Add SEC name for xdp_mb programs
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, brouer@redhat.com,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shay Agroskin <shayagr@amazon.com>,
        john fastabend <john.fastabend@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Eelco Chaudron <echaudro@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Saeed Mahameed <saeed@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        tirthendu.sarkar@intel.com
Content-Type: text/plain; charset="UTF-8"
x-netskope-inspected: true
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 14, 2022 at 8:50 AM Jesper Dangaard Brouer
<jbrouer@redhat.com> wrote:
>
>
>
> On 14/01/2022 03.09, Alexei Starovoitov wrote:
> > On Thu, Jan 13, 2022 at 3:58 PM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >>>
> >>> Btw "xdp_cpumap" should be cleaned up.
> >>> xdp_cpumap is an attach type. It's not prog type.
> >>> Probably it should be "xdp/cpumap" to align with "cgroup/bind[46]" ?
> >>
> >> so for xdp "mb" or xdp "frags" it will be xdp/cpumap.mb (xdp/devmap.mb) or
> >> xdp/cpumap.frags (xdp/devmap.frags), right?
> >
> > xdp.frags/cpumap
> > xdp.frags/devmap
> >
> > The current de-facto standard for SEC("") in libbpf:
> > prog_type.prog_flags/attach_place
>
> Ups, did we make a mistake with SEC("xdp_devmap/")
>
> and can we correct without breaking existing programs?
>

We can (at the very least) add the correct sections, even if we leave the
current incorrect ones as well. Ideally we'd mark the incorrect ones deprecated
and either remove them before libbpf 1.0 or as part of 2.0?

--Zvi

> > "attach_place" is either function_name for fentry/, tp/, lsm/, etc.
> > or attach_type/hook/target for cgroup/bind4, cgroup_skb/egress.
> >
> > lsm.s/socket_bind -> prog_type = LSM, flags = SLEEPABLE
> > lsm/socket_bind -> prog_type = LSM, non sleepable.
> >
>
