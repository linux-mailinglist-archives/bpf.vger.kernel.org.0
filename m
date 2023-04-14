Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570466E2342
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 14:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDNMaL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 08:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjDNMaK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 08:30:10 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EB71BC5
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 05:30:06 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n9-20020a05600c4f8900b003f05f617f3cso16448122wmq.2
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 05:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681475405; x=1684067405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lcdXn+gQ2Fdms6yQMDsaRg+lsr216xu+/ri8K2zsM9k=;
        b=gJallV+FicPk3ve0MWABmYUWan01QVdpDotFpUpPF4dU6tgnxV3Lh1UuvaeA9iBtwW
         Ocz6oCHjkRiMUjk5w2/6yEN6KD6HbBVT015IXNz+63hiNY4yI3ix+MYDGCdCDImvXW+f
         uPirb9N56y1ADd24Ux8pt9SdbB1ugn4yHsCJ/kIhDwjYyH/T/QeutiipoNVox5rAsWjO
         glNPYHP3zWDa6DrBBCR3zjvul+J2OiztRCVi9h2gSjbxfadWnkajCJHwAT8UF1VQCTpV
         4PQPReSNfTVazRXP97Z5nFHLL6f5sEk6nhmer3zJB2RU/e306HM/ufbKXS+6WK9QTsXJ
         U2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681475405; x=1684067405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcdXn+gQ2Fdms6yQMDsaRg+lsr216xu+/ri8K2zsM9k=;
        b=D6l1IOWVhoD6FE1yr8qoDbrVIF+ITRM/Yr/XXg+yggj08gt8IMxRQcJFXH1Pzb2OMc
         C3cTedYjjeaXNKoQ67Nh9OdeUXK8UdiHo2PBVHT/3lC6NYn/x5nVxUXv6VUGlGAmAioH
         2IGI8Dr/Nl+F9v1V+/YoRE8xu+bM9RT1S23U1makq44KHL3XEKHS5R/6Pvle7TYdGuc7
         vjxzgvBnWEiGkwzWjFu2elvXJ2L1PlbdX2L7W1e7SSz5qC12X4unU0ASu+EFQ90D8FK4
         rmxOJPROEeJFJ24ztrJ+D5kyDbryRVZUvsWqjPh7VE682DAqOtC7dkuR6Gc+Wx+eNeuW
         QxPw==
X-Gm-Message-State: AAQBX9djuQ6OAGpykv190etJSl0ODF+T/kt3pdDSIik2EyBbfvePC9W4
        JhwbvnBncTKAQiAvRqLCf7U5hA==
X-Google-Smtp-Source: AKy350YhJ9EsbBANF41KU0JsrgYKESkaxSwSkyYsvYeVp6K8XmpXWkVNrn4s2xKlYA0SpK2Y+jar6g==
X-Received: by 2002:a7b:c404:0:b0:3f0:a785:f0e0 with SMTP id k4-20020a7bc404000000b003f0a785f0e0mr4243117wmi.40.1681475405010;
        Fri, 14 Apr 2023 05:30:05 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:d040:969c:6e8e:e95d? ([2a02:8011:e80c:0:d040:969c:6e8e:e95d])
        by smtp.gmail.com with ESMTPSA id v22-20020a7bcb56000000b003f049a42689sm4207490wmj.25.2023.04.14.05.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 05:30:04 -0700 (PDT)
Message-ID: <b933fad3-7759-00d4-94cb-f20dd363b794@isovalent.com>
Date:   Fri, 14 Apr 2023 13:30:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
Content-Language: en-GB
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>,
        Mahe Tardy <mahe.tardy@gmail.com>
References: <ZDfKBPXDQxH8HeX9@syu-laptop>
 <CACdoK4L5A-qdUyQwVbe-KE+0NBPbgqYC1v0uf0i1U_S7KSnmuw@mail.gmail.com>
 <20230414095007.GF63923@kunlun.suse.cz>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230414095007.GF63923@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2023-04-14 11:50 UTC+0200 ~ Michal Suchánek <msuchanek@suse.de>
