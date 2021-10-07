Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B0C4255AA
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 16:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241999AbhJGOnk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 10:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242064AbhJGOnk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 Oct 2021 10:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633617706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9UsAj+RvkqSk1B1eEQgMjvEXwWnDtfISX9Eoc5Bzxs0=;
        b=dG/8cvIs2WYi1JdcfrjyDsUJpOWl6h6mSr3Vm+JZFjioaV8qp6klf2wmNzD/hh0w9e3aRL
        YU+x8V82S1abzA4gWcn8CLD2BZI/NI6VuA2OjJs44PUrbWpe/XCa12afzJoMgu5tTAiXCV
        lLzHmepQClajsWOoCiEJvtHNNM/AMgs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-dMNBm8mpOemDSWSwoGbSaQ-1; Thu, 07 Oct 2021 10:41:45 -0400
X-MC-Unique: dMNBm8mpOemDSWSwoGbSaQ-1
Received: by mail-ed1-f72.google.com with SMTP id q26-20020aa7da9a000000b003db531e7acbso1749952eds.22
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 07:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9UsAj+RvkqSk1B1eEQgMjvEXwWnDtfISX9Eoc5Bzxs0=;
        b=C0m2UAc0ntRERWDBj+jloV21VmvIb4Yq8CjkPN8iLlvkWtEFZi6EQp/9m+iyGte5je
         Cq/r7DMhRL/udAsnXvieoWClsfQRonISgsIERX0yEvotM1716CseNG0thS/JPFAdAJoc
         rP1Q4T7vlElLkmxWUcNRCJuHSL+SrGV8twBpytPB1A/KUOP2piywTYD0eFd8qfZJ5zXy
         V9jvXnfrLiq09uHE2FiZAu5+qBop6pSw9byzQV2q/oztmyEv07N9Q6ziFkoDcm4rcAr7
         fm046+npmxUKQXW63mZlGKfzDJRsDlx1Y0C/i/dDkiyzGAxYZ7Ebsnm8Vst+T4beHppM
         3NkA==
X-Gm-Message-State: AOAM531FVC/D1RAq79tt84/WnJKlCZs0fi8o5c9qHMSjcLH1OVcwmTBr
        elGnOb5qXUbFE5lXpJB2SrM5skQJxUlqhblC8pKMmEUoQMaap5tcHyl6tOE2aPV9e7XBQuuBoJC
        e83tdojWIdZTo
X-Received: by 2002:a17:906:a3c4:: with SMTP id ca4mr5944631ejb.529.1633617704011;
        Thu, 07 Oct 2021 07:41:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeNIJPlwwnvwGXyY8+AXFH3jjdLd70rNGsjxas2Uu97WK1uAY7zz/494/IF5D9WG4divTqWw==
X-Received: by 2002:a17:906:a3c4:: with SMTP id ca4mr5944597ejb.529.1633617703677;
        Thu, 07 Oct 2021 07:41:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ke24sm2505369ejc.73.2021.10.07.07.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 07:41:42 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4B521180151; Thu,  7 Oct 2021 16:41:42 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joanne Koong <joannekoong@fb.com>, bpf@vger.kernel.org
Cc:     kafai@fb.com, netdev@vger.kernel.org, Kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 0/3] Add XDP support for bpf_load_hdr_opt
In-Reply-To: <20211006230543.3928580-1-joannekoong@fb.com>
References: <20211006230543.3928580-1-joannekoong@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 07 Oct 2021 16:41:42 +0200
Message-ID: <87h7dsnbh5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joanne Koong <joannekoong@fb.com> writes:

> Currently, bpf_sockops programs have been using bpf_load_hdr_opt() to
> parse the tcp header option. It will be useful to allow other bpf prog
> types to have a similar way of handling tcp hdr options.
>
> This series adds XDP support for bpf_load_hdr_opt(). At a high level,
> these patches are:

Why is this needed? Why not just parse the header directly in XDP? Seems
a bit arbitrary to add a helper for this particular type of packet
payload parsing to this particular program type. I.e., what about other
headers (IP options?)? Are we going to have a whole bunch of
special-purpose parsing helpers to pick out protocol data from packets?

Also, why only enable this for XDP (and not, say the TC hook as well)?

-Toke

