Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705DE2DB601
	for <lists+bpf@lfdr.de>; Tue, 15 Dec 2020 22:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgLOVqk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Dec 2020 16:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731189AbgLOVpc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Dec 2020 16:45:32 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365A9C0613D6
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 13:44:52 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id t22so5897700pfl.3
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 13:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wTQdPJzV3XdD7lQ+gMDjSLMczu9h6s0ap9Smv/VvOrI=;
        b=jHjZjlkzd4OcRpREUtMX7FhZH6xp55lfNHL68D9fPKZZiH3J1pZJTbD7rfFq3704gh
         AMqPKBJmzMKE0AoiNCJe1Yq5z32aKCugM7yUzsewbVyEe+YpMdKOCdL+64x/vvuyDJsN
         UqayJ4z5OGV9hoMacGge9eTqXzngYXvtEWkD71U13RoSe4XdVe9UJOnDNZIOF2H7V6Di
         9T6zmBsyaHwqXayOiAwuASiH9xNyVD4GMxT6XUdTnkBWyYG0sQtYrJKq+WQa7yHlGHSN
         hr8+wSzx5tVNWFJl6rveMI0F+MsTeW18i/gxXZ9pTw1Iv91d/7GiVAqwCTRaJoeexwAT
         vhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wTQdPJzV3XdD7lQ+gMDjSLMczu9h6s0ap9Smv/VvOrI=;
        b=Qmdwetyy0qQSdvvS0enOzYR0kEs/wMXbQW6Z3IsE4Ydj1kfjUI/rAFy7lZgj3azwdG
         Wht0MAjfJlKhrheYMlsL8tjA/I8UuYD5PfYaSe1lStuk/tvL2HzTiNOxow+jFnJaPzO0
         uUxRc0Kj5j2TADLJlBMzqyAe38L+m7oint8UK1PyK5Aal6l2cvEbOqUeQKqc5e8+BYwl
         eadovg/rUEl9YMJsqQSstrc2qdMkX2QsePER0FT/MfoMWLC1HyBBQzy/H0qa9QnoDDgW
         yeRWm7XFSw0a3Qp+R44++YSdXqtpxb6qFGSMCHwDEIEaDmRUeQQfZ2YkzCNd3G+YzljD
         y+RA==
X-Gm-Message-State: AOAM530YQWDNizak8lCIFP7t3M9DIMY+pEBXdLhWmTDHbZ6hlSALZaIM
        qf6hwQ4ELAzCGRhzpzcPGPAYbKqyUxaegY5VO6Q772XGWmFpfQ==
X-Google-Smtp-Source: ABdhPJzzQ/IZRMW6GcgufpiPgUM4oH30+TIrGc8tsVeSgkFjVXUy56bQjNYN1dLYBpuLHcVpfmth4Kh1gsZ+GLCI4lU=
X-Received: by 2002:a63:2265:: with SMTP id t37mr17426094pgm.336.1608068690519;
 Tue, 15 Dec 2020 13:44:50 -0800 (PST)
MIME-Version: 1.0
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 15 Dec 2020 13:44:39 -0800
Message-ID: <CAM_iQpUJsv7sO+AeuxnFWNcaBQT8-8X+Ptixjis9G_8SLF1F=g@mail.gmail.com>
Subject: Why n_buckets is at least max_entries?
To:     bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

Any reason why we allocate at least max_entries of buckets of a hash map?

 466
 467         /* hash table size must be power of 2 */
 468         htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);

This looks very odd to me, as I never see any other hash table
implementation like this. I _guess_ we try to make it a perfect hash?
But in reality no hash is perfect, so it is impossible to have no
conflicts, that is, there is almost always a bucket that has multiple
elements.

Or is it because other special maps (LRU?) require this? I can not
immediately see it from htab_map_alloc().

Thanks!
