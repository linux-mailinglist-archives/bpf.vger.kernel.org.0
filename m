Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C0B360619
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 11:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhDOJqi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 05:46:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhDOJqh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Apr 2021 05:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618479974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yt0pPRk4FAx3KOA3uBg3sAaCbyFJ9MPZjUZtHs4zBdQ=;
        b=B3xej8LqVZ7l5oq8o9ubI5a88w2GW4T0i6hyce6ZCUYyj+DSzetlzCHQlCNDvj7d/DGHlw
        p0BK2bPVLLm97mUqZjCXLSeRJ10oQyFidehTfDoSJz1UjvqL631u7xNRW1FOpWekkfgZD+
        g+27fssK9a78QUb0tCFXGGE0KFISypk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-NC5zC8IqOFW9JuAp8QoLWw-1; Thu, 15 Apr 2021 05:46:11 -0400
X-MC-Unique: NC5zC8IqOFW9JuAp8QoLWw-1
Received: by mail-ed1-f70.google.com with SMTP id y13-20020aa7cccd0000b02903781fa66252so4907665edt.18
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 02:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Yt0pPRk4FAx3KOA3uBg3sAaCbyFJ9MPZjUZtHs4zBdQ=;
        b=N5theHcSYOHb/dOFLMcsadFhPET0e/dIhAI/kfV4oOxuRVnWObcM+R68afokzyFxvK
         FgsyuhlJ2hR4DBoH8qeET4Bw5Q1SasanstEJ53qnT+Viwr3m8mShGYCtNtMZx941P9Tw
         Fv2+hBW8j1G1GNskZ9i1rMjBeq07gvt85ell51MO6XtqmFsLgJW3oLhSL1/dGX7jcwNF
         xHOe8NotZNJ4rb1FQDwfUlosC58zVMZ6KvtcqNShK4aNxx3XzH5fdpUhrmIp56JzOkGO
         azJLVoVkdWASFSfTrO1agQjOajIOs5qUFRMIaExamWD7cyqA7h9vIdj+QC/EnKwEg/OP
         FzHg==
X-Gm-Message-State: AOAM530aBAyl5wvmpvWvy1T7BhRFP6uCFjTrcXt0n16Zu+NBZZIB+Yo5
        ULQLm/PZC3nIH4ul5bYWDDdIhqD/fCh/ihO+mMrZzMZ+UkddBV/AGsiz4t+ovv1kE+QoVpQXAnt
        8pkeuy6khMQ8b
X-Received: by 2002:a17:906:29ca:: with SMTP id y10mr2591053eje.250.1618479969989;
        Thu, 15 Apr 2021 02:46:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBGZpidcdzWh3/QTwVlja8CQutaML1ZwlEhIFOv2PmdzHG+T94JebFZ/xKVAekAbf2stb8lg==
X-Received: by 2002:a17:906:29ca:: with SMTP id y10mr2591030eje.250.1618479969609;
        Thu, 15 Apr 2021 02:46:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id qt10sm1559903ejb.34.2021.04.15.02.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:46:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 659221806B3; Thu, 15 Apr 2021 11:46:08 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: Access to rodata when using libbpf directly
In-Reply-To: <CAEf4BzZ2Piu5kkpp6PmHUFryGOo7P=jjNk7DkUVg6kJUBaHs8g@mail.gmail.com>
References: <CAO658oVyB2b+Y6K3--sAhTcXfmPpmPjLhA0z7bbjyjhzDV8kcA@mail.gmail.com>
 <CAEf4BzZ2Piu5kkpp6PmHUFryGOo7P=jjNk7DkUVg6kJUBaHs8g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 15 Apr 2021 11:46:08 +0200
Message-ID: <87fszrkhi7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Apr 14, 2021 at 7:26 PM Grant Seltzer Richman
> <grantseltzer@gmail.com> wrote:
>>
>> As I understand it, accessing and setting read only global variables
>> from a userspace control program through libbpf can only happen when
>> importing a BPF skeleton. Things like `bpf_object__find_map_by_name()`
>> are exposed but the name of this map is internal and
>> `internal_map_name()` is as well. Traversing through the maps array
>> via bpf_object directly doesn't seem possible either.
>
> Not really.
>
> See bpf_object__for_each_map() macro and bpf_map__is_internal() API,
> both of which are public. As for the name, it's also sort of part of
> API, though I want to fix them in libbpf 1.0 (they should be named
> .rodata, .data, .bss). So you can definitely either find the map with
> iteration or by knowing how the name is generated. Then do mmap() and
> using BTF you'll know each variable's offset and size. No magic, just
> some code to do this, which is what is done by bpftool for skeletons
> (bpftool is a completely external user of libbpf in this case, no
> private APIs are involved).

We also added bpf_map__set_initial_value() for this, so you don't even
need to mmap(); we're using this in libxdp:

https://github.com/xdp-project/xdp-tools/blob/master/lib/libxdp/libxdp.c#L2325

-Toke

