Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F3A671A32
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 12:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjARLOg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 06:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjARLNq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 06:13:46 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F351A9CBAB
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 02:24:31 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y19so15393777edc.2
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 02:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JjbMwH7wtztxpVEzNDiuMUnQ9Jvb8RCm9+Fyzzo0gjk=;
        b=UzNqf6FOmPUpYW645ortHl8wDnagAGHRpJHHs9QnDIiIVW9zacYmj7qBcfYKUEeTrc
         G5temDQ+tSHuqDM4aBehgXY8mxW2N+zo5Hl0buBlJDJZg+oDBnLe6Mh6wYV73r/G+M6Y
         1PhuLW+xWdxbqW+eWeJnEfRzeGKEcm5Fbp6N+LNxKvu5Fv6foCJhGGe8EKk9yWdVAdsw
         BpsKIUvIfXqxB3B6N1DxXd+3ygULc5Qic+NFpyxnozpvDBsgPtIxN/onOfU/W5BUz1JD
         4XNVcSHLjheO7uGUTk7ewwviHvp6ORdfAWAUsNjCK0gW1qsJDAowDxkK20lPDbbMwIzo
         bCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjbMwH7wtztxpVEzNDiuMUnQ9Jvb8RCm9+Fyzzo0gjk=;
        b=Lrb9hD0CNTRYDM7TO88Bb27oikAwreaRJ+FA+19Hj4KFCsNh3WP/w16SHINtVi9U0R
         fTloaM1mwmNnItBy6FmYsaDFLZ8X4P3IiPhp34G5Ur6R7zcPZhDxPIgeZCFVLQbdxKjJ
         k/+8yCwgGPi9NXQy05kAfXEJJ21mX8xH6tug5sAVe6CthvxAbgPzZmhcFPbowOTABBEC
         xbgYNvFdidHPk1ooYxHg90QpU85YLAk6BqkuArTOk3sQjbvnz/mdvSSqveUZScqOJyiM
         p+payRhSOrGPGZAhUcwB3D8AjCFS3smQ/QBqKWeJAF2XOwOsZQsg/uv1UlHhz7BzLXtu
         W8xA==
X-Gm-Message-State: AFqh2kqN7CO1LM0SFOfh1TPXcLfPmHxTHFxPmkVhAe634KJyf1BfIxmz
        g5ONIFqBiFcNBAlL/z3CWfHCxkqz7IxGSqgGNbs=
X-Google-Smtp-Source: AMrXdXvxG2UFjI2adD6QzfBccbt7Eb5ZTd2DVw7HeTOwMJprH/2Un0PwUQyDi22SiBoS/7LiEyafCHF8dUx646aB2O8=
X-Received: by 2002:a05:6402:1203:b0:495:5232:b05c with SMTP id
 c3-20020a056402120300b004955232b05cmr606317edw.286.1674037470107; Wed, 18 Jan
 2023 02:24:30 -0800 (PST)
MIME-Version: 1.0
Sender: cherryfreya22@gmail.com
Received: by 2002:a05:7208:552b:b0:61:3f08:1323 with HTTP; Wed, 18 Jan 2023
 02:24:29 -0800 (PST)
From:   Jenneh Kandeh <jennehkandeh07@gmail.com>
Date:   Wed, 18 Jan 2023 11:24:29 +0100
X-Google-Sender-Auth: jAMIMxA6FLzRFlZ_1aAfjBmAo5E
Message-ID: <CAJ4SZEP6ktgdjE_X+pOBTo6BfT-Wvprha5Z_HQ+cRXzfRkQcSA@mail.gmail.com>
Subject: Re: Regarding Of My Late Father's Fund $10,200,000......
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,MILLION_USD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5314]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [cherryfreya22[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jennehkandeh07[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  2.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

......
Hello
I got your contact through the internet - due to serious searching
fora reliable personality. My name is Jenneh Kandeh birth date
May/23rd/1994 in Free Town Capital of Sierra Leone.

l am a nephew to Foday Sankoh, the rebel leader of Sierra Leone,
opposed to the government of President Ahmad Tejan Kebbah the
ex-leader. I have been on exile in the Benin - Porto- Novo. But l am
current residing in PORTO-NOVO BENIN due to war of my country, my
mother was killed on 04/01/2002 for Sierra Leone civilian war. my father
decided to change another residence country with me because I am the only
child of my family, bad news that my father pass away=C2=A0 on 25/11/2019;
During the war, My father made a lot of money through the
sales of Diamonds.

To the tune of $10,200,000 (Ten Million Two Hundred United States
Dollars). This money is currently and secretly kept in a ECOWAS
security company here in Porto-Novo Benin, but because of the
political turmoil which still exists in this africa, I can not invest
the money myself, hence am soliciting your help, to help me take these fund=
s
into your custody for investment and also advise me on how to invest it; an=
d
=C2=A0I want to add here that if agreed 30% of the total worth of the fund =
will be
yours minus your total expenses incurred during the clearing of the
fund in Cotonou Benin that 30% is a $3,060,000 (Three Million Sixty
Thousand United State Dollars) is yours out of the fund after we
confirmed the fund there. l'm waitting to hear from you soon.
