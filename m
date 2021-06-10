Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F433A37A1
	for <lists+bpf@lfdr.de>; Fri, 11 Jun 2021 01:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhFJXHk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Jun 2021 19:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27492 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230103AbhFJXHk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Jun 2021 19:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623366342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zaN/4xw50VkDE65M8AibghHcVWhVfVwq3dgmOVKPedk=;
        b=bhtMle334M4N1NOzw2Brpa1MYz0ModuMllJUlNoO/+mIUbLDcOLKBqpP8CgkY7Ch6zCQzC
        58BT8pnOh8mCH9cHdZYzR6gvx2RQTmDeof+h5BSNHvcHExwjK4BosiU789cRuqo1J0i9Mn
        NV9nCL98CadvnBKH3nLqHRy0+MIy4RY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-5-S0vcYUMaCzwbtXHN2RmA-1; Thu, 10 Jun 2021 19:05:41 -0400
X-MC-Unique: 5-S0vcYUMaCzwbtXHN2RmA-1
Received: by mail-ed1-f72.google.com with SMTP id j13-20020aa7de8d0000b029038fc8e57037so15023738edv.0
        for <bpf@vger.kernel.org>; Thu, 10 Jun 2021 16:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zaN/4xw50VkDE65M8AibghHcVWhVfVwq3dgmOVKPedk=;
        b=DQI1B2wsIJ0cNZpB8JWfQyjrGhPjU4KEUET9K0s/ep4fifgCsCZRTPX2ZMpRcjITwJ
         0mObMU1fFxq8P5VNrLlOc18BwLgu+vKPJ1ZZneOBYqTl5IFTQocdo6cOAwfuZxGAPk9v
         r6gh8BK2lr2h/KnfPG5Zp3FIxsbWkBWogWizsLtd8UiBItb3u65TPnd/e5uaG03cy9M6
         xH44SnasYcLkGrwUFxrzoFXNO1E9/+ITUg8fFDOi6kcdJJSqeWpQESXNaVrswkod6B2X
         cSgRsWve+a2bxxLLW9S5UW0lofZR3B8S3wtRANIW+KizIQc79hTolFXN19qel1BZgFBj
         6uMg==
X-Gm-Message-State: AOAM531syDwVFCaOORMKY7bFgG/y7pNTQOeum1CDH8NszI1H/Q7LYVMj
        Rd0zLg02jrt5soeBRfOPmv4FNhxYkfp+Fmx0iMAHEbsymTjts4TvuoeFzp/327bbuAhgKnKrxrA
        YhXZiPEjMXulV
X-Received: by 2002:aa7:c9cf:: with SMTP id i15mr788025edt.118.1623366340323;
        Thu, 10 Jun 2021 16:05:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7UrdC3NbigfdW/whZC2A9NUxkEVZp/6LZemrS5UvqVh5wxoS0Eay52k4MdJevVhm+NwJX1Q==
X-Received: by 2002:aa7:c9cf:: with SMTP id i15mr788003edt.118.1623366339966;
        Thu, 10 Jun 2021 16:05:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id de19sm2016257edb.70.2021.06.10.16.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 16:05:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A3A1818071E; Fri, 11 Jun 2021 01:05:38 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH bpf-next 03/17] dev: add rcu_read_lock_bh_held() as a
 valid check when getting a RCU dev ref
In-Reply-To: <20210610193722.753tqgrovwyg2v6v@kafai-mbp>
References: <20210609103326.278782-1-toke@redhat.com>
 <20210609103326.278782-4-toke@redhat.com>
 <20210610193722.753tqgrovwyg2v6v@kafai-mbp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 11 Jun 2021 01:05:38 +0200
Message-ID: <87lf7huxq5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <kafai@fb.com> writes:

> On Wed, Jun 09, 2021 at 12:33:12PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Some of the XDP helpers (in particular, xdp_do_redirect()) will get a
>> struct net_device reference using dev_get_by_index_rcu(). These are call=
ed
>> from a NAPI poll context, which means the RCU reference liveness is ensu=
red
>> by local_bh_disable(). Add rcu_read_lock_bh_held() as a condition to the
>> RCU list traversal in dev_get_by_index_rcu() so lockdep understands that
>> the dereferences are safe from *both* an rcu_read_lock() *and* with
>> local_bh_disable().
>>=20
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  net/core/dev.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index febb23708184..a499c5ffe4a5 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -1002,7 +1002,7 @@ struct net_device *dev_get_by_index_rcu(struct net=
 *net, int ifindex)
>>  	struct net_device *dev;
>>  	struct hlist_head *head =3D dev_index_hash(net, ifindex);
>>=20=20
>> -	hlist_for_each_entry_rcu(dev, head, index_hlist)
>> +	hlist_for_each_entry_rcu(dev, head, index_hlist, rcu_read_lock_bh_held=
())
> Is it needed?  hlist_for_each_entry_rcu() checks for
> rcu_read_lock_any_held().  Did lockdep complain?

Ah, yes, I think you're right. I totally missed that
rcu_read_lock_any_held() includes a '!preemptible()' check at the end.
I'll drop this patch, then!

-Toke

