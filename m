Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D7E2D35BC
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 23:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgLHWCA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 17:02:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726758AbgLHWCA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 8 Dec 2020 17:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607464833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dVwrtMjFPSWA+stVu1eMikGIn2Zj2pVaabSntdZDQrA=;
        b=IgwNzwawYglWHiHM1529XBVgFagwPZu8iML/jDZdTm0BpVfkjbbtGp5fk1itnXT7vHS6op
        +dHWfY0XGlW+HawBAxQpsxN70a3YpjpKH+/wEYqgkSeEUbCdrZ2woq0EaRv6J/bvfn2ZlL
        KbcEtqN0lfMAm2V12UooPmytg2uKmA0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-3k7fSkqjO9K16euEkQRRnA-1; Tue, 08 Dec 2020 17:00:32 -0500
X-MC-Unique: 3k7fSkqjO9K16euEkQRRnA-1
Received: by mail-wr1-f70.google.com with SMTP id o12so1892003wrq.13
        for <bpf@vger.kernel.org>; Tue, 08 Dec 2020 14:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dVwrtMjFPSWA+stVu1eMikGIn2Zj2pVaabSntdZDQrA=;
        b=lhDyrDHFgpL/G1XmJbGJd6sQhU4Ay8tQp7YwFPjcQfwCXza9H/7OyiQKKrA3Zt9Owr
         GEaviYl+3CVbh1FBAi0CR9aLJw1h6EiVxJLX/KVXRgg8K3IjwUv5kyRv+JVOXP4vJ+hV
         hb/Wabpz+Tw227mXXNPj77TeME58C37Uic27VxzKdkANKo/lze4bhylaua5LWTz1kEET
         y0SNNgVVWa/DLMtDJg2NVZfypGLtD8myuwCX8g8TNsDffKhT+DYQgwYgHIESbPPbmkNe
         3ifpKEhEz0luPtNehzGpokqIPZms1jlerE+9uUHJ1KRrKEMvYf+x+FnN9VFT/WSZUXFJ
         z90Q==
X-Gm-Message-State: AOAM532vlizHBRNCXxKQKswKOOkYJ2N+sANTzW6KumnXQYwqlix+rhrI
        v12aOmSxujj0I7HLYqtRcCd77zp1XnmVUyzhPPTqafYje4uviS0TZ2HaLl7GAY/v7qFaWHh3noD
        A49ijHek6aynu
X-Received: by 2002:adf:e4ca:: with SMTP id v10mr151721wrm.260.1607464828379;
        Tue, 08 Dec 2020 14:00:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSwb4gu0VPC90w4U16G8hnN/hXWQFO+jMf3AOb+Pqpbep24Nod9ZchBqlSFxLbqmT4jM5D/g==
X-Received: by 2002:adf:e4ca:: with SMTP id v10mr151688wrm.260.1607464828144;
        Tue, 08 Dec 2020 14:00:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 35sm315438wro.71.2020.12.08.14.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:00:27 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 22007180002; Tue,  8 Dec 2020 23:00:27 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Simon Horman <simon.horman@netronome.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Jiri Benc <jbenc@redhat.com>, oss-drivers@netronome.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 0/7] selftests/bpf: Restore test_offload.py to
 working order
In-Reply-To: <20201208090315.5106c049@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
References: <160708272217.192754.14019805999368221369.stgit@toke.dk>
 <87360gidoo.fsf@toke.dk>
 <20201208090315.5106c049@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 08 Dec 2020 23:00:27 +0100
Message-ID: <87r1o0ot50.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 08 Dec 2020 15:18:31 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>=20
>> > This series restores the test_offload.py selftest to working order. It=
 seems a
>> > number of subtle behavioural changes have crept into various subsystem=
s which
>> > broke test_offload.py in a number of ways. Most of these are fairly be=
nign
>> > changes where small adjustments to the test script seems to be the bes=
t fix, but
>> > one is an actual kernel bug that I've observed in the wild caused by a=
 bad
>> > interaction between xdp_attachment_flags_ok() and the rework of XDP pr=
ogram
>> > handling in the core netdev code.
>> >
>> > Patch 1 fixes the bug by removing xdp_attachment_flags_ok(), and the r=
eminder of
>> > the patches are adjustments to test_offload.py, including a new featur=
e for
>> > netdevsim to force a BPF verification fail. Please see the individual =
patches
>> > for details.
>> >
>> > Changelog:
>> >
>> > v2:
>> > - Replace xdp_attachment_flags_ok() with a check in dev_xdp_attach()
>> > - Better packing of struct nsim_dev=20=20
>>=20
>> Any feedback on v2? Would be great to get it merged before the final
>> 5.10 release :)
>
> LGTM but if my opinion mattered this could would not have been changed
> in the first place :)

Heh, right. Well I, for one, value your input, so thanks for taking a
look :)

-Toke

