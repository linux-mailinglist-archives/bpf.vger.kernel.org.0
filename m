Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE4A546A91
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 18:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiFJQgS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 12:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349506AbiFJQgQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 12:36:16 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E81849272
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 09:36:15 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id f13so25966771vsp.1
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=qeBJNhRyC6NugrrZV5aFMIIUBdUJiWAxEMkk6M4qGac=;
        b=cy/JV2i90+r1HwCAEykcv8A6l7FSF4RPBX9EhyIPiUHbM55bQAWME/2LMfcNuor6s5
         fiJDlPkvz0NQ5i3ErtiPMcv6SKsyf5BFDutWWYCqRV6YvKMBbQE64Xs4/PRZ+iqsIWIP
         Duif5Ip3fLxvwv4H3zbOx0ZdPpp4mEoBScksg4ualI1DDz8MaQsPbMvhck4M8lEf1tnQ
         ForUA/6x56DdoNxot5uCYTXMHTvgR7LpTHj8dj1C982P2VdglIuP5rmXdtsnRbtzSyG6
         YDR1z/p3yk2IX2hhPIE6LnP85vZpweWV4iF+E812lMCJJ7dUD87e88+mJ0jo2FkARMFI
         Df8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=qeBJNhRyC6NugrrZV5aFMIIUBdUJiWAxEMkk6M4qGac=;
        b=Ld+1g5KPoNVnpegtp+KpODCB6ubHDWH4Atd2AaaFzJARyFtg3GwYUZULWgmpk5kZHN
         iHJd/m0xWwKVdJJfwlxjuFf4S7evTla93LGeMxxT3ubHjvKqqDnfS9gWi19M9dmY2W/U
         e2IYucGGd4C1H9mMHU9B4EPFPS7YNHCTOHostAwN+Dr/NRzK5dSnxd6Ed3E0Vb/mtHjh
         YTShLdK2WU0U5gCk8ZjjGalDEAavJrmkAU9ZgX6JKPpb5RkuQ+7xa8rZpxfcAkmO0HsI
         BljCMvlb31h2rrDYKWP6Hb2RFellR8hKFno71cnDtyH4U7MhyuwEBnXoAnHvCAvAwkOs
         bTtQ==
X-Gm-Message-State: AOAM533MBgg1roYlXzNa44nDKHj3Rp5NGiaudDErs2aBdyOU0QadhLpJ
        6aDMiu/uVVuab/bTEVek6gKiW9cyU1wisNDG4KA=
X-Google-Smtp-Source: ABdhPJxxHthvFAgcaNZQxeXYwwInDFpiTUdDikfuAEHnGPvDLFcnVFFqt3bHa9VCa1IjzlkLn4YB/fvtfk7qdzUTME4=
X-Received: by 2002:a67:d70e:0:b0:34b:8e32:404b with SMTP id
 p14-20020a67d70e000000b0034b8e32404bmr18613965vsj.31.1654878973669; Fri, 10
 Jun 2022 09:36:13 -0700 (PDT)
MIME-Version: 1.0
Sender: generaljosephkofi@gmail.com
Received: by 2002:a05:612c:1181:b0:2c9:ed8c:cf4c with HTTP; Fri, 10 Jun 2022
 09:36:13 -0700 (PDT)
From:   "Mr. Jimmy Moore" <jimmymoore265@gmail.com>
Date:   Fri, 10 Jun 2022 17:36:13 +0100
X-Google-Sender-Auth: l1d7iL9OWXs9UJloRUNe0Df4zQo
Message-ID: <CAENTeKNhbos=n1JxY4AnBwrVpLccYc4t4arwQ0RcE-z2oT42Rw@mail.gmail.com>
Subject: UNITED NATIONS COVID-19 COMPENSATION FUND.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        LOTS_OF_MONEY,MILLION_USD,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

UNITED NATIONS COVID-19 OVERDUE COMPENSATION UNIT.
REFERENCE PAYMENT CODE: 8525595
BAILOUT AMOUNT:$3.5 MILLION USD
ADDRESS: NEW YORK, NY 10017, UNITED STATES

Dear award recipient, Covid-19 Compensation Funds.

You are receiving this correspondence because we have finally reached
a consensus with the UN, IRS, and IMF that your total fund worth $3.5
Million Dollars of Covid-19 Compensation payment shall be delivered to
your nominated mode of receipt, and you are expected to pay the sum of
$12,000 for levies owed to authorities after receiving your funds.

You have a grace period of 2 weeks to pay the $12,000 levy after you
have received your Covid-19 Compensation total sum of $3.5 Million. We
shall proceed with the payment of your bailout grant only if you agree
to the terms and conditions stated.

Contact Dr. Mustafa Ali, for more information by email at:(
mustafaliali180@gmail.com ) Your consent in this regard would be
highly appreciated.

Best Regards,
Mr. Jimmy Moore.
Undersecretary-General United Nations
Office of Internal Oversight-UNIOS
