Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0AC4EA4E3
	for <lists+bpf@lfdr.de>; Tue, 29 Mar 2022 04:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiC2CEC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 22:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiC2CEB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 22:04:01 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3835FF00
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 19:02:18 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id u13so2422875ilv.6
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 19:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xbh19nl3BqltuV8pNuWarkletzRmBP1mYiQYNmYq2F4=;
        b=o+QcYN/3nuE/c3F04jJ/aK2FKH9aKvvPWe9b1rdcNNFQo01zr5jdN2w79ZcXemMRF3
         MaAFfUgqRruIrxmnLySBRbhJIOJ7SLIAJTWa6dC83yU7Qdye43IWOQHCsYhtHke9euh2
         4MTgkbkgxe7LA4aFvPCi+IN4mlJsRdoArMj6z9+ZmtZWLUi/NAzHqhqRYuwSF2OZD1lw
         wUIVh3C2h2VlgJBd/NYQ/o7JU0JHa8LMPcf4WH/7adDCO2i7l9zhn64jPCtu/2ihpCu/
         fKgT8CtOAhHy6xGoJvOyL1ioZzrRpHNTCNedyWAlD5pwiHwysXQV8gZVTxfWJ64+vEaM
         RQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xbh19nl3BqltuV8pNuWarkletzRmBP1mYiQYNmYq2F4=;
        b=Dzsf+cn3sjeb0bMvK7lr4niiLrw50GmoaNceDLlYpdLKgepSK7W/kJoyYZ9r+WSnv3
         xg/sVx7usiGBsogg2H7/18O9td8nqQvck1Tkc2nRSAzaKZ51+c9sa5tEkFJRUqxfyH1O
         Tv14UoEqUwzj4scaIr7H9OVIz0yRLZFWm+HlUiUUPciU/nVzOfmQuDmxpUsgu8TYW2E4
         k9V5IgvneNncKWF/qthepUxXF7YI5sL0LGk+dMNBmGKfP34Jv6lFPbikKBMEYOtmWhlo
         OsmgS7cXYl0ZHgqirqtMrsskt9CrzzhreoSmzCLb1bY199Cn//kJXi4SitcA5h3XmuqV
         kuiw==
X-Gm-Message-State: AOAM531DbZS2MrKufyXR1pTYdwQM8BUkZ7zsYJPY5EV3OxcGeFjFTRbF
        d61XvO21jG0OTEcavveZZYubcM1wzm9s6pAK0rP+zg==
X-Google-Smtp-Source: ABdhPJy9VpSe3XZjh8CG94DrvdQDGniToxxCNFqBhP+7c80YPUWNuhZR2ICLxlE2xd++WQ9Nb58w4NF5QF4zDo7IgiQ=
X-Received: by 2002:a05:6e02:19cd:b0:2c7:c621:3da with SMTP id
 r13-20020a056e0219cd00b002c7c62103damr7329652ill.130.1648519337814; Mon, 28
 Mar 2022 19:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220322154231.55044-1-fankaixi.li@bytedance.com>
 <20220322154231.55044-3-fankaixi.li@bytedance.com> <1e206112-c610-d4e5-1ab6-e78ea3e2dcea@fb.com>
 <CAEEdnKEF=EfiXsQX7HgPbj2Fz2Un2km1nb=SgK8uNNYxsP05cw@mail.gmail.com> <8b498619-a08e-0c4c-c1d3-93dc9cdbc1f2@fb.com>
In-Reply-To: <8b498619-a08e-0c4c-c1d3-93dc9cdbc1f2@fb.com>
From:   =?UTF-8?B?6IyD5byA5Zac?= <fankaixi.li@bytedance.com>
Date:   Tue, 29 Mar 2022 10:02:06 +0800
Message-ID: <CAEEdnKFM1yCqK+ZBnXX=M1EF+K6uaLP1k4gzWfi4Mv+UzezgvA@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 2/3] selftests/bpf: add ipv4 vxlan
 tunnel source testcase
To:     Yonghong Song <yhs@fb.com>
Cc:     kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, bpf@vger.kernel.org, shuah@kernel.org,
        ast@kernel.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> =E4=BA=8E2022=E5=B9=B43=E6=9C=8829=E6=97=A5=E5=
=91=A8=E4=BA=8C 07:10=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 3/26/22 10:04 AM, =E8=8C=83=E5=BC=80=E5=96=9C wrote:
> > Yonghong Song <yhs@fb.com> =E4=BA=8E2022=E5=B9=B43=E6=9C=8826=E6=97=A5=
=E5=91=A8=E5=85=AD 00:41=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >>
> >>
> >> On 3/22/22 8:42 AM, fankaixi.li@bytedance.com wrote:
> >>> From: "kaixi.fan" <fankaixi.li@bytedance.com>
> >>>
> >>> Vxlan tunnel is chosen to test bpf code could configure tunnel
> >>> source ipv4 address.
> >>
> >> The added test configures tunnel source ipv4 address.
> >>
> >>   >It's sufficient to prove that other types
> >>> tunnels could also do it.
> >>
> >> Could you be more specific what other types will also use source ipv4
> >> address. It is too vague to claim "it's sufficient to prove ...".
> >>
> >
> > Is it better to add more test cases for other types of ip tunnels ? It =
would
> > introduce more duplicate codes.
> >
> > In the kernel, this is referred to as collect metadata mode as follows:
> > https://man7.org/linux/man-pages/man8/ip-link.8.html
> > Kernel use "struct ip_tunnel_info" to save tunnel parameters, and use
> > it for tunnel encapsulation. The process is similar for vxlan, gre,/gre=
tap,
> > geneve, ipip and erspan tunnels.
> > The previous test cases in "test_tunnel.sh" test this mechanism for bpf
> > program code already.  Based on this mechanism, I just use vxlan tunnel
> > to test tunnel source ip configuration.
>
> You can just mention something like:
>    Other type of tunnels, e.g., gre, gretap, geneve, ipip, erspan, etc,
> can also configure tunnel source ip addresses.
>

Thanks. It's more clear as you say !

> >
> >>
> >>> In the vxlan tunnel testcase, two underlay ipv4 addresses
> >>> are configured on veth device in root namespace. Test bpf kernel
> >>> code would configure the secondary ipv4 address as the tunnel
> >>> source ip.
> >>>
> >>> Signed-off-by: kaixi.fan <fankaixi.li@bytedance.com>
> >>
> >> Again, please use proper name in Signed-off-by tag.
> >
> > Thanks. I will fix it.
> >
> [...]
