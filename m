Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F284839F6
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 02:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiADBuO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Jan 2022 20:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiADBuO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Jan 2022 20:50:14 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4EDC061761
        for <bpf@vger.kernel.org>; Mon,  3 Jan 2022 17:50:13 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id q14so134497973edi.3
        for <bpf@vger.kernel.org>; Mon, 03 Jan 2022 17:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mrxhTGCiJdlGC+eJy5UXznUx973zEpGxFnhRGTjwkGI=;
        b=EMVaAAyPmXhqLZsA9cgl+MZxBbBzEvsAdNWn5K4I25GLePpsf/fAYBQVdMbQniVm9z
         z7DDd36dZuTtohpyo11OOmYLdA7oGb3mIrAqzH12D5uKQwsSosib5o2zd9A99Q10cGZ4
         DeN/WOlmeXXnxJ3LrK5OZJHLAfbz58g3DR0jzd7XQhXKjUTh4vE9qUMDgivnKTe1unrY
         DcU2vake8YBttBCNJ3vSoWfq9pqq06thzLB0WD83kn9ICOi7TSfEWRhuFcbqo/W+Su/5
         uEj+3QMBQfbhFpXIai8ZY7gPca7ZYTquR+uBmkXiv2cWkbuSfNvLT9YNPZj8zZQre0qR
         pDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=mrxhTGCiJdlGC+eJy5UXznUx973zEpGxFnhRGTjwkGI=;
        b=4sOQpv1phoDSa2QihitY4cMFnu1LP3S7Q90tBcOnJRCxvJi44kpDaU8A02IX28+Mqt
         t8HM7mr9wJNfEK0J5Jm24xuz6EXdmLofL5mEyBG+mjUzZ67H8Lvdw4zXbje8D4gsLF0o
         pOUxXy4fg+lrty+ZgvdI3p+MjQHnBTI9U427Pv+xJDR9pZc/uM6V85W5F96pmpemzaVe
         KEYFzz1zVVTYiv7kJ77liPH7ILgLuUg4wMCET6OIedWUWSCsZhqFNzr10mY/BgOlF9qe
         aCULP/aeU5SbQzGot0T/Vvg9QgoluXHmfcaL2VwZYGf6OooJXk29BpFu0P6DD+mvYJma
         b9Tg==
X-Gm-Message-State: AOAM533DPmnlPCYuShgXhITXepZtXK4Y0bEY3yLHSQ1oN9bBNkuJQarE
        65PZonOuWqZgrJeJDw6Z0+HzuugEE6X6EWvSsr4=
X-Google-Smtp-Source: ABdhPJzBSjdVU5rBLKJmozlLIozfFeRgyYkZvc7mTKwv3F1Ko2HxgXFnRKIY4J0Tmkr7wneuHKwEDpC4hXRg+ysk1kU=
X-Received: by 2002:a17:907:1689:: with SMTP id hc9mr37593582ejc.228.1641261012293;
 Mon, 03 Jan 2022 17:50:12 -0800 (PST)
MIME-Version: 1.0
Reply-To: asad1ibn@gmail.com
Sender: ibrahimrahman084@gmail.com
Received: by 2002:a17:906:3e10:0:0:0:0 with HTTP; Mon, 3 Jan 2022 17:50:11
 -0800 (PST)
From:   Mr Asad Ibn <asadibn22@gmail.com>
Date:   Mon, 3 Jan 2022 17:50:11 -0800
X-Google-Sender-Auth: PyichGIgLuTJJjtE_TaBfGiHnx0
Message-ID: <CAAN216iyZL_4kKmFi_JMr43tQgXwWtovkKsp8+YGKUYff-fHDg@mail.gmail.com>
Subject: Dear Sir/Madam
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I=E2=80=99M Barrister Assad LBN.from Burkina Faso, I am sending this brief
letter to solicit your support. I have a Client who is an Indian, his
name is Mr. Dasya Kahaan. He was a gold dealer here in Burkina Faso
before he died six years ago when he went for kidney transplants in
his country India.

He deposited the sum of $5.5 Million dollars in one of the legendary
banks here in Burkina Faso. I have tried all I can to get in touch
with any of his friends or family members but no way.

So i want you to apply to the bank as his Business partner so that the
bank can release Mr.Dasya Kahaan. fund into your bank account. I will
give you the guidelines on how to contact the bank and we have to do
this with trust because I don't want the bank to transfer the fund
into the Government treasury account as an unclaimed fund, so I need
your response.

Warm Regards,
Email.asad1ibn@gmail.com,
Barr.Assad LBN.
