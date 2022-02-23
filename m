Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4024C1F77
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 00:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244755AbiBWXQj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 18:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242528AbiBWXQi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 18:16:38 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5AD58390
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 15:16:09 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d6bca75aa2so5304347b3.18
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 15:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BhJUsoTK5aV5hMXGrbNckKjnY5JAB55Pq/ekvjk0Clw=;
        b=Wx79eJ0cagmUtytYmD+wFDQpVmtPNTNGkehmvpo4FpB/mI9qc9+PW/iD+6d1oU32bm
         bghAq2mffsQJarF80M5rq4CwlbzA3n9mDcHuk78DjliwqSLBvxDHnIGyPI5+nuif/cAe
         CS4Hf3HolDnznBSVTAaQulpYp1MHm3gFhCdEG/YRSozm2JGK0EkfL7YEV7lsskDTn0MP
         tkUoZuA2HV/qgKlyZyCA2uPdHW1cOcUPpd/XX9Dr4xIaKaifCS1v6XmmlyBJ8oUFoXYi
         sJMbDKUEK/V9NWsDPxTDvR1XPCPNIb4xUk1eZW4OwLzq2mUYYgb1jJxGEmVDoi++7k2K
         nB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BhJUsoTK5aV5hMXGrbNckKjnY5JAB55Pq/ekvjk0Clw=;
        b=Ik987bTUAVAuvHdVsc4zoaddXn7NfB0dUmYSDH2sB0DwT6eeDfL1F9/KbWglFpD/eU
         xDenn7yutQoe52+I7vgEpQare+Nj6mjasAzYIxT03gJYql4BLsOsD2DOb8t+R2iBrBtn
         /GJNEOC/bgwBnwXX4HilpgKSy39s2Orlk99XEJ34SOtthIb4szjxwEV2yZUubkZOtFhP
         HsBa7JJS5lfVBjXNOgV1DYaK4b57nH9IvCrLcmCduuIh9vRUwgjcDVeuAj6wRsa3dKfR
         EyOPYMVPMWnfoatAbXF+Jj5r/H4bWBQtIn1CcKSnrpqV+1pQDEXTVMf+BsNEQ8mrTHii
         KVzA==
X-Gm-Message-State: AOAM532h6a9XAWen2XeIyXl8GCgfo2pyhPiloioK1NjPvsc/xgbjHoy9
        Y4YL9nNp2hO7BvCXQkILbBk3SXibvRPh
X-Google-Smtp-Source: ABdhPJyjbkOhm+d3Qo5rFFcxETx/mv1oPTm67GgShybJP9Gq4GEZRAfpRd8aZXD6Scb4/ZrTVK9r79DI0beC
X-Received: from gthelen2.svl.corp.google.com ([2620:15c:2cd:202:26ef:3969:d6e5:31f])
 (user=gthelen job=sendgmr) by 2002:a5b:342:0:b0:624:9b29:979f with SMTP id
 q2-20020a5b0342000000b006249b29979fmr39735ybp.599.1645658168592; Wed, 23 Feb
 2022 15:16:08 -0800 (PST)
Date:   Wed, 23 Feb 2022 15:16:06 -0800
In-Reply-To: <CAEf4BzbjxwEukaZfW9qCLwXeyS32WeNQ_8MvUqRd-JA7cZzuGw@mail.gmail.com>
Message-Id: <xr9335k918eh.fsf@gthelen2.svl.corp.google.com>
Mime-Version: 1.0
References: <20220223222002.1085114-1-haoluo@google.com> <CAEf4BzbjxwEukaZfW9qCLwXeyS32WeNQ_8MvUqRd-JA7cZzuGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Cache the last valid build_id.
From:   Greg Thelen <gthelen@google.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Wed, Feb 23, 2022 at 2:20 PM Hao Luo <haoluo@google.com> wrote:
>>
>> For binaries that are statically linked, consecutive stack frames are
>> likely to be in the same VMA and therefore have the same build id.
>> As an optimization for this case, we can cache the previous frame's
>> VMA, if the new frame has the same VMA as the previous one, reuse the
>> previous one's build id. We are holding the MM locks as reader across
>> the entire loop, so we don't need to worry about VMA going away.
>>
>> Tested through "stacktrace_build_id" and "stacktrace_build_id_nmi" in
>> test_progs.
>>
>> Suggested-by: Greg Thelen <gthelen@google.com>
>> Signed-off-by: Hao Luo <haoluo@google.com>
>> ---
>>  kernel/bpf/stackmap.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 22c8ae94e4c1..280b9198af27 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -132,7 +132,8 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>         int i;
>>         struct mmap_unlock_irq_work *work = NULL;
>>         bool irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
>> -       struct vm_area_struct *vma;
>> +       struct vm_area_struct *vma, *prev_vma = NULL;
>> +       const char *prev_build_id;
>>
>>         /* If the irq_work is in use, fall back to report ips. Same
>>          * fallback is used for kernel stack (!user) on a stackmap with
>> @@ -151,6 +152,11 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>
>>         for (i = 0; i < trace_nr; i++) {
>>                 vma = find_vma(current->mm, ips[i]);
>
> as a further optimization, shouldn't we first check if ips[i] is
> within prev_vma and avoid rbtree walk altogether? Would this work:
>
> if (prev_vma && range_in_vma(prev_vma, ips[i])) {
>    /* reuse build_id */
> }
> vma = find_vma(current->mm, ips[i]);
>
>
> ?

Yes, that's a nice addition. Good idea.

>> +               if (vma && vma == prev_vma) {
>> +                       memcpy(id_offs[i].build_id, prev_build_id,
>> +                              BUILD_ID_SIZE_MAX);
>> +                       goto build_id_valid;
>> +               }
>>                 if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
>>                         /* per entry fall back to ips */
>>                         id_offs[i].status = BPF_STACK_BUILD_ID_IP;
>> @@ -158,9 +164,12 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>                         memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
>>                         continue;
>>                 }
>> +build_id_valid:
>>                 id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ips[i]
>>                         - vma->vm_start;
>>                 id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
>> +               prev_vma = vma;
>> +               prev_build_id = id_offs[i].build_id;
>>         }
>>         bpf_mmap_unlock_mm(work, current->mm);
>>  }
>> --
>> 2.35.1.473.g83b2b277ed-goog
>>
