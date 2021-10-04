Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD4B42093D
	for <lists+bpf@lfdr.de>; Mon,  4 Oct 2021 12:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhJDKTp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Oct 2021 06:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhJDKTo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Oct 2021 06:19:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456CEC061746
        for <bpf@vger.kernel.org>; Mon,  4 Oct 2021 03:17:56 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so3562893pjw.0
        for <bpf@vger.kernel.org>; Mon, 04 Oct 2021 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=rDRc6hNiPM1HSlgW17nsSFt1jGE48UP9MInESY6X75g=;
        b=bYfjKIAjliWXQ4lb2sitrk7IlhptV0PCUKN3LwJ51p6WU+Cef5NTECeY4TQhEkutTe
         6A2h5CGn2ui3Jh9OryYoo/ZcJBiEsmau+nGWV1KyndBe9tTCBSRqt3LQjGfMSo79Of5V
         axwRq91t0Uau1sXmUFnQP+FE8LpB3+StnGzS8aJfWNt5S6qjS0OGG8F533Ouf6QQh7v8
         e8HFbeEpfHTsyj/BKzoCfv3plYpRQoKuySeojVqrDXPEdaPErsHxBMAnLWUi6LV+n47P
         BMNXLqmdsYB5emkJkdq11y14twfimhWIG5lGHyWjKjRGt4VWI8Qabki3eXKi2kXLBNiW
         9BNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=rDRc6hNiPM1HSlgW17nsSFt1jGE48UP9MInESY6X75g=;
        b=mraYftjbzFPUo7ldyxmnkyU3n9vRzb+bH+CXx4WM1i41xH/IAIWD5t2Mx6WTe+XbmC
         sxbCfSJP6kT6iorgrgCp0N8HHCX3/0Jtqwq46PyEvPE9U9BImdkEsTO/8IIXwVodsGDL
         7Cn76iCa5d2SeW/lOs43D0G0avqdMurVDTWt/MK7FIsexsJJefrOZYSTerDcoOJvGx8H
         O0YFhMvaelraZphhvcKFJeVhPMlhKLl4liaYwOZalFdBQfy6oE26S12L8W1LwqVPWsh9
         LI4XvrJAgjan1Gs9K8RGC8MLkAgwKtPan8KESWZDn0vYzPSCroFmNcTALkn70ZBm7uqP
         2jYQ==
X-Gm-Message-State: AOAM533w6WHKRKXEpjHckVFzJN6dSGfwptlFh7ffsFt0dwb6GFBDSc8l
        M8mY/8apxltmBjGb0L3vCuO2wlQNQITJieYqjx0=
X-Google-Smtp-Source: ABdhPJyIsAH6Inq3nx9zFFACXXctRFJzJVcZ0lBwNDG3PKw9Ty1MIELzDoOyUy3/CWxbowiU/9y6+TsV9H/BvycDWJc=
X-Received: by 2002:a17:902:7ec9:b0:13e:b409:fb4d with SMTP id
 p9-20020a1709027ec900b0013eb409fb4dmr7047078plb.11.1633342675310; Mon, 04 Oct
 2021 03:17:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:505:0:0:0:0 with HTTP; Mon, 4 Oct 2021 03:17:54
 -0700 (PDT)
