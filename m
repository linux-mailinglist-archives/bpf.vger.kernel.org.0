Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72D342A4D7
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 14:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbhJLMuU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 08:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43573 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236508AbhJLMuT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Oct 2021 08:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634042896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OKLvXpV+oAjkG5GJWRYOYD3Wm31HeEfrG7+1hQhnTQY=;
        b=QZf9GUa/nHuPAYRzPJwH+qCshx5J8k+AOjkQrF+54u1cy+8aK6LpmiLEU/Mj77YHMtO/RX
        JG8bg1KIiLvc2TKrd45FxrB+VxR/GDlHybg59t5xf8kv2hnHZl0lfj0gnOEAlnIGClDsD2
        XSfjVz7lmkJsLMwNsSQ1LKYO29ZQtxw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-1LSsi1YiPKKuS8PrEogqbA-1; Tue, 12 Oct 2021 08:48:15 -0400
X-MC-Unique: 1LSsi1YiPKKuS8PrEogqbA-1
Received: by mail-ed1-f70.google.com with SMTP id v2-20020a50f082000000b003db24e28d59so18802376edl.5
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 05:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OKLvXpV+oAjkG5GJWRYOYD3Wm31HeEfrG7+1hQhnTQY=;
        b=qyzVgIpnjlTyzblD+CsiOB4I3aRwauhL3e1Vx/ZeP/x9+OlbGzztvLGxyVdpeO5k9b
         uRe2mBKMsNHQCdSFvNxVcXqO1OFqibBP4Ty3eXdVmNdRpUBsZVBi0iCfqpFQa4AlVDF5
         9R9gwJTRduILIA/PS2MsrohT1Nb8DSQVYIzWy6bJt/nWXElX/C1AVYdjhcPBG3GlfrRg
         QzWLmcCLkaD1L0d2AQ8kPRDCCJ8DOUG2tyIJaERnfVPLgXI/Apjhw5sq5wSrdd8I3Z+3
         STZAONoRaqQueipWw4C12gy2n2EyPoyUkzsYrKlbKeuee2OLORHIAenHUjo1L+0kCCkN
         g+UQ==
X-Gm-Message-State: AOAM532IbY+u13kje4y7uT5WolJsa4XCVdIVPfzW4JxH+6Kph3imW1FX
        oE+j5D5TD5siOGb/6Mc0oTFLdcnH3cmW0bzcfKUjDRfUXWGwNLSjQd9nsNIZ+c6pVLcWCksaQJd
        sIIv0g+xzy8wT
X-Received: by 2002:a17:906:ce25:: with SMTP id sd5mr31414775ejb.398.1634042892309;
        Tue, 12 Oct 2021 05:48:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzt4ERaDuaOp0WSodAqCRB84ZWS5CYlr3SxKZHLOVekfIN4mKBw8+90dBiOjzrjmx0YHgjLHg==
X-Received: by 2002:a17:906:ce25:: with SMTP id sd5mr31414591ejb.398.1634042890550;
        Tue, 12 Oct 2021 05:48:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id x16sm4828581ejj.8.2021.10.12.05.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 05:48:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3A02E180151; Tue, 12 Oct 2021 14:48:09 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Add bitset map with bloom filter
 capabilities
In-Reply-To: <CAEf4BzbWVCz6RNKHVgqLYx8UqGUdDqL5EPKyuQ5YTXZMxt2r_Q@mail.gmail.com>
References: <20211006222103.3631981-1-joannekoong@fb.com>
 <20211006222103.3631981-2-joannekoong@fb.com> <87k0ioncgz.fsf@toke.dk>
 <4536decc-5366-dc07-4923-32f2db948d85@fb.com> <87o87zji2a.fsf@toke.dk>
 <CAEf4BzbqQRzTgPmK3EM0wWw5XrgnenqhhBJdudFjwxLrfPJF8g@mail.gmail.com>
 <87czoejqcv.fsf@toke.dk>
 <CAEf4BzbWVCz6RNKHVgqLYx8UqGUdDqL5EPKyuQ5YTXZMxt2r_Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 12 Oct 2021 14:48:09 +0200
Message-ID: <877deiif3q.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

>>
>> The 'find first set' operation is a single instruction on common
>> architectures, so it's an efficient way of finding the first non-empty
>> bucket if you index them in a bitmap; sch_qfq uses this, for instance.
>
> There is also extremely useful popcnt() instruction, would be great to
> have that as well. There is also fls() (find largest set bit), it is
> used extensively throughout the kernel. If we'd like to take this ad
> absurdum, there are a lot of useful operations defined in
> include/linux/bitops.h and include/linux/bitmap.h, I'm pretty sure one
> can come up with a use case for every one of those.
>
> The question is whether we should bloat the kernel with such
> helpers/operations?

I agree, all of those are interesting bitwise operations that would be
useful to expose to BPF. But if we're not going to "bloat the kernel"
with them, what should we do? Introduce new BPF instructions?

> I'd love to hear specific arguments in favor of dedicated BITSET,
> though.

Mainly the above; given the right instructions, I totally buy your
assertion that one can build a bitmap using regular BPF arrays...

-Toke

