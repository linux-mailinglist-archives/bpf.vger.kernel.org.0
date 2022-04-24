Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA9E50CEBB
	for <lists+bpf@lfdr.de>; Sun, 24 Apr 2022 04:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiDXDAS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Apr 2022 23:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237859AbiDXDAR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Apr 2022 23:00:17 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE3013FB67
        for <bpf@vger.kernel.org>; Sat, 23 Apr 2022 19:57:16 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id h1so11692532pfv.12
        for <bpf@vger.kernel.org>; Sat, 23 Apr 2022 19:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+Xyuj6OWpgjVllOe8yTX9VVPlaIRmbHUGU8i6+X1P0s=;
        b=SbD415j2d4YhazQ2W3SFT6ven/L24vKS0BumSXOb5nDLafnl1uy6/1pikT+iC8PgoW
         HMiWDKcx8ekh8VIxa7frqoiHR8TqOFwjWOOgHwn20KtPLTGsg7Powi4+LpzmySV2mbUF
         KLfjpIP8xCXr+tooRlTXrg7pKldO3NYtRejxhxkh7Z6Nt1keX/6J4DSgBUW05MC6bmxS
         seN5QDPaQs0Pv8uMOUr0OUegV/ur/AmyA2W++jeR3Ypf+LGGT6qWToA5P8BlP6OPVP4Y
         dtC6zg1clCc2yWtFRcUy4AYlz77J9Lb8gSdqMOLq0+lN4SWs2iu3eDPPVst6FEzt3AoZ
         JTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+Xyuj6OWpgjVllOe8yTX9VVPlaIRmbHUGU8i6+X1P0s=;
        b=M7vkxP3uXEZAAucHB9hBMEBIxW33oW7C/toxe0Yz7a0KSXRBKbZEgtTmstYseO3lv3
         uGW5UjMNDtZU1KxHUMjkWsKhPiiXK+P3PelrFBuQMABwgVqyNRuRhuAZuSyfbbmQvZGN
         81/5gs37MlGhrRRODLAnP+kecfk9NAijFoP2XYES5LuC5sz4nT5SoVm8G7HBUtVEhGCM
         uy9SQsLBzQSvRhMYi3QPfUl//HUTSS783WQD/Yt2LG67q9BW5JMUE8J3JFDkVjnG6bTk
         IS+2f6x1+vbyyAvS7+nfkZ6scLRvzdaaPzjQDgJyjD11QxbffEtSaMimp0oI42Np/Yfa
         2SKw==
X-Gm-Message-State: AOAM533omD1TjfvRx0YSVNhxud9iIKeGRmaST3oP0M+ibrxNkeSInLQx
        K1qh883f7P1OxhUmr7JQ4T5/ZPaNnyr3H+2DXHbaijKf
X-Google-Smtp-Source: ABdhPJwc16zGux0Bmit78wFFiQhQrqZ5tlyKmnD67KMnxzEdA6Dsw50KUWPpSMbIQyxfoHjB5ytl2dRGuLdt/yZusy4=
X-Received: by 2002:a63:5163:0:b0:3a9:4e90:6d3d with SMTP id
 r35-20020a635163000000b003a94e906d3dmr9970639pgl.48.1650769035401; Sat, 23
 Apr 2022 19:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220422120259.10185-1-fankaixi.li@bytedance.com>
 <20220422120259.10185-3-fankaixi.li@bytedance.com> <CAADnVQL9=XivjNeg3CyE67N3cp6xB+cetUhWG6b+DtXo-6x0VA@mail.gmail.com>
 <CAEEdnKFjUQeZGYFF+gAtqEeyCzdz=5A91w-PFgAjsS-nkZ6BXw@mail.gmail.com>
In-Reply-To: <CAEEdnKFjUQeZGYFF+gAtqEeyCzdz=5A91w-PFgAjsS-nkZ6BXw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 23 Apr 2022 19:57:04 -0700
Message-ID: <CAADnVQL2j-sLdDr+ZRHakKo8SVrKofCq3ffQJ8Fpqvr0gEXHPg@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v5 2/3] selftests/bpf: Move vxlan
 tunnel testcases to test_progs
To:     Kaixi Fan <fankaixi.li@bytedance.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 22, 2022 at 7:51 PM Kaixi Fan <fankaixi.li@bytedance.com> wrote=
:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2022=E5=B9=B44=
=E6=9C=8823=E6=97=A5=E5=91=A8=E5=85=AD 08:37=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, Apr 22, 2022 at 5:04 AM <fankaixi.li@bytedance.com> wrote:
> > > +#define VXLAN_TUNL_DEV0 "vxlan00"
> > > +#define VXLAN_TUNL_DEV1 "vxlan11"
> > > +#define IP6VXLAN_TUNL_DEV0 "ip6vxlan00"
> > > +#define IP6VXLAN_TUNL_DEV1 "ip6vxlan11"
> > > +
> > > +#define SRC_INGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/test_tunnel_ingres=
s_src"
> > > +#define SRC_EGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/test_tunnel_egress_=
src"
> > > +#define DST_EGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/test_tunnel_egress_=
dst"
> > > +
> > > +#define PING_ARGS "-c 3 -w 10 -q"
>
> Thanks for the suggestion.
>
> >
> > Thanks for moving the test to test_progs,
> > but its runtime is excessive.
> >
> > time ./test_progs -t tunnel
> > #195 tunnel:OK
> > Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> >
> > real    0m26.530s
> > user    0m0.075s
> > sys    0m1.317s
> >
> > Please find a way to test the functionality in a second or so.
>
> Hi Alexei,
> Do you mean the sys time should be in a second ?

real time.
sys time is already there.
The big delta between real and sys time highlights
inefficiency of the test. The test sleeps most of the time.
