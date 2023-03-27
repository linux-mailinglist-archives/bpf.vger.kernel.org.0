Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552D56CB225
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 01:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjC0XNl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 19:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0XNk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 19:13:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7823F2128
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 16:13:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b20so42675502edd.1
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 16:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679958817;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h1dER13/YUlRBmS9Zphnih9CPMbd0uRZSGTFZYQnlH4=;
        b=jDy/tRXaCTvWa50Q2AJZaK7f5MLFcjmQ6j47qGlDQtJt9hVJRZ6V+WwrQd5W302GeT
         /NFGm6ujIYvAo1dvQ9F1LYv7z3LZ2sBcy8whJ2H2Njm07S0RqTGp0ixVXzjaLBFwcRFy
         Pgym+nu7FLeAOayunzAOy6DTAn2GVoKbzlQXh5fpaMUUT8vVU5y2ifkTFxf1pRLRsa5G
         T+EBiNwu1/t2IH6ZYQ8Fudmj5rx0P+biLbgZIZ8/luqj3YKMH+iYgEXsgqbbat3k+S+X
         wgw2ar4+8sf4WMkL9Zmk+bM5FqztF3v4aYkb/AAoiXYAoxmXrbDHgLu64bWkwE5N0wAc
         YUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679958817;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1dER13/YUlRBmS9Zphnih9CPMbd0uRZSGTFZYQnlH4=;
        b=nldllmNGeTBaoKfAE8phGoGv42uo4OUAlpfbvijL2G42ns9UVvkomyCD3fF8lO4ZMj
         hGqU661vXw5A0y/br1z36ozOfApXjf+RaWJgRupFxPHzbkGAiS5j/qnmp8BYrjIPgY/T
         o6JjG1BQHgeosGL+EsbSIR2oh9hlBbMv9/t1+Mp5CUu7qTsolzPhk+Rh3CsufiL331YS
         q5DPDY/rP7e4gD/3LWKUdUg9KE/htahuuBoKTVpBdsasUV2EoNEnSXHMkpMmK0s/sM6K
         C6G8vWA5DhyocNGase47Icn2pBKIqnHIM11/qsc3Vb5ov6fHncNX7E/RIoTomS566muy
         O+7g==
X-Gm-Message-State: AAQBX9f0WGUPjmJTaunh5PAEtUMxo7WYlzDiBlO2QfHIwW1avQ5tqaA+
        dAQNL9QDr1tY6GHmTXdfAEe/nwzwBJ8A7A==
X-Google-Smtp-Source: AKy350aBAwf1hyYmA2h5uHh015cQcHqzLfFdNfp2EPbdQNwTbARIsvZNLqyT0ttXK+eYNK2hr2DemQ==
X-Received: by 2002:a05:6402:1058:b0:4fb:1fa8:da25 with SMTP id e24-20020a056402105800b004fb1fa8da25mr12207923edu.36.1679958816776;
        Mon, 27 Mar 2023 16:13:36 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i23-20020a508717000000b004af6c5f1805sm15185837edb.52.2023.03.27.16.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 16:13:35 -0700 (PDT)
Message-ID: <b38121e0f9129d388b9426be4b2a88f87b4b5bb6.camel@gmail.com>
Subject: Re: GCC-BPF triggers double free in libbpf Error: failed to link
 'linked_maps2.bpf.o': Cannot allocate memory (12)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>
Date:   Tue, 28 Mar 2023 02:13:34 +0300
In-Reply-To: <CAEf4BzYMrXrGs0MFTqN6yxjRby-ALDbeC1aMEFjdSHO_1AsOwA@mail.gmail.com>
References: <CADvTj4o7ZWUikKwNTwFq0O_AaX+46t_+Ca9gvWMYdWdRtTGeHQ@mail.gmail.com>
         <CAEf4BzbEaTbEn1j9vLtmS1-8uJf0Bz-8wfmZj8N4Mmedt29nag@mail.gmail.com>
         <c55f31dc3ae7e346e2a6d16d3e467e5460346b91.camel@gmail.com>
         <CAEf4BzZ-x4U5NM7wsCcuESGXkoBbf_pk3CwJzA+gsj=WLwHSkQ@mail.gmail.com>
         <55da8c265fda2b45817ef70bdc57e4c2d168b74d.camel@gmail.com>
         <CAEf4BzYMrXrGs0MFTqN6yxjRby-ALDbeC1aMEFjdSHO_1AsOwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2023-03-27 at 15:50 -0700, Andrii Nakryiko wrote:
[...]
> >=20
> > I finally got back to this and have a question which I should have
> > asked on Thursday, sorry. Why do you want to preserve a call to
> > realloc() when dst_final_sz is 0?
>=20
> Because it's supposed to work correctly. Why is it weird? realloc API
> is supposed to work with zeros, so I'd rather have one code path that
> handles all the cases instead of avoiding calling realloc().

Having two ways to encode effectively identical state feels weird.
Ok, thank you, I'll send the patch the way you suggest shortly.

[...]
