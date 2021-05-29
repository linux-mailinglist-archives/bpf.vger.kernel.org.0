Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05D7394D2A
	for <lists+bpf@lfdr.de>; Sat, 29 May 2021 18:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhE2QtP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 29 May 2021 12:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhE2QtP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 29 May 2021 12:49:15 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00B7C061574
        for <bpf@vger.kernel.org>; Sat, 29 May 2021 09:47:38 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id g34so3965598uah.8
        for <bpf@vger.kernel.org>; Sat, 29 May 2021 09:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0VwzA6JPvBPeEZCsi58jfEN29zRlnhjydzgi3Zu7uls=;
        b=n16p+PprpSExCX2AmTllMtsimH1ZCTbzZ6xLL0KB5Q/uWayzRDSWBAMU/aB43DHDTf
         gPhMUKyG5YmSsxtIohS70LrdptrYjIqHIZCeYM3dwchorJBpg5ed0oThW/67EXkEbysj
         RgWG6WKT/1arMtofeEGXaxt5e9IaAii7aB0/Qr7tdGPPNXENybtuNmyKkMGKD4MkwzBU
         v4uasYSDp2xq6GLP45R6zpVASfDakUUzy0+SS1kQN0UZ4P7ojnd4D1CM7Woqc7fdbqHi
         7OS5cNeuqMknnAGwfTPf9+3lSsJJlJcaqqUqPPKVcQDxK3LhjQXjSXQpStmIalsYtOPg
         whPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0VwzA6JPvBPeEZCsi58jfEN29zRlnhjydzgi3Zu7uls=;
        b=cHyWdLnoIiHbV3dGgMkB49VRmJBWH0j+6zyA557aaPY2T59mlYBQiMUvZikyoDiOFR
         ZCRp4psbztxFXBLi98JvxXHYwouLMXj/gTsxIGi4p3Q/autnXjW2QW5J22T1PM+f05o7
         EqGeAMK5ZH8nDk/hS0ThU7pWSiWM+9f6QDToGdKgrzz+lxHQGaI1YwlYhd7P3blyPVuF
         6L7ssMNRxRJpog1KFVDmLTQw7Oefmmqu6BocvZO4lZ5vlAgQy8plri4ZD9IBagV+/hJf
         MMK8c+b1UoywcIpWMsOa5FAyOb1fCpV6y0UYJ8Ur9hU2wL14D6mF6jUGKsRDKFnPyx17
         eGWg==
X-Gm-Message-State: AOAM533OpIaUjlyIOXYUM1azlta/WNzH7swH/2djV4nIcbe/Z4rED7Pf
        xNfl+KqDS4oUxEcJcz7nbzxMgIdXDzvXew58FiZ/lzqi/08=
X-Google-Smtp-Source: ABdhPJwSAQ0k+XyNhIb1NvWdEppmwRNQzouXiOtOOYY6XOkvvVOfTR+heaRJDYGZEXBH6jEI1mgiwzYKKg/6FYbOafU=
X-Received: by 2002:a1f:2703:: with SMTP id n3mr4635426vkn.18.1622306857396;
 Sat, 29 May 2021 09:47:37 -0700 (PDT)
MIME-Version: 1.0
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Sat, 29 May 2021 12:47:26 -0400
Message-ID: <CAO658oV7yTT=8Uv_zipO=EY39B_Ye77XKjzAPcok5Z38B59Fhg@mail.gmail.com>
Subject: Strategy for debugging 'Exceeded stack limit' errors
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all,

I'm trying to reduce stack usage in my bpf program. I moved over to
using `bpf_core_read()` instead of `bpf_probe_read()` and it appears
to have made my program exceed the 512 byte stack limit.

Are there any profiler tools or compiler flags I can use to figure out
what is exactly using up the most memory?

Additionally, does anyone have good examples they can point me to of
storing structures in per_cpu maps or local storage mechanisms?

Thanks so much!
Grant
