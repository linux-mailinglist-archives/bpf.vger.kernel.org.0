Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1273398481
	for <lists+bpf@lfdr.de>; Wed,  2 Jun 2021 10:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbhFBIty (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Jun 2021 04:49:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49997 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232822AbhFBItt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Jun 2021 04:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622623686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QAqDQbuc2zHT+lmvkpkliupEQ5G+pBOcwfPuyVGkZ4M=;
        b=e5U296M4a+m6Up0N6568RA9rPQfdLxacxq9IaJvKiLNsg/fNrMtHE0HyK4OKuTAbbmj+Ki
        sjv6hrK6kwP/HVZEd+hp0zBfo6szo9eb1tdJrKg/X8P14yCT8P04lEnmj8fvOlljfHZL7t
        VU7lLIopYAXR3PRNuAfZbxy6xfz91wM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-wIjJW2JAM9GLCY5HmL13LA-1; Wed, 02 Jun 2021 04:48:05 -0400
X-MC-Unique: wIjJW2JAM9GLCY5HmL13LA-1
Received: by mail-ej1-f69.google.com with SMTP id j16-20020a1709062a10b02903ba544485d0so423392eje.3
        for <bpf@vger.kernel.org>; Wed, 02 Jun 2021 01:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=QAqDQbuc2zHT+lmvkpkliupEQ5G+pBOcwfPuyVGkZ4M=;
        b=LIxIsMaac35RFPKseVK3NJTaDvXchj8I30ENTbPOsvKKxi18/h1S8Fap8cDZe13klK
         kXFRHWHa2mC7x/q6GEEOvbvGM0jRiwetEuvuTraU36cbbmyOsoGjNxH0fXdg3jTQwggf
         Z4Rv6GZdMDK1uFdUmdkR/7T0VRqiZc7flCFyITWj+Ude23CR1PcZJ4zh2uW31nqoVLv2
         juICLkRsxtVB+J1ZDrpOTuLo8R56ZgnqZ9En4kmlXO2W8craV9XGGKOu1S0nrlKNIiSj
         jDk+ziLpF5RzSaHz7yR/rNgPjSl8jHVyXR3V20/RtB/2NkMKSzptXKOH9TiYJT/fId1G
         JIKg==
X-Gm-Message-State: AOAM531ZjYRgt3EajuL1JeymtkaTR7JXoXOJlM78eenJRFhawEBXCkoM
        8haK5+W0LonFvpkBhnDq8c4+9HF+mlcTtZaIbzlfBE4HJ1YaGta21YkQcLK2sEI/KCWBjf9nGf/
        IrcA3a5dr+iX2
X-Received: by 2002:aa7:cb5a:: with SMTP id w26mr4404203edt.139.1622623684383;
        Wed, 02 Jun 2021 01:48:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywfTaE0hAprvL9p9WssZnPY02Ob4LEn6uB7GNvr1kyQ4a1zhsGY1pnoio1QZitdVpv/kIDLA==
X-Received: by 2002:aa7:cb5a:: with SMTP id w26mr4404188edt.139.1622623684082;
        Wed, 02 Jun 2021 01:48:04 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id n16sm893224edw.26.2021.06.02.01.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 01:48:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CF229180726; Wed,  2 Jun 2021 10:48:02 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@fb.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Introduce bpf_timer
In-Reply-To: <20210602020030.igrx5jp45tocekvy@ast-mbp.dhcp.thefacebook.com>
References: <20210520185550.13688-1-alexei.starovoitov@gmail.com>
 <CAM_iQpWDgVTCnP3xC3=z7WCH05oDUuqxrw2OjjUC69rjSQG0qQ@mail.gmail.com>
 <CAADnVQ+V5o31-h-A+eNsHvHgOJrVfP4wVbyb+jL2J=-ionV0TA@mail.gmail.com>
 <CAM_iQpU-Cvpf-+9R0ZdZY+5Dv+stfodrH0MhvSgryv_tGiX7pA@mail.gmail.com>
 <CAM_iQpVYBNkjDeo+2CzD-qMnR4-2uW+QdMSf_7ohwr0NjgipaQ@mail.gmail.com>
 <CAADnVQJUHydpLwtj9hRWWNGx3bPbdk-+cQiSe3MDFQpwkKmkSw@mail.gmail.com>
 <CAM_iQpXUBuOirztj3kifdFpvygKb-aoqwuXKkLdG9VFte5nynA@mail.gmail.com>
 <20210602020030.igrx5jp45tocekvy@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 02 Jun 2021 10:48:02 +0200
Message-ID: <874kegbqkd.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

>> > In general the garbage collection in any form doesn't scale.
>> > The conntrack logic doesn't need it. The cillium conntrack is a great
>> > example of how to implement a conntrack without GC.
>> 
>> That is simply not a conntrack. We expire connections based on
>> its time, not based on the size of the map where it residents.
>
> Sounds like your goal is to replicate existing kernel conntrack
> as bpf program by doing exactly the same algorithm and repeating
> the same mistakes. Then add kernel conntrack functions to allow list
> of kfuncs (unstable helpers) and call them from your bpf progs.

FYI, we're working on exactly this (exposing kernel conntrack to BPF).
Hoping to have something to show for our efforts before too long, but
it's still in a bit of an early stage...

-Toke

