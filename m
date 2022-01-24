Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F6F499EBD
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 00:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579392AbiAXWnY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 17:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835937AbiAXWhs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jan 2022 17:37:48 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF222C02B872
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 12:59:57 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso242311wmj.0
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 12:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=LelPLFVyiMTpw5yA1vIPFMWw4VOWdiJSPS8F5u+bLEc=;
        b=qRZb3pM+5b2VNWc/AzABp2OqhydpmI2RSTdUgZsB+pKt3vGNMqDrBgXP/MKGbxYyHg
         wWnY5BfxqqcbIUq6wPMF9Wrl3cFRKva373rvxCvgG/CE3dvo9GQkBwHGCDK8CsN8vWpD
         7ThNJfRa6Vr+Tbjs2BXWAheDIeoqp5RiCRk8u1cD2qULgAiilowza9Apg/0qECxnejBa
         Fad6dKu/8fVBAYJjbuNnYB1rOP9vDJdi1naj3nqGx/sHOem74ASUXGbfnLBjY2QkTYNc
         WTA2kK8IEaUhDo+ifHdp9FaYSgg8bYW1d5pV0BY6wa5HAyUByZbm4iPldXhv8wz416yY
         ASyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=LelPLFVyiMTpw5yA1vIPFMWw4VOWdiJSPS8F5u+bLEc=;
        b=BWoxKAfkW8dEX9rk4N+R36YxbS0X7Q5rabjN5h6gTU/AxAfCMb/wen36NdUzxC3Gys
         zKqy4jHqvh0hAlcdTOl2gsmc4ERStDFXwJ/2Hezwv/6XZhTxzm4yko2P6K2Ud5OJFWDf
         V3eE7pLqHnZVTSqxDK240nKPw2OKnTMo0Q85rSsNnNJFg73qbbuoWor8IXZ68A6LgKOL
         IX2bR7kcO9Re31uefcCc7yrXqT5FGJJncmrofWh9pr/iou2A4NSf9aeSztP6ZwmS//t9
         OE576ZBG5pVPq8vGLaIUS5BEgCXMvQRUoFe1l8KUd1p3dEiSdvXERYGbbyAXjN5SlGBv
         cWng==
X-Gm-Message-State: AOAM532QgkkOg6c7CzLCe7FYciLKDhNCO8Q1HTjrxY3JZRt3mdHZxvhr
        0i6tGuVyczeLMv8nZ3JHNO4qiI7G4vq+uEX7NTHN8g==
X-Google-Smtp-Source: ABdhPJzQ2EdezBI/cadxJvyRuRdpwrqFMtyGwYYsP71DbnBy25EekbaOkxmdTf3MKawF+mMAoyzlm2azpJ+IBoCSdG0=
X-Received: by 2002:a05:600c:3503:: with SMTP id h3mr110888wmq.164.1643057996298;
 Mon, 24 Jan 2022 12:59:56 -0800 (PST)
MIME-Version: 1.0
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 24 Jan 2022 12:59:44 -0800
Message-ID: <CA+khW7gh=vO8m-_SVnwWwj7kv+EDeUPcuWFqebf2Zmi9T_oEAQ@mail.gmail.com>
Subject: [Question] How to reliably get BuildIDs from bpf prog
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Blake Jones <blakejones@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Namhyung Kim <namhyung@google.com>,
        Ian Rogers <irogers@google.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dear BPF experts,

I'm working on collecting some kernel performance data using BPF
tracing prog. Our performance profiling team wants to associate the
data with user stack information. One of the requirements is to
reliably get BuildIDs from bpf_get_stackid() and other similar helpers
[1].

As part of an early investigation, we found that there are a couple
issues that make bpf_get_stackid() much less reliable than we'd like
for our use:

1. The first page of many binaries (which contains the ELF headers and
thus the BuildID that we need) is often not in memory. The failure of
find_get_page() (called from build_id_parse()) is higher than we would
want.

2. When anonymous huge pages are used to hold some regions of process
text, build_id_parse() also fails to get a BuildID because
vma->vm_file is NULL.

These two issues are critical blockers for us to use BPF in
production. Can we do better? What do other users do to reliably get
build ids?

Thanks very much,
Hao

[1] https://man7.org/linux/man-pages/man7/bpf-helpers.7.html
