Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C786862FB
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 10:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjBAJle (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 04:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjBAJld (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 04:41:33 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C285D133
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 01:41:31 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id a1so2193021ybj.9
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 01:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5f7Vo+JFAerdiMoOwREJwZlbAlqNzBMzi2DNbGEP4U=;
        b=kvONBYoizGLWRAx3xHFRHrm7vGgwu0cW77w03VyL35Jw6AJVd63wYPnnjLkbA1HGgs
         hJMjRfxzcFUK6fKTi/VH1hkQ6pkfHzkRymJL62dMATzLCp+Mp+1btWL13TnsKwUwvWji
         ZINjpv6b9ciZJ0/kmlioPYa6K6Gvy+EHStDL3TlvhWurxMv87aVXWOSsZOobhZmEU2+b
         8Epr3kDbaN1v1t+sHWq6EmY8Gdr7WdAx4+MgOJWM7HN6BI5ZLNbYUyc0XZg0Rx1W3fCq
         EWoIkGwZRAL7DccJ1sHCXGro6wD9+b+V9aPCGsh1RevdNXIodfn8+Q/n8oXwKMVT/e0E
         QZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5f7Vo+JFAerdiMoOwREJwZlbAlqNzBMzi2DNbGEP4U=;
        b=DeQffp58rDdZbwlewByeLM8NdSYowE5ZRdHz3s8t2g1ju7umJwm2Z0aR2qZzKkX0fn
         g7WIeYQmHb6wCXVPrLkxz8k+pnvFzWhYkRRV5TQpUJRft8/u+IHGSWO08Gr9gY85uugq
         2QZ8YOE9e5HqV6ksCMIFQ3QcPOcs7ZUlDPybr78/HGHhqnjXfwj6n4A3AQTuomG4oxo6
         adwvhn6cskRYZGGffvui2sBwul8oHd86f8IPxiD8IIW9Mu7FhkTVENCG36MNuv/8C/jM
         k8jjNsmGK5iqJOzOyyUwvM9KQMjo1zQT/bUYdkyBcZtNUx5A9DpB5w2l7LrMtaSlt7/n
         jhUw==
X-Gm-Message-State: AO0yUKXdhovxyKyiGhRKuX2XwrV8LFkgZS7FVD2I/hO+wRdXXGqcOJEB
        +KIVjgvJhjvksb0wDhiRs1t63U+Nle7R9WcBAKtpRT+7cZFdAw==
X-Google-Smtp-Source: AK7set+cZXddw8D7hzkfLANPKXnnoKvTbgFJ3PdZvjiyXZhTrHQpcwu1I03+cYe+mCJxEfLz+bXWGqbj13mQrrd3Qlg=
X-Received: by 2002:a25:12c2:0:b0:824:2dc5:3be5 with SMTP id
 185-20020a2512c2000000b008242dc53be5mr290820ybs.570.1675244490211; Wed, 01
 Feb 2023 01:41:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:1494:b0:1a2:7785:5d68 with HTTP; Wed, 1 Feb 2023
 01:41:29 -0800 (PST)
Reply-To: cynthiaaa199@gmail.com
From:   Cynthia Lop <expresslogisticsdelivery20@gmail.com>
Date:   Wed, 1 Feb 2023 09:41:29 +0000
Message-ID: <CADPRa6mrt4Dowi7rPCGcanROYSGs-7CMC=pc7FroHLf3JKUzZA@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Gooday , I saw your email from facebook.com,

I am Miss. Cynthia from United States ,I work in Ukraine Bank , I
contacted you because i have something important to tell you , Please
contact me back  for more information,
