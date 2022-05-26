Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B5B535062
	for <lists+bpf@lfdr.de>; Thu, 26 May 2022 16:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiEZOMg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 May 2022 10:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiEZOMe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 10:12:34 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948E7C1ED2
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 07:12:32 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v26so3142802ybd.2
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 07:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=WgNCQNJ6DUznxZMPlMlgkea/oWMdzzwftb3rvbSVmT8=;
        b=Bf2Xi+aJu519esGIXxW3yuXHo2NAs7L7iClK2eRQEJe+/xh9yg80WspDgyaoBleGSm
         +TMyQ2Tro5xETy3V3U21d5QDE61wWysP642/xX5tondUuHAZ6O65UPufeY4X6NCvAumK
         NGzXXz56ONwjEnIu9jrXx1ARhn635ipIOMJyYrtbsmKC78zcVk89qNXIk9Q5CPUZ9cLj
         I8THVZT60Fy3wzrjH55DnYM366/BKDTWbSNRJCS+4PnEXMY0dKHIfaMAKHUuFBoxkC4e
         UXtAxFSC+zZgdSBqWLrWg4AIVu5REygfzVGyaxQUFe4NI8BduM6R1LnkkxLQMvInFKE7
         O9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=WgNCQNJ6DUznxZMPlMlgkea/oWMdzzwftb3rvbSVmT8=;
        b=5Kk17FVsQ+ry+i2z5TTFMsMG3Jp/fkahfPGJTErmpUjko9CIxd5GgGYJXWM7nKjmvu
         E9H3cws22/O/1c21wZdYOnmvQfx2z/rBxH6OOhNzTvdvNpzNbfc/NEy1V4gxW/W9H2u8
         w0TY05lqela077iUqBVmJkuxYv9/7PwNXY7ktCVmzTCd4G0y5qvhatnxdTJ1J5e7kz1l
         MkkJ0lPyAQUzR/3EZ1OtkoKlOgBKJtL26J1BRA7X4Gdeq1eeqZ9A5l70QlQhsjAOYDmB
         TMocCx4S3ZzZug5jiHkn0EVJz3n9qknvoKMdXGPciKKmPGOg+MyUdAU88ACfReX9yvY8
         Z++A==
X-Gm-Message-State: AOAM5322AHZfy4/XTXpy+tmFyodIjjalRmvbMhzQqINgoEN71u24SMxW
        Rs1+IE9QOARd9UyVTtx58DEwcnAV6u6P+IaKGTs=
X-Google-Smtp-Source: ABdhPJy3HhEGGGmbL2H0P7dL/9mroANLoLf53xKfmsklFTYFLJv6HOlZ4ae7EcgM9x5ly/z3eSjbp6NdwLqfDWoS+tY=
X-Received: by 2002:a25:df02:0:b0:64f:7747:923a with SMTP id
 w2-20020a25df02000000b0064f7747923amr27436410ybg.363.1653574351384; Thu, 26
 May 2022 07:12:31 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: ozildanka@gmail.com
Received: by 2002:a05:7108:730d:0:0:0:0 with HTTP; Thu, 26 May 2022 07:12:31
 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Thu, 26 May 2022 14:12:31 +0000
X-Google-Sender-Auth: FhOx6CItJRjuNQvvNitdMCRm9J4
Message-ID: <CAMo8Hh-C0KxuD9eoWK7x48uk6nddVY8jpiHmJn9NsixQ=0tq5g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Greetings to you, did you get my two messages? please check and reply me


Pozdrowienia dla Ciebie, dosta=C5=82e=C5=9B moje dwie wiadomo=C5=9Bci? pros=
z=C4=99 sprawd=C5=BA
i odpowiedz mi