Reply-To: rhajihaid8888888@gmail.com
In-Reply-To: <CAEjj=UUP29iWLz4fSnv7myTD6jLR2Ui_iEDzuvOMXu+ftZHexg@mail.gmail.com>
References: <CAEjj=UWuaJPROEiemTdVYD4nk-AKOwRTXVvuRZ8gSDC+BecvEg@mail.gmail.com>
 <CAEjj=UUeHucaJ8y+eeE86=ZGTWqM42SkG+LvtKQwcYp_=sAjcw@mail.gmail.com>
 <CAEjj=UX+gp1f2vRcowafsZE_xb=sZeKvfiFDXQgB5wqQqSRWDw@mail.gmail.com>
 <CAEjj=UUiRSoUo4+XXJ9Mx6OM3iWeMwzoVTyCK32+X+93eppHyQ@mail.gmail.com>
 <CAEjj=UXMVeS0ucZ2OaW2WUU1Z_jU01QmGaqgh-E1e5u-0v-jFQ@mail.gmail.com>
 <CAEjj=UWWObqTCR0sKYW33Qi3rQDFxBb=xXc-PzHBw772W9xjuw@mail.gmail.com>
 <CAEjj=UUPLZZpamt8g5AEJ1quny0r-2t6E6w8Awm60Lsp_1Q=qw@mail.gmail.com>
 <CAEjj=UXJtnHM_thq+ADyBEFpDUQ6izNFa3s47f8=oRqyQR-W1A@mail.gmail.com>
 <CAEjj=UU9xR27+u96_4MPwXJxE6PWJZLhwTxP+bcLpYtgwt9wjQ@mail.gmail.com>
 <CAEjj=UV_AWS73ebUXrFWd8VppYBL__kc-AoeVNDJcWi1sUEEiQ@mail.gmail.com>
 <CAEjj=UX7etm-5Vreagcxmhb-V_k7hFuaXMrvUkKeFQJC0eYT7A@mail.gmail.com>
 <CAEjj=UVB-rg+GtjcdON8oAf52gG4b-BXzEayQ+77QxzGpuurZA@mail.gmail.com>
 <CAEjj=UUkkXq25WB1XLTTSo1-wE+1zff-7gbMsVgxUiW9fik_fg@mail.gmail.com>
 <CAEjj=UWvGdfCn80tYPg1t4a13LjpmyziG68DD1TgaEUy26YRDg@mail.gmail.com>
 <CAEjj=UWeXBt3DryHroyTUjMUK8R3Qm7Vs=8SeSH9jT_aQAdicg@mail.gmail.com>
 <CAEjj=UXj6TNWdwh+xJ0F5Teckne38haVhp8f_wcs5xji6OPsyQ@mail.gmail.com>
 <CAEjj=UXmdCU3QOq4E0GB2+Fm2Azn2qpQCCLxa9OrwZGN=UuwTA@mail.gmail.com>
 <CAEjj=UVTMAFQebnQeijVTVPsScNnrwUZpErA4bUEvHb4QocNiQ@mail.gmail.com>
 <CAEjj=UUV8VPC3D+FJ8EJnxsaXxmv0GEhK_WVezT4yPaKb8piHg@mail.gmail.com>
 <CAEjj=UX0829z_4ou5EDVqc=0Z30fvPFo5NgCuwYeCiDUjjeLbA@mail.gmail.com>
 <CAEjj=UVeHDT=LP9r3ePZJnwE9vuJ+rGbcmfyzfZC2JGcJctYFw@mail.gmail.com>
 <CAEjj=UXCXRKDSJZkwj+VQzKBRrfra+KhOBOKv1pgUhDTe=mkMw@mail.gmail.com>
 <CAEjj=UU8zT9v6n5kr0e4psGitUazbxZgx6vDnGeqp6fyzVtP0A@mail.gmail.com>
 <CAEjj=UXR=pChVgLrKJLFu0JczB+dfxQis_5Pux9nbgB5Yf3Q7Q@mail.gmail.com>
 <CAEjj=UWD6+dWw26KuCH5Waf3JEsdXdMtO9LUsNNkW3wPrqjRpw@mail.gmail.com>
 <CAEjj=UXU2Zx6FwogZMA8o2A6edtmputiTr4si0DcszF-EGHDeg@mail.gmail.com>
 <CAEjj=UUH11TfGFWGk59dxvYLR7a1u1Eqv19Yw5KHGUNb=fv8_A@mail.gmail.com>
 <CAEjj=UUw83qjzF_7dAQMET2xG+1iZCmdDtgb4PgDyCGPLMFDEA@mail.gmail.com>
 <CAEjj=UVDx7iE6aGcDVmJEyHJ7FdaUc4uKP8cCKCt_W77xKtkdA@mail.gmail.com>
 <CAEjj=UWPytgmXFf4cmC49oCisB28MhdLQxqsF8g5yg7tOO6BvQ@mail.gmail.com>
 <CAEjj=UWPq+HP2UD8EgRw10Wgk=DTxQMafDtKMTCZFt3uqWXJ6A@mail.gmail.com>
 <CAEjj=UV=4UUbGPC+1ghwpGQ_R9b-Rut5xrPLd3UNucAdZi--HA@mail.gmail.com>
 <CAEjj=UVAnNqKr+B=dmeq2+C7U8VQ--MDrnyHK9k-bpqUiGeHJQ@mail.gmail.com>
 <CAEjj=UU2TwGTN2ZpXYfme6VEfJtSdk4NdeX4msMeD3g9oGHR0Q@mail.gmail.com>
 <CAEjj=UVEFuR8yhVhyTwqgKRFo_fRbroX07+55WSMBUCzHo0wJw@mail.gmail.com>
 <CAEjj=UV-VPoTpzGyjy1G56Tv2ym_8soCihjUvL_pPKcGqm6mXg@mail.gmail.com>
 <CAEjj=UVcB7LQshr5-DGqHRM8QFi17rdB8FmM1XfJ+DEQCc40dQ@mail.gmail.com>
 <CAEjj=UV_Mmv+c3_sJo2Ss-Yp4Fudin_6TbwoyCwc8+wkWvo9-A@mail.gmail.com>
 <CAEjj=UWZfAxEym05nd8+ZRy9hqLB0z5zqEBBfONujX9X=ifiPg@mail.gmail.com>
 <CAEjj=UVEjCRN5yUC1EqBWZHL+BMYFy-3uBG5v7osCe5NpZewkA@mail.gmail.com>
 <CAEjj=UUo4CA6y1rwfSXmd4DPEkqX=cs5oYeVw4qCVsH_1=hpiA@mail.gmail.com>
 <CAEjj=UUZKgnz4PvtwZDCQ2ME_XvHW5hdmaezkXXTXq-A8XvsFw@mail.gmail.com>
 <CAEjj=UU2tmnZNLuXaJ2SBC-mbSZsDeti=2s1aAEqT3qNEtVCbA@mail.gmail.com>
 <CAEjj=UXCVoiO28cSSJUU6WL8oVGCtuu2pGig=0-ZsMNbMoXBxg@mail.gmail.com>
 <CAEjj=UWvNa-yeQnnwxP2-ym3ozzi5ckDCg0VwqDEuYKT2UA2bw@mail.gmail.com>
 <CAEjj=UVgkFAJhxRYRadXAwPeGqC97anr6bQZxBu-LuENk8rFPQ@mail.gmail.com>
 <CAEjj=UUCP3WmThhTAvJ=jStoda2dWjdfcjdp=c8pMHbX5kT0_Q@mail.gmail.com>
 <CAEjj=UVo8QJJ1aZ5EbjMfnXVp=9NGB=9iU57j2nCHpECJM3q-w@mail.gmail.com>
 <CAEjj=UV6NJgi2XmQCxtzDkO+1Cfh1e=vb-XbAwdbagee+N15fA@mail.gmail.com>
 <CAEjj=UU6XtU+dkXVRBV_7kXkP2WcWAip8SRvwQQxDXHq2AekUA@mail.gmail.com>
 <CAEjj=UUpWg1y8x9eiLpTY2h7+XOCjWqFA4BrbfCyBBdZ4CaJDQ@mail.gmail.com>
 <CAEjj=UUnt5cD5W9weDLqqXdGSzTUHU2EcZ151Ma6Wgwi+sBG9Q@mail.gmail.com>
 <CAEjj=UUqbrybMgCzXr3nYrnsVpNySa1Y2tcLgqX229mapRCo1g@mail.gmail.com>
 <CAEjj=UU743c3jQoQp3K3gZdT-ZhEgtZZkUF4T9G95V=aDkdo2w@mail.gmail.com>
 <CAEjj=UUAZFxhytSNb+2vpU7i3OV3DEhkub3QGuW7+K4z=7h3dw@mail.gmail.com>
 <CAEjj=UXB-43Zjgc0cz0XNtTxj6qChHWgMWm5cvwNm3sCDrmWfQ@mail.gmail.com>
 <CAEjj=UXYXv5u9Bi6Wg0abt2XuD63GnV0gV8iriYFZqwmUONXkw@mail.gmail.com>
 <CAEjj=UU0yGtdRHJKt61s=xynq83e0-M2+MsFbaSPYRDa8y5MAQ@mail.gmail.com>
 <CAEjj=UVxdU-6rT09NNf9m9-XappsJeSpH4O0jyBKBsWi4QUGYQ@mail.gmail.com>
 <CAEjj=UUsZ5G4jid+ngNMGgkhiRXfST=rLj6dUF_DXTq7iUYfEw@mail.gmail.com>
 <CAEjj=UVTpPzpDve6tok+4=y+5UiGixgOJDja8LZk=fCEvQpWHA@mail.gmail.com>
 <CAEjj=UU5jWG7B-ZrsvteCjw9tS314HnF5t88zsR5+YB2zKmw4g@mail.gmail.com>
 <CAEjj=UV3Vh_XPt-0wneStEneZjO_kEXR1hOC33=V6_THMHEiJQ@mail.gmail.com>
 <CAEjj=UUkTRKRFEFWwdySBhp_oBfFvRtovqZGpaQ=qE-tP-cKQQ@mail.gmail.com>
 <CAEjj=UUUK1-1pR=v7AphqQ579C=WKfoJsgAteZyXm=xcubQueg@mail.gmail.com>
 <CAEjj=UWJaatnKJdJkyX3=B8_rJKB_N8MT-VC_y=h0vhWrnz1+Q@mail.gmail.com>
 <CAEjj=UVL7P0CWvtmKu-zWTbGLMwpzSVABukwdEOka=8r6hx60g@mail.gmail.com>
 <CAEjj=UXDuUvU=Ucn8MZFoQNWV6=ENdYBog8_k49LFLBvVkrHCQ@mail.gmail.com>
 <CAEjj=UUph9MRrOQ7sGNrf4hT50TWKHMJFcE8CbkfR5U-LjxPVA@mail.gmail.com>
 <CAEjj=UWEp-GD-62akgbUv3kbtWeZHjzLjuXombg_-UD463CTsA@mail.gmail.com>
 <CAEjj=UVqmYf+YXxaLdRvehbMJtckUpaUpR7Uefo31hi+zQqohw@mail.gmail.com>
 <CAEjj=UXQPeMfKb7q0gizVRnLmpk4c7eyO8HgDXnKnh=VK1uuQw@mail.gmail.com>
 <CAEjj=UVF5qiYgNFfLtexdZ=Xgs5cNtYRhZ0WxhbWWA7E-mUvhQ@mail.gmail.com>
 <CAEjj=UXhZtK7qAxZtNDm7_XWz5Z4sdun8B_mu=O6uSpJxU5bxg@mail.gmail.com>
 <CAEjj=UVuCb4T0Lek4qLbvTL947j6CdmUcyX4sdS1eaTQvpkjYQ@mail.gmail.com>
 <CAEjj=UVhu1ypWOU38Buq_Dc7xJmyP55ZH4p1YtFeVibi78-s5g@mail.gmail.com>
 <CAEjj=UX5xhXscEP-KuAQvvYKYXcCLSEBD1qtCJw-2nPB+csUKA@mail.gmail.com>
 <CAEjj=UUPPBkS-=Xxsvv02LrivAVSnpZ+-cGTdaj3hbq2_ms11g@mail.gmail.com>
 <CAEjj=UWNbC7UT3AooFWuofo2-jCWR1mf-20JB4tymNv_8Cq++A@mail.gmail.com>
 <CAEjj=UWoMbtQPh-MYWXsyAtuhTPL+PUXnf9vH9sn7M7UTAOeNg@mail.gmail.com>
 <CAEjj=UVFFf3XL8s+K1bDepN9T_aj1fnHCXT=JqCDeGfkaN8gWw@mail.gmail.com>
 <CAEjj=UUvHez_xCc1hjr0sXnZ_pUFct4z8_=AQdjQooGobKjbbw@mail.gmail.com>
 <CAEjj=UV1F_8xriaJZ3meVEUqR6vdE1pw_CJp7nr2rwcGpaDffQ@mail.gmail.com>
 <CAEjj=UW0O2fEFm7oESai=hQM6acjKZjVh-3z+KtjDDYKZEyUTQ@mail.gmail.com>
 <CAEjj=UV2T4xu+eeWcnMucEOUVx-_AOsLyGLFiKtrMWAm9dy82A@mail.gmail.com>
 <CAEjj=UWc24eb_42ary7k3i4ecHc4-_HkJE57R+PWdftRkFB8AQ@mail.gmail.com>
 <CAEjj=UV31UFfrzpzWgp8ss0UAWHJ6kn9+Ch86qme1-T05_7=Fg@mail.gmail.com>
 <CAEjj=UXY_dnAYghLtkDVGswhiUEvqPR2n6dk40qjskVWTg4ADw@mail.gmail.com>
 <CAEjj=UUdQZKVBrpOdPqV9-zZO+_o1VFtBWC7+CGfBq5qzqu6Lw@mail.gmail.com>
 <CAEjj=UXzjaFZHvVz8QPUeFYJ01GQ3Nmtk-xEe5aHySkQuKJ2Rg@mail.gmail.com>
 <CAEjj=UW0wvFb5eBNw3xLrmS3Wj_RjXeQpFiXKt4bP-jd+QTB3Q@mail.gmail.com>
 <CAEjj=UXdgoFG4jVLoz+KV5y1v9SNPoypOpQG7EsaHpVtMobaBQ@mail.gmail.com>
 <CAEjj=UW1mfowrsS4o6y1NwUKEy8G++rNAxaymds8fS_b7X65sg@mail.gmail.com>
 <CAEjj=UVDZ2O+_-uqzzAvj1r8X-ShZW_OTK+Ftp+X19QhzaM45A@mail.gmail.com>
 <CAEjj=UVh7ygzVQROzZ=phAgNRT083YKm4qmc2D_b+Y0PZhPD4g@mail.gmail.com>
 <CAEjj=UXWQEm1yBfukVNN4UNVeY7Oy+LwGfDwPDzvXTkqJwc7ig@mail.gmail.com>
 <CAEjj=UV94OjdR0YfGzhcbNmOKDMzTf4MyBQ4kyGXG90xF7h5ww@mail.gmail.com>
 <CAEjj=UV712Nv5mW9Ls978m1AO4BJ11oDubfVHD6qkjq_MhTEvQ@mail.gmail.com>
 <CAEjj=UX+gAFn_a6JmmRfzOE0p9AtkVwBT4bUTFT2KwGOceR7qg@mail.gmail.com> <CAEjj=UUP29iWLz4fSnv7myTD6jLR2Ui_iEDzuvOMXu+ftZHexg@mail.gmail.com>
