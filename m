Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62053311E1C
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 15:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBFO4h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 09:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhBFO42 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 09:56:28 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C0AC061788
        for <bpf@vger.kernel.org>; Sat,  6 Feb 2021 06:55:57 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id sa23so17722445ejb.0
        for <bpf@vger.kernel.org>; Sat, 06 Feb 2021 06:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=OLh8O5HPHkbHKn/B7MjZmJBMm08TY2tjbzlLR9wPezT3zRGDxxUT05CH0Ee2ZcUqRY
         eCqgp1cg8TQBlz1LSGkB2AM2hmwwDyhl7pvXhANU/a+uatPz98VqXd9ZOk3y66HnbTfn
         gL3+Y4kFYArAYNulQiXvkck6TgErdPYbRLoDnlzdLYVgLV1LDtTjyyrXydzqG0nRYJpP
         0UEpZe66R/6padmdzUqPa7Pur4BhX6sVB2zLyOIje4h7Tqu4b0jF6R96qjCsj/crtAzg
         f3orPWzHPdzEuqXZi1Dk1LkeK19OHIpHf+W2b+8A5riw9LzfkQMWMc/H2CnLhFo1fw58
         N18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=cT1B4uYhm7BK/DrGe65/mSAm7c6l0OqPq3XigxE/9QvarN1lZugPq9PSBA44eEFrmF
         eZQeBETpvJLMdveVpFEWhQJirdLOur1oG/sCkpNTsPgmpvqV1jn1reJEXEKUQyqLB+In
         zcx7hisZZpZAcCrSQ4DIUeeBpEz2TcYMpi8yc6/lKnK+dqxF/RZLNqEcljFnNobvlB28
         8h4PPa/gUoyCESiIBp1NV5tRG2u57pzz1kdsAa1yCVLlrkFag9K++m7ev4dAKzkmylaH
         m1w5Veoz+2Op1FuI9HuJFI8dtKr/ig5ZVkSCCjf3foOh/KLXdz8yThXCfY2NL0XDLPFA
         8F4A==
X-Gm-Message-State: AOAM533wU4UcpiHwcrcNGq2pam7BKYx7UbDgMBjEE8lOP+dOHQTjC54+
        gpWUMv6j2zQad5IWh4xFoD86TNM8vdnka3B8a+o=
X-Google-Smtp-Source: ABdhPJwjMvpuV/VqjgpveJvPNmYVeAMmn8WOjONDfrGssEavAqf0/tXnxurz++ZDtqwmWNnjAVf6/MGWmsSqJw5vX2k=
X-Received: by 2002:a17:906:c413:: with SMTP id u19mr9176333ejz.147.1612623356087;
 Sat, 06 Feb 2021 06:55:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:25d0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:55:55
 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada9@gmail.com>
Date:   Sat, 6 Feb 2021 15:55:55 +0100
Message-ID: <CAGSHw-Aw7aM3K_cZpN8a1qwjjK-RAWwzkEvOqmJCw75UoBtQfQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
