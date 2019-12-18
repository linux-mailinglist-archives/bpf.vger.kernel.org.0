Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A04D1124598
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2019 12:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLRLTx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Dec 2019 06:19:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58368 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726682AbfLRLTx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Dec 2019 06:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576667992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tGaENIXVL4R5jkagyaHEkiUhgqCbNBAQnfNq8HfjrSk=;
        b=cN0F6XqzwHvVhqR91nboyNnohrPq1ABhvKRtoGi97SYnQ4aKu/GUxRzzJO8ryeJLSreDfN
        nZFmUQSa1nDFxS1g7EiDimxS/tm2kMAXBqjAZO3IdpP/nXhh14ZWrkigP+idHPtOJDiO/Y
        S6P91gy3FNeh2h6qFBBdmKC7aeBSv0c=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-3N25i2SdOY6pWt45gkeVNQ-1; Wed, 18 Dec 2019 06:19:51 -0500
X-MC-Unique: 3N25i2SdOY6pWt45gkeVNQ-1
Received: by mail-lj1-f199.google.com with SMTP id u9so584752ljg.12
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 03:19:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=tGaENIXVL4R5jkagyaHEkiUhgqCbNBAQnfNq8HfjrSk=;
        b=hHR//ymk+4bGwIyB8Du3GeU/3LtU83rc1RBDpWiwRbN7qO7wxnsMWduc95GY3zuodF
         WXw3Szztu3ZvVmBQr+fDpI7ZM2MQ4u1ejQuzklaxF2vvKc0+R+swVt1TVQ9gDv/PmWNT
         G/pT6jbvzDmNvUXwiuHy76J3PZ6QhLwaZgrTq4zePKG7RJ9XQ6uQMyZNki7AG70/sxMe
         W9Qzq53ZMxBBpugcHqiosS5xFRC+uiP8vrGVJ3mNT8idO7k1lqmHy4R1dC/yX66dKNiR
         2e4Es/UcRCerg/NNU0kMCE9h8U8OGM31l7HkAWxOZw1qXwd2QReR/WWAT26OGZUz21Ct
         Tg5w==
X-Gm-Message-State: APjAAAVcKvOYMwB1Wz42A14LYyaou3HCL4W+DyaDVDj9uEhn9p+j/JBW
        ExFDiu1vt3fWXxABOW5m4RTWdi8XjrQlOXBHExxnT9oNqjUK+wo2Vm7Cea8ESjfbkzmOrJuk424
        O9qwUbLrsil9D
X-Received: by 2002:a2e:90da:: with SMTP id o26mr1337951ljg.25.1576667990213;
        Wed, 18 Dec 2019 03:19:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqxSjOukFg+meWtIM98dabrAAHbQKcIr84NUTloWwJlMSxMnFMKgCYamMRQpHy8VhsK4mKNHxw==
X-Received: by 2002:a2e:90da:: with SMTP id o26mr1337946ljg.25.1576667990095;
        Wed, 18 Dec 2019 03:19:50 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z7sm967741lji.30.2019.12.18.03.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:19:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F2EC5180969; Wed, 18 Dec 2019 12:19:48 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, davem@davemloft.net,
        jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, magnus.karlsson@intel.com,
        jonathan.lemon@gmail.com
Subject: Re: [PATCH bpf-next 5/8] xdp: make devmap flush_list common for all map instances
In-Reply-To: <20191218105400.2895-6-bjorn.topel@gmail.com>
References: <20191218105400.2895-1-bjorn.topel@gmail.com> <20191218105400.2895-6-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 18 Dec 2019 12:19:48 +0100
Message-ID: <87r2116fu3.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>
> The devmap flush list is used to track entries that need to flushed
> from via the xdp_do_flush_map() function. This list used to be
> per-map, but there is really no reason for that. Instead make the
> flush list global for all devmaps, which simplifies __dev_map_flush()
> and dev_map_init_map().
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

