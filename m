Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC93C9928E
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2019 13:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbfHVLtv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 22 Aug 2019 07:49:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732004AbfHVLtu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Aug 2019 07:49:50 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B281C08E284
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2019 11:49:49 +0000 (UTC)
Received: by mail-ed1-f72.google.com with SMTP id x40so3238553edm.4
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2019 04:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uoZ3PNSE4HS3HgyqFhdpD/PQA1UhdevSS3WoOeyssD4=;
        b=CsZ8ORzGauSdU25unpvfkJ0/lLuADWmFlTKlfVk19yThshLRN8arlu5eFnTKLctos2
         P9SZkRMmaZa03sKqR22rNvVmGMbk4HilI8dzXBbGZq47o4MjUZdJ0o7V+hfB028rCoMj
         HNupRiG638CAEkgz6KgXPasWPmn8gHHPLz0ZThw62ygkDJtMuQ7q0CF1nSCZ40yZRGwM
         PRJLWRFa5FsC5AIxI/AJxotdXGM0fsyRNRREPvNpAlaE8fqZ/F/ulBl/c1RREkSi8qkR
         g31QUGXmx3vnvZeCyyyX11smJYyGU+QBncbjHpxbe1Zok/Qg9AJ49fpqa6LkVCFAkSnP
         nf8w==
X-Gm-Message-State: APjAAAVbAt/aKE4yBEmFy5lIGv22u81JjUIObTtqPhNNMircoO25V3NZ
        Ic1vlKqJTIxRQMy3//9fFjKR4xjqKIhasfOuzXPxWzRxiVH1H4Nyn3nX4xC6FUV0fKU4jbcOrXR
        m5mfVzcbSyrrl
X-Received: by 2002:a50:fa8a:: with SMTP id w10mr23989023edr.247.1566474588296;
        Thu, 22 Aug 2019 04:49:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxFRJ2cOFcesvIsAQVEUJE5pxzKgJOdOQxj4JnHNV6K+YECED9rPCqColkjWE/TY5ZdTu2CTQ==
X-Received: by 2002:a50:fa8a:: with SMTP id w10mr23989008edr.247.1566474588085;
        Thu, 22 Aug 2019 04:49:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id f15sm3581701ejx.14.2019.08.22.04.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 04:49:47 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 11A0D181CEF; Thu, 22 Aug 2019 13:49:47 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC bpf-next 0/5] Convert iproute2 to use libbpf (WIP)
In-Reply-To: <87d0gxpgjw.fsf@toke.dk>
References: <20190820114706.18546-1-toke@redhat.com> <CAEf4BzZxb7qZabw6aDVaTqnhr3AGtwEo+DbuBR9U9tJr+qVuyg@mail.gmail.com> <87blwiqlc8.fsf@toke.dk> <CAEf4BzYMKPbfOu4a4UDEfJVcNW1-KvRwJ7PVo+Mf_1YUJgE4Qw@mail.gmail.com> <43e8c177-cc9c-ca0b-1622-e30a7a1281b7@iogearbox.net> <87d0gxpgjw.fsf@toke.dk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 22 Aug 2019 13:49:47 +0200
Message-ID: <87a7c1pgh0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Toke Høiland-Jørgensen <toke@redhat.com> writes:

