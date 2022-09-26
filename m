Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465085E9E1C
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 11:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiIZJoZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 05:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbiIZJoH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 05:44:07 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C51210FDC
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 02:42:17 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id u3-20020a4ab5c3000000b0044b125e5d9eso1023597ooo.12
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 02:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=EThfXOsChd8Ds/teM8XF9/4bZFxtFbmMMLDhrhk/LVg=;
        b=YYc5P+j35LDNKZy88I137TEl6ocfw3FZ0Hz9ef/d9+GrxBvDRc6Hc0LymPnj0LIIpT
         4oAtcYJXDOZkFC1vSetGjbmam0ePZZmCPCsUf1pz6UlEOL/wcTRtwnItdCLAkc9NwBsW
         gPBF2Afi+fVKc0CXj90V6T1rVyPwHXyVP4h0TZ1WXnZtzI2RnzHSGF11VfLxIbVo5MAA
         vLFM+LTvBnCjH5faSbZU+i2NEYGuPYYf6Gl1mZKX3EGSIY4GMCseIsfAafOkxuIk/mGJ
         lCeWplMDCWGi+vS1mK/M7b8QtXfraqCS8HoVYy6RIyD73FH2vnxxeFqTeehX1lPDShuo
         IpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EThfXOsChd8Ds/teM8XF9/4bZFxtFbmMMLDhrhk/LVg=;
        b=jpwjoVg5LjhA6VMn8xlIK14+CycMAKVC0Y4r0qqdQoGXV3OZPfYbhgP91FF7mj/Nyj
         tuOdyY+v7LEOowY3zurCC9VQo111oXmE4iWpXLoGcKwHLZpnMI2pZJYhdPG0L0IIXGxx
         1iepWLRtLNmTXXJmLM8Nj87gxcyiI/x6z6zXZsbJf+hlB6NpqXVYNN5TKk2QKVEbRCkJ
         Qx6cVE9gZ3Ww+B6Y5/zy57O9F/2rW2Qz4VZk07U7uIj/MVitVHI2YEG1yE64B3lDa1uZ
         6Ztv0KvlegJOTohmlqryaNXJTMAmIWp8vTJULyOtTxr8mnjnDGLz4f8FXiBi2fgYQOZB
         fMdw==
X-Gm-Message-State: ACrzQf14aZ0WgE87WYon5SDyQSG9aoYe4NIo5Dz2pga1uiKijD7CW47z
        PkwqIMTNmwaRhXF9LZfoZZ62H2eB+vKncHMNauQ=
X-Google-Smtp-Source: AMsMyM5vtslIrE21DzLyz5XfEWQ2sGqtaLHgMdzPnuD/TEUvQxvWzvaXce0JaoyM/RXd7w0WZi+wKktpzRSZtHMXPK8=
X-Received: by 2002:a4a:b984:0:b0:476:4c84:d434 with SMTP id
 e4-20020a4ab984000000b004764c84d434mr6875785oop.75.1664185320851; Mon, 26 Sep
 2022 02:42:00 -0700 (PDT)
MIME-Version: 1.0
Sender: mohammeddrashok@gmail.com
Received: by 2002:a05:6838:4426:0:0:0:0 with HTTP; Mon, 26 Sep 2022 02:42:00
 -0700 (PDT)
From:   Ibrahim idewu <ibrahimidewu4@gmail.com>
Date:   Mon, 26 Sep 2022 10:42:00 +0100
X-Google-Sender-Auth: ukYfDBvhB3IjSvYtnk97j33A9iA
Message-ID: <CAL=ghb51O0f_D=_0c+wU+K04xkpQoAjBdmoHHb-tiR12dr9W5Q@mail.gmail.com>
Subject: I Need Your Respond
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.4 required=5.0 tests=ADVANCE_FEE_5_NEW_FRM_MNY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MONEY_FORM,
        MONEY_FRAUD_3,NA_DOLLARS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_LOAN,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

My name is Mr.Ibrahim Idewu, i work in the bank here in burkina faso.
I got your contact
from internet search i hope that you will not expose or betray this
trust and confident that am about to entrust in you for the benefit of
our both families.

I decovered an abandoned fund here in our bank belonging to a dead
businessman who lost hs life and entire family in a motor accident,
I am in need of your help as a foreigner to present you as the next of
kin and to transfer the
sum of $19.3 million U.S dollars (nineteen.three million U.S dollars) into your
account risk is completely %100 free.

send me the below details

Your Full Name.

Your Country.

Your Age.

Your Occupation.

Phone Number.

contact address

best regards
mr Ibrahim Idewu
