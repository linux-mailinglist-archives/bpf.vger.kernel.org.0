Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EE236851D
	for <lists+bpf@lfdr.de>; Thu, 22 Apr 2021 18:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbhDVQn6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Apr 2021 12:43:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236058AbhDVQn6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 22 Apr 2021 12:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619109802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gXx9vxUfIiBoDVKcHfcptbsKUrDJ1MF/y059ShRd67s=;
        b=gwqaJKDg37OhMjNo359tFhAORlo9vOvD/wF66vVdUlsd+F4oqqbtFzAWcdYUodlr0k5iTD
        a4ewlo+XJgZuRmg6/iZ6BrG+XKjvzCJO++8ZCEC1JTN8VwSi/oTiSis9XEB6OW9n35ARLS
        WUdMuI0TSx5+HbVw5cV4bnn4G3bP8Cw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-1ISfiP3iN7GSQBgkzzHuYQ-1; Thu, 22 Apr 2021 12:43:17 -0400
X-MC-Unique: 1ISfiP3iN7GSQBgkzzHuYQ-1
Received: by mail-ed1-f71.google.com with SMTP id r4-20020a0564022344b0290382ce72b7f9so17070534eda.19
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 09:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gXx9vxUfIiBoDVKcHfcptbsKUrDJ1MF/y059ShRd67s=;
        b=qX6StZ0eX/XtoU2riweDWPmrzVrklfH01WsbnMaXsDxvgFjsMbaMl2ShQauVid5AV0
         yOljcsJ+QtvZkPRDO55eliMOrjZE07wN2fnWbjr3B6THNKeJsx8ATP7/8d9OSXPL3wvC
         ioyl6ne5OuL4BfndgQIOeiWU1ZEjK+c1kCso2wOAfKvIrBnLiNRGMb8s9l3MTsa0Pt0n
         ardzLECx1ePdaHRsiIrZ4nrscnb/tR6liGMlvpkmss+6O0Vw6shLA2Qsym2iJFnjWK7a
         epi4AyxFfsm6eTtxty/xRTFanz74OP70yAZGTBkP6gqMn0Z24UVWXdslWIytstLW1EYQ
         vesA==
X-Gm-Message-State: AOAM531CmUEttR1R6pyf+iDfJJE8K3OLSR8X3qt5jocxEKB2mPbr+pow
        YL5TL9liVCCqVfElXRfXExSmD8yzC2bz2jVLfwdpi+6td5d/0Uo17emnHeve6FE2ENq1yb821DO
        xmbGfdgmwOAFI
X-Received: by 2002:a05:6402:199:: with SMTP id r25mr5037338edv.128.1619109796467;
        Thu, 22 Apr 2021 09:43:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvqWih6472Ly4HxpjU/tNlR83vaNYz0C8OkDMRh8BAEiJAquXJqt4IyhTA3juWqagYdrmmXw==
X-Received: by 2002:a05:6402:199:: with SMTP id r25mr5037329edv.128.1619109796343;
        Thu, 22 Apr 2021 09:43:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s11sm2638526edt.27.2021.04.22.09.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 09:43:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 078CC180675; Thu, 22 Apr 2021 18:43:15 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kenny Ho <y2kenny@gmail.com>, bpf <bpf@vger.kernel.org>
Subject: Re: bpf helper functions from kernel module
In-Reply-To: <CAOWid-eY4CHZw01d9w3KC0qpodWmTXfQqLopkNFVNwZhmCYgMQ@mail.gmail.com>
References: <CAOWid-eY4CHZw01d9w3KC0qpodWmTXfQqLopkNFVNwZhmCYgMQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 22 Apr 2021 18:43:14 +0200
Message-ID: <87czumfexp.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kenny Ho <y2kenny@gmail.com> writes:

> Hi,
>
> From https://www.collabora.com/news-and-blog/blog/2019/04/15/an-ebpf-overview-part-2-machine-and-bytecode/
> "The BPF-accesible kernel "helper" functions are defined by the kernel
> core (not extensible through modules) via an API similar to defining
> syscalls"
>
> Has there been interest/discussion around having helper functions from
> kernel modules?  Going through the code, I am guessing one of the
> obstacles is to have the verifier checking against helper functions
> that may or may not be available but I am not an expert of the
> subsystem.  What are the current opinions on having helper functions
> from kernel modules?

The support for calling kernel functions directly (AKA "unstable
helpers") will likely be the way this will be achievable. See the
comment in brackets half-way down in the description here:

https://lore.kernel.org/bpf/20210325015142.1544736-1-kafai@fb.com/

-Toke

