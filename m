Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE694CE5A9
	for <lists+bpf@lfdr.de>; Sat,  5 Mar 2022 16:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiCEP7l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Mar 2022 10:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiCEP7l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Mar 2022 10:59:41 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4DC140C2
        for <bpf@vger.kernel.org>; Sat,  5 Mar 2022 07:58:49 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id q10so2078549ljc.7
        for <bpf@vger.kernel.org>; Sat, 05 Mar 2022 07:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=CiUk5tIcl+PT2j32pnUdKHpgQK/0Zv+XWVWUWM992/A=;
        b=D3QBPogJt8LNLnYbtK+qpPdDewmvdn5OgHUiTxWq1N1g6x+3bCGble8/9mzAhQzoi8
         3/5xnv00TZwrXppghWHlYhqpgSP+hvafATHZHdzL58NNRvPF3xutv5GyRSY8hmKP7uyP
         lPWcZFQJwdF3r3nS0oADCWNL5Jxx3iqlpPLshH0Z7FcezAsFB4UfwPF7+jqqLC6bbRhe
         balN6SYQC3SvuQEmDJDUccTnf7l6S4NROUajnCQ9j9V/WCCh5rsPktFIZCGpraWvvEq+
         Qqum0wwb1dsOdC2IAUrJaFGHBadlXfLoz1NOUrWAa3+D4RphrPhQRdpctMVAaozmHhkP
         ddxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=CiUk5tIcl+PT2j32pnUdKHpgQK/0Zv+XWVWUWM992/A=;
        b=Gj700tDP3NZ8woxJ1jRy4HeSUIdHBwGlIs0yDnx92w3BvvREG0UBLXXvcKdeKZRn5+
         3xyUFRSg9EwwCtvpDI/0eQjuiDeqXXmYuz/Podluv/Bmn+q9/Pn+FDQFzNntVXJq2dsj
         wog+ooxReg84hGMjcd5+O5x6liBN8++eFhDzzL1znKRklic/nlDd6UuT5Bzu2TNN6hrv
         U+FDcB9pVBFeFTzvyzDzugg1pbHiv4JobmmhElqko2p0W84OKwpQn428vD1K+Ixejj9S
         H8Yqqjv1tjXgg5ao9JCkVIaAQy6L/GKdsJNsJjSUxKx5lV+29K8oqC9jnWKDfMICYf01
         dQ5Q==
X-Gm-Message-State: AOAM533b9EJwaKsgz/MpqzQrve09aKkMvA/CA0OZUzkQz8urGMlRhlQA
        5Yt0TC8fgt0Qw+SCDnSXhRCAlEEFbtB+2bB5DsU=
X-Google-Smtp-Source: ABdhPJzlMqvD4iHxVSCblRauGF5xWPSCNYQBBRQluJvIa37Bs+W5HK5VbZm1QgOWiKre2tdHivh3sqityxZBMMNJwn4=
X-Received: by 2002:a2e:b8ce:0:b0:247:deb7:cd8f with SMTP id
 s14-20020a2eb8ce000000b00247deb7cd8fmr416885ljp.531.1646495925371; Sat, 05
 Mar 2022 07:58:45 -0800 (PST)
MIME-Version: 1.0
Sender: mrkadijahules@gmail.com
Received: by 2002:ab3:6d84:0:0:0:0:0 with HTTP; Sat, 5 Mar 2022 07:58:44 -0800 (PST)
From:   Dr Haruna Bello <drharunabello4@gmail.com>
Date:   Sat, 5 Mar 2022 07:58:44 -0800
X-Google-Sender-Auth: jicsyG8tqXRm0TKp0zhAM0Q-b1U
Message-ID: <CAOvGz7SrGtSVig0O7+MZNUNp_FSrDHBi-n_b21koTT2Yaj0Uig@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Greetings,

I am Haruna Bello, I write to relate to you of my intention to use my
funds for charity work in your country.

I have been suffering from cancer I want to know if I can trust you to
use these funds for charity / orphanage. You will receive 30%
compensation for the work.

Please contact me on my direct Email: drharunabello4@gmail.com
if you are interested, so that I will give you more details.

Yours in the Lord,
Haruna Bello
