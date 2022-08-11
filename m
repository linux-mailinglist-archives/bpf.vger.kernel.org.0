Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58B958FCE0
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 14:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbiHKMyI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 08:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiHKMyH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 08:54:07 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BFF6E886
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 05:54:06 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id s10so50284ilq.5
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 05:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=447DttLGWlnXVhl3+i4qWwJxEj6tFprhGwRHCuyrWEY=;
        b=dt+sRkzONFeRFLtJM+58Y1xcZOOO1Bl85VZFwLi37j7kSWQX6hZPM62IBx7U1au0Ns
         oOVQg0KQN/V5lMLzG33DTqDzANT8we2YfJv3A9jYDdlAqM7CvA4LQgXH489O8sCbM8K1
         FPQ6F80g9jWUpHe0RefhARLoxv48KJf5yJyhqcZ2csqGR0yZosFFF+UvXa4KzbUrzWcO
         ijjc7Q5ErnstrwryHavXJPiNGyC1GHTmFR+InZByJyKUJdI6D+0I6oleWmE/CwWrTpsg
         ppSfxddUbKuMdiVnqxqdMkIxaDuJKLXgrbghioMxfXcUVJSJy/ioX6MmCQttUp5sgXi1
         OhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=447DttLGWlnXVhl3+i4qWwJxEj6tFprhGwRHCuyrWEY=;
        b=LuLMlO/idiH1B0L1EOjY7y4lJderucu0y9LCQb3NtkZD8+z8eo5YrEExrRKkv/Sob+
         ZRJe3OrxmAZHseFgU6QHJP/JLNrexyVWCR7l+5a56g395YMa7AzDWCtO1sT9B+D9Fqqa
         VcUOOAQn9i0D3z8AsEyzWn3v6rcV+EflWzntPclIhppJzR8x+bXwGc7DR1KqKFDbFcGL
         mgs2WdN8CXUW7j59yFu+dtloDhL2tm/kT6NLENKd4wbaJIy4qdbHxC5iDY8gQtkEcqqY
         VigtUZFh9cWhGn1IXtxC+zvJLQXaDHkF/2HIOWA5zGKML+mri+eMPFH/Ke5oEZaOVMos
         p0jw==
X-Gm-Message-State: ACgBeo3a3KKLWn4e1FWc8ORjxFJrN1ftrSpE4yZ4gRvPIStgqKiaUPEr
        /EQM4haFq7RwvEsJRoz7BLSfyFeruM9CDUdBtyY=
X-Google-Smtp-Source: AA6agR4lcsloBHZnqe3YpzRwYbWOtrOaKn7rVs9Ms4KzWmvRDn+JLCt5gfsjer4o0UzcuioFnaDlU2iUlBgO1eQeHGQ=
X-Received: by 2002:a05:6e02:152d:b0:2de:bf95:118b with SMTP id
 i13-20020a056e02152d00b002debf95118bmr15361063ilu.237.1660222446175; Thu, 11
 Aug 2022 05:54:06 -0700 (PDT)
MIME-Version: 1.0
Sender: ummarilwan95@gmail.com
Received: by 2002:a05:6638:2596:b0:343:17ee:f2e1 with HTTP; Thu, 11 Aug 2022
 05:54:05 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher01@gmail.com>
Date:   Thu, 11 Aug 2022 05:54:05 -0700
X-Google-Sender-Auth: TE8jOhmeLWP52vzfbIIYAk0hzEk
Message-ID: <CAC+4zVOtrvmQvDZkikBgJ9ifjWMcLzccMo5HWaeGeoEVAqDurg@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply me.

 Hope to hear from you

Best Regard

Mrs. Margaret
