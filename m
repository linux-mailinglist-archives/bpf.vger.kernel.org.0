Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC9632A472
	for <lists+bpf@lfdr.de>; Tue,  2 Mar 2021 16:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578114AbhCBKfn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 05:35:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380004AbhCBKZW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Mar 2021 05:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614680590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SGioato23lbkvo7M0QJS06qhjk71ippSH/Xk3g8ZuNY=;
        b=dsTj11O1qqgvhjAy+NpYwhcfeQityWn2dd0t98f24AqBl47FWPY99MNtUzdzdcK9oKazDb
        TrL0TLKwYpN6lhtEpmPYBo8WpaZoz+7LF6Mn8kT/0wMX58j8+CM8FTRz4cVghg7vkIbvor
        SCSW4oZIw3SdR7/TLkPRkMZcqY3QfJc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-cjxObi82PjCOgbAFOITy_Q-1; Tue, 02 Mar 2021 05:23:09 -0500
X-MC-Unique: cjxObi82PjCOgbAFOITy_Q-1
Received: by mail-ej1-f71.google.com with SMTP id fy8so3355870ejb.19
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 02:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SGioato23lbkvo7M0QJS06qhjk71ippSH/Xk3g8ZuNY=;
        b=lpJXOD5X8FC/psZKd2/XvrNTa8RN9hEFtS4d4AD6xPbyaDLcm5RAXSCgxtJbmjDBQd
         AcQ0YXnB1/cdypHKt8JbDGvSr/LfD6Hp4Omc/SCuT4xQsh4AfHRHrCFHX/Nrh9ddpTBH
         Km2fTm/meJUWZ1SRjC3XsPN9K3agkqkGOP7hqdoV4038hsFbsy+/bJLuVHjqVWk4Ooa/
         qcofAG0yQa5+D10Zd5USYPoGyBxqwK9YbD8StoVfox8RlZBwU7b/9XHQVrh3IF9G7mL5
         Zrwsb0u0l62q5aBy4EvRDcdXdcLy7cmCU5UOVIzz7b3GrADQZGEILkN14qLo/PHRmHjE
         UrLQ==
X-Gm-Message-State: AOAM532E8x11nVYsb7rsvWEHwObuMZJEShzqcM4+hfJzLgKrbj17esjU
        bw8uiwbW7q0QneZ4EObcl/9efiTVUAq5vQtGzUITSICd0CdZNSzaI5FjEnE042f/BPn+40uxaZN
        URFjKNtkWXSPR
X-Received: by 2002:a17:907:98f1:: with SMTP id ke17mr20328485ejc.498.1614680587749;
        Tue, 02 Mar 2021 02:23:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXvNpAMqBBkGg+NOxtgWvOBSxWBoUndCBrESzleiWax8xy6W/ulefjzFx7PChqUiN+eNt+sw==
X-Received: by 2002:a17:907:98f1:: with SMTP id ke17mr20328462ejc.498.1614680587415;
        Tue, 02 Mar 2021 02:23:07 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id s2sm18031250edt.35.2021.03.02.02.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 02:23:06 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 413061800F1; Tue,  2 Mar 2021 11:23:06 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, paulmck@kernel.org
Cc:     magnus.karlsson@intel.com, jonathan.lemon@gmail.com,
        maximmi@nvidia.com, andrii@kernel.org
Subject: Re: [PATCH bpf-next 1/2] xsk: update rings for
 load-acquire/store-release semantics
In-Reply-To: <939aefb5-8f03-fc5a-9e8b-0b634aafd0a4@intel.com>
References: <20210301104318.263262-1-bjorn.topel@gmail.com>
 <20210301104318.263262-2-bjorn.topel@gmail.com> <87mtvmx3ec.fsf@toke.dk>
 <939aefb5-8f03-fc5a-9e8b-0b634aafd0a4@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 02 Mar 2021 11:23:06 +0100
Message-ID: <87zgzlvoqd.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com> writes:

> On 2021-03-01 17:08, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:
>>=20
>>> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>>>
>>> Currently, the AF_XDP rings uses smp_{r,w,}mb() fences on the
>>> kernel-side. By updating the rings for load-acquire/store-release
>>> semantics, the full barrier on the consumer side can be replaced with
>>> improved performance as a nice side-effect.
>>>
>>> Note that this change does *not* require similar changes on the
>>> libbpf/userland side, however it is recommended [1].
>>>
>>> On x86-64 systems, by removing the smp_mb() on the Rx and Tx side, the
>>> l2fwd AF_XDP xdpsock sample performance increases by
>>> 1%. Weakly-ordered platforms, such as ARM64 might benefit even more.
>>>
>>> [1] https://lore.kernel.org/bpf/20200316184423.GA14143@willie-the-truck/
>>>
>>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>>> ---
>>>   net/xdp/xsk_queue.h | 27 +++++++++++----------------
>>>   1 file changed, 11 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
>>> index 2823b7c3302d..e24279d8d845 100644
>>> --- a/net/xdp/xsk_queue.h
>>> +++ b/net/xdp/xsk_queue.h
>>> @@ -47,19 +47,18 @@ struct xsk_queue {
>>>   	u64 queue_empty_descs;
>>>   };
>>>=20=20=20
>>> -/* The structure of the shared state of the rings are the same as the
>>> - * ring buffer in kernel/events/ring_buffer.c. For the Rx and completi=
on
>>> - * ring, the kernel is the producer and user space is the consumer. For
>>> - * the Tx and fill rings, the kernel is the consumer and user space is
>>> - * the producer.
>>> +/* The structure of the shared state of the rings are a simple
>>> + * circular buffer, as outlined in
>>> + * Documentation/core-api/circular-buffers.rst. For the Rx and
>>> + * completion ring, the kernel is the producer and user space is the
>>> + * consumer. For the Tx and fill rings, the kernel is the consumer and
>>> + * user space is the producer.
>>>    *
>>>    * producer                         consumer
>>>    *
>>> - * if (LOAD ->consumer) {           LOAD ->producer
>>> - *                    (A)           smp_rmb()       (C)
>>> + * if (LOAD ->consumer) {  (A)      LOAD.acq ->producer  (C)
>>=20
>> Why is LOAD.acq not needed on the consumer side?
>>
>
> You mean why LOAD.acq is not needed on the *producer* side, i.e. the
> ->consumer?

Yes, of course! The two words were, like, right next to each other ;)

> The ->consumer is a control dependency for the store, so there is no
> ordering constraint for ->consumer at producer side. If there's no
> space, no data is written. So, no barrier is needed there -- at least
> that has been my perspective.
>
> This is very similar to the buffer in
> Documentation/core-api/circular-buffers.rst. Roping in Paul for some
> guidance.

Yeah, I did read that, but got thrown off by this bit: "Therefore, the
unlock-lock pair between consecutive invocations of the consumer
provides the necessary ordering between the read of the index indicating
that the consumer has vacated a given element and the write by the
producer to that same element."

Since there is no lock in the XSK, what provides that guarantee here?


Oh, and BTW, when I re-read the rest of the comment in xsk_queue.h
(below the diagram you are changing in this patch), the text still talks
about "memory barriers" - maybe that should be updated to
release/acquire as well while you're changing things?

-Toke

