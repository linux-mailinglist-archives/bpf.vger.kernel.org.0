Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B400680445
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 04:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjA3D2s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Jan 2023 22:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3D2s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 Jan 2023 22:28:48 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E4414230
        for <bpf@vger.kernel.org>; Sun, 29 Jan 2023 19:28:47 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id p26so16863526ejx.13
        for <bpf@vger.kernel.org>; Sun, 29 Jan 2023 19:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fbcYImcgPdAI2L9Hs+Zw/DfxUS4eWsPQ3W4OsWG5tPU=;
        b=Ez2484M3S8wGkG9ABzceTUuvNKjfELBsicQQmVwhFHhC1ysCStUB9sd6Li2SzYiBG2
         yXAIspKyxVsI5Rfi/N3uD23B/K9ptpU0UaSFc+gYIchNY/BRrojJLh6iDmxA2V7KsaJ7
         ZmpvbsO71Ba1mgh+c6NPJqxLDN6W+ZZtokimIX1R5gGaops7BrwfEsVlnW8CfnybZIpR
         EZ90KiLHkphrtFyzefVra3PN/Pgq4658N1SY6ZDMQ6dpplow/AIWh66ldDCzoUKcGJ2w
         lvaNKm7645K/aJMB3T89sF5GCNHQzU6rVVcEvJfh0xM2Ac7c63F5PXWiWsmWEjAsqnqL
         BkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbcYImcgPdAI2L9Hs+Zw/DfxUS4eWsPQ3W4OsWG5tPU=;
        b=UEJV9vIOEFnshAFWgfEEcfHzjQL4hUxqZVUSviuVrdwya/YlAvWOedxr5yGbGStKTi
         deKPsaRh3QONGSebNxRz5LuBNguGVcatw0jSXRlCJLZ6kG6mTJ/bBjEaM8XPJDo5KxuE
         RNMtEELbh3GufCjWG4sGefXhyE1e89qnJUSci/qXytiwdlU3QGcVsd8mIdgJNSvq/qhz
         2pvEd4AtO0w6g1AzUh7c9vr35TgwXRKL/YXvkkOi8qHHnTLMzNdpYWABeduqKO4O5+MG
         0Hqm3E7uLYuov20aouPFbJu9KNPVntkRzRfnm9eUL66c8N4A/Y/e+G/5/uKB/pOZpAEk
         17Ig==
X-Gm-Message-State: AFqh2koJmbrQf8yDHYUfGp5w7V880G/lz3179JHITRTR29o1+AnAD1H6
        VgaacbjbgNHnl+8Kaisx3LHMoSPvykeNJ/WdSdGVrDvY
X-Google-Smtp-Source: AMrXdXvPeOE3kcACfOVhy+EyD6gcfpHbCPfoxkGRHHeaTtLYmh7IRxvffKe1rpaP+79aHQTtB4Ot11ZPZURyoNgJdC8=
X-Received: by 2002:a17:906:7ac2:b0:86e:429b:6a20 with SMTP id
 k2-20020a1709067ac200b0086e429b6a20mr7116704ejo.247.1675049325323; Sun, 29
 Jan 2023 19:28:45 -0800 (PST)
MIME-Version: 1.0
References: <20230129190501.1624747-1-iii@linux.ibm.com>
In-Reply-To: <20230129190501.1624747-1-iii@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 29 Jan 2023 19:28:34 -0800
Message-ID: <CAADnVQL4Kmk-Hz5XB_AiVC+xVBhVvBqBZTTtedAJC5op2xGD6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/8] Support bpf trampoline for s390x
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 29, 2023 at 11:05 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> v2: https://lore.kernel.org/bpf/20230128000650.1516334-1-iii@linux.ibm.com/#t
> v2 -> v3:
> - Make __arch_prepare_bpf_trampoline static.
>   (Reported-by: kernel test robot <lkp@intel.com>)
> - Support both old- and new- style map definitions in sk_assign. (Alexei)
> - Trim DENYLIST.s390x. (Alexei)
> - Adjust s390x vmlinux path in vmtest.sh.
> - Drop merged fixes.

It looks great. Applied.

Sadly clang repo is unreliable today. I've kicked BPF CI multiple times,
but it didn't manage to fetch the clang. Pushed anyway.
Pls watch for BPF CI failures in future runs.
