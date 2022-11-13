Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB026627099
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 17:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbiKMQa3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 11:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbiKMQa3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 11:30:29 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553C87674
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 08:30:28 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id g24so8084130plq.3
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 08:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vdU0l5q7SwDqyQdrl+AlHir8nP1WSQabvgknUb9WZQA=;
        b=eZmAIErqOnrhL7C8rilTlivxpxuzeOpPez1v707b40CzDVNLkuOu1ypXnZLomL5OhI
         8Q5jtryPMAk2b6MaXT/XxbI2yMxlXtssiq0/aXFPZPhosTppErvwpOsIzUVtdSgAjASz
         y2g0/YMZ9vLqc3ToTOQoigDJcCsoeP2eFZ45fBS1+9d6SKoXem1fe1wK8egwn5JFkiwF
         dF9avknM1fym8L8z9RBzMRPd6hA93o97R8MaOWoxe4fDwmb7Sybc4HZXabV7LbzPFJwl
         waHYn9OaIcTJ6M6sJzGM2yN6ygQkzqEgH6Kz1L4Wi3gHTNVW84Ac5h7qlhIkimWHJm6a
         rfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdU0l5q7SwDqyQdrl+AlHir8nP1WSQabvgknUb9WZQA=;
        b=ZD8RKK3xTyi/p9bpKNDm+6mXlCTX4TMHmPh7Sz8C632vehkeIEeNYUwZLdRW+iRrjd
         pDCoeX7UIuVtsNwE8AYTva4411dk35Ed3AXz6A+WKIbquqyzYUtMPrPHAV/j3Ynhf0Le
         2mtrjJ2KqzvPsZzxwmydPEotmUPQqIoMuxAgAxSChp3AYYbMWbHjr1P6zhhPkDiXk4iS
         e9DpT6noCaLH/X5IVaN+w27xmLJ87+lusDKM4YU77p6M/qrJcgUOmmwDOC3MOb5H4wH9
         agaUHegvSxe8xF0F6OEM0PGF7Ormeg1HVAQ2I5P6xEsoIf1edxKz4dGxlhU+bKhbjHtf
         w3tA==
X-Gm-Message-State: ANoB5pk/HI78YywsZ/+WP3ijCKN2UdDB21Omp5H7Rtw8+d+NMmBUYL/N
        l+ehRPydsfX024CzVVATwZI1roFFDOES5OyhUT4=
X-Google-Smtp-Source: AA0mqf41cTZQt7mX79pc94BztKlgzZQTdlTsX/tdXNJlee9HrwI+UJM3HrcOrN0fibaeg24Z9F2mPSAAchtgQNxSgyo=
X-Received: by 2002:a17:902:e890:b0:186:a22a:177e with SMTP id
 w16-20020a170902e89000b00186a22a177emr10371465plg.163.1668357027828; Sun, 13
 Nov 2022 08:30:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac4:88d5:0:b0:589:82eb:58b1 with HTTP; Sun, 13 Nov 2022
 08:30:27 -0800 (PST)
From:   Ved Manish <vedm60013@gmail.com>
Date:   Sun, 13 Nov 2022 17:30:27 +0100
Message-ID: <CAGwWHSRFV11B2SLMzzkTNA8jjt96d_9R6dtQChLzmNMAo3bWZw@mail.gmail.com>
Subject: New message
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Did you receive my mail yesterday?
