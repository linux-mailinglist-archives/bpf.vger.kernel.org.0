Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5044D48518C
	for <lists+bpf@lfdr.de>; Wed,  5 Jan 2022 12:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbiAELCR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jan 2022 06:02:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235128AbiAELCR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 5 Jan 2022 06:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641380536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mU9/SzRKyPGOPfZFRPOAGh+plV0Bf7SmUPmiV04B6Vk=;
        b=d/TgLtO57hS6uLGjPPT4TK1WYjQIgnUGI+RoiQKBE9f2xpzIPB1BNNdVvC8BZhqLSohM9A
        PhvDQ1PerXTUK3Ej0LdtmNzO95dVU6rTpxZDcg1mc1eeramR2CwIkle36q+eHF3V3fOK9X
        v6UQzf1plc5kx0OS3LvH1HTUvupVAvs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-SvuzQplLOYmiIVUy0nQMcA-1; Wed, 05 Jan 2022 06:02:15 -0500
X-MC-Unique: SvuzQplLOYmiIVUy0nQMcA-1
Received: by mail-ed1-f69.google.com with SMTP id ch27-20020a0564021bdb00b003f8389236f8so27430304edb.19
        for <bpf@vger.kernel.org>; Wed, 05 Jan 2022 03:02:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=mU9/SzRKyPGOPfZFRPOAGh+plV0Bf7SmUPmiV04B6Vk=;
        b=V48AfqBuHJsxAoYwyzGlkUpVCNGatnhsWygKc3qFwW860W615hnPW6rxG2ScK427m6
         HatCqUfLIrropgev5oB/D5JDBe6JTXGUl9OFqaO07RJ6uexZyt5tQsGyPVwrSmzDjpB1
         OZ3EZL+YUoseXpUCY4OGOi4ZT9rY0L/ajcehwRLcA8H+j0Z0aJYN3XUyoI+udNqLbfR4
         fotxoguXyWyfH3yw1QUhJwwONxOf+hdEUinN3Kq4qAUAbB8zn5DzatDFRfG7Z+hKXtmy
         6Crs3/xWiZa8Dm2Tz2jJ6Q2z6YRj+npjaq8Wno3fy0ZlVKWQhQbqc3NZAXjxv4o0PNh2
         Ugbg==
X-Gm-Message-State: AOAM532rV6PUJnzFIkSy3huPThwlX6SSfOSJ3/g/d/0qfCmxlijfrNgb
        OwAw8hGhUZDFHRvhbqlVNtZtqJdrp4hMy+vMQC1l8qDL8+CxHcRr222OQQBVem53UhPoED2x0k4
        GoyfbcGE1K0lr
X-Received: by 2002:a17:907:6d1d:: with SMTP id sa29mr43168639ejc.413.1641380534120;
        Wed, 05 Jan 2022 03:02:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9BXnPr0Tq3UHoiYc72JhrjPXsWEdorzKHJtEkTSX46fkbGaZHkO7VTr1cu2DVkkgtRHr1xQ==
X-Received: by 2002:a17:907:6d1d:: with SMTP id sa29mr43168619ejc.413.1641380533854;
        Wed, 05 Jan 2022 03:02:13 -0800 (PST)
Received: from [192.168.0.50] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id u1sm15687817edp.19.2022.01.05.03.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 03:02:13 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <976df045-b8c2-eeed-68d8-56c7c649ee2a@redhat.com>
Date:   Wed, 5 Jan 2022 12:02:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 3/7] page_pool: Store the XDP mem id
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>
References: <20220103150812.87914-1-toke@redhat.com>
 <20220103150812.87914-4-toke@redhat.com>
In-Reply-To: <20220103150812.87914-4-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 03/01/2022 16.08, Toke Høiland-Jørgensen wrote:
> Store the XDP mem ID inside the page_pool struct so it can be retrieved
> later for use in bpf_prog_run().
> 
> Signed-off-by: Toke Høiland-Jørgensen<toke@redhat.com>
> ---
>   include/net/page_pool.h | 9 +++++++--
>   net/core/page_pool.c    | 4 +++-
>   net/core/xdp.c          | 2 +-
>   3 files changed, 11 insertions(+), 4 deletions(-)

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

