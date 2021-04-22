Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D12367D54
	for <lists+bpf@lfdr.de>; Thu, 22 Apr 2021 11:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhDVJJy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Apr 2021 05:09:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235602AbhDVJJv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 22 Apr 2021 05:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619082556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4rCc8lLkNUHdhonmC2gi0L9aKXC3shqcqZPuL+BdCFg=;
        b=JNwhWIIqWKS9IxSG/UhFxSwKRjxkQM8mNn84hJwkq/1QHpb7+lIA9wPSzCat9uaa+TgL4W
        bas/Os8HoiBYkb6QfaSeOAz2vmcGr+WMlRW4xAt/seBm1uEDtpvlLI+PKt1H0Uu9ImqrCb
        5Eut7QwKcgrbtCfRjglwjyEungrpe98=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-dRLzaDT8Nq21yOEPQ9rrPA-1; Thu, 22 Apr 2021 05:09:03 -0400
X-MC-Unique: dRLzaDT8Nq21yOEPQ9rrPA-1
Received: by mail-ej1-f69.google.com with SMTP id 16-20020a1709063010b029037417ca2d43so6957017ejz.5
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 02:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4rCc8lLkNUHdhonmC2gi0L9aKXC3shqcqZPuL+BdCFg=;
        b=Xv7qc9tyB9AQ5RMZcxUgjj39XIgbt22PfOrUkOZN/8WPglufJbTZOVwNIm+8o51D2E
         RY/kv8CNuEYXfYutkNHJ4yomAROC2QVibsGw7EdWQYnqAxecBBY063/Gw5qgikAsH1vI
         TB6wbXFXskGWTnaIZsiQtDrsU45zeYxFjsfoYtlLX6ZjL62j1yKFQIzksdAdGGKzX0iA
         y2eyn3AfJaIzbCpkqQTiLAALgpU6GCnYT+ozFzl5yrECsRqC6T2NMcDRHJ5YeEdYwZr0
         wHNYEB5RCewS+20Bhf54ZUa8P17UZBcZVqyr0druYQTUT7F7lK9uIWA/qMP6olJEU6GS
         rwgQ==
X-Gm-Message-State: AOAM531zsoKTlT+GHkGJkHB6r1aDSSCk0WqTTtt/BSZndXOHuhmouxgP
        nwrEmUfDk7OmUhQS0JkfV6cD2MB7gwQ4JEQeTEq87g2HSux/ujP8OmjAqynyvEALdzSBoLRRhZQ
        xZ290ZDATCHw1
X-Received: by 2002:a05:6402:10c9:: with SMTP id p9mr2579876edu.268.1619082541863;
        Thu, 22 Apr 2021 02:09:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjBEzGdVX1CQq9A+Dj2UFi2PunHTkRL//AaNrncT26WrCeL1f0mRERmTIFkIr+bSUhpseTAQ==
X-Received: by 2002:a05:6402:10c9:: with SMTP id p9mr2579834edu.268.1619082541601;
        Thu, 22 Apr 2021 02:09:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ck29sm1559672edb.47.2021.04.22.02.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 02:09:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F378C180675; Thu, 22 Apr 2021 11:08:59 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 2/3] libbpf: add low level TC-BPF API
In-Reply-To: <bd2ed7ed-a502-bee5-0a56-0f3064ee2be5@iogearbox.net>
References: <20210420193740.124285-1-memxor@gmail.com>
 <20210420193740.124285-3-memxor@gmail.com>
 <CAEf4BzYj_pODiQ_Xkdz_czAj3iaBcRhudeb_kJ4M2SczA_jDjA@mail.gmail.com>
 <87tunzh11d.fsf@toke.dk>
 <bd2ed7ed-a502-bee5-0a56-0f3064ee2be5@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 22 Apr 2021 11:08:59 +0200
