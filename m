Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0855F3B0FB9
	for <lists+bpf@lfdr.de>; Wed, 23 Jun 2021 00:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFVWCv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Jun 2021 18:02:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229612AbhFVWCu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 22 Jun 2021 18:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624399234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=muXiI1t5kA6cK1rXHpxgihnBFeO1TBS1Tofk95h0PDc=;
        b=id9LYvTgmXrP24+eKlZhIsT1VNblP4zz3DLhVSws2uOXX2MHT0RENgWaYSt2yuobq20wYN
        zcOGbONt+x4seJXIAkcxSCbqVfECUwrCN68rXLaQKvHc3eTWVv+I9yezvzaMCTMJAeJMN4
        vCWy+zsEwotpkOO4/JRV1L4uVD3owio=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-1n3yHdiBNbSQQg5E_qro8A-1; Tue, 22 Jun 2021 18:00:30 -0400
X-MC-Unique: 1n3yHdiBNbSQQg5E_qro8A-1
Received: by mail-ed1-f71.google.com with SMTP id ch5-20020a0564021bc5b029039389929f28so265294edb.16
        for <bpf@vger.kernel.org>; Tue, 22 Jun 2021 15:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=muXiI1t5kA6cK1rXHpxgihnBFeO1TBS1Tofk95h0PDc=;
        b=LpbaYblck08tY0dRju4UaBiM462aCG66zM72YAnLHwtUFujD4uJMg259hK37uU8yDe
         Zs82d5Vj/StbYZmRzWxeExUBSQC6I6MxSr5fhmIJrXg5phkDLvWmf3rAVpJC3r02ooSx
         6P8pSUj1PgHZkxeQRIb5oYd9x89kOFtRqNdcZVJyldW8a4FIVFhXc+EC4DWKEE9pneTy
         C59tuEOEnwAwEOAJsB2EqE21SMcbsa+bpcuyPK743oQNkXDeReLJLHuDhGK8YCndEx5O
         on3mkzp2x4mX0j7OLSE3aiOY7s5DSmMpHutHi9S5sk7KxlnL56Qr4Bu4esu2wiOsJ69k
         MGLg==
X-Gm-Message-State: AOAM532zSf9cWIxZ2yP3r8gR40Kpb463Oq+MkwEfv2WJpcBmST+Ai+YX
        boKo9gU8pvawPj5eVURbzThKXhpJ8BjphNusk647/gK5I15GHkm1EZp9az+yqznaYjf5haPynqd
        +akpT31Q72vd0
X-Received: by 2002:a17:906:1318:: with SMTP id w24mr6134878ejb.222.1624398772553;
        Tue, 22 Jun 2021 14:52:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYgXlU6eB4BDCEoFhNChY4tjZ+nDf+v/FSJVdCo814paMiu/xWxD483Me4Gunzl5gGglJMwA==
X-Received: by 2002:a17:906:1318:: with SMTP id w24mr6134867ejb.222.1624398772386;
        Tue, 22 Jun 2021 14:52:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id n11sm6630781ejg.43.2021.06.22.14.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 14:52:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 603CE180730; Tue, 22 Jun 2021 23:52:51 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/5] bitops: add non-atomic bitops for pointers
In-Reply-To: <20210622202835.1151230-3-memxor@gmail.com>
References: <20210622202835.1151230-1-memxor@gmail.com>
 <20210622202835.1151230-3-memxor@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 22 Jun 2021 23:52:51 +0200
Message-ID: <871r8tpnws.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> cpumap needs to set, clear, and test the lowest bit in skb pointer in
> various places. To make these checks less noisy, add pointer friendly
> bitop macros that also do some typechecking to sanitize the argument.
>
> These wrap the non-atomic bitops __set_bit, __clear_bit, and test_bit
> but for pointer arguments. Pointer's address has to be passed in and it
> is treated as an unsigned long *, since width and representation of
> pointer and unsigned long match on targets Linux supports. They are
> prefixed with double underscore to indicate lack of atomicity.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bitops.h    | 19 +++++++++++++++++++
>  include/linux/typecheck.h | 10 ++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 26bf15e6cd35..a9e336b9fa4d 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -4,6 +4,7 @@
>  
>  #include <asm/types.h>
>  #include <linux/bits.h>
> +#include <linux/typecheck.h>
>  
>  #include <uapi/linux/kernel.h>
>  
> @@ -253,6 +254,24 @@ static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
>  		__clear_bit(nr, addr);
>  }
>  
> +#define __ptr_set_bit(nr, addr)                         \
> +	({                                              \
> +		typecheck_pointer(*(addr));             \
> +		__set_bit(nr, (unsigned long *)(addr)); \
> +	})
> +
> +#define __ptr_clear_bit(nr, addr)                         \
> +	({                                                \
> +		typecheck_pointer(*(addr));               \
> +		__clear_bit(nr, (unsigned long *)(addr)); \
> +	})
> +
> +#define __ptr_test_bit(nr, addr)                       \
> +	({                                             \
> +		typecheck_pointer(*(addr));            \
> +		test_bit(nr, (unsigned long *)(addr)); \
> +	})
> +

Before these were functions that returned the modified values, now they
are macros that modify in-place. Why the change? :)

-Toke

