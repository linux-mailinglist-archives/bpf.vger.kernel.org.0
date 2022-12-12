Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D3564ABCE
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 00:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiLLXwO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 18:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiLLXwO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 18:52:14 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC773AF
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 15:52:13 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id a16so10495385qtw.10
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 15:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qipOPsspidMxqoo4oBDYgeBgzcLXxHtxJQXaWmeGNjg=;
        b=4oCqnjivDfsr+3g1K3qnHBmJNaLG+FpNHIvoKBop5DjzY/wcxXrgbmmj138x0o3Pqc
         cWSdPtTp0pIigo+zGSqhdesl9caMWlMsf5BCYakyrB5ABq6TWEWQ/O+1DzU7KPmJ4qw+
         GLRBO00YCX6EdZtHDG5FdVHj+GcnpRvlDpJNdkQBRxPYugP1py+3vzwAcyTBQAIUET7l
         HUKsUgfgcnRuBQqihDAd/gfK6PDgU+Uu9MXHnM88rpOWcGOmg4rb6+ZnG1X/k3XwpsWX
         LxeHecG20gF6JFxfw0kBhM5REgbzgKfeSeM4Y7ZGwEuVRARARQt3OiyMlNv0shp3ukC5
         Vfig==
X-Gm-Message-State: ANoB5pn3GTIJu4Jkw8gRkZKsD8rVUQshJgDU3vHnHl4htE1+0tv93YhV
        QHtJvUYZFesn/jznVwwBtZk=
X-Google-Smtp-Source: AA0mqf4Wp4XQTmHb2uDmp+hxS/HsJMf+1tLsS6USDt/JjjnwBP/kexha3QbPXHM2Dm8Jgi9OPtjblQ==
X-Received: by 2002:ac8:6b4f:0:b0:3a8:270:c0b8 with SMTP id x15-20020ac86b4f000000b003a80270c0b8mr1577393qts.15.1670889132157;
        Mon, 12 Dec 2022 15:52:12 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:6a51])
        by smtp.gmail.com with ESMTPSA id r18-20020a05620a299200b006fed2788751sm6895425qkp.76.2022.12.12.15.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 15:52:11 -0800 (PST)
Date:   Mon, 12 Dec 2022 17:52:10 -0600
From:   David Vernet <void@manifault.com>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Subject: Re: [linux-next:master 7935/14039] progs/task_kfunc_failure.c:76:36:
 error: no member named 'last_wakee' in 'struct task_struct'
Message-ID: <Y5e+qj8M3LZafhGK@maniforge.lan>
References: <202212130502.iuVFgkdf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212130502.iuVFgkdf-lkp@intel.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 13, 2022 at 05:35:01AM +0800, kernel test robot wrote:
> Hi David,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   f925116b24c0c42dc6d5ab5111c55fd7f74e8dc7
> commit: fe147956fca4604b920e6be652abc9bea8ce8952 [7935/14039] bpf/selftests: Add selftests for new task kfuncs
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce:
>         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=fe147956fca4604b920e6be652abc9bea8ce8952
>         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>         git fetch --no-tags linux-next master
>         git checkout fe147956fca4604b920e6be652abc9bea8ce8952
>         make O=/tmp/kselftest headers
>         make O=/tmp/kselftest -C tools/testing/selftests
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>

Ah, task->last_wakee isn't defined on UP builds, my mistake. This patch
fixes the issue. I'll send the patch to the bpf list in a separate
email.

From 80ec7fa20b0beb1b047bfc66b49b0910c578da83 Mon Sep 17 00:00:00 2001
From: David Vernet <void@manifault.com>
Date: Mon, 12 Dec 2022 17:34:40 -0600
Subject: [PATCH bpf-next] bpf/selftests: Use parent instead of last_wakee in
 task kfunc test

Commit fe147956fca4 ("bpf/selftests: Add selftests for new task kfuncs")
added a negative selftest called task_kfunc_acquire_trusted_walked which
ensures that a BPF program that gets a struct task_struct * pointer from
walking a struct is properly rejected by the verifier if it tries to
pass that pointer to a task kfunc. In order to do this, it uses
task->last_wakee, but unfortunately that's not defined on UP builds.
Just use task->parent instead.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: fe147956fca4 ("bpf/selftests: Add selftests for new task kfuncs")
Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/bpf/progs/task_kfunc_failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index 87fa1db9d9b5..60508c20041f 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -73,7 +73,7 @@ int BPF_PROG(task_kfunc_acquire_trusted_walked, struct task_struct *task, u64 cl
        struct task_struct *acquired;

        /* Can't invoke bpf_task_acquire() on a trusted pointer obtained from walking a struct. */
-       acquired = bpf_task_acquire(task->last_wakee);
+       acquired = bpf_task_acquire(task->parent);
        bpf_task_release(acquired);

        return 0;
--
2.38.1