> Hello,
> 
> On Fri, Apr 14, 2023 at 01:35:20AM +0100, Quentin Monnet wrote:
>> Hi Shung-Hsi,
>>
>> On Thu, 13 Apr 2023 at 10:23, Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
>>>
>>> Hi,
>>>
>>> I'm considering switch to bpftool's mirror on GitHub for packaging (instead
>>> of using the source found in kernel), but realize that it should goes
>>> hand-in-hand with how libbpf is packaged, which eventually leads these
>>> questions:
>>>
>>>   What is the suggested approach for packaging bpftool and libbpf?
>>>   Which source is preferred, GitHub or kernel?
>>
>> As you can see from the previous discussions, the suggested approach
>> would be to package from the GitHub mirror, with libbpf and bpftool in
>> sync.
>>
>> My main argument for the mirror is that it keeps things simpler, and
>> there's no need to deal with the rest of the kernel sources for these
>> packages. Download from the mirrors, build, ship. But then I have
>> limited experience at packaging for distros, and I can understand
>> Toke's point of view, too. So ultimately, the call is yours.
> 
> Things get only ever more complex when submodules are involved.

I understand the generic pain points from your other email. But could
you be more specific for the case of bpftool? It's not like we're
shipping all lib dependencies as submodules. Sync-ups are specifically
aligned to the same commit used to sync the libbpf mirror, so that it's
pretty much as if we had the right version of the library shipped in the
repository - only, it's one --recurse-submodules away.

> 
>>>   Does bpftool work on older kernel?
>>
>> It should, although it's not perfect. Most features from current
>> bpftool should work as expected on older kernels. However, if I
>> remember correctly you would have trouble loading programs on pre-BTF
>> kernels, because bpftool relies on libbpf >= 1.0 and only accepts map
>> definitions with BTF info, and attempts to create these maps with BTF,
>> which fails and blocks the load process.
>>
>> But we're trying to keep backward-compatibility, so if we're only
>> talking of kernels recent enough to support BTF, then I'd expect
>> bpftool to work. If this is not the case, please report on this list.
> 
> It won't build:
> https://lore.kernel.org/bpf/20220421003152.339542-3-alobakin@pm.me/

True in this case, and this is something that needs to get fixed. Thanks
for reopening that thread! Are you building bpftool on kernels older
than 5.15? (genuine curiosity)

> 
>>> Our current approach is that we (openSUSE/SLES) essentially have two version
>>> of libbpf: a public shared library that uses GitHub mirror as source, which
>>> the general userspace sees and links to; and a private static library built
>>> from kernel source used by bpftool, perf, resolve_btfids, selftests, etc.
>>> A survey of other distros (Arch, Debian, Fedora, Ubuntu) suggest that they
>>> took similar approach.
>>
>> I would like them to reconsider this choice eventually. Sounds like
>> for RHEL, this will be a tough sell :). At least, I'd love Ubuntu to
>> have a real bpftool package instead of having to install
>> linux-tools-common + linux-tools-generic, or to have distros in
>> general (Ubuntu/Debian at least) stop compiling out the JIT
>> disassembler, although this is not strictly related to the location of
>> the sources. I've not found the time to reach out to package
>> maintainers yet.
>>
>>>
>>> This approach means that the version of bpftool and libbpf are _not_ always
>>> in sync[1], which I read may causes problem since libbpf and bpftool depends
>>> on specific version of each other[2].
>>
>> Whatever source you use, I would strongly recommend finding a way to
>> keep both in sync. Libbpf has stabilised its API when reaching 1.0,
>> but bpftool taps into some of the internals of the library. Features
>> or new definitions are usually added at the same time to libbpf and
>> bpftool, and if you get a mismatch between the two, you're taking
>> risks to get build issues.
> 
> In other words no API exists.

