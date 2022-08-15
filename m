Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B159659518F
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 07:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiHPFBs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 01:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiHPFA6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 01:00:58 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0DCBFEAD
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 13:56:09 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id y18so6467283qtv.5
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 13:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=ej3T27wdcOl5hgxFKEEvscpLUDARFbq7IX1O4+1Fbq8=;
        b=GKmGHtkrQMk73kuQFkbh8D5C0XyGfxFi1pbKWyxFivzSeO0au1SjT/ANpr4YyZ9FkZ
         COvgDkR+k6Sqtv7PKde+kywbQvImD0ItSmeBWoqP1w/Jrh7ot6jOxPgZicv4Ez4GqtNb
         MKeiXWfTTbU9ZDrZbEVlNXibrGWJ6mYaIEeD+TsCdLBJAdNG6tyjEbbWwARLZGBv3uxh
         TbAJBIe/snmYU97vmrGVVk5OAQhIvs3GzJu81Lb/yYjmsN/hXQj1vcSA0li8kP2+aeRi
         Q0TEAO47hgmQS8suNWIgQxdwt8yuin5FFCyvU8zi/yOTFNJKKZTbeb8LP3gexxnrXa++
         0q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=ej3T27wdcOl5hgxFKEEvscpLUDARFbq7IX1O4+1Fbq8=;
        b=sBJa821ABcgnD5MDwCeKlWjEcvymnHKQI4+Wsg0GRlb0COduVidwcU8PGBsf+K0b7b
         YkY1NNu37pfU8o3RNqi8P23fY/iUfgj0NZ4dFoB9U4g6FUjSiuc/3qq+40+dzGUBF5ny
         DnjOTCCpmvPszse7x6iShlVsBQWAUx5zyPrm5rLA5o2WOQLBpLegVxjFnzWBRh63M+iE
         hkuxwYy/Se1h5uwgyIjk+U60Z3ouC68iDnmrdCRjVLyK5/LoECGLeX7rYl4C7yOp0+dj
         r/6YNYoS4OxkFeYHJt6iaWYOGYi8HJqwuaXNfMGHI7owvy2fToZw+y0x7a6rgfSU00wI
         jePQ==
X-Gm-Message-State: ACgBeo2Ifti1RwVaWtaV1vqcw5PVvzlRIf1+JixIEnKVDWO2zujWAtyp
        N1yX89kg01bfSlJ7aGHzb1zu8YBAiMxiQVJD7EI=
X-Google-Smtp-Source: AA6agR6ErzXSHXjfCx8K/Ak7fhtZ5AYRWJG2jetMzQsmXSKlo+gP9cg6XpFiiQxBS47jt58ItCifrRFANQITy0vEsdI=
X-Received: by 2002:a05:622a:4806:b0:343:6173:f513 with SMTP id
 fb6-20020a05622a480600b003436173f513mr15154280qtb.681.1660596968787; Mon, 15
 Aug 2022 13:56:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:ef88:0:b0:46d:3a61:256e with HTTP; Mon, 15 Aug 2022
 13:56:08 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Prof. Chin Guang" <dmitrybogdanv07@gmail.com>
Date:   Mon, 15 Aug 2022 13:56:08 -0700
Message-ID: <CAPi14yJVnXbH_+nmrfOEXQBnyceA0JR6vkkN6gTgvHS8kfhQ9Q@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:82c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [wijh555[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dmitrybogdanv07[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [dmitrybogdanv07[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello,
We the Board Directors believe you are in good health, doing great and
with the hope that this mail will meet you in good condition, We are
privileged and delighted to reach you via email" And we are urgently
waiting to hear from you. and again your number is not connecting.

Sincerely,
Prof. Chin Guang
