Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11B2626ABC
	for <lists+bpf@lfdr.de>; Sat, 12 Nov 2022 18:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiKLRLF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Nov 2022 12:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLRLE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Nov 2022 12:11:04 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FB815FE8
        for <bpf@vger.kernel.org>; Sat, 12 Nov 2022 09:11:03 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g12so12839348lfh.3
        for <bpf@vger.kernel.org>; Sat, 12 Nov 2022 09:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZ2HOXC7u9lp2DzJs0sbNkHU6jI1OZTGPVdm1KQ1HEc=;
        b=WW4LswdcC21nam3VOIcj9IvyKC24EuXdHUQpmxE1Jazprdobc3NMd+3/OUpfGINvbn
         9HOMdo3conE+EXOf5BiDbKvDoXBBjrIvjKYG/GXBBfpgg/Jgq0d/Twexw8Zkp96hs9jW
         o3/lFyfHz3Od2U3MHz+DSMZW5NAwpPGl1pqhAEBpJFh9qqGK91w/RzamAVgcoSGdxvQo
         HV4ZqIe6EAAswlPhzTcxntoGT7+Vg9Espy62tD1PJlDIApt0w0OXfe+Le1HIIydCDOK2
         wGT3O+V9A/TneKg3pLg4dPgriMW+YvHe/Q0M4r9/Ag2Zmf05p8uu/mIo+Mcatq6i+wVF
         tg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZ2HOXC7u9lp2DzJs0sbNkHU6jI1OZTGPVdm1KQ1HEc=;
        b=Idm8hdtA6bvmPS0CiwDDUh3NbAv196hHsW3E8fY6lWQ2M7xvPQci6EOoVdI1XzqiVw
         jSxJw3yjBWf05fM6ut57QFFL/NqZvmnOBiLVKcgMql8oTHv9x5uZVhehrmPb++utprBw
         mAL6l4oQ5sW0cIzEga7zeyCba/b0uoDvK8VeN5/MFKxcHOj+rJhc/qvWNxvL30q0zsfX
         +RA2x589yFt8Ud8SFuuGQLFjJ5IbfB12vhKLurAn3GXkhpSjmt0OegbQeRjDjOyEb59P
         beNJ7Jhokj2+PrLdCrBp2t0guSeivC3w5Wm1piG/++vnUk/ib2lgAzszRspkhdw48crd
         oWEg==
X-Gm-Message-State: ANoB5pkFIYXQXhKv6ZlUNlCOy4Kt6KbE+TYiC+h3O6PnUeueMCYGCDu5
        i7rs9L051x3TZbtlDJRqFjiu8Gf4PiCS6yJDxJI=
X-Google-Smtp-Source: AA0mqf78qxPvLfYXpKksxyojguKW+GwWQOwrCoTutEXp8cvruom2BGm5358Wpv7QKHz68+QeLekhW+aO+hfSskDNpaY=
X-Received: by 2002:a05:6512:2107:b0:4a2:3d03:d951 with SMTP id
 q7-20020a056512210700b004a23d03d951mr2149665lfr.387.1668273061628; Sat, 12
 Nov 2022 09:11:01 -0800 (PST)
MIME-Version: 1.0
Sender: jw888502@gmail.com
Received: by 2002:ab3:6f52:0:b0:200:9879:f9aa with HTTP; Sat, 12 Nov 2022
 09:11:00 -0800 (PST)
From:   "Doris.David" <mrs.doris.david02@gmail.com>
Date:   Sat, 12 Nov 2022 09:11:01 -0800
X-Google-Sender-Auth: OeiSwHFBBy-m0elH4ywXZ_5ya0o
Message-ID: <CA+hfTyn4xyPjPEZOTmbouLTeevrYVxeVQ+_ZP2qKVxvoBu14tA@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5005]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jw888502[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.doris.david02[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night  without knowing if I may be alive to see the next day. I am
Mrs.doris david, a widow suffering from a long time illness. I have
some funds I  inherited from my late husband, the sum of
($11,000,000,00) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness Having known my condition, I decided to donate this fund to a
good person that will utilize it the way I am going to instruct
herein. I need a very Honest God.

fearing a person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained I do not want a situation where this money will be used in
an ungodly manner That's why I'making this decision. I'm not afraid of
death so I know where I'm going. I accept this decision because I do
not have any child who will inherit this money after I die. Please I
want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how
thunder will be transferred to your bank account I am waiting for your
reply.

May God Bless you,
Mrs.doris david,
