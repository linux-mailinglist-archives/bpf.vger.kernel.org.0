Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6483C85D1
	for <lists+bpf@lfdr.de>; Wed, 14 Jul 2021 16:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhGNOST (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 10:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22378 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231543AbhGNOSS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Jul 2021 10:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626272126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BBYm9n1JHXZyPXbWdNZg18WOdwYLu4hkfmz0//Wgw9g=;
        b=dWdVcAhNwlWwc+B3blBVlPGTZj0liIt29sIAFyA1XBRFfhEilO3DmLa159AkuHTYYZuMNQ
        YkZju8WJT7oxp/STHaQoymsUDVmyCfnqrOmg/SqbVSy1j53Q/gWkzk2hOjV2refmmzOr0b
        PVDvQZFFgYGPgqyO3AqqgzE3y7Aqn7s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-AsVXYOjfOvmT6iXsA8cJjQ-1; Wed, 14 Jul 2021 10:15:25 -0400
X-MC-Unique: AsVXYOjfOvmT6iXsA8cJjQ-1
Received: by mail-ej1-f72.google.com with SMTP id r10-20020a170906350ab02904f12f4a8c69so856062eja.12
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 07:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=BBYm9n1JHXZyPXbWdNZg18WOdwYLu4hkfmz0//Wgw9g=;
        b=bVYGgENtqErFmbv+RpQ8O5RpJmnaUxS1o+zvYPxmApRNt86eRQMld8lnKh6pBEKJjf
         oSeu9IGk6FLVbcbxUOICC3769+K7RNhle9ZN1uFQvA8U7BdcxPUoywIu5YUSossX74ey
         ne5NuPH7BQwLlk2iZitVaj8pw1gR/x4+bV+NUoUF8b2OQ2RXGJ8IPZnigYp/AS9I+zjk
         jVoki0UhyvTYezZfgdI+aF3flCak8mNd5qPUbz61g5RnbnpQ8DSyuSUHWdJikjVrTJyr
         SP+hC0M9IJ8tn+nnaw1wGVSyjKZCNraYPoTXOZukxBBbsX47z0YUhWvBkJsuGEUWtoP1
         iQbw==
X-Gm-Message-State: AOAM530oMV5BNKT3tS4+fj8A9abSgJ2QdYDJvVoQyE+8bVigBb+3Vlrm
        sr71gnIsAzwQZ9+OoYMhNOtTZHOfZG36oP11ppG/+cKDTSOuYcOcG5ZLdBqzpgCKnXpeS2Zn8W+
        3iDT4FkMTML6c
X-Received: by 2002:a17:907:1c8d:: with SMTP id nb13mr12794769ejc.155.1626272122496;
        Wed, 14 Jul 2021 07:15:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx44GSIqjM8mInhWCz3gqHqXMTEt/1u7//N2lpZQtN7OzLESX29Qn0OFaYivmxKjfe/CSD5iw==
X-Received: by 2002:a17:907:1c8d:: with SMTP id nb13mr12794643ejc.155.1626272121106;
        Wed, 14 Jul 2021 07:15:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id j1sm1091866edl.80.2021.07.14.07.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 07:15:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B9D6E180709; Wed, 14 Jul 2021 16:15:19 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     "luwei (O)" <luwei32@huawei.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        David Ahern <dahern@digitalocean.com>
Subject: Re: Ask for help about bpf map
In-Reply-To: <189e4437-bb2c-2573-be96-0d6776feb5dd@huawei.com>
References: <5aebe6f4-ca0d-4f64-8ee6-b68c58675271@huawei.com>
 <CAEf4BzZpSo8Kqz8mgPdbWTTVLqJ1AgE429_KHTiXgEVpbT97Yw@mail.gmail.com>
 <8735sidtwe.fsf@toke.dk> <d1f47a24-6328-5121-3a1f-5a102444e50c@huawei.com>
 <26db412c-a8b7-6d37-844f-7909a0c5744b@huawei.com>
 <189e4437-bb2c-2573-be96-0d6776feb5dd@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 14 Jul 2021 16:15:19 +0200
Message-ID: <87k0ltf0co.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"luwei (O)" <luwei32@huawei.com> writes:

> Hi Andrii and toke,
>
>  =C2=A0=C2=A0=C2=A0 I have sovled this issue. The reason is that my iprou=
te2 does not=20
> support libbpf, once I compile iproute2 with libbpf, it works. Thanks=20
> for reply!

Awesome! You're welcome :)

-Toke

