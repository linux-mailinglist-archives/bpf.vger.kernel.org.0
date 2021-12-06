Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7043A46A666
	for <lists+bpf@lfdr.de>; Mon,  6 Dec 2021 20:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349368AbhLFUB2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 15:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349373AbhLFUBO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 15:01:14 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74149C0698CF
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 11:57:37 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso15051564otj.11
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 11:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Hp2wuf+GFIgPk2krY9oLPCwUDqecUtCiJ9IkJj6FAwY=;
        b=erwLQqURu+Z0eqHJlYLwFR8dLd2NY5mB6iXlNvj86722x9Pb1y2a1YOX4ieB/4ItAR
         F/rtWx/Y6ePZSaOPQ7McD7zaa8u//OrT4BvpoGezt/G6UezcuzJcewg5Z0Rx+66w2tb4
         FzmHLDeQR7sONBWPUfG6JZDEJG0dG1ZC55dX3GGUdM8/XUZt62FKn5mJlc6Dl1Tw/q5J
         SC3tClspmLGZmOoIw10mKla5wRXJ/ruBbdxvjNw1STp+qJjhaybtmkboFTqtJXzw7qhw
         bp4DEdHV/3DPbRMzlJJL18VoFvBfWYNqnUonYm9oVEOcvnEQG/iwT6V4RU4dxkMdVF+F
         og3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=Hp2wuf+GFIgPk2krY9oLPCwUDqecUtCiJ9IkJj6FAwY=;
        b=HlrVbq6+oVB6fs9Hmzp9BMLwG0pko2ZSS3nhDkq/ka7dQp6mjs/yLq4RyCWs+RuYZY
         bKfUbrNk2abUKU5uGAgTkK9c56EjNeGSIHTCoAo0LI/40V6PsP9GxiXXFbsrAOYRKIVP
         XHUHwPOOdKEb4SvZTZwsZAtupyE1fmPqyimzI6eslFP+K3aQD6x2ZCy4qdaiF5HEo2Vg
         zTfiNxnl9Uo0Jf7yYvqY+2fDNT5gETAqx5rDVDms1dH+8rJF/4p3CnzxmEW7r+lSxX/u
         wFDmxYqm4aytIjnbb5kr8KJ2DW7QlJdSpLQZN8KSQpaaDGmuMS6C44A3KaqXOac18P39
         Jg3w==
X-Gm-Message-State: AOAM5321Ow7nwfJiWDDNsQsJxJ3VOIC61PGiViYREbXqpK6lnMxfJziN
        lxv2gOAkDwo/IbJzhfT79RgC7V1FT9pCDH41fko=
X-Google-Smtp-Source: ABdhPJzyAuU38upZHZFOCTec0SIsAc5X4maOhEJ47R/1HfIqKoBH4k5JhExaiP2bDdIjvNFNGv5AG/n29otc+CG3Lak=
X-Received: by 2002:a05:6830:1417:: with SMTP id v23mr31587329otp.367.1638820656622;
 Mon, 06 Dec 2021 11:57:36 -0800 (PST)
MIME-Version: 1.0
Sender: blessmegod87@gmail.com
Received: by 2002:a05:6838:9414:0:0:0:0 with HTTP; Mon, 6 Dec 2021 11:57:36
 -0800 (PST)
From:   DINA MCKENNA <dinamckennahowley@gmail.com>
Date:   Mon, 6 Dec 2021 19:57:36 +0000
X-Google-Sender-Auth: fuOhrAuh8A3rDmzbdJ7o8ItFZtI
Message-ID: <CACOw96kFBkx3KZ=u_hD9GuY+f9qQdPoqiw+_+NQ5Ww+WQ=zBuA@mail.gmail.com>
Subject: Hello,
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
and glory upon my life. I am Mrs. Dina Howley Mckenna, a widow. I am
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
will be transferred to your bank account.. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.

I'm waiting for your immediate reply..

May God Bless you,
Mrs. Dina Howley Mckenna.
