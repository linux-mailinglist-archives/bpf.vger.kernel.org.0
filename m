Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02402941EF
	for <lists+bpf@lfdr.de>; Tue, 20 Oct 2020 20:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408952AbgJTSKe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Oct 2020 14:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392266AbgJTSKd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 20 Oct 2020 14:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603217432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wQkEDlaX0HhcNfQVpcDzMD97CIPghzROCngfCJtHNvk=;
        b=DZDZBgWkSG1Ayri9br4+7TXVzUxsJsdS93M6a8fWUlS8WEibl8Cvr3a/9vgyv11eRTp+tI
        IIJLenHuy1QB59TkKoi+Dq9hI1lzBtr+1Re/DtHBD93lGK5ZaYCtVqmSF4MDI3KzY6d7Dz
        ZNLuCkQWrlo4kPu2xD7Zcz/FX4EKcIg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-JJGCmJMEMxGbgKuxhsFInA-1; Tue, 20 Oct 2020 14:10:30 -0400
X-MC-Unique: JJGCmJMEMxGbgKuxhsFInA-1
Received: by mail-ej1-f69.google.com with SMTP id f11so1149289eja.23
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2020 11:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wQkEDlaX0HhcNfQVpcDzMD97CIPghzROCngfCJtHNvk=;
        b=JnJAqVmX35GgT75VHHtSUROmgQSiZU7bx0xdQDTisBx6N/ZjLqcuPT5CN0zUZWeHBQ
         jzjG81hhEglzZ90HeURc7CbKVDO8azTay9w7UHsSMarjuFbSdsxbZadmmgKUB1Z7ivKb
         XD7jO4YKNqgd3A7v5XL6wbDbYalJJ3pC+gAUa3k1Qy3Hn9ETWdUYCyVOcEu0ASn8UJEa
         YTB5WAWQxbTO3FutlI8kriq22DCKW9vesVRCb9EOoM2sOoCGB7f5dfsqheuOgPJKCoSK
         VpK4MhW7nEpKVt+5qpAcYBg2f3PrW6ygMQ+A/sv6H8+t8ELOysHTGmOwdeWXEJHkzFzh
         zByA==
X-Gm-Message-State: AOAM533MTwSMsDtUi5hx34ecDbP+rDCYit5ZxhzWdH8gv/8LnB5lV7s1
        XgUrGbaNVTkxcUL5/YGcac3T29NktzLvRp/Hwn1GcQrHNBn2nFgoRXbYbNT67NCuEyGfqdjl21L
        uDVQG0fXxzZUG
X-Received: by 2002:aa7:c451:: with SMTP id n17mr3954954edr.266.1603217428850;
        Tue, 20 Oct 2020 11:10:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxb8RfZZaiXvqsd4csTOW12ZXkF+OQAkeNwopG2y4VHehycPYbUl2BlTzVLM+QyMZzfJ/VXBg==
X-Received: by 2002:aa7:c451:: with SMTP id n17mr3954912edr.266.1603217428342;
        Tue, 20 Oct 2020 11:10:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id b13sm3362589edk.22.2020.10.20.11.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 11:10:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 588941838FA; Tue, 20 Oct 2020 20:10:27 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>
Cc:     David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/3] bpf_fib_lookup: optionally skip neighbour
 lookup
In-Reply-To: <9506a687-64a7-8cf4-008f-c4a10f867c01@iogearbox.net>
References: <160319106111.15822.18417665895694986295.stgit@toke.dk>
 <160319106331.15822.2945713836148003890.stgit@toke.dk>
 <20784134-7f4c-c263-5d62-facbb2adb8a8@gmail.com>
 <9506a687-64a7-8cf4-008f-c4a10f867c01@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 20 Oct 2020 20:10:27 +0200
Message-ID: <87pn5c22gc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 10/20/20 3:49 PM, David Ahern wrote:
>> On 10/20/20 4:51 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>>
>>> The bpf_fib_lookup() helper performs a neighbour lookup for the destina=
tion
>>> IP and returns BPF_FIB_LKUP_NO_NEIGH if this fails, with the expectation
>>> that the BPF program will deal with this condition, either by passing t=
he
>>> packet up the stack, or by using bpf_redirect_neigh().
>>>
>>> The neighbour lookup is done via a hash table (through ___neigh_lookup_=
noref()),
>>> which incurs some overhead. If the caller knows this is likely to fail
>>> anyway, it may want to skip that and go unconditionally to
>>> bpf_redirect_neigh(). For this use case, add a flag to bpf_fib_lookup()
>>> that will make it skip the neighbour lookup and instead always return
>>> BPF_FIB_LKUP_RET_NO_NEIGH (but still populate the gateway and target
>>> ifindex).
>>>
>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>> ---
>>>   include/uapi/linux/bpf.h       |   10 ++++++----
>>>   net/core/filter.c              |   16 ++++++++++++++--
>>>   tools/include/uapi/linux/bpf.h |   10 ++++++----
>>>   3 files changed, 26 insertions(+), 10 deletions(-)
>>=20
>> Nack. Please don't.
>>=20
>> As I mentioned in my reply to Daniel, I would prefer such logic be
>> pushed to the bpf programs. There is no reason for rare run time events
>> to warrant a new flag and new check in the existing FIB helpers. The bpf
>> programs can take the hit of the extra lookup.
>
> Fair enough, lets push it to progs then.

OK, with this and the other comments, this goes back to v1 + the
compilation fix. Will send that as v3...

-Toke

