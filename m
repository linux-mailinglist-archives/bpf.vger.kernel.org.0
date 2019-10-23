Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 041C0E1BBC
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2019 15:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405550AbfJWNFW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Oct 2019 09:05:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405549AbfJWNFW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Oct 2019 09:05:22 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C0754DB1F
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2019 13:05:21 +0000 (UTC)
Received: by mail-lf1-f72.google.com with SMTP id f3so4108655lfa.16
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2019 06:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ayShX9eSwI2mf/Z2LSvzkLt/5bIb4viERXJyj+kghaQ=;
        b=ZTJSFSCCUQ8d8fFbly+x3rFWWCBkrXwEb/yVKCkAgETNP9/LkB5AY9fzePdOEemPz9
         ZrBb0ufMjAspCWHlSb4MbfiTBeiqTTL22DZut2iAvH6wHxJ85Z/aQIaBL13zihm1tugN
         BypQH4tYtnSzUTjm7lUDzKjuZK9aa6EuWw5n+EIgWpdM800WT7mSF89bcCm6OPBpynZU
         EORkOGYVugxDYpI9n8ZcfksvgxC5h807pI44m47AYKk/NRr1UtCKfAcMRvlkU4RSZXy7
         +K8sKdcS6x8wi1bMKIDQxcec0CfXYIy99wWKcDvfB58mHrgEUCQqVuuppZx/eRQ0t6K3
         pJJg==
X-Gm-Message-State: APjAAAUCbgfNjhqtSPN1zBZ0/nINIQ0BV0quNu3K6IuHcEX7LaliIxda
        TlnUUQkFmc5HToW8GvPkIY9Z4bbaXLzrd7moIqtBu5ozlauu2P+Bhw/oRSJ4bvxoe9Tkdhr5x4j
        zmUm3zqP5IXq+
X-Received: by 2002:ac2:46d8:: with SMTP id p24mr19215841lfo.28.1571835920144;
        Wed, 23 Oct 2019 06:05:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzwZtLPghpRsZMbUAONvnb70ijFg4cju+eSJepEBx9DBET3MVwXX1/NPhUB4xKvuIlos6F1jg==
X-Received: by 2002:ac2:46d8:: with SMTP id p24mr19215817lfo.28.1571835919863;
        Wed, 23 Oct 2019 06:05:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id g21sm18349357lje.67.2019.10.23.06.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 06:05:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5D77A1804B1; Wed, 23 Oct 2019 15:05:18 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] libbpf: Support configurable pinning of maps from BTF annotations
In-Reply-To: <6c0e6ebf-aebc-5e80-0e32-aa81857f3a74@iogearbox.net>
References: <157175668770.112621.17344362302386223623.stgit@toke.dk> <157175668991.112621.14204565208520782920.stgit@toke.dk> <CAEf4BzaM32j4iLhvcuwMS+dPDBd52KwviwJuoAwVVr8EwoRpHA@mail.gmail.com> <875zkgobf3.fsf@toke.dk> <CAEf4BzY-buKFadzzAKpCdjAZ+1_UwSpQobdRH7yQn_fFXQYX0w@mail.gmail.com> <87r233n8pl.fsf@toke.dk> <6c0e6ebf-aebc-5e80-0e32-aa81857f3a74@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 23 Oct 2019 15:05:18 +0200
Message-ID: <87a79rmx2p.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> You are worried about the case where an application should be able to
> unpin the map before loading a new one so it doesn't get reused?

No, I'm worried about the opposite: Someone running (the equivalent of)
'ip link set dev eth0 xdp off', and then wondering why all resources
aren't freed.

I do believe that the common case could be solved by a logic similar to
the one I proposed, though:

>> Hmm, but I guess it could do that anyway; so maybe what we need is just
>> a "try to find all pinned maps of this program" function? That could
>> then to something like:
>> 
>> - Get the maps IDs and names of all maps attached to that program from
>>    the kernel.
>> 
>> - Look for each map name in /sys/fs/bpf
>> 
>> - If a pinned map with the same name exists, compare the IDs, and unlink
>>    if they match
>> 
>> I don't suppose it'll be possible to do all that in a race-free manner,
>> but that would go for any use of unlink() unless I'm missing something?
