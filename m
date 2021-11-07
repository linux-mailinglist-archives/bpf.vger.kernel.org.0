Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3434475FE
	for <lists+bpf@lfdr.de>; Sun,  7 Nov 2021 22:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhKGVHW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Nov 2021 16:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhKGVHV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Nov 2021 16:07:21 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FA5C061570
        for <bpf@vger.kernel.org>; Sun,  7 Nov 2021 13:04:38 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id f78so5158094vka.5
        for <bpf@vger.kernel.org>; Sun, 07 Nov 2021 13:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=msSuyuNN1qGawUOx+wJjclYFd7Ehg7HyYzhPy0YPAk0=;
        b=jg4GqGNgEByxxQwKlml/5lHWd9ViGxMXqqQ0w35UrgY7/MnYL+clZT3vyuJS8hD0Rf
         e6/cGy4UIrRu2pJtqhoMVYnx8EzG369fcQjapAkX8eSP/aI/PCVnawhDgGvwa8u+OhPg
         ou73+VuCSavpFsHUoNu2KVSyMUe3TO78y8PwJQKJeYeHsGF+LwMVj/E7+O3Td92llDUx
         A/26lBmC8bPeJri/is+N/bDtFiGXbykq2JkAMq3lVuIIyanpN3Nh4w7QX9mIv5ykR1aG
         DANScVWBEZEF4DOa+baKTEPA9wzIkIYGwoWhZDxtJeKBHau3C4Qa8kRup4eSI7ZjsLp/
         GZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=msSuyuNN1qGawUOx+wJjclYFd7Ehg7HyYzhPy0YPAk0=;
        b=tZ7U40T7B0HiIL+Tv05Zp13PAlwpSoMezAdmqqOR4ylh/+lhiRtknBSXKCNIHoaiZB
         dXK9utjQagei5/acuZDblJ4tWn0/KgUbaHbU8I/fLgV1bel3ZO4+JHEKIlfOLtjpola4
         NixVvLGJwakAtq8f1VPTrkS0TXEEGZTYeT2EXRoYYGJFftMVyF2TIlkDDRmML8tVo8Qe
         iuoJF9e0W7jfQML1Hk9kCzeiywz8SCTO1J2XSC3YEyewlInaAYTWLdPcapKBoCHn4+m5
         3xuxintp2FgcjIb1t2d714XAf21dUny0/ay/r3QYi1ZGuhrUUen8mhJeqfjAyflqJqmI
         6m5Q==
X-Gm-Message-State: AOAM532tCtIjB2LLaOLwH7z9rtsVCcKi0HZxHMrCVawIJXO9T3KwoPZC
        C6z0+M7kZi1pUB/ejn6/rU6ktu16c9Qun1c2orY=
X-Google-Smtp-Source: ABdhPJwmhnLF38mer2+8GwWxqdEq3jk4N7dGayQ86fBcbjkYfxQAivla60aReS+hODPbWazieSZGglyK4OFBBRPv4+4=
X-Received: by 2002:a1f:a3ca:: with SMTP id m193mr15666032vke.4.1636319076370;
 Sun, 07 Nov 2021 13:04:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:5911:0:0:0:0:0 with HTTP; Sun, 7 Nov 2021 13:04:35 -0800 (PST)
Reply-To: cja6665@gmail.com
From:   Charles <harunarabiu678@gmail.com>
Date:   Sun, 7 Nov 2021 22:04:35 +0100
Message-ID: <CAL=De6pwFBRYAGW_5ZgBMw8VkP50r2Gqe-JnhHDMqSKQYi87bQ@mail.gmail.com>
Subject: RE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
YOUR EMAIL ACCOUNT HAS BE SELECTED FOR  A $3,500,000.00 DONATION FOR
CHARITY. PLEASE CONTACT US FOR MORE INFORMATION
