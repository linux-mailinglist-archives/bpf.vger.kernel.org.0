Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374AC287D9C
	for <lists+bpf@lfdr.de>; Thu,  8 Oct 2020 23:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbgJHVE6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Oct 2020 17:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49801 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729593AbgJHVE5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Oct 2020 17:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602191096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UqB3iHz5/cM/cl4ywBFbnzeZWHwKJOe5Pql/dzy6gPc=;
        b=KgVcIblTWcVQEUzFKfLCC/0R/qNAFCthRVkKlOMVCsj1Kj54heqjIZ1MhX5OwCZn8C5GpB
        fKQcenW2yz8IkvuPL59kdbrT60ScgpbY4rdSP1S20AIJ1PDjDmPrrymrFy6S+fx8Faj12U
        w/xZCAmLWX7rDe9gxCL59b2rxEAhaTY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-crEMYoqXMFG1eMdezg2Iew-1; Thu, 08 Oct 2020 17:04:54 -0400
X-MC-Unique: crEMYoqXMFG1eMdezg2Iew-1
Received: by mail-wr1-f70.google.com with SMTP id l17so4315062wrw.11
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2020 14:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=UqB3iHz5/cM/cl4ywBFbnzeZWHwKJOe5Pql/dzy6gPc=;
        b=MePpkWlXsvjtR1PDfHqzeTUmPOnmPKBAvCXslVMB8DpVvfGnQzi/rQT7aJOjHX1Ych
         pNGEx8Qer5+SwNVQQXK1wBlAaSjIu3H+Ja9mSfFHXQmIguxp/0o1FTKTnUaM4JMTf+j9
         dTI7SZJEPMUcxCjsnz8kMNjkIF61Oo/6g9jJSmo0on7PyptUV5PdAfD9FHSJow11n/WM
         RRPBfmhIqpH+7z9KDBCufUAWd8wCf0bZox3aEaQBtuaNm0cFQFwJj5/9yRK9OpKy6p17
         24Kzq4O+b7FZKIkOst/4MAN0HHnP6wzyH+s0fsUksnwwmT4TZxWd0IzTPGXeqnXOECxA
         VChA==
X-Gm-Message-State: AOAM530akJGBmlxV3O0aeqVAHpVaTULDY+ucNZcVkFfWG3VOt7ar2fpX
        WjUlZOqGVQe4suaE1Je8BmfqYVrNsL21igW40fYBMVJ1suuhm3kt068M6N62lsjj+2hzUdmdFVy
        JUFMOSVwFN4dM
X-Received: by 2002:a5d:558e:: with SMTP id i14mr11992330wrv.40.1602191093195;
        Thu, 08 Oct 2020 14:04:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwad84X0Kl74b51WU6538iqq8F7ZrvmioS8u9IhfGJlG5f+WTZFazhnQGbQPqa5DPO1NMKxqg==
X-Received: by 2002:a5d:558e:: with SMTP id i14mr11992290wrv.40.1602191092605;
        Thu, 08 Oct 2020 14:04:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id z6sm3745711wrs.2.2020.10.08.14.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 14:04:52 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 850411837DC; Thu,  8 Oct 2020 23:04:51 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>, ast@fb.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH bpf-next] bpf_fib_lookup: return target ifindex even if
 neighbour lookup fails
In-Reply-To: <5d900a50-31f6-c311-8200-424369872092@iogearbox.net>
References: <20201008145314.116800-1-toke@redhat.com>
 <bf190e76-b178-d915-8d0d-811905d38fd2@iogearbox.net>
 <87a6wwe8nu.fsf@toke.dk>
 <5d900a50-31f6-c311-8200-424369872092@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 08 Oct 2020 23:04:51 +0200
Message-ID: <877ds0e8ek.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

n> On 10/8/20 10:59 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>> On 10/8/20 4:53 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> The bpf_fib_lookup() helper performs a neighbour lookup for the destin=
ation
>>>> IP and returns BPF_FIB_LKUP_NO_NEIGH if this fails, with the expectati=
on
>>>> that the BPF program will pass the packet up the stack in this case.
>>>> However, with the addition of bpf_redirect_neigh() that can be used in=
stead
>>>> to perform the neighbour lookup.
>>>>
>>>> However, for that we still need the target ifindex, and since
>>>> bpf_fib_lookup() already has that at the time it performs the neighbour
>>>> lookup, there is really no reason why it can't just return it in any c=
ase.
>>>> With this fix, a BPF program can do the following to perform a redirect
>>>> based on the routing table that will succeed even if there is no neigh=
bour
>>>> entry:
>>>>
>>>> 	ret =3D bpf_fib_lookup(skb, &fib_params, sizeof(fib_params), 0);
>>>> 	if (ret =3D=3D BPF_FIB_LKUP_RET_SUCCESS) {
>>>> 		__builtin_memcpy(eth->h_dest, fib_params.dmac, ETH_ALEN);
>>>> 		__builtin_memcpy(eth->h_source, fib_params.smac, ETH_ALEN);
>>>>
>>>> 		return bpf_redirect(fib_params.ifindex, 0);
>>>> 	} else if (ret =3D=3D BPF_FIB_LKUP_RET_NO_NEIGH) {
>>>> 		return bpf_redirect_neigh(fib_params.ifindex, 0);
>>>> 	}
>>>>
>>>> Cc: David Ahern <dsahern@gmail.com>
>>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>>
>>> ACK, this looks super useful! Could you also add a new flag which would=
 skip
>>> neighbor lookup in the helper while at it (follow-up would be totally f=
ine from
>>> my pov since both are independent from each other)?
>>=20
>> Sure, can do. Thought about adding it straight away, but wasn't sure if
>> it would be useful, since the fib lookup has already done quite a lot of
>> work by then. But if you think it'd be useful, I can certainly add it.
>> I'll look at this tomorrow; if you merge this before then I'll do it as
>> a follow-up, and if not I'll respin with it added. OK? :)
>
> Sounds good to me; merge depending on David's final verdict in the other =
thread
> wrt commit description.

Yup, figured that'd be the case - great :)

-Toke

