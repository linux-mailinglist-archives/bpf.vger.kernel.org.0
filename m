Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674EA6CB2A8
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 01:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjC0Xwm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 19:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjC0Xwl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 19:52:41 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13251B8
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 16:52:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ek18so42864695edb.6
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 16:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679961159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LE+GDtujY5dEp2QJlqwGeGf176HPNBVbeHSxIB1aKd8=;
        b=TZztNehgbhekYOCdhGkVRnLy0f0T2OoD2Priq4kM2Qa9l+aoMz2IaNZwN2G/d9EkFK
         dIqkYaEVEYd9ikQ/cPNySF6oOvGy9/wiwBhQ1jcEc2bat83mvnmWFnn7p973xYxj/Ran
         839s/eG1f6gAJFIk9fbEj/oDsa9KFr1XmvkVc/cMZJAYHe9eESckqEvlJsYMGQQWksji
         I9hz9dI8iLkBXIwzbOnpEDKsrjTi+QcK90Dh4KDBiVtVHATKYgPCeo9ZR/Cyor2Ur6V+
         x8dCxItkTE+PmmPLHQ3O64qSKrm7Dp3olg1RYLJKTDYeZ6qg52GyLTRX+1sH/CJIXpJN
         jTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679961159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LE+GDtujY5dEp2QJlqwGeGf176HPNBVbeHSxIB1aKd8=;
        b=ZXkozV3/G6ZChFr1Rc2RJukk/K5yozqUNT6lUOukms56KZa7nj79dtqO5v+46SYU9h
         zAWjkCIBXkh9X1JvVIORM5NQe6SdNKnL8slTiTUIklIf6G7RsCI/U7SE+IgSOl9ISw1O
         JHT0tFuxxT8YcG3HC3su5n2Wy6sOsCPv2btgprtwzaapY3cyW/JUlZ8/opaYrdII1kTv
         gaYSoz0ZDP6IIM0bHYOeLoXpUqeIHZDnFatUBA9UaxGqGDoLrRqtskiz9hBOVhZwwNuk
         COdYOR93OhbHuVcN587w9NHyj2FJME2ubESwnuhyC1O+uWNf/2c5TjeDlZeyKQDsqFdQ
         bI5A==
X-Gm-Message-State: AAQBX9fLMrmA3MllJCHYIxUj7KxZhnZpvwn7xQ/vCNn4UlrIRsWtzZhO
        1sgPOzgWKakmi67eq2pyqMC6xWR3f+2V2KkAWN4elqNU
X-Google-Smtp-Source: AKy350auL/+C8SIfRo16zz4lGkBakAH3JUFzjiZPC+60y9sf8SMiJMtnlG2Jd/e9bD2/nxkMx+bshVnFVO1IkUWni6A=
X-Received: by 2002:a17:906:6692:b0:944:70f7:6fae with SMTP id
 z18-20020a170906669200b0094470f76faemr2597696ejo.5.1679961159260; Mon, 27 Mar
 2023 16:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <CADvTj4o7ZWUikKwNTwFq0O_AaX+46t_+Ca9gvWMYdWdRtTGeHQ@mail.gmail.com>
 <CAEf4BzbEaTbEn1j9vLtmS1-8uJf0Bz-8wfmZj8N4Mmedt29nag@mail.gmail.com>
 <c55f31dc3ae7e346e2a6d16d3e467e5460346b91.camel@gmail.com>
 <CAEf4BzZ-x4U5NM7wsCcuESGXkoBbf_pk3CwJzA+gsj=WLwHSkQ@mail.gmail.com>
 <55da8c265fda2b45817ef70bdc57e4c2d168b74d.camel@gmail.com>
 <CAEf4BzYMrXrGs0MFTqN6yxjRby-ALDbeC1aMEFjdSHO_1AsOwA@mail.gmail.com> <b38121e0f9129d388b9426be4b2a88f87b4b5bb6.camel@gmail.com>
In-Reply-To: <b38121e0f9129d388b9426be4b2a88f87b4b5bb6.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Mar 2023 16:52:26 -0700
Message-ID: <CAEf4Bza84U5XOQ2RfYuBvXn47QnH+0XH5R=D=NE7yPdL+GafCQ@mail.gmail.com>
Subject: Re: GCC-BPF triggers double free in libbpf Error: failed to link
 'linked_maps2.bpf.o': Cannot allocate memory (12)
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 27, 2023 at 4:13=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2023-03-27 at 15:50 -0700, Andrii Nakryiko wrote:
> [...]
> > >
> > > I finally got back to this and have a question which I should have
> > > asked on Thursday, sorry. Why do you want to preserve a call to
> > > realloc() when dst_final_sz is 0?
> >
> > Because it's supposed to work correctly. Why is it weird? realloc API
> > is supposed to work with zeros, so I'd rather have one code path that
> > handles all the cases instead of avoiding calling realloc().
>
> Having two ways to encode effectively identical state feels weird.

It's weird on the realloc() side. But from libbpf's side, we always
call realloc(), always use its results, always pass it into free().
It's one way: consistently use realloc()+free() API.

> Ok, thank you, I'll send the patch the way you suggest shortly.
>
> [...]
