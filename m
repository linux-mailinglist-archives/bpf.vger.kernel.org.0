Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93E931A6A2
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 22:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhBLVQ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 16:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhBLVQ5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 16:16:57 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699FAC061574
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 13:16:17 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id p6so735420pgj.11
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 13:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=VOh44KJfmTHWItSbZ6YbzEnX757pkGjSv9K+QdsDUFA=;
        b=mM46KnR9UD21nsGulWfi58bH2LSH4d7JEw5d7IzN45GZNtkvLhfb1G7qsjJyQ/HXcf
         CF0atURZNU+WsBH79QVlzMq9F+AFEZW2AmPEOKwiNqLudegkift5o7BkPvStozMFagQ9
         /vu7hr4lYx3nuJfzuL3/TRIaXeaYcDBb/b1jQkOU9rYb5vbVyEW+kkDequJGiTrgv8AQ
         7C60tn28Zw9hEwRczuJ43gUUvcpjsh+D7RTqBX89RLx5leSJf5hlH/0+qeH+cSthMC8x
         oeL+jCP18Ovu5w36gzyGYKTsDolkgTgMAhR+cLMfbDjcc3vniMeMeFkHXzKHa6BDw0F/
         Lzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=VOh44KJfmTHWItSbZ6YbzEnX757pkGjSv9K+QdsDUFA=;
        b=k+gzcmtQ8HXGo33pp4AtQYQq313iS8CG6wfR+Bi67u9S/opTYqSpuiftBzc4SnYKsH
         M8cLeswI80FGUl6uwM/k/rQ0QBlLkMdyzVDQFdUUtkfw651pidfR5VSywfpwidU5JUHE
         3oBOCQnbzp3A+1ZbN+fypZQ07KqrQCTkTFaqNO0cc9o6typSv+HrBeWTwwbWI4dE+S+F
         29nFFMZhhJfUZdTElCw0NQUG9hUa+8ti7HWNRlb/9gjyOazWewhhORklsVisknq2Ujiu
         TgIKBlsDCOU5esLPqc74w7ajKnrlLhOMjhKO//emSlGrMjxYXoTrwFqgMyDnOykBx0LW
         WlDQ==
X-Gm-Message-State: AOAM533p+aZYTw7Dc2fy5RINGnC0CvLSfqWaZXLAI4s5xZlCOE4vE+Gw
        mUBiJVix5ZLrzoJn0q6fvLiALHfa
X-Google-Smtp-Source: ABdhPJwjFBYm/SrzWjwdf6KOoyXlDHdExT6QOvlY2l8WLg5cuOgmZ537ZIZ2yxUAmoQWxerAdxvY/ER9eA==
Sender: "morbo via sendgmr" <morbo@fawn.svl.corp.google.com>
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:ed1b:1611:4b90:c2e9])
 (user=morbo job=sendgmr) by 2002:a17:902:7d8c:b029:e3:1bd0:b20d with SMTP id
 a12-20020a1709027d8cb02900e31bd0b20dmr4462551plm.63.1613164576881; Fri, 12
 Feb 2021 13:16:16 -0800 (PST)
Date:   Fri, 12 Feb 2021 13:16:06 -0800
Message-Id: <20210212211607.2890660-1-morbo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [RFC 0/1] Combining CUs into a single hash table
From:   Bill Wendling <morbo@google.com>
To:     dwarves@vger.kernel.org, bpf@vger.kernel.org
Cc:     arnaldo.melo@gmail.com, Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey gang,

I would like your feedback on this patch.

This patch creates one hash table that all CUs share. The impetus for this
patch is to support clang's LTO (Link-Time Optimizations). Currently, pahole
can't handle the DWARF data that clang produces, because the CUs may refer to
tags in other CUs (all of the code having been squozen together).

One solution I found is to process the CUs in two steps:

  1. add the CUs into a single hash table, and
  2. perform the recoding and finalization steps in a a separate step.

The issue I'm facing with this patch is that it balloons the runtime from
~11.11s to ~14.27s. It looks like the underlying cause is that some (but not
all) hash buckets have thousands of entries each. I've bumped up the
HASHTAGS__BITS from 15 to 16, which helped a little. Bumping it up to 17 or
above causes a failure.

A couple of things I thought of may help. We could increase the number of
buckets, which would help with distribution. As I mentioned though, that seemed
to cause a failure. Another option is to store the bucket entries in a
non-list, e.g. binary search tree.

I wanted to get your opinions before I trod down one of these roads.

Share and enjoy!
-bw

Bill Wendling (1):
  dwarf_loader: have all CUs use a single hash table

 dwarf_loader.c | 45 +++++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

-- 
2.30.0.478.g8a0d178c01-goog

