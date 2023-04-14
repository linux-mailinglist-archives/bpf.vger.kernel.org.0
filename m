Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987C86E207D
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 12:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDNKOK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 06:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjDNKOI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 06:14:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB3A8A53
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 03:13:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50489d1af35so4841723a12.3
        for <bpf@vger.kernel.org>; Fri, 14 Apr 2023 03:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681467203; x=1684059203;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNCYWc3+395/cdIb4O8onIiz31xrMP58ieof9MiWNmE=;
        b=UIntHyPrs1hGBGzHwHDpDgYYHxlISlqH4fTM/0bOWHnS2XasI7EViBoeYkkpx/1fkd
         r16diKh1mEuC5uG5pvQ3gPyaLEoLTIV5y6n0FQ+eIkKc6hWv9RWAH8lRZ6PcCXXw5eR8
         y6qWm58Z4TQNfSQo4uS6tgzEiB444IqUrFFX4gfVLs2G+9jcIFf4maMk9TUi40bwC0Rs
         IyYY7o6AFQApXoQMFwmFpYhTDtYGzM+jrJR6evyeDdYD8mNgf35uPVzi3XHLwK8PDmNv
         tyuWuqbfWeliTLR1ojujECXGZcr9wk+AlP4RNOjjVuS67i9QPXJ7Bw2fqpztGALCFLBc
         1DHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681467203; x=1684059203;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNCYWc3+395/cdIb4O8onIiz31xrMP58ieof9MiWNmE=;
        b=PseOvStSbzrWvWQwFaV3KDuGPNgDbNLE77/DI5jhQ6Go84jAxbyhXaIchr/E+huw9C
         FftR5HVOZhksrabDH22Xt99r5F41KQdasnMR95LBmNLKAJXg9riTsxUx/Wr0QCjeW/pE
         1j2Kf0i3T9pBE4W1+OK+pIXnbXwjmy+p3am94BsO80ct+8eamP64UZk5eCQ8NotOC2fw
         CF/SrNj8lQ/JrK2dIw9O7W99LVR+7nb5pNAPQW9tWXeDcEwHs4J7tGUdY8X4MX0kV7dv
         3Ha7AeQD0+SwmSPoCd6kjTUTB5XGzvCzJ3u1BKtzXzw57d9D2pruj7QAiMJ6Rq0kBD3T
         EH+g==
X-Gm-Message-State: AAQBX9fPR3tXe4BNJ3ZkMDxKLIipwm7SScfbaJc50c1ExeLkuVVFsZhQ
        bTXQbkPa/UKneutXfMrbAOELGThakQvw0ketozI=
X-Google-Smtp-Source: AKy350bbh+lgWcf5AiV7kOq5Vuj90rJiVnhBTsRk+avGiWzfJMJJrvDkTTXJrmzONchm2d+B39netfdLkfZr0y+pVZg=
X-Received: by 2002:a50:baac:0:b0:504:a610:7a3a with SMTP id
 x41-20020a50baac000000b00504a6107a3amr2800159ede.5.1681467202531; Fri, 14 Apr
 2023 03:13:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7208:396:b0:67:334d:71b1 with HTTP; Fri, 14 Apr 2023
 03:13:20 -0700 (PDT)
Reply-To: roland80@email.com
From:   "Mr.Roland Philip" <michaeltobogin043@gmail.com>
Date:   Fri, 14 Apr 2023 10:13:20 +0000
Message-ID: <CAGCJN-zgtDPdYEfGheuVEaRzgVFF1Ej5g8yH3XyQugMcCC2wCw@mail.gmail.com>
Subject: Read the message
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=ADVANCE_FEE_3_NEW,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY,
        URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:531 listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [roland80[at]email.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [michaeltobogin043[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [michaeltobogin043[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.6 ADVANCE_FEE_3_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

My name is Mr. Roland Philip, can we work and share this project
together. If you are
interested I wrote you an email this week regarding to one of your
family member who died
here in our country and left some huge amount of money in one of our
bank here so kindly
acknowledge for my advice more details,please urgent reply to this email address
