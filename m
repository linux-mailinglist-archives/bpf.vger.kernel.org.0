Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC872E8111
	for <lists+bpf@lfdr.de>; Thu, 31 Dec 2020 16:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgLaPpk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Dec 2020 10:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgLaPpk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Dec 2020 10:45:40 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB3AC061573
        for <bpf@vger.kernel.org>; Thu, 31 Dec 2020 07:45:00 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 11so18237722oty.9
        for <bpf@vger.kernel.org>; Thu, 31 Dec 2020 07:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=yuduB4eHjczaWqNUfXiPMh31DIPqsr1nppE96Y4QKCk=;
        b=dxgi8W4vUvQfkoSoz8OcR/0BdL9WjRFhK9r+iNdXG35iA49wLPT723mcKwyjLoB8r2
         ull9p5U8nJZq7+pxtkRPMBx0NwIBIsFDppLLY/UOfBATGuXEQM5k7slK4AtDPb+J38KD
         OmjS7Ox+ZJO3tY09I9nIcYWLj42OT3JsvEVA1JKH0auZ4vvKRek16Zhgiop9MWCrhdqw
         6A60QORLM54fJnArOdE3eeFxtL3DZZH/I210JJWMOHwS140R4Lu/mbeiv5qQiiu+khvV
         99yNCRx3cBKoLJBiBVoVfFCzzQp4+kAURYbQFPHP1svPU5uDU4qmYjMXU1u360KvhTMq
         3q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=yuduB4eHjczaWqNUfXiPMh31DIPqsr1nppE96Y4QKCk=;
        b=LdvidfMRkLTV8lefswvA5JV6rJIDB59+ceEzl1Rr7gEuPrcpmq7cIP1S1yuzbI4ajC
         voyqQsBSYOMuUb4KNaFH1yn02pAEjLxlR/4iCMiAtEm8uxGGP+MfiSAhBKZeLsQNABmY
         uZyEq/3Oka7Rt9UZM+jHOtvpLoNYzkSB3qvZfeyQZ287IRisrFR4OiIBXcCGrK0Wp0gT
         ZXDucO+3ZDTPr5gdfGxxzV+03BwIqu23ULRfyXMJyae3Oeq0J2hRDyAihNtMU0vzbCE3
         XUrmk0BiC8OoOT7jtWicQKT8eHsWuozAejmZcMM8ue9T9s8nWsJfA35vbuKG/tr+iZmM
         8N1g==
X-Gm-Message-State: AOAM530nx4aQpNJU9QGDnjUCuYysAQh8+dNcbjr/Z2l2hqDlezkDSqoa
        D8hL+aQm+d76GfbSva27WeU=
X-Google-Smtp-Source: ABdhPJzFsHqg1EsezokAv0ltJk81WWpxImi825rbEx90pen+pjE8xgd21bN84ABxYsDKCZ1fzpXiMw==
X-Received: by 2002:a9d:7ac1:: with SMTP id m1mr42435236otn.186.1609429499662;
        Thu, 31 Dec 2020 07:44:59 -0800 (PST)
Received: from localhost ([184.21.204.5])
        by smtp.gmail.com with ESMTPSA id e10sm10431724otr.73.2020.12.31.07.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 07:44:58 -0800 (PST)
Date:   Thu, 31 Dec 2020 07:44:50 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Message-ID: <5fedf1f23f0a5_4b79620837@john-XPS-13-9370.notmuch>
In-Reply-To: <20201231052418.577024-1-yhs@fb.com>
References: <20201231052418.577024-1-yhs@fb.com>
Subject: RE: [PATCH bpf] bpf: fix a task_iter bug caused by a merge conflict
 resolution
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song wrote:
> Latest bpf tree has a bug for bpf_iter selftest.
>   $ ./test_progs -n 4/25
>   test_bpf_sk_storage_get:PASS:bpf_iter_bpf_sk_storage_helpers__open_and_load 0 nsec
>   test_bpf_sk_storage_get:PASS:socket 0 nsec
>   ...
>   do_dummy_read:PASS:read 0 nsec
>   test_bpf_sk_storage_get:FAIL:bpf_map_lookup_elem map value wasn't set correctly
>                           (expected 1792, got -1, err=0)
>   #4/25 bpf_sk_storage_get:FAIL
>   #4 bpf_iter:FAIL
>   Summary: 0/0 PASSED, 0 SKIPPED, 2 FAILED
> 
> When doing merge conflict resolution, Commit 4bfc4714849d missed to
> save curr_task to seq_file private data. The task pointer in seq_file
> private data is passed to bpf program. This caused
> NULL-pointer task passed to bpf program which will immediately return
> upon checking whether task pointer is NULL.
> 
> This patch added back the assignment of curr_task to seq_file private data
> and fixed the issue.
> 
> Fixes: 4bfc4714849d ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf")
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/task_iter.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 3efe38191d1c..175b7b42bfc4 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -159,6 +159,7 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
>                  }
>  
>                  /* set info->task and info->tid */
> +		info->task = curr_task;
>  		if (curr_tid == info->tid) {
>  			curr_fd = info->fd;
>  		} else {
> -- 
> 2.24.1
> 

Acked-by: John Fastabend <john.fastabend@gmail.com>
