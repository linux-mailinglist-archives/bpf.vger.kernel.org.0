Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B0167A737
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 00:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjAXXwY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 18:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjAXXwW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 18:52:22 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDD04201
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 15:52:20 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id y9so14797945lji.2
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 15:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJ/QyPMvHYitchauxg+J4IBvV0VZtgC9RglXLyAlxPA=;
        b=Dzmc0gKsy3coC0buILAgl3Ola3rZPSboh5rroD4xtmTTWP2JrxZS/00pmKma/b9kpi
         Wot6qc0GaALU3tBU2c8hII6jla9H25Wz5rF8HzLqhGM0f6ITj9F4dHz+iF/1lLODnP0W
         TiUXfjEilHxK2EALv546c6sIunqoefswFNMJgWp2R9SZVocOSVGKoo4+wpe4wB8ro++K
         g0A5nuSxLgrnw/PmZLQai2UZUGeT2zWggomln7bfoy1dMR4jya69UQohRTm3YrO0bzco
         PFrP2s917kBv00lPaEqt0gNnneOKxAfggzBAW6V4acXGtHfz8TlOj1w4NdqyLaC46un/
         FVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ/QyPMvHYitchauxg+J4IBvV0VZtgC9RglXLyAlxPA=;
        b=rjUTZP1mimSSYiRf8NsOg2ah6YBiSmF5W1PD1GKqB1XMFRlJXaJl+HKESWqVtGHDbV
         FX95c1+3sOgmebnp2wIYgdE26608MtperYhU03vfo7i+C0svYISfe7wM4/Thm9Fg0FH+
         V5jb7i+Q+m8ITHvBdXyAClu3qEUEgYtG4uUjIek7fik3joTmN4mR0gScfycS2ntDTGOI
         f6E42bmhlc3r4GAaZj20nJHrv9NgDWgue95sEdzyPDSsc906wtnePjBWXcwKwc+eivKX
         uQABguTQTFooO88lAEURzxV+hu4tg7rSR+oiy9iJIlNaj12Qf4TOQ7r6jjXUSTGQ32+z
         c8vA==
X-Gm-Message-State: AFqh2kp/bOB05Joiif4SFA3Sy/akEHXvDvxwtE3gXA8sJS7gcFqBefrl
        SkVbmTycvFc09CPW2AJXNvl5rRuaH5rmGP7dJlM=
X-Google-Smtp-Source: AMrXdXt0PEwEOVwXP1vGnWUzomUbgcR4XshWTFuFWWCLVH+vVWeePReiUMDOJfs5P81FjzBPL5mClTaQXWubeN8+iU8=
X-Received: by 2002:a05:651c:555:b0:282:1326:7888 with SMTP id
 q21-20020a05651c055500b0028213267888mr1496625ljp.496.1674604338289; Tue, 24
 Jan 2023 15:52:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:651c:210f:0:0:0:0 with HTTP; Tue, 24 Jan 2023 15:52:17
 -0800 (PST)
Reply-To: ms.bbianca@yahoo.com
From:   Ms Blake Bianca <lamoussadionou76@gmail.com>
Date:   Tue, 24 Jan 2023 15:52:17 -0800
Message-ID: <CAJY9HcAjrtc_d7J0gqnw1GgjVT203dauQiJEsDY3SOz7Ku+Xjg@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

      I have an offer for you, kindly reply back for more details.

Remain Bless,
Ms Blake Bianca
