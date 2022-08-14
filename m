Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E677591ED0
	for <lists+bpf@lfdr.de>; Sun, 14 Aug 2022 08:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiHNG4u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 14 Aug 2022 02:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiHNG4t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 14 Aug 2022 02:56:49 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2A51F2EF
        for <bpf@vger.kernel.org>; Sat, 13 Aug 2022 23:56:48 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id jm11so1798233plb.13
        for <bpf@vger.kernel.org>; Sat, 13 Aug 2022 23:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=t2xo6E1uDVXBL9rtyALdnKwGeumoPy0aKoIQA7ijnWQ=;
        b=SJMFGFf9E1EEimxFA+dBib7JfbkgZlP368ioQMrzjPAO4jQJRWTPYAhkG6aIYGDK4h
         iSbR7jZO0opcyPjA184tpjpN1Hf2w7NVeunRD4b/1s5GK9M7MBYDuik2aXS2ImyP43Qj
         REvar56U4rTjUf0bOvWmbHGY4mN+UIFH1/c+q7/hw9s6iu7qEc12QKLayZGvzhclJw3W
         kAl2R6d0IHbCQsuplKf7WHdQQ2P5AV85GmluyqYQrCA/O7t0ithQG+ambGXPA1Uoslbs
         vrnlrXHlcgUg1nc9pQHfxEe/zS4PVkv7wGjdZAIdl4lNnkFUTR98TAn66ovht3Qhj29u
         cN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=t2xo6E1uDVXBL9rtyALdnKwGeumoPy0aKoIQA7ijnWQ=;
        b=bbSjUDbWThgAMSIWf776FkBo9mEIa6AcJ8q0geopfCcWmK4y+1jnHFIqULbyWjrxqY
         K8nDmm60hqEQkh1evDOqxh7KLFSSeHkErcTICUX6H9LPWaJabwn4UkWfuNAe+o/DJhtY
         WD0VGzvIqBf0rmpSbV8CsqTrVvYM/9O2cBhpjQ1KIHkfda9i9d8MNFQ9mHf2KaXjawCr
         d+VejXcIiNHzW4xNVWHItro53TiAs00qRLylyColWxjRlYPfBWWY2jyHsNRzCQLpDvx0
         7U3ufyxRwxkoA8//lL5VyOdXC1e6yLmoTpLMobxyL1fF339E+z5H8NJSJvX8DLl+GWqI
         HtnA==
X-Gm-Message-State: ACgBeo3NS8U/J0qUi9nltXlLI4SuXaoeiWZwjZR0HPrn9cLuuZ8LnPQU
        qIzWKyGCfPBt6ikDiF4Fk0GaQw3dX3dY6jzYXmU=
X-Google-Smtp-Source: AA6agR5VBXmyuD9jcB8WjE34wuRjWnlxNVjatQAhdG5ICHudA7erHNt78qX+opfdDMUq5VBV/tnMvCwY404GEzulh94=
X-Received: by 2002:a17:90b:3b49:b0:1f4:df09:d671 with SMTP id
 ot9-20020a17090b3b4900b001f4df09d671mr12446699pjb.129.1660460207752; Sat, 13
 Aug 2022 23:56:47 -0700 (PDT)
MIME-Version: 1.0
Sender: rayngwu1@gmail.com
Received: by 2002:a05:6a11:5a3:b0:298:df7d:dd9d with HTTP; Sat, 13 Aug 2022
 23:56:47 -0700 (PDT)
From:   "mydesk.ceoinfo@barclaysbank.co.uk" <nigelhiggins.md5@gmail.com>
Date:   Sun, 14 Aug 2022 07:56:47 +0100
X-Google-Sender-Auth: 8FoBN6hu0ldpjGjc1vEyyT8wiTo
Message-ID: <CAFUkv_DgfYj=TcCCvajYpROoht_2sm+rUdOKcp4Zw1wshb=P5A@mail.gmail.com>
Subject: RE PAYMENT NOTIFICATION UPDATE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_2_EMAILS_SHORT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,YOU_INHERIT autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:643 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [rayngwu1[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nigelhiggins.md5[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.5 YOU_INHERIT Discussing your inheritance
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.9 FROM_2_EMAILS_SHORT Short body and From looks like 2 different
        *      emails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello,

I am the Group Chairman of Barclays Bank Plc. This is to formally
notify you that your delayed inheritance payment has been irrevocably
released to you today after a successful review. Get back for more
details.

Yours sincerely,

Nigel Higgins, (Group Chairman),
Barclays Bank Plc,
Registered number: 1026167,
1 Churchill Place, London, ENG E14 5HP,
SWIFT Code: BARCGB21,
Direct Telephone: +44 770 000 8965,
WhatsApp, SMS Number: + 44 787 229 9022
www.barclays.co.uk
