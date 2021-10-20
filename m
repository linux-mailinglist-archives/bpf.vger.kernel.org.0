Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486E4434FF3
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 18:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhJTQSp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 12:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231402AbhJTQSn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Oct 2021 12:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634746586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DB6FNE9518vrXKyk9/xmjFbyTClEQdA5fjKA0BXqbOU=;
        b=fz0/VvXe/nQh5+G66wEJXw7pV1kjs8aZKZaP7Uk1ZxVJoH+6raBBWD0EIZsFuVI6vRfzFN
        F9dQHgjLob2mF0MJMwFUEW0MICuH17NfwmJWJ1//38UNI/zZsbNpT+J0z3iiKygwGIqQID
        Ujyx5FutkmiT1HJj/KqsEpGPYZwynxU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-Mc4PhPhXO9qrUg_CLYZC0w-1; Wed, 20 Oct 2021 12:16:25 -0400
X-MC-Unique: Mc4PhPhXO9qrUg_CLYZC0w-1
Received: by mail-ed1-f70.google.com with SMTP id t18-20020a056402021200b003db9e6b0e57so21491569edv.10
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 09:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DB6FNE9518vrXKyk9/xmjFbyTClEQdA5fjKA0BXqbOU=;
        b=EOZO/tnguwsL6mz5vFVqyR62c8A/XwN26i+FRCbQlVCkeGYISnTArDFpSH7vcqN+5L
         OXsqHeSZg2ft0jKQr3wuRPs/aS/Ut3JdYydoqjTaxsxeCEom+R4YlDkzU2QeCpMCWv+c
         u6Pzrk1lAmzIKw2Xnt0j2JKPczmd0I5qwl0PkDLlN5uZvp1Ex0+Zw3xtJfbmSPfT9xYW
         DeGOJgojPQ0dlPlyFmevsB3i8YE827BToyWq3gb90QTYd1f48cWM5nrWFxoFUsVx5uai
         eM0woB0h1zeFdzug/SV1Nxxls5IaDvkFrJe8mknsHjbtkyVPTsb6fscBnvznkfy6Qs/k
         ug3g==
X-Gm-Message-State: AOAM533dvKp9sQanD77TxglepKsoK3P6bsRt57/rO7+I2gLYPGxXEr/6
        W75AvtWXlXAzO4e5QcxlfOUuWHSf0TvWkR+r5dVkAacF1NcdJ2RETdw1ERkgkYJ8zCom/CqCL0j
        s7dT4++gb6eF/
X-Received: by 2002:a17:907:7752:: with SMTP id kx18mr347275ejc.276.1634746583010;
        Wed, 20 Oct 2021 09:16:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxyQmCf6ySfQkkio7kRxi2QylOtvh+NWOtFaKQ59KcVINsv7754SFz8ClvR/dwt/emOrfu5A==
X-Received: by 2002:a17:907:7752:: with SMTP id kx18mr347035ejc.276.1634746580913;
        Wed, 20 Oct 2021 09:16:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i10sm1474006edl.15.2021.10.20.09.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 09:16:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9D47A180262; Wed, 20 Oct 2021 18:16:19 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenz Bauer <lmb@cloudflare.com>,
        Maxim Mikityanskiy <maximmi@nvidia.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@chromium.org>,
        Joe Stringer <joe@cilium.io>, Tariq Toukan <tariqt@nvidia.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH bpf-next 09/10] bpf: Add a helper to issue timestamp
 cookies in XDP
In-Reply-To: <CACAyw9_MT-+n_b1pLYrU+m6OicgRcndEBiOwb5Kc1w0CANd_9A@mail.gmail.com>
References: <20211019144655.3483197-1-maximmi@nvidia.com>
 <20211019144655.3483197-10-maximmi@nvidia.com>
 <CACAyw9_MT-+n_b1pLYrU+m6OicgRcndEBiOwb5Kc1w0CANd_9A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 20 Oct 2021 18:16:19 +0200
Message-ID: <87y26nekoc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenz Bauer <lmb@cloudflare.com> writes:

>> +bool cookie_init_timestamp_raw(struct tcphdr *th, __be32 *tsval, __be32 *tsecr)
>
> I'm probably missing context, Is there something in this function that
> means you can't implement it in BPF?

I was about to reply with some other comments but upon closer inspection
I ended up at the same conclusion: this helper doesn't seem to be needed
at all?

-Toke

