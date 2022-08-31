Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407915A7C36
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 13:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiHaLcf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 07:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiHaLce (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 07:32:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9DCB4EA6
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 04:32:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id nc14so22817863ejc.4
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 04:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=cRsSAHA0JjdihPrbMx2kI9nXXD88IUt0RIM4eCQIW2o=;
        b=XxBuilaL36COwjblzdnTAFSKjCERfiB75ckpHvawtLF9H/XtpymERklKQnZUro2H+2
         W5JTtNTnSDkjDWDnP3uR+Drnoj5OYtVZLBlCjjZIj/wuv1eT6DqUpzfaYttvFoG+PjR4
         M3qt0Til8TTOSFb9+5jKAvJXYzzXmxbJryO6xjr+COsWT5BnGqmxxQWpq0RWP/K4f2Gx
         vEeMnfRKt0+0P3SCjcyTBnOMViXcEuy6ax3BGQ+4i6mLMBwohFxkdC4KjbWffdNl0/6U
         9wl2O+PMUM5JDCyYXned3ABTu8E6KyWhCbE5wU/ldflgSFGrxE5G+cR735zVheI3DLDD
         ZXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=cRsSAHA0JjdihPrbMx2kI9nXXD88IUt0RIM4eCQIW2o=;
        b=v5Sbl5O5MHU2FLVgxjlIfmLfLLjzKLZYDi02vku7+t1+LLtL+ijhV4TPj/SgHWYdtf
         Qt7hTKsAzNWIl125GxhNjgjbuFEQXJLeMtb/rDwFRSfPNrQVAv/0k4q93YGoQPvtw72Z
         IQydVHqlyiUltkNtJGCTuOLNAoLjS1uDKJAjt7OOjJsIV+O3In5GqXcjWmWCGbYhsokK
         L9V8EzCY3mjxN53PPiMliBJKw1GcqJiPZSQj+VBdZg8at4BZTsKmCbiCalxJ/rlOeU8L
         mtaj2WqDRayxH9rXbwHitpTX+GDZLfPICmZetplqr4ZF+97MuO499cWZZ8fQf6buOxSP
         PdQg==
X-Gm-Message-State: ACgBeo0guua3qwQ/rB11FDy7nN4FRDQYKX+uBhPGEnym0nTT5NcdmNt8
        lv/YZ1tcMFR/wmI3YzJqwf0=
X-Google-Smtp-Source: AA6agR7XKlEV0TA3K4AhEt+1yjR7CoLw7Fa+4aTWCjuc/EwIZ7ZEC3n6lxFH2Y9OTr1PAgu2xEND2A==
X-Received: by 2002:a17:907:8a1e:b0:731:39b9:e00c with SMTP id sc30-20020a1709078a1e00b0073139b9e00cmr20331403ejc.65.1661945552149;
        Wed, 31 Aug 2022 04:32:32 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090676d200b00730860b6c43sm6992998ejn.173.2022.08.31.04.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 04:32:31 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 31 Aug 2022 13:32:30 +0200
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, yhs@fb.com
Subject: Re: [PATCH bpf-next v9 0/5] Parameterize task iterators.
Message-ID: <Yw9GzoOhUBxSs8fz@krava>
References: <20220831023744.1790468-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831023744.1790468-1-kuifeng@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 30, 2022 at 07:37:39PM -0700, Kui-Feng Lee wrote:
> Allow creating an iterator that loops through resources of one task/thread.
> 
> People could only create iterators to loop through all resources of
> files, vma, and tasks in the system, even though they were interested in only the
> resources of a specific task or process.  Passing the additional
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

hi,
I'm getting bpf_iter/vma_offset fail:

test_task_vma_offset_common:PASS:bpf_iter_vma_offset__open_and_load 0 nsec
test_task_vma_offset_common:PASS:attach_iter 0 nsec
test_task_vma_offset_common:PASS:create_iter 0 nsec
test_task_vma_offset_common:PASS:strcmp 0 nsec
test_task_vma_offset_common:FAIL:offset unexpected offset: actual 257222 != expected 203974
test_task_vma_offset_common:PASS:unique_tgid_count 0 nsec
test_task_vma_offset_common:PASS:bpf_iter_vma_offset__open_and_load 0 nsec
test_task_vma_offset_common:PASS:attach_iter 0 nsec
test_task_vma_offset_common:PASS:create_iter 0 nsec
test_task_vma_offset_common:PASS:strcmp 0 nsec
test_task_vma_offset_common:FAIL:offset unexpected offset: actual 257222 != expected 203974
test_task_vma_offset_common:PASS:unique_tgid_count 0 nsec
test_task_vma_offset_common:PASS:bpf_iter_vma_offset__open_and_load 0 nsec
test_task_vma_offset_common:PASS:attach_iter 0 nsec
test_task_vma_offset_common:PASS:create_iter 0 nsec
test_task_vma_offset_common:PASS:strcmp 0 nsec
test_task_vma_offset_common:FAIL:offset unexpected offset: actual 257222 != expected 203974
test_task_vma_offset_common:PASS:unique_tgid_count 0 nsec
#11/38   bpf_iter/vma_offset:FAIL

jirka

> 
> Differences from v8:
> 
>  - Fix uninitialized variable.
> 
>  - Avoid redundant work of getting task from pid.
> 
>  - Change format string to use %u instead of %d.
> 
>  - Use the value of page_shift to compute correct offset in
>    bpf_iter_vm_offset.c.
> 
> Differences from v7:
> 
>  - Travel the tasks of a process through task_group linked list
>    instead of traveling through the whole namespace.
> 
> Differences from v6:
> 
>  - Add part 5 to make bpftool show the value of parameters.
> 
>  - Change of wording of show_fdinfo() to show pid or tid instead of
>    always pid.
> 
>  - Simplify error handling and naming of test cases.
> 
> Differences from v5:
> 
>  - Use user-space tid/pid terminologies in bpf_iter_link_info and
>    bpf_link_info.
> 
>  - Fix reference count
> 
>  - Merge all variants to one 'u32 pid' in internal structs.
>    (bpf_iter_aux_info and bpf_iter_seq_task_common)
> 
>  - Compare the result of get_uprobe_offset() with the implementation
>    with the vma iterators.
> 
>  - Implement show_fdinfo.
> 
> Differences from v4:
> 
>  - Remove 'type' from bpf_iter_link_info and bpf_link_info.
> 
> v8: https://lore.kernel.org/bpf/20220829192317.486946-1-kuifeng@fb.com/
> v7: https://lore.kernel.org/bpf/20220826003712.2810158-1-kuifeng@fb.com/
> v6: https://lore.kernel.org/bpf/20220819220927.3409575-1-kuifeng@fb.com/
> v5: https://lore.kernel.org/bpf/20220811001654.1316689-1-kuifeng@fb.com/
> v4: https://lore.kernel.org/bpf/20220809195429.1043220-1-kuifeng@fb.com/
> v3: https://lore.kernel.org/bpf/20220809063501.667610-1-kuifeng@fb.com/
> v2: https://lore.kernel.org/bpf/20220801232649.2306614-1-kuifeng@fb.com/
> v1: https://lore.kernel.org/bpf/20220726051713.840431-1-kuifeng@fb.com/
> 
> Kui-Feng Lee (5):
>   bpf: Parameterize task iterators.
>   bpf: Handle bpf_link_info for the parameterized task BPF iterators.
>   bpf: Handle show_fdinfo for the parameterized task BPF iterators
>   selftests/bpf: Test parameterized task BPF iterators.
>   bpftool: Show parameters of BPF task iterators.
> 
>  include/linux/bpf.h                           |  25 ++
>  include/uapi/linux/bpf.h                      |  10 +
>  kernel/bpf/task_iter.c                        | 227 ++++++++++++--
>  tools/bpf/bpftool/link.c                      |  19 ++
>  tools/include/uapi/linux/bpf.h                |  10 +
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 282 ++++++++++++++++--
>  .../selftests/bpf/prog_tests/btf_dump.c       |   2 +-
>  .../selftests/bpf/progs/bpf_iter_task.c       |   9 +
>  .../selftests/bpf/progs/bpf_iter_task_file.c  |   9 +-
>  .../selftests/bpf/progs/bpf_iter_task_vma.c   |   7 +-
>  .../selftests/bpf/progs/bpf_iter_vma_offset.c |  37 +++
>  11 files changed, 591 insertions(+), 46 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_vma_offset.c
> 
> -- 
> 2.30.2
> 
