Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670A856FFA0
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 13:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiGKLBi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 07:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiGKLBO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 07:01:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BDC108BD1
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 03:06:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b8so3016413pjo.5
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 03:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=PAXVwj5KV7QHJkz3JV1tUchfOSXDlpVf8HSdvLuBDBU=;
        b=dOqzhC5u2KevK1gsZXusFOsoZZNO2238t7McWJPELz7CuXu/QpEFWOLMAIoYHK846N
         JGxGMrVwa6qmDcKHFnYT8aI89z3GE5ahPZSlJaOK2F9vRhTL+nvMNS4LDw+XZe/pn/Dl
         8kBe/Br1Dc5MXcQuIf83lXDjwYvQCPAKjNJN0RfN31YqBXfOXQa8xXe7yy1K5cdUFdO2
         YgEqfO+CSWkksW1H8meKLZ7PxtlczL39On377VZnwNp8z5gxs0V0XjK8+j1b4Gu2/XDM
         PzmOIEA5iRcZH3/Lkf+w2x9rm8Y2v3qVWM4G+grJjS0xmhOfQ8dkX5UpO/5//ttEK6qs
         Mb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=PAXVwj5KV7QHJkz3JV1tUchfOSXDlpVf8HSdvLuBDBU=;
        b=QEsLoTaL5maRO24gjYCUY0ipJxzsvH4vir+lHCJG/NnFNzKQnUazQsfWr8XP8Fe6vM
         G0+8QtOLOKy9qQWbU045GZmjr5oX9u8olNRjbeLiFb2zcdCFCkAa7iC/ngwPHXPLI5G5
         LXfw4uL46XislgKEeyR1HAbNVC/BF5OxbFpTaK+a9SJo/Jftqc2Qnz1SEuAP3kd7uhY8
         LABqgBo57xDHVGttSWlRAVcIDb/9Dx22ZWlFJE2958utqVS39ahHtSZSojy6Wd8oRvyK
         PvmVClKbfRuc+JMHwvJ4QZlSyQUJCsKSqTfNLzI2WPDycVuLm9y+yvLLI1eUzJaT1cGV
         4NSw==
X-Gm-Message-State: AJIora/uvEhPu4AG96KkLHEKeBNgNRjBI/P6mQlybk4jGpTE7wwcRPhE
        6RmZ1gTznRCx3vcWIqTeVaLrlE6KZDeNpECbavc=
X-Google-Smtp-Source: AGRyM1sBLPzRkZIIEzLU8PQQ3QzUCjRTdJscm0Ejk0cYiBtp/2c/8kOmcfIY0o29SixzjhLQ47nyUjazDjA7gb/qS1o=
X-Received: by 2002:a17:902:c947:b0:16b:f442:8568 with SMTP id
 i7-20020a170902c94700b0016bf4428568mr17794030pla.55.1657533972058; Mon, 11
 Jul 2022 03:06:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:49a:0:0:0:0 with HTTP; Mon, 11 Jul 2022 03:06:11
 -0700 (PDT)
