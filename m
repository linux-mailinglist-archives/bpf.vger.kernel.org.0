Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAECF3CFD73
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 17:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhGTOlf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Jul 2021 10:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232455AbhGTORU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 20 Jul 2021 10:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626793034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JYeEMxZkqQmanUk3SXevDIn341JznEMVqJ/f4SJD7Ok=;
        b=cSf5h4CsgPizW25XCKrFYMsXs22id2WrEaXyb1KytHXrYDTBFkle3J11Tvu5DVxiugl+54
        qBPtc9UDu2xB6xRBlAeh1yUQnqRDXQurZZOp+kWKKei9j+VjTA5EA9pcxSeo2+Tv1g2jID
        Fc/jTm9ols9+CxPKGMmvZSfyrw6NzFo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-lcbDkvwINEO3q9gFxIphWg-1; Tue, 20 Jul 2021 10:57:12 -0400
X-MC-Unique: lcbDkvwINEO3q9gFxIphWg-1
Received: by mail-ej1-f71.google.com with SMTP id p20-20020a1709064994b02903cd421d7803so6917171eju.22
        for <bpf@vger.kernel.org>; Tue, 20 Jul 2021 07:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JYeEMxZkqQmanUk3SXevDIn341JznEMVqJ/f4SJD7Ok=;
        b=KUPs/4BoXvuaVmsJq4qPvfZLbA4ahB7I+UUGtoIQM96L5ZzPpt0bate31hVUXwFYN9
         gO+1OTxX3yGa+Y7GTDJjY9RYa9UTLor79AqBAh5StKbCtvGWCOif7kVjDFc+QzSD71yB
         sO6emPWktTv/976AD7AdAiAZPaYznZSr2vUPX5XvG10g/0G2jHzW0od86Toqp9mwfx8Y
         m375CWG0kdcYi7EQXaBNVa+lYwdsw42Rvo6WATXoO8GGg9zHPmf396NG/mWbEIGsquH3
         oqo+89BRyrSyDftpJ94PNY+LIELPyhA8ALOhKONMTgTsn0yUiDlGfXVCLUpEubUtL//Q
         kAjA==
X-Gm-Message-State: AOAM533cMh88Zxp5ZqV8YOyxiW1lAV7XFUrG0seDWfwgxiR3d6R3Hsxc
        IY96sIZJwmvvH93ashj9QggGkw+TbPi+lshQ8UnbbvKpL/AMd/vBvIvoN8S5mKUuFFFhLlE+RQC
        0707shHE4NWPC
X-Received: by 2002:a17:907:264e:: with SMTP id ar14mr33337152ejc.134.1626793031601;
        Tue, 20 Jul 2021 07:57:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDRp0wSPGh04ZIsh3ykqs5PMxabHS1Vc0+4aUbwzWbk1J39PLB5QrktN8iIcYORB5fmseh/A==
X-Received: by 2002:a17:907:264e:: with SMTP id ar14mr33337129ejc.134.1626793031420;
        Tue, 20 Jul 2021 07:57:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id i6sm7832882edt.28.2021.07.20.07.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 07:57:10 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 58AD718060A; Tue, 20 Jul 2021 16:50:08 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     "luwei (O)" <luwei32@huawei.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        David Ahern <dahern@digitalocean.com>
Subject: Re: Ask for help about bpf map
In-Reply-To: <beb37418-4518-100a-5b1b-e036be6f71b6@huawei.com>
References: <5aebe6f4-ca0d-4f64-8ee6-b68c58675271@huawei.com>
 <CAEf4BzZpSo8Kqz8mgPdbWTTVLqJ1AgE429_KHTiXgEVpbT97Yw@mail.gmail.com>
 <8735sidtwe.fsf@toke.dk> <d1f47a24-6328-5121-3a1f-5a102444e50c@huawei.com>
 <26db412c-a8b7-6d37-844f-7909a0c5744b@huawei.com>
 <189e4437-bb2c-2573-be96-0d6776feb5dd@huawei.com>
 <CAADnVQJYhtpEcvvYfozxiPdUJqcZiJxbmT2KuOC6uQdC1VWZVw@mail.gmail.com>
 <6b659192-5133-981e-0c43-7ca1120edd9c@huawei.com> <87wnpmtr5j.fsf@toke.dk>
 <beb37418-4518-100a-5b1b-e036be6f71b6@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 20 Jul 2021 16:50:08 +0200
Message-ID: <87a6mh82fz.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"luwei (O)" <luwei32@huawei.com> writes:

> It's very strange, in my virtual host, it is:
>
> $ ip -V
>
> ip utility, iproute2-5.11.0
>
>
> but in my physical host:
>
> $ ip -V
> ip utility, iproute2-5.11.0, libbpf 0.5.0
>
>
> I compiled iproute2 in the same way as I mentioned previously, and the 
> kernel versions are both 5.13 (in fact the same code) .

When compiling, the configure script should tell you whether it can find
libbpf. If not, it's probably because you don't have the right header
files installed...

-Toke

