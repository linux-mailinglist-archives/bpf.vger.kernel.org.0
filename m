Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67066686A8
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 23:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjALWOi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 17:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbjALWNa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 17:13:30 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6941955B2
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 14:07:37 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id h21so17543402qta.12
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 14:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQCpmL3a6I3MxHDBkkJKT+jxF8jK60rugL/II6rJ9zE=;
        b=D2sgxEiGAND4B42uQI2ytVsWC++ObEZqrycdu4p0cyw+s2M9C0TIMShlAz9fArDpiz
         j8mEr1hCn1Y6zovqeuePp1hYrkphWlUqhgYOhrJvu2OVJ2GaJOytcpjvEhALtre3xoQn
         3FvoIcnz6c/HecUd5UOLxCMjVaxHjC02pwQEQJsUpojyF1aiBJeFE9SZpMvk/iI6f3OP
         AnCLs4dmXVBRxwnoacbYYVxGFed/3F0ihEkQVuY2Rvr8TiaePQy+bKmonajWhUnjyVyq
         M9/DH+2BJTrLzy7SrFW9/o5faciGL28Cjl+7T6TXrILqk1WKVskCIvBpzgptpQ6qJnjf
         GOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQCpmL3a6I3MxHDBkkJKT+jxF8jK60rugL/II6rJ9zE=;
        b=z3uzwqA3hRbTW6bcRzIgGxBsUBwzkTV8bqG/Y2+DBWrtw7fd4S/iNrPyCG9LJ7RpWJ
         2TqiOxIvvgmzaegsTGsFTqt7NA4z82O6vln0oQclnORA4A29RZdM9r6KRjCs0y/CZUki
         mVomeTsfalEyIM1h3flw1y8ky1e6Q8A8NVqFlqtObd8y1zDVd+lQpEN8RHmGqM2J8lUT
         FQYG7extxFEX0u9YbuiIbVF5U+eiVN/9LG+6P84rnfatnh+69AEUKcR614+R0836Yfgf
         WlqhhOrqJDb0IWh4dkI2ZCFyf3VaBhjvXG9oKpRVR2dAM5Y5onZc/bJlF5wvTusO/G03
         g4Hg==
X-Gm-Message-State: AFqh2kqXB5THBqES+XZbg0dJa6eg4/CLLv9Jf+0Y/fmRbl0iwG60P3Hf
        LIM3qITawzXNG6YDEXG0gvtAQsO8ki0oXugXtsw=
X-Google-Smtp-Source: AMrXdXvvahVDKYIBkah3OkjZbBNSrZpBSaHutOru5w6rAhMnREhbB8a9sSmSCYJSabcHFWYgdI74p6A/Xw4RhTHkbhI=
X-Received: by 2002:ac8:7743:0:b0:3b0:4a76:512e with SMTP id
 g3-20020ac87743000000b003b04a76512emr323762qtu.113.1673561254230; Thu, 12 Jan
 2023 14:07:34 -0800 (PST)
MIME-Version: 1.0
Sender: jennehkandeh9@gmail.com
Received: by 2002:ab3:ef8d:0:b0:4b2:a25c:b9b0 with HTTP; Thu, 12 Jan 2023
 14:07:33 -0800 (PST)
From:   Jenneh Kandeh <jennehkandeh07@gmail.com>
Date:   Thu, 12 Jan 2023 23:07:33 +0100
X-Google-Sender-Auth: XmIbzuycgQaHw0Sjlr__L03NUMw
Message-ID: <CAD6_1xoMZ2Jhyd8h4ja7XQLEFqLcpfK1wfeVg_-eF3+1XSDZLA@mail.gmail.com>
Subject: re Regard My Father's Fund $10,200,000,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,NA_DOLLARS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I got your online connection - due to a serious search for a reliable
personal. My name is Janna Kandih, date of birth
May 23, 1994 in Freetown Capital Sierra Leone.

I am the nephew of Foday Sankoh, the rebel leader in Sierra Leone,
He opposes the government of President Ahmed Tejan Kubba
former leader. I was in exile in Benin-Porto-Novo. but me
Current resident of Porto-Novo Benin because of the war of my country,
my country
Her mother was killed on 04/01/2002 in a civil war in Sierra Leone. my father
I decided to change the country of residence with me because I am the only one
A child from my family has bad news of the death of my father on 11/25/2019;
During the war, my father made a lot of money by
sell diamonds.

to the value of US$10,200,000 (ten million two hundred US dollars
dollars). This money is currently held secretly in the Economic
Community of West African States
Security company here in Porto-Novo Benin, but because
The political unrest that still exists in this Africa, I can't invest
money myself, and then I ask for your help, to help me take this money
In your charge to invest and also advise me how to invest them; And
I would like to add here that if an agreement is reached, it will be
30% of the total value of the fund
Yours minus your total expenses incurred during the clearing
Fund in Cotonou Benin that 30% amounts to 3,060,000 dollars (three million sixty
thousand US dollars) to you from the fund after us
Fund confirmed there. I am waiting to hear from you soon.
