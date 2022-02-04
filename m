Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0B84AA494
	for <lists+bpf@lfdr.de>; Sat,  5 Feb 2022 00:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241617AbiBDXoe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 18:44:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240954AbiBDXoe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 18:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644018273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OG4d2yofZLex3o/TeM8Xf3ERpfuxuz16MfpWbW0GXSU=;
        b=gXCHxfASxE3Xb3jES8N2q7fj7b4M90QgIjm7SwjHUXNpKtE5Q4WJomF4D1yXsJTthun8CL
        DdfSKKmVymeLpaBrPjFrRCBUAwhP8xlVImbiQsXC/8gEzxTUl/h5XZrX+GrpcJKfb1jghU
        KITvBZrUdDYDZM2hlNlXGtiSp6oYGyw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-plaPgzt4M7C3fa4zLTa5zg-1; Fri, 04 Feb 2022 18:44:32 -0500
X-MC-Unique: plaPgzt4M7C3fa4zLTa5zg-1
Received: by mail-qt1-f199.google.com with SMTP id s1-20020ac85ec1000000b002cf7c93d56dso5815122qtx.21
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 15:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=OG4d2yofZLex3o/TeM8Xf3ERpfuxuz16MfpWbW0GXSU=;
        b=1yBZJrhsxs/aUSyM94DgfLbvgm6Di6RIz1gx2pH1ZEv4JTFe1Jphaz9ZM6+ni+V3jk
         9Po9I8osL+JQFQLvfmY6JsQaBhNhCTPWGUdw/1jGPQy5s+OVtkdxBtP9/lxMzQ78UmnA
         K49Lj4JYFuGVF5zZNzByaouCOlRW0y83cswy9zoFMu91meRYBUcZ/ZVmBMjCnfl37f7m
         tnBgqKBnx90tEcQhPfQg1ry4gKo3tOIzBgz9A6cp8oKeRJnMzJokA3aFOoofcHMvNgrz
         6g4sD8RHZnjJpGwMMYDULvw8+VmRpoSWmcUXzNhptQbKy+hQyyrPat4maOyhsDXBGefN
         oRfQ==
X-Gm-Message-State: AOAM533lxFGLzxMa1NhZkmYm7Op7YZmhpH4vacuBnWoq1JbL++xEuUvR
        cG9owZ9QuoeYZNB3KKlZaYXSxTFw2N8vtE6bUxYni7hTmAdTzy+pwpw9brGo5xeKLRY/k/PJC4R
        izjTpL1JwGyx3
X-Received: by 2002:a05:620a:2546:: with SMTP id s6mr819115qko.587.1644018271305;
        Fri, 04 Feb 2022 15:44:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzbXyZBjD/qSWRhtQRyOpp0HB9Uki8PNS9GPCVgMIYS3jwxv33tskEa0CcyGYgS2OEfhT8GUA==
X-Received: by 2002:a05:620a:2546:: with SMTP id s6mr819087qko.587.1644018270042;
        Fri, 04 Feb 2022 15:44:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 134sm1626369qkl.50.2022.02.04.15.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:44:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F1BEF101B7B; Sat,  5 Feb 2022 00:44:27 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH net-next v2 1/3] net: dev: Remove preempt_disable() and
 get_cpu() in netif_rx_internal().
In-Reply-To: <20220204201259.1095226-2-bigeasy@linutronix.de>
References: <20220204201259.1095226-1-bigeasy@linutronix.de>
 <20220204201259.1095226-2-bigeasy@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 05 Feb 2022 00:44:27 +0100
Message-ID: <87bkzmb3j8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> The preempt_disable() () section was introduced in commit
>     cece1945bffcf ("net: disable preemption before call smp_processor_id(=
)")
>
> and adds it in case this function is invoked from preemtible context and
> because get_cpu() later on as been added.
>
> The get_cpu() usage was added in commit
>     b0e28f1effd1d ("net: netif_rx() must disable preemption")
>
> because ip_dev_loopback_xmit() invoked netif_rx() with enabled preemption
> causing a warning in smp_processor_id(). The function netif_rx() should
> only be invoked from an interrupt context which implies disabled
> preemption. The commit
>    e30b38c298b55 ("ip: Fix ip_dev_loopback_xmit()")
>
> was addressing this and replaced netif_rx() with in netif_rx_ni() in
> ip_dev_loopback_xmit().
>
> Based on the discussion on the list, the former patch (b0e28f1effd1d)
> should not have been applied only the latter (e30b38c298b55).
>
> Remove get_cpu() and preempt_disable() since the function is supposed to
> be invoked from context with stable per-CPU pointers. Bottom halves have
> to be disabled at this point because the function may raise softirqs
> which need to be processed.
>
> Link: https://lkml.kernel.org/r/20100415.013347.98375530.davem@davemloft.=
net
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

