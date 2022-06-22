Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA238554A07
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 14:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbiFVMbv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 08:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiFVMbu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 08:31:50 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EED35246
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 05:31:49 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id 19so17375640iou.12
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 05:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=w57PyM5ymkkfGSszFNozBaZLMWQ4EZrgt+Fi+IcoLN0=;
        b=MVf3ntrwW9qAyAXyhhQuq4aLGoNTf6pyExN19mNntzgq69r/8rt4PPI6RCTKxHizcx
         O6ptJKuc/1s852iQ2RCpvbcX7PMVxVvWrElVQfx98WJ149aw60Fym5b3c9JUOZG/sqpc
         UwlmiJDJNKcO+1E5DFX/IZ8LzDoVdjrTP9PglK4hzcSFUKPAHmpnH+8yhprX32yK/BS7
         g5+TgzMkLqqzB2ggfEUezkUe5BE08Xj3mGK0C36TKo/XHXoI+fkouIyWLm9mlzcP2FCN
         co1IwdOI6inzT4TJFxOrje+DkbLujroUUXTkf4IsWG56+Fcs0x1WL7Isly89PVzHn/f2
         XS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=w57PyM5ymkkfGSszFNozBaZLMWQ4EZrgt+Fi+IcoLN0=;
        b=1rV2TIDC15PgstOTSj2DOfvTvz5SmKWSQGA55XyCanB61wg0+Q2F2vR4xVrYhUvr8f
         HMEHhtvEwHmxgVgSl8aNHVo5mg0IKQpOSoIDbi1Hn7x7u8Fkjh78JJa62vfba2N/ZNxt
         FwZYbhixvZMK2ogdliRS4puDe0I7Vi9M1ozTRU567pv59K+CPfsS/mySQ1IBCIpMmz/R
         ezH0nkhVaHW3d+3ZyVdcQXl4Whp9jYbVLVjK8N63P8B1wtbM9A3AsufHCJOe2sqlMxyr
         L68230t3CKt/FgJnucPRizuL6M8eOtcvmE/vnwQ+N7gbjpY1aZgm1a4shE8VjMAZaat6
         +3Tw==
X-Gm-Message-State: AJIora+iBkhb6jgWt9QV4Mnc1n5x2CaVVZsKW6Gcp3pCDClLwTpvTDRo
        nPEzXVob2ugvRX8f93WAyFNWdTZo0+V4Af1QQIU=
X-Google-Smtp-Source: AGRyM1vQSFJZKooXdJkRebGRa5a/Z++GrXJLR+zWvkLazGs1YQCOQEl6DzSg9h92QZOd8p/e6JGdF7nbZjg0a6PLmWA=
X-Received: by 2002:a5d:9850:0:b0:668:eb75:5898 with SMTP id
 p16-20020a5d9850000000b00668eb755898mr1751758ios.97.1655901109430; Wed, 22
 Jun 2022 05:31:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6e02:b27:0:0:0:0 with HTTP; Wed, 22 Jun 2022 05:31:49
 -0700 (PDT)
Reply-To: biksusan825@gmail.com
From:   Susan Bikram <jbi880375@gmail.com>
Date:   Wed, 22 Jun 2022 05:31:49 -0700
Message-ID: <CAHiEHe9Fdte_WYioPgdNsuUmA238E+hBy2DB9McKdEy2_sskhg@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dear ,

  Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Susan
