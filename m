Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B08F1C7B8B
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 22:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgEFUxC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 16:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728492AbgEFUxB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 May 2020 16:53:01 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82714C061A41
        for <bpf@vger.kernel.org>; Wed,  6 May 2020 13:53:01 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a18so3217814qkl.0
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 13:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CQcbxKSUYsAHBe7Ebehk8JAKNTVPAr/UiGZDOPwaAGc=;
        b=Qc2qN9c83pfJHD8uho1tepgh5pW6tBfZF37n4CM3MD32Y0xOob1XZT1Xv+y3pZ+qx7
         dBB3TftZel2t+tBVFBd8Gmpd8I5YkwQYtydO5Ubo9P4sTrTHbdqfX4CpaxnQmWfWWvgM
         GB0IZxjFVxH21WEMvJry1tpuESxde2u8nQYSHCdadbK+JU0TiFO0kVdGrVkPTvGBJVbo
         hK0NlJTJiZMfi1lUhirdBpVEgN4skITYyCBi0AVgxXzHXTLJ47/oWq3xpYZd9ylfxUj9
         u5EyHrWqrjBvrtX8v6pNmKv7i9YRjxMyZS2xaYfpjkuEcvzXdsdCBIu7GTDszAEDs3cX
         ApSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CQcbxKSUYsAHBe7Ebehk8JAKNTVPAr/UiGZDOPwaAGc=;
        b=aSwjXjyzhEiYAWfjLbg0HgygCsi9T07ltUY6Oyy5yGv/yQCq/cjHR9AE5vkLmetXJI
         CdOciGFqTFr4p3z8bsroQLxs6I/ownS/XAa2vu27MgQ9S6UawkJUtSxmoiBhZYUx71yT
         OnUG6J06hrK6u7DBr9R9lF0tofxCd/ZaeD8Xy44yUAYSNDWlKiuWRpB4Rmj7CsW6/wdQ
         1YtT+IH1bai5l4lz3+O/fXTmVvzCapwWMBAnDLyg3KONTakztBBCZsVeuU4/OqgdZynW
         98L4TpMnc1qST6PpBU5puI1wbp4TvT4S4LbtoOFC4udIfg2gbAHFJ9r585puROxp+qPP
         k32A==
X-Gm-Message-State: AGi0PubqmudWHGwA2BEKZvnnSdrT2PqhaDwzyUB4FASRb+T1pj72dCMN
        iMzPC+ldh2moJQY1b/mN2mwW99RlDZPz
X-Google-Smtp-Source: APiQypIdNrd+yYhBZP4TBZUTUJU1co/gZ+3o6Cxir236qhPBm0psRF02DA8GRECv92XUv8iiH2WZiB7LkvTh
X-Received: by 2002:a0c:fc42:: with SMTP id w2mr9758882qvp.77.1588798380452;
 Wed, 06 May 2020 13:53:00 -0700 (PDT)
Date:   Wed,  6 May 2020 13:52:55 -0700
Message-Id: <20200506205257.8964-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 0/2] lib/bpf hashmap portability and fix
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm experimenting with hashmap in perf for perf events within a metric
expression. In doing this I encountered some issues with lib/bpf
hashmap. Ignoring the perf change, I think these fixes are likely
still worthwhile. Thanks!

Ian Rogers (2):
  lib/bpf hashmap: increase portability
  lib/bpf hashmap: fixes to hashmap__clear

 tools/lib/bpf/hashmap.c | 6 ++++++
 tools/lib/bpf/hashmap.h | 3 +--
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.26.2.526.g744177e7f7-goog

