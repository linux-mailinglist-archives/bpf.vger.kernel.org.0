Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7180F120EE0
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2019 17:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLPQLJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Dec 2019 11:11:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21221 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbfLPQLG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Dec 2019 11:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576512665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Knu3sFj/QXVI2qM2aimTaESR+T6JZFYPOQbQQ+S4wnQ=;
        b=gN41ZajfiSmSqjx2xsn2O+L9INGcgCJIXl0IYLwnQdxCA2/lbWfn03xklkYOd7AHZWJlaw
        Cdo4KsNAORaps2Dw+LkCg0clsTVMQuAuJ68R0hgjgRjvHiUrEX8ZBFdnNpUYlHWPH6rHpz
        S2tyaibzC01tEzzU3YGu22R3quM6KVM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-E9W1pSuOMQCCRBcYEdHWng-1; Mon, 16 Dec 2019 11:11:04 -0500
X-MC-Unique: E9W1pSuOMQCCRBcYEdHWng-1
Received: by mail-lj1-f198.google.com with SMTP id y24so2290189ljc.19
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2019 08:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Knu3sFj/QXVI2qM2aimTaESR+T6JZFYPOQbQQ+S4wnQ=;
        b=tMK1+ZHXmZ6ieFWPcDJuu7stH1cicdqO06GzcjqxpJ6juhQ81Scz9a7xoY4L46/h4r
         bUE/XwwTNbigfvECJBWaUi0v5gVJ0XQ7e8/fOQ+ln5vGumdcS7FvYnC1AluY5WOVi6xF
         YUzDchzHAwZiiRxBxyMQBJnudRef9TK0c8jv76l7OtG/82eOD07fwCYuIVztKXWwd3AC
         JER9QbPQcGA6WsV9v10dd14eUgDFYpn/XlrosCq59zLvtVQCBcUu6v4kk/Kg58zflvxT
         mpS1Zt/6QxN5aqFHkFrRAm4qDpknjk9q7zzlaDhQJZJAA49xJ1CvLtuGpFR7WGiB97dH
         wyJw==
X-Gm-Message-State: APjAAAWldieCGDFlNgc+MbAQwarL61aWRJySuA9K2FXqws00PLMlcWkj
        ArJewgL+6B2j7X2zKMXJSDbb192iTZwsJxPR4s38bajPgrbwoTVitCHObAIBz/BHwfu1YEjl32O
        3xJbRPN2OvMeZ
X-Received: by 2002:a05:651c:1032:: with SMTP id w18mr20295362ljm.61.1576512663010;
        Mon, 16 Dec 2019 08:11:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqz7r+jiTSvA++c/OOf2wcqR9KwcHN7ZNi3ljuGB59+fw0NALhqBCG+KtU5nouN6QB8W+jp2qQ==
X-Received: by 2002:a05:651c:1032:: with SMTP id w18mr20295349ljm.61.1576512662813;
        Mon, 16 Dec 2019 08:11:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y7sm9330755lfe.7.2019.12.16.08.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 08:11:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 75B03180960; Mon, 16 Dec 2019 17:11:01 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, guro@fb.com, hannes@cmpxchg.org, tj@kernel.org
Subject: Re: [PATCH bpf-next] libbpf: Print hint about ulimit when getting permission denied error
In-Reply-To: <20191216160002.vytwcpremx2e7ae3@ast-mbp.dhcp.thefacebook.com>
References: <20191216124031.371482-1-toke@redhat.com> <20191216145230.103c1f46@carbon> <20191216155336.GA28925@linux.fritz.box> <20191216160002.vytwcpremx2e7ae3@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 16 Dec 2019 17:11:01 +0100
Message-ID: <87v9qg8d4a.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Dec 16, 2019 at 04:53:36PM +0100, Daniel Borkmann wrote:
>> On Mon, Dec 16, 2019 at 02:52:30PM +0100, Jesper Dangaard Brouer wrote:
>> > On Mon, 16 Dec 2019 13:40:31 +0100
>> > Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:
>> >=20
>> > > Probably the single most common error newcomers to XDP are stumped b=
y is
>> > > the 'permission denied' error they get when trying to load their pro=
gram
>> > > and 'ulimit -r' is set too low. For examples, see [0], [1].
>> > >=20
>> > > Since the error code is UAPI, we can't change that. Instead, this pa=
tch
>> > > adds a few heuristics in libbpf and outputs an additional hint if th=
ey are
>> > > met: If an EPERM is returned on map create or program load, and gete=
uid()
>> > > shows we are root, and the current RLIMIT_MEMLOCK is not infinity, we
>> > > output a hint about raising 'ulimit -r' as an additional log line.
>> > >=20
>> > > [0] https://marc.info/?l=3Dxdp-newbies&m=3D157043612505624&w=3D2
>> > > [1] https://github.com/xdp-project/xdp-tutorial/issues/86
>> > >=20
>> > > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >=20
>> > Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
>> >=20
>> > This is the top #1 issue users hit again-and-again, too bad we cannot
>> > change the return code as it is UAPI now.  Thanks for taking care of
>> > this mitigation.
>>=20
>> It's an annoying error that comes up very often, agree, and tooling then
>> sets it to a high value / inf anyway as next step if it has the rights
>> to do so. Probably time to revisit the idea that if the user has the same
>> rights as being able to set setrlimit() anyway, we should just not accou=
nt
>> for it ... incomplete hack:
>
> We cannot drop it quite yet.
> There are services that run under root that are relying on this rlimit
> to prevent other root services from consuming too much memory.

How do they do that? Set a pre-defined limit and rely on the other
services not calling setrlimit()? There's no way to read the current
value of how much memory is locked either (is there?), so for multiple
daemons there's a central policy thing that does
SUM(requirement_per_daemon)?

> We need memcg based alternative first before we can remove this limit.
> Otherwise users have no way to restrict.

Yeah, something cg-based would make a lot of sense here (and also
presumably make it possible to read out the current value, right?).

-Toke

