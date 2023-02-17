Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE4C69B1B1
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 18:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBQRUw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 12:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQRUv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 12:20:51 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E9B6FF11
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 09:20:48 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id i10so987042pgm.4
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 09:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prosimo.io; s=google;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbvLQlUFHgCPUPgjcf0DI7lFZGst0e7Dzu3+/RiRdMQ=;
        b=U+y/aNwodNrte7oCNI8QmGxyVFMQV1+JRZ0pQKdJ7l9t7ReYW/GG1u7M6QsiAezsHM
         QuRx/NgPb15sockFgCaBe7XU7nxej0chDfOT5jlAy/3MtNVwazHXW9a336jTQ1zvwqyb
         cLQgpuWhOHW2AyKOZdtfGn+VVqxj4DuZMJVQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbvLQlUFHgCPUPgjcf0DI7lFZGst0e7Dzu3+/RiRdMQ=;
        b=2H7Pi4CIIWfHQ61l7rZJqrPecH/MMeLnMkoeEsehvK5pF9xgUWcBIdfsJLfiOWy8++
         7MFI13Y+8700T3Q4PgxZRKyxBQG/oxtHoeHFdTUSokuwf1Ah9j2HZGyP77MVH1MucW9K
         mgP+FYh1iG0OdHNhkp7BsTftZR173314+I9ZPY8xaU9/m+qnGq5Z0WW+/DgT/VEVkkhB
         2JJV5ydFStVo4Ef/e0LGMyLhgjREbE+Oxb1zNJPqSySIoEQfYd4lQgyPQBDz6Vcd50Uj
         B/XophCz7yfDHX/xHXyeo6XZmEIwyPHFZ66E1sPRcBPN5bWeS3Ire+ahnkParpOMiHnJ
         POog==
X-Gm-Message-State: AO0yUKUtVk59go4tm5BiZWaR9S/97HuH5GTFjYCJpSHLf3TvCwVMnWZu
        DE5oC1EhZImfl06y3LJB3Sgb6C9NnLuyrP0f
X-Google-Smtp-Source: AK7set+uKX8H11l3LQOpC54AZEg3h0dPHtp10Zv59FEz84Xa8ywHbtcYthjB/m81drn1u+AFgjrTzQ==
X-Received: by 2002:a62:1590:0:b0:58d:9791:44bc with SMTP id 138-20020a621590000000b0058d979144bcmr1135043pfv.9.1676654447762;
        Fri, 17 Feb 2023 09:20:47 -0800 (PST)
Received: from smtpclient.apple (c-208-95-237-83.rev.sailinternet.net. [208.95.237.83])
        by smtp.gmail.com with ESMTPSA id c10-20020aa781ca000000b005a909290425sm3425975pfn.172.2023.02.17.09.20.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2023 09:20:47 -0800 (PST)
From:   Howard Chen <howard@prosimo.io>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: [LSF/MM/BPF TOPIC] Multi-cloud networking and troubleshooting with
 eBPF
Message-Id: <A2E950AB-D0CB-4E9E-A017-FE3119AC3DE4@prosimo.io>
Date:   Fri, 17 Feb 2023 09:20:35 -0800
Cc:     bpf@vger.kernel.org
To:     lsf-pc@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We are a multi-cloud networking company that have recently adopted and =
continuing to evolve our product using eBPF. Our eBPF use cases are =
heavy on the networking application, particularly on XDP and TC-BPF. I =
would like to discuss the problems we encountered, the real-world use =
cases and how we use eBPF to solve these challenges.

Thanks,
Howard=
