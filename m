Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E173B1889
	for <lists+bpf@lfdr.de>; Wed, 23 Jun 2021 13:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhFWLL2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Jun 2021 07:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46020 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230185AbhFWLLZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 23 Jun 2021 07:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624446548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZEEymDDfR8efFo43cjUGn36eWEQ3C2e+pjvjw6A7Nw=;
        b=LJuzaiymAYLdXlSi1tak0UOK/YGBI0FjueZHiOGcvnRdbIs/vy5VaFMW9MBR1drtiCN1Wk
        yRyFUm4pyAG/83ox409pyU55OX0+NszWs3BvoqpNx7Aknlc/88wRv22TnCpeHebGOeo+/s
        3wKk4IUR8PzHmYSGO9tPYoHHLSNtqHQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-AvrjOCXTPLiEY5siDSyixw-1; Wed, 23 Jun 2021 07:09:03 -0400
X-MC-Unique: AvrjOCXTPLiEY5siDSyixw-1
Received: by mail-ej1-f71.google.com with SMTP id 16-20020a1709063010b029037417ca2d43so852869ejz.5
        for <bpf@vger.kernel.org>; Wed, 23 Jun 2021 04:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CZEEymDDfR8efFo43cjUGn36eWEQ3C2e+pjvjw6A7Nw=;
        b=pPUnTwAGbvdpTK7kS9ZtsgDo7WHbEjQ5pOBpsa2J9TnTdqMvZKkO7SzyvcbHVA83J7
         AxEsJDscsK+iPMlMhdiiIlJSRqzuEuZCboqLNDVfYvafH9oNG23uJtseUD87ft0Tnqiq
         UolmtiLh8vTDOMSg9L7+EoQabRfzQMQr1KwDPl4xb2rL9tZjbyt3gWv+r1/jUmu/Tw/U
         oK5Z/SSQIU7bQDGMTLIeu6BRCcEmzZCKVYNPSqWSFsp9VyomnA8mPlWPwung9HGD+CSq
         tlF8CpVFNCE5l1vlMWnKiwuTpkYvG8pd7mqboLVbNM4UcqDkxlF28Dy9g0AdCQnv3++Y
         B6LQ==
X-Gm-Message-State: AOAM530Y/baAb8XI+3HcZxrMo6BG31Wl9XLLQiLYkQbGI8dNRUg7CldZ
        QlwtMAdozBYOvEdLXNBJhmPrykfXDj07dnmw1zbhldcJGcSVTOIyHrJygxZ97I9+G7iBCO2QN6d
        1Ld/1MYCup2r9
X-Received: by 2002:a17:906:4a96:: with SMTP id x22mr9208756eju.20.1624446542059;
        Wed, 23 Jun 2021 04:09:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2Cr57AO7gmJROrNJhJ4rlKf989GA0vtppZ5bcn49sDufCZrzjdnSdM8Lp4thAa9VkXpiLOQ==
X-Received: by 2002:a17:906:4a96:: with SMTP id x22mr9208740eju.20.1624446541888;
        Wed, 23 Jun 2021 04:09:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id g16sm7075151ejh.92.2021.06.23.04.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 04:09:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DF674180737; Wed, 23 Jun 2021 13:09:00 +0200 (CEST)
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
In-Reply-To: <20210622231606.6ak5shta5bknt7lb@apollo>
References: <20210622202835.1151230-1-memxor@gmail.com>
 <20210622202835.1151230-3-memxor@gmail.com> <871r8tpnws.fsf@toke.dk>
 <20210622221023.gklikg5yib4ky35m@apollo> <87y2b1o7h9.fsf@toke.dk>
 <20210622231606.6ak5shta5bknt7lb@apollo>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 23 Jun 2021 13:09:00 +0200
