Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EE42C82DA
	for <lists+bpf@lfdr.de>; Mon, 30 Nov 2020 12:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgK3LFy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Nov 2020 06:05:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49096 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725976AbgK3LFy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Nov 2020 06:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606734267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6VS/5KUo43qh82flnNysNY37J2UIcY8iW6tlzsICFF4=;
        b=WC7KceVlFrUe9rdLlB5b6/ol/eD0YZc+eSAx719H8/Xy0EX6KTTcxbFSxo7wPprKgVE0PP
        AUW3REi7A48cmWWLS+GwKtvk78OnpwMIeJd3N7bibYU5hnQOJXL7shbOqs9vKPs/U/D7iq
        getTiuVDEzkKY3/K0id26t83c++GtZw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-wGr86LDnNMebeNBACMaF8w-1; Mon, 30 Nov 2020 06:04:25 -0500
X-MC-Unique: wGr86LDnNMebeNBACMaF8w-1
Received: by mail-qv1-f70.google.com with SMTP id m45so7161657qvg.16
        for <bpf@vger.kernel.org>; Mon, 30 Nov 2020 03:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6VS/5KUo43qh82flnNysNY37J2UIcY8iW6tlzsICFF4=;
        b=KqbwEkJrHcrPaIQxssBWNNq9Sd+ch4CgF6JC4CJAUQpZViSOhUvBQZETMhfJJDcf2q
         DRHkF2K8Y6cZOLqhU05PobUmqA/bU4izZ42hMK89DJv6JACjNY8UbrhlDO3y3WpaJ6Of
         IrP6KVWJmdAKX3AIjwdqsy01KmSohHCUYRUJpzH/CD9Sllc6ioV4IRmLWAcaRhrejvpn
         L1Tg6bscWVlmSnO9Ai+5TOeeZnsOY76pODq685fdWgecejsf1YxEgFMZ+pSfT39mu26W
         QYtm4aEKpkAeQoBYE+L6vT+tmKLQeP9+HfvvFXE9WO6wV6iK73kQQ85pRuwXOqWh6Wy1
         EPKA==
X-Gm-Message-State: AOAM530cw7cVAa+/bgOk8eA+BwZBtL8FCgYFajYNVEw9lvvGCb0uzQi4
        Clpb5swygoAzLOIRym4398W58C4p16NIM2hHQFEcv2H3hfnDddO4j5s/h2eS6Wn+2KeoTModb6D
        sdL9NH3xp96TX
X-Received: by 2002:a0c:f9c8:: with SMTP id j8mr21740784qvo.17.1606734264865;
        Mon, 30 Nov 2020 03:04:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrI+aWvYVbi4psMJoPYVI6PP1YQxo+ZhMJj+gxoeqZdQEktLdk7ENvzTCpRltsxQu3d/ag1A==
X-Received: by 2002:a0c:f9c8:: with SMTP id j8mr21740730qvo.17.1606734264371;
        Mon, 30 Nov 2020 03:04:24 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id p22sm14956835qtu.61.2020.11.30.03.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 03:04:23 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B8755182EDC; Mon, 30 Nov 2020 12:04:11 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     David Ahern <dsahern@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Hangbin Liu <haliu@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH iproute2-next 0/5] iproute2: add libbpf support
In-Reply-To: <08071e1e-497f-f53e-916a-8b519fdd1e0f@gmail.com>
References: <20201023033855.3894509-1-haliu@redhat.com>
 <20201128221635.63fdcf69@hermes.local>
 <08071e1e-497f-f53e-916a-8b519fdd1e0f@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 30 Nov 2020 12:04:11 +0100
Message-ID: <878saj6r84.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Ahern <dsahern@gmail.com> writes:

> On 11/28/20 11:16 PM, Stephen Hemminger wrote:
>> Luca wants to put this in Debian 11 (good idea), but that means:
>> 
>> 1. It has to work with 5.10 release and kernel.
>> 2. Someone has to test it.
>> 3. The 5.10 is a LTS kernel release which means BPF developers have
>>    to agree to supporting LTS releases.
>> 
>> If someone steps up to doing this then I would be happy to merge it now
>> for 5.10. Otherwise it won't show up until 5.11.
>
> It would be good for Bullseye to have the option to use libbpf with
> iproute2. If Debian uses the 5.10 kernel then it should use the 5.10
> version of iproute2 and 5.10 version libbpf. All the components align
> with consistent versioning.
>
> I have some use cases I can move from bpftool loading to iproute2 as
> additional testing to what Hangbin has already done. If that goes well,
> I can re-send the patch series against iproute2-main branch by next weekend.

This is fine by me - there's nothing in the iproute2 patches that
depends on any particular version of libbpf newer than 0.1.0 (that was
the whole point), so it's just a matter of when you guys want to merge
it.

> It would be good for others (Jesper, Toke, Jiri) to run their own
> testing as well.

I'll do some manual testing, and once we get this into RHEL it'll be
part of automated testing there as well. The latter may take a while,
though, so don't count on it for any initial verification...

-Toke

