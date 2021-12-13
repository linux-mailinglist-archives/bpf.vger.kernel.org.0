Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AEF4731CD
	for <lists+bpf@lfdr.de>; Mon, 13 Dec 2021 17:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240222AbhLMQ2c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 11:28:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52798 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236509AbhLMQ2b (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Dec 2021 11:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639412911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xFgMJS5OYLT6odUDPQrNQS9uxsTb4uqYrE9YvbeaGk0=;
        b=e5SijWY6Ly3axe9TvyKuXWr4IbjeQ0sdHdeyCSwkeCZofpFSEpvv/UL3wCq/sqq0tRrpgw
        usC9zppIGrD9faNWcHpOBV4Vpl4rx/wLiHmCSU71dH3UGgVVip5pq38Q/SK/tL8Ff45GHz
        P0DCPgltBTvYIBFtLnVe6mFtVUMjVpk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-PZmjuq_RMAawswGGGwkLOA-1; Mon, 13 Dec 2021 11:28:30 -0500
X-MC-Unique: PZmjuq_RMAawswGGGwkLOA-1
Received: by mail-ed1-f70.google.com with SMTP id eg20-20020a056402289400b003eb56fcf6easo14352618edb.20
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 08:28:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xFgMJS5OYLT6odUDPQrNQS9uxsTb4uqYrE9YvbeaGk0=;
        b=bdeOrMVtp8lwbx6OL3g/k1jAz+RhaGI5WnijWwZKsAwCg4Hv/VhKGKkwfTHPW7HcA1
         Zu/Ak+lxv5bJugL6JXH7kYkZNrn0gXjWuNXMAG4KLQtsOMw8Kj5Zyg0TqH8EP2skkSVa
         mjeq7JYszi32ZCBpED4Ngfisd8lV1m57cv1ut/RwYtxXS6oucrAOvjzuwdE96awb/0+6
         vHUGZgG+bi+yN6ThyufT4nxPIwCy85oWlgZxexuPneHYTbtkoJYkrplxdWT0Gh+OIY5H
         VAZlcOEoYqUewDmCANZAQp0S4LyF+Ei/rJfwNd+LXLQ1837xj5ePnDvWJw+VnJpTTNFB
         Tx9A==
X-Gm-Message-State: AOAM533fEPPIC3iFj7bOIQnIM2MYaqVa+9LD7fM9Ph5qG31oqm3Cpty0
        FOdawVclH1O0T0RgxB911tWVJV50fc0EeRfkp0YzXMw9aTluhy/8/C3DlHJpiG89sRakQ9OHDru
        JokLkPvz+e0bw
X-Received: by 2002:a17:906:11ce:: with SMTP id o14mr45416734eja.457.1639412908764;
        Mon, 13 Dec 2021 08:28:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+1Jri9oBR6QcOXdVO9FQbIa19fYz+o7TqfqBqmF1DCRiSzjfHSbvt13CDIvqX6QJnfcbNiQ==
X-Received: by 2002:a17:906:11ce:: with SMTP id o14mr45416690eja.457.1639412908387;
        Mon, 13 Dec 2021 08:28:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z8sm6706897edb.5.2021.12.13.08.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:28:27 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6330D18355A; Mon, 13 Dec 2021 17:28:27 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 8/8] samples/bpf: Add xdp_trafficgen sample
In-Reply-To: <CAADnVQKiPgDtEUwg7WQ2YVByBUTRYuCZn-Y17td+XHazFXchaA@mail.gmail.com>
References: <20211211184143.142003-1-toke@redhat.com>
 <20211211184143.142003-9-toke@redhat.com>
 <CAADnVQKiPgDtEUwg7WQ2YVByBUTRYuCZn-Y17td+XHazFXchaA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 13 Dec 2021 17:28:27 +0100
Message-ID: <87r1ageafo.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sat, Dec 11, 2021 at 10:43 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>>
>> This adds an XDP-based traffic generator sample which uses the DO_REDIRE=
CT
>> flag of bpf_prog_run(). It works by building the initial packet in
>> userspace and passing it to the kernel where an XDP program redirects the
>> packet to the target interface. The traffic generator supports two modes=
 of
>> operation: one that just sends copies of the same packet as fast as it c=
an
>> without touching the packet data at all, and one that rewrites the
>> destination port number of each packet, making the generated traffic spa=
n a
>> range of port numbers.
>>
>> The dynamic mode is included to demonstrate how the bpf_prog_run() facil=
ity
>> enables building a completely programmable packet generator using XDP.
>> Using the dynamic mode has about a 10% overhead compared to the static
>> mode, because the latter completely avoids touching the page data.
>>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  samples/bpf/.gitignore            |   1 +
>>  samples/bpf/Makefile              |   4 +
>>  samples/bpf/xdp_redirect.bpf.c    |  34 +++
>>  samples/bpf/xdp_trafficgen_user.c | 421 ++++++++++++++++++++++++++++++
>>  4 files changed, 460 insertions(+)
>>  create mode 100644 samples/bpf/xdp_trafficgen_user.c
>
> I think it deserves to be in tools/bpf/
> samples/bpf/ bit rots too often now.
> imo everything in there either needs to be converted to selftests/bpf
> or deleted.

I think there's value in having a separate set of utilities that are
more user-facing than the selftests. But I do agree that it's annoying
they bit rot. So how about we fix that instead? Andrii suggested just
integrating the build of samples/bpf into selftests[0], so I'll look
into that after the holidays. But in the meantime I don't think there's
any harm in adding this utility here?

-Toke

[0] https://lore.kernel.org/r/CAEf4BzYv3ONhy-JnQUtknzgBSK0gpm9GBJYtbAiJQe50=
_eX7Uw@mail.gmail.com

