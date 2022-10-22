Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347236082C7
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 02:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJVARa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 20:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJVAR3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 20:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6033D48A0D
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 17:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666397847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ffLPQLNndW2qNqcG85lW2feB+QGegvpDWXA/1PXL/o8=;
        b=WR1X9Vj0MxZft0qVNWf2mDA+Ili+XUzJUevdUOs8kV2uCnOoJu4DrFHouMUYG27dDTVDe0
        k7t2un6ogUuOApjq706mraKei5/Xlqs8lDxrE4gvpjDsXzbpixwi9zcMF5MQGvmuXQYHly
        gZ99rHsteA9USEAKr0TWyi8uouENGuA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-632-oFZoF8H4OGu82VUTIkF8BA-1; Fri, 21 Oct 2022 20:17:25 -0400
X-MC-Unique: oFZoF8H4OGu82VUTIkF8BA-1
Received: by mail-ed1-f69.google.com with SMTP id e16-20020a056402191000b0045d9775d0f4so4155295edz.16
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 17:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffLPQLNndW2qNqcG85lW2feB+QGegvpDWXA/1PXL/o8=;
        b=sbrEyVIly1R3FhJsH+IYJ2+iZdeZyOkxdhM19AVyYKRNiqzX3tMRxQKUAa6HE8ImpI
         vn/vn16ubKnv44QmuW3Ui3AViIu6QZHU5jznEHm6JIwN3a2Qsq7UzqM7vJo+/6AQjLfM
         twCgVkSXK3f39idqVivh+WDSLpE35D5InzRfoSz1FOFTESVlz2zvTPsg6hnqeAMT13aS
         DkTze7yUqsEkVskexCKpVE6OmgJjnzONuYGmWn/T+f6Q3zg6hQ6TwrSYq8oq5v12CaWf
         JDhiXv4GhucbkzXHJ9Er15+OIOdJFBgiVrudKFPO3qSnTHNCNT25v5flhd8KVNxxYGgR
         lWeQ==
X-Gm-Message-State: ACrzQf2N+jp055bgLX8vCm7r5pTDxfzWs+AbEYWNLHOqQ1j173KBtOXf
        7WugHYxCn8l098ZGrbqogNHOeO9HG08h/5I+Guie52OqzaDkYGopegLswtrWGoO1vlbeZHD29hG
        b0eIvORIfF4wk
X-Received: by 2002:a05:6402:280a:b0:45d:19e8:c7ad with SMTP id h10-20020a056402280a00b0045d19e8c7admr19320284ede.44.1666397844055;
        Fri, 21 Oct 2022 17:17:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7RkKTesKjUts48gOVA6eAd7VenRhjjBJPu5k58JMgOB9rIwxtj/GLog2O5gHtldiRolHFfBA==
X-Received: by 2002:a05:6402:280a:b0:45d:19e8:c7ad with SMTP id h10-20020a056402280a00b0045d19e8c7admr19320251ede.44.1666397843182;
        Fri, 21 Oct 2022 17:17:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906200100b007a03313a78esm329655ejo.20.2022.10.21.17.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 17:17:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1F72B6EE715; Sat, 22 Oct 2022 02:17:22 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     mtahhan@redhat.com, bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Maryam Tahhan <mtahhan@redhat.com>
Subject: Re: [PATCH bpf-next v4 1/1] doc: DEVMAPs and XDP_REDIRECT
In-Reply-To: <20221021165919.509652-2-mtahhan@redhat.com>
References: <20221021165919.509652-1-mtahhan@redhat.com>
 <20221021165919.509652-2-mtahhan@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 22 Oct 2022 02:17:22 +0200
Message-ID: <877d0su2y5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

mtahhan@redhat.com writes:

> From: Maryam Tahhan <mtahhan@redhat.com>
>
> Add documentation for BPF_MAP_TYPE_DEVMAP and
> BPF_MAP_TYPE_DEVMAP_HASH including kernel version
> introduced, usage and examples.
>
> Add documentation that describes XDP_REDIRECT.
>
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>

With one small nit below:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

[...]

> +The following code snippet shows a BPF program that is broadcasting pack=
ets to
> +all the interfaces in the ``tx_port`` devmap.
> +
> +.. code-block:: c
> +
> +    SEC("xdp")
> +    int xdp_redirect_map_func(struct xdp_md *ctx)
> +    {
> +        int index =3D ctx->ingress_ifindex;

Let's get rid of this index variable (it's not used).

> +        return bpf_redirect_map(&tx_port, 0, BPF_F_BROADCAST | BPF_F_EXC=
LUDE_INGRESS);
> +    }


-Toke

