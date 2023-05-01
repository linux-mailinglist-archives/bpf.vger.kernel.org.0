Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AD66F36A5
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 21:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjEATYn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 15:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjEATYm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 15:24:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF85E67
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 12:24:40 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aaea3909d1so17706925ad.2
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682969080; x=1685561080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymsSz42RVPqP5GntIJMDieCpwP11xl0mPqQ8koTrPO8=;
        b=ubhWEL23yLc/dLQUtyBEZGVF4m/b3SrWjcn65UhEeujRk9Zbjuc1wKujzIF3mgSXFh
         qbG9N06sFm5OKCyv0Zn1S7frlUzSH2j4OLIO8/V61mzxpTEcsgBahYYAphH0andOLvCZ
         eUDZlKQeUeGY6DSEuguxh+Jabuits4r8CSr9qV5IqUBQmL+LOjy7sImdNjV0+jOh+UvP
         a8235sexutJfqz4SsnwM07nlpNnU5r27P4vXML6ZgM1PXcsKpscqJpgyA1lggBXeriJu
         hispy5XWrWnzDN9SPKKv+Hrlj5Q7onaYPAvncBtFezHzNruoqhvJXIctqat3avKU+K2v
         ztsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969080; x=1685561080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymsSz42RVPqP5GntIJMDieCpwP11xl0mPqQ8koTrPO8=;
        b=la/R94Cd8BStl9UEyhJD7/NwFLI6Y+DyoKjdKVk2shGOOtuTiJfUg+F4oGHfwAHdvP
         4dfqayHiV07k+FKDUUi/Xz0I8/FN51/nChHquFaW47Q6/rNYOkYOAtizs4uvt6OmGMhS
         erVg1my1EfIay8ZXv3Y9yXrCclcL2fR1NTSojDAivwom7UM+3bFjRF43YA0OLNadBlra
         xGYE1lQxAZDCMBUlueULEEkvIroagd0DTjARt2wscgnpC85GV/67PBJBSqRo1Yf27gyV
         eJ+bDXuUmRTRoGu4gqo61J5+gkQwGbvVdMgrh5DasOPCECKjlTASPNEw6HmmEK2lMAhz
         pkog==
X-Gm-Message-State: AC+VfDyOjZ7SR5aM81XSn7jKJno03x8b/tKTUnPh8R2r+9yF2dc7LZBb
        H4Gh3Z6F68AdqdacGN+xRRnsldjxpKAVcFm+/0f8s31dUGLRtZxrqUhrNA==
X-Google-Smtp-Source: ACHHUZ4VhcAQmEl+zZMeIXehp60OWDd3Yu5HE2uVmpgtQ0SceMh9EY4d8cpxnrsN4S+LKyRvgvb3K1bDxt3IE9Gw9HI=
X-Received: by 2002:a17:902:f607:b0:1a0:7156:f8d1 with SMTP id
 n7-20020a170902f60700b001a07156f8d1mr14598745plg.19.1682969079755; Mon, 01
 May 2023 12:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <ZFAOojsT93ZxwNu3@google.com> <87wn1r6et6.fsf@toke.dk>
In-Reply-To: <87wn1r6et6.fsf@toke.dk>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 1 May 2023 12:24:27 -0700
Message-ID: <CAKH8qBtXdKDTfMQ8FoqdBe15uaRKj00LeGt5QpC4a34zF0NxAA@mail.gmail.com>
Subject: Re: [ANN] bpf development stats for 6.4
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 1, 2023 at 12:18=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@kernel.org> wrote:
>
> Stanislav Fomichev <sdf@google.com> writes:
>
> > Hi all,
> >
> > Here is my attempt to apply Jakub's scripts to analyze mailing list act=
ivity.
> > See the following link for mode details and methodology:
> > https://lore.kernel.org/netdev/4d47c418-32d9-4d6a-9510-a6a927ebe61b@lun=
n.ch/T/#t
> >
> > tl;dr: people/companies receive higher score when they participate in r=
eviews
> > (vs only sending patches).
> >
> > For now, I'm providing the numbers without any analysis.
>
> Thanks for running the numbers!
>
>
> >   12. [233] Toke H=C3=AF=C2=BF=C2=BDiland-J=C3=AF=C2=BF=C2=BDrgensen   =
 12. [ 37] "D. Wythe"
>
> Looks like the script is a bit UTF-8-challenged, though (or some
> conversion went wrong afterwards, maybe?) :)

Ooops, sorry, I will take a look. It's something in my google-sendmail
because the local mutt copy looks ok.

> (But yay, I made the list!)

Congrats! :-)

> -Toke
