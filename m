Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498575FA8C7
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 01:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiJJX6z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 19:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiJJX6x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 19:58:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E003F7FE7F
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 16:58:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p5-20020a25bd45000000b006beafa0d110so11954734ybm.1
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 16:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=32G3k93Ulqw+bBT8wloqCvMkNp9uoyXmylHiGN2Ypxc=;
        b=oBamiBMlwevwaWtK9/MK/DT9KKivXxO2BxJN593yqX6pYjoGISML+X3eegUtf6A2M5
         4iA2KIkdw4Sa2t3eOKZT3OrwBQCo8yzMbPa7sEEiMxRHAUJzqmE8fikOru5PvKc3xLKp
         7pBhjHTEQuE239jf1M8tJM2axFb+arNmTjtVlvz9nWLtrXVa2bgjE1lgBqheC+oaMxPV
         buJwf/w9KTYkdmjq4x2mUZ67/K32gzGzfrn+c8T3b3ekZOISsbXD9cufr41n2pvvZnd4
         2U5PTZALuINUVBwjM1H5EV2MwG9mT5ARQpFgxKTCSTKgM98LAeeMrpsjT5iMKRDZqt+F
         TL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=32G3k93Ulqw+bBT8wloqCvMkNp9uoyXmylHiGN2Ypxc=;
        b=6QLizKIZNvFMBXMfZOAmp4fyBkuyONkQu02mJgcpeY0mheCWNKMBXulYty8u38IIoB
         A5yuKlrvSnd+mgoUDI75XdK9RV7rZltMMiyBUhlpfd0SmF/fzcBnTNh1tGV/wfDFX3gh
         II1NEAUihUFx5WAW8vWThegxRU4IAzEj4zJUESqgadTQ2xlpDqNh72PSrQLPguEYGfmi
         Dytdo+LNhFlUnv43yGszsqlWMzv8cMZwPStM6ZtdeXGPriwok+zoUJADrKUBSzkqLsOx
         d/exSFCXVjyAYiVPfqEoqz7pbmlTUXdFzRlOBrNX8Xofx5yuaUMKoNnXnf4MQdsYUBsC
         WUAg==
X-Gm-Message-State: ACrzQf2FlEpgiQXs5wJuO5h4ebiJjFD2ZksVtoHTTvcUfSt4ra041vky
        pDFoQq4JaDKbqbtK+E5MHoQBH0IGdIkj9YrV
X-Google-Smtp-Source: AMsMyM5DVXg5sRb4xhrP+EF/t+N8fSesDoGkVZhdZwcIM0i//2doFKVpIAnhQz1pvBQYkekxL/PBBffZP3lfkxTd
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a0d:ce05:0:b0:345:5ea7:22fa with SMTP
 id q5-20020a0dce05000000b003455ea722famr19246450ywd.279.1665446332163; Mon,
 10 Oct 2022 16:58:52 -0700 (PDT)
Date:   Mon, 10 Oct 2022 23:58:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221010235845.3379019-1-yosryahmed@google.com>
Subject: [PATCH v1 0/3] Fix cgroup1 support in get from fd/file interfaces
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

commit f3a2aebdd6fb ("cgroup: enable cgroup_get_from_file() on cgroup1")
enabled using cgroup_get_from_file() and cgroup_get_from_fd() on
cgroup1, to enable bpf cgroup_iter to attach to cgroup1.

Apparently, other callers depended on these functions only supporting
cgroup2. Revert f3a2aebdd6 and add new separate interfaces that support
both cgroup1 and cgroup2.

Yosry Ahmed (3):
  Revert "cgroup: enable cgroup_get_from_file() on cgroup1"
  cgroup: add cgroup_all_get_from_[fd/file]()
  bpf: cgroup_iter: support cgroup1 using cgroup fd

 include/linux/cgroup.h   |  1 +
 kernel/bpf/cgroup_iter.c |  2 +-
 kernel/cgroup/cgroup.c   | 55 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 51 insertions(+), 7 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog

