Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE826D2E7A
	for <lists+bpf@lfdr.de>; Sat,  1 Apr 2023 08:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjDAGCk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Apr 2023 02:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjDAGCj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Apr 2023 02:02:39 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83869CC3A
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 23:02:38 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id cr18so19853964qtb.0
        for <bpf@vger.kernel.org>; Fri, 31 Mar 2023 23:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680328957;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v7MwNEQgoLr1DsIfUSRAVJWR1UtEIkQfpF6+DRE0NHU=;
        b=BmuJwSXCeu7WvOEoh8CCJmkUoFhsbCuw1jI08FDZPLqf3tmB6XR4Y3Z3yS3bBPDhMe
         XE6SaOg0JMzxgMnTkcWmqUxDjCO2D8CaZRwCuuwT7vwtKvO5SC5VBYVTdOCQq2gEaTz6
         yCNQ10X3AarGaX3l4dMFriwQrmaM1piGfyOGsq88Be8odE5KEY3sTsljptvy0cOvkbYP
         bKZzGLpCOnPCHuwNKseXacqPO8ygN6iTscjLsO53yguBHIjMFHP08lASQKncHj5kH0zf
         lrGvg+vd6ODUiNRgZEaJv8RIW+0YHi2iVJarqm+HlPweIx7o6QxkYTqQJxn1h9htMSqv
         x9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680328957;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7MwNEQgoLr1DsIfUSRAVJWR1UtEIkQfpF6+DRE0NHU=;
        b=BVjlhE53HCl7V2vAfU8Dyh5pFcHCJHZeiSS8lTVnHbFWKFjhBH6nPfClhzg5QPkBuv
         Wn43crL7RgWRz7d0JsJmIkVK/MJIn0yOWoDSd3ZPBDFCu7x/262q6CwogRRuQVcJJQzD
         w0CVBX38LQHL/2+Kmb91fm3dfAZA+9rykN4YN8QetjxysBChGzJLw36IOK5L7OCd375+
         WnTz0g2UKxtrrY3TqwbNpjY3CFy4ExhAtIVSmF8Ax1n+TEAl71z87tmaCnl8IVoUPJAW
         Zyuan4phdLm09VRWdqKgMbg8lSLIsji7TBSOyjLPlYAObpYEzJSJ0H6wna9NJ7M5pHNm
         kkvQ==
X-Gm-Message-State: AAQBX9dTKo/EyCsWyj96+bt5TxE32mR4Ekx8DeXtq4uH/lSnrxHyj9uk
        10ru2vZINlj2YCwE7/5dN3zEE4935oAoJI0FUv4=
X-Google-Smtp-Source: AKy350bz7hyy33xOQXkVa6CVuAWDrYxfyDuqR/VvpXhFJcvagEeQNlcEcHH/M0JLX8y/knAnkri8M2i5wIOhSt/JIAE=
X-Received: by 2002:a05:622a:1ba7:b0:3e6:2fab:675 with SMTP id
 bp39-20020a05622a1ba700b003e62fab0675mr3261127qtb.9.1680328957669; Fri, 31
 Mar 2023 23:02:37 -0700 (PDT)
MIME-Version: 1.0
Sender: mmrskish@gmail.com
Received: by 2002:a0c:8f1a:0:b0:5b4:bd23:6916 with HTTP; Fri, 31 Mar 2023
 23:02:37 -0700 (PDT)
From:   Ibrahim Idewu <ibrahimidewu4@gmail.com>
Date:   Sat, 1 Apr 2023 07:02:37 +0100
X-Google-Sender-Auth: DpXzzJlOGy2ZJgcsih12vLgziUs
Message-ID: <CAF2A5Bd2T+N_mA7WLP8-xVZBKa+-k9UoDa1kcH0bNhQNYDpvkA@mail.gmail.com>
Subject: OPPORTUNITY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=ADVANCE_FEE_3_NEW_FRM_MNY,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_USD,MONEY_FORM,MONEY_FRAUD_3,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I have a business proposal in the region of $19.3million USD for you to han=
dle
with me. I have the opportunity to transfer this abandoned fund to your ban=
k
account in your country which belongs to our client.

I am inviting you in this transaction where this money can be shared
between us at the ratio of 50/50% and help the needy around us don=E2=80=99=
t be
afraid of anything I am with you and will instruct you what you will do
to maintain this fund.

Please kindly contact me with your information if you are interested
in this transaction for more details(ibrahimidewu4@gmail.com)

1. Full Name:
2. Your direct mobile number:
3. Your contact address:
4. Your job:
5. Your nationality:
6. Your gender / age

Best regards,
Mr.Ibrahim idewu.
