Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189603B7028
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 11:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhF2JkR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 05:40:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34735 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232614AbhF2JkR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Jun 2021 05:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624959470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KBcVNsTwTw4t7ab3uozYsfoVrcxV8lqxnJAi7ZpD9Zo=;
        b=Ks4Fy2VYv+wAEI/axeWLLg8UkTRQsnstnHW214f07ZkOS7vUbLtdQ5bPQyNUMZ6DSd3Z5n
        hFLdetkYr6usquZyplJccWFUfZdH4fHAj3mJnOkzix7HaxoP9UuKL+IzKKc9Sk2ZDyQKcY
        6uHRk4SR/f1Z/A9xsrLdC7dGc6F1s60=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-642A67DeOVGtrb_pkqujEQ-1; Tue, 29 Jun 2021 05:37:49 -0400
X-MC-Unique: 642A67DeOVGtrb_pkqujEQ-1
Received: by mail-ed1-f70.google.com with SMTP id ee28-20020a056402291cb0290394a9a0bfaeso11173358edb.6
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 02:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=KBcVNsTwTw4t7ab3uozYsfoVrcxV8lqxnJAi7ZpD9Zo=;
        b=pZNwrXF0bZsH55EccGZAoGjMKKCYwK973xbvI1Eqz9DpnXfLr5jH5dB3xRvUPY+lg6
         Tj0QYY3OzyqEdQT9Br6MFrXcU6+GbmTkCth+XvmJCNb1KqYOR4HB9FP15IxlKgiSO32u
         Q06sS6c9BpTrI9FA/Qtj7fvo1F9P69qYHJdLzhpt46XKyrYNn9MSNk4VMhXkMuDsBf6P
         A79pnnvw/5ddmOap1eRybqJC5y9BzTR8wjcNeNaY3A3cdvgQrVUdCn/u3n+aSUdujTaK
         W8GhSlDB/bPZdweQenk6pknl3SZC5xDOwIvSNB++ovsKEemDUHys33heHbUEfqMZPUA2
         ViVw==
X-Gm-Message-State: AOAM532N11kbLdY8iptd9z+s4YkjJH4iEHe2o2GwxPIUDicZ9b6NSoTG
        FG9ENpAN1zP3DOwJrX+25OkdzwNMidIsIuya5BOhCS05Km0L6LdmsrXEXubaJYGs2/xsZGXI3uJ
        8VtS6UL7p4iMy
X-Received: by 2002:a17:906:25db:: with SMTP id n27mr28239139ejb.170.1624959467544;
        Tue, 29 Jun 2021 02:37:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOH5SNZqKx/5a+ztg7Mo18FQk9YJwyegOFUl4APyLIzzLuJ0PVk6uaD55PRUVQHNCK6OHWGg==
X-Received: by 2002:a17:906:25db:: with SMTP id n27mr28239117ejb.170.1624959467145;
        Tue, 29 Jun 2021 02:37:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id yd2sm8023006ejb.124.2021.06.29.02.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 02:37:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BE3D818071E; Tue, 29 Jun 2021 11:37:42 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf-next] bpf/devmap: convert remaining READ_ONCE() to
 rcu_dereference()
In-Reply-To: <20210628235559.sgq7txsjmz3s2zeb@kafai-mbp.dhcp.thefacebook.com>
References: <20210628230051.556099-1-toke@redhat.com>
 <20210628235559.sgq7txsjmz3s2zeb@kafai-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 29 Jun 2021 11:37:42 +0200
Message-ID: <87h7hhj9jt.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <kafai@fb.com> writes:

> On Tue, Jun 29, 2021 at 01:00:51AM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> There were a couple of READ_ONCE()-invocations left-over by the devmap R=
CU
>> conversion. Convert these to rcu_dereference() as well to avoid complain=
ts
>> from sparse.
>>=20
>> Fixes: 782347b6bcad ("xdp: Add proper __rcu annotations to redirect map =
entries")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  kernel/bpf/devmap.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
>> index 2f6bd75cd682..7a0c008f751b 100644
>> --- a/kernel/bpf/devmap.c
>> +++ b/kernel/bpf/devmap.c
>> @@ -558,7 +558,7 @@ int dev_map_enqueue_multi(struct xdp_buff *xdp, stru=
ct net_device *dev_rx,
>>=20=20
>>  	if (map->map_type =3D=3D BPF_MAP_TYPE_DEVMAP) {
>>  		for (i =3D 0; i < map->max_entries; i++) {
>> -			dst =3D READ_ONCE(dtab->netdev_map[i]);
>> +			dst =3D rcu_dereference(dtab->netdev_map[i]);
> __dev_map_lookup_elem() uses rcu_dereference_check(dtab->netdev_map[key],=
 rcu_read_lock_bh_held()).
> It is not needed here?

Hmm, I somehow managed to convince myself last night that it wasn't, but
looking at it again now I think you're right. Will send a v2.

-Toke

