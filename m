Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AE047E527
	for <lists+bpf@lfdr.de>; Thu, 23 Dec 2021 15:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239826AbhLWOxh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Dec 2021 09:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236473AbhLWOxh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Dec 2021 09:53:37 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4867DC061401
        for <bpf@vger.kernel.org>; Thu, 23 Dec 2021 06:53:37 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id m6so9261334oim.2
        for <bpf@vger.kernel.org>; Thu, 23 Dec 2021 06:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=avOzz+s5zjOOJ9Z2Kb6BjAYu3bmaGVtVbqQU0g+1drQ=;
        b=OGHIjO2Z5XssG+MlqiXGB03qiPUcaLdlkEWtEUVqlyuf7YKEUn1i/l+09Zv/YTcq1r
         lBk3Uq829E6z8Btf0zMBTYkiveWbjCOicfz0o2l0mSW9apAuM27+NivS7y0DplFT7/kY
         1HYUjiHtmmhMOHWASlbQ5baKN+1+tuT1hYWJEgcEJmPdBTd6NbbML816tpSfxEn9Y0NP
         1D7UlFmK6oopjWi3id9DoLn/stTkJqPJ7MM1FSbrOViOO2jwflaYtgQWh5SrcI1pSnU1
         HbLdKpvlJscIErQ9VyM9q3W+85acc6lEzptYC5M+VXVexTtyfhDhnwLHhUr7a2KQQxKP
         hxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=avOzz+s5zjOOJ9Z2Kb6BjAYu3bmaGVtVbqQU0g+1drQ=;
        b=11DYbyXDAy++usYBV0suzMo+0JB5AJLyfxmhI9s6zW1t/dRK7TQx7mez6AXHzqy7HN
         RErOP+WP940ySYpxMWyg4A3qKbGFCoiXMm0ifV7N1hT1YHyhqgcMJHgJhMRJWO83UXl5
         hRAUXdDzoh3dISatamkkFRBQGaWZquOkS6fw//0PmD4CDYAn1X3mDzwdoke8WXd6Srt9
         12ZsTUKyzTdx7dW+jMY60es+BwfnAU/EKr3Pj9FivMqPNpAJPiFVpkBZGrXWA3fSc9dQ
         Su8pRJ5NXjFfxBfGyux5nXUwET49tW/U3ihZ3GCxu4djXpdsdwFCPDYMWiHDEombjrl+
         xMYw==
X-Gm-Message-State: AOAM532hC61H9lsqBEVvgcM49JTg1H5lbB1W0hgzEu0+663cXVD8UpyZ
        U/9FTHi/DQDQ0irKCvOKq3Y8Nxhti9habrjQ5fo=
X-Google-Smtp-Source: ABdhPJwvHbO9V1wWBRfY7ZXScfoN/68YH0DDsafa3KKWQPlPL+2JyAwD6IXTnYNm/QZWjnxYoBgm3mq7kTbPg/DhbxU=
X-Received: by 2002:a05:6808:1381:: with SMTP id c1mr1798233oiw.129.1640271216462;
 Thu, 23 Dec 2021 06:53:36 -0800 (PST)
MIME-Version: 1.0
Reply-To: drdavidgilbert2@gmail.com
Sender: mrsyoungmijulia@gmail.com
Received: by 2002:a05:6838:82d0:0:0:0:0 with HTTP; Thu, 23 Dec 2021 06:53:36
 -0800 (PST)
From:   Dr David Gilbert <drdavidgilberts2@gmail.com>
Date:   Thu, 23 Dec 2021 06:53:36 -0800
X-Google-Sender-Auth: v3XGD5Zi-UwN5TMHilp1LwQjaAU
Message-ID: <CAK85GsE6WPAp0PWwGRyPKmz2TgE-FSHU=c=Bade3fONUdypOoQ@mail.gmail.com>
Subject: Its an urgent!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I am Dr. David Gilbert, the director of the accounts & auditing
department at the ONLINE Banking Central Bank Of Burkina Faso
Ouagadougou-west Africa, (CBB) With due respect, I have decided to
contact you on a business transaction, I will like you to help me in
receiving of this fund into your Bank Account through online banking,
However; It's just my urgent need for foreign partner that made me to
contact you for this transaction, In my department I discovered an
abandoned sum of (US$10.5 Million dollars) in an account that belongs
to one of our foreign Customer (MR. PAUL LOUIS from Paris, France )
who died along time in 6th of December 2016 in car accident.

I am afraid if this money stays in our bank without claim for long
period of time, our government will step in because the Banking laws
here does not allow such huge amount of money to stay dormant for more
than (Seven) 7years, And you will receiving this money into your Bank
account within 10 or 14 banking days.

The Banking law and guideline here stipulates that if such money
remained unclaimed after 6 or 7years and above, the money will be
transferred into the Bank treasury as unclaimed fund, I agree that 40%
of this money will be for you as foreign partner in respect to the
provision of a foreign account, and while 50%would be for me, then 10%
will map out for the expenses.

If you agree to my business proposal, further details of the transfer
will be forwarded to you as soon as I receive your return mail, Make
sure you keep this transaction as your top secret and make it
confidential till we receive the fund into your bank account that you
will provide to the Bank, Don't disclose it to anybody, because the
secrecy of this transaction is as well as the success of it.

I quickly inform you because the new system of payment policy has been
adopted and it will be very easy and short listed for payment via
Online Banking, So immediately I receive your update; I will direct
you on how to contact ONLINE Central Banking through their E-mail
address, where the funds will be approved by Central Bank of Burkina
Faso and transfer into your bank account through online Banking and
make assure you follow their online payment instruction to enable the
transaction goes successful.

Yours Sincerely,
Dr. David Gilbert.
Central Bank.
