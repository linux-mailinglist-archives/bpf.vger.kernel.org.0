Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5A75A1B3D
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 23:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243876AbiHYVjO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 17:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243890AbiHYVjM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 17:39:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71D0C2294
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 14:39:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33dbfb6d2a3so41831927b3.11
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 14:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc;
        bh=lM7WG9YzqdGMor8dcuiLn6myEZpNs7q19yn84bxvLf0=;
        b=JX+2d/oVQ5mPFVnP0apDqLoeBdHr99X3oV7Oma7L9JPklapt4ivvxn2Gr/DER4dh3e
         Hoh3zdjQ/XFMOIPuNcla974UM/dYGFbbtJMvpEn6qA7n/uiRjub4L38C5+YPTsvYhm2K
         Bs95hhPHzn1IdacEVFCEQ2ubIQ+h6lhLRTVca9JG3rBhxsPGw1S6W5te/rizJEuuoGuU
         eRBdSH9Gi9oS8DgrS+rIaIpih5Qzy0ZvnVgg2ORSZFjjUmivX8EyNg+0rCzt2RIX49rF
         NoE0Gpcrhdem75wKsWo7VzG6bbjTtknQ+v8i08Ku8d6O5y/LUg/W6j3QG0EUgkWGZhWN
         e37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc;
        bh=lM7WG9YzqdGMor8dcuiLn6myEZpNs7q19yn84bxvLf0=;
        b=SxSh/WuuLdi1OAHjXEqRTyJNB7xUWbbjzzPNlGdqiktwr1wNJtZo9CdhwVD+NNiCGG
         smd3LMlSfksaYnJNotu1y+WQHPNCn3EjrTCqMEIoX49CqtkMS9cK1fmJeO/pfHx0xtQb
         cZHaAJwPWHJrBQRxN18RzEKhmqWM3YL2f+fMhZu/QaLW5X4vItVg+5yYNy8CHB9S/R/d
         2LKUjXdDdOAdB4udLR4AM0lyAwh5qkNETP2wemU/sG+4B6FlW4FbN65AmZnucExwiSHM
         chIdVJKaEhcun8rIbLwM7PW9c5xBQlJvilHSxl/lJ6JVlUrFHsq4pwdJ1+CDpQj11eYj
         aRLQ==
X-Gm-Message-State: ACgBeo119cEv/PSeFPW6h1DD7lxVyFbF5e5Pv3YJUKL3Ao5hZuUSLbUp
        K08MVhpM7uq9mgXtvkIRt/DYBtuCsZ8=
X-Google-Smtp-Source: AA6agR7x138fgpCkoVUmt6DrNUUVI2tvfykUhrAY9z9BQ+qRShblMVzFS3t2I0dDI9TMZhhjaQ/aGWu5cIA=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2d4:203:2c4f:653f:78b3:2b5b])
 (user=haoluo job=sendgmr) by 2002:a0d:e6cc:0:b0:338:c82b:9520 with SMTP id
 p195-20020a0de6cc000000b00338c82b9520mr6044145ywe.66.1661463549945; Thu, 25
 Aug 2022 14:39:09 -0700 (PDT)
Date:   Thu, 25 Aug 2022 14:39:03 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220825213905.1817722-1-haoluo@google.com>
Subject: [PATCH bpf-next 0/2] Add CGROUP prefix to cgroup_iter_order
From:   Hao Luo <haoluo@google.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As suggested by Andrii, add 'CGROUP' to cgroup_iter_order. This fix is
divided into two patches. Patch 1/2 fixes the commit that introduced
cgroup_iter. Patch 2/2 fixes the selftest that uses the
cgroup_iter_order. This is because the selftest was introduced in a
different commit. I tested this patchset via the following command:

  test_progs -t cgroup,iter,btf_dump

Hao Luo (2):
  bpf: Add CGROUP to cgroup_iter order
  selftests/bpf: Fix test that uses cgroup_iter order

 include/uapi/linux/bpf.h                      | 10 +++---
 kernel/bpf/cgroup_iter.c                      | 32 +++++++++----------
 tools/include/uapi/linux/bpf.h                | 10 +++---
 .../selftests/bpf/prog_tests/btf_dump.c       |  2 +-
 .../prog_tests/cgroup_hierarchical_stats.c    |  2 +-
 .../selftests/bpf/prog_tests/cgroup_iter.c    | 10 +++---
 6 files changed, 33 insertions(+), 33 deletions(-)

-- 
2.37.2.672.g94769d06f0-goog

