Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51B83B31C6
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 16:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhFXOzR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 10:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25169 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230377AbhFXOzQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Jun 2021 10:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624546377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BqTgXghty2FEnYbebm8W12wOyL6TGAtlqo6b00KWGLk=;
        b=jSkJc9rxhjeLbXMRFQbYmPSicA0o1XVWopPZ0M1ON5bAQfJV4tdCzvSyVhHdZp21J205gL
        w03RTEoHnQnftv17cEFZ87Hdem/9C5crPzqa9igQEHwqGr2pGVtqYxQGa2pjT1NKJZwPlm
        LJKjtas+BBdaTtOu0ckLPcPaAZIcscU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-8mMe_R5jNQqd8OJ60pj3rg-1; Thu, 24 Jun 2021 10:52:56 -0400
X-MC-Unique: 8mMe_R5jNQqd8OJ60pj3rg-1
Received: by mail-ej1-f72.google.com with SMTP id 16-20020a1709063010b029037417ca2d43so2112593ejz.5
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 07:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=BqTgXghty2FEnYbebm8W12wOyL6TGAtlqo6b00KWGLk=;
        b=tax1XeC0KRyKdsmk/XmCI4Ga00l7MQUwKcYvxL8t1J7s0hCjtI55I1xpic8hRatNTV
         R/eHxUBiKP3TV28C/zDbjaifW+dcdWhL4BiR/zkMKpLmbdzSN9fugSy7/xGpnYmjS0Lq
         afGO4BHjtxA9E0hS93+Ue9S/j/7+qC+qF01F07ZNaWT65f/bCM5l7ixL7TtwFEFh2EfZ
         PfWJ3P0Rf8cskvG5g06RMfiK66EpkDAVEpqDMrVXepGGKQq5nYqxHoaOUFt5CxBVaWBz
         TMNqlxSZkt69ktTm1CUHnsNjIBYLv3bU8rROQjtxvrT1RAWtdNnWHbvAfUtbtTcBKQST
         Odvw==
X-Gm-Message-State: AOAM531bjHIR660Do5Ewt818i7Ce8gwy3HimMAf84uzU6sXeR09KsNF5
        wLK8J8Kl2kOUtC/XFc71szEb5qVWoJCtbo3xHu6A/TQx1j3ablv8KXCpaOaFGkx6t+kv0JX2vnU
        oAB4TcQI3EtLP
X-Received: by 2002:a17:906:2b0a:: with SMTP id a10mr5648030ejg.521.1624546374742;
        Thu, 24 Jun 2021 07:52:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9eVOJFLTiWjssfy7sq+Hieyv040TSaY+VsPSqg5BuYtJURghjEkYSNKRIAokrtH1mwNvDAQ==
X-Received: by 2002:a17:906:2b0a:: with SMTP id a10mr5647994ejg.521.1624546374320;
        Thu, 24 Jun 2021 07:52:54 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l26sm2110445edt.40.2021.06.24.07.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 07:52:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D6D1E180731; Thu, 24 Jun 2021 16:52:52 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH bpf-next v4 05/19] xdp: add proper __rcu annotations to
 redirect map entries
In-Reply-To: <f26af869-5ea2-878a-a263-ae6f099043e9@iogearbox.net>
References: <20210623110727.221922-1-toke@redhat.com>
 <20210623110727.221922-6-toke@redhat.com>
 <f26af869-5ea2-878a-a263-ae6f099043e9@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 24 Jun 2021 16:52:52 +0200
Message-ID: <87eecrmi0r.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 6/23/21 1:07 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> XDP_REDIRECT works by a three-step process: the bpf_redirect() and
>> bpf_redirect_map() helpers will lookup the target of the redirect and st=
ore
>> it (along with some other metadata) in a per-CPU struct bpf_redirect_inf=
o.
>> Next, when the program returns the XDP_REDIRECT return code, the driver
>> will call xdp_do_redirect() which will use the information thus stored to
>> actually enqueue the frame into a bulk queue structure (that differs
>> slightly by map type, but shares the same principle). Finally, before
>> exiting its NAPI poll loop, the driver will call xdp_do_flush(), which w=
ill
>> flush all the different bulk queues, thus completing the redirect.
> [...]
>>=20
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> [...]
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index c5ad7df029ed..b01e266dad9e 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -762,12 +762,10 @@ DECLARE_BPF_DISPATCHER(xdp)
>>=20=20=20
>>   static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *pro=
g,
>>   					    struct xdp_buff *xdp)
>> -{
>> -	/* Caller needs to hold rcu_read_lock() (!), otherwise program
>> -	 * can be released while still running, or map elements could be
>> -	 * freed early while still having concurrent users. XDP fastpath
>> -	 * already takes rcu_read_lock() when fetching the program, so
>> -	 * it's not necessary here anymore.
>> +
>> +	/* Driver XDP hooks are invoked within a single NAPI poll cycle and th=
us
>> +	 * under local_bh_disable(), which provides the needed RCU protection
>> +	 * for accessing map entries.
>>   	 */
>>   	return __BPF_PROG_RUN(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
>>   }
>
> I just went over the series to manually fix up merge conflicts in the dri=
ver
> patches since they didn't apply cleanly against bpf-next.
>
> But as it turned out that extra work was needless, since you didn't even =
compile
> test the series before submission, sigh.
>
> Please fix (and only submit compile- & runtime-tested code in future).

Yikes! I was too much in a hurry with to re-submit and neglected to
re-do the compile check before hitting send. Apologies, that was sloppy
of me - I will do better in the future.

Will rebase and send a v5 that doesn't blow up on compile :)

-Toke

