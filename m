Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98EDBE6259
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2019 13:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfJ0MEj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 27 Oct 2019 08:04:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbfJ0MEj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Oct 2019 08:04:39 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 110743B735
        for <bpf@vger.kernel.org>; Sun, 27 Oct 2019 12:04:39 +0000 (UTC)
Received: by mail-lj1-f198.google.com with SMTP id y12so1406143ljc.8
        for <bpf@vger.kernel.org>; Sun, 27 Oct 2019 05:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WAC0ltLf5/k9Fk3oOw2pDdZIy6OL9TvyNRdiY94Gu8M=;
        b=BqGmNti1oBcjCFAxNwLcgHvXt1bB7MF51Th4Wi20hPreVVmZmVTDz1T45uT88FhfNg
         QKr1iuNUGpo3ShaW4CdRI1Dz0ylVqjg1nRKAQ3hwanWhETkQLjF8mQoM69E7G8S/QPIw
         A+knGgKBboN6Y4u34zuTNhRWh8/0po9oGw7bMbuPvqiIKvgwkXe2givB3TWciClUt2vo
         CKWTtBnNsidwNOdBip30HgiZRF2pGyGkrJnCdYEA8ayrk/vdxlQg776ws8O5Ofa2WLSv
         0hQgpE8qcNuSwdUYvHR+x2Av6lP/i3luhmSXBZdLKzJprrgB2/1U7zA/ATQ7re6ajRh1
         F+oA==
X-Gm-Message-State: APjAAAVZLUkDI7MqwfAhAwvdH8e/v7s29xXqhh1gGallimSIsPNgEG4V
        Y6rnmPjUHYf5JwX0Ic3xVqezkK4h0YzkBy7G8UH1H+IfJ/B+SxFZozjLPKAtmnLrfeWXyPtX5NA
        Nu2UknP8mz1Pq
X-Received: by 2002:a2e:9e1a:: with SMTP id e26mr8590143ljk.17.1572177877303;
        Sun, 27 Oct 2019 05:04:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwXLhFqhvcNHt87IB3WnN1OtKoJglNbImP2QD7dO/JqDftrb1/lzIvLRTW0OSsLn8HiQDk3Sw==
X-Received: by 2002:a2e:9e1a:: with SMTP id e26mr8590129ljk.17.1572177877099;
        Sun, 27 Oct 2019 05:04:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id c24sm3857946lfm.20.2019.10.27.05.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 05:04:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5255A1818B4; Sun, 27 Oct 2019 13:04:35 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 4/4] libbpf: Add option to auto-pin maps when opening BPF object
In-Reply-To: <CAEf4BzbBmm3GfytbEtHwoD71p2XfuxuSYjhbb7rqPwUaYqvk7g@mail.gmail.com>
References: <157192269744.234778.11792009511322809519.stgit@toke.dk> <157192270189.234778.14607584397750494265.stgit@toke.dk> <CAEf4BzbBmm3GfytbEtHwoD71p2XfuxuSYjhbb7rqPwUaYqvk7g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 27 Oct 2019 13:04:35 +0100
Message-ID: <87pniijsx8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Oct 24, 2019 at 6:11 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>>
>> With the functions added in previous commits that can automatically pin
>> maps based on their 'pinning' setting, we can support auto-pinning of maps
>> by the simple setting of an option to bpf_object__open.
>>
>> Since auto-pinning only does something if any maps actually have a
>> 'pinning' BTF attribute set, we default the new option to enabled, on the
>> assumption that seamless pinning is what most callers want.
>>
>> When a map has a pin_path set at load time, libbpf will compare the map
>> pinned at that location (if any), and if the attributes match, will re-use
>> that map instead of creating a new one. If no existing map is found, the
>> newly created map will instead be pinned at the location.
>>
>> Programs wanting to customise the pinning can override the pinning paths
>> using bpf_map__set_pin_path() before calling bpf_object__load().
>>
>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> ---
>
> How have you tested this? From reading the code, all the maps will be
> pinned irregardless of their .pinning setting?

No, build_pin_path() checks map->pinning :)

> Please add proper tests to test_progs, testing various modes and
> overrides.

Can do.

> You keep trying to add more and more knobs :) Please stop doing that,
> even if we have a good mechanism for extensibility, it doesn't mean we
> need to increase a proliferation of options.

But I like options! ;)

> Each option has to be tested. In current version of your patches, you
> have something like 4 or 5 different knobs, do you really want to
> write tests testing each of them? ;)

Heh, I guess I can cut down the number of options to the number of tests :P

> Another high-level feedback. I think having separate passes over all
> maps (build_map_pin_paths, reuse, then we already have create_maps) is
> actually making everything more verbose and harder to extend. I'm
> thinking about all these as sub-steps of map creation. Can you please
> try refactoring so all these steps are happening per each map in one
> place: if map needs to be pinned, check if it can be reused, if not -
> create it. This actually will allow to handle races better, because
> you will be able to retry easily, while if it's all spread in
> independent passes, it becomes much harder. Please consider that.

We'll need at least two passes: set pin_path on open, and check reuse /
create / pin on load. Don't have any objections to consolidating the
other passes into create_maps; will fix, along with your comments below.

-Toke
