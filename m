Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4AF3B104E
	for <lists+bpf@lfdr.de>; Wed, 23 Jun 2021 01:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFVXFe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Jun 2021 19:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229675AbhFVXFe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 22 Jun 2021 19:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624402997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gkdf7S21VnLiNI2hSPYpqilho1jT158l5Aks2PTMc+8=;
        b=W7IjcjJYWCI1puXNeEpuymE22zmTOOQCv6tA/2pIvTte5FPFc+P0N+mbKQI2d6SUNTv6z/
        ec5BuPaiudUSfurTB00fUOA9RJntZL8yCRLoWuPJDgpPAD9pkIZOT7mRsdi7HyD7RoGeC0
        +NI6rN8i4Hsmib/+cT3eK/kJ4ipSeV4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-u9AzugDUNh-57bqhkiyMxg-1; Tue, 22 Jun 2021 19:03:16 -0400
X-MC-Unique: u9AzugDUNh-57bqhkiyMxg-1
Received: by mail-lj1-f200.google.com with SMTP id v3-20020a2e99030000b0290144dc7b6cf0so85743lji.2
        for <bpf@vger.kernel.org>; Tue, 22 Jun 2021 16:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gkdf7S21VnLiNI2hSPYpqilho1jT158l5Aks2PTMc+8=;
        b=QkX+AD3OE8gDFn49JcQRZuVxM5L0cYJof5Cw/B3boRnI/qJOwlSvSLpSv3B3FtIYri
         77FMKS73GacM4l68WXgOg6xM3bpXp+JXah4wqj0ZxgUtVyzvJTeQycShBakqWBlYHfSy
         Ll2CJGmuKvId7Ih2x1U2Xoev43dU9QDDsGZcB3QGtQuhpySRykraDaYJgcKsh/ooi9Bj
         /lun3KAldn9cJLkldPMlV8DywRJcNiZBxQ4Kr/shNXn3z//3Y3plS6K9deQziPUb5BVK
         l54SdC7ESajf57Pt0/NSpWdq428/Axp/pCEYHf9Lt/JUlUlHek2I+/xdDHMLVBBfyRSN
         mMsg==
X-Gm-Message-State: AOAM530vZJY0lgqEY95Pv4N0tPDFsg8+SaOcNBueNy+3b71QdKlyuz5A
        IeurkK4vwBYmhcJv6ba3UWaPiQFtVMkJW8BF0Gfjw+llxfefdERgaN0Rlh+wn3cwJS1nIguFSCP
        Y/QWqlyXISoM5
X-Received: by 2002:a17:906:3057:: with SMTP id d23mr6367481ejd.131.1624401189507;
        Tue, 22 Jun 2021 15:33:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzloo3phLmnqBeluVZUPr6bPCfoe/PWVRjC8errtEifQAVlZ/aBqsnGR8bFTh5W5SFYJukYkw==
X-Received: by 2002:a17:906:3057:: with SMTP id d23mr6367463ejd.131.1624401189297;
        Tue, 22 Jun 2021 15:33:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id cw10sm6493977ejb.62.2021.06.22.15.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 15:33:08 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1DA17180730; Wed, 23 Jun 2021 00:33:06 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/5] bitops: add non-atomic bitops for pointers
In-Reply-To: <20210622221023.gklikg5yib4ky35m@apollo>
References: <20210622202835.1151230-1-memxor@gmail.com>
 <20210622202835.1151230-3-memxor@gmail.com> <871r8tpnws.fsf@toke.dk>
 <20210622221023.gklikg5yib4ky35m@apollo>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 23 Jun 2021 00:33:06 +0200
Message-ID: <87y2b1o7h9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Wed, Jun 23, 2021 at 03:22:51AM IST, Toke H=C3=B8iland-J=C3=B8rgensen =
wrote:
>> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>>
>> > cpumap needs to set, clear, and test the lowest bit in skb pointer in
>> > various places. To make these checks less noisy, add pointer friendly
>> > bitop macros that also do some typechecking to sanitize the argument.
>> >
>> > These wrap the non-atomic bitops __set_bit, __clear_bit, and test_bit
>> > but for pointer arguments. Pointer's address has to be passed in and it
>> > is treated as an unsigned long *, since width and representation of
>> > pointer and unsigned long match on targets Linux supports. They are
>> > prefixed with double underscore to indicate lack of atomicity.
>> >
>> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> > ---
>> >  include/linux/bitops.h    | 19 +++++++++++++++++++
>> >  include/linux/typecheck.h | 10 ++++++++++
>> >  2 files changed, 29 insertions(+)
>> >
>> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
>> > index 26bf15e6cd35..a9e336b9fa4d 100644
>> > --- a/include/linux/bitops.h
>> > +++ b/include/linux/bitops.h
>> > @@ -4,6 +4,7 @@
>> >
>> >  #include <asm/types.h>
>> >  #include <linux/bits.h>
>> > +#include <linux/typecheck.h>
>> >
>> >  #include <uapi/linux/kernel.h>
>> >
>> > @@ -253,6 +254,24 @@ static __always_inline void __assign_bit(long nr,=
 volatile unsigned long *addr,
>> >  		__clear_bit(nr, addr);
>> >  }
>> >
>> > +#define __ptr_set_bit(nr, addr)                         \
>> > +	({                                              \
>> > +		typecheck_pointer(*(addr));             \
>> > +		__set_bit(nr, (unsigned long *)(addr)); \
>> > +	})
>> > +
>> > +#define __ptr_clear_bit(nr, addr)                         \
>> > +	({                                                \
>> > +		typecheck_pointer(*(addr));               \
>> > +		__clear_bit(nr, (unsigned long *)(addr)); \
>> > +	})
>> > +
>> > +#define __ptr_test_bit(nr, addr)                       \
>> > +	({                                             \
>> > +		typecheck_pointer(*(addr));            \
>> > +		test_bit(nr, (unsigned long *)(addr)); \
>> > +	})
>> > +
>>
>> Before these were functions that returned the modified values, now they
>> are macros that modify in-place. Why the change? :)
>>
>
> Given that we're exporting this to all kernel users now, it felt more
> appropriate to follow the existing convention/argument order for the
> functions/ops they are wrapping.

I wasn't talking about the order of the arguments; swapping those is
fine. But before, you had:

static void *__ptr_set_bit(void *ptr, int bit)

with usage (function return is the modified value):
ret =3D ptr_ring_produce(rcpu->queue, __ptr_set_bit(skb, 0));

now you have:
#define __ptr_set_bit(nr, addr)

with usage (modifies argument in-place):
__ptr_set_bit(0, &skb);
ret =3D ptr_ring_produce(rcpu->queue, skb);

why change from function to macro?

-Toke

