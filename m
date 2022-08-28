Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DC15A3AC6
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 03:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiH1B1p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 21:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiH1B1o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 21:27:44 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0461E2B614
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 18:27:44 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 62so4050530iov.5
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 18:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=022FgkbYNbtFgKIzjHRlNtPYH3jaauGZA6eBbDBi8cg=;
        b=KjEvGYRxD29y61/hquiJULfJ+YBg6iEXwXgFSC0juprumHjzlIlgVQGKk3YInss2xI
         AbgMV79KoGjHuDGTwCUexFudrBlinlV+4wjD4cZ0sNDZj7IMAWInmaQEt5bKYvDsWYtf
         3i537e92hXylkXzavGqolLWJXWlkdAHTtg8MGi/q9dcix+nznhcgPsRd7YBV6sk8B3UI
         dT8S9i1OiP7frdLcPI3X6gBN0RgTF5ggo1y3svfpWMeHQjDpH33t7/VMSQIDetbdxC9R
         vWim9b1lnrFlMfubCzF6aEVxqLfTHAl949CzEdJSiPwha+eOF3e5zJNdj2TGf3ABt8GN
         Qv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=022FgkbYNbtFgKIzjHRlNtPYH3jaauGZA6eBbDBi8cg=;
        b=JADy+YJRwouz4FCitehDoiLwE5mD7K7iJZJ5Q0w6StFM0Kqdtk8GC4+AtxBcI9VgCc
         7SZLewb538AxKe8KsVr4e0rvH0EHt6UCeYthUflwfC/SmlLvhezcADESuY9jNq83u/w1
         zVEUVMKrAtVydbiGYEQa2HdgY5iN256fuo0IzPhwom1ic82tVjPoPJmVJjflvT5G4n9g
         4rlLtGz7ZI+SPZ72ublFlDvY7LQ68apC7xYkPP9dHnflDnlWokMNz7rn4C2MBPNIShGW
         CJNv5kQNKBHP40g7LnG6jODbQB/WY5ddPgdU+WpN01as0qlbMgnGD4alB+3Ml8XTp/K6
         uGkQ==
X-Gm-Message-State: ACgBeo3B30z41/uOwsviS9sXjuk1U5I7WV4TdMQyLQGaLnQ6rm1UbJaC
        pxjweshIfPyxp308e7LWvEl2hXN98OkSZNsXTrA=
X-Google-Smtp-Source: AA6agR4VpdujjgN1NxFOxwKEoixX5ea21CuH+w/9hXKf2whU+UmWk9pcQkmgpS9BroZByDDqJjxNUw9OhSb94PGwXs4=
X-Received: by 2002:a05:6602:2ace:b0:689:8f31:8cdd with SMTP id
 m14-20020a0566022ace00b006898f318cddmr6352686iov.145.1661650062940; Sat, 27
 Aug 2022 18:27:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:a50f:0:0:0:0:0 with HTTP; Sat, 27 Aug 2022 18:27:42
 -0700 (PDT)
Reply-To: www.orabankatm.tg.com@gmail.com
From:   =?UTF-8?Q?st=C3=A8reForeignDepartment_TransferUnit?= 
        <fdtu01tg@gmail.com>
