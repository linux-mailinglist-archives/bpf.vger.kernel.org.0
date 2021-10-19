Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF10434253
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 01:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJSXzZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Oct 2021 19:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhJSXzZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Oct 2021 19:55:25 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA5CC06161C
        for <bpf@vger.kernel.org>; Tue, 19 Oct 2021 16:53:12 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id n65so7921378ybb.7
        for <bpf@vger.kernel.org>; Tue, 19 Oct 2021 16:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XK3pZtU+8Iv+RyRFofIjnilYSAuOZyrPk9wakqvEXEQ=;
        b=JbafVaM2jnbUyGL37mqFJSveNX6vQvOGQao4Ti4Z7ZeXUrV7CFrVyHsd1/yv5clFLr
         dvFkiSD8fu2VIJBYwZCjGkGrsWECQFVNtnD/PGc9qVwpB3H+CSm/CVm71t042vHSEyHW
         77cZohkuRR/DfParuP75ZN43QJDkTV3sADWsK3WwmF4Hs6KZPeWoRY5/EnlTk53YmXm8
         lfu6cr8Y1KFBiYoyK05meYssHgE6lu7CmCEs2Uba+3jdvYbqRGFixcf9FtwCnaJkkPC2
         R8HgCpR8HVC2sdfCf+QiA64jhUo+pm0pE0bCNmNa8/V+0BxQUvhYikCi6LzMItTGVkxS
         vbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XK3pZtU+8Iv+RyRFofIjnilYSAuOZyrPk9wakqvEXEQ=;
        b=7MmBylohMoP//FCUWfGBg9eyEOormHG4pt5o6BJs9S2BbADdkw/S2gOj/ppwtz7R2z
         heHrQKfuHqYKF4p9Y237x7ryIYxyXFiYVB1NCZ1OKjFQvTTERsFgDvGMQ8U1ST5MMgi3
         C295HOdRKlbge5AuKVtGIZdvpIsIYtlA4mWkldrPRmTYFmssIhnrtYeEMA8kifZ9sRPH
         NflUwh1eJMMb/urW973efLQR9m8oA+ry/eSfANKzBSesgAl+wG1XX94u963chSvbEqD1
         AnIvRxIptIWRO1N0IfmFP+l9q/RkJ/SWQ6yU4N7t50xzp/lpyySsZQdkGAJbG4+fRJtP
         hC4g==
X-Gm-Message-State: AOAM531xX+mjFyxn7matyJPWVaIwtes7QTvu3xvtiQmR8PZx50If+sHf
        W9tJ3Q1E4W27H/BaYXDTqCAjvdNMkB8BvsomEVE=
X-Google-Smtp-Source: ABdhPJz+RFUmOWyPx7zExhNWAECwutlpgXTzBLNCb5ZJ3qQJyZT+ta/4WoUpbSkFpTM27b5UUOCLTDD2HjOfGPekcDs=
X-Received: by 2002:a25:d3c8:: with SMTP id e191mr39096436ybf.455.1634687591255;
 Tue, 19 Oct 2021 16:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211006222103.3631981-1-joannekoong@fb.com> <20211006222103.3631981-2-joannekoong@fb.com>
 <87k0ioncgz.fsf@toke.dk> <4536decc-5366-dc07-4923-32f2db948d85@fb.com>
 <87o87zji2a.fsf@toke.dk> <CAEf4BzbqQRzTgPmK3EM0wWw5XrgnenqhhBJdudFjwxLrfPJF8g@mail.gmail.com>
 <87czoejqcv.fsf@toke.dk> <CAEf4BzbWVCz6RNKHVgqLYx8UqGUdDqL5EPKyuQ5YTXZMxt2r_Q@mail.gmail.com>
 <877deiif3q.fsf@toke.dk> <38d80c55-97e1-4cbb-cb23-d6331d8f539b@fb.com>
 <20211013001152.6f4ssugsebosrjh7@kafai-mbp> <68fdb5ac-934f-ee20-3469-e0f22d66b2a9@fb.com>
In-Reply-To: <68fdb5ac-934f-ee20-3469-e0f22d66b2a9@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 19 Oct 2021 16:53:00 -0700
Message-ID: <CAEf4BzbUu53HHyqkJ4tNj1WXajQ+6ShZVZmCW2BsAr2U_DOdYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bitset map with bloom filter capabilities
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, Joanne Koong <joannekoong@fb.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 12, 2021 at 9:41 PM Alexei Starovoitov <ast@fb.com> wrote:
>
> On 10/12/21 5:11 PM, Martin KaFai Lau wrote:
> > On Tue, Oct 12, 2021 at 03:46:47PM -0700, Joanne Koong wrote:
> >> I'm also open to adding the bloom filter map and then in the
> >> future, if/when there is a need for the bitset map, adding that as a
> >> separate map. In that case, we could have the bitset map take in
> >> both key and value where key = the bitset index and value = 0 or 1.
> > v4 uses nr_hash_funcs is 0 (i.e. map_extra is 0) to mean bitset
> > and non-zero to mean bloom filter.
> >
> > Since the existing no-key API can be reused and work fine with bloom
> > filter, my current thinking is it can start with bloom filter first
> > and limit the nr_hash_funcs to be non-zero.
> >
> > If in the future a bitset map is needed and the bloom filter API can
> > be reused, the non-zero check can be relaxed.  If not, a separate
> > API/map needs to be created for bitset anyway.
> >
>
> sounds good to me.
> let's drop bitset for now since there doesn't seem to be a consensus.

sgtm too
