Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D001639D02
	for <lists+bpf@lfdr.de>; Sun, 27 Nov 2022 21:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiK0Uuc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Nov 2022 15:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiK0UuR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Nov 2022 15:50:17 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B0AF036
        for <bpf@vger.kernel.org>; Sun, 27 Nov 2022 12:50:07 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id r12so14611190lfp.1
        for <bpf@vger.kernel.org>; Sun, 27 Nov 2022 12:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=biw1utCmNyI+ef9futimPqL2qrgw3YwY9eWMD1oBQZg=;
        b=D878ZMGpsmQicXfhiP52yL8UQ1plMhc/+XlpY77KnUEYE2x0hczJoFLlK5KDSdrgpS
         rxmmlPCu0xb+83VgnWvYTENVHO1Vne+0vzJM1VnRSSXjs3TCLV/OV6ZcBq3bhQmfULrk
         tdEYXOUk8GeyfJWtYS+MV2PhdOiIu7/W4IBAwJMO8mdZMaWdA9TjoAzcvpGWvmN7KUrw
         szfXfrMK5hhrndzrWVckUwpiz5LFjQlJpQqB41ZDOWoTXIkn/QAlwoeg14EYaq3JfrgA
         Wp4iqQDFaJFKQ+pWKq0kQYB5sz86hdGoXU8BLgrE9KaOaM1e+BohqeojyS2HvraUs1iM
         ZAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=biw1utCmNyI+ef9futimPqL2qrgw3YwY9eWMD1oBQZg=;
        b=umsMZVbz8l1xu4BzzrReCMzp2ZRAzzctHYcvF/8Yc4iP9PwjySGlF1RtaiBGxn77RA
         FIYvaLYGRBxj6duBNgVWRwR0zQjTsXgzP0c5xCCiz0gN5paWuos+67cYsPbA6pOi8cBG
         y8oT57UyQLIyxrlKiflEWDBmWn77jtLuEfvI8ydsqxqHVUPhITqo3r2dEK2nzVP4RgCi
         oRH7bNDMyrSPFiS5t+pxAef2TY+Hp7liKQoQTsXfbPi9W5B6SY8FQeVijTktAcUKouTz
         eNZUSNxxkzcuMMp+oQMlr0sruFZPGKNjllMdo82yiX6MCiutMLiJNrN84qmQAYh62D3g
         +t/g==
X-Gm-Message-State: ANoB5pnH93WIwq7J0HSqOTdH+Snu2jE/KP6lCORsn8/0Vu9ymWrsK5g6
        jEasCevM2gxxcpeFjkgLtYEZ0Y3xO9f9e7B2TZshbyTNzdZyvA==
X-Google-Smtp-Source: AA0mqf5rf8gD1mkvdGQyyig6eMEG9zKg+FP6icU/W2itmfM/z/HIowcDJG+OMsOHld8eNi3bIVRmjJdHuHfnFl/eqIM=
X-Received: by 2002:a05:6512:3413:b0:4aa:b3d1:9c83 with SMTP id
 i19-20020a056512341300b004aab3d19c83mr9948799lfr.260.1669582205601; Sun, 27
 Nov 2022 12:50:05 -0800 (PST)
Received: from 332509754669 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 27 Nov 2022 12:50:05 -0800
From:   RICHARD EDWARD <richardeddward@gmail.com>
Mime-Version: 1.0
Date:   Sun, 27 Nov 2022 12:50:05 -0800
Message-ID: <CAGpQqipTrqaXdt9p1BZeN7ugcfQ=j+g311of6pP8iQF-Yup79A@mail.gmail.com>
Subject: HARD HAT
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To whom it may concern,
I would like to order HARD HAT . I would be glad if you could email me
back with the types and pricing you carry at the moment .

Regards ,
Mr HAROLD COOPER
PH: 813 750 7707
