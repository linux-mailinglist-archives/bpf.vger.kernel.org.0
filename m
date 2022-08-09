Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DED958DB2B
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 17:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244278AbiHIPea (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 11:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbiHIPe3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 11:34:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFFC65B6
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 08:34:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j7so14766389wrh.3
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 08:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=Qa1S//XEgl1EoiqMCyA/2wdEbj52xdYm49q49/jtgYg=;
        b=PO5iQRJMSK0rwThPpR0bqrDNBKjComgEcrnrYbRkLT3Btx6XS7/Lf1uaeKTKKH6OVo
         3xP5ckUojVKNs68it4oD6KOPdEeR8undWX3Agf2wz5olp2RqHXCQVbTwC4pVXUT2IBAJ
         8X3uit51s1lqrS82GsfsTTBzKrFdO3EAYvIXicBKuVwJlZWlS8wGk733n5EMYiixRc2P
         qaFhBq9P9aAhD5ob+oFg5to761Ggmxjag9/NclIoT8AAV6kfpWU75UDL0L9IM46LqFqR
         5UkKyn/0vJV84EnldOyB7cAXkeVzr/KtflbVxtZ0Fen0nrlAufjQHZWNGGpOTUQlnL6a
         ACIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=Qa1S//XEgl1EoiqMCyA/2wdEbj52xdYm49q49/jtgYg=;
        b=KPsWADZw6qB+Abqw1sV0VPECsfSHg2qpEV8YZKFhNrFZ/2j0CAf4A4qxTH2cmWUGjT
         hpe1JrGleFCkVl2zYn/dDOAdIxSXXj83mWV4fjtPw/9MLyxQCBoiwazHay7w45QYVdwm
         W1I3MR+UNCfqE0TqUDByt5XEDWnyPvK+hHy/F0oGz9HK3Jax6pvkQHyxvv5t0RDjzMan
         ia0SbFTnYDmUtJzoDSG8zLPRWtUEnTB4uV0o6AgIyTBDwql3BbJqOZGX2Divw1VVZPnZ
         kd71kTWpE5uKflmUin7xC/HaJ90Zj/dsZM0y4ot2fJ2/kTCVog7VKnV2RGcpp4jbnxIH
         MqOA==
X-Gm-Message-State: ACgBeo1t8HaZgK8gem750OLnCVI9BS8XxJQIljER1e5lp7awimfNJzZt
        id5/JDsDCpEzlP5WsfetYVs=
X-Google-Smtp-Source: AA6agR7QMO/zxxc9mFO3xa1lP2ZKnnPEs77xKPME7bKVNN9+Z8IRNves/j9mt95cuYmaSpi6Tyyrqg==
X-Received: by 2002:a5d:6a85:0:b0:21f:cf7f:fdfd with SMTP id s5-20020a5d6a85000000b0021fcf7ffdfdmr14648945wru.220.1660059267018;
        Tue, 09 Aug 2022 08:34:27 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id r1-20020adfe681000000b002216d3aee78sm11728762wrm.86.2022.08.09.08.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 08:34:26 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 9 Aug 2022 17:34:24 +0200
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH bpf-next v3 0/3] Parameterize task iterators.
Message-ID: <YvJ+gCJ0V5hg8wLR@krava>
References: <20220809063501.667610-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809063501.667610-1-kuifeng@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 08, 2022 at 11:34:58PM -0700, Kui-Feng Lee wrote:
> Allow creating an iterator that loops through resources of one task/thread.
> 
> People could only create iterators to loop through all resources of
> files, vma, and tasks in the system, even though they were interested in only the
> resources of a specific task or process.  Passing the addintional
> parameters, people can now create an iterator to go through all
> resources or only the resources of a task.
> 
> Major Changes:
> 
>  - Add new parameters in bpf_iter_link_info to indicate to go through
>    all tasks or to go through a specific task.
> 
>  - Change the implementations of BPF iterators of vma, files, and
>    tasks to allow going through only the resources of a specific task.
> 
>  - Provide the arguments of parameterized task iterators in
>    bpf_link_info.
> 
> Differences from v2:
> 
>  - Supports tid, tgid, and pidfd.
> 
>  - Change 'type' from __u8 to enum bpf_task_iter_type.

hi,
I'm getting test fail:

test_task_:PASS:bpf_iter_task__open_and_load 0 nsec
test_task_:PASS:pthread_mutex_init 0 nsec
test_task_:PASS:pthread_mutex_lock 0 nsec
test_task_:PASS:pthread_create 0 nsec
do_dummy_read:PASS:attach_iter 0 nsec
do_dummy_read:PASS:create_iter 0 nsec
do_dummy_read:PASS:read 0 nsec
test_task_:PASS:pthread_mutex_unlock 0 nsec
test_task_:FAIL:check_num_unknown_tid unexpected check_num_unknown_tid: actual 0 != expected 1
test_task_:PASS:check_num_known_tid 0 nsec
test_task_:PASS:pthread_join 0 nsec
test_task_:PASS:bpf_iter_task__open_and_load 0 nsec
test_task_:PASS:pthread_mutex_init 0 nsec
test_task_:PASS:pthread_mutex_lock 0 nsec
test_task_:PASS:pthread_create 0 nsec
do_dummy_read:PASS:attach_iter 0 nsec
do_dummy_read:PASS:create_iter 0 nsec
do_dummy_read:PASS:read 0 nsec
test_task_:PASS:pthread_mutex_unlock 0 nsec
test_task_:FAIL:check_num_unknown_tid unexpected check_num_unknown_tid: actual 134 != expected 1
test_task_:PASS:check_num_known_tid 0 nsec
test_task_:PASS:pthread_join 0 nsec
#10/5    bpf_iter/task:FAIL

jirka

> 
> v2: https://lore.kernel.org/bpf/20220801232649.2306614-1-kuifeng@fb.com/
> v1: https://lore.kernel.org/bpf/20220726051713.840431-1-kuifeng@fb.com/
> 
> Kui-Feng Lee (3):
>   bpf: Parameterize task iterators.
>   bpf: Handle bpf_link_info for the parameterized task BPF iterators.
>   selftests/bpf: Test parameterized task BPF iterators.
> 
>  include/linux/bpf.h                           |   8 +
>  include/uapi/linux/bpf.h                      |  43 +++
>  kernel/bpf/task_iter.c                        | 153 +++++++++--
>  tools/include/uapi/linux/bpf.h                |  43 +++
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 251 ++++++++++++++++--
>  .../selftests/bpf/prog_tests/btf_dump.c       |   2 +-
>  .../selftests/bpf/progs/bpf_iter_task.c       |   9 +
>  .../selftests/bpf/progs/bpf_iter_task_file.c  |   7 +
>  .../selftests/bpf/progs/bpf_iter_task_vma.c   |   6 +-
>  9 files changed, 474 insertions(+), 48 deletions(-)
> 
> -- 
> 2.30.2
> 
