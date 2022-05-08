Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2316E51EBE7
	for <lists+bpf@lfdr.de>; Sun,  8 May 2022 07:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiEHFXR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 8 May 2022 01:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiEHFXQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 May 2022 01:23:16 -0400
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B282C6591
        for <bpf@vger.kernel.org>; Sat,  7 May 2022 22:19:27 -0700 (PDT)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-2f7d621d1caso115803357b3.11
        for <bpf@vger.kernel.org>; Sat, 07 May 2022 22:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=boZL8sxWa4d1tSO8Vkf2XAGcnSBFA0JviefhzZinYdg=;
        b=OMhZgX8Tl+5XlEFHitg/shnltUikmVhk8jziKNAQgHkNSI8OoWFe88UuqBWxsaYG4b
         keCIwbkyiaMuEy/n1iKbSEP73a+VHXXRWSe2vHkEfKfe5hZ6Zvmv1gT7LCF0V8R46Sqf
         OxdZDUripwIqJS8ySMJWfXkl2/EBHEZN2zbCz+GP54lTyVxSXytDoFqV3FyRP71bYi2A
         UoCmP+gYYTvJavaxUa++AxfkMcti5XSzJBggaGC1xhuhW+kkc7+SL5EUN636qO3yAL0u
         eny0UI7nlM9KIThMZuOigZN4YYYkGX43WgOx+I3Z/LMx4yNxSjhtvHcnZlXWz8acRENW
         Gb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=boZL8sxWa4d1tSO8Vkf2XAGcnSBFA0JviefhzZinYdg=;
        b=PtnexDtwgG4drRFvWO3JYZb36fIum3on5b3Y09Aileq3oFxy5K2R+nWp8VvxFS0E/+
         q+FUv1P9QGFZEdmWJrnKuKuqraMQv9JRUiEp+Ez8m2+Thlo8gwYcHDiaFV6kWzNEvTOG
         9GBqC5NCr3C45ouBLH7x8GvFmj9ueapXWrHOei91LLFOA8ZpBwj3VVrKIuOJ2hepRtmS
         DhJZD5dhbn0AximFjpdBR1TzpMd2hpZ5mj1xVtuW+VS9DKEGDawXTDKX22pFn6rlanFX
         IC8H25cDTL2zVf6XacsBwKn1V7xJ2XDy8YRnGIZxeA3hhReEYVYJTFi8kq9Jh747EfH1
         UAYA==
X-Gm-Message-State: AOAM532qoeAgAXgwXr80NNzfNxeLEDQzwOcvD6RRpGKcPCnjFUniTRJP
        9pBR9UxtqEMgtzxhojqcsRuzE9RvVLoKDyP9p00=
X-Google-Smtp-Source: ABdhPJzDIfwDq2JHUZKwPunldWXOg1YzGvzl+vmV814Vs+icgU8WGfeSKTC2n1/ostkNGu4MpwZkxNizpFpp6cpKOkg=
X-Received: by 2002:a81:c443:0:b0:2d0:dfa3:9ed9 with SMTP id
 s3-20020a81c443000000b002d0dfa39ed9mr8694871ywj.220.1651987166646; Sat, 07
 May 2022 22:19:26 -0700 (PDT)
MIME-Version: 1.0
Reply-To: azzedineguessous1@gmail.com
Sender: fatiskoumbousi@gmail.com
Received: by 2002:a05:7108:3a01:0:0:0:0 with HTTP; Sat, 7 May 2022 22:19:26
 -0700 (PDT)
From:   "Mr.Azzedine Guessous" <azzedineguessous1@gmail.com>
Date:   Sat, 7 May 2022 22:19:26 -0700
X-Google-Sender-Auth: PUX3IW3qZH56_i5QvD3Uolhcuaw
Message-ID: <CALtGhaPDKKZ5WhnenbOOpmp-4yvByEyNROGJvXZcPPBXbC8qTA@mail.gmail.com>
Subject: VERY VERY URGENT,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,HK_NAME_FM_MR_MRS,LOTS_OF_MONEY,
        MONEY_FREEMAIL_REPTO,NA_DOLLARS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5088]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [azzedineguessous1[at]gmail.com]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1141 listed in]
        [list.dnswl.org]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [azzedineguessous1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.5 NA_DOLLARS BODY: Talks about a million North American dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.4 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Good days to you

Please kindly accept my apology for sending you this email without
your consent i am Mr.Azzedine Guessous,The director in charge of
auditing and accounting section of Bank Of Africa Ouagadougou
Burkina-Faso in West Africa, I am writing to request your assistance
to transfer the sum of ( $18.6 Million US DOLLARS) feel free to
contact me here (azzedineguessous1@gmail.com) for more clarifications
if you are really interested in my proposal Have a nice day

Mr.Azzedine Guessous
