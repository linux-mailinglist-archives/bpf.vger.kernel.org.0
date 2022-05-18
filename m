Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD4552C4BB
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 22:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242758AbiERUm6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 16:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242709AbiERUm4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 16:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5346B7093D
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 13:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652906570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eci3SfR9YUT02jjJEGOCrPhcn1ykfe0qhbLzqAWYbYc=;
        b=KNaHikTWCbxIknN0FfiyQAC+RmST6Grs5izbXlQWIis9gsnp/EkwhvEvjC7yqkNwfeH8gt
        AHmz+uNtJsswb5gJMlbk1zM0s7Otjvr5Y0kVYptC1BQNNYz+gaVMLDvCAZNmHErLS2sKS+
        9sHcvNhGisJAJRAGhdsUK7+rVEm8CfA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-d-zFGujSOSeSFoDqdFSbSQ-1; Wed, 18 May 2022 16:42:45 -0400
X-MC-Unique: d-zFGujSOSeSFoDqdFSbSQ-1
Received: by mail-ej1-f71.google.com with SMTP id v13-20020a170906b00d00b006f51e289f7cso1489994ejy.19
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 13:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Eci3SfR9YUT02jjJEGOCrPhcn1ykfe0qhbLzqAWYbYc=;
        b=ujN+rx169fNaOVFLPg6VCkHScQh92GTODcRsMcLl+jofD142M8mEEVT2yupfoRtV0x
         TZigbAlM48rjPFpsotiFvOttkNk/o6NngYkEXhu7GpWOwtzz89r9/hVLD3AXEOQH2rYz
         ZZ1C1cj121zwkDC0ah2CgZRP0KSTtCG9r6RzD8AK2UAJXzL0hJRq7CxOKVAuXdlS/2Vb
         ELM034BYCD0SosGJGJ/OP0HCt7Xs/C+8yg4C+5d/XA0pY4WJIP4QeYVozJ6EOvW5cPZf
         /9Iwx7HiTwNScqUqJ0NH4GBnnMDcjhLxykOiReFeLhnnECsge+nEyllwyCr90popY3zA
         oy1Q==
X-Gm-Message-State: AOAM531SocwLVSa8bIq4sPFXqWxzG5aRp5RpGSMw4ayGfnzo6Cyz8A5d
        9ape/IZy7kVqqgVycGASbK2++7aQqsOwFpOR4t7EPPeghVdgb/KVsR9up7LPWQpiT+j23uCuTNo
        +79z5yzqJEZ3U
X-Received: by 2002:aa7:d4c8:0:b0:42a:a406:a702 with SMTP id t8-20020aa7d4c8000000b0042aa406a702mr1680063edr.129.1652906564010;
        Wed, 18 May 2022 13:42:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaqWlxarRMeh6CgpYv/fRqcKPVWXuO9Nbg7+k5CvmvDj/SuWDwKuUZSM9e5xnDaJyqDSUDhQ==
X-Received: by 2002:aa7:d4c8:0:b0:42a:a406:a702 with SMTP id t8-20020aa7d4c8000000b0042aa406a702mr1680003edr.129.1652906563243;
        Wed, 18 May 2022 13:42:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a2-20020aa7d742000000b0042617ba638esm1840273eds.24.2022.05.18.13.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:42:42 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DA44A38ECC3; Wed, 18 May 2022 22:42:41 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, pablo@netfilter.org,
        fw@strlen.de, netfilter-devel@vger.kernel.org,
        lorenzo.bianconi@redhat.com, brouer@redhat.com, memxor@gmail.com
Subject: Re: [PATCH v3 bpf-next 3/5] net: netfilter: add kfunc helper to
 update ct timeout
In-Reply-To: <9651ce53e74ce0d0b200fe9d40875e5119ba6c94.1652870182.git.lorenzo@kernel.org>
References: <cover.1652870182.git.lorenzo@kernel.org>
 <9651ce53e74ce0d0b200fe9d40875e5119ba6c94.1652870182.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 18 May 2022 22:42:41 +0200
Message-ID: <871qwqa7y6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Introduce bpf_ct_refresh_timeout kfunc helper in order to update
> nf_conn lifetime. Move timeout update logic in nf_ct_refresh_timeout
> utility routine.
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

