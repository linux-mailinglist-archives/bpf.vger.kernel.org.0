Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F765FA8BF
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 01:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiJJX6P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 19:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJJX6O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 19:58:14 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9148A7FE75
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 16:58:13 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id nn14-20020a17090b38ce00b0020acfa1403bso107793pjb.1
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 16:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=32G3k93Ulqw+bBT8wloqCvMkNp9uoyXmylHiGN2Ypxc=;
        b=LcWt5IjwCcy3rAad+wx5DSEJeu4bbnR1UwRvydSMhWPJLCVVIhiV3sdwaiTUIjBUbt
         AwITg2e81qFFFEtOCWDrKdow2ER0lA/l4S/JNM2JP+v0ZWrdG39lvd8rPH1dfn6TZQQu
         76My+esp98qhz7FQrF8bxlLcyRAHtUNelF+oJHIqMQ7/1JlULihRngFRjGq+CsdrC7JL
         pyc2BCkq7cxAxQCd3YlkgYqYXYOKvydwutn/bGtBWCJYKOCmNo8ywgrQenJoHqDDJrLW
         ciqwgnPm2h+kpnsB/B33ihE6QHIppIccsEQAkr1f8JnZ/6aJ28iETmFw9Ei0RjxuUfiF
         e5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=32G3k93Ulqw+bBT8wloqCvMkNp9uoyXmylHiGN2Ypxc=;
        b=HlXEuUJRzOrQMWVuWVUc+gSUWn9Ji1p6uCd7rvY2F0sVnLLub7PGNgTLbV7epJ4NkL
         NMIGSngUfPzdwavNAhCVlipwkTuDkizuabd7DCDnMgCzN3mo/1JAQpGOVWEwXctVPw7W
         Ud1GrZWI7129nVWbKDjZMZtnJ7CpM7aWEMy1CZqUOSp5ah0e9231H6nov7a6x1hk95gT
         WkqNk5dq9QHQGxpf0lHX3NhMku3+C7lDwY4QMTGf1Dk5PyUqxSsfgIE70Uu2ij2PPFp8
         pNJs3ttH2VoahLDZL3+i/XUYnEdAT35SDgs3V1N62nHVFTfpIKsIvNBb+SnIH2sOAVtS
         UR7A==
X-Gm-Message-State: ACrzQf2S50NRSjIZ4PQtFKo+M9haUMyU97x+tW/ARgucdkFC4j7WuWj1
        ugb8ucmgRqa4WdHtSIm3DlF4GYpsLDET5BGi
X-Google-Smtp-Source: AMsMyM6Jw40l0u70IlwQVdch68V4JzwL6jSidvy3rtHMdUOo0co1MMkUBYniXw4/pl9AI7Fy/6+g0Wd38ANIIk53
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:cd06:b0:203:ae0e:6a21 with SMTP
 id d6-20020a17090acd0600b00203ae0e6a21mr1888481pju.0.1665446292568; Mon, 10
 Oct 2022 16:58:12 -0700 (PDT)
Date:   Mon, 10 Oct 2022 23:58:02 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221010235802.3378436-1-yosryahmed@google.com>
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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

