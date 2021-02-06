Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDDD311BF7
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 08:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhBFH0z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 02:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBFH0y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 02:26:54 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1802AC06174A;
        Fri,  5 Feb 2021 23:26:14 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id s24so9645122iob.6;
        Fri, 05 Feb 2021 23:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=WAkpmSceCQpOL9g/nb4W8z+4GPryDFavQAvOKJCZ4ec=;
        b=NwAb6V1G+IFXjDY2j2EcxBPzs6HFWtDkMW2mZRrYx3hC+p/bXbeP+RdECFiLUGbbQV
         dgwxhv7stlWzl3ZCYfBvptTMbLJdjgklbAY22It9SJlR67PxOQ9xDrtwAMyNqks19o5m
         iGsY1xKaN2W3l+FKCqLZENSHycmGH/eUc3WxclUWvT/dJX3V9Uugc9XbVBAzXFTIOBCf
         rWtViqSegeTtKjDJmtyTW2pgOnEWA9mv25ISVhYBprRJUApAIwwZVQnVDjp6diWfM1AC
         tIaqESU482JRtGdqPQEjf24k3qcRGRKfoA91Ab3nUvWcqxIafO388gfvdHrdBLP8JeQi
         cDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=WAkpmSceCQpOL9g/nb4W8z+4GPryDFavQAvOKJCZ4ec=;
        b=W6o/DzpuTNys9wOpjWlnnEsMQu80QZyLbUNT3R12f8gslZFXDcUaRUAASvjCpFguZw
         RW7hsaeJzXVjGs2we8u6ZpRxO/dqAaBvgFtFwUQ1ohH4S/XunZICyFgi+PANnK4xETON
         P7h9B51iS9m0VUIzktJ6hGts2dXGaZaQEPayqU0oyhKnrvwV//yU0ynzbkfZJgGEN+J/
         fLpcU+BvAW6Rj5YNWY+aJZ/vlcoTYU0ATvYQsrgML6GkRQ6aHQBEh4qeVrx4/8yGdskS
         xxUEJbpdHuZkRkfD3j4fSF4TDikmn+mn0VGRScESTrKW1/Lu4CCK9v2iACVkucjX5QpS
         Nf/g==
X-Gm-Message-State: AOAM531nU2g8lnxR+g09b4pBUmc80C/12HOEnpFJOl4jaVF4KSaOQBA+
        ah4qB7V/sMUHm7wtikDBUhZj7lnEcHrqAbM8wP8=
X-Google-Smtp-Source: ABdhPJxBD9o8SaZXUd2IGQs70eRnxmjnsa9ro/WLT3SvzYjbuE5LfuJ45b6mWetkQkmLI043G1Ku8Oyjb9KMFs2gvJA=
X-Received: by 2002:a05:6638:251:: with SMTP id w17mr8479927jaq.138.1612596373526;
 Fri, 05 Feb 2021 23:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org> <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
 <CA+icZUU2xmZ=mhVYLRk7nZBRW0+v+YqBzq18ysnd7xN+S7JHyg@mail.gmail.com>
 <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com>
 <20210205152823.GD920417@kernel.org> <CA+icZUWzMdhuHDkcKMHAd39iMEijk65v2ADcz0=FdODr38sJ4w@mail.gmail.com>
 <CA+icZUXb1j-DrjvFEeeOGuR_pKmD_7_RusxpGQy+Pyhaoa==gA@mail.gmail.com>
 <CA+icZUVZA97V5C3kORqeSiaxRbfGbmzEaxgYf9RUMko4F76=7w@mail.gmail.com>
 <baa7c017-b2cf-b2cd-fbe8-2e021642f2e3@fb.com> <20210205192446.GH920417@kernel.org>
 <cb743ab8-9a66-a311-ed18-ecabf0947440@fb.com>
In-Reply-To: <cb743ab8-9a66-a311-ed18-ecabf0947440@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Feb 2021 08:26:02 +0100
Message-ID: <CA+icZUV98seJrpNcSPvN_Vjc4Znc72zH3czqirnie80BGAQfEQ@mail.gmail.com>
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 5, 2021 at 9:03 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/5/21 11:24 AM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Feb 05, 2021 at 11:10:08AM -0800, Yonghong Song escreveu:
> >> On 2/5/21 11:06 AM, Sedat Dilek wrote:
> >>> On Fri, Feb 5, 2021 at 7:53 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>> Grepping through linux.git/tools I guess some BTF tools/libs need to
> >>> know what BTF_INT_UNSIGNED is?
> >
> >> BTF_INT_UNSIGNED needs kernel support. Maybe to teach pahole to
> >> ignore this for now until kernel infrastructure is ready.
> >
> > Yeah, I thought about doing that.
> >
> >> Not sure whether this information will be useful or not
> >> for BTF. This needs to be discussed separately.
> >
> > Maybe search for the rationale for its introduction in DWARF.
>
> In LLVM, we have:
>    uint8_t BTFEncoding;
>    switch (Encoding) {
>    case dwarf::DW_ATE_boolean:
>      BTFEncoding = BTF::INT_BOOL;
>      break;
>    case dwarf::DW_ATE_signed:
>    case dwarf::DW_ATE_signed_char:
>      BTFEncoding = BTF::INT_SIGNED;
>      break;
>    case dwarf::DW_ATE_unsigned:
>    case dwarf::DW_ATE_unsigned_char:
>      BTFEncoding = 0;
>      break;
>
> I think DW_ATE_unsigned can be ignored in pahole since
> the default encoding = 0. A simple comment is enough.
>

For the followers (here: LLVM v12.0.0-rc1):

[ llvm/lib/Target/BPF/BTFDebug.cpp ]

BTFTypeInt::BTFTypeInt(uint32_t Encoding, uint32_t SizeInBits,
                       uint32_t OffsetInBits, StringRef TypeName)
    : Name(TypeName) {
  // Translate IR int encoding to BTF int encoding.
  uint8_t BTFEncoding;
  switch (Encoding) {
  case dwarf::DW_ATE_boolean:
    BTFEncoding = BTF::INT_BOOL;
    break;
  case dwarf::DW_ATE_signed:
  case dwarf::DW_ATE_signed_char:
    BTFEncoding = BTF::INT_SIGNED;
    break;
  case dwarf::DW_ATE_unsigned:
  case dwarf::DW_ATE_unsigned_char:
    BTFEncoding = 0;
    break;
  default:
    llvm_unreachable("Unknown BTFTypeInt Encoding");
  }

- Sedat -
