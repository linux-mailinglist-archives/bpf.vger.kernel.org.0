Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5836D5811C4
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 13:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbiGZLRg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 07:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiGZLRf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 07:17:35 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF01630F49
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 04:17:33 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a23so19793974lfm.10
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 04:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=geCVNY+flwt789c9RdieCurETz/pfYIPVuJSXzc2+N4=;
        b=BM0rh7VbZ2xUz1j+iUJw2xgVAdLFYIH0rtwJoR38QVlGZdVdDiyBHy2/QZc7AGW11C
         etiv/PgQbvtPb+mUiMgxYM//t2RTI+gSgodj2UZkrqj9BKDyzyYASV8QGt8CUCKySdKQ
         qV5me8fxfy8u7bd/e6Mecr9xDICVAa+u6o7MqCsAHEn8Lk2N1kY6q1Z2XRARhlFtmcqm
         TDoz4ePJamsL8o7wjytca8miCt5YGVywqtzOgfH7B5bJDb+4Qbi6AIE+mJB2JgAX1G0a
         RQI/A1D8nX79wbMacygtDXpR0DoQ2UvTpng6ACC81+s6JZNxHkyGTJYOXSOHAlVg7OSi
         dRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=geCVNY+flwt789c9RdieCurETz/pfYIPVuJSXzc2+N4=;
        b=0NO1rdfQxzNkYn3lAS8S9FpbGnRv1I9zff9cOy3/zt8mijGYkbPeLhvRQeB2LI5yX6
         9iPJZVoPo66exD2gjNh1O3C2/QNEkhqb9cWHC4NQFcicw9wLeG2Xm44W0Lv4knL1JCoH
         19Zx2MdRovx2bjAnF89B+LYpCt8lgotw1AD+LEMmfxOT7t3//IP/SBNbF8gJcJ4E/h3r
         7gfOCxBVQUIOyEVi9yZkqBx5ocH2ViXZNy9bCGyhSsWhXLZEbPKAwlipYDGGC+AOvjI+
         0gVt5u8VAgyex4HVmpPCmPvctlyzGkrE2eUo/gQXOH9xOiARKVyYqUpCKGUqMqrj/cMg
         onkA==
X-Gm-Message-State: AJIora+U+00FppceHU5plxFFX1kEtFoTNr4Ijz2xlKagrGVXS7dn8ie5
        OHph1t7gzUmlXt7lM8QK96HnDc32HnOQMA6M53w=
X-Google-Smtp-Source: AGRyM1uya30K4wPMzCOdHpnGZ7b6BPyMCTfgbawKHNJ8iTmf9f4e5fGnBRSI6B56g+LzLc4ptBGAtaK63uuyXh+W8hY=
X-Received: by 2002:a05:6512:6c8:b0:486:7288:4651 with SMTP id
 u8-20020a05651206c800b0048672884651mr6074434lff.49.1658834252338; Tue, 26 Jul
 2022 04:17:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:2a1:0:b0:1d7:b824:937f with HTTP; Tue, 26 Jul 2022
 04:17:31 -0700 (PDT)
Reply-To: loebarryson@consultant.com
From:   shahab Ayub <drusmanhassan19@gmail.com>
Date:   Tue, 26 Jul 2022 12:17:31 +0100
Message-ID: <CAMdE0PP8RQ59KAXLowg9gBYYTB4aA6XsAw3C_wndrcbfDFP-pQ@mail.gmail.com>
Subject: Business Proposal From Dubai UAE
To:     shahabayub <shahabayub@consultant.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello,

I am the Chief Compliance Officer of the United Arab Bank of Dubai. I
invite you to a good business deal. I want us to work together as a
partner and benefit from this good business. I will explain in detail in
my next letter if you are interested in doing business with me.
Have a nice day

I look forward to your prompt reply.

   Shahab Ayub
 shahabayub@consultant.com

Shahab Ayub
Chief Compliance Officer
https://www.uab.ae/en/Discover-Us/Senior-management
Website:
www.uab.ae
Address:
Sh Abdulla Bin Salem Al Qasimi Al Qasimia St , P.O Box 25022 Sharjah
United Arab Emirates ( UAE )
