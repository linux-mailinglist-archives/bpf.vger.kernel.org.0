Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB18649570
	for <lists+bpf@lfdr.de>; Sun, 11 Dec 2022 18:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiLKRiG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 12:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiLKRiF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 12:38:05 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759F2B489
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 09:38:04 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v8so9881873edi.3
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 09:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A5Os1rPoo1ChPlg5hPaCwrd/EmKpmzjimIuVlwuqaAE=;
        b=JJeneg4/azi0QE7TdlTc+u+42beLa95wA2OJIGQe7OssZVepLuT3kVJvqgVBdZKzVB
         OPfj34gtN71QWk80FHctwRFDHAoDFfFL25feUqM923x3LYOdcwNaIVDoSnI7YvPIUMO+
         gSFPbqkCrM3uBKxZCbRl7EdA3DWF7+1A6sWlYeHBio8/omBfmdpmbR1JPSNtV2Ppzy6H
         A8Tpn8gE3Pn9u+lgZruG+KI9Q0W6MACb3Km6jHinMlptoaQDg4H/rfYPe4tRdW50QTpf
         nCciM8IIrXz1P4FVNewciK5SLb0uLpwRz4I03tkUkjB/lDki/lWn6Gmbqo/4GJfkyHLZ
         G26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5Os1rPoo1ChPlg5hPaCwrd/EmKpmzjimIuVlwuqaAE=;
        b=205cXUeNmls0FrAwpKaI8gv/wg2dWeaNoFDTC5G1SFXMgMOpYJQKjyYZbQKroffXBr
         KQmLik8NQxq25uy+iubVexSkYUgiQpk2lP789W5gL2BkKTwxTogijqdYOhFPcSjqI8UP
         5dOa4myWRW0Zy7od0AXlD+KZQP52nBPHWgrDGIx5qvNnhQLZ+Rp9+ki0VPFdT5FG/s5Q
         2cJWHsRv6+7KLvjteazl4sDpbPMUQiigqAPuuac1WsN166OTe2r3EBl2hbrlEWchVpAu
         WumVcdN6AeFH0/SPCYuB+QtXU1wJuwK2DNKEzoIO+ttQz4+SMNAxM/tzVVIJ89ZgIArv
         AHHQ==
X-Gm-Message-State: ANoB5pmTZdBo1U7hwIA+ckV8JmR1ppPvMwZFJfDaq4dWyOz0d432YVir
        Ia9cvfrGOCUR2RHmsuRWMfvf+1x6VQi9IzcaNy4=
X-Google-Smtp-Source: AA0mqf4VvHJ87Lq43enx07M55tsiCtZ3n0oSHwYKTAeCzQvF0zUGKj51cLOQlaUw0vrdydJauTnVPvXXQM0tgs1nYcA=
X-Received: by 2002:aa7:ce86:0:b0:46b:1872:4194 with SMTP id
 y6-20020aa7ce86000000b0046b18724194mr43554144edv.362.1670780282556; Sun, 11
 Dec 2022 09:38:02 -0800 (PST)
MIME-Version: 1.0
Reply-To: 0085lwh@naver.com
Sender: engradams88@gmail.com
Received: by 2002:a50:3781:0:b0:1ea:fe14:4001 with HTTP; Sun, 11 Dec 2022
 09:38:01 -0800 (PST)
From:   "Mrs. Lo Han" <0085lwh@gmail.com>
Date:   Sun, 11 Dec 2022 17:38:01 +0000
X-Google-Sender-Auth: YXbWoIvRzwWxhQTpVzEd67Haiqg
Message-ID: <CACnDYXQ1Yp41vqMquCt0zmtW1ybjX9SBj5+syk==6OF+NLYieQ@mail.gmail.com>
Subject: Hello Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FROM_STARTS_WITH_NUMS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:533 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 FROM_STARTS_WITH_NUMS From: starts with several numbers
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [engradams88[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [engradams88[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Dear,

I am still waiting to hear from you regarding my last email, I am Mrs.
Lo Wai Han and I have a charity project to carry out, I would like you
to handle this project for me.

Please reply to me for more information.

Yours Sincerely,
Mrs. Lo Wai Han.
