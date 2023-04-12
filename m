Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F9E6DF21D
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 12:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjDLKn0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 06:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDLKnZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 06:43:25 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098BA4EE2
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 03:43:25 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w19so7317037oiv.13
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 03:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681296204;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y5t9haSUmu6+LRsJr/oOTk9eZWnzPg4O73mmGdbJGS8=;
        b=FSHntqtqMnFnN+sO0Bp+WJJ4QjFK92KSP/JnR/4QeR9NTvHBA8yYUWxasFHrbDEQGh
         rJROdN3DP+aRU7Oy7+OXh2r42YzJ6jKXgOqOrNvPm/Q+P65bpxZo/w/pCypUn0kMAho5
         fH4cgWGMksCjnRuKpQNemHoYNVoOh5x8KirT94L6ZTcs6oLenWDhXoRQQWjnT/TBKDNL
         Td5IaUO+m1tg1iycFuz5YlbyFizXOC+sxtUK/4BD0RiWyFAt75sRSAD5lFFHrrx3HbBf
         NdXekP/K6N3wEnqgQ/73vzGsAIoRbyHSygIKukkQqmVpiQWa5jd/IdmkIFvQHb3xYj+g
         P1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681296204;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5t9haSUmu6+LRsJr/oOTk9eZWnzPg4O73mmGdbJGS8=;
        b=DRKqbmlBPd33yUot+ClL4q+/0WmxD1nNiDpDMHWxEVw/i01hiAYegFGJzAKSArkuM+
         ObFOO60VXpqLDDAtHNnM5bjBEaO45Wp79jBRXC+ePeWNPLXp5koqZS1Kq94Cqo8ZuE8p
         ytdDMLsoYwMf//7s0XweenBH8TVLx40TFAnLK0FprCqtF4xkxyvdLDh20jLIdhP6XL41
         hyyuQW304BWq2NVkkIE12xNckNw9Hr9fS7DVp9KYbvkvolOtDG/G9RYoAo63tXQBWYpM
         DrJ4bGsg9cBoIymuKRyaTgNMzNJollIZCFSjQ7FjJ4kdNXizHGrhrNxnyeHkzW9mLq/x
         keRw==
X-Gm-Message-State: AAQBX9ek8z/6/1SZeY0sbpuERzlomNcVy88ASRJaqugRfeRzMvzGFAJn
        QOlUtQO323FsxSTfWJfrpxlPQpGOzC30Z3nwAo0=
X-Google-Smtp-Source: AKy350YSG+T5/3s1Ug9Lh99JZj9dYht10C4nBA6EYaOkUcF7DEoiG/UtUJ/NJ8x10Yuc2iUq4tRHj2a4hkzojg6pwSE=
X-Received: by 2002:a05:6808:9aa:b0:38b:d8a9:9d95 with SMTP id
 e10-20020a05680809aa00b0038bd8a99d95mr1504973oig.5.1681296204267; Wed, 12 Apr
 2023 03:43:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4b0b:0:b0:6a1:6a34:8daa with HTTP; Wed, 12 Apr 2023
 03:43:23 -0700 (PDT)
Reply-To: felixglas37@gmail.com
From:   Douglas Felix <douglasmomoh007@gmail.com>
Date:   Wed, 12 Apr 2023 10:43:23 +0000
Message-ID: <CA+RX96_=SbA5ff1Hrpf7G-sKnxfm30gbSOOaBb6h0KDYJ0MmNw@mail.gmail.com>
Subject: =?UTF-8?B?5YaN5Lya?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

LS0gDQrkuIrlkajmn5DkuKrml7blgJnlr4TkuobkuIDlsIHpgq7ku7bnu5nkvaDvvIzmnJ/mnJsN
CuaUtuWIsOS9oOeahOWbnuS/oe+8jOS9huS7pOaIkeaDiuiutueahOaYr+S9oOS7juadpeayoeac
iei0ueW/g+WbnuWkjeOAgg0K6K+35Zue5aSN6L+b5LiA5q2l55qE6Kej6YeK44CCDQoNCuiCg+eE
tu+8jA0K5b6L5biI44CCIOmBk+agvOaLieaWr+iPsuWIqeWFi+aWrw0K
