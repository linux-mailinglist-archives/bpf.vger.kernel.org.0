Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F2E516A9E
	for <lists+bpf@lfdr.de>; Mon,  2 May 2022 08:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383413AbiEBGGY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 May 2022 02:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348929AbiEBGGX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 May 2022 02:06:23 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F6547AD9
        for <bpf@vger.kernel.org>; Sun,  1 May 2022 23:02:55 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso9124989otf.12
        for <bpf@vger.kernel.org>; Sun, 01 May 2022 23:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=K4EH4yTl2Li4cRUJ9RCe0Gd6AqFtxwTiHPJAGBrJGWI=;
        b=J1TZy1PnFQjfIpJet4PEYddPCcpvkmRwfvqYp1PmgMBpy4y07ESx1OXpn0ce8kPdUE
         AvD6QsGn135O7Pb0njRDl+Tbp7r5vPvuNCJYpXHzbuw4nzfhwfheVcCoIeFGr1jWOr1u
         EJNiPjGPSxAV8TsSNQH9sMCNJ/ASv5l6zf1zNODUwlAekmMhjnhzWQJPRsCkgrRUFWLu
         yCMmBlg2pNWRI93ZU2S7Q53+B1EPwl8lVp4rWd4655y1YBZ4cf6RkGFqEWqhZPpWexEX
         yMqN6Ts8nN0AVWeGxtiglaakT7ZDA3GzR9hWrYxs/EQhC9UsvGQATKDPbXLB0rwZ1niu
         lALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=K4EH4yTl2Li4cRUJ9RCe0Gd6AqFtxwTiHPJAGBrJGWI=;
        b=FdoZ95B0ZxjkwquGfD5F5xf59PQ3l0duXtn4ugU4qvFRIhkuuhVFuusJ8x1GWHnzNz
         NKDB0vhbNANesvcYYicLY4Q1YtNjwctT8qaTIFfGmqDbGZlYGLuJH5oST/sn7MzVMJjs
         Sx4U6Wj0/imC9dAQAfFLZntzjYeA1kekOa/ND1eO3NsN568eb7KSwkVatUHPXfsVjRFT
         c8N+FSIBpr6VZelSd632LdnZHMgPSWYgnPZ9jOQwvQlalhqa0n0r31tIxCT5KMjM+N4Q
         DufTj1CYNpr9VI7Bf8vJrcmSAMzL5YVrXN+4TPhO2+UA5mDO0toI/DDQ8MQFCdC3Z2UZ
         Dptg==
X-Gm-Message-State: AOAM532fX/FxlRPJzqP+cZ3G/zL7YPXk8qPzzJexmPDVEuIb3GRk/tSo
        TMs6FoQAnRur8zTnIMdAAIAXB04Q6JaWs99lBA4=
X-Google-Smtp-Source: ABdhPJzi33tYcmPShB2t9QRKAiDrfXXO8uDzwd6aKjqIZVfKw57yoTIvTIhtoIrsnyhpBtIbCzeo4q2qgaAJJH5oFx0=
X-Received: by 2002:a9d:58c3:0:b0:5e6:d8f7:c18c with SMTP id
 s3-20020a9d58c3000000b005e6d8f7c18cmr3694034oth.364.1651471374752; Sun, 01
 May 2022 23:02:54 -0700 (PDT)
MIME-Version: 1.0
Sender: gilgracelove@gmail.com
Received: by 2002:a05:6830:3103:0:0:0:0 with HTTP; Sun, 1 May 2022 23:02:54
 -0700 (PDT)
From:   Tete Duago <teteduago@gmail.com>
Date:   Sun, 1 May 2022 23:02:54 -0700
X-Google-Sender-Auth: KC-BAHvBSazlNnj4xkg1FBDSDp4
Message-ID: <CAP52+OSHp2H1RLrfMtZUsKdjzvYSmx0Nnaeit8=n0jA78drq8w@mail.gmail.com>
Subject: w
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_SCAM,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello please contact me for more information on the transfer of
($8.6M) left by my late client. I want to present you as a business
partner and next of kin of the fund. I will give you the details of
this transaction as soon as I hear from you.

Best Regards,
Tete Duago.
