Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FC55BAEA0
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 15:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiIPNxz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 09:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiIPNxq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 09:53:46 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369D7AE85C
        for <bpf@vger.kernel.org>; Fri, 16 Sep 2022 06:53:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id j12so21295100pfi.11
        for <bpf@vger.kernel.org>; Fri, 16 Sep 2022 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=AdLD2x+/b68/HDNyNupubD5hr9rf1FZwromosVpJYvOlA9kvgnJlPpq8MQXAiB8KSX
         GhFR9WnfFGKJqoqpIgIkRJObR3ugnV9/WPxKysCJzeLAmDD+5HFLI61im/91PjNxO7wC
         jqeCwhM9Utwm09h/3lhuXJZgPy74TPh4G7pFGom0nYT3FgznK9/zVuFFVc4+I925bfxy
         pzvevakHMVghfzbsUnYcfuufjURMdQuVMAX9ZQyU4hXeUohvkRXZWtXzyyYg1zA/Sv76
         u+uimI2GZUzPz6I2KtbN+mQkQ0IL8yCZyHgyFBa41/mxAu+GpT77MTywgJx+PfGRmXzQ
         JABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=S/zkbMnjPp1RIshjOKupJKNJgH2Te+CRZH0ynI0vFEAgPJSAAO7ycAxq6O4MaLUGXO
         iTDcQ5JtCdfJydvL0KWxwioPAKLu1MaTVUpLjeRU9L8J7wX0NndyDJdM5Z9HljOUfCaH
         2W4dzwPDuFg6glE4aFz+TtQA9gR//g0zNF/2ucq33x0qQNTg8TbQuFAYN/AsvUkVG6cv
         h9JRqoMv2veJHdkWkVncNpgYaFHSsHMCZjxI62RfMyckYAXUJdwx+jrgyi0zIWZ1ZXl5
         tg6LBIMvJ6mcwSCNKaUw9yb2MldEReMsttCY3h2eWPlKEsRXOJ3ukT14NEhBreOyYU2+
         cxhQ==
X-Gm-Message-State: ACrzQf3BDL0LVjPj2Nj55buDXRhDj3PWi6TRedSAHGQwaE0YcI0j4NX0
        1wo7OhuQU+zCT4YMThgmsVd9OYvG3bn7xfqqjIU=
X-Google-Smtp-Source: AMsMyM42KgpK0Yv9klxkoPlc15xgtO7WVMk3Jknk8jrLMKFoXN1hmUep2m+aHWKAIw2mDyXDwDILLeGYijbR3Kj/qyo=
X-Received: by 2002:a63:d94a:0:b0:412:6986:326e with SMTP id
 e10-20020a63d94a000000b004126986326emr4741190pgj.56.1663336393910; Fri, 16
 Sep 2022 06:53:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:538d:b0:68:35aa:417b with HTTP; Fri, 16 Sep 2022
 06:53:13 -0700 (PDT)
Reply-To: davidnelson7702626@gmail.com
From:   napu johnson <napu361@gmail.com>
Date:   Fri, 16 Sep 2022 13:53:13 +0000
Message-ID: <CAJhLzrpvixvsX3T-+g4LSiEz_gfRps2CF_1qhxxVrauDWLWr9Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:432 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [napu361[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [davidnelson7702626[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [napu361[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello friend, I want to send money to you to enable me invest in your
country get back to me if you are interested.
