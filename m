Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6703A3802
	for <lists+bpf@lfdr.de>; Fri, 11 Jun 2021 01:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhFJXnT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Jun 2021 19:43:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22045 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230212AbhFJXnS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Jun 2021 19:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623368481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AR0ush4P46QAA/VTr4sxcEcbJnlOs/9qEWXHNYSYYUQ=;
        b=Y3Q2JmryRvG9sc602XNmPb4l6vzWb/PV7hZBPdNFdFgGJrUJRkRZTCx7pXQfzFcX17eEuO
        SYrRxbindGbyHmh59QXQtxJdQz6K/G+0jRTHJk3oclAcnrLyXsg5i9hxwtMnPe/O5U3lVY
        PRpR+65djJsVob9jr01AuVV/tJPf0uM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-QOU5XowKPTSMvVA7QTqOlg-1; Thu, 10 Jun 2021 19:41:19 -0400
X-MC-Unique: QOU5XowKPTSMvVA7QTqOlg-1
Received: by mail-ej1-f69.google.com with SMTP id f1-20020a1709064941b02903f6b5ef17bfso316755ejt.20
        for <bpf@vger.kernel.org>; Thu, 10 Jun 2021 16:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=AR0ush4P46QAA/VTr4sxcEcbJnlOs/9qEWXHNYSYYUQ=;
        b=G4E0rrUjiMrMrxj3LgNxHbfmlHEO9FJrU1IehPeRIiHi6ZB3BQzNju0ppUPXZX8HgD
         WsioiqpXHNdQmFjckCqQry/QccsY6X5N++b9MeBylBW2RNuFhj61cty7U4iQRU8VmGnO
         OPlHG91uk+6XxaAYosAUtS3B1bZczbx0Rp2sw/AfBolfUNKDtxI6fTPCByVXlo2YFXZi
         0I3HQkwjV4UctDveupgALqT8hZJcu9x57dx4LmKl2TaqRX8UYF4g+63hrAfyYhAJp/z2
         prSLIJc+DIJr24uXEQY7iEf56l4yNwl5J80Scv0PHgmILLeUthm4ZuhZwBZWUJ/qweXX
         5daA==
X-Gm-Message-State: AOAM530kCBzo2MEVvloAKJ/Gk5ndWRVT4IaUoyqN6Z2VHncqnMpnhbmP
        5D4o6mOjTUrJEOZqHL/uSFl82ZMzP7hJGPN1aA3bPMrpcKCljfJpouCJ9bHnAJ+S9kcfFd0/wIE
        n5eKnziK9/E7K
X-Received: by 2002:a17:906:5593:: with SMTP id y19mr804341ejp.195.1623368478610;
        Thu, 10 Jun 2021 16:41:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfAVO4j19hF8iHvKpB3Qu7rdUUGFfFgZC6tpT4QpPjBqlLyhJfjXi+mQHXRw8tGerKkBYXwg==
X-Received: by 2002:a17:906:5593:: with SMTP id y19mr804327ejp.195.1623368478286;
        Thu, 10 Jun 2021 16:41:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id bd3sm1979645edb.34.2021.06.10.16.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 16:41:17 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2100F18071E; Fri, 11 Jun 2021 01:41:17 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH bpf-next 04/17] xdp: add proper __rcu annotations to
 redirect map entries
In-Reply-To: <20210610233250.pef2dwo2r5atluwt@kafai-mbp>
References: <20210609103326.278782-1-toke@redhat.com>
 <20210609103326.278782-5-toke@redhat.com>
 <20210610210907.hgfnlja3hbmgeqxx@kafai-mbp> <87h7i5ux3r.fsf@toke.dk>
 <20210610233250.pef2dwo2r5atluwt@kafai-mbp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 11 Jun 2021 01:41:17 +0200
Message-ID: <875yyluw2q.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <kafai@fb.com> writes:

> On Fri, Jun 11, 2021 at 01:19:04AM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> >> @@ -149,7 +152,8 @@ static int xsk_map_update_elem(struct bpf_map *ma=
p, void *key, void *value,
>> >>  			       u64 map_flags)
>> >>  {
>> >>  	struct xsk_map *m =3D container_of(map, struct xsk_map, map);
>> >> -	struct xdp_sock *xs, *old_xs, **map_entry;
>> >> +	struct xdp_sock __rcu **map_entry;
>> >> +	struct xdp_sock *xs, *old_xs;
>> >>  	u32 i =3D *(u32 *)key, fd =3D *(u32 *)value;
>> >>  	struct xsk_map_node *node;
>> >>  	struct socket *sock;
>> >> @@ -179,7 +183,7 @@ static int xsk_map_update_elem(struct bpf_map *ma=
p, void *key, void *value,
>> >>  	}
>> >>=20=20
>> >>  	spin_lock_bh(&m->lock);
>> >> -	old_xs =3D READ_ONCE(*map_entry);
>> >> +	old_xs =3D rcu_dereference_check(*map_entry, rcu_read_lock_bh_held(=
));
>> > Is it actually protected by the m->lock at this point?
>>=20
>> True, can just add that to the check.
> this should be enough
> rcu_dereference_protected(*map_entry, lockdep_is_held(&m->lock));

Right, that's what I had in mind as well :)

-Toke

