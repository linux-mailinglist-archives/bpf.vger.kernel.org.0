Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB845B3A00
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 16:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiIINyf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 09:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiIINyT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 09:54:19 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B67814483B
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 06:53:56 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v1so1845872plo.9
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 06:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=qjkcNlIH0whMTU2F6KeM1yLo/gpgHOi/0YMyhWrsTRWaavmNRPmR/DManAYWb+narH
         1rBHZYylzNikrQQgc9v6cmdU6KJB2x8XwAg3qpTVkjRw8ueeGSbZpIQJIyl0GvgW+II0
         uPOi7xuv0CKTt8hPZZBj+KvFz5c9PONYk/scbxk2GptK//dFO2nzUKXxdQ3DVcFtJoKO
         1Ro+245WM1LeuCXTHElNmxL5/3JDF2P0FiIMykBqzkKKrPuPsc/FyM9a5KmBX9IcN9RR
         t9TMuA/m2pYwm2hhtHGYJlPwKTTP/myuMqMdE8KyiBSxvSQ2WwPKXGy74VpY8yL1c1iD
         EHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=0d+vA8rUH9pQSjlM+HPH3UZcJgpSArUk10ACslg/gOjWUrWOpqEy3TU74NGFtj3NAL
         Ce3f1jeWK9vZbNNj3jdQm78VxlYq6pMnC3nbv36jrYjhTHop+XvMVAL4VE7U24ygxlGF
         VZeDNA9bBk0GsZ6kunc2zkz0Nk1mTE+5kFc9CON5HdwxoGSaVy8JQU6HrThhDBtubZD2
         fy812/6Xx6/kgh1uiHdPJToG5EpG8x7/TudhwgyVr7Hy/FN3Jon7aqATIi4wFLp+TCBE
         ONm4BcOwzfcku1inZWGYbdreUkvHXTY6rywCe/lByj25uQQS2S8yrhirC/epg4BVIu7Y
         mfCw==
X-Gm-Message-State: ACgBeo19OfgnU8P8Yi/n2/z7FZ63RVrye1a+Wqa8XPbh4/XDhfRbQRjh
        ZsxWYK12UAOWBF+EbrsacrHhcULCtLSQP+meeLM=
X-Google-Smtp-Source: AA6agR5JPRitbwtv5X6RraNxIBBUA2OAyGn4UbeJQJPZZTKYxTCRmxu2aRvsjnn1+82mnzNdtKwLXTIM28qUqDTEJag=
X-Received: by 2002:a17:902:8f8a:b0:170:8df4:eebd with SMTP id
 z10-20020a1709028f8a00b001708df4eebdmr14043293plo.116.1662731635767; Fri, 09
 Sep 2022 06:53:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a06:168b:b0:574:9d:8b42 with HTTP; Fri, 9 Sep 2022
 06:53:55 -0700 (PDT)
Reply-To: maryalbert00045@gmail.com
From:   Mary Albert <tinaevan26261@gmail.com>
Date:   Fri, 9 Sep 2022 14:53:55 +0100
Message-ID: <CAD13F+WoC66h8BkReAbtiK_eVvaW70GnKFrgLCWWHmW+YU2pQQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:634 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4991]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tinaevan26261[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tinaevan26261[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [maryalbert00045[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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
how are you?
