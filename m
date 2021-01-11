Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A2C2F1E1E
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 19:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbhAKSem (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 13:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbhAKSem (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jan 2021 13:34:42 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2706C06179F
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 10:34:01 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id g20so1114060ejb.1
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 10:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=OZdR0KKEThMsFvKP7tD2X2q9k/zKZiRS1Wn8/wP3boA=;
        b=MbdxW+3WdHdapP+tJTy+Jm2I3pc83GIDSkuxVcAB5pADbimrf8vfwcFx4/hpWMj5n9
         WDFXyKSWvZDWGBeQGbM6LGnU/YOwsx/zYublserxG5y9Gril5dpYvy42JsXGxRog6orT
         XLbtvzz10jFWth0zlZkiSQJl33ZrMAXa+f9uhNMn/TwTcP0Q2pWL+Q5q9lvgkzPJ+1xp
         Q19n0xXqDrYJm7LbV2OQDvmor/jo8EMketOZlZ+hMhj3twzFNg7ykdEx/+G7jxE9BmJE
         XMN3sIiCzdh07Rddrsonrv2AdLrHLokem0kkwoCQ1Y22efAc4xJWsWveVNv/FU172ssP
         HFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OZdR0KKEThMsFvKP7tD2X2q9k/zKZiRS1Wn8/wP3boA=;
        b=N9XlTHzjArcuA9SD25cMtSC3NZztCVLinxGW9aY6Fe+Ooyrz0EC+1XNoQs9pl8ZzEF
         3Oo0uL7NIGJTOSe4CWKvShLvltFram4zC9zkJDNALXDOu3l5wf3dESV1oYI2DNw9mOCh
         v9F5FxLMmkVwrjB+NBgXlWcmg+R2WDBPUJxhkpMDml8yk/Y12nnV8JmsnK2JpTdY02M4
         06vkbBbaFNWWvePKAqSzq0DPbPQQII20x0IxY/7exQHjetOQxbDX/YobURrIT0Dk05KL
         XuvcqMY6Ekn4wxIXPzYVA4x7S/XOMzI/SNLe6NR+Wf4z+OsceSlBNDz2HogELmglfoXO
         pM0Q==
X-Gm-Message-State: AOAM53282CCAFS57Gd4WGv7PRlvsePN5UrK+0aO6wGMb0n/4fKrG4TZM
        D10YLP/n0fy0cycRJrP7InrGej/rfsMLRROkr2dhHa3/e4w7LA==
X-Google-Smtp-Source: ABdhPJxkuVH96VfuPkAaSO0bH5pufB92AXiGWuPgn1+XkouHh8SuHg16TReh9qy0En0Nxi/38V3OHspO1RTe10xnysA=
X-Received: by 2002:a17:906:402:: with SMTP id d2mr530524eja.35.1610390040137;
 Mon, 11 Jan 2021 10:34:00 -0800 (PST)
MIME-Version: 1.0
From:   Konstantinos Kaffes <kkaffes@gmail.com>
Date:   Mon, 11 Jan 2021 10:33:49 -0800
Message-ID: <CAHAzn3rz5ZH25-53+ijGXhzoV2DqiOhEtV==V2k2R72AwpGAdA@mail.gmail.com>
Subject: [QUESTION] TCP connected socket selection
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi everyone,

It is the first time I am posting to a kernel mailing list so please
let me know if this question needs to be directed elsewhere.

I have been using BPF to programmatically steer UDP datagrams to
sockets using the "sk_reuseport" hook.

Similarly, I would like to identify request boundaries within a TCP
stream/connection and programmably forward requests to different
sockets *after* a connection is established. Is there a way to do that
in the kernel using BPF?

Thank you in advance,
Kostis
