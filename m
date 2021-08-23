Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA073F4954
	for <lists+bpf@lfdr.de>; Mon, 23 Aug 2021 13:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbhHWLFn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Aug 2021 07:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbhHWLFm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Aug 2021 07:05:42 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF32C061575
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 04:05:00 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id n12so25572504edx.8
        for <bpf@vger.kernel.org>; Mon, 23 Aug 2021 04:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MuPTW4ALZWevaRISzXEfBw8BnMU8KijiAITHAhRewoM=;
        b=VhA+NQLVXzJcB1ScLB8u6xP+SAA2dblOpHa5qwaLPocbX5aHj4k3UE4yPrfBTEhj5U
         NuQqiRQNlDYSwJmkyj9kZGoKJ5f/nTilNuqiLUbS6yB/g8nU3gLWlrUax2vq8CGQkx8F
         1L+UieOOSEnIjQBdxVk+gU3La/H+9kkCxyxoD9we78k5qW0vDOj14Snpa2HYNLMp+Txt
         usOw4MkBX9jxZbt0c2vx9m2V81QetFGvMyjHjh2UCorPfFt0DD7XDrOIVHRB+AjeKsQM
         3VdOwn5HI9VGYvyN98wVX2vkoKzu9CV599EbXXlixIqLEorTSlfSMtmKBsXJtrCp5qVg
         RRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MuPTW4ALZWevaRISzXEfBw8BnMU8KijiAITHAhRewoM=;
        b=LKeBhS18YZ3CRGxGcJdgdp8EhZ/Db90mtkKQ1FHurOM0fpHsiNk1puSPVzDhyouke+
         QJiZhnDsDNhhg6b9/TllVH3Ruj+umwAkFge0rWXj7jWbGgwBj64EaTd8vnrSH6fOTvXc
         1idf8V70PWe2IvRyUGxa4LY6eVNqab4S4d1OhmZOnNUvVKJQmnRfmTsZv81EZsxj8xgo
         UdVC4l803VKo3uyw/AeIBcO6TbZU1ORewaSb05GzMqBvce2J91RZ2y7uQJq8FU9/tIv0
         kAOIWDbTkZM3T4igjgwuXohbQQXdWgJ/C9Ff3Lv6s/0FUK4ufUl8bWQYqOYB0vAZ0F+X
         /4fA==
X-Gm-Message-State: AOAM531aPf7HxLIyLvQOg3AWe3MTc3Hd5i16Ahkc/xEK4FTbjAiD98w4
        dfupuvg/lVqDcUoubNPDwv07H/W+O8e44BJyDqdXr/iZMvjQHg==
X-Google-Smtp-Source: ABdhPJyN3IMyEQ58b/WVDyIPWSpYZj7RxwgGuxIq6yWXShU2oOdg/jakQA5H39vwoF46L2tcPwqOnZolN32x8mlGqD8=
X-Received: by 2002:a05:6402:4303:: with SMTP id m3mr37062447edc.379.1629716698607;
 Mon, 23 Aug 2021 04:04:58 -0700 (PDT)
MIME-Version: 1.0
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Mon, 23 Aug 2021 14:05:51 +0300
Message-ID: <CAMy7=ZXTiaX9xzNi5aOavwsf+mziJ=w-EcHH2f=cJmCGr3EPQA@mail.gmail.com>
Subject: libbpf: Kernel error message: Exclusivity flag on, cannot modify
To:     bpf <bpf@vger.kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using the recently added libbpf tc API worked fine for us in v0.4.0.
After updating libbpf and syncing with master branch, we get the
following error:

libbpf: Kernel error message: Exclusivity flag on, cannot modify

I found that commit a1bd8104a9f1c1a5b9cd0f698c886296749a0ce9 is
causing this problem, and removing the NLM_F_EXCL resolves the issue.
Is this the expected behavior and I'm doing something wrong?
