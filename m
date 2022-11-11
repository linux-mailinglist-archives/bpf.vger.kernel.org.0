Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9592C625E02
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 16:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiKKPOl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 10:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiKKPOO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 10:14:14 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0262B79D00
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 07:12:28 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id b29so5104459pfp.13
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 07:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFPao6+FHTUKOYc11RmLF8YTaUlvFn2TAMXlqT2wmEQ=;
        b=DQpMxx0JlGAfFHlwtaVvCbqTLb0cJBSrAFTzNn7FEiojuW/n8wgdxErHVhvI80RHPX
         y+HJw4xygDBnyZlBXtuwGCGX4wJu5REMScJ0NtJo9vXUVQhDBEAc5gFQhMvHl6SWourN
         Q58mGLvC0A+nPG0XJfK9ejRE2aC1CfIxNHJOmkAK/GPGk091nnaAeQvmB86NjkRrjSfE
         p9W+60Ryxe6LwgvXKq6NMmgOWISXnFg8gFvmbgHqzwcqOF3xTDJn7c2U04imEd8IqeG3
         CjXO/gAOTDcL35Mbi0wAQr8jom71Yh21JCG4s2U9Mdx+vT+r5Fqn0eVTLYpKvQh26r4a
         QNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFPao6+FHTUKOYc11RmLF8YTaUlvFn2TAMXlqT2wmEQ=;
        b=Fx3h7CvsFQn5p6eewtPxysZi/ovoiCTrNt8oFYjSTdcfNAwJ/lrxaax27k6yTAl3Fv
         i76SVl8ZB/jZp6vt7d3cNyr1IdayLWmKa/gZEYcJAer/Gj62cZqlEY5yCXVge7VmxPQr
         q83URXa/jRSvaaJFIJgAeFlLkVZocXdOIq3mkJO8oo0Tf8jmjDboxGA6OKK+bw387HH9
         KF4Komdw8+T6NRiFn70oyefLcrgTTvkde7VWYbYR8R46kBdazw2gx8qXJahNDyUtqK88
         klz8OG9PTFdKpfRv7+qx1JsRkOF7Pcwdl4O3OX9rpmWbu/Q1B/N56sfBPiAQxV8FfYPY
         +gMA==
X-Gm-Message-State: ANoB5pnNwK2nL52vlGQtMqGTExg27EfbzRHYs56osb7IEuoo3cfTwCIz
        PXYl89nlnIAsNezdkQdpV9zpiTdzybtGLv5tnXU=
X-Google-Smtp-Source: AA0mqf6Fl3mbPSx3PrPJ/OrMAfxTblZSQETwAsOFRE+NjuSNKlGp1IVP9plp7ebq6N97IXp5cRNaJsb3CmFl1HzGGII=
X-Received: by 2002:a63:3c3:0:b0:439:3aad:c1c3 with SMTP id
 186-20020a6303c3000000b004393aadc1c3mr2004359pgd.350.1668179547408; Fri, 11
 Nov 2022 07:12:27 -0800 (PST)
MIME-Version: 1.0
Sender: chijosco1990@gmail.com
Received: by 2002:a05:7300:760c:b0:7a:d83b:ebf0 with HTTP; Fri, 11 Nov 2022
 07:12:26 -0800 (PST)
From:   "Mr. Ibrahim Idewu" <ibrahimidewu4@gmail.com>
Date:   Fri, 11 Nov 2022 16:12:26 +0100
X-Google-Sender-Auth: Enjbx2no5xsnKOVb7WAAJy4hTeU
Message-ID: <CAMsCVzAto8ZGkJdT3WTUe2fyZ0nw9eU0LqfbZJi2WPgXrYu4Ag@mail.gmail.com>
Subject: NO RISK
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=ADVANCE_FEE_5_NEW_FRM_MNY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HK_SCAM,
        LOTS_OF_MONEY,MONEY_FORM,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:435 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6433]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ibrahimidewu4[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [chijosco1990[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.0 HK_SCAM No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  0.0 MONEY_FORM Lots of money if you fill out a form
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  0.0 ADVANCE_FEE_5_NEW_FRM_MNY Advance Fee fraud form and lots of
        *      money
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dear,
                       Can you trust a financial relationship that is
mutually beneficial to us both? I have received your name and contact
information from your country's banking data Information, hoping that
you are interested in what I am going to tell you.

I'm Mr. Ibrahim idewu from Ouagadougou, here in Burkina Faso. I work
for coris bank international. I am writing to you about a business
proposal that will be of great benefit to both of us. In my
department, as a banker, I discovered $19,300,000 in the account of
one of our deceased foreign clients.
The choice to contact you depends on the sensitivity of the
transaction and the confidentiality it contains. Now our bank has been
waiting for one of the family members to file the application, but
nobody has done so. Personally, I have not found family members for a
long time. I ask for permission to present you as the next of kin /
beneficiary of the deceased, so the proceeds of this account are worth
$19,300,000 to you.

This is paid or shared in these percentages, 60% for me and 40% for
you. I have secured legal documents that can be used to substantiate
this claim. The only thing I have to do is put your names in the
documents and legalize them here in court to prove you as the rightful
beneficiary. All I need now is your honest cooperation,
confidentiality and your trust, so that we can complete this
transaction. I guarantee that this transaction is 100% risk-free, as
the transfer is subject to international banking law

Please give me this as we have 5 days to work through this. This is very urgent.

1. Full Name:
2. Your direct mobile number:
3. Your contact address:
4. Your job:
5. Your nationality:
6. Your gender / age:

Please confirm your message and interest to provide further
information. Please do get back to me on time.

Best regards
Mr. Ibrahim idewu
