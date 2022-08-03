Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F9E589434
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 23:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiHCV6w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 17:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238379AbiHCV6v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 17:58:51 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1643D5C36F
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 14:58:50 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id c22so6173586vko.7
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 14:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=dfjnRDK8jnimfuSQUPwEDEztyFPM5Vr47com6f/m4e4=;
        b=hSmDEe4GN5b4LvKQZS99GRBDrh6RDoemksLKS5L762HcvFW1ZhFG8y/ttK9WDKILm+
         CRRg2mcMRpIDrt33eyysKc0nJmNIn8Ygs/JXwx/nXsVLwJA0F8lD2yKsE3hYhh2t4gc+
         20yYmWAZMESjirULV258BcBMCH7ZvngGD5bDg4yXNaKWU1D/0Hheyyg5zHn4dzEtGLnB
         fuZ0eH6doIWL4KdAVv723Mj/7cz9aPhWOv+Z6ZHscMd0rO6efJ5c/cGu50Mjw3NDS2ut
         tbvzlCX4PLEeBU2Mblo/j2BPb/KihkVIlVq+9PeUT7beMJdODdQrebu8Qx/3ZECvgYEd
         0tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=dfjnRDK8jnimfuSQUPwEDEztyFPM5Vr47com6f/m4e4=;
        b=hwXVOU/+QYNn6ubORkgJxAS+yDfeDPvhgrQDTluY/9UC+SH5NB/TQACEL7iG9A20aL
         M7Z2uXQCaqW5vpM/4tXPorgu9L9AH98vnEJyk9gDMN5g8b92gGGkr+Zh4yT4G8wXC7OA
         vbpP9FC9i8ENkaaip+tPFRUSfbIuInFgaiyipbUfBcVgfnPkOZc3206zPBZipwAvE4ql
         q6CbQiWmSu8Ev0+kxfBURPz3KvX7xVKjxJ5UAwvS1aPPr5pGudJSJYgW646EcRKE/6Zv
         OI4GxjuEs4oTaBhbLwsl2LhwV+m/GusFYFs7+5CdujIQhJipY81xOFg1tojLG5udBzKn
         2CzQ==
X-Gm-Message-State: AJIora9ZSBEs1qqOBkQ3jm99qsQtZXveTprJUeUdYZiK4bsnef8t3svU
        BiX5p05sjIX+4gVZXrHuOSPamL8zU4RGu8NpqxI=
X-Google-Smtp-Source: AGRyM1vZii5c67NTEUWpd/0AcFhKvwqdGxudewsl+66znvuexye+pdXbLgYgOxnaL0LxjVFnEl+BFq3RoPyLRAhK+sA=
X-Received: by 2002:a1f:2bc8:0:b0:375:21ea:25ca with SMTP id
 r191-20020a1f2bc8000000b0037521ea25camr10763295vkr.37.1659563929080; Wed, 03
 Aug 2022 14:58:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:4841:0:0:0:0:0 with HTTP; Wed, 3 Aug 2022 14:58:48 -0700 (PDT)
Reply-To: keenjr73@gmail.com
From:   "Keen J. Richardson" <shellymarkevka81@gmail.com>
Date:   Wed, 3 Aug 2022 21:58:48 +0000
Message-ID: <CAJLhD933V9QvpnXPTWuYJ=bLgQw_zf_uM5QAd1A=zATsq8=0Bg@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a29 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [shellymarkevka81[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [keenjr73[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [shellymarkevka81[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
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
Keen J Richardson
