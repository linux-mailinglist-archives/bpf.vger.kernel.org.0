Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2A44D6435
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 15:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbiCKPAk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 10:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237094AbiCKPAj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 10:00:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B05D91688C6
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 06:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647010774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3W/IoaQ0z5H2FlrGbqflpFUCLF4DbPLlyyeKMaGHUXY=;
        b=hVeb9Z5Zv03V2klTmPhS9d/KIk9DOU6Sh0DydT2TwAPfUH4I4se1u4TMGWIFch5MZ8oz09
        MGK++D52/9c+Jq4BpMc9zE4u/btEeC5yBrPw231oXOC7OnBlE3l70yMyMc5gcGX0O/ce++
        3MNrrNgGFzX4LBUUUlIC0SRTsnxYKvU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-PG0792wZP36TTiIbRA4fXA-1; Fri, 11 Mar 2022 09:59:33 -0500
X-MC-Unique: PG0792wZP36TTiIbRA4fXA-1
Received: by mail-ed1-f70.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso5014054edh.1
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 06:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3W/IoaQ0z5H2FlrGbqflpFUCLF4DbPLlyyeKMaGHUXY=;
        b=SCH60dWXS9dN0iY2VoAj6M5NTgxaLuWOKDU+UgB7jjsa6s00Iw/4+FZv8wX/cqbVrp
         kE2yyPq9cwynl0tQdCVI2kyW7hnpYJinbgreeY36IizNO0IGXEkIqDf2rPAD/s009gnE
         L3PfYApP/MI/KtQJaTTT2JUid4d7/+QVEo+kruM12ErAgxj9tMjru2aXFb3JLexs4Sar
         dY0jB557q8oqmj5epzaus1qoh20x/Dy9kDP1nfBQbD6mTvWIM/XI8o3xw3aVrIYC/1oo
         bkNuCaNhMTBP3tKYgRBnqwBv/J9bhs/lVVT2GWVscR6V2FJUyrN5gkAxnjQb/ECwyNJ6
         s1mw==
X-Gm-Message-State: AOAM5333sjGWMXMrq9IifiAWN16XaRStPOR5MFZnkRa33x93C396mU1o
        AGVZfL8qv/MyDNRLhWsUNvG31UzGzzHghgAPgl3YZJcHm+A4HzL+dNHxjD6VenccHQ/+7B/rmOX
        xztQCNtk0t7t4
X-Received: by 2002:a17:906:9754:b0:6da:7d72:1353 with SMTP id o20-20020a170906975400b006da7d721353mr8887365ejy.273.1647010768938;
        Fri, 11 Mar 2022 06:59:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7fXe6QQk628+FhGowANMFq1dijH20UyoC49Xg3az5EYhBMrj6bMQHREdwOGK+yoQOK8p1dg==
X-Received: by 2002:a17:906:9754:b0:6da:7d72:1353 with SMTP id o20-20020a170906975400b006da7d721353mr8887172ejy.273.1647010766196;
        Fri, 11 Mar 2022 06:59:26 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ec21-20020a170906b6d500b006d170a3444csm3012478ejb.164.2022.03.11.06.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 06:59:25 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 25B441AB56B; Fri, 11 Mar 2022 15:59:25 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, brouer@redhat.com, pabeni@redhat.com,
        echaudro@redhat.com, lorenzo.bianconi@redhat.com,
        toshiaki.makita1@gmail.com, andrii@kernel.org
Subject: Re: [PATCH v5 bpf-next 2/3] veth: rework veth_xdp_rcv_skb in order
 to accept non-linear skb
In-Reply-To: <8d228b106bc1903571afd1d77e797bffe9a5ea7c.1646989407.git.lorenzo@kernel.org>
References: <cover.1646989407.git.lorenzo@kernel.org>
 <8d228b106bc1903571afd1d77e797bffe9a5ea7c.1646989407.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 11 Mar 2022 15:59:25 +0100
Message-ID: <87y21gwn5e.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Introduce veth_convert_skb_to_xdp_buff routine in order to
> convert a non-linear skb into a xdp buffer. If the received skb
> is cloned or shared, veth_convert_skb_to_xdp_buff will copy it
> in a new skb composed by order-0 pages for the linear and the
> fragmented area. Moreover veth_convert_skb_to_xdp_buff guarantees
> we have enough headroom for xdp.
> This is a preliminary patch to allow attaching xdp programs with frags
> support on veth devices.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

