Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE8A4D8E01
	for <lists+bpf@lfdr.de>; Mon, 14 Mar 2022 21:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242151AbiCNUQf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Mar 2022 16:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236244AbiCNUQe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Mar 2022 16:16:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611CB33EA6
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 13:15:23 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w12so29219137lfr.9
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Y1fLfQqbKSBfpRY3kVshBxmlsZ8GJ1fhC3Qvk3voIdw=;
        b=ESZymB4DEb3DTObGnbo9vp5z2zcyTCakst2obDSdcqr8zhhu6+SMg2u0SxoN+xPROL
         fMuVD+C9XIBOW4Rau9VQijIqq0VwOL8CI2QI0v6ywWONXB1cGnW+JbaQhoDM+0TTT4sm
         MztcvcL6N8YqQQKM2zN94XzLLHAa2oSBi8WHaygzy8+CdkvqP2HDAePkofhMS8RakQhx
         kG/aTjjZs5iZTCi2TWQtZ8jGKaKxOdod0W8uMwwkAAqvFyI6YjXr6eo3tlku+AFvDWZU
         gd/Y3JaOVeq4YSRnEyvPbpig1KbrF7Q5zsEJWqpULaCkG5GGC8J3zetkH3JSabPO1b4t
         lY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Y1fLfQqbKSBfpRY3kVshBxmlsZ8GJ1fhC3Qvk3voIdw=;
        b=tHYt4EWMe5CxpYup0Ezb/dORDYtafalbw7AtV6Tn4kQko2XB9iXiIaWIZAWM4HILw3
         mie1wi66fs0BsaxsFHwfwPEcp4C21qh14K6McAkPqTMbZ3gUYVItwRfqzl9OTApBhAeL
         5JrtXBqir72URKPs7d27D3h8kp0/UIhLUTQ8iiPbCiBZetuG9v9l4BqNIqCZgo6ABleX
         jzmoWzlrVcyn2AVs9fIChtu3jE6vcsVhhpF7fHAap0VOSoaA+Dc+76eyofxzpImrnBAg
         TriJab2MTWqLBn0jZkmgmlKuCF8ODlf9I+2omUrIw6wwnbB4LPjrfNc/ArnJiIbpj3CB
         auuA==
X-Gm-Message-State: AOAM531qWObkJelMCt2O4Zik3o4rPi2cMj+TKZR4PL2wxfiajGyy9qeu
        siPBqFZ5GxDFs62av2IZCEhRzadtZRrm1AT5Y86ZLqW6b2U=
X-Google-Smtp-Source: ABdhPJwlejsitcKr3vZWcMJlC+hVhndsRZ+AoyU506bSVoyC8SEz3ychdmlkYbLjWGbmTcvEkRsRHLVl8g6xp77+2Dg=
X-Received: by 2002:a19:6145:0:b0:448:2f83:4f6a with SMTP id
 m5-20020a196145000000b004482f834f6amr14498611lfk.164.1647288920977; Mon, 14
 Mar 2022 13:15:20 -0700 (PDT)
MIME-Version: 1.0
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Mon, 14 Mar 2022 16:15:10 -0400
Message-ID: <CAO658oXGvzTsPDTE9yLEfxJbjFvBt7-HzfO5Aa94PWXKWXPCzA@mail.gmail.com>
Subject: bpf_map_create usage question
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi there,

If I call `bpf_map_create()` successfully I'll have a file descriptor
and not a `struct bpf_map`. This stifles me from using a lot of the
`bpf_map__` API functions, for example `bpf_map__pin()`. What's the
reason for this? Is there a way to get a  `struct bpf_map` that I'm
missing?

Thanks so much,
Grant Seltzer

P.s. been a while since I've worked on adding docs, but I will finally
be getting back to it!
