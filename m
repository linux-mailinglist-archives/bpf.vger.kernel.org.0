Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276FC64F927
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 14:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiLQNxh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 08:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiLQNxf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 08:53:35 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C8F13F1D
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 05:53:34 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id j16so4883152qtv.4
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 05:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UleXfybfkB/Pp7XCNYIxvDWfUpO/oLpvjkUbrsMk7bk=;
        b=bUVS/dg8ArAcxZY6k7GYdHRkb7tCtb2dIyrqrGw2KFktHNZmS5IpZ256/Rc1k1RC+o
         7ZtLNA0NJTsmEnm5ep/UndL1Faft3zb8qp/HeXTeTEhd/EsEEDAo641+6CrHKH6Xn2i3
         4XRpZ/qgP0WW2c0ax9uhBkuL4MCKATh0CosfzlY15maLjVMnyM/QcCL0M9FTaTA0CtnV
         xy4b/YFIKEjpFpdY0wI0yCmnTL3BiMRSChhQbpJ71R3A22ydq5Y4+5iZTy/fnGExBlrj
         3jzpmTKxk41getrReqy+Wbdh5cFZG+L46wxu9Fbt4i4nk8DFmQvf0tUs3bEKNReMR5dj
         wkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UleXfybfkB/Pp7XCNYIxvDWfUpO/oLpvjkUbrsMk7bk=;
        b=3PfqfnW4kUKYpDGY8TaGo8W+GQz30jG/LudwayFfnot0FIupklb7JA8BU9OIGCK64w
         OXzGlJ+exenThzsXWAJx9bJq5AL54V0FX63Mw3hsxUd+fCB9Oz+ZU4ZJaHZ93Opub5Mi
         DNawZ/kEufaNa64SKCnd8tkE9ahvzLDIjtN48PL79ou+nBcbunkDX8DLngfKxnbY8jT6
         6A+RKCl14tOaCXaXnJk1Ui89yvG2rGBge8DLGY25Y96cETG7+2pDXAldgBDdBu7go0i2
         vUTURLXdOOjoHI7i56aMYeIEri0DV6xP/8RAMAeR9JflHqubIDLYMR4mUph9t1NgSkyQ
         mU3w==
X-Gm-Message-State: ANoB5pm5v3vEqUmTQuYa2AcOO0fLJLtTWD5hBjWTBXA2BMN/dfT8mHCQ
        HRTOXz0qsdQ/WKvRVJ+OMi+zkGFxwJF04sGwyD4=
X-Google-Smtp-Source: AA0mqf7rKI46CJvr+iInOizlHJ+e1yDtL7st8njqBdeFZw0vVOrc8H22ujhEyU/38yo/UyUofcvTweSe9O3zs+5dir4=
X-Received: by 2002:ac8:60d9:0:b0:3a7:e616:e091 with SMTP id
 i25-20020ac860d9000000b003a7e616e091mr13274959qtm.537.1671285213614; Sat, 17
 Dec 2022 05:53:33 -0800 (PST)
MIME-Version: 1.0
Sender: asfiss2018@gmail.com
Received: by 2002:a05:622a:38f:0:0:0:0 with HTTP; Sat, 17 Dec 2022 05:53:33
 -0800 (PST)
From:   John Kumor <a45476306@gmail.com>
Date:   Sat, 17 Dec 2022 13:53:33 +0000
X-Google-Sender-Auth: 27rELLrxJqmBHbmMJi6SQh19HAQ
Message-ID: <CAMhHx7-Li-ncT871nt3nYUpKbv43whNTDTVQ6N8ucb8ze90igQ@mail.gmail.com>
Subject: Kindly reply back.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Greetings!!
Did you receive my previous email?
Regards,
John Kumor,
