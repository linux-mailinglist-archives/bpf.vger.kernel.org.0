Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4D66081FA
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 01:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJUXFC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 19:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJUXFA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 19:05:00 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB303BECF7
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:04:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a13so11294184edj.0
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AXNJWmFgQy+uNF/VdgFS7jI55kvZA5AsixPnNUZmVFA=;
        b=bHU5ctopE2Up00G6e6F9A+UHTCiVFNbZxTlNAe17P1oIct5jZiBbM42nvtm/s5Ie/j
         8+yBGsZZ5H7Bvw1tVeH7aq9pzRrwZm8+logzREBdbvlR8F8IIW35GxMTcoWP7ewh9gKX
         jb3sMVGPPOq28Hm89leFxlH6217AiSQK+Z2RN17+6LU9dgiOPNGehSxKFMloZyhu8v3H
         zaovfCGGVn1DzIHOZfpQJ2bRP7qhMKdBwuLZq3YVqTQBu1iMpb14xIDsc8lGtA9EhnbM
         p9eaSMtrw2wJNOUC2aU9SzGU0ZWYTiNaeEmC0iCr9ySXsuJVGsFGXKTdoV/0ShNKRYri
         XvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXNJWmFgQy+uNF/VdgFS7jI55kvZA5AsixPnNUZmVFA=;
        b=kgjXAe/GkF5J2ywrByypHZ57AHe9g/ggyZ6s32MI5cyldE+HKmkqxmEAA1HxDpSg5Y
         pgXnoc1mKg0gHpMNpL/p+JoVC8Cxhwhrwx9hiIKxTCg2regSl5J3W03l/FoPdvzqiZRO
         gGFRsQ1G80uKNx5K49uGS+wN7U68edlbma0MgYfxzVHZIOXQ28JvylmsXuMESVLHXsEa
         4ESw/b8HCK6mw3frPuENNS+JyuUwH+H9lQpEAJP71W4ZisZCMSZgqlLMSGFE9yLERl20
         LxkKxYZ8WTRGPKBB2j6mNpifg6I3fTGSglV8dqkhenPNRdUQq6gvD9Ah7Xldc7u0xAHH
         LX5A==
X-Gm-Message-State: ACrzQf0Dsw8D3BgwW6LptZHhFF6jBX+D5D12w8MwnzyOynzsOgMia7xC
        IvImC3AnYG8t/jsqlWGlQT6FYJMUQ7YcNWibdWM=
X-Google-Smtp-Source: AMsMyM7YDQpcA9uq92qfpxUktfU2wo5B4HpUwpJlyNZualAfxU1VPdC8/KXrffBc5GMkC4/3fs4c6mNI7KOdgfQX9tQ=
X-Received: by 2002:a17:907:2cca:b0:78d:ec48:ac29 with SMTP id
 hg10-20020a1709072cca00b0078dec48ac29mr17507404ejc.114.1666393497294; Fri, 21
 Oct 2022 16:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221020160721.4030492-1-davemarchevsky@fb.com> <20221020160721.4030492-4-davemarchevsky@fb.com>
In-Reply-To: <20221020160721.4030492-4-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Oct 2022 16:04:45 -0700
Message-ID: <CAEf4Bzb+Sb7s8NwDHJ3DGhzRMFaNYi-HbKYSnhSvSk7AUjEAAQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 4/4] selftests/bpf: Add write to hashmap to
 array_map iter test
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 20, 2022 at 9:07 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> Modify iter prog in existing bpf_iter_bpf_array_map.c, which currently
> dumps arraymap key/val, to also do a write of (val, key) into a
> newly-added hashmap. Confirm that the write succeeds as expected by
> modifying the userspace runner program.
>
> Before a change added in an earlier commit - considering PTR_TO_BUF reg
> a valid input to helpers which expect MAP_{KEY,VAL} - the verifier
> would've rejected this prog change due to type mismatch. Since using
> current iter's key/val to access a separate map is a reasonable usecase,
> let's add support for it.
>
> Note that the test prog cannot directly write (val, key) into hashmap
> via bpf_map_update_elem when both come from iter context because key is
> marked MEM_RDONLY. This is due to bpf_map_update_elem - and other basic
> map helpers - taking ARG_PTR_TO_MAP_{KEY,VALUE} w/o MEM_RDONLY type
> flag. bpf_map_{lookup,update,delete}_elem don't modify their
> input key/val so it should be possible to tag their args READONLY, but
> due to the ubiquitous use of these helpers and verifier checks for
> type == MAP_VALUE, such a change is nontrivial and seems better to
> address in a followup series.

Agree about addressing it separately, but I'm not sure what's
non-trivial or dangerous? If I remember correctly, MEM_RDONLY on
helper input arg just means that it accepts both read-only and
read-write views. While the input argument doesn't have MEM_RDONLY we
accept *only* read/write memory views. So basically adding MEM_RDONLY
in BPF helper proto makes it more general and permissive in what can
be passed into it. I think that's a good change, we added tons of
MEM_RDONLY to helpers that were accepting PTR_TO_MEM already.

But anyways, patch looks good:

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>
> Also fixup some 'goto's in test runner's map checking loop.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 20 ++++++++++++------
>  .../bpf/progs/bpf_iter_bpf_array_map.c        | 21 ++++++++++++++++++-
>  2 files changed, 34 insertions(+), 7 deletions(-)
>

[...]