> Daniel Borkmann <daniel@iogearbox.net> writes:
>
>> On 8/22/19 9:49 AM, Andrii Nakryiko wrote:
>>> On Wed, Aug 21, 2019 at 2:07 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>>>> On Tue, Aug 20, 2019 at 4:47 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>>>>
>>>>>> iproute2 uses its own bpf loader to load eBPF programs, which has
>>>>>> evolved separately from libbpf. Since we are now standardising on
>>>>>> libbpf, this becomes a problem as iproute2 is slowly accumulating
>>>>>> feature incompatibilities with libbpf-based loaders. In particular,
>>>>>> iproute2 has its own (expanded) version of the map definition struct,
>>>>>> which makes it difficult to write programs that can be loaded with both
>>>>>> custom loaders and iproute2.
>>>>>>
>>>>>> This series seeks to address this by converting iproute2 to using libbpf
>>>>>> for all its bpf needs. This version is an early proof-of-concept RFC, to
>>>>>> get some feedback on whether people think this is the right direction.
>>>>>>
>>>>>> What this series does is the following:
>>>>>>
>>>>>> - Updates the libbpf map definition struct to match that of iproute2
>>>>>>    (patch 1).
>>>>>
>>>>> Thanks for taking a stab at unifying libbpf and iproute2 loaders. I'm
>>>>> totally in support of making iproute2 use libbpf to load/initialize
>>>>> BPF programs. But I'm against adding iproute2-specific fields to
>>>>> libbpf's bpf_map_def definitions to support this.
>>>>>
>>>>> I've proposed the plan of extending libbpf's supported features so
>>>>> that it can be used to load iproute2-style BPF programs earlier,
>>>>> please see discussions in [0] and [1].
>>>>
>>>> Yeah, I've seen that discussion, and agree that longer term this is
>>>> probably a better way to do map-in-map definitions.
>>>>
>>>> However, I view your proposal as complementary to this series: we'll
>>>> probably also want the BTF-based definition to work with iproute2, and
>>>> that means iproute2 needs to be ported to libbpf. But iproute2 needs to
>>>> be backwards compatible with the format it supports now, and, well, this
>>>> series is the simplest way to achieve that IMO :)
>>> 
>>> Ok, I understand that. But I'd still want to avoid adding extra cruft
>>> to libbpf just for backwards-compatibility with *exact* iproute2
>>> format. Libbpf as a whole is trying to move away from relying on
>>> binary bpf_map_def and into using BTF-defined map definitions, and
>>> this patch series is a step backwards in that regard, that adds,
>>> essentially, already outdated stuff that we'll need to support forever
>>> (I mean those extra fields in bpf_map_def, that will stay there
>>> forever).
>>
>> Agree, adding these extensions for libbpf would be a step backwards
>> compared to using BTF defined map defs.
>>
>>> We've discussed one way to deal with it, IMO, in a cleaner way. It can
>>> be done in few steps:
>>> 
>>> 1. I originally wanted BTF-defined map definitions to ignore unknown
>>> fields. It shouldn't be a default mode, but it should be supported
>>> (and of course is very easy to add). So let's add that and let libbpf
>>> ignore unknown stuff.
>>> 
>>> 2. Then to let iproute2 loader deal with backwards-compatibility for
>>> libbpf-incompatible bpf_elf_map, we need to "pass-through" all those
>>> fields so that users of libbpf (iproute2 loader, in this case) can
>>> make use of it. The easiest and cleanest way to do this is to expose
>>> BTF ID of a type describing each map entry and let iproute2 process
>>> that in whichever way it sees fit.
>>> 
>>> Luckily, bpf_elf_map is compatible in `type` field, which will let
>>> libbpf recognize bpf_elf_map as map definition. All the rest setup
>>> will be done by iproute2, by processing BTF of bpf_elf_map, which will
>>> let it set up map sizes, flags and do all of its map-in-map magic.
>>> 
>>> The only additions to libbpf in this case would be a new `__u32
>>> bpf_map__btf_id(struct bpf_map* map);` API.
>>> 
>>> I haven't written any code and haven't 100% checked that this will
>>> cover everything, but I think we should try. This will allow to let
>>> users of libbpf do custom stuff with map definitions without having to
>>> put all this extra logic into libbpf itself, which I think is
>>> desirable outcome.
>>
>> Sounds reasonable in general, but all this still has the issue that
>> we're assuming that BTF is /always/ present. Existing object files
>> that would load just fine /today/ but do not have BTF attached won't
>> be handled here. Wouldn't it be more straight forward to allow passing
>> callbacks to the libbpf loader such that if the map section is not
>> found to be bpf_map_def compatible, we rely on external user aka
>> callback to parse the ELF section, handle any non-default libbpf
>> behavior like pinning/retrieving from BPF fs, populate related
>> internal libbpf map data structures and pass control back to libbpf
>> loader afterwards. (Similar callback with prog section name handling
>> for the case where tail call maps get automatically populated.)
>
> Thinking about this some more, I think there are two separate issues
> here:
>
> 1. Do we want libbpf to support the features currently in iproute2 and
>    bpf_helpers (i.e., map pinning + reuse, map-in-map definitions, and
>    NUMA node placement of maps). IMO the answer to this is yes.
>
> 2. What should the data format be for BPF programs to signal that they
>    want to use those features? Here, the longer-term answer is BTF-based
>    map definitions, but we still want iproute2 to be backwards
>    compatible.
>
>
> So how about I revise this patch series to implement the *features* (I
> already implemented map-in-map and numa nodes[0], so that is sorta
> already done), but instead of extending the bpf_map_def struct, I just
> expose callbacks that will allow programs to fill in internal-to-libbpf
> data structures with the required information. Then, once the BTF-based
> map definition does land, that can simply define default callbacks that
> uses the BTF information to fill in those same internal data structures?
>
> This would mean no extending bpf_map_def, and relaxing the current
> libbpf restriction on extending bpf_map_def.
>
> The drawback of this approach is that it does nothing to combat
> fragmentation: People building their own loaders can still reimplement
> different semantics for map defs, leading to programs that are tied to a
> particular loader. So this would only work if we really believe BTF can
> save us from this. I don't feel competent to comment on this just yet,
> but thought I'd mention it :)
>
> -Toke

[0] was supposed to be a reference to
    https://github.com/tohojo/libbpf/tree/iproute2-compat
