Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7918F3C1592
	for <lists+bpf@lfdr.de>; Thu,  8 Jul 2021 17:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhGHPEO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Jul 2021 11:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31416 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229738AbhGHPEN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Jul 2021 11:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625756491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E8Pcfl0gqcPBUL1m77+/3iyVOTtd5zHFsGGjer4gKVM=;
        b=WGJqOsa7brJFzASvRzyf0fbmxObFI1YHUpOC81ysGOhYZu1rJkAZVE29sPFNidbIIzznlg
        ul1U3hovWND0yG29/iNT6veAj3ghcY9pVLcIsSuFgV5ZbV5flyacfu3WlTQGT7VE4qkdVK
        yTmuowTtw1cFpI8xwRqZvqCc7oMH9NA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-ljqMO5AENUasQm_IkmstKw-1; Thu, 08 Jul 2021 11:01:30 -0400
X-MC-Unique: ljqMO5AENUasQm_IkmstKw-1
Received: by mail-ej1-f71.google.com with SMTP id ci2-20020a1709072662b02904ce09e83b00so1964405ejc.23
        for <bpf@vger.kernel.org>; Thu, 08 Jul 2021 08:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=E8Pcfl0gqcPBUL1m77+/3iyVOTtd5zHFsGGjer4gKVM=;
        b=o56OzkEIyDH/F0HKwxB4QwRHN8YZcXDsG1yf/FWVI1dBdjRnFqXZqlU9yeI9P9bqkc
         BbVFSmJFEVXArWX6NRy7IyvvswWVbcBaJRjTdWFCw4w2waMo/nSr2No0OmsxrSnTyfMg
         ysEh9UWuLG865pWu93n3licYDJDo5HR7LMueapPMQIzwAr3eXmldsN7X/KOdj0Dh0gUz
         R/UUao/gOhFBx1eFhqn4yQiuS4Awh18G0epAy8ixwenqW1nSoksRzOwmSr/6UQqcyZa/
         GFBpC/iFoAJebLs4QceELpvmFufyj8obSlZ49q0FVetuAV6oG6Bc6ntXvAPoZpqLeaYL
         E5cA==
X-Gm-Message-State: AOAM532CdYt68eXpkZfBiq6B/6Rd5/69vdCRPeaPuLr/o1sU8VSCbUTD
        MGJ/l57DEWLqWqIGRCboFesOCJggkLnKXTcY1RmeOPtDm1fDp0KkHDiZW6b2fSmRn2kkjlSAq2k
        SgLeSosgbNxXq
X-Received: by 2002:a05:6402:5114:: with SMTP id m20mr39449688edd.174.1625756488387;
        Thu, 08 Jul 2021 08:01:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVe3QcMnua09KrtS6j9ghQdTNnNsWXXqcnb7UF7RBgyKCh0bps7sn+LHuMXy+lJO7qC+uU6g==
X-Received: by 2002:a05:6402:5114:: with SMTP id m20mr39449626edd.174.1625756487864;
        Thu, 08 Jul 2021 08:01:27 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id s4sm1407503edu.49.2021.07.08.08.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 08:01:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 911F5180733; Thu,  8 Jul 2021 17:01:26 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martynas Pumputis <m@lambda.lt>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf] libbpf: fix reuse of pinned map on older kernel
In-Reply-To: <41795594-5d66-e17e-095c-cc4cdc84a017@lambda.lt>
References: <20210706172619.579001-1-m@lambda.lt>
 <CAEf4BzbCAO=hjA=hSh9QXN3C79xOmM0=Cc0H1gZnhm6LdDz9Sw@mail.gmail.com>
 <41795594-5d66-e17e-095c-cc4cdc84a017@lambda.lt>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 08 Jul 2021 17:01:26 +0200
Message-ID: <87sg0ovohl.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martynas Pumputis <m@lambda.lt> writes:

> On 7/8/21 12:58 AM, Andrii Nakryiko wrote:
>> On Tue, Jul 6, 2021 at 10:24 AM Martynas Pumputis <m@lambda.lt> wrote:
>>>
>>> When loading a BPF program with a pinned map, the loader checks whether
>>> the pinned map can be reused, i.e. their properties match. To derive
>>> such of the pinned map, the loader invokes BPF_OBJ_GET_INFO_BY_FD and
>>> then does the comparison.
>>>
>>> Unfortunately, on < 4.12 kernels the BPF_OBJ_GET_INFO_BY_FD is not
>>> available, so loading the program fails with the following error:
>>>
>>>          libbpf: failed to get map info for map FD 5: Invalid argument
>>>          libbpf: couldn't reuse pinned map at
>>>                  '/sys/fs/bpf/tc/globals/cilium_call_policy': parameter
>>>                  mismatch"
>>>          libbpf: map 'cilium_call_policy': error reusing pinned map
>>>          libbpf: map 'cilium_call_policy': failed to create:
>>>                  Invalid argument(-22)
>>>          libbpf: failed to load object 'bpf_overlay.o'
>>>
>>> To fix this, probe the kernel for BPF_OBJ_GET_INFO_BY_FD support. If it
>>> doesn't support, then fallback to derivation of the map properties via
>>> /proc/$PID/fdinfo/$MAP_FD.
>>>
>>> Signed-off-by: Martynas Pumputis <m@lambda.lt>
>>> ---
>>>   tools/lib/bpf/libbpf.c | 103 +++++++++++++++++++++++++++++++++++++++++++++------
>>>   1 file changed, 92 insertions(+), 11 deletions(-)
>>>
>> 
>> [...]
>> 
>>> @@ -4406,10 +4478,19 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
>>>
>>>          map_info_len = sizeof(map_info);
>>>
>>> -       if (bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len)) {
>>> -               pr_warn("failed to get map info for map FD %d: %s\n",
>>> -                       map_fd, libbpf_strerror_r(errno, msg, sizeof(msg)));
>>> -               return false;
>>> +       if (kernel_supports(obj, FEAT_OBJ_GET_INFO_BY_FD)) {
>> 
>> why not just try bpf_obj_get_info_by_fd() first, and if it fails
>> always fallback to bpf_get_map_info_from_fdinfo(). No need to do
>> feature detection. This will cut down on the amount of code without
>> any regression in behavior. More so, it will actually now be
>> consistent and good behavior in case of bpf_map__reuse_fd() where we
>> don't have obj. WDYT?
>
> I was thinking about it, but then decided to use the kernel probing 
> instead. The reasoning was the following:
>
> 1) For programs with many pinned maps we would issue many failing 
> BPF_OBJ_GET_INFO_BY_FD calls (instead of a single one) which might 
> hinder the performance.

"Might" hinder the performance? Did you measure this? We're usually
talking (at most) dozens of maps per object file, not thousands; also,
this would only be incurred if the initial call actually fails (i.e., on
old kernels).

> 2) A canonical way in libbpf to detect features is via kernel_supports() 
> and friends, so I didn't want to diverge there.
>
> Re bpf_map__reuse_fd(), if we are OK to break the API before libbpf 
> v1.0, then we could extend bpf_map__reuse_fd() to accept the obj. 
> However, this would break some consumers of the lib, e.g., iproute2 [1].

IMO, this does not sound like something worth breaking the API
compatibility for...

-Toke