Of course it does. Libbpf exposes a specific set of functions to user
applications.

But correct, from bpftool's perspective, there are a few locations where
we accept to derogate and to access to the internals directly, making it
more dependent on a specific version, or commit, of libbpf, and blurring
the notion of API.

This special relationship is nothing new though, and it has been
discussed before. It derives from both tools being developed in the same
repository, and bpftool being so tightly linked to libbpf - it has been
qualified of command-line interface for libbpf in the past. Bpftool's
version number itself is aligned on libbpf's. (As a side note, bpftool
used to pull libbpf's headers directly from libbpf's dir instead of
installing them locally, which facilitated this mix-in for
public/internal headers in the first place.)

I know you advocated making the required functions part of the API,
given that some users (such as bpftool) need them. These functions are
not exposed, by choice. They are not judged relevant to generic user
space application (I'm sure libbpf's maintainers are opened to
discussion if use cases come up). Some of the internals we get from
libbpf are also mostly to avoid re-implementing things, such as netlink
attributes processing, or implementing hash maps. These have nothing to
do in libbpf's API.

> 
>>> Using the GitHub mirror of bpftool to package both libbpf and bpftool would
>>> kept their version in sync, and was suggested[3]. Although the same could be
>>> said if we switch back to packaging libbpf from kernel source, an additional
>>> appeal for using GitHub mirrors is that it decouples bpftool from kernel,
>>> making it easily upgradable and with a clearer changelog (the latter is
>>> quite important for enterprise users) like libbpf.
>>
>> Happy to read these changelogs I write are useful to someone :). Yes,
>> this is my point.
> 
> Yes, publishing the changelog in a usable way relieves others of the
> need to write thier own, usually with less understanding of the changes
> in question. That's generally the idea of opensource - not endlessly
> repeating what has already been done :)

Not discussing that - My point is that I've received little feedback on
the mirror so far, so it's hard for me to figure out who's using it or
whether anyone has been reading the changelogs.

> 
>>> The main concern with using GitHub mirror is that bpftool may be updated far
>>> beyond the version that comes with the runtime kernel. AFAIK bpftool should
>>> work on older kernel since CO-RE is used for built-in BPF iterators and the
>>> underlying libbpf work on older kernel itself. Nonetheless, it would be nice
>>> to get a confirmation from the maintainers.
>>
>> As explained above - Mostly, it should work. Otherwise, we can look
>> into fixing it.
>>
>> As a side note, I'm open to suggestions/contributions to make life
>> easier for packaging for the mirror. For example, Mahé and I recently
>> added GitHub workflows to ship statically-built binaries for amd64 and
>> arm64 on releases, as well as tarballs with both bpftool+libbpf
>> sources. If there's something else to make packaging easier, I'm happy
>> to talk about it.
> 
> Make it possible to build with system-installed libbpf. If it's released
> it should have versioned dependency on a libbpf release, and libbpf from
> that version on should be good enough to build it.
> 
> I tried copying those 'private' headers into a separate directory, and
> link against static libbpf, and it seems to work. Of course, having
> an actual API would be much better.

Just as you said yourself, the missing stability is in the way. I don't
see this happening as long as bpftool is using libbpf's internals. I do
expect builds to work most of the time by copying the headers as you
did, but as soon as something changes and it no longer does, everyone
will start filing issues on GitHub instead of using the version that
works, and I don't want that.

As for decoupling from the internal: making the functions part of the
API is not an option. One option could be to move this code into further
dependencies shared between libbpf and bpftool - although I guess libbpf
developers will have little appetite for that. We could also duplicate
the necessary code in bpftool, which doesn't sound optimal, but might be
one solution. Other options have been discussed before, such as moving
bpftool into libbpf's directory/mirror and shipping both together, but
there was no consensus at the time, and I don't expect libbpf to ship
with bpftool any time soon.
