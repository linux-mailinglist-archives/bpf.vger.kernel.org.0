Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108815823E2
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 12:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiG0KKO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jul 2022 06:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiG0KKM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jul 2022 06:10:12 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07B538A6
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 03:10:11 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-31d85f82f0bso169769937b3.7
        for <bpf@vger.kernel.org>; Wed, 27 Jul 2022 03:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=2/uwM2GEZkt+JB58n7KpqeeRAdU4XVBzinrWXFSTZPw=;
        b=efxPNljWe1RyDhyinjmC6EAUrsajHqeFwx+mXNYuWjyNELyMA9w4sVrw9HHobiL4Ju
         1r2SJqE8Oia6h6tbRPZHWQoFuJrqCJ7Mx3EIPeIeODvFvH1i1wdpJiZuhCa93AQfOPe0
         Hl2gLQrVPfCiOTlvHYUk5FWsMmXDNLEPluQienwDPejszKUgBbBDpLZX8RD+MgzbyYQ7
         Hmy+s83LHdsl9j7Gtm8QOUs+59MIqHAEtFOWDeavZsJZi6fh/yiFQyubcpLkVeyxx/K2
         3SqeuAHVCGXpGZaBbQQJsfUHpqzr90p08UUzJrRaTWphyPzti1akqYfUS0tuCGyg1rsA
         kIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=2/uwM2GEZkt+JB58n7KpqeeRAdU4XVBzinrWXFSTZPw=;
        b=X9lDYw+5Y9WKjjQqD9IhFfMwi19FDKeHCtIvpi1YKptTsDGu/Q6xvIFDcOHjMzwShS
         v3BXXtSbn5KDuJPRPs5AIyn6g3CiHi3uwu9hinKnkEurSr7pjYwcpmEP0JunHWn496xF
         9VlX7OY/XSKdkYEiCbgi/t3+ePqcCKmBeTL5eU0txzUraqkGkv4LODDa7rftk+WxJFja
         7Ha5obHu4dyOE0nbeTxGDjYbd04M18PdZ76In7FOoSamkz2WyCGO/I5WD1k0AWb/o27K
         9o9y8n/yDNDQlvsWBzWpqi0xCrcWqgSTfFXRpkr0/Yr6gqKeek4gIRIECItgvzJ7CfLQ
         8i/A==
X-Gm-Message-State: AJIora/gv8AQ9Se1zL5pji1m3HL2DKqpGpzSao2Rj18rS4vIZ6RGKxFV
        Or3Dlz4V8YumBWWpT/E4jVjtCZW33Kzgvhlp9Tc=
X-Google-Smtp-Source: AGRyM1sOfcp3BXkoEmDW8sca2Q5l+RKU2dAJZleXhodgyLJVuZJvSPja67geSOP89EeVdH36TLSfFitVaIwuwUXkd8g=
X-Received: by 2002:a81:a551:0:b0:31f:4253:1620 with SMTP id
 v17-20020a81a551000000b0031f42531620mr8877706ywg.442.1658916610766; Wed, 27
 Jul 2022 03:10:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:4302:0:0:0:0 with HTTP; Wed, 27 Jul 2022 03:10:10
 -0700 (PDT)
Reply-To: felixdouglas212@gmail.com
From:   Douglas Felix <legalrightschamber07@gmail.com>
Date:   Wed, 27 Jul 2022 10:10:10 +0000
Message-ID: <CALi75Ooe1e6WqPcjqC3nxuCi5epdjMLjxtWKbkCHPbPT2WAScQ@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.4 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1141 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8481]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [legalrightschamber07[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [legalrightschamber07[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [felixdouglas212[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
A mail was sent to you sometime last week with the expectation of
having a return mail from you but to my surprise you never bothered to replied.
Kindly reply for further explanations.

Respectfully yours,
Barrister. Douglas Felix
