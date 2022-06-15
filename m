Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0090F54C9A1
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 15:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245276AbiFONT5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jun 2022 09:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241056AbiFONT4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 09:19:56 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC1838185
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 06:19:55 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-30c143c41e5so60886497b3.3
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=Z/Netpz31PZPwyi6lv9WeBV3hygNwb008R4NVKyRNhE=;
        b=d7m3D1um3sDwMsKvI83iNUzuDZKPyQwO+be8bSG4ALU5KOHBnFnU/Dzkl/43lIkT7p
         HCUNz8uym4wqbUwmDhG8nGJs1xNMZuXf0RZZZTS/+xT+kDAlFjeNIqOAQmzcbcBVHj8W
         GOpZq53GfnoAsVFSqZR4Ff2CS/t+f4qIhzc8CjzZLanJ/S7hzZ0myorxKVB4iRv0f2E5
         d6QGdYvSZnZhKpYyVHlpbn237QDywxokz2daKpQoqAUJhsQ2kR+ucN3IAPbBHgdKgpRM
         Qwu0IVrbNhEfaw605esysEiNbHE20/VJqqXdjbc/g9nkO6qoMxX88/H2PcJTM/wKQ2AB
         UTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=Z/Netpz31PZPwyi6lv9WeBV3hygNwb008R4NVKyRNhE=;
        b=A/AR3rXVErLKT9H51YQcW/FtDjwN6qpRbT4s//5ESH1UKcI/J4hEU4y+tqu7ZCR+hA
         3n15k514wlIfSZXzjStQLQ7Q2HgqPjhbP9yfeK7n/KVHjCVVQUKc96Da+LQLxZvgPL0C
         LD0BEGGHxHYlzlefHNF8LovXDlVF6BqwUqqjRQu8QFbyIAg5CgI5lheBQILzN6SPDKxr
         VCrHbmQMFeGrQHB6dkMnZRik3rItzsP00rV7ZejeJzZmqSthU026IceW3NUVPiLR9ERa
         Sy35rjo1dJb/3/8dAI+8fYjT+IfJMh8CxbqNk4fc9w2dvpU3Ig+KQZ7lBmfOqa7OWSOq
         kBOg==
X-Gm-Message-State: AJIora9+1tiuQB6iqnL1C40LwMxhDsiXKb8WZemtuS/fAlW6EW+48DJ2
        LGmP7btzYR7F4EtDHu0dn4abOS9xLXe0lObnBPE=
X-Google-Smtp-Source: AGRyM1sCwKsGtW0v5jj0J2CAB7nqvBm0pymxCVhGGG9BTXzTDBXY4ZEg6YuW+2hxvdxNNKir7dcdN1Vin3oCrY3Ah+Y=
X-Received: by 2002:a81:5dc5:0:b0:30f:f45f:f3f1 with SMTP id
 r188-20020a815dc5000000b0030ff45ff3f1mr11524696ywb.204.1655299194088; Wed, 15
 Jun 2022 06:19:54 -0700 (PDT)
MIME-Version: 1.0
Sender: thomasemem3@gmail.com
Received: by 2002:a05:7000:4e8a:0:0:0:0 with HTTP; Wed, 15 Jun 2022 06:19:53
 -0700 (PDT)
From:   Mimi Hassan <mimihassan971@gmail.com>
Date:   Wed, 15 Jun 2022 06:19:53 -0700
X-Google-Sender-Auth: gDUoDjr3h8PSuzuHycH6jbIVaoQ
Message-ID: <CAOH2t15QuLkMrLihjmkTz79hY1mg8Y-ykPvYsLg=Su9Vv2ZVyQ@mail.gmail.com>
Subject: Can You?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_3,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

i am Mrs Mimi Hassan and i was diagnosed with cancer about 2 years
ago,before i go for a surgery  i  have to do this,so  If you are
interested to use the sum of US17.3Million)to help Poor,
Less-privileged and  ORPHANAGES and invest  in your country, get back
to me for more information on how you can  contact the bank  where the fund is
Warm Regards,
Mrs Mimi Hassan
