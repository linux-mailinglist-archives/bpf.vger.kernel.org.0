Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FBA4FF189
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 10:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiDMIQx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 04:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiDMIQx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 04:16:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F066394
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 01:14:32 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id ay36-20020a05600c1e2400b0038ebc885115so2376515wmb.1
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 01:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=23IqQ7Qe0MB9deDpmcZWoJBTgc8tYnf4jwIAOCwbNrI=;
        b=LXWtNbEpn269d0IRH8kiSV9x2uBusu49mQvrox/ll4qZqMxT0nSWecqoSJiXcWN3VG
         vsR+DVCu1OfOcXNgKajqtdcCxfL2nyYH24QjDmLmvnoznFSmfiG8/uegGheZ/u2X9bQ1
         kfAFDABCrFLwh7y5Z/K2zS6K/gWpIAU9F2WTI3zfjpH/9T1PDXOglEr11fDqNhln5/D9
         tEQshF/BD/V6Fi2deiGJODoP5tt+iAAUc5UUYMht3gSVCOZW4A7+EGiNMzT4hO1q2Tzd
         tSkH0WsjWyfK+rak3/FtI8AY8yId/Wl6FTfJBpnqeuUIGprl9RpZeJUNCm5ozPIKg1Jo
         yxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=23IqQ7Qe0MB9deDpmcZWoJBTgc8tYnf4jwIAOCwbNrI=;
        b=o0pClMpOq2aJhrh3flPUxCiqYIt1lZNBZRBAWup0K15jzzt20ixuc3HQYWstESKnRl
         Dk2pTJ1eXtA6gSKC/pKKfde6p93pfkxvWlirR5Dn54HibA6bptRva3Mw00Hmu2j76tt6
         YqLkImhMMKZ4qrj7m6j+A89NILAsYiG9dWNmHmiynghou/bzqL00QtLYpReCGICB+MT8
         TTHn6LPLkW58sN9O8isFZOd/sMFIqaBE1a8F2uwDGY1XnXyf8Kzpm6W/c5JXHnTvTliI
         R2AFgv1BtPBjiF7PARpXgwT4ombULopczaEuKDj/eRXtRw4ERmpUo4tPvR7fuU20PUxG
         hgig==
X-Gm-Message-State: AOAM531Tm3lwKBXkRewxg3CwzcpsW4MB1BalENGj5RbAie+LiQh10l3+
        bPjMMdOJ71ZzjbpnAIawI5x1tzDlY5l8JWM0SNI=
X-Google-Smtp-Source: ABdhPJwId/c8tynsBiXerN1KxQymptBjP6p7R13DVEyE8XHby9+miDUK8BpqhHX6uDM2u35mWVmWvPT19v9U76FdMQk=
X-Received: by 2002:a05:600c:3ac7:b0:38b:f9c6:27b8 with SMTP id
 d7-20020a05600c3ac700b0038bf9c627b8mr7392940wms.75.1649837670751; Wed, 13 Apr
 2022 01:14:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:b782:0:0:0:0:0 with HTTP; Wed, 13 Apr 2022 01:14:30
 -0700 (PDT)
Reply-To: WB9676473@gmail.com
From:   WB <filepvt2020@gmail.com>
Date:   Wed, 13 Apr 2022 01:14:30 -0700
Message-ID: <CAHt+Jjk_CSzUpKxuapA+3r9NqyPHYfdRtp_XoNN3EFvC3Gr2fg@mail.gmail.com>
Subject: WB
To:     wb8899110@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_75_100 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
HI,YOU ARE NOMINATED FOR 500,000USD IN WARREN BUFFETT EMPOWERMENT PROGRAME.

THIS MESSAGE IS TRUE DO NOT DISREGARD.

REPLY TO ENSURE YOUR EMAIL ADDRESS IS VALID FOR MORE DETAILS.

YOURS SINCERELY,
N.STEVEN (P.A)
FOR:WARREN BUFFETT
ENTREPRENEUR,INVESTOR & GLOBAL PHILANTHROPIST
OMAHA,NEBRASKA,USA
