Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDBB57222F
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 20:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiGLSHa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 14:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbiGLSH0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 14:07:26 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81523B93C0
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 11:07:25 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id o10-20020a655bca000000b00412787983b3so3653021pgr.12
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lloN9hb7nN2dMAdA09PzOQpjSNDOoS5RCiCFgS6Ls+s=;
        b=NxWjyiUpCWyFcSNCFjEwidDmT84Pg1+9DC8lbNLbejZBrVuVS7GF1pmdcmS9XCiNaA
         w5RKAnawrUXTfD/8C86WAYOfT4DZsoKbJ+M8RUqtWKeyRyvFcKdGWeO71HUCD0bklOte
         Q+k1ypPkJSSoDNnWNfn3spDBBhQ8vQK2aEJsh7bmeTQIMpJACrDj7MOgfFGDD2AdNawf
         krQisMJR4TJaL1I8ky8ZkkpYeQW+TLnZobL36cdwlZ8bir0G9pcIbM53YyDDN16DbpRR
         2/grgMIDZBcomHflPc5gwyzot0kjv7WvN2ANn23HKLLgS2vRDk1tnnVrN+f6suT3670m
         MJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lloN9hb7nN2dMAdA09PzOQpjSNDOoS5RCiCFgS6Ls+s=;
        b=J1wd/hbK0ox4bW0ikqfT/5ZpFfRpgDdQiGi1aCggrZd+UI58e0QqmAlu72BU+iDyBL
         xhr7JhJ1IosD2AwA+qc3mebif1JNRhO8elQoeMnF7FDGB4qCUgbYhP5snaZkAYei+9GW
         7g0pom2Ew0GYHh2i+uuAHIrAIhapisknhks3me8tsTqUdGWdf9v/3fdCia7ge+n9QPSS
         bHRF526rrayE4SI5jpLQCaEcw50iNH9vvMtbCJeUi0sBM5uWZzQ+rf5MWfTtyP4C4iK1
         HWc+n0uytpEGZtGEsDvRDCPT4vEhOwqnPezEp8P1t6pGq3/yknUoLj6D7oCevelExiaQ
         VR4g==
X-Gm-Message-State: AJIora+ge7Y6RwOIRcPsc+eiW5tnlRafxP1258qWQV3ZC7DDQb/qnj8i
        z+D3DhzFoDDtLjkVfv2N2LnhXqI=
X-Google-Smtp-Source: AGRyM1u/FqkBduqX9SBfkyj10noBI6i+TvTijT45z0mdUEL64ZNkVlM0xikNBe5w0uQYnvszA6MhqwQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:90ce:0:b0:528:90a4:73ec with SMTP id
 k14-20020aa790ce000000b0052890a473ecmr24459926pfk.73.1657649244800; Tue, 12
 Jul 2022 11:07:24 -0700 (PDT)
Date:   Tue, 12 Jul 2022 11:07:23 -0700
In-Reply-To: <cover.1657576063.git.delyank@fb.com>
Message-Id: <Ys24W4RJS0BAfKzP@google.com>
Mime-Version: 1.0
References: <cover.1657576063.git.delyank@fb.com>
Subject: Re: [PATCH RFC bpf-next 0/3] Execution context callbacks
From:   sdf@google.com
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/11, Delyan Kratunov wrote:
> BPF developers are sometimes faced with surprising limitations of the  
> execution context
> their code runs in. NMI is particularly problematic though userspace data  
> access as a whole
> has come up as well (e.g. build id not being available).

> This series adds bpf_delayed_work_submit which takes a callback function  
> and a context pointer
> and is able to execute the callback from (initially) a hardirq context.

> This is an RFC to answer a few questions on direction:

> 1. Naming is intentionally bad and something I'd like to bikeshed a bit.
> "bpf_(defer|submit)_work" was my first instinct but that has workqueue  
> connotations in the kernel.

> 2. The callback arguments need to be in a map. We can currently express  
> helper arguments taking a
> pointer to a map value but not a pointer to _within_ a map value. Should  
> we add a new argument
> type or should we just pass the map value pointer to the callback?

Passing map value pointer (as you do in the selftest) seems fine; do
you think we need more flexibility here?

> 3. A lot of the map handling code is verbatim from bpf_timer. This feels  
> icky but I'm not sure if it
> justifies a refactor quite yet. Opinions welcome.

+1, it does seem very close to a timer with expiry time == 0.

I don't know what's the exact usecase you're trying to solve exactly, but
have you though of maybe initially supporting something like:

bpf_timer_init(&timer, map, SOME_NEW_DEFERRED_NMI_ONLY_FLAG);
bpf_timer_set_callback(&timer, cg);
bpf_timer_start(&timer, 0, 0);

If you init a timer with that special flag, I'm assuming you can have
special cases in the existing helpers to simulate the delayed work?
Then, the verifier changes should be minimal it seems.

OTOH, having a separate set of helpers seems more clear API-wise :-/

> 4. This functionality is implemented as a single helper call (no matching  
> bpf_delayed_work_init). In practice,
> this means that we can't implement the map->usercnt check that  
> bpf_timer_start performs to ensure the
> map is referenced from userspace. However, given that a) we wait for  
> pending work before releasing the
> bpf_prog, b) the map will be in the bpf_prog's used_maps, and c) the map  
> free path does not need to release
> any external resources, and d) the bpf_delayed_work items bump the prog  
> refcnt, I think we can keep this mechanism
> a single call.

> I'd like to get this right from the start, so do let me know if I'm  
> missing potential execution
> contexts that we can't really wait to drain from the bpf_prog free path.

> 5. This mechanism generalizes to other contexts (e.g., sleepable context  
> on the way back to userspace
> a-la set_thread_flag(TIF_UPROBE)), by means of adding the  
> bpf_delayed_work items to other llist_heads.
> E.g., we can keep the llist_heads in task_local_storage or in per-cpu  
> structures. I can't think of
> anything that requires a more complicated approach (or reserved space in  
> the structs) but do let me
> know if I'm wrong.

> 6. Lastly, the llist approach was dictated by the NMI constraints. RCU  
> lists are out because they need
> to synchronize_rcu when splicing from one head to another.

> Thanks,
> Delyan

> Delyan Kratunov (3):
>    bpf: allow maps to hold bpf_delayed_work fields
>    bpf: add delayed_work mechanism
>    selftests: delayed_work tests

>   include/linux/bpf.h                           |  22 ++-
>   include/linux/btf.h                           |   1 +
>   include/uapi/linux/bpf.h                      |  36 +++++
>   kernel/bpf/btf.c                              |  21 +++
>   kernel/bpf/core.c                             |   8 ++
>   kernel/bpf/helpers.c                          |  92 ++++++++++++
>   kernel/bpf/syscall.c                          |  24 +++-
>   kernel/bpf/verifier.c                         | 132 +++++++++++++++++-
>   scripts/bpf_doc.py                            |   2 +
>   tools/include/uapi/linux/bpf.h                |  35 +++++
>   .../selftests/bpf/prog_tests/delayed_work.c   |  29 ++++
>   .../selftests/bpf/progs/delayed_irqwork.c     |  59 ++++++++
>   12 files changed, 457 insertions(+), 4 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/delayed_work.c
>   create mode 100644 tools/testing/selftests/bpf/progs/delayed_irqwork.c

> --
> 2.36.1
