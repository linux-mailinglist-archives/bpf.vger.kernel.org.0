Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D07949791B
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 08:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbiAXHHK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 02:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiAXHHH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jan 2022 02:07:07 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4538C06173B
        for <bpf@vger.kernel.org>; Sun, 23 Jan 2022 23:07:06 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id w206so9552273vkd.10
        for <bpf@vger.kernel.org>; Sun, 23 Jan 2022 23:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zOHJbgxEeKcTUS1M3dbg/CCHL8zxNc7o7Y1pwSiNVNQ=;
        b=a9Pm3gW6Dx19rcWktyoQHHY7M8nyT9W42AWClmhIa7sAr61b27tWH4/RB8kolVK6yD
         vcohVnRu/wrXcVRraWQ4Yh7E8D2XxnQIiLqcAM020KE9VoEYFt56wE4ZcYJ+WdNiCAWH
         GBWkhCQsrLeXBySd2KQ7wZcP1krkftE1dyhP62xR05f5ADw/hTEn2cZVpJI4+VeAgSDy
         ZvcvnZmZaKpV01/jCDcqGPSeKmIBUAiJO4gAzZLwaNXXZwYwt6EHpB99bUE07vS3rMlC
         6M9HJi4IO6mIXppCC8RST0S/yz2ZgvFQGBT9wzHgeSJhxih+3iWjdXOibL6H7m+Y41zs
         Xoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=zOHJbgxEeKcTUS1M3dbg/CCHL8zxNc7o7Y1pwSiNVNQ=;
        b=xlsc1ng/KBsn0ypPG3+fRFCgruAK68xDmWEi8Ct89Wq1R7kNulcR2dfxcVFLSyXaCe
         52poA15Fq4DJZDAAmMhTL/AsS8aTiPWKB0NMzDkS9H5ysIXEWH1xhMJOuivNwjtgxSr4
         Oi1EsbacoDX6YfYoQ2pjqr52+0wAXoix/VlbZ6KP+fvewha5T334+lB7fpL6hNP3UI7b
         9sq2yXECtdWgugI15yK40bv2pwWje49I9hAUav0ytuVIMqGGy1s++2/qODafgP6+iM4o
         7XCbzA0G0tl6f2O1GxBhXTlPv20o4FFlwQVDh0ZC2PZ9oa+KQQ85PEiZWXgGwd9qpLXH
         dW2Q==
X-Gm-Message-State: AOAM530AF+P/5G6wAHDQENK2T92Ptjo77LwM3mxO82WU2iWGSeVLWf8e
        Gr8VrJZZT+oeEB/k3XiPprBKKm6mSYWeaF2407Y=
X-Google-Smtp-Source: ABdhPJyz7SvcbDWO5xJuWDqlhCfiDd+DKhM8676zyu4OprNVNxGZ71ljl8BuEytbuG7Nv2QYCPbaxH0fTcr8Q16rQso=
X-Received: by 2002:a1f:3f42:: with SMTP id m63mr823374vka.7.1643008025895;
 Sun, 23 Jan 2022 23:07:05 -0800 (PST)
MIME-Version: 1.0
Sender: jameswiliamsjw682@gmail.com
Received: by 2002:a59:ca85:0:b0:282:df4:318e with HTTP; Sun, 23 Jan 2022
 23:07:05 -0800 (PST)
From:   DINA MCKENNA <dinamckennahowley@gmail.com>
Date:   Mon, 24 Jan 2022 07:07:05 +0000
X-Google-Sender-Auth: EadPQbAdIA9CR0UdSAur_iHOk6I
Message-ID: <CAJMpOne0FMRDs4QUkyksKOBbOJKhfQpbcgVbRDZO+Yh-rDuyuQ@mail.gmail.com>
Subject: Calvary greetings.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello my dear,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina. Howley Mckenna, a widow. I am
suffering from a long time brain tumor, It has defiled all forms of
medical treatment, and right now I have about a few months to leave,
according to medical experts. The situation has gotten complicated
recently with my inability to hear proper, am communicating with you
with the help of the chief nurse herein the hospital, from all
indication my conditions is really deteriorating and it is quite
obvious that, according to my doctors they have advised me that I may
not live too long, Because this illness has gotten to a very bad
stage. I plead that you will not expose or betray this trust and
confidence that I am about to repose on you for the mutual benefit of
the orphans and the less privilege. I have some funds I inherited from
my late husband, the sum of ($ 11,000,000.00, Eleven Million Dollars).
Having known my condition, I decided to donate this fund to you
believing that you will utilize it the way i am going to instruct
herein. I need you to assist me and reclaim this money and use it for
Charity works therein your country  for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die.. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.

I'm waiting for your immediate reply..

May God Bless you,
Mrs. Dina. Howley Mckenna.
