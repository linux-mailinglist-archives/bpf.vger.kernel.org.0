Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4F849B7F7
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 16:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582579AbiAYPuM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 10:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582433AbiAYPsA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 10:48:00 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE40C06175B
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 07:47:57 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id h23so24073072iol.11
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 07:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IEMma1eGW5sQblzU1//BqOEn5E488+F+nzzq2q8j3TU=;
        b=fOS9t/4WIMWIIiK5hLKXdT0Po9uD+kzDn6VOR2znUTqPMFzLaexDBWz0/XVpZDVVF6
         BLhx7LQ6EJASCmS1cJ2gBSroupwLUVLpgGtDmofkp94T0dIx0hUzt25XJGThpBeRaS2l
         dSnhJldTv4kCaVTwQemnC5B2GfP3YXrF7gyeiQuD0+OeM6rMggY8gW4EEwzwWuDmmIPi
         RZwQ5nPnAJv4O02s08IynswwjoK3oYzdAQqslk7VNKYr3eS4/vXBTJEwfKFMq7fGgL1R
         MjoORe+Q8ZLuVr10WKwic1IXyV4krSlQy4/GD4pWI1wV9ewFfj1fplFqCtKbWAllHoan
         lyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=IEMma1eGW5sQblzU1//BqOEn5E488+F+nzzq2q8j3TU=;
        b=JGtZC1xyo1rI9VG54XqNpERlIWpy8PBiUJtZ0JAHFH9aa0kPyVV02pWJqOe3DmkD51
         8G3KK9YDrjKRxodS1aHN8Qp3247TxJ/9DOgwXBSHSz/K7yhI8zazotbDaACJhrOtuhwu
         tjE83Upo7+LNHeYdDal9fMlB5TiF1mPTXMosg8BazPHQPD3tX8UZD8UMxuHCqioaBrkC
         MHOybDLdrrVV2Avu/dfhRVp8tqwwoyoo40yl1GXMd2YYy8/fkOmr8vlTjtYrnzTkhgDH
         NDWWbBRstxNnB9SQnM7gJv/28RmuSRLFhZyWeGqBgMBEQbXUHBXuk4zEwT8Ay5It0DH8
         qJJw==
X-Gm-Message-State: AOAM533FQQjk5j2M2JXV++/J7ewj0dH4fySh5/yNtjNgm9CHjYsp5iHN
        YcaDK4EkYeAfkI90R+zSccon8lF+squhkkDbLjo=
X-Google-Smtp-Source: ABdhPJybsVyo/ViKGbsZAyN3QH5WDtQ4NHwh5GDBRzwxoSOxx/XwZxqhjDQ8DcHMYJW2qGEymLF0XoencV3PZSK19NA=
X-Received: by 2002:a02:8407:: with SMTP id k7mr5730588jah.106.1643125677196;
 Tue, 25 Jan 2022 07:47:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6638:3044:0:0:0:0 with HTTP; Tue, 25 Jan 2022 07:47:56
 -0800 (PST)
Reply-To: abrahammorrison443@gmail.com
From:   Abraham Morrison <barrmorr111@gmail.com>
Date:   Tue, 25 Jan 2022 07:47:56 -0800
Message-ID: <CAKy4BjGgAaBUmpL3ro5QQ4AC4JftuZoYTdfdUd=7EP-t7p3S8A@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prosz=C4=99 o uwag=C4=99,

Jak si=C4=99 masz? Mam nadziej=C4=99, =C5=BCe jeste=C5=9B zdrowy i zdrowy? =
Informuj=C4=99, =C5=BCe
uda=C5=82o mi si=C4=99 zako=C5=84czy=C4=87 transakcj=C4=99 z pomoc=C4=85 no=
wego partnera z Indii i
teraz =C5=9Brodki zosta=C5=82y przelane do Indii na konto bankowe nowego
partnera.

W mi=C4=99dzyczasie zdecydowa=C5=82em si=C4=99 zrekompensowa=C4=87 ci sum=
=C4=99 500 000 $
(tylko pi=C4=99=C4=87set tysi=C4=99cy dolar=C3=B3w ameryka=C5=84skich) z po=
wodu twoich
wcze=C5=9Bniejszych wysi=C5=82k=C3=B3w, chocia=C5=BC mnie rozczarowa=C5=82e=
=C5=9B. Niemniej jednak
bardzo si=C4=99 ciesz=C4=99 z pomy=C5=9Blnego zako=C5=84czenia transakcji b=
ez =C5=BCadnego
problemu i dlatego postanowi=C5=82em zrekompensowa=C4=87 Ci kwot=C4=99 500 =
000 $,
aby=C5=9B podzieli=C5=82 si=C4=99 ze mn=C4=85 rado=C5=9Bci=C4=85.

Radz=C4=99 skontaktowa=C4=87 si=C4=99 z moj=C4=85 sekretark=C4=85 w sprawie=
 karty bankomatowej
o warto=C5=9Bci 500 000 $, kt=C3=B3r=C4=85 zachowa=C5=82em dla Ciebie. Skon=
taktuj si=C4=99 z
ni=C4=85 teraz bez zw=C5=82oki.

Imi=C4=99: Linda Koffi
E-mail: koffilinda785@gmail.com


Uprzejmie potwierd=C5=BA jej nast=C4=99puj=C4=85ce informacje:

Twoje pe=C5=82ne imi=C4=99:........
Tw=C3=B3j adres:..........
Tw=C3=B3j kraj:..........
Tw=C3=B3j wiek:.........
Tw=C3=B3j zaw=C3=B3d:..........
Tw=C3=B3j numer telefonu kom=C3=B3rkowego:..........
Tw=C3=B3j paszport lub prawo jazdy:........

Pami=C4=99taj, =C5=BCe je=C5=9Bli nie prze=C5=9Blesz jej powy=C5=BCszych in=
formacji
kompletnych, nie wyda ci karty bankomatowej, poniewa=C5=BC musi si=C4=99
upewni=C4=87, =C5=BCe to ty. Popro=C5=9B j=C4=85, aby przes=C5=82a=C5=82a C=
i ca=C5=82kowit=C4=85 sum=C4=99 (500 000
USD) karty bankomatowej, kt=C3=B3r=C4=85 dla Ciebie zachowa=C5=82em.

Z wyrazami szacunku,

Pan Abraham Morrison
