Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0E76EC0E9
	for <lists+bpf@lfdr.de>; Sun, 23 Apr 2023 17:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjDWPx4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Apr 2023 11:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDWPxz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Apr 2023 11:53:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81306E6F
        for <bpf@vger.kernel.org>; Sun, 23 Apr 2023 08:53:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4efe8991b8aso1303036e87.0
        for <bpf@vger.kernel.org>; Sun, 23 Apr 2023 08:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682265233; x=1684857233;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e24w503MQ9S82/uvccS06cym8XRFCTMJaG97VA8q4T4=;
        b=hbjiAY7Bnhva6ioKJTT0253vVp2DPzIDMTkQDBUiVU5cAWQ+UiqQe4wIOpgMwHfWcc
         B/B1RUe6VFTRIpsaw4tGiX37/A0cPuN6hjfTTA4rL3crnL3hznuKyM4Br/yFOIZlzKs5
         TGThBKCykdPBg7hcb2RDdAXruiNGdAhFF1To5fs4Iou6SO1hi3vTrDsLICCiQVkGvGVH
         punlAdjOIMkZetm+DigD2ott5AlM4IgZX+59NfkkAxzbZg7jngiXRmci2r9Q17ZIE43k
         zQKQ/UunqudSqaTQSksIBl/YSQoeP8AMr1/4kLnDX0GerOVS1biVyrejclIcJtARB9GD
         2zxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682265233; x=1684857233;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e24w503MQ9S82/uvccS06cym8XRFCTMJaG97VA8q4T4=;
        b=YrnTYGJ8gf7mN2bcUt/eVpHI2VLCix5Dn7J8stT4PpystfNrkSHEKVXNIVRYK+hGZr
         9pFv7vGpmPwBp74mXathCKzgsG9NsrpCX3JI9McrvyP2M6m9W4EALO5GfO0rgu/a8YZY
         ohZBSDm/LsaioErqBbkZxFlqhD5U1RUJ5jPBGGYLJ9Kx9zVsCvJdEVp/Elqz4XA7xqnd
         eUSUOSeyoLctDNzBdxOe8diJDrqnrw4AfUz1yOUN1BK2MhXjIqXB3s3s2SjvrZwdvUEQ
         /iwBsoG3nXjQ86n+7MYqNQEN9INm3b6k3W5wDV5fJ8OPrRK9Iv/E+sj/hvT1d0uO0ZtK
         Dz2w==
X-Gm-Message-State: AAQBX9ex1cwMtp0p5mOtESvaB1Y72F67Z1mhDJJjhtDKJwHuxzjTQ7a5
        pAdR5uI4y9/l+NxSDivHc3yqA0JaIwH6E7m4OzM=
X-Google-Smtp-Source: AKy350aWxPe2EMvl8N7rmoQ+jLUPFltsuYW9gU1lLu9XYgk2fayyZUaXfn+RPM6NRSYOc0oBz/8/fCygtS1lHi3WfSU=
X-Received: by 2002:ac2:5204:0:b0:4eb:30f9:eeca with SMTP id
 a4-20020ac25204000000b004eb30f9eecamr3485088lfl.28.1682265232462; Sun, 23 Apr
 2023 08:53:52 -0700 (PDT)
MIME-Version: 1.0
Sender: ginabahg@gmail.com
Received: by 2002:a2e:8785:0:b0:2a9:f98d:21c8 with HTTP; Sun, 23 Apr 2023
 08:53:51 -0700 (PDT)
From:   Mrs Josephine Raya <josephine.raya226@gmail.com>
Date:   Sun, 23 Apr 2023 03:53:51 -1200
X-Google-Sender-Auth: F8ETOx25LuGGmwsgjViVAM4tSOU
Message-ID: <CAL2p_XkZ_dEcJ8eNbDWCcCatL=2mDhwgukvg1q9vPj7R9zyzGA@mail.gmail.com>
Subject: My name is Mrs. Josephine Raya from Indonesia,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.5 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,HK_NAME_FM_MR_MRS,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0001]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:134 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ginabahg[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.5 HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--=20
My name is Mrs. Josephine Raya from Indonesia,

I know that this message might come to you as a surprise because we
don't know each other nor have we ever met before but accept it with
an open and positive mind. I have a Very important request that made
me to contact you; I was diagnosed with ovarian cancer disease which
doctors have confirmed and announced to me that i have just few days
to leave, Now that I=E2=80=99m ending the race like this, without any famil=
y
members and no child, I just came across your email contact from my
personal search.

I=E2=80=99m a business woman from Indonesia dealing with gold exportation h=
ere
in the Republic of Burkina Faso. I have decided to hand over the sum of
($10.5 Million Dollar) in my account to you for the help of orphanage
homes/the needy once in your location to fulfill my wish on earth. But
before handing over my data=E2=80=99s to you, kindly assure me that you wil=
l
take only 50% of the money and share the rest to orphanage homes/the
needy once in your country, Return to enable me forward to you the
bank contact details now that I have access to the Internet in the
hospital to enable you to contact the bank, always check your email
always remember me for doing good.

Your early response will be appreciated.

Yours Faithfully,
Mrs Josephine Raya
