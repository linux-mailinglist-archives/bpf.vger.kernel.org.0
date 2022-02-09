Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7281C4B0094
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 23:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbiBIWq0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 17:46:26 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbiBIWq0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 17:46:26 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0767C1DF65E
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 14:46:28 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id g14so10285370ybs.8
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 14:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=aPTFbZr4LhKGppGQDkO7tNLWiZLizgW3cwR+POXjY4E=;
        b=RUjYCxK0GpjzGui+gibPE5VEKMnPRMFYeV+GI9+6N93lqQAiUb+WgUx3+56dh6uqMk
         S+yHV5TJagKsiKJuBOq0VurlIOY5uy9SV1L87+rECBZKyPkCR0EBEAUbqkLLxMLdL6hn
         AXr8bWoxcT4iDVygMfFD8Y5wraNA3Bm10+9ecHWGDYsdgOVuf3cmbnwK1r4eoTeFIN7m
         gHK6vbiUDyjUYeie/Qic3FtYR3iJGw/rh86orip9q/aX+aHqPfReZ/BP26g7aBy5m/PM
         bF5EHNCR8fd7EA5gRKU54NLPVoc9H4JaAchELLZzG6J/RiZtOpiARt5VA5YQrsIi/wqj
         26WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=aPTFbZr4LhKGppGQDkO7tNLWiZLizgW3cwR+POXjY4E=;
        b=Gd/NYPzOGXyrK4OcVY2MSGojbxbGukGm3L6siOX3IsZUYnQJL6/6z+HlvriOPClvox
         whdx1p/lDfIXG8DdMIk0KTE1Cxb1Fb4RaabhSmplBvt1Eu10nBZR42VPFRLQI3TRJsyV
         nlccRV5FFLOWjcNkXR/R2Ushwl+PFKo/w2qy3G+O84yHPa0IO7w5e3vWDx6zIfB4vKh5
         mKEq02BCIMn22Vd/WxkOe9unGCsF0KLXy1Ww22bryfVf8d5zgv5yn4Yl4XQj+N3BF+wa
         41fZjIhLle+R0YsF8bkUXQMhfduGRsW0E4ssYIr33rrmnMZrykYldlthgj9Zck5F8dVw
         UUFg==
X-Gm-Message-State: AOAM532/0mER1KyXpEx4YDUnODNRe+ER3F9aptCFQTCI5ieNvsjaT3Cj
        DLeH+HbKqUNH/HCJtiIYE3w3fFV1RYUY3FdGNUo=
X-Google-Smtp-Source: ABdhPJzN2rj0tzCcmtlQvMm+tUQxi7yOdzjZlwM9nylNY6hlRfBFAwIxqmyZOkF8w85W+y7/oL40UivdW9s5nW+HFAw=
X-Received: by 2002:a5b:247:: with SMTP id g7mr1503262ybp.97.1644446787973;
 Wed, 09 Feb 2022 14:46:27 -0800 (PST)
MIME-Version: 1.0
Reply-To: dr.tracymedicinemed1@gmail.com
Sender: ra00028671@gmail.com
Received: by 2002:a05:7010:4da9:b0:20c:2ace:da88 with HTTP; Wed, 9 Feb 2022
 14:46:27 -0800 (PST)
From:   Dr Tracy William <ra6277708@gmail.com>
Date:   Thu, 10 Feb 2022 06:46:27 +0800
X-Google-Sender-Auth: CpecWyAoVKDqGJd4lD_OilNm65E
Message-ID: <CAEWKTYf--+WYuVus13F4pTQPP9NcRh0bhELXAOt2yuOo77ft1w@mail.gmail.com>
Subject: From Dr Tracy from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ra00028671[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ra00028671[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dr.tracymedicinemed1[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Dear,

how are you today,I hope you are doing great.

It is my great pleasure to contact you,I want to make a new and
special friend,I hope you don't mind. My name is Tracy William from
the United States, Am an English and French nationalities. I will give
you pictures and more details about my self as soon as i hear from
you Kisses.

Pls resply to my personal email(dr.tracymedicinemed1@gmail.com)

Thanks.
Tracy,
