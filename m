Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB7B5886CD
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 07:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiHCFhZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 01:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbiHCFhY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 01:37:24 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2F73D58D
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 22:37:21 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31f661b3f89so160742747b3.11
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 22:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc;
        bh=8v205cQ/ieAUhL/Vo4tOV+N+9VBgqw+bgVFiUzCohIE=;
        b=DzZZONlia6lEQx8QYO2ajUdHdG6qlDgT6EcVxtUu0/fhlgRKnBGDMsCnSqck6dIAwG
         Ib+2r8XPtYaTbvdJjgMFB3eJpRRCe9bg/0rHf7b5XwPM6japUBcLsSoeCQNFl+bve5dS
         PyG7ywSlv1/sxd83Mr+eoInjSFS55Yr+uMKegyc+IXX0Tx51ouU/bLd72LFqOQN9IM9x
         V+MSDXZcBOXJhJw7Goi7zO2F4EMHfS8w9kV6iMOyDfv0w3oZTLLy/xWozPRap8qJy73c
         grtQ5dHzI6B2XGYXX/hjImyfc+e0zIP5DaZsdroKLH6KiIWfFcvDvmJlobgyXintPmX4
         dRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8v205cQ/ieAUhL/Vo4tOV+N+9VBgqw+bgVFiUzCohIE=;
        b=RjYjVhdaAzIKMLS5a6GaHPg7z0L3OMCibaBQl6bfXtIoIU0MmLJVpqiULAOuSyU+Mn
         kckeorxcLyuEPD5z3WzerP6xwMtbp/9gI6dtiKvdCzQOT4v2TJbP2buoSKgq1t8652yq
         kJ5PjBVLJ8Ubp4grl90nCZqxKJqCret6Gt6X4gM7AnGT/UXiXu14ceuDy68NRA2LDFEa
         c8Rbz7hmppn6SCBhanAAb7PioHb4Nq8gmo3J8SKdukn18cHgQFwbqrlpuZQpdqHSXskl
         DuGXpO6bSQ0GyG6zzgnfzQ5T4rnVNLquBNqQ97WdrVX7m86iiQgVKgNFObjeRSaY8HEH
         mbUg==
X-Gm-Message-State: ACgBeo1VnG48sJGMzVOy0+p/EB1PYQL+k2lnPWVb6vvWiSdNWn56UVMz
        +5070WheKJKQpdbO7hT1FYma1w8D1iNWAVR8UIY=
X-Google-Smtp-Source: AA6agR7CvtM2pFABsATEAX5G/TQzX4FarJRd99zQ3Ecq77HwwfzGnkGZ7qktwprCLkaVbpN6YTHKfESeS9RW+aG/NB8=
X-Received: by 2002:a81:4ecc:0:b0:323:bfb0:e71d with SMTP id
 c195-20020a814ecc000000b00323bfb0e71dmr20861504ywb.18.1659505040759; Tue, 02
 Aug 2022 22:37:20 -0700 (PDT)
MIME-Version: 1.0
Sender: drabrarzebadiyah@gmail.com
Received: by 2002:a05:7010:42cd:b0:2e8:65bb:6021 with HTTP; Tue, 2 Aug 2022
 22:37:20 -0700 (PDT)
From:   Mrs Evelyn Richardson <evelynrichards10@gmail.com>
Date:   Tue, 2 Aug 2022 22:37:20 -0700
X-Google-Sender-Auth: SwhcPk7R8r0HUpuXGh2q1LbbZTU
Message-ID: <CAB4WHGvV92RRZN3R6yBULOoQVz2AsJYKOOM_vxpQYyOZs_35VA@mail.gmail.com>
Subject: Dear Beneficiary
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_95,DEAR_BENEFICIARY,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HK_SCAM,LOTS_OF_MONEY,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1132 listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9881]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [evelynrichards10[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.0 DEAR_BENEFICIARY BODY: Dear Beneficiary:
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 HK_SCAM No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--=20
Dear Beneficiary.

This is to inform you that the United Nation Organization in
conjunction with the World Bank has released the 2022 compensation
Fund which you are one of the lucky 40 winners that the committee has
resolved to compensate with the sum of ( =E2=82=AC2,000,000.00 Euro ) Two
Million Euro after the 2022 general online compensation raffle draw
held last WEEK during the UNCC conference this year with the
Secretary-General of the United Nations Mr. Ant=C3=B3nio Guterres in Geneva
Switzerland. This payment program is aimed at charities / fraud
victims and their development to help individuals to establish their
own private business/companies.

However, your Compensation Fund of =E2=82=AC2,000,000.00 Euro has been
credited into an  DISCOVER CARD which you are entitled to be
withdrawing =E2=82=AC3000 Euro each day from the DISCOVER CARD in any
DISCOVER CARD of your choice in your country or anywhere in the World.

Therefore, contact Engineer Account Mrs Kristalina Georgieva, he is
our representative and also United Nation`s Coordinator in United
State of America that will organize with you in Dispatch or handling
your DISCOVER CARD to your Destination. You are to make sure that you
received the UN Approved DISCOVER CARD in your names which is in list
founds in names of U.N world list to receive this UN Guest
Compensation.

We are at your service.
Many Thanks,
Mrs. Evelyn Richardson
United Nations Liaison Office
Directorate for International Payments
United States of America  USA.
