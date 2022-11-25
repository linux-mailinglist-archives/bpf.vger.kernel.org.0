Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81640638DB7
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 16:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiKYPu1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 10:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKYPu0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 10:50:26 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E3022BFB
        for <bpf@vger.kernel.org>; Fri, 25 Nov 2022 07:50:22 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f7so6917883edc.6
        for <bpf@vger.kernel.org>; Fri, 25 Nov 2022 07:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/htPiokpxlSzvGlhsl1Xj6H5P5GA8oJZklSjRGzFbNU=;
        b=HWGQK9dOvskuYZ4g/mLbrmgmdPS7LvzwMQKN37jfIFLPxg+ew/NZBKCPNvHSjCoC9A
         /zzqOs8YaRbWiAmcPKAqd3SgyxSBuOOrt+u8QBafWKi8x+DrJZy+awTnq304EIpIZE6v
         UF4H4OL3xYFQ9V7U19mCdJbtooRqfuXgPaVJcc9RIUtQRXs4e2NkkoNiDfSJePdrllWU
         Fy51aY9v4cdBHidiQDvq7UrpjX0LFlyk6JIr/rAlCXA8u/dA2tg+++BZbW9OUSsqeOIa
         XW/dbMpf6CeMJHI8mkIdpln27dHKDYHQYX1tGItXaCkdecBUGNtNDKYa5FFYx5jr1e/S
         KyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/htPiokpxlSzvGlhsl1Xj6H5P5GA8oJZklSjRGzFbNU=;
        b=0QngM86a6esPxCCfIlc4cSU9M0zsm7H8EhkDrPI3U9EkyQY39q5iIOyJUUF/1rWiLB
         DyW4btckeE05kmGya/QqvYpsiZE8lkqI8hqZpXr1Vl5VK5RwQnWvtPe22cTSDj+9CY+v
         /ZIEQ83MQzjWwee6O30KwT7YFpyyfUakE7TLehFE+bu6X+TYfMQnVCj4oQ04MpFfO3LV
         FqjzcvWWg1NsM5d/51aaICVbETnpnS+BS2iLHCx9YA3dqz/uso0snex2s/MFZz2t4SMB
         FJAdm8pACojDU0/ujZl+AjrJB/QREblbj2hfy+Mdqixfh3AMYf9FTy1K2bQ0wZ2gWsGA
         piEg==
X-Gm-Message-State: ANoB5pnx+mibnYof35ZAGxfcLPg40iqvm5oZhmbPh4czvF4SeRxbsTda
        +WBpCFnLHo6YvOzvrg6MTNVtWbH/NDkRY5A9Qtw=
X-Google-Smtp-Source: AA0mqf4Xt8buqU/+6y0RKigwOF/YT+FNz+HoGbuvpCfBokVA44akCQ6vWHgyFW8M+wCdIaxph00yA46QWg5P29EzrSU=
X-Received: by 2002:a05:6402:4:b0:463:cb99:5c8 with SMTP id
 d4-20020a056402000400b00463cb9905c8mr35565550edu.395.1669391420643; Fri, 25
 Nov 2022 07:50:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a50:3199:0:b0:1ea:6a7a:46e6 with HTTP; Fri, 25 Nov 2022
 07:50:20 -0800 (PST)
Reply-To: davidnelson7702626@gmail.com
From:   thuma <blaiseagbo940@gmail.com>
Date:   Fri, 25 Nov 2022 16:50:20 +0100
Message-ID: <CAKkVg-wunFKt9A2P4pfzYMHTMu4bx=fRwv-FCPNZ1_e3qhuLxg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [davidnelson7702626[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [blaiseagbo940[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [blaiseagbo940[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello friend, I want to send money to you to enable me invest in your
country get back to me if you are interested
