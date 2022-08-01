Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49461587406
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 00:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiHAWiV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 18:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiHAWiU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 18:38:20 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A93474C2
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 15:38:19 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q14so9499229iod.3
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 15:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=ej3T27wdcOl5hgxFKEEvscpLUDARFbq7IX1O4+1Fbq8=;
        b=ozYuBtEFJXnnUttMeEBGkK0QuvTK1rHvEquTDZnNf7AxcLsu7lvrmYyuldMqfH8/YB
         rsVTWlZpQNVKDnC5EeKCBEEqPxCxoFPxnTg3fSznKcGCB3yRa4SUYgFwoFIOcyP29BF7
         VjTXPd9RSQtXswZOgEexQ2JQ7RpzV6waA/tkGJPaQx/NB3rvTEK0M+D0XRLwSwLvrlyv
         q4xr8IWv766OJ8CQr1oMR1VXt8Rhb3O+IbWRkG/mOlGBN9U7KGMDLrjEAV3Q1rpMT8eD
         pZfUAoBKlFGQDoUQxNXw1ZtaKq3BGNMDspw6wBEuzkwrb9NTFUsNRnd0yNLqyKulKLfr
         mHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=ej3T27wdcOl5hgxFKEEvscpLUDARFbq7IX1O4+1Fbq8=;
        b=kuiKB1tNKJ0YHt33otcvEj6KLT1tyJ43fLHCPSYLeYdyqCDOMwi8VVX/VIvYSpZNcp
         d+SEq3IrLhUUweEc9KnxpzZwSfjqFhQbiHtv8fyf/InUqxTKRd0W+y62796S4OLYNW2N
         WUso5BXWzhTsFa5AF7U0tshbxlldJAYfWCELPhtkp7jJnLOQtkmQN5HpY6H0BnNbXJbn
         xYXLuGoYzZkrgdYUHpYQQYbc36rc7I1VJdGdHxhPBsH6YRrg8o9G/M1j5/XwXObjZXcX
         8i/kVRyVVXcTUgjlTPz4yXMnxW2k2L8BB49nhgfNaYQeys5wpqT3ItGN3HX9CnU8dPH0
         ykVw==
X-Gm-Message-State: AJIora8dvWVB40wpmHMvfLUSNmKknURSOhLl+gp2zE71CSVVVmFUc86c
        opqYfXtLGLlcKBpCjtpTMRERd+JDKmmErlhRFlA=
X-Google-Smtp-Source: AGRyM1sLxDcJeYX0/RRSGdobw9aSZiKZPbyM01YVgSdjp0ZO5TnidTrYJpJUs0lzMdCDYaIpZMo1ChS6CjMZl60Sr24=
X-Received: by 2002:a05:6602:2c8f:b0:67c:308a:ce26 with SMTP id
 i15-20020a0566022c8f00b0067c308ace26mr6128583iow.94.1659393499347; Mon, 01
 Aug 2022 15:38:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6e04:683:0:0:0:0 with HTTP; Mon, 1 Aug 2022 15:38:18
 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Prof. Chin Guang" <confianzayrentabilidad@gmail.com>
Date:   Mon, 1 Aug 2022 15:38:18 -0700
Message-ID: <CANrrfX7VAJfHgthcVVcZtPcj+u17QjzHQY3kWDuqi2rr-6K62Q@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello,
We the Board Directors believe you are in good health, doing great and
with the hope that this mail will meet you in good condition, We are
privileged and delighted to reach you via email" And we are urgently
waiting to hear from you. and again your number is not connecting.

Sincerely,
Prof. Chin Guang
