Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BE447AED6
	for <lists+bpf@lfdr.de>; Mon, 20 Dec 2021 16:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbhLTPEM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Dec 2021 10:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240817AbhLTPCG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Dec 2021 10:02:06 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C707C08EE18
        for <bpf@vger.kernel.org>; Mon, 20 Dec 2021 06:51:36 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x15so39432737edv.1
        for <bpf@vger.kernel.org>; Mon, 20 Dec 2021 06:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zOHJbgxEeKcTUS1M3dbg/CCHL8zxNc7o7Y1pwSiNVNQ=;
        b=YgqgUnSECcj3JiW3LyjHLqC1DjEFPdNxCmKns+p0oV6GiwKkUJNUHoTcnFfbnWO16H
         jebZBzyzJrTd1QZJa62/u3YQWPDN+TBNKHr02PWHTVtHIThIbmEY+9t5ASfaGzJwt2OD
         nTTeAMMSZc4HBGcTW3mBUiZ/WMMwdHHCyaeLQQnGA2hfCoSGmSVJG+VQZFV4LrRQPFcb
         +ZwHWDVvDqVqVdJN6DhXzEoJOFsnKNK6Nq4+dunBjrBMbEL4ttw86uq7ez2wYxaew8i1
         ITVKpgeNKCtd0G0reVAp/jl8+yaAbKZotdHGPVzEJnsW05++8q8WnL0ttAicPm/Q4gMt
         vo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=zOHJbgxEeKcTUS1M3dbg/CCHL8zxNc7o7Y1pwSiNVNQ=;
        b=QVkyOxWxZlRZD/3sxjhN16N8OMHOe7iLG+fcnmIfJ50vxMbu0H4y7QBE+UxGEO5zlB
         SS1B373L3tfWucc9tUtyrYp/d2j55PlvHlJtdxKPi4SjQEC9uXTyfEVjZGDvpKEkfR4l
         JTzlxUuqWgOq7MSLHo5T6Y2tJ5IZm2cxXsG2c+a+GuuNpUvZxHL1L9rZqbg7C20rbRtV
         5qx9X8hHx2MSNildJ40ugUz4AIO6BnJkexD2u/UxNmbG8+RxCmEg3EtWZHeggkvvKxbE
         EucKxB3edsQ8B3J/XhLPgFWBJD8ewCN02WKpk7+ysNv5Cbg0ANG1vhUrPPNZUH1IXTbR
         CEgg==
X-Gm-Message-State: AOAM531dsfWqFRmz3uf0DUUTskCsj3Qe2iucl6dpd6vue1rAVGVEOnxC
        VLvAoJCj9o3TEWRchakTeee9NqRhqu0i18ZZsw==
X-Google-Smtp-Source: ABdhPJwnQyp3Preos9jWHXbmn36Y56nQYSe/zxoFOPNb7yVTrPWvJvtxh6p3CgX1X9xwjiWVjNcNZIhhbXz972LiQ1A=
X-Received: by 2002:a17:906:6a0a:: with SMTP id qw10mr13547516ejc.141.1640011894152;
 Mon, 20 Dec 2021 06:51:34 -0800 (PST)
MIME-Version: 1.0
Sender: chantalstark91@gmail.com
Received: by 2002:a05:6400:5b22:0:0:0:0 with HTTP; Mon, 20 Dec 2021 06:51:33
 -0800 (PST)
From:   DINA MCKENNA <dinamckennahowley@gmail.com>
Date:   Mon, 20 Dec 2021 14:51:33 +0000
X-Google-Sender-Auth: cWKhlmrOYpaiDrBslEwmS9d7-ig
Message-ID: <CAOzO0HRjqFt++PSeFvwrHM5eFx9G15jjFtk0aKNK4jNgBQ4Gyw@mail.gmail.com>
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
