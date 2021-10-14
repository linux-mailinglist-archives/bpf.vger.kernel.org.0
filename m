Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9484542DAC9
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 15:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhJNNwK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 09:52:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57651 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230177AbhJNNwK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 Oct 2021 09:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634219404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NU91yXOcSHE5nSjfMfHje2UOd8qpOzLy0LtZp6G93T4=;
        b=F8Dbu/21BN00ZPh984YQUEr2XsD4uo/QXGsy1JqsNCGlNy/yrpaAkm5471tOr6IPOhF4kH
        34SJXQUZu6QOGcfMrSHsNFycVlyq0GL73pBcSM/TXikHHJ4+5TosCPzKgzcy5MGUAOjw33
        9pjhx4WHVvB+LnY7mW6zCPMG6v/S2Vw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-jgtChhiZONyQHarOlyWR6g-1; Thu, 14 Oct 2021 09:50:03 -0400
X-MC-Unique: jgtChhiZONyQHarOlyWR6g-1
Received: by mail-wr1-f70.google.com with SMTP id h99-20020adf906c000000b001644add8925so1432634wrh.0
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 06:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NU91yXOcSHE5nSjfMfHje2UOd8qpOzLy0LtZp6G93T4=;
        b=G/sLSlGl/WaYX5PlhDBMhHItR04O0Q04WyBYcMP7I3HLfuHcYKJ8dvCPFCpIuEcrDB
         gs1aehTJW3L986EF9BKzXaAarnNlz/Ju8m+29zsjjtu5kh27s50s2SLgXtw8gmAgIXGG
         gU7fCxG/QemExt+Vn69O4WGNnbFgNSEbllPzoqg/K0BgYD7F8Q2or7C9Zwi35uVXt6i0
         2JPd8WQAezui3qBJKGflmsV6VFuSmgNrfEKCyhrFszwx0zKp961/8mtWxAQaGPopHwyA
         aI0E5Xxqykj55rT+9wZ2QBj1pFoT5xs7BdQXmgCNlqDO9oU00VeRq839dX5Ueci1F2uT
         FHbw==
X-Gm-Message-State: AOAM5320YG7djDOIZ807lUYB14T/hvYEl8oyZ+O3nyxz8PTz6XqPqRM/
        kajH4bYkCtv1EjKJc7Oj09Wj41QLoPS5zbI/rA3n0TLahwW3jc0lnFZ4cOPXm44stfF1aQzKRxZ
        rXaHSGS2x/FpK
X-Received: by 2002:adf:a48c:: with SMTP id g12mr6772211wrb.341.1634219402591;
        Thu, 14 Oct 2021 06:50:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhasqnkH6VqbFgdvBD0W5Dr+k4Bevu249dEYV/bhzX6RKl2KWbGOdZbqz1wCI3B6WA3SqVvQ==
X-Received: by 2002:adf:a48c:: with SMTP id g12mr6772182wrb.341.1634219402382;
        Thu, 14 Oct 2021 06:50:02 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-16.dyn.eolo.it. [146.241.231.16])
        by smtp.gmail.com with ESMTPSA id c15sm2496966wrs.19.2021.10.14.06.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 06:50:02 -0700 (PDT)
Message-ID: <f3cc125b2865cce2ea4354b3c93f45c86193545a.camel@redhat.com>
Subject: Re: [syzbot] BUG: corrupted list in netif_napi_add
From:   Paolo Abeni <pabeni@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        syzbot <syzbot+62e474dd92a35e3060d8@syzkaller.appspotmail.com>,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Cc:     toke@toke.dk, joamaki@gmail.com
Date:   Thu, 14 Oct 2021 15:50:00 +0200
In-Reply-To: <f821df00-b3e9-f5a8-3dcb-a235dd473355@iogearbox.net>
References: <0000000000005639cd05ce3a6d4d@google.com>
         <f821df00-b3e9-f5a8-3dcb-a235dd473355@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2021-10-13 at 15:35 +0200, Daniel Borkmann wrote:
> On 10/13/21 1:40 PM, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> 
> [ +Paolo/Toke wrt veth/XDP, +Jussi wrt bond/XDP, please take a look, thanks! ]

For the records: Toke and me are actively investigating this issue and
the other recent related one. So far we could not find anything
relevant. 

The onluy note is that the reproducer is not extremelly reliable - I
could not reproduce locally, and multiple syzbot runs on the same code
give different results. Anyhow, so far the issue was only observerable
on a specific 'next' commit which is currently "not reachable" from any
branch. I'm wondering if the issue was caused by some incosistent
status of such tree.

Cheers,

Paolo

