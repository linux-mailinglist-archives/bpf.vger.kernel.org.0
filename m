Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CA04A727C
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 15:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344567AbiBBOBl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 09:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiBBOBk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Feb 2022 09:01:40 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952C8C061714
        for <bpf@vger.kernel.org>; Wed,  2 Feb 2022 06:01:40 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id g13so19016776qvw.4
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 06:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=E7DjwvpK8fKU+n0BvI0K3vZtJI6EGSLZ3tJ9NtovK9I=;
        b=Tc9rvSciVyW7X3K1CIKKFb3is0GCHxQO1sZyz+4cIy7yJVuvqAC6Kpb3JpEyTQQG+m
         3EBq4idA0LxFN2zNvtA4QVHDtXdq12Qwp6Uxu4z/vrQ8mOdvl4rL+Uk7d9ktgqtdnQ8p
         9U2AnbLaqXDK9cffJ3R6eSHKDf9chpTu/PzEo7oB28N+bH/7dsUqdymyqgbKJDf4PLOL
         IPVVatnXI2YA6GJLK+o9R3k5srNxq7DpU1Wkx/seJAAG1duuxmgcX4zBq169IT1AAmRm
         5FiTbo6md7vLnFFx/UU7YlPH7npRRJe+we4FXjIEqB1XDgwkG/xLDD/RvxfDBzaWBvtG
         O0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=E7DjwvpK8fKU+n0BvI0K3vZtJI6EGSLZ3tJ9NtovK9I=;
        b=gPX3RchVI6PiV5r7ZJwZawFbiTw9tO0vQoC0u+oYzLKgsjFD5MdrGIz3s1zm2Bclcw
         Suzzh/ZTmC+JAFSTCCMxZVF93dYaUH917/xN3gJHoci2NFMW2NIn/Tm6+ouYh7baxCJ7
         r01UOnigtmKXZLKnOQz9By+ofIAjtMDmnSoa3tlyAXc6GiMmuL/yx3LjkDJkL6FXYsK6
         KXGuvsbP7iydx/B40r6nGHsyxtHVGqqMjz44kk1NyJsoSSyMAv/e7Q3Iv95Z1CtvXOtY
         IR6zRcLO96sLiLzw/yXkHVnfkjjUMSgAkx+nVl/1s11GN6bIiZJu1Z3I/8B6AyPyg+Py
         CsxQ==
X-Gm-Message-State: AOAM533j3SFk2ZHiNel32aQqnfqfdtbouqqqcJjADk0fhrTOhSuJmcZt
        ZA9MF5MZn0fxDkcdYv/jetZNLJ3oW5ztl2kH0Nc=
X-Google-Smtp-Source: ABdhPJxGqJfd6Zr/yuYt+e18U5snvasg/Ex48OGlBaeunN9yXQF8c68jDOEUlqRFfXhKx/yvxL7HocbJ1ydFxXUUGnc=
X-Received: by 2002:a05:6214:2a4c:: with SMTP id jf12mr26933389qvb.10.1643810499288;
 Wed, 02 Feb 2022 06:01:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:250c:0:0:0:0 with HTTP; Wed, 2 Feb 2022 06:01:38
 -0800 (PST)
Reply-To: orlandomoris56@gmail.com
From:   Orlando Moris <jonesregina165@gmail.com>
Date:   Wed, 2 Feb 2022 14:01:38 +0000
Message-ID: <CAMWeqz0qxf-Tk3kdXRN=QCvUsQrUQ2OU=j4-Dd8xFKUv9ba_YA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sveiki, informuojame, kad =C5=A1is el. lai=C5=A1kas, kuris atkeliavo =C4=AF=
 j=C5=ABs=C5=B3
pa=C5=A1to d=C4=97=C5=BEut=C4=99, n=C4=97ra klaida, bet buvo skirtas konkre=
=C4=8Diai jums, kad
gal=C4=97tum=C4=97te apsvarstyti. Turiu pasi=C5=ABlym=C4=85 (7 500 000,00 U=
SD) mano
velionio kliento in=C5=BEinieriaus Carloso, turin=C4=8Dio t=C4=85 pat=C4=AF=
 vard=C4=85 su
jumis, kuris dirbo ir gyveno =C4=8Dia, Lome Toge Mano velionis klientas ir
=C5=A1eima pateko =C4=AF automobilio avarij=C4=85, kuri nusine=C5=A1=C4=97 =
j=C5=B3 gyvybes. .
Kreipiuosi =C4=AF jus kaip =C4=AF artim=C4=85 mirusiojo giminait=C4=AF, kad=
 gal=C4=97tum=C4=97te
gauti l=C4=97=C5=A1as pagal pretenzijas. Gav=C4=99s greit=C4=85 atsakym=C4=
=85, informuosiu apie
re=C5=BEimus
=C5=A1ios sutarties vykdym=C4=85. Susisiekite su manimi =C5=A1iais el
(orlandomoris56@gmail.com )