Reply-To: donaldphilip801@gmail.com
From:   James williame <georgehilla8@gmail.com>
Date:   Mon, 11 Jul 2022 03:06:11 -0700
Message-ID: <CAF1CgQpf7Dj5wtpVPzO8V+fN4uTZFr=DMvtW6z_exDw+hwidMA@mail.gmail.com>
Subject: =?UTF-8?B?2YXYsdit2KjYpyDYtdiv2YrZgtmKINin2YTYudiy2YrYsg==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2LXYr9mK2YLZiiDYp9mE2LnYstmK2LINCg0K2YPZitmBINit2KfZhNmDINin2YTZitmI2YXYnyDY
o9i52KrZgtivINij2YbZhyDZgtivINmF2LEg2YjZgtiqINi32YjZitmEINmF2YbYsCDYotiu2LEg
2KfYqti12KfZhCDZhNmG2KcuINi52YTZiSDYo9mKINit2KfZhA0K2Iwg2KPZhtinINij2KrYtdmE
INio2YMg2YXYsdipINij2K7YsdmJINio2K7YtdmI2LUg2YXYudin2YXZhNiq2YbYpyDYp9mE2LPY
p9io2YLYqSDYp9mE2KrZiiDZhNmFINiq2YPYqtmF2YQg2YXYudmDINio2YbYrNin2K0uDQrZhdmG
INin2YTZhdik2LPZgSDYo9mGINin2LHYqtio2KfYt9mDINio2Yog2YTZhSDZitiq2YXZg9mGINmF
2YYg2KXYqtmF2KfZhSDYqtit2YjZitmEINin2YTYtdmG2K/ZiNmCLiDZhNinINij2LnYsdmBINiM
DQrYsdio2YXYpyDYqNiz2KjYqCDYp9mE2YPYq9mK2LEg2YXZhiDYp9mE2LbYuti3INiMINmB2KPZ
htiqINmF2KzYqNixINi52YTZiSDZgdmC2K/Yp9mGINin2YTYp9mH2KrZhdin2YUg2KjYp9mE2LXZ
gdmC2KkuDQoNCti52YTZiSDYo9mKINit2KfZhCDYjCDZitiz2LnYr9mG2Yog2KPZhiDYo9io2YTY
utmD2YUg2KjZhtis2KfYrdmKINmB2Yog2KrYrdmI2YrZhCDYp9mE2LXZhtiv2YjZgiDYqNin2YTY
qti52KfZiNmGINmF2LkNCtin2YTYtNix2YrZgyDYp9mE2KzYr9mK2K8g2YXZhiDZgdmG2LLZiNmK
2YTYpy4g2KPZhtinINit2KfZhNmK2Kcg2YHZiiDZgdmG2LLZiNmK2YTYpyDZhNmE2KfYs9iq2KvZ
hdin2LEuINmI2YXYuSDYsNmE2YMg2Iwg2YTZhQ0K2KPZhtizINis2YfZiNiv2YMg2KfZhNiz2KfY
qNmC2Kkg2YjZhdit2KfZiNmE2KfYqtmDINmE2YXYs9in2LnYr9iq2Yog2YHZiiDYqtit2YjZitmE
INin2YTYo9mF2YjYp9mEINiMINix2LrZhSDYo9mG2YbYpyDZhNmFDQrZhtiq2YXZg9mGINmF2YYg
2KfZhNiq2YjYtdmEINil2YTZiSDZhtiq2YrYrNipINmF2K3Yr9iv2KkuINiq2YLYr9mK2LHYp9mL
INmE2KzZh9mI2K/Zg9mFINmB2Yog2YXYs9in2LnYr9iq2Yog2Iwg2YLYsdix2Kog2KPZhtinDQrZ
iNi02LHZitmD2Yog2KfZhNis2K/ZitivINiq2LnZiNmK2LbZgyDYqNmF2KjZhNi6IDg1MCDYo9mE
2YEg2K/ZiNmE2KfYsSDYrdiq2Ykg2KrYqtmF2YPZhiDZhdmGINiq2KzYsdio2Kkg2KfZhNmB2LHY
rQ0K2YjYp9mE2LPYudin2K/YqSDZhdi52YbYpy4NCg0K2YTZgtivINiq2LHZg9iqINio2LfYp9mC
2Kkg2KrYo9i02YrYsdipINin2YTYqti52YjZiti2INin2YTYrtin2LXYqSDYqNmDINmF2Lkg2LPZ
g9ix2KrZitix2KrZiiDYrdiq2Ykg2KrYqtmF2YPZhiDZhdmGDQrZhdiz2KfYudiv2KrZiiDZgdmK
INil2LHYs9in2YTZh9inINil2YTZitmDLiDYp9mE2KLZhiDZitix2KzZiSDYp9mE2KfYqti12KfZ
hCDYqNiz2YPYsdiq2YrYsdiq2Yog2YHZiiDYqtmI2LrZiCDYjCDYp9iz2YXZh9inDQrYp9mE2LPZ
itiv2Kkg2K/ZiNmG2KfZhNivINmB2YrZhNmK2Kgg2YjYqNix2YrYr9mH2Kcg2KfZhNil2YTZg9iq
2LHZiNmG2Yo6IDxkb25hbGRwaGlsaXA4MDFAZ21haWwuY29tPi4NCtin2LfZhNioINmF2YbZhyDY
o9mGINmK2LHYs9mEINmE2YMg2KjYt9in2YLYqSDZgdmK2LLYpyDZhNmE2LXYsdin2YEg2KfZhNii
2YTZiiDYqNmC2YrZhdipIDg1MCDYo9mE2YEg2K/ZiNmE2KfYsS4g2KPZhtinDQrYp9mE2KLZhiDZ
hdi02LrZiNmEINmE2YTYutin2YrYqSDZh9mG2Kcg2YHZiiDZgdmG2LLZiNmK2YTYpyDYqNiz2KjY
qCDYp9mE2YXYtNin2LHZiti5INin2YTYp9iz2KrYq9mF2KfYsdmK2Kkg2KfZhNiq2YoNCtij2YXY
qtmE2YPZh9inINij2YbYpyDZiNin2YTYtNix2YrZgyDYp9mE2KzYr9mK2K8uINin2KrYtdmEINio
2KfZhNiz2YrYr9ipINiv2YjZhtin2YTYryDZgdmK2YTZitioINi52YTZiSDYp9mE2YHZiNixINiM
DQrZiNij2K7YqNix2YfYpyDYo9mK2YYg2KrYsdiz2YQg2YTZgyDYqNi32KfZgtipINiq2KPYtNmK
2LHYqSDYp9mE2KrYudmI2YrYtiDYp9mE2K7Yp9i12Kkg2KjZgy4g2LPZiNmBINiq2LHYs9mEINmE
2YMNCtin2YTYqNi32KfZgtipINiv2YjZhiDYqtij2K7ZitixLiDYo9iq2YXZhtmJINmE2YMg2YPZ
hCDYp9mE2KrZiNmB2YrZgiDZgdmKINis2YXZiti5INmF2LPYp9i52YrZgy4NCg0K2KzZitmF2LMg
2YjZhNmK2YUNCg==
