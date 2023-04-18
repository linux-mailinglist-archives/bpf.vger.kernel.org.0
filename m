Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368496E5E6F
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 12:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDRKRw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 06:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDRKRv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 06:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A363C12
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 03:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681813022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ApoV6tQ/8bWNgsumqAtwyvPE2nYx/deLF6XAnhG6Ezo=;
        b=KnEh9QNOaFkB0T29JkpbGDUKFLYwA8s7JwMuR2o4cx8V3TOHEx3hvOQjX1cwsUdLX1GFav
        QG0T7Xl/wSvT9vFZ+lJtiI5PGvVK6oSEV5HLAIW9Bvrtwnw/rnEZl1Vd0EAblgwDS/U+mf
        eU3gSltnqBXmYIgCWeUb6S4jVNiRVhA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-zuI5xRlVOhadMQHmXqGEPw-1; Tue, 18 Apr 2023 06:17:01 -0400
X-MC-Unique: zuI5xRlVOhadMQHmXqGEPw-1
Received: by mail-ej1-f72.google.com with SMTP id kr13-20020a1709079a0d00b0093be92e6ff4so10186811ejc.23
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 03:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681813020; x=1684405020;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApoV6tQ/8bWNgsumqAtwyvPE2nYx/deLF6XAnhG6Ezo=;
        b=EVgO2NVWHP2MQpA33hdQsADCu5wQYAh6WxIB6T38p28lLlZ7+xZKKnMpcTFnzUCT9v
         AwOMVYdwJdqS0tIrfcdHuPc7Nmy3NBW8HKDD6Q0qeQ6o0V2xECm+TF+jwry5i2qrg7/e
         4j4c0ddtxZIHoiwzw9PN4lWpeezXeikNQ6zDNs7VFAGXZvb99HzbG5EATnRlEB0MjM4+
         j+zSWheRFWMKPWAOcj3y/8yDgyu2siJ1g6/8GLTFoBzuodSZ/HxOuXe9PZ11Lu+Ez4OJ
         gIZuKsV7Nhbg59wjot7A/SnXRSqylBG3I01mfBtWUuQP3Bq9KqguXGZkc5a3zC9irRjs
         +o6Q==
X-Gm-Message-State: AAQBX9eM9iqNubjbeO2WQ30MV22nwBclXAesIcGEp4uT9Td0KO8jwSKy
        jJpeqBBUS67SWtmzYhpFx058UftLAhfpsGxF/x5QaQnPfTAwEp5iQ9zo/wcb1XjDVfHRiesoU/E
        YfdOyKhH8Pfb6
X-Received: by 2002:a17:907:838d:b0:947:4828:4399 with SMTP id mv13-20020a170907838d00b0094748284399mr7869348ejc.12.1681813020428;
        Tue, 18 Apr 2023 03:17:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350a+9FUztTLaTcXx8PE3l5G/TqPZEC561sVQryR4LTqFxkdQ1s67cLIsu1//A4fVbtZjLVD1Og==
X-Received: by 2002:a17:907:838d:b0:947:4828:4399 with SMTP id mv13-20020a170907838d00b0094748284399mr7869332ejc.12.1681813020026;
        Tue, 18 Apr 2023 03:17:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906715100b0093f822321fesm7835354ejj.137.2023.04.18.03.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 03:16:59 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 99F12AA85EB; Tue, 18 Apr 2023 12:16:58 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kal Cutter Conley <kal.conley@dectris.com>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        =?utf-8?B?QmrDtnJu?= =?utf-8?B?IFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/3] xsk: Support UMEM chunk_size > PAGE_SIZE
In-Reply-To: <CAHApi-=ODe-WtJ=m6bycQhKoQxb+kk2Yk9Fx5SgBsWUuWT_u-A@mail.gmail.com>
References: <20230406130205.49996-1-kal.conley@dectris.com>
 <20230406130205.49996-2-kal.conley@dectris.com> <87sfdckgaa.fsf@toke.dk>
 <ZDBEng1KEEG5lOA6@boxer>
 <CAHApi-nuD7iSY7fGPeMYiNf8YX3dG27tJx1=n8b_i=ZQdZGZbw@mail.gmail.com>
 <875ya12phx.fsf@toke.dk>
 <CAHApi-=rMHt7uR8Sw1Vw+MHDrtkyt=jSvTvwz8XKV7SEb01CmQ@mail.gmail.com>
 <87ile011kz.fsf@toke.dk>
 <CAHApi-=ODe-WtJ=m6bycQhKoQxb+kk2Yk9Fx5SgBsWUuWT_u-A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 18 Apr 2023 12:16:58 +0200
Message-ID: <874jpdwl45.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kal Cutter Conley <kal.conley@dectris.com> writes:

>> In addition, presumably when using this mode, the other XDP actions
>> (XDP_PASS, XDP_REDIRECT to other targets) would stop working unless we
>> add special handling for that in the kernel? We'll definitely need to
>> handle that somehow...
>
> I am not familiar with all the details here. Do you know a reason why
> these cases would stop working / why special handling would be needed?
> For example, if I have a UMEM that uses hugepages and XDP_PASS is
> returned, then the data is just copied into an SKB right? SKBs can
> also be created directly from hugepages AFAIK. So I don't understand
> what the issue would be. Can someone explain this concern?

Well, I was asking :) It may well be that the SKB path just works; did
you test this? Pretty sure XDP_REDIRECT to another device won't, though?

-Toke

