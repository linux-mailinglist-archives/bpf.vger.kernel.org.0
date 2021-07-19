Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64F03CD4DC
	for <lists+bpf@lfdr.de>; Mon, 19 Jul 2021 14:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhGSL55 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 07:57:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231388AbhGSL54 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 19 Jul 2021 07:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626698316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9xnPevyU/vinvxm9fpLnz13ttiz6/qE1ToIVXogNE+c=;
        b=QL2zVu247E78B49KAcVCgdg3/m7/kirPBGBNy7AwqvZPURjmJceSUnN2mVKGVvjLfj1VEW
        sxpL0AfKrgH4wsLIamBqvl/jp4s/gjU/IAd5ExphklIXhJcGT+ZMM2nRRcUfopvArjNJuG
        enn3IGfe5EwCCYRWpwWt8FNRRt/LAgo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-DyOpQBITPvWR1rDbiCb7ow-1; Mon, 19 Jul 2021 08:38:35 -0400
X-MC-Unique: DyOpQBITPvWR1rDbiCb7ow-1
Received: by mail-ej1-f70.google.com with SMTP id sd15-20020a170906ce2fb0290512261c5475so5308606ejb.13
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 05:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9xnPevyU/vinvxm9fpLnz13ttiz6/qE1ToIVXogNE+c=;
        b=r05b71CevRKnrTpIsVn2Rwq3APnvADlqAQv7V2a3hcCRE+TEfeoLQhrHyYpQ8DyzqU
         UTpziJjQplK8leQO4+XZ3mqWlnJgSZi5Gj4Yo4LBhweymQN82Mo1DFSeucnb3UhWiTm5
         TmgWouvrV2rb8VTgnHOlpO9c8qrQQkCobL2bkfQhJj8dzHrlkA+ZXzKUfm/D9Mu0NbyY
         2XOTHiDP6GrDBII4rilu4VbWNUGsGdrsWKDo8G5Fo7r6fSMgZtT4yMyUik+Ml/3UmiXp
         IzxhUXN+WiNRS3oUAS1YC4PKCgj6Xi3/IGRIhIlOU8wrEtEHrUztStKIk63b0zkA7+Hn
         8P3g==
X-Gm-Message-State: AOAM530IG1vlUXmdsKgmus4FPRbf29FdqQxL8LZisUoAOa87KDSbq8ty
        bVL1j+rj/7Gfq7qtxM+M3GH0XIp/CzXYmwXfg+t+jHE59oeNkK9u71nefynxyMEBeHH0nqmFsuf
        wp4YgpUjmGTpK
X-Received: by 2002:a05:6402:692:: with SMTP id f18mr34700411edy.327.1626698313963;
        Mon, 19 Jul 2021 05:38:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnczeyvEpOgLXM/x4GwI3PK+KqvUJeavIe9mVLcwzRkXbCNtd51hBnv/Dbxxr24TjaxK5HTQ==
X-Received: by 2002:a05:6402:692:: with SMTP id f18mr34700397edy.327.1626698313850;
        Mon, 19 Jul 2021 05:38:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d18sm5856039ejr.50.2021.07.19.05.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 05:38:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 506F7180065; Mon, 19 Jul 2021 14:38:32 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     "luwei (O)" <luwei32@huawei.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        David Ahern <dahern@digitalocean.com>
Subject: Re: Ask for help about bpf map
In-Reply-To: <6b659192-5133-981e-0c43-7ca1120edd9c@huawei.com>
References: <5aebe6f4-ca0d-4f64-8ee6-b68c58675271@huawei.com>
 <CAEf4BzZpSo8Kqz8mgPdbWTTVLqJ1AgE429_KHTiXgEVpbT97Yw@mail.gmail.com>
 <8735sidtwe.fsf@toke.dk> <d1f47a24-6328-5121-3a1f-5a102444e50c@huawei.com>
 <26db412c-a8b7-6d37-844f-7909a0c5744b@huawei.com>
 <189e4437-bb2c-2573-be96-0d6776feb5dd@huawei.com>
 <CAADnVQJYhtpEcvvYfozxiPdUJqcZiJxbmT2KuOC6uQdC1VWZVw@mail.gmail.com>
 <6b659192-5133-981e-0c43-7ca1120edd9c@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 19 Jul 2021 14:38:32 +0200
Message-ID: <87wnpmtr5j.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"luwei (O)" <luwei32@huawei.com> writes:

> Andrii and Toke inspired me. You are right, the libbpf version should be included in -V output
> , but not mine. I searched google and found this page: https://www.spinics.net/lists/netdev/msg700482.html
> , according which I re-compiled iproute2 and it works.

Did the libbpf version appear in the output of 'ip -V' after you
recompiled and enabled it? It does in mine:

$ ./ip/ip -V
ip utility, iproute2-5.13.0, libbpf 0.4.0

-Toke

