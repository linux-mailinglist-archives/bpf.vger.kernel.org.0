Return-Path: <bpf+bounces-3326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EC973C4AA
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 01:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF681C213EF
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 23:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07636AAA;
	Fri, 23 Jun 2023 23:07:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEAA6FC5
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 23:07:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B41B26AE
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 16:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687561640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IndmHJW7I2iYVHC+s6xLbT86+daeIKxbgRYOnFOMqQk=;
	b=FYYqO20sx+ZdL4Ol8D9HyY6KZh2StFC68mOb3PFHCE3a59M9gmNdEefJMelriv62jxqwH8
	UvZhZPGwYueUsTMqAO5reBMemEbnx/Q+9wZGZHy9aggkqnV9mUtXAqBI/EY1b/Ws6qWRMO
	smyEm6DFu6Zpa8THGXKh5Z1g5W/Frj0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-4G0B8Z1YPrKqODZd9KCM8Q-1; Fri, 23 Jun 2023 19:07:18 -0400
X-MC-Unique: 4G0B8Z1YPrKqODZd9KCM8Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9835bf83157so68015266b.2
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 16:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687561637; x=1690153637;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IndmHJW7I2iYVHC+s6xLbT86+daeIKxbgRYOnFOMqQk=;
        b=BtSU9feEcxojpmSCd2UP95T1nW4pl+K4xkC+CWC2idP3EFn8IYzg/HutERZXJVtUTw
         sqU4IAukEXN4YHtpjjCJDc9lM91hoNU6w0zfxJaA+02/aVNlcb321yDpQlCLGD+Sg4kz
         SVMTkviXzGvxFN19F3G9GsjrULUK+CfoG4DuyT3LjiGNvOHXJeSkVY9MzgrwpxswGwz5
         YKUwdt/j0yAZrokhqWLQ45AbZIC8fyTVsHVQVzIWKsEGKL1JJljibTJ615XZg6qvcA1e
         G+y6IEN3IyTODeIm0l+Q//xDba5ul7UtHO9gQsuRX6R21EL595arR6GyX8yLn2Yzbue6
         Tt8w==
X-Gm-Message-State: AC+VfDwgY9DHuedWzDd1mnEwBqfcN6EWso/iHkre7Wz2I/uBKFdTUUH7
	bVLtc/7mNgXplRj5iSJT1LVGKSmsLsF8VfGTG/BXGA5Wpo3EATsta1+gORp9CQvfSxq+Ju/kGLr
	O/PWvUfaLRQRK
X-Received: by 2002:a17:907:7294:b0:988:c97b:8973 with SMTP id dt20-20020a170907729400b00988c97b8973mr11952538ejc.6.1687561637370;
        Fri, 23 Jun 2023 16:07:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4jXVCMLg8/cuBN07+tlH0Tc4fw+5Tajcbq0k2+pijlLqwz/GNKlFoaHWf/LcljX+tmgPb5ZQ==
X-Received: by 2002:a17:907:7294:b0:988:c97b:8973 with SMTP id dt20-20020a170907729400b00988c97b8973mr11952518ejc.6.1687561636713;
        Fri, 23 Jun 2023 16:07:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q9-20020aa7da89000000b0051d7e2648d8sm39880eds.33.2023.06.23.16.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 16:07:16 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7D87BBBF798; Sat, 24 Jun 2023 01:07:15 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Maryam Tahhan
 <mtahhan@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, linux-security-module@vger.kernel.org, Kees Cook
 <keescook@chromium.org>, Christian Brauner <brauner@kernel.org>,
 lennart@poettering.net, cyphar@cyphar.com, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
In-Reply-To: <CAEf4BzY2dKvMk_Mg2oLnD5a8aOhXCmU-0QD6sWGNZqkjbMrhBA@mail.gmail.com>
References: <20230607235352.1723243-1-andrii@kernel.org>
 <c1a8d5e8-023b-4ef9-86b3-bdd70efe1340@app.fastmail.com>
 <CAEf4BzazbMqAh_Nj_geKNLshxT+4NXOCd-LkZ+sRKsbZAJ1tUw@mail.gmail.com>
 <a73da819-b334-448c-8e5c-50d9f7c28b8f@app.fastmail.com>
 <CAEf4Bzb__Cmf5us1Dy6zTkbn2O+3GdJQ=khOZ0Ui41tkoE7S0Q@mail.gmail.com>
 <5eb4264e-d491-a7a2-93c7-928b06ce264d@redhat.com>
 <CAEf4BzY2dKvMk_Mg2oLnD5a8aOhXCmU-0QD6sWGNZqkjbMrhBA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sat, 24 Jun 2023 01:07:15 +0200
Message-ID: <87wmztixr0.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

>> applications meets the needs of these PODs that need to do
>> privileged/bpf things without any tokens. Ultimately you are trusting
>> these apps in the same way as if you were granting a token.
>
> Yes, absolutely. As I mentioned very explicitly, it's the question of
> trusting application. Service vs token is implementation details, but
> the one that has huge implications in how applications are built,
> tested, versioned, deployed, etc.

So one thing that I don't really get is why such a "trusted application"
needs to be run in a user namespace in the first place? If it's trusted,
why not simply run it as a privileged container (without the user
namespace) and grant it the right system-level capabilities, instead of
going to all this trouble just to punch a hole in the user namespace
isolation?

-Toke


