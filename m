Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC466191A5
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 08:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiKDHPQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 03:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKDHPP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 03:15:15 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B817DB492
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 00:15:14 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s196so3686011pgs.3
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 00:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WXNbuSH7mNjvDYb1OwM/KuE254ETLtyy8YYcBX3kISU=;
        b=pxMpwqDXVr1bFgmoNQ7Ony9mn+8sPN8VX8PI9sfmtz+HTLcIlwvuDlpV4Vq8tcGl73
         fgaBe5fmu+PQfVh4MrMIA4++M3EbHvd4SQXCAqsWVPWdn1Rh1/IXL7Jf/RXgZc3Oa5i3
         lT4SBP54C/18cYcxJLDpPkmclWI4HU/bJ7VBsHUl+8P21DSQJWCaIqrC6bp2Jr4gEEnL
         DZ7NqUNWCQlsk8aD3LB1h8tM6txI9a3wHcv6SosLPRm1FO4fhHw2XRuewaDPpWTkPRIP
         3z6et7Zm/lEgZD2km22pOqxGpDdwFZt8GuQvz0FLb/naOJ1iQ20UEe7n0tyJhRU9FJ8P
         4TRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXNbuSH7mNjvDYb1OwM/KuE254ETLtyy8YYcBX3kISU=;
        b=1GarQQQ20rCXNKBmbPS3SQIKXTUnIye7CLP5el4BcGniYWyDSkrBYzvI33Kv+BVPQg
         MLCTO0WVpGEqrjTKP6gX2Gby1WKDXASyJQUAN5NEIIwP9+GziBpmgpsQNuRMBnmZwdTl
         OAL76ynlip9U6L5lmOvB4ION6slow1reYhPUddVb4eynoDevMAZXAnsMrFBgfCBSxaIO
         9dVjwC7UWc46BHrVMlpZlxeIbRd1w60iOo2d0U3Va694M3HjNf18BQqpOZ52HLA6SUkL
         dwwQiGP9emOnOvSnTOODDvohqPJWHSG7SlQJ++sFkEDlVGbstRzqF7JZn2iEQiA1earl
         xO9Q==
X-Gm-Message-State: ACrzQf0R4scRQOkXGst+OIlIL5hxdnLXIoZ/tHmK5lQFqWk7tef5VAUh
        sxG9V8KqzKfYaNquFVqw2VQ=
X-Google-Smtp-Source: AMsMyM4qH1hf5jqQG1SOPy0ZRNb/Ee/WIkRjnuVhgUzU574D44NksQa0HWiZBPfEBDCHFoZj5I0ijg==
X-Received: by 2002:a05:6a00:158e:b0:56c:8dbc:f7a6 with SMTP id u14-20020a056a00158e00b0056c8dbcf7a6mr35028975pfk.80.1667546114212;
        Fri, 04 Nov 2022 00:15:14 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id p189-20020a625bc6000000b0056abff42a8bsm1922253pfb.69.2022.11.04.00.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 00:15:13 -0700 (PDT)
Date:   Fri, 4 Nov 2022 12:44:51 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v4 24/24] selftests/bpf: Add BPF linked list API
 tests
Message-ID: <20221104071451.wjd65fmlgxpm7qcc@apollo>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-25-memxor@gmail.com>
 <0e1ab4b0-422d-f8b4-4673-d1239e2a0794@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e1ab4b0-422d-f8b4-4673-d1239e2a0794@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 12:33:46PM IST, Dave Marchevsky wrote:
> On 11/3/22 3:10 PM, Kumar Kartikeya Dwivedi wrote:
> > Include various tests covering the success and failure cases. Also, run
> > the success cases at runtime to verify correctness of linked list
> > manipulation routines, in addition to ensuring successful verification.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> [...]
>
> > diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
> > new file mode 100644
> > index 000000000000..eed0b2c1eb4a
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/linked_list.c
> > @@ -0,0 +1,330 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_core_read.h>
> > +#include "bpf_experimental.h"
> > +
> > +#ifndef ARRAY_SIZE
> > +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> > +#endif
> > +
> > +struct bar {
> > +	struct bpf_list_node node;
> > +	int data;
> > +};
> > +
> > +struct foo {
> > +	struct bpf_list_node node;
> > +	struct bpf_list_head head __contains(bar, node);
> > +	struct bpf_spin_lock lock;
> > +	int data;
> > +};
> > +
> > +struct map_value {
> > +	struct bpf_list_head head __contains(foo, node);
> > +	struct bpf_spin_lock lock;
> > +	int data;
> > +};
> > +
> > +struct array_map {
> > +	__uint(type, BPF_MAP_TYPE_ARRAY);
> > +	__type(key, int);
> > +	__type(value, struct map_value);
> > +	__uint(max_entries, 1);
> > +} array_map SEC(".maps");
> > +
> > +#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
>
> This __attribute__((aligned(8))) causes my clang to fail to build this selftest.
> It fails with:
>
>   fatal error: error in backend: unable to write nop sequence of 4 bytes
>
> Tracked it down to llvm/lib/Target/BPF/MCTargetDesc/BPFAsmBackend.cpp:
>
>   bool BPFAsmBackend::writeNopData(raw_ostream &OS, uint64_t Count,
>                                    const MCSubtargetInfo *STI) const {
>     if ((Count % 8) != 0)
>       return false;
>
> Presumably since ".data.A" section is PROGBITS the compiler tries to write
> 4 bytes of nop before / between the variables, but fails.
>
> I'm using a clang built off of a very recent LLVM commit [0]. David Vernet
> was able to successfully build the selftests with a clang built from
> late August's tree, so maybe it's my clang version or some other toolchain
> issue. Which clang did you use to build this?
>

Yes, I get the same ICE on clang nightly as well, specifically for linked_list
test. Then I rebuilt this with clang 14.0.6.

Also, that __attribute__ is necessary because the alignment info in UAPI bpf.h
is lost when it gets dumped to BTF and emitted to vmlinux.h. Since the struct
only has padding bits, the default alignment is 1. Adding named fields is
probably the better solution, which gives it __alignof__(u64).

> [0]: github.com/llvm/llvm-project/commit/2a827e4a988b614bc6f70abe00308ceeb50dcd0a
