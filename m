Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6345A03C2
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 00:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiHXWGj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 18:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240887AbiHXWGd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 18:06:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0B6786DF
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:06:32 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u9so7124729ejy.5
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 15:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Xm+4Gf1xG1oK1GM+WhAAoclk6yOevjiyPxCVGkIAN8U=;
        b=mkNYQhPfGJoBD4hLng/5/nsMlecxydbnb0E7OHoiWwPRmTR40Z7i5FpE4pV2z/2J4w
         b0Nc9wrpMhAKeKE5pSiP2ORVwTWR53kEjx9nMDcBKazj5LX5KYrJep5+7p0dGLO3pYRi
         apayIjMWTvmXk5fL2e1X4LL0Ui1GmbTzJPb2oPL7tmz1w9LjJWeENkRE81a2dicH/HfG
         XYr+xyj4t0VuvDFAB48QJt9/4hsaO9MXSxzOQGmLdCKyiTHMSAcBUWDDdmUxm2s9ikhE
         yGUYn6BN43pG4025+p3no9tR5P4nOb6n3YEF8c+w7ws2edAsgmcscfF2VO7LDDH1r6NE
         Q1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Xm+4Gf1xG1oK1GM+WhAAoclk6yOevjiyPxCVGkIAN8U=;
        b=iF9/56fW+C4wWNO1VMUsf4xfF3HVQjOPv+nMUDi8tZEFM+c0agtD9aDk9YbB7l8esl
         GgcJg+Qim1V6Cige4r7nXqEnBG+4rovV7XdKiKHVkpyQqc1SdC8ofqkqpzrWjXhOyqqt
         UpgmMU7kkCKM7nyIEFlEjwEJN84zYLC5eZyE7rz5V0uexZPtzaeZnSNp5FtWB/eFT30i
         u76wtwXVzeibUMJs6aFdw+JTc9SwX9lGEUEu8vJJMkxGcOo/UzOybo5uZEiNdlmJl9bR
         ELeVRlq629bsfDB48AfmUnhb3qtLb74FP5GEqiT/86TLnEHouNxInKIeXzcwxRC//25N
         bF3w==
X-Gm-Message-State: ACgBeo1eapBxvkkigUBDUONmkOztZOH0t+KonCClEXsIz0o/RjIHsZnx
        88BaOazsuPXTGuvYgSKzKbusc4O28z0H6NkpKTemwbgb
X-Google-Smtp-Source: AA6agR4P2sgxEY088hX9u1xn905kH/uIuxHDdQZkhcUHSJDh39e3W3nQgLmHLDWCRfFP/UGXt50c63WL76/jHT+P+KI=
X-Received: by 2002:a17:906:99c5:b0:73d:70c5:1a4f with SMTP id
 s5-20020a17090699c500b0073d70c51a4fmr593124ejn.302.1661378791045; Wed, 24 Aug
 2022 15:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220819220927.3409575-1-kuifeng@fb.com>
In-Reply-To: <20220819220927.3409575-1-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Aug 2022 15:06:19 -0700
Message-ID: <CAEf4Bzbq-JBO4D_M591DaDXiaNYHqxhrhm_e5NhA-v4qij8GVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/4] Parameterize task iterators.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 19, 2022 at 3:09 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
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
> Differences from v5:
>
>  - Use user-speace tid/pid terminologies in bpf_iter_link_info *** BLURB HERE ***

BLURB HERE :)

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

We normally carry over entire change history across revisions, so we
don't have to jump through multiple links to see what happened
earlier. Please consider preserving all the changes in one place for
next revision.


> v5: https://lore.kernel.org/bpf/20220811001654.1316689-1-kuifeng@fb.com/
> v4: https://lore.kernel.org/bpf/20220809195429.1043220-1-kuifeng@fb.com/
> v3: https://lore.kernel.org/bpf/20220809063501.667610-1-kuifeng@fb.com/
> v2: https://lore.kernel.org/bpf/20220801232649.2306614-1-kuifeng@fb.com/
> v1: https://lore.kernel.org/bpf/20220726051713.840431-1-kuifeng@fb.com/
>
> Kui-Feng Lee (4):
>   bpf: Parameterize task iterators.
>   bpf: Handle bpf_link_info for the parameterized task BPF iterators.
>   bpf: Handle show_fdinfo for the parameterized task BPF iterators
>   selftests/bpf: Test parameterized task BPF iterators.
>
>  include/linux/bpf.h                           |  25 ++
>  include/uapi/linux/bpf.h                      |  12 +
>  kernel/bpf/task_iter.c                        | 142 +++++++--
>  tools/include/uapi/linux/bpf.h                |  12 +
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 284 +++++++++++++++++-
>  .../selftests/bpf/prog_tests/btf_dump.c       |   2 +-
>  .../selftests/bpf/progs/bpf_iter_task.c       |   9 +
>  .../selftests/bpf/progs/bpf_iter_task_file.c  |   9 +-
>  .../selftests/bpf/progs/bpf_iter_task_vma.c   |   6 +-
>  .../bpf/progs/bpf_iter_uprobe_offset.c        |  35 +++
>  10 files changed, 493 insertions(+), 43 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_uprobe_offset.c
>
> --
> 2.30.2
>
