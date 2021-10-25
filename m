Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AAB439B22
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 18:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhJYQFv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 12:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230511AbhJYQFv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 12:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635177808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SzZKBwOsVE4UO/yr3UZsr7hPmN/ISAyTPojfUgsRot0=;
        b=H5mlONSoXvMzmJxk0vM9CpINKW6aL5uePoObGU+TPSdezEItTBfpQZrefLQ9SUQPLlsSOK
        JHNjq7pigHnvjNYrIQqniC77sM3Zoowdu4oiRf68DHUh3CSY/yJUW4/RyCCKb3VWvjdCwB
        2J4ezqJW1M0aGAzUKXPpem3l/ETyN6k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-hv_5IZAEO2yji8VrAmnAXw-1; Mon, 25 Oct 2021 12:03:26 -0400
X-MC-Unique: hv_5IZAEO2yji8VrAmnAXw-1
Received: by mail-ed1-f70.google.com with SMTP id m16-20020a056402431000b003dd2005af01so8708677edc.5
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 09:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SzZKBwOsVE4UO/yr3UZsr7hPmN/ISAyTPojfUgsRot0=;
        b=y7Hgg6VJx2wf0euDd7W5hXXnRP+lVZpcCOtEMLtiRObhS7ORlTYhkF5LKCFMC76sN0
         FtGjONrm8+Rj5Ns7Jlfmq3dz1YMykcfNL6qDDa0dQTNlc0BEWdENCw0IdWJEmOD2BSjO
         i6GVWYeQyULNdJmda9idwg9g1hBSUfeAfoksELC/dfcTtOkSyGXa5iOwMPZ1LKZgJAjs
         DLR1h46jiGuIAJko4QPJItU6Z3yrlUa+MfXqaMdA8ZiYx09OyoBIe3tftP+tF0STQVGm
         9O3iWj5nYzwDTfh3BUl5Ealgdw75XwtHI70l+Fw0pXivHKTWi94nRpkAK3Wb1uUIOdXJ
         TPCg==
X-Gm-Message-State: AOAM531fYN4EF8RxbPQsKiwHeJr7aA/oqQj+QQCq5JpN466WawV71mEH
        ZUbKGJCU1FDGUGw/xi0+KA8ZMHixhUn2nZIz+B+kkVO2NJfi+mlug1vrW/Me4n/di69sTse49l7
        9qN0epT9tCc2d
X-Received: by 2002:a17:906:4e57:: with SMTP id g23mr16629607ejw.448.1635177805113;
        Mon, 25 Oct 2021 09:03:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8cUU70PkM538DkLDFWDPq5g3C/6csXSqxmm69uiH427YqCUzOA1QoZ/RnuSTIYoaw+U+GqA==
X-Received: by 2002:a17:906:4e57:: with SMTP id g23mr16629569ejw.448.1635177804705;
        Mon, 25 Oct 2021 09:03:24 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ne2sm2363040ejc.44.2021.10.25.09.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 09:03:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 785B2180262; Mon, 25 Oct 2021 18:03:23 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: libxsk move from libbpf to libxdp
In-Reply-To: <CAJ8uoz35Xqx1YCnxB0wCd-58_u9fdzEy5xS45Jcs82gXiAnK1Q@mail.gmail.com>
References: <CAEf4BzZ5Uajg5548=vpq8O2L5VLrONmr8h2O-6X6H0urMDXEqA@mail.gmail.com>
 <CAJ8uoz35Xqx1YCnxB0wCd-58_u9fdzEy5xS45Jcs82gXiAnK1Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 25 Oct 2021 18:03:23 +0200
Message-ID: <87v91lay7o.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Magnus Karlsson <magnus.karlsson@gmail.com> writes:

> On Fri, Oct 22, 2021 at 7:49 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> Hey guys,
>>
>> It's been a while since we chatted about libxsk move. I believe last
>> time we were already almost ready to recommend libxdp for this, but
>> I'd like to double-check. Can one of you please own [0], validate that
>> whatever APIs are provided by libxdp are equivalent to what libbpf
>> provides, and start marking xdk.h APIs as deprecated? Thanks!
>
> Resending since Gmail had jumped out of plain text mode again.
>
> No problem, I will own this. I will verify the APIs are the same then
> submit a patch marking the ones in libbpf's xsk.h as deprecated.
>
> One question is what to do with the samples and the selftests for xsk.
> They currently rely on libbpf's xsk support. Two options that I see:
>
> 1: Require libxdp on the system. Do not try to compile the xsk samples
> and selftests if libxdp is not available so the rest of the bpf
> samples and selftests are not impacted.
> 2: Provide a standalone mock-up file of xsk.c and xsk.h that samples
> and selftests could use.
>
> I prefer #1 as it is better for the long-term. #2 means I would have
> to maintain that mock-up file as libxdp features are added. Sounds
> like double the amount of work to me. Thoughts?

I agree #1 is preferable of those two. Another option is to move the
samples to the xdp-tools repo instead? Doesn't work for selftests, of
course; if it's acceptable to conditionally-compile the XSK tests
depending on system library availability that would be fine by me...

I pinged the Debian maintainer of libbpf to see if I can get him to pick
up libxdp as well, or sponsor me to maintain it. Should make the
transition smoother; guess I also need to get hold of the OpenSuse
people.

-Toke

