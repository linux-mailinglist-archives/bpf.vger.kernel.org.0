Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B9141CD7D
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 22:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346756AbhI2Ukx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 16:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346768AbhI2Ukw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Sep 2021 16:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632947950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1q2iWY5x6NtiyghS9gn8oPV2bKVir0LZN4nVYY52WSw=;
        b=gy8wXvUMs4i15vIKh9J3iYNg2uFLJUK9PUFGEC0Ypi3ddDVWk9ODvtDUk5pBde7jutGjZZ
        zNe8NuqswUZpOtZQWkJrHa7lVfDbirH4mycwu5sjF4m+loe4dvX7pX535GQvLt0WuuB9QQ
        W1shG2KBGndTTr27AOVaS1l9LSYZO74=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-J_ZLJyyQNBWj8H3uXcOodg-1; Wed, 29 Sep 2021 16:39:08 -0400
X-MC-Unique: J_ZLJyyQNBWj8H3uXcOodg-1
Received: by mail-ed1-f70.google.com with SMTP id u17-20020a50d511000000b003daa3828c13so3761496edi.12
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 13:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1q2iWY5x6NtiyghS9gn8oPV2bKVir0LZN4nVYY52WSw=;
        b=U5z3EkKGPeD/Ch2/PPGUZhes5GH0g3JMTJE48XVD0LFfEqFuE5jsdjqJm8hBEsE6YN
         A5GmXw4tlQXamyVRXGy7T1LpllEQDR4+iGZOCdoDNaZ51lLx4KP2HVrKxTTbpEWoVD0E
         BBzJD62X+wWP6ZDp0WUQpyt9mCofQCzj3FQ+dSYdhNnKF6rbKQkfKOX+A358blccg2oL
         LG2kXeHBZ+dRsHS/pP7MRGuik7o7AfMNK1RvUG8FcB+1ht+QZvePM0laDLXN4/gx1aAF
         DvSTwtoBmDpivsb+3jxmESAYSPw0PuvqXCgqbD+N3JmculkG+hTXaA++1E1Y1Wz7WeVz
         qysw==
X-Gm-Message-State: AOAM532poUBznUAJNAJGSg/Y1b/6kHExNoxV3fyqdIvGV2nWrxn9SDyD
        STa7bkVXSiC1X5R19riiwT/JjVmTkTa8XqF4Yz5Q/URtCaz/CNIIbKsECc/4D8+eSmtKkgCAWfb
        b1ThdEPpeCHiG
X-Received: by 2002:a05:6402:847:: with SMTP id b7mr2454878edz.242.1632947946873;
        Wed, 29 Sep 2021 13:39:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfFNcYoblnlae3U4yRwj0z0K5t3IzH+wSxByDMfEUiBPCc7QN8JJkD0RlKmLnCKsCQnU47yQ==
X-Received: by 2002:a05:6402:847:: with SMTP id b7mr2454830edz.242.1632947946525;
        Wed, 29 Sep 2021 13:39:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v13sm504982edr.0.2021.09.29.13.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 13:39:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E2F4718034F; Wed, 29 Sep 2021 22:39:03 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, shayagr@amazon.com,
        John Fastabend <john.fastabend@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Saeed Mahameed <saeed@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        tirthendu.sarkar@intel.com
Subject: Re: [PATCH v14 bpf-next 00/18] mvneta: introduce XDP multi-buffer
 support
In-Reply-To: <20210929122229.1d0c4960@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <cover.1631289870.git.lorenzo@kernel.org>
 <20210916095539.4696ae27@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CACAyw9-8t8RpJgJUTd7u6bOLnJ1xQsgK7z37QrL9T1FUaJ7WNQ@mail.gmail.com>
 <87v92jinv7.fsf@toke.dk>
 <CACAyw99S9v658UyiKz3ad4kja7rDNfYv+9VOXZHCUOtam_C8Wg@mail.gmail.com>
 <CAADnVQ+XXGUxzqMdbPMYf+t_ViDkqvGDdogrmv-wH-dckzujLw@mail.gmail.com>
 <20210929122229.1d0c4960@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 29 Sep 2021 22:39:03 +0200
Message-ID: <87mtnvi0bc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 29 Sep 2021 11:54:46 -0700 Alexei Starovoitov wrote:
>> I'm missing something. Why do we need a separate flush() helper?
>> Can't we do:
>> char buf[64], *p;
>> p = xdp_mb_pointer(ctx, flags, off, len, buf);
>> read/write p[]
>> if (p == buf)
>>     xdp_store_bytes(ctx, off, buf, len, flags);
>
> Sure we can. That's what I meant by "leave the checking to the program".
> It's bike shedding at this point.

Yeah, let's discuss the details once we have a patch :)

-Toke

