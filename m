Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACFE467E4E
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 20:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382901AbhLCTjo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 14:39:44 -0500
Received: from linux.microsoft.com ([13.77.154.182]:41006 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382892AbhLCTjn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 14:39:43 -0500
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by linux.microsoft.com (Postfix) with ESMTPSA id 80A8F20E6949;
        Fri,  3 Dec 2021 11:36:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80A8F20E6949
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1638560179;
        bh=2pP/9JRM0rTXtUOmeafagrBwv5eObSGCNt9Low4V4S8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fQyTIkjxELV/1BP16Ywq28694ArGI0QqUZqTIkJf+ae5rRjBSjzpXH3GksuOFJS4g
         1o6QsbdYp4CENDqf7IkikOESldtwnjsZD/41e8400KU+eBhu97qa1EOk5BaCwD5nJE
         8XdCCUDon0iuwPIJi3RzvHBHb7vPaAl/zqMW/2yI=
Received: by mail-pj1-f43.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so5788104pjj.0;
        Fri, 03 Dec 2021 11:36:19 -0800 (PST)
X-Gm-Message-State: AOAM532x6XHmPrB8O8hXYoMl0zZyxPOGXZ6OgfUM/YA6vi9P6wmpZTWd
        mFKtGU4yuQO+a8E/Z8Q9Wcja3l/7qxWb9qexVV0=
X-Google-Smtp-Source: ABdhPJwFkchJAjDh/V18uY72WRYvTyX5uVYgPnYQ2Ivkbt91qfVGm5rsPPieGI0BPE2QhzniVSMuJmFSVrfF4O69m2Y=
X-Received: by 2002:a17:90a:fe0b:: with SMTP id ck11mr16131985pjb.15.1638560178885;
 Fri, 03 Dec 2021 11:36:18 -0800 (PST)
MIME-Version: 1.0
References: <20211203191844.69709-1-mcroce@linux.microsoft.com> <CAADnVQLDEPxOvGn8CxwcG7phy26BKuOqpSQ5j7yZhZeEVoCC4w@mail.gmail.com>
In-Reply-To: <CAADnVQLDEPxOvGn8CxwcG7phy26BKuOqpSQ5j7yZhZeEVoCC4w@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Fri, 3 Dec 2021 20:35:42 +0100
X-Gmail-Original-Message-ID: <CAFnufp1_p8XCUf-RdHpByKnR9MfXQoDWw6Pvm_dtuH4nD6dZnQ@mail.gmail.com>
Message-ID: <CAFnufp1_p8XCUf-RdHpByKnR9MfXQoDWw6Pvm_dtuH4nD6dZnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] bpf: add signature
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Luca Boccassi <bluca@debian.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 3, 2021 at 8:22 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Dec 3, 2021 at 11:18 AM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> >
> > From: Matteo Croce <mcroce@microsoft.com>
> >
> > This series add signature verification for BPF files.
> > The first patch implements the signature validation in the kernel,
> > the second patch optionally makes the signature mandatory,
> > the third adds signature generation to bpftool.
>
> Matteo,
>
> I think I already mentioned that it's no-go as-is.
> We've agreed to go with John's suggestion.

Hi,

my previous attempt was loading a whole ELF file and parsing it in kernel.
In this series I just validate the instructions against a signature,
as with kernel CO-RE libbpf doesn't need to mangle it.

Which suggestion? I think I missed this one..

-- 
per aspera ad upstream
