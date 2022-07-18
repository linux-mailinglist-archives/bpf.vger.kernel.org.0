Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BB3578DD2
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 00:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiGRW61 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 18:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiGRW61 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 18:58:27 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0171C920
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 15:58:26 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id g4-20020a17090a290400b001f1f2b7379dso762988pjd.0
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 15:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=2ER2WW01ET2wH1WV2jGlyhputEhjwKA2tNpxchjmONE=;
        b=BL1n55haiIU6dcML3MmvSTXeTN1OAGG425M/8QaIT9O6EOGtFz8aTJLt5y5lfM37Gw
         f40JxetwRpn3rzyDUYmWxiPgr7Sp61D6YK5FkPA0G/yiVJAx9phQL1cAkhOZgB9dlTj5
         VjYoChGs3qPrN6mD/fN5tZXC1kHaaBLs21SYjCaGuFcAjG783T9Frt1vvlGdxFj7cdDR
         3KULs3qbnDx+O7Skm/U2TNFQZPVKfXIp2/7cLJSiSQGdj+tAzug74i3usPSOZ8lfzkwM
         fp/cE1bYrM2go13i1xHWFHiynTBsk4rsutugQiZ18rdOVVu9KpPNx/LbRzEK+66caYtA
         GsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=2ER2WW01ET2wH1WV2jGlyhputEhjwKA2tNpxchjmONE=;
        b=fINs+r4ViLrlPBUzuwl5ZTsHAisNKdiDbJ/dnPzdC1KGBYWRUbVRqauy/SxrxVK1U7
         rSCuPRJoc1rHCP+mtRSqG2o80zRO9L9VRu2+jEk06Dmr8UO3hnAprNzhtr5yxtnblZ7F
         nT0SR7Y4mnJRPLSJz5eK7wrIZJPHZBcWLRGfnnRitcbwQEJ3tJJW6ciN+ggg4UPJLY5t
         3OaZECNCEJVVOSYVqf3DrBImI4MAIeoLD3cvoMwSoMbWIrf4HKtVEtf0I1wwRyE68Vj4
         fFE9DoeK1QJPY1+O+NecEoxmaQ4afK+jXRGcd+9XIC3plT7xtdfsBYPmoxXSNj/y6Gb4
         LpYw==
X-Gm-Message-State: AJIora82OyHB84orYFd4nn3slIRnJ1wmKkS4iNuJgbW1ELv3NH0uQCK0
        36pR8AKd/vWUwRUfQYoAYBOfQ64uCxIDaMlWbkc=
X-Google-Smtp-Source: AGRyM1vurYnVc9DfqE6iu3wFxKeDocMRcqAWLIrtgsyWYMa58rdzeKuwgfcV7m5AwIMtcQQvR0y1NprmtEjofSFx7sY=
X-Received: by 2002:a17:902:cf4a:b0:16c:1b21:a3ae with SMTP id
 e10-20020a170902cf4a00b0016c1b21a3aemr31213401plg.38.1658185106067; Mon, 18
 Jul 2022 15:58:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:f350:b0:2b8:cd69:cc39 with HTTP; Mon, 18 Jul 2022
 15:58:25 -0700 (PDT)
Reply-To: drlisa985@gmail.com
From:   Lisa <carolinahashim828@gmail.com>
Date:   Tue, 19 Jul 2022 00:58:25 +0200
Message-ID: <CA+V2SsBCK51szVtQNQ6kgF37wg3dyZTQprEuJicGF78tHcVPNQ@mail.gmail.com>
Subject: With Love
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1041 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [drlisa985[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [carolinahashim828[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [carolinahashim828[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Dear,

My name is Dr Lisa Williams from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks
With love
Lisa
