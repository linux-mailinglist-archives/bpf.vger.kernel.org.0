Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5203862E9ED
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 00:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiKQX65 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 18:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiKQX6z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 18:58:55 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98765EF84
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 15:58:53 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id g62so3307977pfb.10
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 15:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1xvNb29J9Xo3fZNak3Wqj4gfnFa9hv/J/cinUYzBCFQ=;
        b=LCgG0x1PjIHBXuiFYDaI1TUAr0aNfo1Rb2W0IJ/2BGhCOAF/L7APIBewcWpAzHkcz0
         i0ZLK6TWjPyTEE8zMY9ICE8eDtL4vtamLUdoHBjy8eaF2DsNlEBomYW8JMOV05S/PvU4
         TYTxKZ/nZOTzY+uis0jGYcg6g+faopF1miDfI8LUQvcskNVC8jKvWCjwdJhMhLY9Klqv
         uURmcfWYUjs32xFVZ+FSn1DbLLvWSLjvwXSFbHrJCQdb2Tc+jSO4nYYC0buDehhtG3RB
         Gn/jBm9bFZE9pvquqCZvAEkxzd0qlAn4wLEb7IyF7GviJKFRCYfruL0lPe0Nmws4SEsG
         hXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xvNb29J9Xo3fZNak3Wqj4gfnFa9hv/J/cinUYzBCFQ=;
        b=3lEicA7n1p0I81vB+Czfx7NsqZN678jGk3hUvtTjKwcacg0d265J7K8Cy1OJyEomqp
         /FDLaI0V++3CfAu6BhV2jAUg24JthLvaHMGyXT4UJP92mudm0ymY8zxRGBh1MSrzPqXN
         JtA9j3utJEc+uNVrzZj9aA+hXxFHiQW6oTSMRUXjFfkV6q7+nptkFXYBCGfGYcHkjykU
         E2KXoy1C7kBQEKQo5oMy47HzKOt3xLQQh9/IR1ZJplQO0fvJtRu96Ab7y1U6P+OV8+BN
         7VN25l5BnCFTpiv7J9LMuO0pVTb8RSx42Zw5wwFkluHbly3tdQLULPlQIha6TIPUG8EO
         7zqQ==
X-Gm-Message-State: ANoB5pnsjz8safnO+fuDdRyKDIYBkOyDhffTLuvqTAyhKypGE1fGMo7G
        2NVzorSkJVTgkLovd09tqeeuVt+XVbg=
X-Google-Smtp-Source: AA0mqf5iHqNBCYwzEKow14EgCBRVmvJ/052bDZ7dqpM1zi8YJHASFygqLxHTGNfFpP1vCLKx9mZKVA==
X-Received: by 2002:a63:f354:0:b0:476:db6f:e79d with SMTP id t20-20020a63f354000000b00476db6fe79dmr4308053pgj.399.1668729533164;
        Thu, 17 Nov 2022 15:58:53 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090a450b00b001fd76f7a0d1sm4088333pjg.54.2022.11.17.15.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:58:52 -0800 (PST)
Date:   Fri, 18 Nov 2022 05:28:49 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v9 22/23] selftests/bpf: Add BPF linked list API
 tests
Message-ID: <20221117235849.bldrbatcyuhqevtk@apollo>
References: <20221117225510.1676785-1-memxor@gmail.com>
 <20221117225510.1676785-23-memxor@gmail.com>
 <CAADnVQKHibbQUNkwvd0g3YDK8n7k6g21=_TFd1=ccRFYJWrsOA@mail.gmail.com>
 <e3b2d51e-22ae-b6b3-b618-b410dbdf89ce@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3b2d51e-22ae-b6b3-b618-b410dbdf89ce@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 04:57:50AM IST, Dave Marchevsky wrote:
> On 11/17/22 6:05 PM, Alexei Starovoitov wrote:
> > On Thu, Nov 17, 2022 at 2:56 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >>
> >> Include various tests covering the success and failure cases. Also, run
> >> the success cases at runtime to verify correctness of linked list
> >> manipulation routines, in addition to ensuring successful verification.
> >>
> >> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >> ---
>
> [...]
>
> >> diff --git a/tools/testing/selftests/bpf/progs/linked_list.h b/tools/testing/selftests/bpf/progs/linked_list.h
> >> new file mode 100644
> >> index 000000000000..8db80ed64db1
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/bpf/progs/linked_list.h
> >> @@ -0,0 +1,56 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +#ifndef LINKED_LIST_H
> >> +#define LINKED_LIST_H
> >> +
> >> +#include <vmlinux.h>
> >> +#include <bpf/bpf_helpers.h>
> >> +#include "bpf_experimental.h"
> >> +
> >> +struct bar {
> >> +       struct bpf_list_node node;
> >> +       int data;
> >> +};
> >> +
> >> +struct foo {
> >> +       struct bpf_list_node node;
> >> +       struct bpf_list_head head __contains(bar, node);
> >> +       struct bpf_spin_lock lock;
> >> +       int data;
> >> +       struct bpf_list_node node2;
> >> +};
> >> +
> >> +struct map_value {
> >> +       struct bpf_spin_lock lock;
> >> +       int data;
> >> +       struct bpf_list_head head __contains(foo, node);
> >> +};
> >> +
> >> +struct array_map {
> >> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> >> +       __type(key, int);
> >> +       __type(value, struct map_value);
> >> +       __uint(max_entries, 1);
> >> +};
> >> +
> >> +struct array_map array_map SEC(".maps");
> >> +struct array_map inner_map SEC(".maps");
> >> +
> >> +struct {
> >> +       __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> >> +       __uint(max_entries, 1);
> >> +       __type(key, int);
> >> +       __type(value, int);
> >> +       __array(values, struct array_map);
> >> +} map_of_maps SEC(".maps") = {
> >> +       .values = {
> >> +               [0] = &inner_map,
> >> +       },
> >> +};
> >> +
> >> +#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
> >> +
> >> +private(A) struct bpf_spin_lock glock;
> >> +private(A) struct bpf_list_head ghead __contains(foo, node);
> >> +private(B) struct bpf_spin_lock glock2;
> >
> > The latest llvm crashes with a bug here:
> >
> > fatal error: error in backend: unable to write nop sequence of 4 bytes
> >
> > Please see BPF CI.
> >
> > So far I wasn't able to find a manual workaround :(
> > Please give it a shot too.
> >
> > Or disable the test for this case for now?
>
> I noticed this in an earlier version of the series.
> Will be submitting a fix to LLVM upstream today.
>
> Until that's settled, reverting commit 463da422f019 ("MC: make section classification a bit more thorough")
> in LLVM will fix the issue.

I can confirm the revert fixes the crash.

Let me know what to do (whether to disable the test temporarily and respin, or
whether the revert can be applied to CI)? And whether I should respin the set
adding it to DENYLIST.aarch64.
