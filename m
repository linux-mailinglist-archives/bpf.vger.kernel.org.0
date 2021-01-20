Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C5A2FD37D
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 16:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbhATPAg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 10:00:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46308 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390188AbhATO63 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Jan 2021 09:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611154623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fwvMFPt1WboLcOoH23UIfhd2xo9KC7W2tNFuZGnH5tg=;
        b=LuAN7x0ZV57AWkU+pMrVnXFbb8SjIbUZJvxr1rATfEJ+0q1bB42C3l5P9b7UqObHbuo0wg
        yXkqxX7xow/cKvAXaNRl12gr4zMMpyfkRHaf8hVcoxCS8thkVM78ezlXKSQ95/M7Nr75a2
        Nuk/krXbHiMpvMup1Le62uFSqqJNqmA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-4nmbKqRMPeOTvGvnFnp7Dg-1; Wed, 20 Jan 2021 09:56:59 -0500
X-MC-Unique: 4nmbKqRMPeOTvGvnFnp7Dg-1
Received: by mail-ed1-f71.google.com with SMTP id g6so11172282edw.13
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 06:56:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=fwvMFPt1WboLcOoH23UIfhd2xo9KC7W2tNFuZGnH5tg=;
        b=QwdSUr9x0ETTRHxUuCJfaMmIiXJs8ZANIvegRrAGYDji0HyWoeD78k/xY3lE9KjKpm
         kX/G+546HyRWrSPO+4/cacZy1Ium/5SkWyg6+a3KSlE2lfpLdXHhIjXVSA42gSMOpLXA
         mEV//ymd3ClFIz9Ua7zp8qFsDkC545PuFmFWIbD0LdHU+SdvO+Ua0wsz18+m0kOgQelK
         IB6Y7S0hlH3v85ed3OsGBwK5Bg4EXc2e2Ib8xIZVpNcOTtFqieCpcKWW6VKUZ3lNupVX
         M4nCNfg9GIBcw1kRDFud2lEvVslh04yIXbBxFr5QFkvalOpUe+DU48osYCfRBQ1smZAJ
         YMSA==
X-Gm-Message-State: AOAM532OJ9CC0kqG4PhU3tz77gNP640RJxZSWWPBneIAFTjM6rXsU3tZ
        IiPVjV2T6LjxAAjd405hjvWR9fHXUxg1QyvKilw6gF9XbfDmmUWLOzPLUr14Pf2aPYrGv0Ljr6G
        eaW0aXfAijY4O
X-Received: by 2002:aa7:d2d4:: with SMTP id k20mr7518634edr.361.1611154618202;
        Wed, 20 Jan 2021 06:56:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy99WUOs30PTEEP3IzAalAndtcfLMV0Alj0wITXpTucPw6kGqbpjitK+lVUsQrpGBXLVfgbTg==
X-Received: by 2002:aa7:d2d4:: with SMTP id k20mr7518623edr.361.1611154617989;
        Wed, 20 Jan 2021 06:56:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id w16sm1313993edv.4.2021.01.20.06.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 06:56:57 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 378D5180331; Wed, 20 Jan 2021 15:56:57 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        kuba@kernel.org, jonathan.lemon@gmail.com, maximmi@nvidia.com,
        davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        ciara.loftus@intel.com, weqaar.a.janjua@intel.com,
        Marek Majtyka <alardam@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/8] libbpf, xsk: select AF_XDP BPF program
 based on kernel version
In-Reply-To: <6c7da700-700d-c7f6-fe0a-c42e55e81c8a@intel.com>
References: <20210119155013.154808-1-bjorn.topel@gmail.com>
 <20210119155013.154808-6-bjorn.topel@gmail.com> <875z3repng.fsf@toke.dk>
 <6c7da700-700d-c7f6-fe0a-c42e55e81c8a@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 20 Jan 2021 15:56:57 +0100
Message-ID: <87h7nb4pxi.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com> writes:

> On 2021-01-20 13:52, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:
>>=20
>>> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>>>
>>> Add detection for kernel version, and adapt the BPF program based on
>>> kernel support. This way, users will get the best possible performance
>>> from the BPF program.
>>=20
>> Please do explicit feature detection instead of relying on the kernel
>> version number; some distro kernels are known to have a creative notion
>> of their own version, which is not really related to the features they
>> actually support (I'm sure you know which one I'm referring to ;)).
>>
>
> Right. For a *new* helper, like bpf_redirect_xsk, we rely on rejection
> from the verifier to detect support. What about "bpf_redirect_map() now
> supports passing return value as flags"? Any ideas how to do that in a
> robust, non-version number-based scheme?

Well, having a BPF program pass in a flag of '1' with an invalid lookup
and checking if it returns 1 or 0. But how to do that from libbpf, hmm,
good question. BPF_PROG_RUN()?

An alternative could be to default to a program that will handle both
cases in the BPF code, and make it opt-in to use the optimised versions
if the user knows their kernel supports it?

-Toke

