Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DE4326214
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 12:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhBZLoj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 06:44:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhBZLoi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 06:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614339791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t2fgVufcTrJmZD93R7raUQEAmu7odu1BskLOilLiKQ0=;
        b=HOtPw9ACb5fOFSH6NrHEG2aHDACp+cdFRt9LS+deeHLq0T3ZOX+0thRWtb1VFaTSRt8F6c
        tJCWwbXL4hdyFmHQa9AGTe9GTk3QBkhPkgkvJFzdj4EuQc3515bdcbre6JY0NrtMRAwJN7
        +AarrYgAkoN0Xfl1bKehFBO7299jCbQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-isKZasxMNnihNytbmh5ucg-1; Fri, 26 Feb 2021 06:43:09 -0500
X-MC-Unique: isKZasxMNnihNytbmh5ucg-1
Received: by mail-ed1-f71.google.com with SMTP id w9so4333359edi.15
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 03:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=t2fgVufcTrJmZD93R7raUQEAmu7odu1BskLOilLiKQ0=;
        b=dWdXRhsaMVR7hQ0peUe9LMQl20X4uqOND+4P5heT2Qhagco64dH1nI3SbAAzKcTbgL
         l4zdotTiOF3xmjlc5FnKK6KP0uA58CeMV3XT0RrUsDWeK/y8CC5ne6D7ukEoWPxaTWza
         5SSUA3++J4D8UXeEuWwR2llv9AFGKExowh3epz+lDhog7uATme2BLpaE++w99QudyzMU
         AL27MofyInfZciHn1QSfp0KnCXs19GS64w4mLBxmCB1E6slPUP79U3gqmfUhCX0GpKRV
         1JYDoQAEHzy+SOtYP/37U33Jn+JNAJYVaj1lH3T0nI9UJsj8lFCSQNOp90FN5Nutr0F2
         qP+A==
X-Gm-Message-State: AOAM530HCwvFO3JTa3iwFVATW15uRb5lDjQUsxSwnBmIGhqVVWPEtmoF
        xg14XY83uNcXqjCsMZBGp2srGQxjZeKzeH4dkHzBiVDdBgh7iyqpYhkHuGAhSJSycc16LRaFbSA
        25W7+G2JRHZFj
X-Received: by 2002:a17:906:503:: with SMTP id j3mr2885988eja.172.1614339788203;
        Fri, 26 Feb 2021 03:43:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwH0VmMX7NuXtztbUxTJFUFA710jWxAukUXoBUo3DQGO4ZwoqOZE0nQoVSDr2hnqyKvfQNtzQ==
X-Received: by 2002:a17:906:503:: with SMTP id j3mr2885962eja.172.1614339787958;
        Fri, 26 Feb 2021 03:43:07 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id j17sm5595659edv.66.2021.02.26.03.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 03:43:07 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 64C55180094; Fri, 26 Feb 2021 12:43:07 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     maciej.fijalkowski@intel.com, hawk@kernel.org,
        magnus.karlsson@intel.com, john.fastabend@gmail.com,
        kuba@kernel.org, davem@davemloft.net
Subject: Re: [PATCH bpf-next v4 0/2] Optimize
 bpf_redirect_map()/xdp_do_redirect()
In-Reply-To: <1759bd57-0c52-d1f2-d620-e7796f95cff6@intel.com>
References: <20210226112322.144927-1-bjorn.topel@gmail.com>
 <87v9afysd0.fsf@toke.dk> <1759bd57-0c52-d1f2-d620-e7796f95cff6@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 26 Feb 2021 12:43:07 +0100
Message-ID: <87pn0nyrzo.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com> writes:

> On 2021-02-26 12:35, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:
>>=20
>>> Hi XDP-folks,
>>>
>>> This two patch series contain two optimizations for the
>>> bpf_redirect_map() helper and the xdp_do_redirect() function.
>>>
>>> The bpf_redirect_map() optimization is about avoiding the map lookup
>>> dispatching. Instead of having a switch-statement and selecting the
>>> correct lookup function, we let bpf_redirect_map() be a map operation,
>>> where each map has its own bpf_redirect_map() implementation. This way
>>> the run-time lookup is avoided.
>>>
>>> The xdp_do_redirect() patch restructures the code, so that the map
>>> pointer indirection can be avoided.
>>>
>>> Performance-wise I got 3% improvement for XSKMAP
>>> (sample:xdpsock/rx-drop), and 4% (sample:xdp_redirect_map) on my
>>> machine.
>>>
>>> More details in each commit.
>>>
>>> @Jesper/Toke I dropped your Acked-by: on the first patch, since there
>>> were major restucturing. Please have another look! Thanks!
>>=20
>> Will do! Did you update the performance numbers above after that change?
>>
>
> I did. The XSKMAP performance stayed the same (no surprise, since the
> code was the same). However, for the DEVMAP the v4 got rid of a call, so
> it *should* be a bit better, but for some reason it didn't show on my
> machine.

Alright, fair enough - pesky real world not lining up with expectations!
Maybe Jesper has additional suggestions, but I can live with the 4%
improvement ;)

-Toke

