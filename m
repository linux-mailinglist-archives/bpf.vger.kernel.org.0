Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474C75FEFBD
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 16:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJNOGl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 10:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiJNOGh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 10:06:37 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF322E683
        for <bpf@vger.kernel.org>; Fri, 14 Oct 2022 07:06:25 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-358bf076f1fso46970987b3.9
        for <bpf@vger.kernel.org>; Fri, 14 Oct 2022 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=M1L5cORaWt5pw4NwklrjTogp3McFHNpkijqH23a5/Pg7EMwvd5HXSusY+WtRjKQU+1
         NKjk0FFY2X8z6ztstc0xkgu2zrgPhL715DIzlY+HoeAzuR08KNHey1I1+rttJdNP7HIN
         btUZV64jOGcGmaQUUsXoP1r8LXYONnvSL7IRvXiPwnup4+XRDQBBCAichnTtSWkk2TVd
         S24PbpQ9XnIYQzcPKhYfOTEUZ/bSojHQnBJgqQp8ov1pMGHM8qA2p913ii5NX6Vzhwfb
         Tv8S8T/fV9BQzCPoAl1978VN0N6iGKO8rGHwYMXLlLgsSiqtMka9qDtVaLNTtyfZ8esO
         obgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=tltuZL/l47RoinJBoeA8uKWrTQGSu3FFFM2oZEbaUQHZ+5Sob2q3Nsdg2gpCYSYJFg
         M7jNsKXZQx1WMDROVZApxTIWly+ti+LFRC1ea+uC5PYsgs+B4UJQf07hYqtVLzS0+1zs
         ob7fLcKNjeyQS6mo5uyiUOYEkWfg2QKAV+aafCwLRIeEWyzzzJrvJ38zSgOq2ml97zc5
         xu0gm/mupWjadWyrjpG96Ahg9C7VP4hjG1m4dXiw9n1UFSc1avMlLYW4j+ma1UZ2OrC4
         7XCU0QS5R5fvtE4wStJVCrBu3/KmFMVtHZ+pVflZcCMhTx3nQEUQdcuo6TryA+iAIb8W
         a9fg==
X-Gm-Message-State: ACrzQf1/NphMYfo1FCAe727IegPfHaX23b8uO81EghkNae7pvBI9baGR
        7Z17aM6CRv0hFRjGL+dZkgOobQ9ZJ8BoatKxV64=
X-Google-Smtp-Source: AMsMyM5IqfJcNd1ifdXfNRsuPj18dFlYKi45GvVyG6f2eqgZawcLCYH5oxTP/ZAj8dR+xuO4/4GohCbHXSiPAGk28GQ=
X-Received: by 2002:a0d:d409:0:b0:360:913a:81db with SMTP id
 w9-20020a0dd409000000b00360913a81dbmr4767200ywd.419.1665756303340; Fri, 14
 Oct 2022 07:05:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:6c05:b0:3c1:5961:57b5 with HTTP; Fri, 14 Oct 2022
 07:05:02 -0700 (PDT)
Reply-To: tatianaarthur72@gmail.com
From:   "Mrs.Tatiana Arthur" <goowjarwq@gmail.com>
Date:   Fri, 14 Oct 2022 16:05:02 +0200
Message-ID: <CAC-x_XEj5Yd2Jqt2qrG=XP_rdEHoR_pajq-3b2r8DyiOeHKJvg@mail.gmail.com>
Subject: Did you receive the email I sent you?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


