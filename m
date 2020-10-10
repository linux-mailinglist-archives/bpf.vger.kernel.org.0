Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDA928A222
	for <lists+bpf@lfdr.de>; Sun, 11 Oct 2020 00:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbgJJWzF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Oct 2020 18:55:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731390AbgJJTTJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 10 Oct 2020 15:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602357547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I7EtWAFY7JZkjFe439jiLJXYfP9d4SSV/XXrbixkMTA=;
        b=jNbjyF6TJlTszsq644bbP6OX6kMihnXVfJI1WIlzUdVXsLYDZu69cVkt2ng7DmSKSls9zE
        fSRCcGsADjfppD4jTMrgaAslpIJlwa2pkds7HEUMweGjKW57j7eycbbYNZBcBfP0pQtYho
        NYJI91stUGtOI/veu40q7umk8MID50g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-Ffj3lfbLPXOs70okA44FCg-1; Sat, 10 Oct 2020 09:42:29 -0400
X-MC-Unique: Ffj3lfbLPXOs70okA44FCg-1
Received: by mail-ed1-f69.google.com with SMTP id ay19so4586963edb.23
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2020 06:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=I7EtWAFY7JZkjFe439jiLJXYfP9d4SSV/XXrbixkMTA=;
        b=DZfaZ8tGertaYdsAkuO1+JMPMyOSaEOxD/842UxjX86Gbk2Me4EeXmFpYfa+VFmaxo
         WU4xpWKN9jYFKmpij1hUr875pW01vdDJX6FYApSee+GpEf2ohb6vCxXpX69ZtsEANX4e
         fJlS6hv4gC/GVbue2vHibPNviirHUqVbx0YyQARF+Qh3ZhpRJdHscXn7hMqCU7JiKey7
         2TMGxp0EDK2x0FYjVPUw9IrqZ1v8pB4bwv61Xkvyw+92jKqxYUHg41q3HQ0VPlY8ehPA
         g1yzLtZWA0cwpGw27zxQxmZyfPSRUg6e3Lko3eZGBnncco9jyNzsdIE7fcjARD8vnU0b
         ELzA==
X-Gm-Message-State: AOAM532L0ReRYzfJ6fWTwyicb4Xc+2As+6F0IzcQFL24FcKgCz5an2X2
        ufQa6ImWX2ME6H33zmr+7hGe0R/lg7SCI0JLPWsWZzOiaq5ITFryx18yCejBzp7H/8zLQDm/vta
        Pww1IbEO/GMeo
X-Received: by 2002:a50:9e82:: with SMTP id a2mr4434355edf.117.1602337348406;
        Sat, 10 Oct 2020 06:42:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRFYyKJ+aPffjXFZCfi9lvWRyUVm5adDV3YDqMCJh+hWfnSgr49bo7ImHn8OwBSsA1PPA7+A==
X-Received: by 2002:a50:9e82:: with SMTP id a2mr4434330edf.117.1602337348029;
        Sat, 10 Oct 2020 06:42:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id me12sm7940575ejb.108.2020.10.10.06.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2020 06:42:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 65D3B1837E5; Sat, 10 Oct 2020 15:42:26 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>, ast@fb.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf_fib_lookup: optionally skip neighbour
 lookup
In-Reply-To: <50fc3fee-13b2-11d1-f5b1-e0d8669cd655@iogearbox.net>
References: <20201009101356.129228-1-toke@redhat.com>
 <0a463800-a663-3fd3-2e1a-eac5526ed691@gmail.com> <87v9fjckcd.fsf@toke.dk>
 <4972626e-c86d-8715-0565-20bed680227c@gmail.com>
 <50fc3fee-13b2-11d1-f5b1-e0d8669cd655@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 10 Oct 2020 15:42:26 +0200
Message-ID: <87v9fitcxp.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 10/9/20 11:28 PM, David Ahern wrote:
>> On 10/9/20 11:42 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> David Ahern <dsahern@gmail.com> writes:
>>>> On 10/9/20 3:13 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>> The bpf_fib_lookup() helper performs a neighbour lookup for the desti=
nation
>>>>> IP and returns BPF_FIB_LKUP_NO_NEIGH if this fails, with the expectat=
ion
>>>>> that the BPF program will pass the packet up the stack in this case.
>>>>> However, with the addition of bpf_redirect_neigh() that can be used i=
nstead
>>>>> to perform the neighbour lookup, at the cost of a bit of duplicated w=
ork.
>>>>>
>>>>> For that we still need the target ifindex, and since bpf_fib_lookup()
>>>>> already has that at the time it performs the neighbour lookup, there =
is
>>>>> really no reason why it can't just return it in any case. So let's ju=
st
>>>>> always return the ifindex, and also add a flag that lets the caller t=
urn
>>>>> off the neighbour lookup entirely in bpf_fib_lookup().
>>>>
>>>> seems really odd to do the fib lookup only to skip the neighbor lookup
>>>> and defer to a second helper to do a second fib lookup and send out.
>>>>
>>>> The better back-to-back calls is to return the ifindex and gateway on
>>>> successful fib lookup regardless of valid neighbor. If the call to
>>>> bpf_redirect_neigh is needed, it can have a flag to skip the fib lookup
>>>> and just redirect to the given nexthop address + ifindex. ie.,
>>>> bpf_redirect_neigh only does neighbor handling in this case.
>>>
>>> Hmm, yeah, I guess it would make sense to cache and reuse the lookup -
>>> maybe stick it in bpf_redirect_info()? However, given the imminent
>>=20
>> That is not needed.
>>=20
>>> opening of the merge window, I don't see this landing before then. So
>>> I'm going to respin this patch with just the original change to always
>>> return the ifindex, then we can revisit the flags/reuse of the fib
>>> lookup later.
>>=20
>> What I am suggesting is a change in API to bpf_redirect_neigh which
>> should be done now, before the merge window, before it comes a locked
>> API. Right now, bpf_redirect_neigh does a lookup to get the nexthop. It
>> should take the gateway as an input argument. If set, then the lookup is
>> not done - only the neighbor redirect.
>
> Sounds like a reasonable extension, agree. API freeze is not merge win, b=
ut
> final v5.10 tag in this case as it always has been. In case it's not in t=
ime,
> we can simply just move flags to arg3 and add a reserved param as arg2 wh=
ich
> must be zero (and thus indicate to perform the lookup as-is). Later we co=
uld
> extend to pass params similar as in fib_lookup helper for the gw.

Right, I can take a look at this next week. Feel free to merge (v3 of)
this patch now, that change will be needed in any case I think...

-Toke

