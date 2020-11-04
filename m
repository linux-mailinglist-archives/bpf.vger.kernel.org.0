Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AED2A6331
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 12:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgKDLVl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 06:21:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728700AbgKDLVB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 06:21:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604488860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kVJFexBYORK6LujKRJ/7Ae6OMTPvLiGlGkCyVBuOcDM=;
        b=aOyiKTpa6Zlbry86oFuoWsNzmi63G1QyNg8ismlOmY01au9k4U7Kmsl77/e/ohcXqzAZPe
        tpSMTEzHjH5AuIpDw+nwcKWLsPGPftm3OmhHKpc0ERD5dgYTNQzxwzcFbHqyp5nuYtMjmw
        tUqkwtkeGNvLc+aiMFg810iVesDkl4c=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-NGYRhERxPwOk5Kp-xPMVNQ-1; Wed, 04 Nov 2020 06:20:59 -0500
X-MC-Unique: NGYRhERxPwOk5Kp-xPMVNQ-1
Received: by mail-il1-f197.google.com with SMTP id f66so3013011ilh.17
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2020 03:20:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kVJFexBYORK6LujKRJ/7Ae6OMTPvLiGlGkCyVBuOcDM=;
        b=G2YH6tusqvcu1sMCAa9d6gew35zmRsJdWva8E+Ev7aanBvCmRvJ4BPzMXKnefRdjf9
         asC/6j7ELxtV+cXA29Ccrhxd+wfwBixS3j1SS87sv+Qya535s9s9lh/J6k7iMTfwSf0X
         QL9jxAX5nNW8/VwlsqTAR/wvwKtYni8+4Ua1tnHR/SoXvsMB4UTxwPTpOZaOeWslsnq0
         GDgohltk1kzR9aYZCrO5XjkSZyEFSk8pdv5IN/8622ytxl5/0vy8F2q1GFdX9rw7zgTK
         322e2R+d0Z8c9Etr8Kj43nEm5YqdpgrsnjvrMtP03Lc93fd6YgS9fNNwVb9PzFlfjvCQ
         e8Vg==
X-Gm-Message-State: AOAM5318woTAZE7pprt1RmTG+KYjafkF7Y/uO32I93sgMR6aJm64ZSkw
        5n8aTCZmbezA1jrSF02NKU48rn3DQ9E9vmnPBbPE4Xuhd1j0HNXShX6lTsEDdsHIvoy4nFCdn2F
        lqY6mm7yYfP4M
X-Received: by 2002:a92:cd0e:: with SMTP id z14mr17714481iln.135.1604488858214;
        Wed, 04 Nov 2020 03:20:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkj71aBOqrF8EWkX1F2oYxOUtX4FAv6s4KPWoix8aCQRdFgu+SsBNfZPQny7ZaVL/MovtwYA==
X-Received: by 2002:a92:cd0e:: with SMTP id z14mr17714451iln.135.1604488857773;
        Wed, 04 Nov 2020 03:20:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id p6sm1319598ilc.26.2020.11.04.03.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 03:20:57 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2502E181CED; Wed,  4 Nov 2020 12:20:55 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Hangbin Liu <haliu@redhat.com>
Cc:     David Ahern <dsahern@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Jiri Benc <jbenc@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCHv3 iproute2-next 0/5] iproute2: add libbpf support
In-Reply-To: <2e8ba0be-51bf-9060-e1f7-2148fbaf0f1d@iogearbox.net>
References: <20201028132529.3763875-1-haliu@redhat.com>
 <20201029151146.3810859-1-haliu@redhat.com>
 <646cdfd9-5d6a-730d-7b46-f2b13f9e9a41@gmail.com>
 <CAEf4BzYupkUqfgRx62uq3gk86dHTfB00ZtLS7eyW0kKzBGxmKQ@mail.gmail.com>
 <edf565cf-f75e-87a1-157b-39af6ea84f76@iogearbox.net>
 <3306d19c-346d-fcbc-bd48-f141db26a2aa@gmail.com>
 <CAADnVQ+EWmmjec08Y6JZGnan=H8=X60LVtwjtvjO5C6M-jcfpg@mail.gmail.com>
 <71af5d23-2303-d507-39b5-833dd6ea6a10@gmail.com>
 <20201103225554.pjyuuhdklj5idk3u@ast-mbp.dhcp.thefacebook.com>
 <20201104021730.GK2408@dhcp-12-153.nay.redhat.com>
 <20201104031145.nmtggnzomfee4fma@ast-mbp.dhcp.thefacebook.com>
 <2e8ba0be-51bf-9060-e1f7-2148fbaf0f1d@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 04 Nov 2020 12:20:55 +0100
Message-ID: <87zh3xv04o.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> Back in the days when developing lib/bpf.c, it was explicitly done as
> built-in for iproute2 so that it doesn't take years for users to
> actually get to the point where they can realistically make use of it.
> If we were to extend the internal lib/bpf.c to similar feature state
> as libbpf today, how is that different in the bigger picture compared
> to sync or submodule... so far noone complained about lib/bpf.c.

Except that this whole effort started because lib/bpf.c is slowly
bitrotting into oblivion? If all the tools are dynamically linked
against libbpf, that's only one package the distros have to keep
up-to-date instead of a whole list of tools. How does that make things
*worse*?

-Toke

