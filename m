Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E303ABDD6
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 23:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbhFQVQI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 17:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232867AbhFQVQF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 17:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623964436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gvcjlBEvHeWuTjxP8E3cv/s4SZ5Slc2G2g3da4eluAI=;
        b=Ui+3gRvvl379+39BF4NvuOyOum+HLOvHO55VVucjjADd9luYBq+poN4qKvwbO6uQHJCpYX
        jMBLtvrRPHuaKLVAMja66oG3V37KuGts+mJy8izxQdTLQDHp5dQ0csG/w/6hmV86fx0WdC
        aTHfBL9wi3FyKajbzjaeDdE4rQhN+Sg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-25Z9XmpYPa6HLpKJQLLlEA-1; Thu, 17 Jun 2021 17:13:53 -0400
X-MC-Unique: 25Z9XmpYPa6HLpKJQLLlEA-1
Received: by mail-ed1-f70.google.com with SMTP id y18-20020a0564022712b029038ffac1995eso2376667edd.12
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 14:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gvcjlBEvHeWuTjxP8E3cv/s4SZ5Slc2G2g3da4eluAI=;
        b=PQhfsOvHwwYueQ8apBEDluO6EpNME6+gGtgt5LuYSpJhBJJACQZghLygt7+UQdePgr
         rmadPRvn+kKuTNIA2T4PUjp17JjsbUiJUw3UmE2QfVIyLJxmEvfxEDZdu/JgvJS9B/ka
         hVtHzY+Rtk5dricVUuxLEm9IGS9lZjr+j3vZKAZI0JMiSwxleFhxLCTozoI1Yd3rW9DH
         qNl/k6cn0Ur1/S5CP6FJ/dDXLPkuhQBESJvl2mE89AqLdcHgPnDZntxfu2zqRb1bqR1L
         wsZd3GWoUPRjWtsOQ0ANrGxpst8aiQJRKWALUf/J/JXzj5pryAE+bZTj4eJVFkDxggh/
         71ZA==
X-Gm-Message-State: AOAM530W1vZWtI96xEe/S4mMPw1gTjpCAds2zHNDH9AjDY9MmddMjb1l
        sn3XBYVFp7uA4YGC5QLwlftiWr9dFv61emIUi0SF2lRsOcV2UcCvir9DsnyjStNBMJN43JHbvWc
        eiUxm1IfVOX9D
X-Received: by 2002:a17:907:2642:: with SMTP id ar2mr7403688ejc.391.1623964432381;
        Thu, 17 Jun 2021 14:13:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJgTzSgJN7Vwr5cV0KUJCXbUnYuSmlFDeTdQTiylbTgEQLSZJrOhBB9vBBUggKwM2heDGctQ==
X-Received: by 2002:a17:907:2642:: with SMTP id ar2mr7403675ejc.391.1623964432199;
        Thu, 17 Jun 2021 14:13:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id w8sm5026698edc.39.2021.06.17.14.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:13:50 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6030E180350; Thu, 17 Jun 2021 23:13:49 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH bpf-next v2 03/16] xdp: add proper __rcu annotations to
 redirect map entries
In-Reply-To: <20210617194155.rkfyv2ixgshuknt6@kafai-mbp.dhcp.thefacebook.com>
References: <20210615145455.564037-1-toke@redhat.com>
 <20210615145455.564037-4-toke@redhat.com>
 <20210617194155.rkfyv2ixgshuknt6@kafai-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 17 Jun 2021 23:13:49 +0200
Message-ID: <87czskdwj6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <kafai@fb.com> writes:

> On Tue, Jun 15, 2021 at 04:54:42PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
> [ ... ]
>
>>  static void *__dev_map_hash_lookup_elem(struct bpf_map *map, u32 key)
>>  {
>>  	struct bpf_dtab *dtab =3D container_of(map, struct bpf_dtab, map);
>> @@ -266,7 +270,8 @@ static void *__dev_map_hash_lookup_elem(struct bpf_m=
ap *map, u32 key)
>>  	struct bpf_dtab_netdev *dev;
>>=20=20
>>  	hlist_for_each_entry_rcu(dev, head, index_hlist,
>> -				 lockdep_is_held(&dtab->index_lock))
>> +				 (lockdep_is_held(&dtab->index_lock) ||
>> +				  rcu_read_lock_bh_held()))
> This change is not needed also.

Ah yes, of course - my bad for forgetting to remove that as well. Will
send a v3!

-Toke

