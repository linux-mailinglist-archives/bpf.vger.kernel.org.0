Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8841C55A777
	for <lists+bpf@lfdr.de>; Sat, 25 Jun 2022 08:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiFYGYY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Jun 2022 02:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiFYGYX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Jun 2022 02:24:23 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD81240A9
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 23:24:22 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id p14so2831029ile.1
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 23:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=jE0JLsfEdPpE7rbsOBNLVDtif/ZpFdFdV55NgbKwOcE=;
        b=KI8yeML2g3fOR5ULT2K2TnxsTyaPi+Vij4Ajlgqt855owVlTdxPuvxeoBrTTAgJOGv
         jhvLs7f+I4CN50swx96XTy+WtuCoD5tFofZCCgFJC3tHL7d8Fr3F23ZDdrtfrxxCyTK3
         PEwiLEkp/bRghRyDhPYkHBQn/IOakdavBHBWXegxRzbhv909uA2+/dq8bkEXVorhM113
         Mvrvd5GwVsL1LZs/HtaoKYFnoJTUes48qohN5kroMXIKEDj1Bl7NcrKmj5Ytv4++LjOy
         ob8IkmKGzpRauQr8sR8ztgsgt2v5jR4NogQe51Y+3o48obBJovPJAylXtpc36wKss/G1
         RaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=jE0JLsfEdPpE7rbsOBNLVDtif/ZpFdFdV55NgbKwOcE=;
        b=QUr+DkySuY+JVRKvbQ0KCBAZbAD0bgM66LIwddCoHetAOf+fQ7WnECrWxJ7+1sKYxG
         UEaiM8GG+h+SPR5Pbkpj0V/IvJBUDWPvfySflKTV4ejwTd/2elwXwO2Q5zSdFDnj7DzU
         vE1PNgH+qmq5iiCtMba+2zwSLbroFqu10v8hwBs3FayNr1k3U6HH3xzdQ00GwTeonIn8
         TPRaKTEFJN5h89344EozgcekZe2JEbTunznx6XRUhOymgadYA0WohJh8gfY+/D+ahqge
         HIPk2baIp4AreUHNDK/dQR/MOY9IP4hibvMFHnJKjgXAcqF1OQxHkcMAyGuj8oidUmPA
         vmwQ==
X-Gm-Message-State: AJIora9CjNl6fUyq0uJhhxHDULeaYS9gmC9FqNkopobhbTLiOPtXjds+
        J3yE0FJGKTYgNxCD1J522V/8wHtV72v5SisWr18=
X-Google-Smtp-Source: AGRyM1s9txooWt5bYpb5q9EIxAqR0bnCVJhNXDWdrs03rzPvOG/qzpJD/vuHOEbcaQgrI7e8/hBr0Ysn3WDr8aw01AI=
X-Received: by 2002:a05:6e02:20ce:b0:2d1:c77c:5634 with SMTP id
 14-20020a056e0220ce00b002d1c77c5634mr1465569ilq.73.1656138261603; Fri, 24 Jun
 2022 23:24:21 -0700 (PDT)
MIME-Version: 1.0
Sender: fdrtgbgbhgtrydd@gmail.com
Received: by 2002:a05:6638:2050:b0:332:35cf:b252 with HTTP; Fri, 24 Jun 2022
 23:24:20 -0700 (PDT)
From:   "Mrs Yu. Ging Yunnan" <yunnanmrsyuging@gmail.com>
Date:   Sat, 25 Jun 2022 06:24:20 +0000
X-Google-Sender-Auth: oauRZ2GOQdv38BZ0DqBsIyQATRw
Message-ID: <CAHX3=bkq9dcd6XUUDpqOBpYuQOnKHD7=_LOG7bakybeaHdQUEQ@mail.gmail.com>
Subject: hello dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_SCAM,LOTS_OF_MONEY,MILLION_USD,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hello dear
I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it because all vaccines has been given to me but to
no avian, am a China woman but I base here in France because am
married here and I have no child for my late husband and now am a
widow. My reason of communicating you is that i have $9.2million USD
which was deposited in BNP Paribas Bank here in France by my late
husband which  am the next of  kin to and I want you to stand as the
beneficiary for the claim now that am about to end my race according
to my doctor.I will want you to use the fund to build an orphanage
home in my name there in   country, please kindly reply to this
message urgently if willing to handle this project. God bless you and
i wait your swift response asap.
Yours fairly friend,
Mrs Yu. Ging Yunnan.
