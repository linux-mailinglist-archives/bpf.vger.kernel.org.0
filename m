Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB7A576643
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 19:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiGORoT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 13:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGORoS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 13:44:18 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D466403
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 10:44:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eq6so7208445edb.6
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 10:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oTP3+2w+7FcTFU4j4FJ+Y9AtMVnezscsRoiTCfUlUzA=;
        b=Rn+KzwSJR2pxAWqaFTDrZ9FqNoz7C4Cy9czbM9R+qdz7KV/gFIoYeTtFxCX/5gDLm/
         X1K8tJ1Hru3MiwMvnSLa3H2N9CFv5BorhSEGPZ8tQFmgZInTq3KwCa0pD7oK086nGK6D
         nTdA7eYKforUinRQNtbYLdZk/UjpJ+53NHwaBdusjYEv2s7ZsKOzKJ6JZ2M3p76KmqeY
         ZN2CY3PB/krqvEjxv35LgmTYCjVlxWvguN90RSl50l4RUz7lrT6k6iDpRrGZ3WkLIt9F
         cZpCCC7htuTcGNlKD9wjYgkGedQv0GrJEROvpYebz/ahplh91WD+bOVmF6ID1bNnFKGq
         rTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oTP3+2w+7FcTFU4j4FJ+Y9AtMVnezscsRoiTCfUlUzA=;
        b=acqv5dbWCcE27FJp81Kpm0aJZdHN9+GlE5nijZgmUlpugQDwj1tGPHYGOX2YLNtldn
         V1BQoyCalXmxSoESuG7BqvA0aOUgLvVwgAwrn87B7WXyQ/i0rxmd2jRGqTPkEqvzFu39
         0MoOwC8N/mJbZ/LZqxSTwjFe48hbjOaOIjRo6NIi+FIwCQC/YKzFfo/Hp6iEJBiYCjMF
         yOxfId7RPxT0qzsSxy1NbRsmZu2HDt/sSLD0o4b/URKHYMprhbMBFfA86aNOYsHVdmXL
         y5xRwWbL9U+ZBILs+XAQahZrzJDQWRRem/EroH9suKVoP1F25K525auJu9Pm42aYlpkj
         GKzw==
X-Gm-Message-State: AJIora80+sVssUT0ecUSKNK82VqpBRsBEiDCFRgrjYNbHmikPWfe94AK
        +J6bmX1g3x9pygPxNgof/fheVIARI1oMf3OnoSo=
X-Google-Smtp-Source: AGRyM1uRFCcHXLKKsKVPK7hiDqcns40tuIoYjiQAKUgrZtNdN+gnqtuBJiPA2vd0oPDzG4mUqJBDfLNX5+ao0sFr+DE=
X-Received: by 2002:a05:6402:5d6:b0:43b:2391:a07e with SMTP id
 n22-20020a05640205d600b0043b2391a07emr12285798edx.366.1657907055637; Fri, 15
 Jul 2022 10:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220714224721.2615592-1-joannelkoong@gmail.com>
 <43bbdc5a-000d-0aed-f325-2b942aa1fc02@iogearbox.net> <e167c21e-c448-634c-992f-141bbcdf637d@isovalent.com>
In-Reply-To: <e167c21e-c448-634c-992f-141bbcdf637d@isovalent.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 15 Jul 2022 10:44:04 -0700
Message-ID: <CAJnrk1bV7wXoandqg-QJmyPhOjL+kz-j2Oj1AF6q2Zi+MukTrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: fix bpf_skb_pull_data documentation
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
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

On Fri, Jul 15, 2022 at 6:50 AM Quentin Monnet <quentin@isovalent.com> wrot=
e:
>
> On 15/07/2022 14:43, Daniel Borkmann wrote:
> > On 7/15/22 12:47 AM, Joanne Koong wrote:
> >> Fix documentation for bpf_skb_pull_data() helper for
> >> when flags =3D=3D 0.
> >>
> >> Fixes: fa15601ab31e ("bpf: add documentation for eBPF helpers (33-41)"=
)
> >> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >> ---
> >>   include/uapi/linux/bpf.h       | 3 ++-
> >>   tools/include/uapi/linux/bpf.h | 3 ++-
> >>   2 files changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index 379e68fb866f..a80c1f6bbe25 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -2361,7 +2361,8 @@ union bpf_attr {
> >>    *         Pull in non-linear data in case the *skb* is non-linear
> >> and not
> >>    *         all of *len* are part of the linear section. Make *len*
> >> bytes
> >>    *         from *skb* readable and writable. If a zero value is
> >> passed for
> >> - *         *len*, then the whole length of the *skb* is pulled.
> >> + *        *len*, then all bytes in the head of the skb will be made
> >> readable
> >
> > Quentin, should the formatting be '*skb*' instead of 'skb'?
>
> Correct
>
> > Maybe it's more clear if we speak of 'all bytes in the linear part'
> > instead of 'all
> > bytes in the head' of the skb to make it clearer? Either is ok with me
> > though.
>
> Good suggestion, =E2=80=9Clinear part=E2=80=9D is maybe easier to underst=
and given that
> the paragraph has no other mention the =E2=80=9Chead=E2=80=9D.
>
Great, I'll send out v2 with these edits:
* changing skb -> *skb*
* changing "all bytes in the head" -> "all bytes in the linear part"

> Would it be worth, even, linking to e.g. Dave's doc
> (http://vger.kernel.org/~davem/skb.html) here, to provide more details?
> People reading the header file may not need that, but folks reading the
> generated man page may not be aware of what a skb contains.

In my personal opinion, I think people who are writing programs that
are using skbs will already have read that page and/or know the
internals of skbs. But I'm also happy to add that link in if you think
it'd provide more context.

>
> Quentin
>
