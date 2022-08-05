Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DBD58AA21
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 13:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbiHEL3t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 07:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHEL3t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 07:29:49 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF28B7F7
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 04:29:48 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w10so2434810plq.0
        for <bpf@vger.kernel.org>; Fri, 05 Aug 2022 04:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=coS9yaiFpBby2OfoSNqf9gzdn43j/VET3bvDzCGocjQ=;
        b=ETB8t3aanRgSam/qSFMtDERq5BEJ1X76mySN7ii26h8lFP6D3uebmY8nA9pqXrDxNm
         u/h5uG4tO6aZqJ7qRt6yd7Gdhw8++rAc7uhLaJNtvF8CNYNoATtopJcDAlIs9KxNv+Ov
         PE2K6WwV226a9fYCMpogzfiZD9QuZcgSKseAN/FwaSJ2wqHbpMjUDgBuDgk3MTUA9VVy
         oMWi+3d6b1J2f/4UwvxwNiE4nFWYInXBVb3RgUjR6/4dv/KwtnQqeDZ0uqP3fmlCU+zu
         RLLBxENlqah6SS/Y39DlEzY3E5zVX7USEDHN5vOLJIu72SSZ8How4Dr5HyWAtDoFN0N1
         +Cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=coS9yaiFpBby2OfoSNqf9gzdn43j/VET3bvDzCGocjQ=;
        b=3wvR8uLSPWvrcw5cuGIRrBq+7m8d509gMDGBlcbPZcGAIEy9BIdL8L8s9rKmZjbUpP
         saxqIEjRgiT2MyZqEokzzgVsyKStBobR3Up6Y0S42kxlcqlR8kds7Oj3psAU4zVhCg5A
         jbUHg91psQhuSkB7iq7AGIxispnVEQWWSHO3hmZ1y8suCDhADAHXd0LuVxSz4cNy2aOn
         XQ+Dy1vgojmrVDVabNRb0jHrW/NlqsrHU3dgwKW8AMO1iamUPwATKgbEYltHb11AUrSC
         qHH7xVYWLSAeKsC60kY5icFiYynqd7lEGdpIhLV5N6/GAOWtHdWMt2fVeR6EAKZ2lhsC
         xfOQ==
X-Gm-Message-State: ACgBeo3A5Kzk1I8KF38u2OmoBzHdf4yOwudBA8L1abVpvBOUyb8JNrPq
        hDqTGTiV/GLefmtBGMtvpp92/VkuQrx8+5IGEA==
X-Google-Smtp-Source: AA6agR7z0UsRE66gn9a6d7Fr8Ts9ZCdv4NOQXkQVOOFQgp5SXTdqH3HN+P5q8rMW8ezu+7aZe9tU+k+9KmDvKNYEyMg=
X-Received: by 2002:a17:902:c94c:b0:16e:ce7d:1fe with SMTP id
 i12-20020a170902c94c00b0016ece7d01femr6491727pla.168.1659698987783; Fri, 05
 Aug 2022 04:29:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:cca2:b0:2d1:50d0:5ece with HTTP; Fri, 5 Aug 2022
 04:29:47 -0700 (PDT)
Reply-To: cynthiawilliams777@hotmail.com
From:   Miss Cynthia William <verawilliam999@gmail.com>
Date:   Fri, 5 Aug 2022 13:29:47 +0200
Message-ID: <CAHX9pdb1Hiza+fvAoDUdU4h=_XkszLRFybUVDkjA=v_LreHS3Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,BODY_SINGLE_WORD,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:62e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [verawilliam999[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [verawilliam999[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [cynthiawilliams777[at]hotmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 BODY_SINGLE_WORD Message body is only one word (no spaces)
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello, please I need to communicate with you,
Can I share words with you?

Cynthia
