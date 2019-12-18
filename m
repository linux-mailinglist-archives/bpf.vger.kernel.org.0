Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8330124572
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2019 12:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLRLPG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Dec 2019 06:15:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29348 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbfLRLPF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Dec 2019 06:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576667704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pDExBp6N2KqojXTPG0+Gp10QLUPfm8Ox8GErnJhVPNw=;
        b=dyTi0AuSjzT6vtq3Kqv1z6UdnaCbfIcD/dBItwf6GYYniZIozimdOx5QF0iHuzOoA7oYcd
        Ajs/IlNcfGhVFTr5hcfuZ2i+iiw0ne65+uDLDV8qSR2Oh1fMeKF+ywGjKxdkZYW0+UP4pL
        k0dJjK9Jbb92/699rsuWwLzp21252ss=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-A075LGZsPKGwkn3oIOclLQ-1; Wed, 18 Dec 2019 06:15:02 -0500
X-MC-Unique: A075LGZsPKGwkn3oIOclLQ-1
Received: by mail-lf1-f71.google.com with SMTP id l2so184114lfk.23
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 03:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=pDExBp6N2KqojXTPG0+Gp10QLUPfm8Ox8GErnJhVPNw=;
        b=Cng4/f5E4QEmodMBiAylva5DFtXZ5jXymoTz5tUBRFg9ZyC2npgfo0lnORXjwIuMot
         qsYFy/eW/afTRuZ7BAlqAzrILXml/qUlRcKSGyi2CGZ15I89NJprVzajkwzYxDWKfFa3
         Ap7wdUDOxcyo4Dp4Y5oAM5pux77wzTiK7W/zFN/ZqKsCoFqh2fz8GFx64yYtDYLT/lxo
         YajWt9ZFUtf5Zz7jyafC2ax//yhRmDrWOckyLGQAoKw+8dbW5AW7PFqGycJLj3C7+AmN
         gca6P/PwS5xC7ybVc8TTjX4ccKKSduphMSfTdoPrARCa55g+zHloOtQMX9va7Z8ZH87l
         4jQw==
X-Gm-Message-State: APjAAAWe3R3BlFAaWqjNfH8RkSUI5bE5wRo/44LHuQQzcB2SX705YuSP
        KFiy8l6RDleO7FdptCk4dktOuN0rA9ptIzIvkl3YJg4dBlrbM5xk28ZkPhjv585sMlAJsQalEjQ
        cDg8hoF+/+ZRf
X-Received: by 2002:a2e:a408:: with SMTP id p8mr1299971ljn.145.1576667701609;
        Wed, 18 Dec 2019 03:15:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxu/QsFi5ppTKWgJ/GsTNk/uvuIeU95JnusduZ6XHkMbBeYOQHZNK5HbKXRf+fHg9S9LJb4BA==
X-Received: by 2002:a2e:a408:: with SMTP id p8mr1299950ljn.145.1576667701304;
        Wed, 18 Dec 2019 03:15:01 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q186sm978511ljq.14.2019.12.18.03.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:15:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 70216180969; Wed, 18 Dec 2019 12:14:59 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, davem@davemloft.net,
        jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, magnus.karlsson@intel.com,
        jonathan.lemon@gmail.com
Subject: Re: [PATCH bpf-next 1/8] xdp: simplify devmap cleanup
In-Reply-To: <20191218105400.2895-2-bjorn.topel@gmail.com>
References: <20191218105400.2895-1-bjorn.topel@gmail.com> <20191218105400.2895-2-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 18 Dec 2019 12:14:59 +0100
Message-ID: <8736dh7umk.fsf@toke.dk>
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
> After the RCU flavor consolidation [1], call_rcu() and
> synchronize_rcu() waits for preempt-disable regions (NAPI) in addition
> to the read-side critical sections. As a result of this, the cleanup
> code in devmap can be simplified
>
> * There is no longer a need to flush in __dev_map_entry_free, since we
>   know that this has been done when the call_rcu() callback is
>   triggered.
>
> * When freeing the map, there is no need to explicitly wait for a
>   flush. It's guaranteed to be done after the synchronize_rcu() call
>   in dev_map_free(). The rcu_barrier() is still needed, so that the
>   map is not freed prior the elements.
>
> [1] https://lwn.net/Articles/777036/
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

