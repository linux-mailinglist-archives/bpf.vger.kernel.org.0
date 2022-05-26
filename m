Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186A75351A4
	for <lists+bpf@lfdr.de>; Thu, 26 May 2022 17:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiEZPr7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 May 2022 11:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiEZPr6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 11:47:58 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD05CC169
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 08:47:57 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i11so3516843ybq.9
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 08:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=97ymZEZwGq3ZkaE++ChZlElZU9T/NCpyjfxcrZEDWls=;
        b=V2LLi4te5+fOPiMPDnaPlY42cNS7kLGM1GlL8ZlfUpxzmrZ4xBwL4txUqFci0l/o5G
         LCzuWFW0ZxnP1oObnhEhCZdkNrBiv6sZR6Q2vw3Lppl5c57y8t/lNRULwTMcMI/SjVaU
         DLSBzTU73o5Yw1KhOAyayGYeOTB7fwAzFy8WMq0Frq3MkPDNhWlNW6Z5dGwBvLKkKxWQ
         C4HH05B19TAK08Y++sm9mxPG2UMNMx3yFl7lZWTLZXMqbptY0SyKYvdnE87XA/yhgtD+
         I1Tnv5lfC2U52POjUHVwk1spDyE1sQAj+lPiP9CGINlxRElMKkXfSVFTfm1ru67+s93V
         BjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=97ymZEZwGq3ZkaE++ChZlElZU9T/NCpyjfxcrZEDWls=;
        b=uUC1Xwx560yozO7QI+fFUxhclUBwD7hxCJthN9ck9fjw3a8pyUa3mP1rn46sLoT/Dm
         OpAjH7IVanQoza7y4FbxK0q1vazFmfg6ASfuPcshG+U6Z6hjhrmdarFTQu0vlSQOD5CB
         159VtIad1yhcLKOYGo93H6Kp1Qv+OYpuqzgtiS2tZqgQSEygZRVQ3gCQAcsARHadsa3A
         Qg+8BfBI6mqdCgft7bLssCVYv1LuUHm5AyAZbYa9gdIvdGkDPS5na/0tBN9ThVCm7jXH
         OQvJVkRnmSymToyfL087ttoe2Vf6gm2HDiWtLt1WsNcH5othq4IG3HwMzTMIlfpespBo
         7B7Q==
X-Gm-Message-State: AOAM533arRxn4QX0V+yjRzQri8RYBWJFkIzthL6dtV9RJHPoY5wG/PRK
        6Mvh7EfMWuVaBbStgoMHFQ/oF2s2Kkb4T8ohLiM=
X-Google-Smtp-Source: ABdhPJyYcSzlljq+IR88/7k048VyiJcDlpF2m8MpNpj/eLyKFm1yii47ZmVEgslEHw6ZAZE3xcc3loOf204eXRgajJM=
X-Received: by 2002:a25:7602:0:b0:64e:a27a:1520 with SMTP id
 r2-20020a257602000000b0064ea27a1520mr37151018ybc.618.1653580074276; Thu, 26
 May 2022 08:47:54 -0700 (PDT)
MIME-Version: 1.0
Sender: ibrahimvivane65@gmail.com
Received: by 2002:a05:7000:b902:0:0:0:0 with HTTP; Thu, 26 May 2022 08:47:53
 -0700 (PDT)
From:   Sophia Erick <sdltdkggl3455@gmail.com>
Date:   Thu, 26 May 2022 17:47:53 +0200
X-Google-Sender-Auth: AN2HXikpgCERnNgVZ0POqrvC38g
Message-ID: <CAGCMmKcf1RqsTa_VhyqoUYHC7sWVQdFQA8OgAwrE+Hk9waLZhQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HK_RANDOM_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello ,

It is my pleasure to communicate with you, I know that this message
will be a surprise to you my name is Mrs. Sophia Erick, I am diagnosed
with ovarian cancer which my doctor have confirmed that I have only
some weeks to live so I have decided you handover the sum of($
11,000,000.00) through I decided handover the money in my account to
you for help of the orphanage homes and the needy once

Please   kindly reply me here as soon as possible to enable me give
you more information but before handing over my details to you please
assure me that you will only take 30%  of the money and share the rest
to the poor orphanage home and the needy once, thank you am waiting to
hear from you

Mrs Sophia Erick.
