Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B863A37BE
	for <lists+bpf@lfdr.de>; Fri, 11 Jun 2021 01:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhFJXVH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Jun 2021 19:21:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230488AbhFJXVH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Jun 2021 19:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623367150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aD2LL3NxQAPf5GU2IavUhu+JCNdlw6JkWCN21CEpMvM=;
        b=W7QTWUJ8Nm5395fwmGiI0CyNPQhTdzXhm5JxnWx2iY47tOTxOdHtZSoF8l93GcOE7YZX8J
        bdXnX4szavIScs8aDlXSIDmuUotBZ7jyL6rtMdObtlsz26nzP0ucpX7xiXVcFkuARkGRkg
        SH7tF5wEKNbk8m0TWUihCo7RNnL/KV8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-1FfjhZZcPj-yNCqsC5W3gw-1; Thu, 10 Jun 2021 19:19:08 -0400
X-MC-Unique: 1FfjhZZcPj-yNCqsC5W3gw-1
Received: by mail-ed1-f72.google.com with SMTP id u26-20020a05640207dab02903935beb5c71so9238109edy.3
        for <bpf@vger.kernel.org>; Thu, 10 Jun 2021 16:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=aD2LL3NxQAPf5GU2IavUhu+JCNdlw6JkWCN21CEpMvM=;
        b=BWhRyehoQGkXbLv+LomPwXu+VatxgCg8sjmqr/QnBjGt+cYse1GqONyzS0UmRW1QI8
         5N8zqfF5+emyZqM2myU03eiNq56Z7KxS72nah7k0A+g5LSooIOzgXlEhCYL7OPGwsf3j
         VFh/pI5Xp/eaAAeGsjflvwDH6PAnW71b6aXzcvtuvWhyk966a/DmNqZXBZA+hNrmNRAi
         3qH4awld53ZPX2epvtRcLT5SDxn9PMJH6NnBnP/ALIwD9PrOQFnQRdHvfvALeM4011n6
         R4zeW4jQRgNNpFSPSFQZNh8hZ8rP6lDyah5DZVdf8GXZ6cuuisQjV/jIUfymO1kRJ3DN
         5s0g==
X-Gm-Message-State: AOAM531Pvk721qYx2fPf75+0TVinF8YLfNW0WM4IV1IsKWWQdoDXJ0vd
        AArqNIoSV5q881uMd6PjAemwRPMO9yARmFum/RRtrJE0j9n3vS+uVDApk0lWShzugKXnvZWNXxg
        RHIPqqKMUJ1EO
X-Received: by 2002:a05:6402:543:: with SMTP id i3mr813012edx.173.1623367147336;
        Thu, 10 Jun 2021 16:19:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJcQHadF+yyqcRV1h5SBOoobAmF9eGTr/BROLCWcwTjLdMTEy2ywy8fwdMBnCkASCzU23cSQ==
X-Received: by 2002:a05:6402:543:: with SMTP id i3mr813002edx.173.1623367147217;
        Thu, 10 Jun 2021 16:19:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f10sm1951780edx.60.2021.06.10.16.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 16:19:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BFCD618071E; Fri, 11 Jun 2021 01:19:04 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH bpf-next 04/17] xdp: add proper __rcu annotations to
 redirect map entries
In-Reply-To: <20210610210907.hgfnlja3hbmgeqxx@kafai-mbp>
References: <20210609103326.278782-1-toke@redhat.com>
 <20210609103326.278782-5-toke@redhat.com>
 <20210610210907.hgfnlja3hbmgeqxx@kafai-mbp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 11 Jun 2021 01:19:04 +0200
Message-ID: <87h7i5ux3r.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <kafai@fb.com> writes:

> On Wed, Jun 09, 2021 at 12:33:13PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
> [ ... ]
>
>> @@ -551,7 +551,8 @@ static void cpu_map_free(struct bpf_map *map)
>>  	for (i =3D 0; i < cmap->map.max_entries; i++) {
>>  		struct bpf_cpu_map_entry *rcpu;
>>=20=20
>> -		rcpu =3D READ_ONCE(cmap->cpu_map[i]);
>> +		rcpu =3D rcu_dereference_check(cmap->cpu_map[i],
>> +					     rcu_read_lock_bh_held());
> Is rcu_read_lock_bh_held() true during map_free()?

Hmm, no, I guess not since that's called from a workqueue. Will fix!

>> @@ -149,7 +152,8 @@ static int xsk_map_update_elem(struct bpf_map *map, =
void *key, void *value,
>>  			       u64 map_flags)
>>  {
>>  	struct xsk_map *m =3D container_of(map, struct xsk_map, map);
>> -	struct xdp_sock *xs, *old_xs, **map_entry;
>> +	struct xdp_sock __rcu **map_entry;
>> +	struct xdp_sock *xs, *old_xs;
>>  	u32 i =3D *(u32 *)key, fd =3D *(u32 *)value;
>>  	struct xsk_map_node *node;
>>  	struct socket *sock;
>> @@ -179,7 +183,7 @@ static int xsk_map_update_elem(struct bpf_map *map, =
void *key, void *value,
>>  	}
>>=20=20
>>  	spin_lock_bh(&m->lock);
>> -	old_xs =3D READ_ONCE(*map_entry);
>> +	old_xs =3D rcu_dereference_check(*map_entry, rcu_read_lock_bh_held());
> Is it actually protected by the m->lock at this point?

True, can just add that to the check.

>>  void xsk_map_try_sock_delete(struct xsk_map *map, struct xdp_sock *xs,
>> -			     struct xdp_sock **map_entry)
>> +			     struct xdp_sock __rcu **map_entry)
>>  {
>>  	spin_lock_bh(&map->lock);
>> -	if (READ_ONCE(*map_entry) =3D=3D xs) {
>> -		WRITE_ONCE(*map_entry, NULL);
>> +	if (rcu_dereference(*map_entry) =3D=3D xs) {
> nit. rcu_access_pointer()?

Yup.

