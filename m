Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204CB3A6760
	for <lists+bpf@lfdr.de>; Mon, 14 Jun 2021 15:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhFNNFs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Jun 2021 09:05:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232894AbhFNNFr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 14 Jun 2021 09:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623675824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C+NdEmHtv+U5FdoShfhVB+Z6EqvzPfegd34Orltzayw=;
        b=hq7aaiyzTqXZXRr/Y4IHQltVyPZXCkmAXX5V3x+IwsNLd2xeTn39rlm01Kjn6+oUB6qlbu
        B45tPyjX9Ar44Fsm6FTmE+6VVw1hdXoK+sKFneZcAbhw55XvmpeuHEo45EuxQU1/7qnnav
        OVyBRL/2dA9hbqP4tvW9JmRC2bvl3cA=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-JgqdxIiGNDybooETr5u8pQ-1; Mon, 14 Jun 2021 09:03:43 -0400
X-MC-Unique: JgqdxIiGNDybooETr5u8pQ-1
Received: by mail-il1-f198.google.com with SMTP id i14-20020a92c94e0000b02901ed9f897efdso7215534ilq.21
        for <bpf@vger.kernel.org>; Mon, 14 Jun 2021 06:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:mime-version:in-reply-to:date
         :message-id:subject:to:cc;
        bh=C+NdEmHtv+U5FdoShfhVB+Z6EqvzPfegd34Orltzayw=;
        b=CkX7UopqFr5mSCx5ZQZcaXDl4OsB3j6fmL+GjvQWh9sd1XT6nzzCm1NVwm9hPyfXbF
         hORRiJOrlBlKOzHGcK2uPPFy2dpuJQaPA380RiFON8cZXTmrim4v2QL0sbbZl1IUNVWz
         dRm+tWQ0qOp3/s2RFsJ0LvOaGx+BgZ9xxyRMLXL86+FiHRUdpMWPMsh4I3U4vaNIBrDb
         qq16UF7ExNVeo1Sm2WZFgbuvNrfdQIPzY5a39qOgbKgSindfcl6hm/xKaGjjqCl8L/X5
         9lpoFWyabBSPxFrtVCRPmA3vCklHFIHjq/EG5tpJHQ/FRL1L6yuumZ1hxkRE7shctVuH
         myJQ==
X-Gm-Message-State: AOAM533GPCeGtpxoJEfDEb8wh03TSNFQrDWIMQOwu4fy7Lqc8N6rn45Y
        8G+R3FzgOG3oKzGD5jXaSttMyPEFr1BXxQJ4xcUG5nrUwOHjp7TFm3WDV6dbGNca/TXXw0Kt731
        2OI+blflBcwegZ885U0oQnG1oBwbP
X-Received: by 2002:a5d:8190:: with SMTP id u16mr14604139ion.158.1623675821985;
        Mon, 14 Jun 2021 06:03:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrU4LJttwq1ITunciECemINCXpj/qSXAPjpZKx/67YXAmXbHKgB7ohKD7/t/BfeOOkJkDvUnHY/EQIRxefV5k=
X-Received: by 2002:a5d:8190:: with SMTP id u16mr14604120ion.158.1623675821724;
 Mon, 14 Jun 2021 06:03:41 -0700 (PDT)
Received: from 868169051519 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 14 Jun 2021 06:03:41 -0700
From:   Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20210607033724.wn6qn4v42dlm4j4o@apollo> <CAM_iQpVCnG8pSci2sMbJ1B5YE-y=reAUp82itgrguecyNBCUVQ@mail.gmail.com>
 <20210607060724.4nidap5eywb23l3d@apollo> <CAM_iQpWA=SXNR3Ya8_L2aoVJGP_uaRP8EYCpDrnq3y8Uf6qu=g@mail.gmail.com>
 <20210608071908.sos275adj3gunewo@apollo> <CAM_iQpXFmsWhMA-RO2j5Ph5Ak8yJgUVBppGj2_5NS3BuyjkvzQ@mail.gmail.com>
 <20210613025308.75uia7rnt4ue2k7q@apollo> <30ab29b9-c8b0-3b0f-af5f-78421b27b49c@mojatatu.com>
 <20210613203438.d376porvf5zycatn@apollo> <4b1046ef-ba16-f8d8-c02e-d69648ab510b@mojatatu.com>
MIME-Version: 1.0
In-Reply-To: <4b1046ef-ba16-f8d8-c02e-d69648ab510b@mojatatu.com>
Date:   Mon, 14 Jun 2021 06:03:41 -0700
Message-ID: <CALnP8ZZGu_H1_gvJNKXnn3HTnPzwoEkUbWfpS4YufYbUrP=H-w@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/7] Add bpf_link based TC-BPF API
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Vlad Buslov <vladbu@nvidia.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Joe Stringer <joe@cilium.io>,
        Quentin Monnet <quentin@isovalent.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jun 13, 2021 at 05:10:14PM -0400, Jamal Hadi Salim wrote:
> On 2021-06-13 4:34 p.m., Kumar Kartikeya Dwivedi wrote:
> > On Mon, Jun 14, 2021 at 01:57:16AM IST, Jamal Hadi Salim wrote:
> > > We do have this monthly tc meetup every second monday of the month.
> > > Unfortunately it is short notice since the next one is monday 12pm
> > > eastern time. Maybe you can show up and a high bandwidth discussion
> > > (aka voice) would help?
> > >
> >
> > That would be best, please let me know how to join tomorrow. There are a few
> > other things I was working on that I also want to discuss with this.
> >
>
> That would be great - thanks for your understanding.
> +Cc Marcelo (who is the keeper of the meetup)
> in case the link may change..

We have 2 URLs for today. The official one [1] and a test one [2].
We will be testing a new video conferencing system today and depending
on how it goes, we will be on one or another. I'll try to be always
present in the official one [1] to point people towards the testing
one [2] in case we're there.

Also, we have an agenda doc [3]. I can't openly share it to the public
but if you send a request for access, I'll grant it.

1.https://meet.kernel.social/tc-meetup
2.https://www.airmeet.com/e/2494c770-cc8c-11eb-830b-e787c099d9c3
3.https://docs.google.com/document/d/1uUm_o7lR9jCAH0bqZ1dyscXZbIF4GN3mh1FwwIuePcM/edit#

  Marcelo