Message-ID: <87bl7won1v.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Wed, Jun 23, 2021 at 04:03:06AM IST, Toke H=C3=B8iland-J=C3=B8rgensen =
wrote:
>> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>>
>> > On Wed, Jun 23, 2021 at 03:22:51AM IST, Toke H=C3=B8iland-J=C3=B8rgens=
en wrote:
>> >> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>> >>
>> >> > cpumap needs to set, clear, and test the lowest bit in skb pointer =
in
>> >> > various places. To make these checks less noisy, add pointer friend=
ly
>> >> > bitop macros that also do some typechecking to sanitize the argumen=
t.
>> >> >
>> >> > These wrap the non-atomic bitops __set_bit, __clear_bit, and test_b=
it
>> >> > but for pointer arguments. Pointer's address has to be passed in an=
d it
>> >> > is treated as an unsigned long *, since width and representation of
>> >> > pointer and unsigned long match on targets Linux supports. They are
>> >> > prefixed with double underscore to indicate lack of atomicity.
>> >> >
>> >> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> >> > ---
>> >> >  include/linux/bitops.h    | 19 +++++++++++++++++++
>> >> >  include/linux/typecheck.h | 10 ++++++++++
>> >> >  2 files changed, 29 insertions(+)
>> >> >
>> >> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
>> >> > index 26bf15e6cd35..a9e336b9fa4d 100644
>> >> > --- a/include/linux/bitops.h
>> >> > +++ b/include/linux/bitops.h
>> >> > @@ -4,6 +4,7 @@
>> >> >
>> >> >  #include <asm/types.h>
>> >> >  #include <linux/bits.h>
>> >> > +#include <linux/typecheck.h>
>> >> >
>> >> >  #include <uapi/linux/kernel.h>
>> >> >
>> >> > @@ -253,6 +254,24 @@ static __always_inline void __assign_bit(long =
nr, volatile unsigned long *addr,
>> >> >  		__clear_bit(nr, addr);
>> >> >  }
>> >> >
>> >> > +#define __ptr_set_bit(nr, addr)                         \
>> >> > +	({                                              \
>> >> > +		typecheck_pointer(*(addr));             \
>> >> > +		__set_bit(nr, (unsigned long *)(addr)); \
>> >> > +	})
>> >> > +
>> >> > +#define __ptr_clear_bit(nr, addr)                         \
>> >> > +	({                                                \
>> >> > +		typecheck_pointer(*(addr));               \
>> >> > +		__clear_bit(nr, (unsigned long *)(addr)); \
>> >> > +	})
>> >> > +
>> >> > +#define __ptr_test_bit(nr, addr)                       \
>> >> > +	({                                             \
>> >> > +		typecheck_pointer(*(addr));            \
>> >> > +		test_bit(nr, (unsigned long *)(addr)); \
>> >> > +	})
>> >> > +
>> >>
>> >> Before these were functions that returned the modified values, now th=
ey
>> >> are macros that modify in-place. Why the change? :)
>> >>
>> >
>> > Given that we're exporting this to all kernel users now, it felt more
>> > appropriate to follow the existing convention/argument order for the
>> > functions/ops they are wrapping.
>>
>> I wasn't talking about the order of the arguments; swapping those is
>> fine. But before, you had:
>>
>> static void *__ptr_set_bit(void *ptr, int bit)
>>
>> with usage (function return is the modified value):
>> ret =3D ptr_ring_produce(rcpu->queue, __ptr_set_bit(skb, 0));
>>
>> now you have:
>> #define __ptr_set_bit(nr, addr)
>>
>> with usage (modifies argument in-place):
>> __ptr_set_bit(0, &skb);
>> ret =3D ptr_ring_produce(rcpu->queue, skb);
>>
>> why change from function to macro?
>>
>
> Earlier it just took the pointer value and returned one with the bit set.=
 I
> changed it to work similar to __set_bit.

Hmm, okay, fair enough I suppose there's something to be said for
consistency, even though I personally prefer the function style. Let's
keep it as macros, then :)

-Toke

