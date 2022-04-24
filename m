Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBF350CEFA
	for <lists+bpf@lfdr.de>; Sun, 24 Apr 2022 05:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbiDXDfY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Apr 2022 23:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbiDXDfR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Apr 2022 23:35:17 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CBB1A8C15
        for <bpf@vger.kernel.org>; Sat, 23 Apr 2022 20:32:18 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r12so12563158iod.6
        for <bpf@vger.kernel.org>; Sat, 23 Apr 2022 20:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K9ezTwdzKN4MAJ4zaXuUUNt01SvcWJhe1i+ZSfqzer8=;
        b=0pgzHcMv3SGctdJPx/ptBpOzSpjxG7CE0TVyEFXiEmClJ6N5i0tp0xEO38+C2fn8QE
         hmCc1kVajiqH6s64nHRiylf+Ugm2ZOugNA9uYZvuPSfeheHZBegPOWRn/TyMSdUa3L30
         cItCO/yixIQlTjq6IovtQXSGQYZJWgZsiLpRNbHy1z8zb//w8uDZUscX/DTZKQPJ+qyx
         fHThTesV15Q5+tRkAp6zNZWQcL2BE+9i23PqrC2T/BL0UqIM0gjDNxj+ksKZnHklIaXy
         +W21VWfeJ8NVjEXj/Al4k2PCpVlIH95fJOJaT0pQXSnkWr5vJC6zjBr0a2adFx0ZFoDc
         TJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K9ezTwdzKN4MAJ4zaXuUUNt01SvcWJhe1i+ZSfqzer8=;
        b=F5WesnzVO7Q1iTlLMb64A7WZvE9eGQieCT6ZCd1m4BKP/XHDZmePBsp6Y871cBoQf3
         AX+j/RyVzi3vuOhWJkVTM9WlQUwXzaxNJyTzKp4Zbv3ip+e1ILRexnAwOsTpw093WaOG
         JQtZnLD9Sc/lv5s8CUz3s/I7RgYgxBQ9jIBhdyOT3D6MjUcSU//8XxLBIX8InQUEaRRj
         B5zo8XzZ0QH7VW1VO94l6f6/9LC3XH37oJpPW5s++m7hmxw/vd2s/7fsZdpeRAh4wNBN
         Es5QNWj7xf8f1CFr/VEWauoWTLKGtnaHBr8OMq7ulJR1fKKVfKThoqZSju0MC9ToEb3j
         feJQ==
X-Gm-Message-State: AOAM533O7xmkDs/YrwnGrJO1rT/cx/8NtpML+Yw9KOogqLO9rj8BUuVn
        n7U9pEykMK0hOOVY/eHFk+d0wR2pgSeCUoATvqPqRg==
X-Google-Smtp-Source: ABdhPJz9siO+A7CobVPUkUFYGErOn4KdyShhNineyeJuTztCClLC30608yEn6sIpbTR/b2XeisXaTseJQmw7SYEIgM4=
X-Received: by 2002:a02:8604:0:b0:326:681e:eef1 with SMTP id
 e4-20020a028604000000b00326681eeef1mr4754118jai.275.1650771138370; Sat, 23
 Apr 2022 20:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220422120259.10185-1-fankaixi.li@bytedance.com>
 <20220422120259.10185-3-fankaixi.li@bytedance.com> <CAADnVQL9=XivjNeg3CyE67N3cp6xB+cetUhWG6b+DtXo-6x0VA@mail.gmail.com>
 <CAEEdnKFjUQeZGYFF+gAtqEeyCzdz=5A91w-PFgAjsS-nkZ6BXw@mail.gmail.com> <CAADnVQL2j-sLdDr+ZRHakKo8SVrKofCq3ffQJ8Fpqvr0gEXHPg@mail.gmail.com>
In-Reply-To: <CAADnVQL2j-sLdDr+ZRHakKo8SVrKofCq3ffQJ8Fpqvr0gEXHPg@mail.gmail.com>
From:   Kaixi Fan <fankaixi.li@bytedance.com>
Date:   Sun, 24 Apr 2022 11:32:07 +0800
Message-ID: <CAEEdnKG-HeAhWrATMTOYKa7_OdKXs4NjrVrQpcxFXSicgNY1mw@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v5 2/3] selftests/bpf: Move vxlan
 tunnel testcases to test_progs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2022=E5=B9=B44=
=E6=9C=8824=E6=97=A5=E5=91=A8=E6=97=A5 10:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Apr 22, 2022 at 7:51 PM Kaixi Fan <fankaixi.li@bytedance.com> wro=
te:
> >
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2022=E5=B9=
=B44=E6=9C=8823=E6=97=A5=E5=91=A8=E5=85=AD 08:37=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Fri, Apr 22, 2022 at 5:04 AM <fankaixi.li@bytedance.com> wrote:
> > > > +#define VXLAN_TUNL_DEV0 "vxlan00"
> > > > +#define VXLAN_TUNL_DEV1 "vxlan11"
> > > > +#define IP6VXLAN_TUNL_DEV0 "ip6vxlan00"
> > > > +#define IP6VXLAN_TUNL_DEV1 "ip6vxlan11"
> > > > +
> > > > +#define SRC_INGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/test_tunnel_ingr=
ess_src"
> > > > +#define SRC_EGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/test_tunnel_egres=
s_src"
> > > > +#define DST_EGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/test_tunnel_egres=
s_dst"
> > > > +
> > > > +#define PING_ARGS "-c 3 -w 10 -q"
> >
> > Thanks for the suggestion.
> >
> > >
> > > Thanks for moving the test to test_progs,
> > > but its runtime is excessive.
> > >
> > > time ./test_progs -t tunnel
> > > #195 tunnel:OK
> > > Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > real    0m26.530s
> > > user    0m0.075s
> > > sys    0m1.317s
> > >
> > > Please find a way to test the functionality in a second or so.
> >
> > Hi Alexei,
> > Do you mean the sys time should be in a second ?
>
> real time.
> sys time is already there.
> The big delta between real and sys time highlights
> inefficiency of the test. The test sleeps most of the time.

The tunnel test includes many types of tunnel testcases.  Add a new
tunnel testcase would increase test time.
So the real time could not be reduced into a second.
The test code calls many shell commands to setup test environments. It
may be the reason why there is a big
delta bettween real and sys time.

Reduce the ping packet interval would reduce the real and sys time
significantly.
real 0m7.088s
user 0m0.062s
sys 0m0.119s

Thanks.