Message-ID: <875z0ehej8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 4/21/21 9:48 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>> On Tue, Apr 20, 2021 at 12:37 PM Kumar Kartikeya Dwivedi
>>> <memxor@gmail.com> wrote:
> [...]
>>>> ---
>>>>   tools/lib/bpf/libbpf.h   |  44 ++++++
>>>>   tools/lib/bpf/libbpf.map |   3 +
>>>>   tools/lib/bpf/netlink.c  | 319 +++++++++++++++++++++++++++++++++++++=
+-
>>>>   3 files changed, 360 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>>>> index bec4e6a6e31d..b4ed6a41ea70 100644
>>>> --- a/tools/lib/bpf/libbpf.h
>>>> +++ b/tools/lib/bpf/libbpf.h
>>>> @@ -16,6 +16,8 @@
>>>>   #include <stdbool.h>
>>>>   #include <sys/types.h>  // for size_t
>>>>   #include <linux/bpf.h>
>>>> +#include <linux/pkt_sched.h>
>>>> +#include <linux/tc_act/tc_bpf.h>
>>>
>>> apart from those unused macros below, are these needed in public API he=
ader?
>>>
>>>>   #include "libbpf_common.h"
>>>>
>>>> @@ -775,6 +777,48 @@ LIBBPF_API int bpf_linker__add_file(struct bpf_li=
nker *linker, const char *filen
>>>>   LIBBPF_API int bpf_linker__finalize(struct bpf_linker *linker);
>>>>   LIBBPF_API void bpf_linker__free(struct bpf_linker *linker);
>>>>
>>>> +/* Convenience macros for the clsact attach hooks */
>>>> +#define BPF_TC_CLSACT_INGRESS TC_H_MAKE(TC_H_CLSACT, TC_H_MIN_INGRESS)
>>>> +#define BPF_TC_CLSACT_EGRESS TC_H_MAKE(TC_H_CLSACT, TC_H_MIN_EGRESS)
>>>
>>> these seem to be used only internally, why exposing them in public
>>> API?
>>=20
>> No they're "aliases" for when you want to attach the filter directly to
>> the interface (and thus install the clsact qdisc as the root). You can
>> also use the filter with an existing qdisc (most commonly HTB), in which
>> case you need to specify the qdisc handle as the root. We have a few
>> examples of this use case:
>>=20
>> https://github.com/xdp-project/bpf-examples/tree/master/traffic-pacing-e=
dt
>> and
>> https://github.com/xdp-project/xdp-cpumap-tc
>
> I'm a bit puzzled, could you elaborate on your use case on why you wouldn=
't
> use the tc egress hook for those especially given it's guaranteed to run
> outside of root qdisc lock?

Jesper can correct me if I'm wrong, but I think the first one of the
links above is basically his implementation of just that EDT-based
shaper. And it works reasonably well, except you don't get the nice
per-flow scheduling and sparse flow prioritisation like in FQ-CoDel
unless you implement that yourself in BPF when you set the timestamps
(and that is by no means trivial to implement).

So if you want to use any of the features of the existing qdiscs (I have
also been suggesting to people that they use tc_bpf if they want to
customise sch_cake's notion of flows or shaping tiers), you need to be
able to attach the filter to an existing qdisc. Sure, this means you're
still stuck behind the qdisc lock, but for some applications that is
fine (not everything is a data centre, some devices don't have that many
CPUs anyway; and as the second example above shows, you can get around
the qdisc lock by some clever use of partitioning of flows using
cpumap).

So what this boils down to is, we should keep the 'parent' parameter not
just as an egress/ingress enum, but also as a field the user can fill
out. I'm fine with moving the latter into the opts struct, though, so
maybe the function parameter can be an enum like:

enum bpf_tc_attach_point {
  BPF_TC_CLSACT_INGRESS,
  BPF_TC_CLSACT_EGRESS,
  BPF_TC_QDISC_PARENT
};

where if you set the last one you have to fill in the parent in opts?

-Toke

