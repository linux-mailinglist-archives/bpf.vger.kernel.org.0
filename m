Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061D14AD02D
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 05:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbiBHELT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 23:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiBHELS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 23:11:18 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39601C0401E5
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 20:11:18 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t9so10600895plg.13
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 20:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=4HWW3srFwPeoeibWEbuFvJKgAXfTYBcpWGvdOE3ZrkM=;
        b=S3EnrzOuystMOnwGibMhWyZO1EAXIf7ulf7x8Fsjo3kzR+HQHcanar4Y7H32mg7B6B
         VAy3JoEcGzOvtNgTuotVk9bW+D0Nem4MvMqCD0T8dLbZzdUlXuUXOMPNLsgfoe4p8oPt
         JTxyJ+rdjJHqsT4syIP2FAEppyjKAhZCupkeNHR+qAcWBmLsRHPC5uT7g425lZGY5Dpb
         219y7PAFH0l1hRTL/Lu9CK0ujL0WF5UYk7ZkOKP+fA6pPY/LCgGExUxMkyRCfNc/KJRM
         MnLftfM8N0JRvQnDJPrFwEJMf9L1Bf7WMiMKVeTwk1VJN5j+YElnf4nlUxWXBdm5wUyV
         J9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=4HWW3srFwPeoeibWEbuFvJKgAXfTYBcpWGvdOE3ZrkM=;
        b=MdXbcKAVKky/sgFpq4NbUudU9VF7T2wAdc5evC2p+eoBcAwKKVpG1qCp/cfUVWrYID
         ON0QRo7pkHL5aOXAmAi5mnkHPq+89J2TBsjGgGeLwFuwJTXzbJIUbwWL2L+d+EZf/91D
         gJggdEDzHTHdwUeDU1tezuV6s+qPVCb9VUynroHkezKEVa+bx4vVaZDBaIj8RufYNkpo
         rI19HvZ6kKxSGOSz1fcs8ZXLRCZ0xNI1EeT+OVukovZnPtOLZ/BfuOMhtoyQ9FAypmgy
         oaKudVlNCgeu5Z6LM/vZDetqAY14efwbf0TN6bBLmj1H6zML+NgtVgavEVUCeS68BgXe
         L3yw==
X-Gm-Message-State: AOAM530ZlmssA8rtliPNQzt4NkxnbZ4jvofuIma0uLHDXM9CSD31wmRp
        81ucoBoxwIyyvPaP11RtUWTmNd5+9jqIsvQLtpM=
X-Google-Smtp-Source: ABdhPJyPJKWjvRki4aRGnumX/m6CCDxStCg3Cn8YqgxvhaEaBp3eTSmUyMun1BW2Nvs1ChgZKWcvfPniTaF1usuJ41w=
X-Received: by 2002:a17:90b:4b46:: with SMTP id mi6mr2350226pjb.21.1644293477459;
 Mon, 07 Feb 2022 20:11:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:178d:0:0:0:0 with HTTP; Mon, 7 Feb 2022 20:11:16
 -0800 (PST)
Reply-To: selassie.abebe@yandex.com
From:   "Mr. Timo Helenius" <juanangelino0001@gmail.com>
Date:   Mon, 7 Feb 2022 20:11:16 -0800
Message-ID: <CAE93Of2XUbx+Z5fjNQZxrvOkpaUkG6Xc+Noyquho9UFeu6sMkw@mail.gmail.com>
Subject: Revamped Catastrophe
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:643 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [juanangelino0001[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [juanangelino0001[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--=20
The International Monetary Fund (IMF) Executive Board has approved
immediate grant relief for citizen of 25 IMF's members nation.

This is under the IMF=E2=80=99s revamped Catastrophe Containment and Relief
Trust (CCRT) as part of the Fund=E2=80=99s response to help address the imp=
act
of the COVID-19 pandemic.
Reply to this
Email;selassie.abebe@yandex.com
Best regards and Stay Safe
Mr. Timo Helenius
Copyright @ 2022
