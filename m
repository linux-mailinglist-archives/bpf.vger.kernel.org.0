Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F601632BB3
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 19:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiKUSFE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 13:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiKUSFD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 13:05:03 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BAD5CD1C
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 10:05:02 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bp15so19977834lfb.13
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 10:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLuxvrtTwLpjQCdZkBOlAPtT4PuOt7o3XUb4SWGRYeY=;
        b=aFl4qsh1pGzsrB406jGVgetKTU5dHR/Yq4nfmSbaVP4IJ1WK5efBe9YoThLjFNtyI2
         Kz8nEj/i+1EgGIpQsRaXzp2sEuQpAUpu1tPFClSGrYfMlU0ibiYxwfaP38uUXTpBx1q5
         KiV95QITskZLsLOVy3VVImbnkrR4AxBvE163uTw9abOsM/VfZ+mUcm0D/aBMZiaS+UfB
         ZateLKdD28RTb6oAfK1Z2JdlN8o2opqCu2lsHOb71D6jQ+NinskCXZ3gIsB6nubx7+Gz
         hBMm8gVnEQ3l1l7vHu3V7P0QfKPMTuzg/fpnBBNtaOlhXwpF+putLsOCKdPfs5A1Ljv6
         JzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLuxvrtTwLpjQCdZkBOlAPtT4PuOt7o3XUb4SWGRYeY=;
        b=DLUhfvm5G2RXiWWGmcJX5Vvct27TklhcSsgi/YmtyjqDg7+5aFposlXn7M3pUpfbRZ
         KriXYYTvZA2SnqyboOTfAYODqRdrPEA+2ZQBiuXWbaZKnkBfHTLyOLnuCs6CRIwz4bdz
         /vslfEEsAzUcVMvwGU6PUDZalENs+7kjGH+p/ZrEipkPNoQJvp+7lKzPSz2DtH6v72qi
         dXmibd9CUkHkOnxzdnGgvjdUPuIHTA7n8XxfSYRZ2SP9XyRirKdQ1qDEdhTTbNnRiwBv
         J0Hl3s+1NlfA9xrQORmAZJmbQTDxTOWCkEQfsfNXoFXpBKL7Kr+bGWC/2wcsM70uMv1x
         G3yA==
X-Gm-Message-State: ANoB5pmrzhH5Loni81bT0Mdy4t4K1rz0SborsUdOCUn9vvD7+iOJiJGO
        DIrw9fDJBzIODmKUth6PgWa1Xh2m2G7QwDGIBuI=
X-Google-Smtp-Source: AA0mqf4QjDkacLxuBSfOOnfpkyLOdYLO3J5hU1KhS5YQ4l1ixnRMdoKHYpAUjlU6GllIxGiRi4Sb84jBDVzDQ2jTeTA=
X-Received: by 2002:a05:6512:36d0:b0:494:79b6:c7a2 with SMTP id
 e16-20020a05651236d000b0049479b6c7a2mr643405lfs.513.1669053901075; Mon, 21
 Nov 2022 10:05:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:7005:0:0:0:0:0 with HTTP; Mon, 21 Nov 2022 10:05:00
 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <rw5455090@gmail.com>
Date:   Mon, 21 Nov 2022 18:05:00 +0000
Message-ID: <CAFXnTB2frY_QoBoVVKavJcx6frJhLk4e5oNVsiF1UnsfqmZ3Hg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Dear Friend,

I have an important message for you.

Sincerely,

Mr thaj xoa
Deputy Financial State Securities Commission (SSC)
Hanoi-Vietnam
