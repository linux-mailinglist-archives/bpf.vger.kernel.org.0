Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193EE42BDC4
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 12:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhJMKuk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Oct 2021 06:50:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51390 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229461AbhJMKuk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 Oct 2021 06:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634122117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eR9lMonPqIMsdFUaXBINmSPY/cuXmx2jqkTpmycATS0=;
        b=ZG/M5yGYVCPe8s/MJIfyJRX5jtw+KDBsnr3603sqNWnrPQ3LNy9lJ32gTJBtwgLeEMRxuX
        5Ee5battHBCaky4ymQOPNBByk3sj6JyiUGrmjtNdy3GKIJ5YX2+Jd5kslaXsyGQ7GtGBzC
        UzmSzU09b5vLNDeFfIw5tmgTb6T1BpU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-3i-TUMV5PkeVVu7yhql7JA-1; Wed, 13 Oct 2021 06:48:36 -0400
X-MC-Unique: 3i-TUMV5PkeVVu7yhql7JA-1
Received: by mail-ed1-f69.google.com with SMTP id u23-20020a50a417000000b003db23c7e5e2so1864210edb.8
        for <bpf@vger.kernel.org>; Wed, 13 Oct 2021 03:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=eR9lMonPqIMsdFUaXBINmSPY/cuXmx2jqkTpmycATS0=;
        b=eT50zlsIlPHXZfi+wDnmp5+xkBAHHgA/KujciCC3n56xOvasaYwtI2fswg6a+rH2hB
         /ORityF2begL/4ift94C0FaWcOEHWeJjPtt+eCaMp8zOIyrQSJ2tm3jAnTP7Hwr2iSNr
         2p5Iyv+cE8N2ALJKIZmhTvg4KkUS040uKKRQVyi452jkD1J6uPy6YtVFsW1HEAzArdiP
         lMna8CB5V5OUoO0WcBdzsQZ/l1NhBNHFcOY9mLNDH7HmRBuGmJqXH0xe6A8vZU9W0Hgy
         fp540W4JjXM3Kj1dV5LNkNGuEKQ5PUts0c+ruk2qFFqI1FKZMBpjqsl3srlNwAph++Ft
         aXeg==
X-Gm-Message-State: AOAM531P8c9e0vJAtWpHC1k5k/28Id7Y2VQ6kJQ7H6eBpddHC7+kXXtc
        k1TtwWw68/hZX1gn1BW/5bfmjk392FrsVE301nepHWBWdQCDmJfxWAcgn7HionJnylkUmae3j5K
        +t8HnmEszNASp
X-Received: by 2002:a17:906:a94b:: with SMTP id hh11mr40708853ejb.85.1634122113394;
        Wed, 13 Oct 2021 03:48:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6HONzjPJwksgmD3H5+mt3DoppXUZACT/a7ux222b/alQi6dQ75cCO8dE9C62MtbMbd1QFXA==
X-Received: by 2002:a17:906:a94b:: with SMTP id hh11mr40708704ejb.85.1634122111853;
        Wed, 13 Oct 2021 03:48:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id bm1sm6487880ejb.38.2021.10.13.03.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:48:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B8009180151; Wed, 13 Oct 2021 12:48:30 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Pony Sew <poony20115@gmail.com>, bpf@vger.kernel.org
Subject: Re: Is it possible to install libbpf on kernel 3.19.8?
In-Reply-To: <CAK-59YHAX2unv=0tq7yZz_J7wkkObMRPPt2jbVs9nBus76CmHQ@mail.gmail.com>
References: <CAK-59YHAX2unv=0tq7yZz_J7wkkObMRPPt2jbVs9nBus76CmHQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 13 Oct 2021 12:48:30 +0200
Message-ID: <87sfx5fbep.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pony Sew <poony20115@gmail.com> writes:

> Hello.
> I compiled kernel 3.19.8 on Debian 8 (amd64) then installed it to
> enable more BPF options. With libelfg0-dev (0.8.13-5 amd64) and
> pkg-config (0.28-1 amd64). When I compiled libbpf from github, I got
> some errors. Here are some system informations:

Debian 8 went EOL more than a year ago, and that kernel is more than six
years out of date. Please upgrade!

> My future goal is to run a simple BPF CO-RE program on linux kernel
> 3.19.8. So is it possible to install libbpf on kernel 3.19.8?
> Furthermore, is it possible to run BPF CO-RE programs on kernel
> 3.19.8?

CO-RE is certainly not going to work on that kernel even if you do
manage to compile libbpf.

-Toke

