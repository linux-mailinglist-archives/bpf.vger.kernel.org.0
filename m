Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E585C526AA9
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 21:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiEMTnL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 15:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiEMTnK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 15:43:10 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE20A1BA;
        Fri, 13 May 2022 12:43:09 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id z126so7880369qkb.2;
        Fri, 13 May 2022 12:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kBGZe23og3tuPkyPlZIYCKerjwwMq/7LVdJGiLj5N80=;
        b=Ly2SkEjsVdSoQYd3sFewyPe6Iyi2XDe1w5f7QAs2D25JvktaDIwyyVof/XTgLGA8oX
         UhAHMY/kIvlUmoPMTmZrDojbnqEsNaL9fXwJm3osv64ZaxJllE1cnW78kNaAuNfblR5+
         T1vYUF+rmGIgl0xXlSq0MvAlZPeB3jD13fI/3oReqIFGyTXl/wVeiB0+wYKcsVSboi7M
         JDhqTPMpnPv3gDGY/i6i9Hvah8ORTw56cj5aGnh/hv2LYwC1LdKJfsCAGrdjrifIHc/X
         mYJqMzZHn9sL2Xe7Q/6Rp13gICSuct9fiDLMtb0qja3+19z21e2TSJx+Z9c7jYSQG3HD
         HH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kBGZe23og3tuPkyPlZIYCKerjwwMq/7LVdJGiLj5N80=;
        b=Rtbb8LLThN4/1f1xQ6SPayTgH68bLBjgamTDZSJcwm0KSzI2bhNITcpaJSylSL9OPM
         8qjrWk6fHkImKwFV4AHg7MkMHoL5m/T6EGDv5MtG0KahDYabFTH3DnRfcplOmgake4sD
         A5Jdx1pIv1xuG2lwsaaabzYhzGNpolZi/J0Gs7jv2uZZlDH63uPJcdUFBKHwIh1gkUbP
         4Ykl0HxUugGuvQ46ihMWq60I9Kqc/++Yw70K6/ASFFw5d4rmY4Sn1qTBrEcWHlkGo4EO
         ppl71Ya+/cZNvkkS0h8BHCw8PtvAklLFXdaJtsgNKvroWqTnGHv/Hp6l4ZSYqM50Bpsr
         JS7A==
X-Gm-Message-State: AOAM530OfRzNnJ/im+turF5bGpccF8AL+Pr7UHmaG+lHQUDlL5+mAK/M
        NoIMGNwakZCI5YjjoxBuPrg5uJjaHL06KVYYc/4=
X-Google-Smtp-Source: ABdhPJzLmcawuvWJrk6aMHK8sUSKopx2Zm89XRfnbv2dWG2Fv/EnsoB6rPxtVBbw66OzKURVpiGU9i/+Ethd0+lj7Ro=
X-Received: by 2002:a05:620a:28c7:b0:6a0:5de3:e6 with SMTP id
 l7-20020a05620a28c700b006a05de300e6mr5036681qkp.464.1652470988079; Fri, 13
 May 2022 12:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
 <20220426040314.ez3cdpv2w45vbgkk@MBP-98dd607d3435.dhcp.thefacebook.com>
 <CAO-hwJLziatB9n5Rut_EYRgfN94t2XX8Zx8B_Zmu2nucTw3k8g@mail.gmail.com>
 <CAADnVQKN==eb3ASQhrJBg4yC8BuRdMQyY-OdRbXhdyv2P8L0-A@mail.gmail.com>
 <CAO-hwJ+HV=jZUgH1LXcPuBFirMzx3OAdSy4zvyyYh7PQhnaduQ@mail.gmail.com>
 <20220512042327.vla3j7rjqrmjporp@MBP-98dd607d3435.dhcp.thefacebook.com> <CAO-hwJLXM6Zf46_PweJ=QTiacX0+siUYkyqPu1hRrx_8fDVUTQ@mail.gmail.com>
In-Reply-To: <CAO-hwJLXM6Zf46_PweJ=QTiacX0+siUYkyqPu1hRrx_8fDVUTQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 13 May 2022 12:42:57 -0700
Message-ID: <CAADnVQ+BLhpM-VZZ27XJGqqnm2uVTHzDqwtwp-w8U=m7zRqF+w@mail.gmail.com>
Subject: Re: [RFC bpf-next v4 0/7] Introduce eBPF support for HID devices (new attempt)
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 13, 2022 at 10:02 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Thu, May 12, 2022 at 6:23 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Apr 30, 2022 at 09:12:09AM +0200, Benjamin Tissoires wrote:
> > >
> > > Also, I wonder if we should not have some way to namespace kfuncs.
> > > Ideally, I would like to prevent the usage of those kfuncs outside of
> > > some helpers that I define in HID so I don't have to worry too much
> > > about other trace programs fuzzing and segfaulting the kernel.
> >
> > That would be a great feature to have. Other folks expressed the same interest.
> > Just grouping them by prog type is not flexible enough.
> > It feels kfuncs could be scoped by (prog_type, attach_btf_id or attach_hook) pair.
> > What are your thoughts?
> >
>
> Scoping by attach_btf_id is very appealing to me (attach_hook less TBH):
> I have internal functions I do not want normal users to use, and also
> it would also restrict who can call what in the more general case.
>
> However, I don't think I'll put that effort in v5. It is a nice to
> have feature IMO, but not really required ATM.

Great. Looking forward to it.
