Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF303BC94F
	for <lists+bpf@lfdr.de>; Tue,  6 Jul 2021 12:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhGFKSR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Jul 2021 06:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231293AbhGFKSQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 6 Jul 2021 06:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625566538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0uXh4hYsW1n5ig7p6gvHrs15tMwDdKovh4TpmR0Nfp8=;
        b=FvL9OoN3kOM9BEA2M7HsF7QOjlplQ2M2PvsMa/CrkKIFESbGLoNlG4t/t6m3vl1+vOkBY+
        p+t4j7z8HFltaGt6H3+DqRQPBGamN24SNl5V85O3KqXcqZxk3IhwW4lj6k4p4ScQw0Oi6z
        xm+CvHNCt3CCOWM8xu+MUZBjc+Og+j4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-565N67SAO1q3DtPgVDgX0g-1; Tue, 06 Jul 2021 06:15:37 -0400
X-MC-Unique: 565N67SAO1q3DtPgVDgX0g-1
Received: by mail-ej1-f71.google.com with SMTP id h14-20020a1709070b0eb02904d7c421e00bso2482004ejl.2
        for <bpf@vger.kernel.org>; Tue, 06 Jul 2021 03:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0uXh4hYsW1n5ig7p6gvHrs15tMwDdKovh4TpmR0Nfp8=;
        b=RTREna4LK8vHrfBb/Ez8sXaqeRohXVX6jAZKyCkjEt/ICyAoppWm7q7E0/nAhFKnfz
         J+8on/+JX1tpcszGy4gH8hESe6magnsuQkTvNugzyaubrzuzXsoVut+OCNskOZFLJHzx
         XtTIBwZ2Yxy9b0cvqXb5Ml1tpE/mJox7IVKTiss1o3N2aKbA68GWOazdULsI4hTxRtrX
         3qFz0JtwSzpMZsE29jmWFqF5iBY8MXIuOSX06v5G0HK20+/KZgZxjiV15hDEMe4xWprf
         SBxUXmUaZMWeEr1vXFBs1j0WD50uDHRT/uJx91cxBBIi7l+Ol9Pg1ypUDiRJWjZGU0+Z
         ZIqA==
X-Gm-Message-State: AOAM533lHGLo3+lArW5lVEjgi8sDgzsvVf6eNjCFX4eS0BERwvUKC4hr
        uA3ArBQ6S0XYLd52Qswpx6BH/rVtItgjdSa91njs1cwMd4d3oixt3A8TSIfn3NDzCm5dRs7Qgn6
        vYFin5t5PQ2Oh
X-Received: by 2002:aa7:ce08:: with SMTP id d8mr21902362edv.341.1625566535997;
        Tue, 06 Jul 2021 03:15:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqNq/L80XyGEn6AXG6CAPDrUV07gdYHjzf/myK8L7dN3swI6frl3kvy56XZXSC1f9dI1l2cA==
X-Received: by 2002:aa7:ce08:: with SMTP id d8mr21902309edv.341.1625566535746;
        Tue, 06 Jul 2021 03:15:35 -0700 (PDT)
Received: from [10.36.112.251] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id q17sm4262297eja.108.2021.07.06.03.15.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jul 2021 03:15:35 -0700 (PDT)
From:   Eelco Chaudron <echaudro@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, lorenzo.bianconi@redhat.com,
        davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, shayagr@amazon.com, sameehj@amazon.com,
        dsahern@kernel.org, brouer@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com
Subject: Re: [PATCH v9 bpf-next 10/14] bpf: add multi-buffer support to xdp copy helpers
Date:   Tue, 06 Jul 2021 12:15:34 +0200
X-Mailer: MailMate (1.14r5819)
Message-ID: <E8662E15-A4FB-4828-830B-3543E9BE8F35@redhat.com>
In-Reply-To: <60d49690a87ae_2e84a2082c@john-XPS-13-9370.notmuch>
References: <cover.1623674025.git.lorenzo@kernel.org>
 <4d2a74f7389eb51e2b43c63df76d9cd76f57384c.1623674025.git.lorenzo@kernel.org>
 <60d27716b5a5a_1342e208d5@john-XPS-13-9370.notmuch>
 <34E2BF41-03E0-4DEC-ABF3-72C8FF7B4E4A@redhat.com>
 <60d49690a87ae_2e84a2082c@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 24 Jun 2021, at 16:28, John Fastabend wrote:

> Eelco Chaudron wrote:
>>
>>
>> On 23 Jun 2021, at 1:49, John Fastabend wrote:
>>
>>> Lorenzo Bianconi wrote:
>>>> From: Eelco Chaudron <echaudro@redhat.com>
>>>>
>>>> This patch adds support for multi-buffer for the following helpers:
>>>>   - bpf_xdp_output()
>>>>   - bpf_perf_event_output()
>>>>
>>>> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
>>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>>> ---
>>>
>>> Ah ok so at least xdp_output will work with all bytes. But this is
>>> getting close to having access into the frags so I think doing
>>> the last bit shouldn't be too hard?
>>
>>
>> Guess you are talking about multi-buffer access in the XDP program?
>>
>> I did suggest an API a while back, https://lore.kernel.org/bpf/FD3E6E0=
8-DE78-4FBA-96F6-646C93E88631@redhat.com/ but I had/have not time to work=
 on it. Guess the difficult part is to convince the verifier to allow the=
 data to be accessed.
>
> Ah great I think we had the same idea I called it xdp_pull_data()
> though.
>
> Whats the complication though it looks like it can be done by simply
> moving the data and data_end pointers around then marking them
> invalidated. This way the verifier knows the program needs to
> rewrite them. I can probably look more into next week.


Sorry for the late response, but I did do a POC a while back with changin=
g the data and data_end pointers, and this worked. The problem that got r=
aised at the time was that it was not hiding the implementation. i.e. you=
 had to put in the fragment number, and so you needed to know how many fr=
agments existed and the size of each one.

With the API suggested in the above email link, I was trying to avoid thi=
s. But it needs a lot of work in the verifier I guess.

> From my first glance it looks relatively straight forward to do
> now. I really would like to avoid yet another iteration of
> programs features I have to discover and somehow work around
> if we can get the helper into this series. If you really don't
> have time I can probably take a look early next week on an
> RFC for something like above helper.

Thanks for looking at it.


Cheers,


Eelco

