Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC26471558
	for <lists+bpf@lfdr.de>; Sat, 11 Dec 2021 19:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhLKSgD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Dec 2021 13:36:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231733AbhLKSgD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 11 Dec 2021 13:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639247762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ajlmog3xH6YXGMfi/eJM6BOlcjlzkfu8C1zEPFmZomM=;
        b=Lmo/S7B7XxqmsWv4ZyWhLh+mTzN1LBINvPIm7H75/zmxX/fKw7dHJHVJ7MuXhM3aCrLCqO
        FdlXMI9fB098hlyWgO5JCP4c3EZC/KVg0NMJ8jJMgi606M5HfLJ679ONodzWvm0pfQDtLh
        u2VRHWNvnxc3tm1N4jn1z8JA8XgY+rs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-2S08qbE5NUa0_FBBJuJthA-1; Sat, 11 Dec 2021 13:36:01 -0500
X-MC-Unique: 2S08qbE5NUa0_FBBJuJthA-1
Received: by mail-ed1-f71.google.com with SMTP id d13-20020a056402516d00b003e7e67a8f93so10853193ede.0
        for <bpf@vger.kernel.org>; Sat, 11 Dec 2021 10:36:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Ajlmog3xH6YXGMfi/eJM6BOlcjlzkfu8C1zEPFmZomM=;
        b=3sr3qD0Jc7hkpOofex6QejS2c3yryHeDCWJx+34hQSDBFB7s081wp3oCepc4Gh/hV5
         ajZC8+lMRO/hFeX5I/vES2FHM0NgaXGG/Q3Z4p+68s+8JyApmjQAzIo7IDVGCCerImxp
         95KZvMF7h+1swI1P/1G5s+5K0NV2IiylOpBNtKp2wy5ZZ72Qt/BhPwfT6Y+9YcBT6UPp
         XgyhjwZ9ZYF4egn9xLJMDFJD6zbaSgNK+r0F3Q6EdFuRfBJ9dmEmVXIEnMsp9cl1zy4X
         VwCm7B+yD0QudfRTChyaLAkJJXs5TqbA51Cyio4U1ESlMGKrYMMbJ+gaM6NuB3oyGINP
         T89w==
X-Gm-Message-State: AOAM5308lr9fyJklloCqW92KSzLQL+phgxJu0HgWtAKGvCIW/aLyBr1o
        GAlnT8LwkbsBVIOlJh5TUb6PjHb3LZ27P8WH1GLAouiPlvCjcoY7xpX9Wi2iM9RdACrmr11inE1
        XjpqLE6drIl6b
X-Received: by 2002:a17:906:4bcf:: with SMTP id x15mr32858840ejv.273.1639247759927;
        Sat, 11 Dec 2021 10:35:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAFqc5JuXJpR1PDi7k/x9dO4ZE+BE0VTGlDb2bqnamOUNKbVBx1kYG1eQmBCh9kyvI7D29gw==
X-Received: by 2002:a17:906:4bcf:: with SMTP id x15mr32858809ejv.273.1639247759610;
        Sat, 11 Dec 2021 10:35:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q7sm3522535edr.9.2021.12.11.10.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 10:35:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 156FE180471; Sat, 11 Dec 2021 19:35:58 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Florian Westphal <fw@strlen.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 7/9] net/netfilter: Add unstable CT lookup
 helpers for XDP and TC-BPF
In-Reply-To: <YbPcxjdsdqepEQAJ@salvia>
References: <20211210130230.4128676-1-memxor@gmail.com>
 <20211210130230.4128676-8-memxor@gmail.com> <YbNtmlaeqPuHHRgl@salvia>
 <20211210153129.srb6p2ebzhl5yyzh@apollo.legion> <YbPcxjdsdqepEQAJ@salvia>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 11 Dec 2021 19:35:58 +0100
Message-ID: <87pmq3ugz5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> writes:

> On Fri, Dec 10, 2021 at 09:01:29PM +0530, Kumar Kartikeya Dwivedi wrote:
>> On Fri, Dec 10, 2021 at 08:39:14PM IST, Pablo Neira Ayuso wrote:
>> > On Fri, Dec 10, 2021 at 06:32:28PM +0530, Kumar Kartikeya Dwivedi wrote:
>> > [...]
>> > >  net/netfilter/nf_conntrack_core.c | 252 ++++++++++++++++++++++++++++++
>> > >  7 files changed, 497 insertions(+), 1 deletion(-)
>> > >
>> > [...]
>> > > diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
>> > > index 770a63103c7a..85042cb6f82e 100644
>> > > --- a/net/netfilter/nf_conntrack_core.c
>> > > +++ b/net/netfilter/nf_conntrack_core.c
>> >
>> > Please, keep this new code away from net/netfilter/nf_conntrack_core.c
>> 
>> Ok. Can it be a new file under net/netfilter, or should it live elsewhere?
>
> IPVS and OVS use conntrack for already quite a bit of time and they
> keep their code in their respective folders.

Those are users, though. This is adding a different set of exported
functions, like a BPF version of EXPORT_SYMBOL(). We don't put those
outside the module where the code lives either...

I can buy not wanting to bloat nf_conntrack_core.c, but what's the
problem with adding a net/netfilter_nf_conntrack_bpf.c that gets linked
into the same kmod?

-Toke

