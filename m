Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7247A21BD3F
	for <lists+bpf@lfdr.de>; Fri, 10 Jul 2020 20:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgGJS5c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jul 2020 14:57:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52815 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728248AbgGJS5b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jul 2020 14:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594407449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3vr4p3HOtOZH3FqPih/GiIpdmOKnnPMCPNV6jgpCAc=;
        b=CCkEY7gbdI/8oCPGGZnp9v+BSAKjP6Vhs2aUVX/V7x0RrlGWHHHe49n8MGKPCRnQwYf/6r
        bcK0cZHNlyflPrG3NBAI676yUswh/bQkQaB/hNQz52dJ6sPy4EjVJxzFmsuGnah7ONoZ+J
        2eBWj1FTtS8ToQj+AvaFIR2fHBnd7iU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-M1eg4V3cMgugByK5OImeJQ-1; Fri, 10 Jul 2020 14:57:25 -0400
X-MC-Unique: M1eg4V3cMgugByK5OImeJQ-1
Received: by mail-pl1-f197.google.com with SMTP id p14so4013874plq.19
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 11:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=g3vr4p3HOtOZH3FqPih/GiIpdmOKnnPMCPNV6jgpCAc=;
        b=qIO9dSs2HY82KItjJ26mqF+E0HpUn8YepRTDV5lugXAyFECWVBR9bp194/A/nLmxla
         Qlttp1jvoy53yFGmUMOt4XxO9s3jstOah8Am46z19J/eM8a18JhrefsPFaKAO7yYORHG
         bh/EvlUnXtyOS5pg2BHHcOgz55Q2W1w2pJwwS9Yzsw8aDEdDu/qnO+iRPY4bgnHGjL7n
         eI8eBfxHGeaqJUn3JKGfLMi8TR5V8hsz6v4gc2fP9JR3K1lSU9xtEJmlYw9EZ6bCQobC
         CrvEnkMgDoouuZ17yzXd1IFSHM8g+vCt6b25jA5iq2Aj1qdappOWfaEXC8ZnWFlo6v5I
         zsBg==
X-Gm-Message-State: AOAM532SeEU9a/ta+fKBUK/rcyAxzkKG8Vfhs6M5JgJxk/OIO+X9nR40
        3GXji9aQQtPsBNVn6+RUc0QRDXITVOaUFdY+z/IqegGWHbH72iF/4irjfR1A4Uf0lZWNSQzj27Z
        zJA5Cul3cBU9o
X-Received: by 2002:a17:902:9f96:: with SMTP id g22mr15845520plq.306.1594407444709;
        Fri, 10 Jul 2020 11:57:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/tVx6cQ9PiRSX4L09kZ6HuM+5mJq1HjYk1MsqxC65kL5z0rrT8cvGQ00NqVS3PFpZ66gdNg==
X-Received: by 2002:a17:902:9f96:: with SMTP id g22mr15845508plq.306.1594407444386;
        Fri, 10 Jul 2020 11:57:24 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y7sm6084764pgk.93.2020.07.10.11.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 11:57:23 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BA49D1808CD; Fri, 10 Jul 2020 20:57:17 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joe Perches <joe@perches.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
        john.fastabend@gmail.com, mchehab+huawei@kernel.org,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: XDP: restrict N: and K:
In-Reply-To: <a91354960fc97437bd872fa22a2ce1c60bda3e25.camel@perches.com>
References: <20200709194257.26904-1-grandmaster@al2klimov.de> <d7689340-55fc-5f3f-60ee-b9c952839cab@iogearbox.net> <19a4a48b-3b83-47b9-ac48-e0a95a50fc5e@al2klimov.de> <7d4427cc-a57c-ca99-1119-1674d509ba9d@iogearbox.net> <a2f48c734bdc6b865a41ad684e921ac04b221821.camel@perches.com> <875zavjqnj.fsf@toke.dk> <458f6e74-b547-299a-4255-4c1e20cdba1b@al2klimov.de> <a91354960fc97437bd872fa22a2ce1c60bda3e25.camel@perches.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 10 Jul 2020 20:57:17 +0200
Message-ID: <87tuyfi4fm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> On Fri, 2020-07-10 at 20:18 +0200, Alexander A. Klimov wrote:
>>=20
>> Am 10.07.20 um 18:12 schrieb Toke H=C3=B8iland-J=C3=B8rgensen:
>> > Joe Perches <joe@perches.com> writes:
>> >=20
>> > > On Fri, 2020-07-10 at 17:14 +0200, Daniel Borkmann wrote:
>> > > > On 7/10/20 8:17 AM, Alexander A. Klimov wrote:
>> > > > > Am 09.07.20 um 22:37 schrieb Daniel Borkmann:
>> > > > > > On 7/9/20 9:42 PM, Alexander A. Klimov wrote:
>> > > > > > > Rationale:
>> > > > > > > Documentation/arm/ixp4xx.rst contains "xdp" as part of "ixdp=
465"
>> > > > > > > which has nothing to do with XDP.
>> > > []
>> > > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
>> > > []
>> > > > > > > @@ -18708,8 +18708,8 @@ F:    include/trace/events/xdp.h
>> > > > > > >    F:    kernel/bpf/cpumap.c
>> > > > > > >    F:    kernel/bpf/devmap.c
>> > > > > > >    F:    net/core/xdp.c
>> > > > > > > -N:    xdp
>> > > > > > > -K:    xdp
>> > > > > > > +N:    (?:\b|_)xdp(?:\b|_)
>> > > > > > > +K:    (?:\b|_)xdp(?:\b|_)
>> > > > > >=20
>> > > > > > Please also include \W to generally match on non-alphanumeric =
char given you
>> > > > > > explicitly want to avoid [a-z0-9] around the term xdp.
>> > > > > Aren't \W, ^ and $ already covered by \b?
>> > > >=20
>> > > > Ah, true; it says '\b really means (?:(?<=3D\w)(?!\w)|(?<!\w)(?=3D=
\w))', so all good.
>> > > > In case this goes via net or net-next tree:
>> > >=20
>> > > This N: pattern does not match files like:
>> > >=20
>> > > 	samples/bpf/xdp1_kern.c
>> > >=20
>> > > and does match files like:
>> > >=20
>> > > 	drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
>> > >=20
>> > > Should it?
>> >=20
>> > I think the idea is that it should match both?
>> In *your* opinion: Which of these shall it (not) match?
>
> Dunno, but it doesn't match these files.
> The first 5 are good, the rest probably should.

Yup, I agree, all but the first 5 should be matched...

-Toke

> $ git ls-files | grep xdp | grep -v -P '(?:\b|_)xdp(?:\b|_)'
> Documentation/hwmon/xdpe12284.rst
> arch/arm/mach-ixp4xx/ixdp425-pci.c
> arch/arm/mach-ixp4xx/ixdp425-setup.c
> arch/arm/mach-ixp4xx/ixdpg425-pci.c
> drivers/hwmon/pmbus/xdpe12284.c
> samples/bpf/xdp1_kern.c
> samples/bpf/xdp1_user.c
> samples/bpf/xdp2_kern.c
> samples/bpf/xdp2skb_meta.sh
> samples/bpf/xdp2skb_meta_kern.c
> samples/bpf/xdpsock.h
> samples/bpf/xdpsock_kern.c
> samples/bpf/xdpsock_user.c
> tools/testing/selftests/bpf/progs/xdping_kern.c
> tools/testing/selftests/bpf/test_xdping.sh
> tools/testing/selftests/bpf/xdping.c
> tools/testing/selftests/bpf/xdping.h

