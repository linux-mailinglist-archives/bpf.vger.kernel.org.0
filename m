Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1207F32EC81
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 14:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCENuw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 08:50:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24171 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230143AbhCENuh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Mar 2021 08:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614952237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hSb8Vt0yPzgXokYu7fBUtDV5WT7uNZ2ZQjhplLhog50=;
        b=Cuvc11dD5QF/sv995HpNPuvu2vekTsEPRMocIz8tn/HU5MdL+9S3gwXMvPN1j339wrjv2v
        vVOUGGdCogNul+lmMDtSdfrLikrK4aqfcSVamESIrqt3jlwbG+OZR4U9A4QRn2Bp2evi9u
        2WrNMyCrMXBWqO/4Sy6LfY99Q0/86fg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-ed7HK5imOX2Kq6OlH_bGnQ-1; Fri, 05 Mar 2021 08:50:35 -0500
X-MC-Unique: ed7HK5imOX2Kq6OlH_bGnQ-1
Received: by mail-ej1-f69.google.com with SMTP id k16so860591ejg.9
        for <bpf@vger.kernel.org>; Fri, 05 Mar 2021 05:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hSb8Vt0yPzgXokYu7fBUtDV5WT7uNZ2ZQjhplLhog50=;
        b=nWgMe30Zf1RiIBsjm6mqJUfw0nHmW9dKUc74wQLMMEYd8iL83mLnPJV7bMgX6XTCZ6
         ctHDCRccSjo7AtNoNQODawF+owFr9AVIDPIebQlggbBXxnCkhbbFyKOfQE0I+l6FCkSG
         BQGWQj7CkmGW+m8ofY7tcxT6RdniRae9mHQYqJrXJICgsACo/e2IlsbdGhtj/PPiXUv9
         Ehy5Lg+weR+7ph04jnhvpu6Y193zzvLPfsBLJFvFjixGnIh2xHsUSx8rs7wl8uV90Yj9
         t5w4uT3JUTtgDWrEz0Z3cdMgqf/MMcFpgNYr9JHmxAgQcFQB8XIHO2Xxrk6/1S+h6GsC
         +nnQ==
X-Gm-Message-State: AOAM532RXevV0i7Kuu5N9PQqvCMd0r+ltcbNleK01e7Yhq+N92XhRaIF
        c+EZMr4u8GqA+9R1ijEflbXsrr2oRxYVkzUTbgBjFn/4+CpXG7QuHdWjeGlI4BiuIJ8lDwZQIZ/
        tpt92/RGT9uXG
X-Received: by 2002:a17:906:8546:: with SMTP id h6mr2225055ejy.23.1614952234403;
        Fri, 05 Mar 2021 05:50:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwBxh+bg0gxcGMJxA0QfhO32LkB6JChHHXVX5wkLPKRak0oDPOrZ/mKOeHJcmpm3qGJj/dL3Q==
X-Received: by 2002:a17:906:8546:: with SMTP id h6mr2225039ejy.23.1614952234222;
        Fri, 05 Mar 2021 05:50:34 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id n5sm1652302edw.7.2021.03.05.05.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 05:50:33 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AE4C8180248; Fri,  5 Mar 2021 14:50:31 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        bjorn.topel@intel.com, magnus.karlsson@intel.com,
        jonathan.lemon@gmail.com, maximmi@nvidia.com, andrii@kernel.org,
        will@kernel.org, paulmck@kernel.org, stern@rowland.harvard.edu
Subject: Re: [PATCH bpf-next v2 0/2] load-acquire/store-release barriers for
 AF_XDP rings
In-Reply-To: <20210305094113.413544-1-bjorn.topel@gmail.com>
References: <20210305094113.413544-1-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 05 Mar 2021 14:50:31 +0100
Message-ID: <87y2f1u2u0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> This two-patch series introduces load-acquire/store-release barriers
> for the AF_XDP rings.
>
> For most contemporary architectures, this is more effective than a
> SPSC ring based on smp_{r,w,}mb() barriers. More importantly,
> load-acquire/store-release semantics make the ring code easier to
> follow.
>
> This is effectively the change done in commit 6c43c091bdc5
> ("documentation: Update circular buffer for
> load-acquire/store-release"), but for the AF_XDP rings.
>
> Both libbpf and the kernel-side are updated.
>
> Full details are outlined in the commits!
>
> Thanks to the LKMM-folks (Paul/Alan/Will) for helping me out in this
> complicated matter!
>
> @Andrii I kept the barriers in libbpf_util.h to separate userfacing
>         APIs (xsk.h) from internals.
>
> @Toke I kept "barriers" but reworded. Acquire/release are also
>       barriers.

Right, that text is better - thanks!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

