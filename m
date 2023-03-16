Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162316BD4B9
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 17:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCPQL2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 12:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCPQL2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 12:11:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A288C8898
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 09:11:27 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id r27so3004657lfe.10
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 09:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678983085;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9K9250mRicINX0Dfxf071y/GDvSJd+yQt4casiHRz8=;
        b=YDD3TibhdrHBbnKCXhCPKSGwfa1mC8JeGKiEqzmoED2IdJHOoy4Rr8Yjkc06JrH9Ls
         DDqLYqdwjSAVLP4p31uWmjzzi2YCcUUSzf7khvvL+A03rDjVLYLdH7iYaUMowWTsFPjL
         QtYAu7mqDPGeqdBAEwgjegqOJSs3kRyx83rjow3sOdPGyG3e48hp+wFa3EeL4iYOOoCF
         LbOJsl/h3UwmeLRmGXP4wEMJM86lOG8wwiwe+p45H893e12w1rivy1a6xmzP0SCQTihj
         k2783+KA2lZ4x62lgRvrZelOB8WErYQqADhoY2lJtu8TElguG+crx7+8Ib9PsZJEzJDg
         aALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678983085;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9K9250mRicINX0Dfxf071y/GDvSJd+yQt4casiHRz8=;
        b=vIpiEtx8hF5Yer33SB80+czB0fYh3oFEqsXL680W+yWK8l+Z7Ic3WFDXjmFutB9XPU
         gZ2XW0acdF5VAraZNFRwiu0ZdV1TjxfTwBe6bhIQ/9tCRGsXozBKItlNesOs0nUugDiT
         YY0QysQyE2RcoDEp6tsRc1csnLGuo1UsY6y043VQbA8DM6JVqq1DLSgGJFDym+s/6i/6
         uvK3nuYJK1zRmXLPfBFck0zg7DLhcx43uZlqVorE2imtFzQzoYhWKqKGCqlvaew8aI3L
         IT4F3miLzkkdNe4Jcjim2B/w3fU3xNRSCQ2CleLKGL2DjVSEyBWcZWd3+88Xzdg9xm1M
         Ju6A==
X-Gm-Message-State: AO0yUKUKp9dPZJe3ubl2Vd3n9gMGahN6C53t0eE/e7wdpIk3S0IXehP/
        cE3G6BIzk+miZhd8KdYb4m+3HjoNsk9LxmeHsoY=
X-Google-Smtp-Source: AK7set9uc0EUKv2KTzjmVFJ5ZFMVh4bOYDiekeJM8Ok96dc4byANDGftyQhQcMy7NfuHpWIGOS32i3ahgoRPSKFqxg0=
X-Received: by 2002:a05:6512:3b22:b0:4e8:4409:bb76 with SMTP id
 f34-20020a0565123b2200b004e84409bb76mr5255627lfv.2.1678983085479; Thu, 16 Mar
 2023 09:11:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:651c:1059:b0:295:ba26:8ad0 with HTTP; Thu, 16 Mar 2023
 09:11:24 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   Sgt Kayla Manthey <ramatoutoumey1@gmail.com>
Date:   Thu, 16 Mar 2023 16:11:24 +0000
Message-ID: <CAFFFc6S1uG1zTkjoh3zw-HrUMkWo+eAPdadmjQWXRKKR-PQwbw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12a listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7023]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ramatoutoumey1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ramatoutoumey1[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sgtkaylam28[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
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

-- 
Hello,
Please did you receive my previous letter? Write me back
