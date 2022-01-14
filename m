Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6711A48EEB0
	for <lists+bpf@lfdr.de>; Fri, 14 Jan 2022 17:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243621AbiANQub (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jan 2022 11:50:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243602AbiANQua (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 14 Jan 2022 11:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642179029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aog+Xm4qfU3nqJAaFVSSDCOw9xaUbeG0yHB/PP3Bm0g=;
        b=jIlIzzPIEGguquc175sJzC08CBTUqrgCmTJJzuge7YcAlssMWMVQLWLFJoNkrOSGGGw2Jq
        ate0r3F9o4jeRZZxojHIFa7QS+Lu6py3OA6567SfsSQdD31k87n+uegi5vEFPpm/cIKUKA
        qyOmyer5DQRpeoe6YdFKU/gvhvyOhjo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-UkuoMKDqOLKV4RLPiHhxsg-1; Fri, 14 Jan 2022 11:50:28 -0500
X-MC-Unique: UkuoMKDqOLKV4RLPiHhxsg-1
Received: by mail-ed1-f70.google.com with SMTP id z10-20020a05640235ca00b003f8efab3342so8639266edc.2
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 08:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=Aog+Xm4qfU3nqJAaFVSSDCOw9xaUbeG0yHB/PP3Bm0g=;
        b=Ub7saRIulwpyDR/Tq/kASqTFpXHg/8kJ6xwi+aZC3zp63swZ8bRl69RcnYH3zTeLfe
         /SKrSK76JhbqVP72VP9fDV+TiJ6CCqn5fhAEGn6k89IGxrAy3gTrrD8k00P6QBWMpW64
         UH1s3D1Fd0/GlDJfZWRPAlInZmQxfGR7OzNeU0+O6kQ0Asyp0h9PP4uOxUBeULzG7zIC
         aFdE0xp2MU6kBfyY8ZOofikjMsiywdshVC02VZW5N48sSMDhl+YrV2OQVI2bt850r6vX
         B3sEGQ/SRaGozla8X7gRqkHMhXGYk2UUGMOJ2eCX0egJKpf6ccIGxX0f7m7HJTkDPRRJ
         K5UA==
X-Gm-Message-State: AOAM531Wv/I3ULLk9mjhmcxZte8PWGaEptKl1Glx4Wt51LOhUd4VstyD
        AWBNYhGPO5PJkVyKQu8yQ4fCetnYJahrBVnFmhxwZQeaPKmYQIEvDvTy9nIjEGmbn4/oF7H/K4L
        jFhtb+KTy7g2O
X-Received: by 2002:a17:907:6e89:: with SMTP id sh9mr7871948ejc.309.1642179026603;
        Fri, 14 Jan 2022 08:50:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx289mMFaskSpHlDQKd6krI58HMAi62MQ740w6gblEPsMNl6GOH2PzyU4F3wqziA3sWWpEG6g==
X-Received: by 2002:a17:907:6e89:: with SMTP id sh9mr7871918ejc.309.1642179026343;
        Fri, 14 Jan 2022 08:50:26 -0800 (PST)
Received: from [192.168.2.20] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id s3sm1982831ejs.145.2022.01.14.08.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 08:50:25 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <e86ccea8-af77-83bf-e90e-dce88b26f07c@redhat.com>
Date:   Fri, 14 Jan 2022 17:50:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Cc:     brouer@redhat.com, Jesper Dangaard Brouer <jbrouer@redhat.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Zvi Effron <zeffron@riotgames.com>,
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
Subject: Re: [PATCH v21 bpf-next 18/23] libbpf: Add SEC name for xdp_mb
 programs
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
References: <CAEf4Bza+WO5U+Kw=S+GvQBgu5VHfPL29u7eLSQq34jvYzGnbBA@mail.gmail.com>
 <CAADnVQLGxjvOO3Ae3mGTWTyd0aHnACxYoF8daNi+z56NQyYQug@mail.gmail.com>
 <CAEf4BzZ4c1VwPf9oBRRdN7jdBWrk4pg=mw_50LMjLr99Mb0yfw@mail.gmail.com>
 <CAADnVQ+BiMy4TZNocfFSvazh-QTFwMD-3uQ9LLiku7ePLDn=MQ@mail.gmail.com>
 <CAC1LvL0CeTw+YKjO6r0f68Ly3tK4qhDyjV0ak82e0PpHURVQOw@mail.gmail.com>
 <Yd82J8vxSAR9tvQt@lore-desk> <8735lshapk.fsf@toke.dk>
 <47a3863b-080c-3ac2-ff2d-466b74d82c1c@redhat.com>
 <Yd/9SPHAPH3CpSnN@lore-desk>
 <CAADnVQJaB8mmnD1Z4jxva0CqA2D0aQDmXggMEQPX2MRLZvoLzA@mail.gmail.com>
 <YeC8sOAeZjpc4j8+@lore-desk>
 <CAADnVQ+=0k1YBbkMmSKSBtkmiG8VCYZ5oKGjPPr4s9c53QF-mQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+=0k1YBbkMmSKSBtkmiG8VCYZ5oKGjPPr4s9c53QF-mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 14/01/2022 03.09, Alexei Starovoitov wrote:
> On Thu, Jan 13, 2022 at 3:58 PM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>>>
>>> Btw "xdp_cpumap" should be cleaned up.
>>> xdp_cpumap is an attach type. It's not prog type.
>>> Probably it should be "xdp/cpumap" to align with "cgroup/bind[46]" ?
>>
>> so for xdp "mb" or xdp "frags" it will be xdp/cpumap.mb (xdp/devmap.mb) or
>> xdp/cpumap.frags (xdp/devmap.frags), right?
> 
> xdp.frags/cpumap
> xdp.frags/devmap
> 
> The current de-facto standard for SEC("") in libbpf:
> prog_type.prog_flags/attach_place

Ups, did we make a mistake with SEC("xdp_devmap/")

and can we correct without breaking existing programs?

> "attach_place" is either function_name for fentry/, tp/, lsm/, etc.
> or attach_type/hook/target for cgroup/bind4, cgroup_skb/egress.
> 
> lsm.s/socket_bind -> prog_type = LSM, flags = SLEEPABLE
> lsm/socket_bind -> prog_type = LSM, non sleepable.
> 

