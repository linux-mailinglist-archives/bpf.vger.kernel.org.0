Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DAE625A75
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 13:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiKKMa3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 07:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiKKMa1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 07:30:27 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E196B398
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 04:30:22 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g24so4153113plq.3
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 04:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffCoKNiZCbLVipbg2otJCA7P5+JqnENgNvxYbkwxONY=;
        b=N+Nr23sjC8iHuDV8sBYjCDxfUaW9xTWufeYgLdv0iQPUZjkB3AuQpFxGzfFHP9Ksg5
         mwSg+0N5bMCiSSH/X4oHtzItCxXD5NgCxhovidkgmSDZdvZX6XoS1s0uKXVf1tU07pcw
         XZl8LzA1q9kn8mQvWNgFTr5hiSR/u/J0hiZhEufA9MMG7Ij2fssvrHolOPZKK3sheZjf
         DuBLkN0sSVYUXcqkEnHdM/XuUJiOoOqQJgsZZVwVIw5NC5+Aw5EK5gxGNyvIi8TV5sf9
         EVfB+MYDaNYV9YIa2Ub6amsZKHd0kGSuPtJrZqckuY13V34Iha2+GnQ7IIDVEzkSYYT4
         P/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffCoKNiZCbLVipbg2otJCA7P5+JqnENgNvxYbkwxONY=;
        b=izeWCFF7Hz75ExO1JMXhV1VIurRPFFcXUg2qXWb37piiMLznvO95BMHsBAe0s53Xgn
         Gd8hH35jDN2D1Zmc4zET0SpB5fZYnxlnL/qJrImVXE16Y6dQzttSpaWZCTsayrondmAK
         DjfuK82x/HqgcFcuN4udgw/zdqSYw7TMyybj3Dvqqr1ddcqcsSNHvvrURbbojCBwQgVM
         a/WIjXS2g9nbu8M88zJq6820hn1VkVhXe4TgnY9jZfNMEqQJTZ3TtLUcNz+TQQZ6oEv/
         UAFEu78SAVWU1p2KJr7V7LC/cSmz3QL5xy2SrGi7U0RFhxLKIRy+62gZESCnZiCgckzb
         afWQ==
X-Gm-Message-State: ANoB5pn8QwjP6EFLc73MD31vY8dqfnIEtUj9mDYtYqu0jDKGwVNdZGTU
        nUWGrCoGzZyaTgEq7FOELSys2j1KWwDVZ9Sz154=
X-Google-Smtp-Source: AA0mqf5C+N7KITTal0uVxMR6CKVzAKplA5WtQGe13CGWVHtVW3eHI2B2g24G6VslNPiaSs5UXctvTzEEE+g1t35404A=
X-Received: by 2002:a17:90a:b286:b0:213:34f7:fb14 with SMTP id
 c6-20020a17090ab28600b0021334f7fb14mr1695901pjr.25.1668169821449; Fri, 11 Nov
 2022 04:30:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:902:e884:b0:187:110d:29fd with HTTP; Fri, 11 Nov 2022
 04:30:21 -0800 (PST)
Reply-To: ecobankauditormanager@yahoo.com
From:   ECO BANK <cw209886@gmail.com>
Date:   Fri, 11 Nov 2022 13:30:21 +0100
Message-ID: <CAByE_KHj=Zig85B_QK84ApzCrC-irLPXdfNkAsmnLcBu1fhdcQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello, please I need to communicate with you,
Can I share words with you?

Steven
