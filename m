Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2F4398450
	for <lists+bpf@lfdr.de>; Wed,  2 Jun 2021 10:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbhFBIkf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Jun 2021 04:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21015 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232717AbhFBIkf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Jun 2021 04:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622623132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sTZTtBNUa2GqpMgr3TsfApPZ9E5Jnhf92Yl0Bbd6O1k=;
        b=N8NKZJLHztsTWaiI4i+o+1eRs3wBImf0FNCL46X8ETRW0WhO2D9zN9zq2m6jL2GEog/1iq
        mB5y4S/tgCm3O2TiydeYjaCZJwfL1KhmqwCiHlejg16v942CBzFj/gTDgjEljN4aiivxde
        l8J9IG2jj7BYxsAvqyFz0v1aV0P+g7I=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-xNPghQoYMvqkZ3aAXkFXjQ-1; Wed, 02 Jun 2021 04:38:51 -0400
X-MC-Unique: xNPghQoYMvqkZ3aAXkFXjQ-1
Received: by mail-ed1-f71.google.com with SMTP id j13-20020aa7de8d0000b029038fc8e57037so1010723edv.0
        for <bpf@vger.kernel.org>; Wed, 02 Jun 2021 01:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=sTZTtBNUa2GqpMgr3TsfApPZ9E5Jnhf92Yl0Bbd6O1k=;
        b=C8TXpcF3L2N+QJC7+aUKxmoMBqNi1rGDisvcg5BQNCH9IED3NwNbcplaP7MlezWf2U
         on3Whx/pU5IAc4UAQ/xQ/sHViGX2SBrAbL+oLJAJC2FdUmjtAYuJ8JD65oeE6lon17X0
         cIvjekdXGZymjwOa679uin6i/KBx9mHh0VH3cLMzR92kVYoNOrS/epOyovjXxog9q9WV
         V3NuEQcxLErUfoleGRlOfq86aeGcGVT+Mab4T18N2ep/QmG9QdajShCvWTYTSOKbih0w
         OOYIYHTbcLzL8HrrkGOXfGP9Ax2i1AJIxavS178+Zm35YfUcLJ9aA85QN/pWFpa4tUMi
         sHGA==
X-Gm-Message-State: AOAM5304Hhe1w3paB/MxOdpl4U1F04xe4g/W8+I0aWd6R462MmtFPn2/
        QW1++/zVIwzH2Rvws92xSRUZuP7OX6cMAlEzTCIwHSofm72Ge/O8kqqGhBqT0YuPYIOQ674KNXd
        UYplreoXQBBUv
X-Received: by 2002:a50:cb85:: with SMTP id k5mr32554937edi.170.1622623129844;
        Wed, 02 Jun 2021 01:38:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznNx1BKF2wb6aAOnoMMX1IU04QbC3N7r29/JqfnA7jMn5hjgExL0f5PSdJyUQIWvBLHfs6/g==
X-Received: by 2002:a50:cb85:: with SMTP id k5mr32554918edi.170.1622623129709;
        Wed, 02 Jun 2021 01:38:49 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id cz14sm840407edb.84.2021.06.02.01.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 01:38:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 878F5180726; Wed,  2 Jun 2021 10:38:47 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        Wang Hai <wanghai38@huawei.com>
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] xsk: Return -EINVAL instead of -EBUSY after
 xsk_get_pool_from_qid() fails
In-Reply-To: <CAJ8uoz2sT9iyqjWcsUDQZqZCVoCfpqgM7TseOTqeCzOuChAwww@mail.gmail.com>
References: <20210602031001.18656-1-wanghai38@huawei.com>
 <CAJ8uoz2sT9iyqjWcsUDQZqZCVoCfpqgM7TseOTqeCzOuChAwww@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 02 Jun 2021 10:38:47 +0200
Message-ID: <87a6o8bqzs.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Magnus Karlsson <magnus.karlsson@gmail.com> writes:

> On Wed, Jun 2, 2021 at 6:02 AM Wang Hai <wanghai38@huawei.com> wrote:
>>
>> xsk_get_pool_from_qid() fails not because the device's queues are busy,
>> but because the queue_id exceeds the current number of queues.
>> So when it fails, it is better to return -EINVAL instead of -EBUSY.
>>
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
>> ---
>>  net/xdp/xsk_buff_pool.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
>> index 8de01aaac4a0..30ece117117a 100644
>> --- a/net/xdp/xsk_buff_pool.c
>> +++ b/net/xdp/xsk_buff_pool.c
>> @@ -135,7 +135,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>>                 return -EINVAL;
>>
>>         if (xsk_get_pool_from_qid(netdev, queue_id))
>> -               return -EBUSY;
>> +               return -EINVAL;
>
> I guess your intent here is to return -EINVAL only when the queue_id
> is larger than the number of active queues. But this patch also
> changes the return code when the queue id is already in use and in
> that case we should continue to return -EBUSY. As this function is
> used by a number of drivers, the easiest way to accomplish this is to
> introduce a test for queue_id out of bounds before this if-statement
> and return -EINVAL there.

Isn't the return code ABI by now, though?

-Toke

