Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3474A4A83A0
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 13:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbiBCMOe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 07:14:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59300 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235416AbiBCMOd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Feb 2022 07:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643890473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ODOQArJJvYfML0pKRD0g+/Ott6+hxp0VKQUHIOq19B0=;
        b=GfvfUwOCpTqqaIDcozgn5O3m2gNvWNB/5SfSqvzte815fH8yIr8MtRNPQ6pzGDV2vyKMBg
        WNIxK0R2ry3gVcIhgNQRRQ3PhJa2ST9UuESX/eP8zjD+mHZYzvlyZkLYBVCLFqw9fV2yB5
        19OVM8JowdfI9w4+g1UpbeuUk1Hq/gc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-efNTYgKnPRG5rZ4fETo3Ag-1; Thu, 03 Feb 2022 07:14:32 -0500
X-MC-Unique: efNTYgKnPRG5rZ4fETo3Ag-1
Received: by mail-qt1-f198.google.com with SMTP id y22-20020ac87c96000000b002d1bfdbd86dso1712167qtv.20
        for <bpf@vger.kernel.org>; Thu, 03 Feb 2022 04:14:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ODOQArJJvYfML0pKRD0g+/Ott6+hxp0VKQUHIOq19B0=;
        b=Hp/MCX35vjKWF4TqrC1wSqGPegAKP6656kUo4GzkrMv+V8i6cuY73jSlXgA3aBKyyR
         zUc/kbb7Cu0x6sT5pyp+6ddBhuImnhFpQ/J60A+kg6FV2YXJzKJcsn8OaQAoRr/QjLx7
         /vxLjUzJ/FZNH2+LpkU8l3NxpU/LB8odTTctLM40F5pVoxWpDMeD6MVrWeCbr8aOvWVq
         Tjdo1JEDEjmJc777lniIEDp+KPcZM3j+vF/Ea6zebVN4ai7630Dj2OeVxtn1S396dp9F
         EVNSxT9a+ofVOxUj329WGfOsEV+6VYwqz4I3aXjzuHkncSuWi06lskX4NGqbU6gB1tbr
         qG3w==
X-Gm-Message-State: AOAM531LgU4JgNHKtDyY5IraXzQUdNflF8XCk5+FdHGAS+RYkqbkYMPF
        SnOanJ8UxqjcfWtNkozj4PGJo8ky8ZpE6RnZbCZkJRqjLaZczp0MV7XW60I9C+5qD0Tk/qm3oxk
        qc/vnDIukQ95I
X-Received: by 2002:a05:6214:5189:: with SMTP id kl9mr30379812qvb.9.1643890471142;
        Thu, 03 Feb 2022 04:14:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvpa629qj80OU8UG9SO57p7Cq9/hr+NM7WkasmLeij/E+wi2zQVqhlpjDAIKoUxNu4dkHDwQ==
X-Received: by 2002:a05:6214:5189:: with SMTP id kl9mr30379687qvb.9.1643890468898;
        Thu, 03 Feb 2022 04:14:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id j186sm13350515qkb.57.2022.02.03.04.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 04:14:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CFC02180703; Thu,  3 Feb 2022 13:14:26 +0100 (CET)
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
Subject: Re: [PATCH net-next 2/4] net: dev: Remove get_cpu() in
 netif_rx_internal().
In-Reply-To: <20220202122848.647635-3-bigeasy@linutronix.de>
References: <20220202122848.647635-1-bigeasy@linutronix.de>
 <20220202122848.647635-3-bigeasy@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 03 Feb 2022 13:14:26 +0100
Message-ID: <87sft0b10d.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> The get_cpu() usage was added in commit
>     b0e28f1effd1d ("net: netif_rx() must disable preemption")
>
> because ip_dev_loopback_xmit() invoked netif_rx() with enabled preemtion
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
> Remove get_cpu() since the function is supossed to be invoked from
> context with stable per-CPU pointers (either by disabling preemption or
> software interrupts).
>
> Link: https://lkml.kernel.org/r/20100415.013347.98375530.davem@davemloft.=
net
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

