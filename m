Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8A85E922A
	for <lists+bpf@lfdr.de>; Sun, 25 Sep 2022 12:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiIYKnP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Sep 2022 06:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiIYKnO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Sep 2022 06:43:14 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A682C649
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 03:43:12 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id j188so5259861oih.0
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 03:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=jmLqJw88R92BvyU2VzDQO5lt78Rt7uYyR/eZs1kVM6M=;
        b=JivkuPji1zvtNP/La7znPDqyR2ZUPnXhlf0TM2FGaPHcGEKVFzpLL2tJbFwJg4Ew0c
         A9/L2HYh6vTahipBFA4z+V5sJ0a2BjODmkbk2F1Ocg1fSx77HbCKB0NN1rnE+olgDUOd
         R21jyGkTQQu54EY/y1FuQgMSurAK+iHtii2gFJ8TYF6QWqlpcpyz7SyzczUzfPRR7eql
         SLkgVDm4hNnKPtsD0D+cplN6Np6xIpIpSJEVfyrhSTLHifRIHPX4gCp7UmpJbSsF1Ura
         htAIC+CmeLvgUflxNg/fSDg2taPQqvdLwPAA1ioFXjVjjGzF3SFaFrpzIVQ/G1ev3WRA
         TXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jmLqJw88R92BvyU2VzDQO5lt78Rt7uYyR/eZs1kVM6M=;
        b=khyzxtJujVoXpghvb52K0Ji+Q/K8vmGtNz0fUbn50KXXFew6ErV1bjmVAj9PebgXZR
         kYtVs73g3FmeXoQnr1M5qoR8XkBf17awWdCFce8TtpofD7G3Kv/y96xRS2naJknsc9gg
         NTWj5R//3vtlmjlPJ+5gLmSW/TLFRNM7/ZJyh095pUfkJu4Slx6eXeznPHQuOZMTb1eG
         simPOG4EX4g8c31n+KkpUXg4JU/1Q3PI9HWIAccM3bV4Kr1HVLopu1NpJ8rmSSH5pa7u
         iOVt8LAX1ee2aU+XJcaBGYPx/wxWpIRnlF3xzIyZd8c1tcuaXjUWfvdyheFfQloX1/X2
         qtqw==
X-Gm-Message-State: ACrzQf1tifHs0xMs6CLH5rCmq/giOSyJ1kB6T3tz/aw0dba2G4ji/lVp
        1+lhDJ/blIAA8e8vDRUXo/hvMAAQqyfQKlxgudM=
X-Google-Smtp-Source: AMsMyM5TKSMlrW5Nieph9yNZB2dGO59TwqZ1C7LPVN7amRBG3c4D4S3fRHeFzZXEw2kHmfrVaI+wckjO440z70JIEM0=
X-Received: by 2002:a05:6808:124a:b0:350:a5e:f8f4 with SMTP id
 o10-20020a056808124a00b003500a5ef8f4mr12226435oiv.149.1664102592323; Sun, 25
 Sep 2022 03:43:12 -0700 (PDT)
MIME-Version: 1.0
Sender: larry85veji@gmail.com
Received: by 2002:a8a:f2a:0:0:0:0:0 with HTTP; Sun, 25 Sep 2022 03:43:11 -0700 (PDT)
From:   Pavillion Tchi <tchipavillion7@gmail.com>
Date:   Sun, 25 Sep 2022 10:43:11 +0000
X-Google-Sender-Auth: RqBsgvPHavf2sSUgbtZwaLh0Zv8
Message-ID: <CABdhqSB-U9XJaUCavPUkomAAsJ3Lmiks=egAHuURYQDXHUN_cg@mail.gmail.com>
Subject: Inheritance
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_SCAM,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Greetings
I have written to you before, but you have not replied to my letter.
How are you and your family today? I hope you are ok! With due
Yours, I'm lawyer Pavilion Tchi, I sent you a letter in the past
month, but you did not answer me. I have important information about
your the $5.5 million legacy that your deceased had
cousin from your country. I ask for your consent to submit
you as next of kin at the request of this fund, because the bank
instructed me to introduce them to the next of kin allow them to begin
the legal process of transferring this fund to your
Bank account.

Your prompt reply will be appreciated for more details.
Sincerely,
Pavilion Tchi
