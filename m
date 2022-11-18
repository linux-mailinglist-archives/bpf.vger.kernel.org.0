Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAED62EA05
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 01:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiKRAFS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 19:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiKRAFP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 19:05:15 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA292639C
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 16:05:14 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v17so4908922edc.8
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 16:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ylaE9olIv4mlXryHfv/xe+duu7tut0shlbgTphofv4M=;
        b=em9Louy2bFd506PE6IMlYQAWmzaBT/Q9Jz4D/LRH2BBjyAmhgubz4wNEW3viodb/ep
         L21zxZSbYlvk/JTt/P2fOREZ5k8XyOVv92wjyFamaPZbMVsS4d5D65V0XXZE7lr/LmcI
         MVQcjqaSlzSBjhgxgqhkOrGjOT2nvoPf2OvgQTkmCexV9snGq+s7qyFz3NSfqje3pgll
         r19JWEWw5aLqD6lSnsSbAMV6G/vt5sLsQLIPiyyoc7sJ7qyN5ZajzemjKfaHHJtgKqCv
         Fz8takAUPO+p9pRUijszWC7yuYavHqZf7m1kyzFI4beKqzVnnAEoE4gHOC13BBuOrWNh
         gQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylaE9olIv4mlXryHfv/xe+duu7tut0shlbgTphofv4M=;
        b=0iY5BLHMfbm8O1zJ0pPy4VjBbEIwU6KFKbAb3hF3w+IM1WrUpol37ly/m6l1aXOfpt
         hwMnaVnxfhmmGB6RtjQFhu0IDkd/7Zxn6mc+FZ/6M9cbl7QsdpNoz59IrBYRvvz6ddmK
         xj4gS6t4eorUGfNhlklGQZRLZTODZwIOniz/gSrwLxRkvjYARcZ3GV0W5BSvYHqIxyia
         h/NxXRJ2tVk5wrMGJ1+v3dStXdCcLCT6lSQhoY5eL+kgMKoL3vMiKgAnBdlNYBN2+9V8
         f5Pw1T4nrjqqypVXaWmppwIl5/Sx9lCJ+USyeND45V4dxPv6iUB1YiWJ4pRr2Ok5Qkuz
         iWMA==
X-Gm-Message-State: ANoB5pnru+0G6p7Tl9wMo1d+Bvb+c8PJXaPfU0Jwlb/sIrkVz7xcSZ4R
        JJi1AcsKZbcabEUWvZ63mKGs5JhncML/hDGPJw0=
X-Google-Smtp-Source: AA0mqf6Ed2Bp2LUDCL2T/jXAfsc7LP6rv3mGBmJXFPZFwpDjwv9ep5B51500Ms8Al7mMnrLwHXs97oYBEw4k5xcN6L0=
X-Received: by 2002:a05:6402:142:b0:461:7fe6:9ea7 with SMTP id
 s2-20020a056402014200b004617fe69ea7mr4094725edu.94.1668729913235; Thu, 17 Nov
 2022 16:05:13 -0800 (PST)
MIME-Version: 1.0
References: <20221117225510.1676785-1-memxor@gmail.com> <20221117225510.1676785-23-memxor@gmail.com>
 <CAADnVQKHibbQUNkwvd0g3YDK8n7k6g21=_TFd1=ccRFYJWrsOA@mail.gmail.com>
 <e3b2d51e-22ae-b6b3-b618-b410dbdf89ce@meta.com> <20221117235849.bldrbatcyuhqevtk@apollo>
In-Reply-To: <20221117235849.bldrbatcyuhqevtk@apollo>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 17 Nov 2022 16:05:01 -0800
Message-ID: <CAADnVQ+uPvSBeyYa-2_7hNYoLix86qkOXGR04t_PU=m2Rr19Ag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 22/23] selftests/bpf: Add BPF linked list API tests
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@meta.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
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

On Thu, Nov 17, 2022 at 3:58 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, Nov 18, 2022 at 04:57:50AM IST, Dave Marchevsky wrote:
> > On 11/17/22 6:05 PM, Alexei Starovoitov wrote:
> > > On Thu, Nov 17, 2022 at 2:56 PM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > >>
> > >> Include various tests covering the success and failure cases. Also, run
> > >> the success cases at runtime to verify correctness of linked list
> > >> manipulation routines, in addition to ensuring successful verification.
> > >>
> > >> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > >> ---
> >
> > [...]
> >
> > >> diff --git a/tools/testing/selftests/bpf/progs/linked_list.h b/tools/testing/selftests/bpf/progs/linked_list.h
> > >> new file mode 100644
> > >> index 000000000000..8db80ed64db1
> > >> --- /dev/null
> > >> +++ b/tools/testing/selftests/bpf/progs/linked_list.h
> > >> @@ -0,0 +1,56 @@
> > >> +// SPDX-License-Identifier: GPL-2.0
> > >> +#ifndef LINKED_LIST_H
> > >> +#define LINKED_LIST_H
> > >> +
> > >> +#include <vmlinux.h>
> > >> +#include <bpf/bpf_helpers.h>
> > >> +#include "bpf_experimental.h"
> > >> +
> > >> +struct bar {
> > >> +       struct bpf_list_node node;
> > >> +       int data;
> > >> +};
> > >> +
> > >> +struct foo {
> > >> +       struct bpf_list_node node;
> > >> +       struct bpf_list_head head __contains(bar, node);
> > >> +       struct bpf_spin_lock lock;
> > >> +       int data;
> > >> +       struct bpf_list_node node2;
> > >> +};
> > >> +
> > >> +struct map_value {
> > >> +       struct bpf_spin_lock lock;
> > >> +       int data;
> > >> +       struct bpf_list_head head __contains(foo, node);
> > >> +};
> > >> +
> > >> +struct array_map {
> > >> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> > >> +       __type(key, int);
> > >> +       __type(value, struct map_value);
> > >> +       __uint(max_entries, 1);
> > >> +};
> > >> +
> > >> +struct array_map array_map SEC(".maps");
> > >> +struct array_map inner_map SEC(".maps");
> > >> +
> > >> +struct {
> > >> +       __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> > >> +       __uint(max_entries, 1);
> > >> +       __type(key, int);
> > >> +       __type(value, int);
> > >> +       __array(values, struct array_map);
> > >> +} map_of_maps SEC(".maps") = {
> > >> +       .values = {
> > >> +               [0] = &inner_map,
> > >> +       },
> > >> +};
> > >> +
> > >> +#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
> > >> +
> > >> +private(A) struct bpf_spin_lock glock;
> > >> +private(A) struct bpf_list_head ghead __contains(foo, node);
> > >> +private(B) struct bpf_spin_lock glock2;
> > >
> > > The latest llvm crashes with a bug here:
> > >
> > > fatal error: error in backend: unable to write nop sequence of 4 bytes
> > >
> > > Please see BPF CI.
> > >
> > > So far I wasn't able to find a manual workaround :(
> > > Please give it a shot too.
> > >
> > > Or disable the test for this case for now?
> >
> > I noticed this in an earlier version of the series.
> > Will be submitting a fix to LLVM upstream today.
> >
> > Until that's settled, reverting commit 463da422f019 ("MC: make section classification a bit more thorough")
> > in LLVM will fix the issue.
>
> I can confirm the revert fixes the crash.
>
> Let me know what to do (whether to disable the test temporarily and respin, or
> whether the revert can be applied to CI)? And whether I should respin the set
> adding it to DENYLIST.aarch64.

Please respin with some kind of workaround (if possible)
or temp disable just that test.
