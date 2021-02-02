Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9828830BDB0
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 13:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhBBMHU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 07:07:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36110 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230139AbhBBMHG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Feb 2021 07:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612267539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mehHJF+/Hp3KHLeMA4Z0N4YM6ZtdnidDiwvZxW1mKcE=;
        b=LQ0dQTWzkvEjdSAZP31MoZszEgfvF9aZygIYQpF8bwUAOJKCstK61K+4j+jRxYfNRpqwll
        K0/+xyMeR5UdW+h7j9DHnOd+sxejCRPNaUF0yBlE0/v9sYzqEgk0w74q5LU4EN5+TmcpkB
        0CPa+5aSUWScsT+LlK6wXdRR1j9yirc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277--qvV3jeqN5uPlVvBHvEBhw-1; Tue, 02 Feb 2021 07:05:37 -0500
X-MC-Unique: -qvV3jeqN5uPlVvBHvEBhw-1
Received: by mail-ed1-f69.google.com with SMTP id g6so1635235edy.9
        for <bpf@vger.kernel.org>; Tue, 02 Feb 2021 04:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mehHJF+/Hp3KHLeMA4Z0N4YM6ZtdnidDiwvZxW1mKcE=;
        b=BuXw8Zb3QdgVH8VvWKFDBI9GBFVl0muiJFJFT2lyGl1YLY2/VneK/PFRuQ5hR/bbcD
         c/GNyyLDKSAiI81aJN+m8P5sKqt6ULMl95tWZpK+CEl1yyBPj9xmm++YxQ0V3pZ5lPJF
         QR3N0Zmwzc2PhsLJmrxjdP1n5w6BCOsJXSbRpkr9OzDXf7Bic3Zi6JtbzgIkum+cFI68
         ZRyYhFEBw8cfm/6BAZvmcSRBqd3NNyMp6bfiuIvjXpafIhTGQqC4m3lWu2a2XAXvhaVR
         DR89+KL4GMnfPZUQzD3ZzIYvqZa2hyLrb5HllrrjjMA15rAWCVOwKmcrZ9OuC95Fgo6C
         g6PA==
X-Gm-Message-State: AOAM531zJ1JYWGH7BhHY79aW4ON8FyR8Y3UrpGgjkkZ4IVOeBSc/6VcZ
        /WJwu6RaLYlEkr/lBf1TgaIZA0KTlpu4qggNyqzRdcZRYkUFizz2NzLUm6aVvdzbvgTpMZ7HK4D
        wW1kHN5ZhSiQU
X-Received: by 2002:aa7:de19:: with SMTP id h25mr11597075edv.145.1612267536057;
        Tue, 02 Feb 2021 04:05:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+EBuBoDLfhwAot1dUjDT+O5gyu5qLkpgYj7zLuuSfOh78WjxxwcsOLudJAXo9hfBpiNAvzA==
X-Received: by 2002:aa7:de19:: with SMTP id h25mr11597042edv.145.1612267535765;
        Tue, 02 Feb 2021 04:05:35 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id m20sm10416216edj.43.2021.02.02.04.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 04:05:35 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9FBC8180367; Tue,  2 Feb 2021 13:05:34 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Marek Majtyka <alardam@gmail.com>
Cc:     Saeed Mahameed <saeed@kernel.org>, David Ahern <dsahern@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Maciej Fijalkowski <maciejromanfijalkowski@gmail.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, hawk@kernel.org,
        bpf <bpf@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        jeffrey.t.kirsher@intel.com
Subject: Re: [PATCH v2 bpf 1/5] net: ethtool: add xdp properties flag set
In-Reply-To: <CAAOQfrHA+-BsikeQzXYcK_32BZMbm54x5p5YhAiBj==uaZvG1w@mail.gmail.com>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204102901.109709-2-marekx.majtyka@intel.com>
 <878sad933c.fsf@toke.dk> <20201204124618.GA23696@ranger.igk.intel.com>
 <048bd986-2e05-ee5b-2c03-cd8c473f6636@iogearbox.net>
 <20201207135433.41172202@carbon>
 <5fce960682c41_5a96208e4@john-XPS-13-9370.notmuch>
 <20201207230755.GB27205@ranger.igk.intel.com>
 <5fd068c75b92d_50ce20814@john-XPS-13-9370.notmuch>
 <20201209095454.GA36812@ranger.igk.intel.com>
 <20201209125223.49096d50@carbon>
 <e1573338-17c0-48f4-b4cd-28eeb7ce699a@gmail.com>
 <1e5e044c8382a68a8a547a1892b48fb21d53dbb9.camel@kernel.org>
 <cb6b6f50-7cf1-6519-a87a-6b0750c24029@gmail.com>
 <f4eb614ac91ee7623d13ea77ff3c005f678c512b.camel@kernel.org>
 <d5be0627-6a11-9c1f-8507-cc1a1421dade@gmail.com>
 <6f8c23d4ac60525830399754b4891c12943b63ac.camel@kernel.org>
 <CAAOQfrHN1-oHmbOksDv-BKWv4gDF2zHZ5dTew6R_QTh6s_1abg@mail.gmail.com>
 <87h7mvsr0e.fsf@toke.dk>
 <CAAOQfrHA+-BsikeQzXYcK_32BZMbm54x5p5YhAiBj==uaZvG1w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 02 Feb 2021 13:05:34 +0100
Message-ID: <87bld2smi9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Marek Majtyka <alardam@gmail.com> writes:

> Thanks Toke,
>
> In fact, I was waiting for a single confirmation, disagreement or
> comment. I have it now. As there are no more comments, I am getting
> down to work right away.

Awesome! And sorry for not replying straight away - I hate it when I
send out something myself and receive no replies, so I suppose I should
get better at not doing that myself :)

As for the inclusion of the XDP_BASE / XDP_LIMITED_BASE sets (which I
just realised I didn't reply to), I am fine with defining XDP_BASE as a
shortcut for TX/ABORTED/PASS/DROP, but think we should skip
XDP_LIMITED_BASE and instead require all new drivers to implement the
full XDP_BASE set straight away. As long as we're talking about
features *implemented* by the driver, at least; i.e., it should still be
possible to *deactivate* XDP_TX if you don't want to use the HW
resources, but I don't think there's much benefit from defining the
LIMITED_BASE set as a shortcut for this mode...

-Toke

