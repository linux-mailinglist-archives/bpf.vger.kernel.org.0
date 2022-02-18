Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD1B4BBEDD
	for <lists+bpf@lfdr.de>; Fri, 18 Feb 2022 18:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbiBRR7Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 12:59:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238884AbiBRR7Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 12:59:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9E1821B2
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 09:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645207145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p5oI/8dNH/4MFIeI5cLeBF2jrxGnWI8Y2my0AXgZ3EQ=;
        b=QMxCJlfbp7qrJ88B0U2M8ucEGSXkrQ07J3HPTvwVG7Qgf6WRifJ2KmWw8nRUovV1LBQUfS
        cD4tmOoxfaIj41ey9ZZLa0ENpZerDV+HaacFXrxnI1QyH26Y9ncLOgdOvS9+Wm/bRo85UX
        1MGkZPcQ6UpZ33mfbei5qUvbS5P7QB8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-0TwMF7ylN5O8rMej6tBWtA-1; Fri, 18 Feb 2022 12:59:04 -0500
X-MC-Unique: 0TwMF7ylN5O8rMej6tBWtA-1
Received: by mail-ed1-f69.google.com with SMTP id m4-20020a50cc04000000b0040edb9d147cso5949539edi.15
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 09:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=p5oI/8dNH/4MFIeI5cLeBF2jrxGnWI8Y2my0AXgZ3EQ=;
        b=dfi7iJf0eM46zNuYMRbrTu5a2j1tKBltKvlB5KHFNlWO2l15U08cTIABuAJ1KmAoiv
         2nyvV++JMX4//XGDju+Az0P4Sdvm21XxM6a1VO7yTxOvWSy/530UjOwalI/ikhsPGBLc
         nVYV4xAx8+ikheYb/6Vlw0d0gMKF3fMo950UJzPjWlbZ7kO1ZqcnoqM/2V2dQ6ng3H6V
         4GZnaQvFDP9jpy27+FOtTRNRiq8L9Qrv/rUFJeYTkqUbmKyAHWBmaOvFdsoIG2SsQjeU
         egSqmoMc3CCuZTnhNb4Au4bTLqVrcZl56/b7Y43zRsfBMC6oKP0qEgWnC5W7yP2ZHy7F
         ljlw==
X-Gm-Message-State: AOAM532pUoZmQn/ugbBQyWK9zBdqJeLJmcOASnMafg/wzwEJ5oYAA7zN
        AQnEi0GHGF06iFoIDVskfqWHCizQxzHQweAANOVNEg/eJ9Zs66oib5elc58a9j2xzxqypMbhBa3
        RW5WjQY6JZuSE
X-Received: by 2002:a17:906:aed4:b0:6ba:6d27:ac7 with SMTP id me20-20020a170906aed400b006ba6d270ac7mr7489002ejb.33.1645207142549;
        Fri, 18 Feb 2022 09:59:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJww0cTfqnVBcid2KvnkIgltIfa8ngQGHX5cBQYZf339vsSNYU9Rk2ynmAwWH2iPxeiWIbVYBw==
X-Received: by 2002:a17:906:aed4:b0:6ba:6d27:ac7 with SMTP id me20-20020a170906aed400b006ba6d270ac7mr7488872ejb.33.1645207140118;
        Fri, 18 Feb 2022 09:59:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h7sm5077174ede.66.2022.02.18.09.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 09:58:59 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EF7B5130248; Fri, 18 Feb 2022 18:58:58 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 0/5] Add support for transmitting packets
 using XDP in bpf_prog_run()
In-Reply-To: <20220218175029.330224-1-toke@redhat.com>
References: <20220218175029.330224-1-toke@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 18 Feb 2022 18:58:58 +0100
Message-ID: <87zgmo12fx.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> A sample traffic generator, which was included in previous versions of
> the series, but now moved to xdp-tools

This is still a bit rough around the edges, but for those interested, it
currently resides here:

https://github.com/xdp-project/xdp-tools/pull/169

-Toke