Date:   Sat, 27 Aug 2022 18:27:42 -0700
Message-ID: <CABVxoQjkE4hyGzM8SZW0BhbER8rcJdouJ3Dg_ctaw98nLBC=4g@mail.gmail.com>
Subject: =?UTF-8?B?2KfZhNin2KrYtdin2YQg2LnZhNmJINmI2KzZhyDYp9mE2LPYsdi52Kkh?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2YjYstin2LHYqSDYp9mE2K7Yp9ix2KzZitipINin2YTYo9mF2LHZitmD2YrYqS4NCtin2YTZhdmI
2LbZiNi5OiDYpdiu2LfYp9ix2KfYqiDYp9mE2KzYp9im2LLYqSBSRSDYjCDYp9mE2YLYs9mFINin
2YTYr9mI2YTZiiDZhdmGIE1PTE9UVEVSWSDYudio2LEg2KfZhNil2YbYqtix2YbYqi4NCg0K2KfZ
hNin2YbYqtio2KfZh9iMDQrZg9is2LLYoSDZhdmGINin2YTYs9it2YjYqNin2Kog2KfZhNiq2LHZ
iNmK2KzZitipINiMINiq2YUg2KfYrtiq2YrYp9ixINin2YTZhdi02KfYsdmD2YrZhiDYqNin2LPY
qtiu2K/Yp9mFINmG2LjYp9mFINiq2LXZiNmK2KoNCtmF2K3ZiNiz2Kgg2YrYqtmD2YjZhiDZhdmG
IDEwMDUwMDAwMCDYudmG2YjYp9mGINio2LHZitivINil2YTZg9iq2LHZiNmG2Yog2YTZhNij2YHY
sdin2K8g2YjYp9mE2LTYsdmD2KfYqiDZgdmKINis2YXZiti5DQrYo9mG2K3Yp9ihINin2YTYudin
2YTZhSDZg9is2LLYoSDZhdmGINio2LHZhtin2YXYrCDYqtix2YjZitisINil2YTZg9iq2LHZiNmG
2Yog2YXYtdmF2YUg2YTYqti02KzZiti5INmF2LPYqtiu2K/ZhdmKDQrYp9mE2KXZhtiq2LHZhtiq
INmB2Yog2KzZhdmK2Lkg2KPZhtit2KfYoSDYp9mE2LnYp9mE2YUuINi22Lkg2YHZiiDYp9i52KrY
qNin2LHZgyDYo9mG2YMgLyDYudmG2YjYp9mGINio2LHZitiv2YMNCtin2YTYpdmE2YPYqtix2YjZ
htmKINmF2KTZh9mEINmE2YTYs9it2Kgg2YbYqtmK2KzYqSDZhNiy2YrYp9ix2KfYqtmDINin2YTZ
hdiu2KrZhNmB2Kkg2YTZhdmI2KfZgti5INin2YTZiNmK2Kgg2KfZhNmF2K7YqtmE2YHYqQ0K2LnZ
hNmJINin2YTYpdmG2KrYsdmG2KouINi52YbZiNin2YbZgyAvINi52YbZiNin2YYg2LTYsdmD2KrZ
gyDYjCDYp9mE2YXYsdmB2YIg2KjYp9mE2LHZgtmFIDIzMC0zNjUtMzA3MSDYjA0K2KjYp9mE2LHZ
gtmFINin2YTYqtiz2YTYs9mE2YogNzEwLTQzINiMINis2LDYqCDYo9ix2YLYp9mFINin2YTYrdi4
IDgg2IwgNSDYjCA2INiMIDI0INiMIDE5INiMIDM0DQrZiNin2YTZhdmD2KfZgdij2Kkg2LHZgtmF
IDUxINiMINmI2KjYp9mE2KrYp9mE2Yog2YHYp9iyINmB2Yog2KfZhNmB2KbYqSDYp9mE2KvYp9mG
2YrYqSDYsdiz2YUg2YTZiNiq2Ygg2LnYqNixDQrYp9mE2KXZhtiq2LHZhtiqLg0KDQrZhNiw2YTZ
gyDYjCDYqtmF2Kog2KfZhNmF2YjYp9mB2YLYqSDYudmE2Ykg2K/Zgdi5INmF2KjZhNi6IDXYjDgw
MNiMMDAw2IwwMDAg2K/ZiNmE2KfYsSDYo9mF2LHZitmD2Yog2Iwg2YjZh9mIDQrYp9mE2YXYqNmE
2Log2KfZhNmB2KfYptiyINmE2YTZgdin2KbYstmK2YYg2YHZiiDYp9mE2YHYptipINin2YTYq9in
2YbZitipLiDZh9iw2Kcg2YXZhiDYpdis2YXYp9mE2Yog2LXZhtiv2YjZgiDYp9mE2KzYp9im2LLY
qQ0K2KfZhNio2KfZhNi6IDM42Iw0NTDYjDAwMC4wMCDYr9mI2YTYp9ixINiMINmI2KfZhNiq2Yog
2YrYqtmFINiq2YLYp9iz2YXZh9inINio2YrZhiDYp9mE2YHYp9im2LLZitmGINin2YTYr9mI2YTZ
itmK2YYNCtmB2Yog2KfZhNmB2KbYqSDYp9mE2KvYp9mG2YrYqS4NCg0K2YjYp9mE2YrZiNmFINmG
2K7Yt9ix2YMg2KjYo9mGINij2YXZiNin2YTZgyDYs9iq2YLZitivINmB2Yog2KjYt9in2YLYqSDY
qtij2LTZitix2KkgQVRNINmF2YYg2YLYqNmEINio2YbZgyBPcmEg2IwNCtis2YXZh9mI2LHZitip
INiq2YjYutmILiDYo9ix2LPZhCDYp9mE2YXYudmE2YjZhdin2Kog2KfZhNiq2KfZhNmK2Kkg2YTY
qtiz2YTZitmFINmF2KjZhNi6IDXYjDgwMNiMMDAwLjAwINiv2YjZhNin2LENCtij2YXYsdmK2YPZ
iiDZiNmH2Ygg2KfZhNmF2KjZhNi6INin2YTYpdis2YXYp9mE2Yog2KfZhNiw2Yog2KrYrdiq2YjZ
itmHINio2LfYp9mC2Kkg2KfZhNi12LHYp9mBINin2YTYotmE2Yog2KfZhNiu2KfYtdipINio2YMu
DQrYqtij2YPYryDZhdmGINil2K/Yrtin2YQg2KfZhNio2YrYp9mG2KfYqiDYp9mE2LXYrdmK2K3Y
qS4NCtin2LPZhdmDINin2YTZg9in2YXZhCA9PT09PT09PQ0K2KjZhNiv2YMgPT09PT09PT0NCtmF
2K/ZitmG2KrZgyA9PT09PT09PQ0K2LHZgtmFINmI2KfYqtizINin2Kgg2KfZhNiu2KfYtSDYqNmD
ID09PT09PQ0K2LnZhtmI2KfZhiDZhdmG2LLZhNmDID09PT09PT0NCtiq2YfYp9mG2YrZhtinIQ0K
2YXYuSDYp9mE2KfYrdiq2LHYp9mFDQrYr9mD2KrZiNixINmD2YjZgdmEINiz2YTYs9iq2YrZhg0K
INin2YTYqNix2YrYryDYp9mE2KXZhNmD2KrYsdmI2YbZiiDZhNmE2KfYqti12KfZhCA9IHd3dy5v
cmFiYW5rYXRtLnRnLmNvbUBnbWFpbC5jb20NCg==