From:   Mr Rhaji Haid <johnmoor1006@gmail.com>
Date:   Mon, 4 Oct 2021 11:17:54 +0100
Message-ID: <CAEjj=UXbzK_N9tT=JdYh2LF09wg684qG0Bg-xrGBzRnPb2R-Rg@mail.gmail.com>
Subject: URGENT ASSISTANT NEEDED
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>>>  Dear Friend
>>>>
>>>> you may be surprise to receive this mail since you don=E2=80=99t know =
me
>>>> personally, but with due respect, trust and humility, I write to you
>>>> this proposal. I am Mr. Rhaji Haid the son of Mr Tariq Haid of Darfur
>>>> Sudan. It is indeed my pleasure to contact you for assistance of a
>>>> business venture which I intend to establish in a country with a
>>>> stable economy.
>>>>
>>>>  I got your contact while I was doing a private research on the
>>>> Internet for a reliable and capable foreign partner that will assist
>>>> me and my family to transfer a fund to a personal or private account
>>>> for investment purpose.  Though I have not met with you before, but
>>>> considering the recent political instabilities in my country, I
>>>> believe one has to risk confiding in success sometimes in life.
>>>>
>>>> There is this huge amount of money (US$18 Million.) EIGHTEEN MILLION
>>>> UNITED STATES DOLLARS ) which my late Father deposited here in South
>>>> Africa awaiting claim before he was assassinated by unknown persons
>>>> during this war in Darfur Sudan.
>>>>
>>>> Now I have decided to invest this money in a stable economy country or
>>>> anywhere safe for security and political reasons. I want you to help
>>>> me retrieve this money for onward transfer to any designated bank
>>>> account of your choice for investment purposes on these areas below:
>>>>
>>>> 1) Transport Industry
>>>>
>>>> 2) Mechanized agriculture.
>>>>
>>>> 3} Estate investment
>>>>
>>>> I will then furnish you with more details and I have mutually agreed
>>>> to compensate you with 30% which is your share for assisting me, and
>>>> 5% for any expenses that might be incurred by both parties in the
>>>> course of the transaction. Then the remaining 65% will be for me and
>>>> my family, which you will help us to invest in your country.
>>>>
>>>> Please, you can contact me through this Email
>>>> rhajihaid8888888@gmail.com
>>>> all require is your honest & kind co-operation. I will give you
>>>> further details as soon as you show interest in helping me. I wait for
>>>> your kind consideration to my proposal.
>>>>
>>>> Best Regards,
>>>> Mr.Rhaji Haid
>>>>
>>>
>>
>
