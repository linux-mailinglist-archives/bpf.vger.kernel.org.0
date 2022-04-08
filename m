Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD27C4F9D16
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 20:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbiDHSnH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 14:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbiDHSmt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 14:42:49 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC44181159
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 11:40:45 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r11so7080701ila.1
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 11:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+0NbECOTepiFR95PH7iBNDLaq38jykJqVNkLQyHaX0=;
        b=Skr9tdXmnlB3bZmZnu0t0hACfbtzAEyNvCznGKRs2jkfMCehxuhKSvFDHm0E3r52WD
         nMphZk1WctlJVkORwccOqbf4fZM7QaFo6gVdcIylbM1kb6RbKOyTCZkfgIBo0ExKlO6V
         k5CGuj44e7xSd+Zqr3u0tducYk4UilwHX7JqcrBGtKaNoQeYPOZhCKLHFitxDmmNRCSh
         JPgXUAVbGS1L28HpY3mrbUz/ohcsgzlFyKUBs50+8muMCMhGafrxYwv79F+V7/6LGKlR
         YWL3aulrtW7Ah3goU7HDMxwwOKtExmcHCU41L0l7vokJ6vK7fT73tYpZCJszazDXZc6n
         MQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+0NbECOTepiFR95PH7iBNDLaq38jykJqVNkLQyHaX0=;
        b=DV7uLai52siRe8gvK1is29VNWoVD4bLZtMy82qzd0W6IYMSTxProU3SS32clRDXSV0
         3CR4RzAT+KCiSokNCJKrLGafKiaL/+UakBkBQt1yExSD3tqmh3PaxdDJFE2FbPOAFtLb
         DFhRJyjMFnHwkVjIndsPhn4SJEoxuOM9AXWc2zpjHBVEzKTyc7wMjF1+R0LP49987evJ
         6X4uULajlbh3conCvSHkC8ymg53ww2Q8oDDYECjgd13vPbGQqK0Uq3eyruzxeAWpjNIy
         knkdvuU0bN40/xZGhl7XewHRaX9SKV7tmp/NX+w/NNsNJRPlk51iGJHgkP7NPrlfwHs2
         3mRA==
X-Gm-Message-State: AOAM531SZV7/k0iwiJxQtG7jGJfrNFPLh7MHPX4SOXueHunRO7bV1zLQ
        jpESX2AUwiCkhWGFPJZcLrvueEduT8jxa9EiZBNjzCUE
X-Google-Smtp-Source: ABdhPJxHyun9ENxoD+AUh/euM7EhsJTh5B3ckKMH6h4ThjkGwxUHb5ojKa8LYBKXFjusw2TjxVGUnqcseF8/G5f1tzo=
X-Received: by 2002:a05:6e02:1a8f:b0:2c9:da3d:e970 with SMTP id
 k15-20020a056e021a8f00b002c9da3de970mr9062599ilv.239.1649443244815; Fri, 08
 Apr 2022 11:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220408181425.2287230-1-andrii@kernel.org>
In-Reply-To: <20220408181425.2287230-1-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Apr 2022 11:40:34 -0700
Message-ID: <CAEf4BzYLYEVic8gfbL1PvhJgpKeVEs0-VM=tgU2kq7ufZPx=CQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Fix handling of CO-RE relos for __weak subprogs
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Fri, Apr 8, 2022 at 11:14 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Fix the issue accidentally discovered during libbpf USDT support testing.
> Libbpf overzealously complained about CO-RE relocations belonging to the code
> of a __weak subprog that got overriden by another instance of that function.
>
> Fix the issue fixed, return back to __weak __hidden annotation for USDT

"With the issue fixed", sigh...

> BPF-side APIs.
>
> And add CO-RE relos to linked_funcs selftest to ensure such combo keeps
> working going forward.
>
> Andrii Nakryiko (3):
>   libbpf: don't error out on CO-RE relos for overriden weak subprogs
>   libbpf: use weak hidden modifier for USDT BPF-side API functions
>   selftests/bpf: add CO-RE relos into linked_funcs selftests
>
>  tools/lib/bpf/libbpf.c                            | 15 +++++++++++----
>  tools/lib/bpf/usdt.bpf.h                          |  6 +++---
>  tools/testing/selftests/bpf/progs/linked_funcs1.c |  8 ++++++++
>  tools/testing/selftests/bpf/progs/linked_funcs2.c |  8 ++++++++
>  4 files changed, 30 insertions(+), 7 deletions(-)
>
> --
> 2.30.2
>
