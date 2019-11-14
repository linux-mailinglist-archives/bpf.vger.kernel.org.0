Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1BB3FC6F8
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2019 14:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfKNNKC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Nov 2019 08:10:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54345 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726190AbfKNNKB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Nov 2019 08:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573737001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vX83CN7NUJeyKjIkXTWoqG09Owt4UZW59OTf1NDbrbc=;
        b=V7t+DbP5H0XA43P80Z4ipgauQuQIW1uLp8hsZwQq/say8TK8PcfT0lO5t+H5BXDww6Gb1c
        vQ2jjJMTn+G6nY2eM6sM+Vtr6zT+JSDM4CpS4jhUEWu8TD2Gm4S1i091ooBWc7T1Cbw9q/
        Wev2Br7k/UxW8bHbU/zc78689pe+2pM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-DAD7oEMyOMmrBLS912RgDQ-1; Thu, 14 Nov 2019 08:10:00 -0500
Received: by mail-lf1-f69.google.com with SMTP id x16so1948554lfe.19
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2019 05:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vX83CN7NUJeyKjIkXTWoqG09Owt4UZW59OTf1NDbrbc=;
        b=F7TzAsfjaOTGFfF3tNMlLPrmIgPfz6J83EeFVemw39gqGJp0C6li9OFWsXeb9+d16Y
         JItKMVWgf804LYMpBk4H+xeq9VeROTpmYz9zM96M8SQHf7LItQsPr/q9L/HsQUdP2n+1
         c1LH3fvxjNsgfB0rYY13gT+VWXKpDv1A9xzbjuTAj4jFkj49WpMrtJwNJoRntlR2/SlH
         3XkkGISqVyHkeI5fRP3pxVuE28soBuhfdIwGEQ+B2e8tMEuBM33psESm3sXPkKVJrICV
         b97bj6nWNA2mp3LLdEH3n8YX9vlzR4oBnGZCyKDPshjfzoKTD143z44xWGFQdvydVf0K
         HTZA==
X-Gm-Message-State: APjAAAUihhb7CV93H5rihhBY+A4Eo5yyya954sSqdT+ppLeNQB3bha0D
        wOEvDiA5FxdIdBgt9GtiOgRa1iHnpL/eBJGpEWdgYHIVlRIAsecEw0IcWCOX0RlL2CuaKA7jf/Y
        StYT+OEKhcnUU
X-Received: by 2002:a2e:b4eb:: with SMTP id s11mr6559568ljm.38.1573736998993;
        Thu, 14 Nov 2019 05:09:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqw30J1OnKaQ6GvpVSw65G6QYc0kjJ4PwIxOjL+tHZwHaX0QSrFkwDU8HT88BdJC5jPP4KOjNw==
X-Received: by 2002:a2e:b4eb:: with SMTP id s11mr6559545ljm.38.1573736998762;
        Thu, 14 Nov 2019 05:09:58 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id i28sm2563696lfo.34.2019.11.14.05.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 05:09:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 685661803C7; Thu, 14 Nov 2019 14:09:57 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        netdev@vger.kernel.org, ast@kernel.org
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, magnus.karlsson@gmail.com,
        magnus.karlsson@intel.com, jonathan.lemon@gmail.com
Subject: Re: [RFC PATCH bpf-next 2/4] bpf: introduce BPF dispatcher
In-Reply-To: <7893c97d-3d3f-35cc-4ea0-ac34d3d84dbc@iogearbox.net>
References: <20191113204737.31623-1-bjorn.topel@gmail.com> <20191113204737.31623-3-bjorn.topel@gmail.com> <87o8xeod0s.fsf@toke.dk> <7893c97d-3d3f-35cc-4ea0-ac34d3d84dbc@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 14 Nov 2019 14:09:57 +0100
Message-ID: <87eeyaob8a.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: DAD7oEMyOMmrBLS912RgDQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 11/14/19 1:31 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:
>>> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>>>
>>> The BPF dispatcher builds on top of the BPF trampoline ideas;
>>> Introduce bpf_arch_text_poke() and (re-)use the BPF JIT generate
>>> code. The dispatcher builds a dispatch table for XDP programs, for
>>> retpoline avoidance. The table is a simple binary search model, so
>>> lookup is O(log n). Here, the dispatch table is limited to four
>>> entries (for laziness reason -- only 1B relative jumps :-P). If the
>>> dispatch table is full, it will fallback to the retpoline path.
>>=20
>> So it's O(log n) with n =3D=3D 4? Have you compared the performance of j=
ust
>> doing four linear compare-and-jumps? Seems to me it may not be that big
>> of a difference for such a small N?
>
> Did you perform some microbenchmarks wrt search tree? Mainly wondering
> since for code emission for switch/case statements, clang/gcc turns off
> indirect calls entirely under retpoline, see [0] from back then.

Yes, this was exactly the example I had in mind :)

>>> An example: A module/driver allocates a dispatcher. The dispatcher is
>>> shared for all netdevs. Each netdev allocate a slot in the dispatcher
>>> and a BPF program. The netdev then uses the dispatcher to call the
>>> correct program with a direct call (actually a tail-call).
>>=20
>> Is it really accurate to call it a tail call? To me, that would imply
>> that it increments the tail call limit counter and all that? Isn't this
>> just a direct jump using the trampoline stuff?
>
> Not meant in BPF context here, but more general [1].

Ah, right, that makes more sense.

> (For actual BPF tail calls I have a series close to ready for getting
> rid of most indirect calls which I'll post later today.)

Cool!

-Toke

