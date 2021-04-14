Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F8135F608
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 16:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345706AbhDNORE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 10:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23206 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345592AbhDNORD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Apr 2021 10:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618409801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6EnIkHF0mrKFySBJ0Tb9/DPDchSiulKvYv90SvgrrsQ=;
        b=dIzxGZluuVswTuViYAlwrTrNamX0gYUPmT24Ds3cuC+v2RDMz5CyL+dYUUnJb7hD28f/d7
        yhwlz46c3GlSZ26yHosZXkBs0HdWPM/siuJkRDg0ASZnaKqR+LbJ4sMqVyZsYZlASonTrH
        zXJnlk8yjtFEHZ6ksfnH6xWpbLkgR2g=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-ZzRIwhctP_aTZBYS-HqyNw-1; Wed, 14 Apr 2021 10:16:40 -0400
X-MC-Unique: ZzRIwhctP_aTZBYS-HqyNw-1
Received: by mail-ed1-f71.google.com with SMTP id co5-20020a0564020c05b02903825bcdad12so3416394edb.0
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 07:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6EnIkHF0mrKFySBJ0Tb9/DPDchSiulKvYv90SvgrrsQ=;
        b=GdIFDXmaqMMPsGq/090PhAtfl1kOB1kkKne7jsJoghSM/k2oOxZldEAWLFW/ZC8bnm
         ZlikWM8Sgq4+3Uj5VHu1hvQNi7pcMxIqZHV5JqPRBZpADW2k/W4Hyswpxob35bd5/UF6
         b3o1Wo5CRi14TDlD58/xEm6so4faWBpcIdQLtM7+3oV+oSIP7bpuOC1LrrsTgTY8Qz58
         tqFCglEJUqHC/wlIYqblP277b8Ndu8CWHEzlMpUuAZ1s8CPEpbDdYmXSoc6ibREVRJh/
         JrK/ov4QHFlpUOocOQ7tmZFx9uspxI3auZKwcTNF14GrWGu9rfAxooW+Fu2rzQhOnIli
         /vkg==
X-Gm-Message-State: AOAM532Kqb2CeVgqzUX4mzUxLn7g/Pa99lLSApLEePlC87sklgc1kinD
        fyAD/mTBZCc6AHHxnMINOgx7tHCrZk4sFIy88pnxCDIWdKj9PPkf9u4LRLwObZ5SdccYR6B4I/3
        2A6S3Dxrn42ec
X-Received: by 2002:a05:6402:5113:: with SMTP id m19mr42187991edd.78.1618409798481;
        Wed, 14 Apr 2021 07:16:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyljjol7myZaSjPi3ZrpP7abhsmGrhOla/DTSa/iTifsYFqNZAKw5gISQdqEU3wdj72s4jQlg==
X-Received: by 2002:a05:6402:5113:: with SMTP id m19mr42187966edd.78.1618409798368;
        Wed, 14 Apr 2021 07:16:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id w5sm2705366ejc.84.2021.04.14.07.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 07:16:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B8AA91804E8; Wed, 14 Apr 2021 16:16:36 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Hangbin Liu <liuhangbin@gmail.com>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        =?utf-8?B?QmrDtnJuIFQ=?= =?utf-8?B?w7ZwZWw=?= 
        <bjorn.topel@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCHv7 bpf-next 0/4] xdp: extend xdp_redirect_map with
 broadcast support
In-Reply-To: <20210414122610.4037085-1-liuhangbin@gmail.com>
References: <20210414122610.4037085-1-liuhangbin@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 14 Apr 2021 16:16:36 +0200
Message-ID: <87r1jdkl2z.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hangbin Liu <liuhangbin@gmail.com> writes:

> Hi,
>
> This patchset is a new implementation for XDP multicast support based
> on my previous 2 maps implementation[1]. The reason is that Daniel think
> the exclude map implementation is missing proper bond support in XDP
> context. And there is a plan to add native XDP bonding support. Adding a
> exclude map in the helper also increase the complex of verifier and has
> draw back of performace.
>
> The new implementation just add two new flags BPF_F_BROADCAST and
> BPF_F_EXCLUDE_INGRESS to extend xdp_redirect_map for broadcast support.
>
> With BPF_F_BROADCAST the packet will be broadcasted to all the interfaces
> in the map. with BPF_F_EXCLUDE_INGRESS the ingress interface will be
> excluded when do broadcasting.

Alright, I'm out of things to complain about - thanks for sticking with
it! :)

For the series:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

