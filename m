Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD8C6A03C2
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 09:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjBWIYH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 03:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjBWIYH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 03:24:07 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EC0193F6
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 00:23:54 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id j17so10290281ljq.11
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 00:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=enmI0tN7zqlN2rfSjPKH5Df9NY9kF1JpU13XAsuLLS4nTlj0ek0OLV0mKpQRDEYn2r
         Ivn8aFvrt3+jVj+bCVnGfDptL1J6bLzFg4HvKNIhvdgwFDA74GN5yKbUfnBY/12d+xS1
         e8Cl4+ONcJOhpsvi9n4OBI2tfgpQoUzt1KhPsX4b8KGFKYWObb0azD+kQxJ5o+oUOsys
         Ts57p99F3cdZhp3jAvHLYdAl1pWWKnBYTvPf9ygnqejpX6OnkNbE3WBt/YLFFwl95X7a
         YrJCN0hPx2Blsu1te4ne4VitoftmCqa6zobQLUDt2MG0tlYjitKZqRQDLPTWEXctj+iZ
         uqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/krrOzf32PMDRBi/P9qe9m671OONK8NSr+9AstJjJkE=;
        b=vi4GDEVanih5Z9mjE6PNzbj5Kayl98PbXbXuWL014rkaFL2g6kpEOFjeEXbqlKjj3d
         4+TQpcjd2f9gM8U/Kc1/Ql/W7O9cRCgtun/GiQCNX5MFzhcmJyhae52q9QuUEGtaN87s
         Ly3u87yUUpvZatJTbM4wHVjPT5+77/PQJtZkg60rFXl0fH2idcXCAmW0JPEi+1N4K5KQ
         Bk9djlvVIFb0eknabOTnvOa5XffqGkv4amLpA8HEcq1L/D+TVwlbxbaJXtgr8hwEfqcT
         Abs5NTz1WSf4OYzfO11APgzKpp63icBzWizWOST2HCHSGUC3tjc95HmUQtExg/JnlKRq
         TCgw==
X-Gm-Message-State: AO0yUKXRT0+7Zitnz26vC+wChCGJwnnZafWiniXZYTVYz2jV947kz2sC
        nVAAQR3mr34U7W023teuHji9R2F0oh7ShBIezGM=
X-Google-Smtp-Source: AK7set95aiMEdvWxgLjHOopfRgebqjWvDzzdkC1gHoNtOijM40JliCBlMaz771CuoKpd7t/6CAV8JjhVNOOqXgrg9uc=
X-Received: by 2002:a05:651c:484:b0:295:8918:9d7e with SMTP id
 s4-20020a05651c048400b0029589189d7emr2507885ljc.1.1677140632683; Thu, 23 Feb
 2023 00:23:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:9550:0:0:0:0:0 with HTTP; Thu, 23 Feb 2023 00:23:52
 -0800 (PST)
Reply-To: avamedicinemed3@gmail.com
From:   DR AVA SMITH <tracymedicinemed005@gmail.com>
Date:   Thu, 23 Feb 2023 09:23:52 +0100
Message-ID: <CAGvfcMxhbELX_+vU96UzE-xuLWOkrDyi_GgEpBq128sv73_OSw@mail.gmail.com>
Subject: From Dr Ava Smith from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:234 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tracymedicinemed005[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [avamedicinemed3[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tracymedicinemed005[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello Dear
My name is Dr Ava Smith,a medical doctor from United States.
I have Dual citizenship which is English and French.
I will share pictures and more details about me as soon as i get
a response from you
Thanks
Ava
