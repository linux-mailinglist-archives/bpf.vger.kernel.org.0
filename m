Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D8E552EED
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 11:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349198AbiFUJl3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 05:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349278AbiFUJlG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 05:41:06 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2911B275F0
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 02:40:46 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-317741c86fdso123031977b3.2
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 02:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/0bRExIb6Mv4sy5raFRmeQINC+UUx7zEZcUUOWWOPJg=;
        b=FKASb223d3NtQMBP5RFeOXN8P5DQKBcTJ4QRO19It+KvFk7OoqZ0LY+SnXESJzqqMs
         lfDl3HKAsgjnf77inGhyMfyUPW+gehhHUcwxRcYdFe6WkOfCq2z2M/6PDQ/0TVy21NBS
         Iygtd4xmTrIfD9GTsPMbvS+k5vJICxMpU0oD7Df4yj0CXeOxzs85EyDtxsNYT2oVpcHN
         xhx8VFupooD1KEcwkZpkE4SKs+sLm4KHZTDwNmOZMGcRpWiK3jxMWd/BOMAvYgBQDht0
         j9igC/CZQLX8d72bCNggwD3GKX1HBiOqNQgsEQY797T3zvcTFVxbgPY0qY0VcLUJkhbF
         QMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/0bRExIb6Mv4sy5raFRmeQINC+UUx7zEZcUUOWWOPJg=;
        b=n+uS6HX8RMMW09/kY+t4ezQl+iuIJZNA+z31ZI3Wi3Ks/s8dARvbKOJxZziCqEznJf
         KWczB1FM0KoEd0isG1DxS3JM0ih/TP05q5iZDSZzVBZMJ6kvyqX2z7JVanCPXNK1/Ick
         BVCs40ZS0S/CeboMEw5amGwkscFDAFsg92YiEUx2ZvekY5hGjJMsZ4JNvHxwC6pt1epT
         pHtFgCQdan5VXVeUH7o81DUnHX2GTk4KS5bugyER+TrnZuUG5/PbyfEAgeYIGcxTcVTg
         2gNVoZC/esNvGV35ZFFlfjFLU3DRcPLOrFbGGJ9zTYbZvHGb9Ex9Vw5/KxNZmnsx/qyJ
         NQ+w==
X-Gm-Message-State: AJIora+Gg7nOjxaoqnQZmGrLGTniF+GlIXnDG6Yqg1IVtG87B39NlFWW
        tbui5ga9NQH/9mR04M7Y5nm8TuTkEuFYAkZ7x0g=
X-Google-Smtp-Source: AGRyM1tvUOMq0dP6kPGJWYLIcVNsK+vhjIL6HHZUPVMJgQYZULc+k5Gn5MHTe3oSh8hINosUy7J+fiZtAW+V3I/oPGE=
X-Received: by 2002:a81:9103:0:b0:317:9522:e7d9 with SMTP id
 i3-20020a819103000000b003179522e7d9mr19220965ywg.61.1655804444892; Tue, 21
 Jun 2022 02:40:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:e10a:b0:2d9:e631:94d0 with HTTP; Tue, 21 Jun 2022
 02:40:44 -0700 (PDT)
Reply-To: dimitryedik@gmail.com
From:   Dimitry Edik <lsbthdwrds@gmail.com>
Date:   Tue, 21 Jun 2022 02:40:44 -0700
Message-ID: <CAGrL05bYBDDFjz8tb3skfCP7XM=q8os5O9pY=EqmRcH8FFAS4A@mail.gmail.com>
Subject: Dear Partner,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1132 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lsbthdwrds[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Dear,

My Name is Dimitry Edik from Russia A special assistance to my Russia
boss who deals in oil import and export He was killed by the Ukraine
soldiers at the border side. He supplied
oil to the Philippines company and he was paid over 90 per cent of the
transaction and the remaining $18.6 Million dollars have been paid into a
Taiwan bank in the Philippines..i want a partner that will assist me
with the claims. Is a (DEAL ) 40% for you and 60% for me
I have all information for the claims.
Kindly read and reply to me back is 100 per cent risk-free

Yours Sincerely
Dimitry Edik
