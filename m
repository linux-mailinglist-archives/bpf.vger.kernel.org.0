Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FED685C2D
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 01:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBAAcN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 19:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjBAAcM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 19:32:12 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1ED53B19
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 16:32:11 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id z14so881885pgs.10
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 16:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5f7Vo+JFAerdiMoOwREJwZlbAlqNzBMzi2DNbGEP4U=;
        b=U0+ZvzzNXdeZextUhPadYgDrpO4W5eUindYTmfbOtFb/MB7uezSa2lOSKlwM+y4lul
         kvzdJfw9hqTpKPgcRbAw9S6cYUTPCaCGj0aK4fahnPnEU7tceoUQyR0tnnynCbh1u2S2
         ew9ZcSbPLFuIW621yqx5+6WnYn/eBkxU9qfORKrtmPs7bHrMG6odZQZRt2ABgg60bdqp
         42weBOgBAdv6oyLjt7ubhi1juXUr11i3ALSioYKUeiwS5Sze2CZUvfpIa3qvwozf/yUh
         ROuC5O2VrtT6Tym4WlebSTh4H/taXKHz5WeOPb5OjJf4XHT3Vt+Ef0ZhsE++tAfuOclV
         3vOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5f7Vo+JFAerdiMoOwREJwZlbAlqNzBMzi2DNbGEP4U=;
        b=GSv/YOBuVXLkH3aSb6bLhKTYsTCKYRgAT7T2X/HsODFf59WCJTyVXJnYaGyz/f4WG6
         wQJU0aGoVwodQBfFccg4rBahOxaiMxLmJrGf0XjfynMN+evElI4sUgqGgEj8qr0vpaqO
         kb4nm+XrAkfsbPneEIPYp81cmMmTlMFC82zstfqv6Xvpu2585NMLkj4e0DY6XnOeHgWF
         1u6Ui4m331qpALyMvAO0KFqsjZxwids844iAKmX0vrxDPa9HJjyobdaPybmSvejSUeqQ
         gERSWBVy/dFx9h1JElVVr9Ieu8imWAGKWJ9r1zLi7UTJxyB/pS0hbDxZEoIrViBQtUZf
         05Dg==
X-Gm-Message-State: AO0yUKV3ah4WuttARfqWzKChlLnpcXLi4Jfbkx0dHaYdSDF08jZcdbFT
        QkBF8IF/hCqjrmJEuWIYqDGqiRZyJGpRqoTZ5do=
X-Google-Smtp-Source: AK7set/MkCOVgME1SgpmQ5+eM5cqZV26P8FYKlKZdjPGlfFHE2g1SuM75RxrR/opFkl6tja5URtAUDVzUxyM4bQ+wJY=
X-Received: by 2002:a05:6a00:1490:b0:593:8deb:820c with SMTP id
 v16-20020a056a00149000b005938deb820cmr96156pfu.2.1675211531313; Tue, 31 Jan
 2023 16:32:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7022:120:b0:5d:6cc7:156 with HTTP; Tue, 31 Jan 2023
 16:32:10 -0800 (PST)
Reply-To: cynthiaaa199@gmail.com
From:   Cynthia Lop <maxwell1973david@gmail.com>
Date:   Wed, 1 Feb 2023 00:32:10 +0000
Message-ID: <CAD6kYWEw4B75Mk=g_+eJ+p2Sc4+x0VpsfoQnCkBWs_4hG75ezg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
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
