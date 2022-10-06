Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA775F601B
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 06:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJFE3Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 00:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJFE3X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 00:29:23 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F3C84E7B
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 21:29:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e18so1143613edj.3
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 21:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wlNHkMxCbmHfN4H+qi8Jx5cnaVdgONIqMM9mcQSV2fI=;
        b=MNwNtaKmqqadeF5OrK+dNQGsa9Yb+rTS1L9Ml2nU7LuBjPbbYWIkWyylorvN6Z+pwG
         1L9mYrlgdGIEo9MnB1bclyA0OTShfJDbeK/XcGQ1oBLwzo71YRxElm8fcRg+Bj9YUy6A
         GwLPeHsT32lNe5KvINUtk+ubxv/R4RENNyl9EDABOoZt/bT/UWGUSM18XdXuffBRAyqt
         QwUN1fXFGlQnPOHOomPmo5XeuyyUZP+C+tIvK7fJ4n/Zf0MaCrIe4dP7q2d0cxAGgHDD
         hK00a9fVQMAEr/cZDnv5it9xAaB98JI7TBZQj+7cZxnn15XLStMuG5hgH0TBenA+PIDA
         oOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlNHkMxCbmHfN4H+qi8Jx5cnaVdgONIqMM9mcQSV2fI=;
        b=3/BAT/oybBtZcxWPpyfaJ1Wop/lD8ivv1KB/3XdYyVnMJmmnAmT+nPm85eN6e3QW7b
         lzyJOlG4ZqA6a6sOMq5f4No8oWah051goAoG/ZimIoijU0F98o6aUgFvjNOHnpNc+4+n
         mYI+WF5u0u6b/+fs07NGOGmJdkVIIRegou6YmoYmnOSqWbF5WBtZSLdJQEpPoTHI6FJa
         NhdiZELOJhtabbdVwbFj4DMyw79B88WOTScxT8Ou/SgoM4tJSnY6yDks5sm1Upp+73m1
         t5HiSdtRhVbrkKf6nhx+mV8TcD+cSSXKweMK50jdEWM/Ns4j++1gdOs/U+/mMGsCMU9i
         wX3g==
X-Gm-Message-State: ACrzQf13TopF6PGMq12PraOVVcWskM4Qf/wGeOXAYR92CLoLyNlTMWiB
        UmTidta+qPY6zBBE2EmIl70fnBEALgX0gksdGGg=
X-Google-Smtp-Source: AMsMyM5CfvgU6y1a66y6lTpSsUtG89WnO1N4RRDnhd7w1AKO8mg5uVw+Xi69bTYwHR4fDqrNa5TM9oWDDGj8Mb2kmOA=
X-Received: by 2002:a05:6402:1856:b0:458:db1e:20ec with SMTP id
 v22-20020a056402185600b00458db1e20ecmr2866445edy.14.1665030561414; Wed, 05
 Oct 2022 21:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221006042452.2089843-1-andrii@kernel.org>
In-Reply-To: <20221006042452.2089843-1-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Oct 2022 21:29:09 -0700
Message-ID: <CAEf4BzZMo5Ezrm3DoAqzV3qcWnbEXky-DHJFzJARmyLymL74CQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: explicitly define BPF_FUNC_xxx
 integer values
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Quentin Monnet <quentin@isovalent.com>,
        Andrea Terzolo <andrea.terzolo@polito.it>
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

On Wed, Oct 5, 2022 at 9:25 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Historically enum bpf_func_id's BPF_FUNC_xxx enumerators relied on
> implicit sequential values being assigned by compiler. This is
> convenient, as new BPF helpers are always added at the very end, but it
> also has its downsides, some of them being:
>
>   - with over 200 helpers now it's very hard to know what's each helper's ID,
>     which is often important to know when working with BPF assembly (e.g.,
>     by dumping raw bpf assembly instructions with llvm-objdump -d
>     command). it's possible to work around this by looking into vmlinux.h,
>     dumping /sys/btf/kernel/vmlinux, looking at libbpf-provided
>     bpf_helper_defs.h, etc. But it always feels like an unnecessary step
>     and one should be able to quickly figure this out from UAPI header.
>
>   - when backporting and cherry-picking only some BPF helpers onto older
>     kernels it's important to be able to skip some enum values for helpers
>     that weren't backported, but preserve absolute integer IDs to keep BPF
>     helper IDs stable so that BPF programs stay portable across upstream
>     and backported kernels.
>
> While neither problem is insurmountable, they come up frequently enough
> and are annoying enough to warrant improving the situation. And for the
> backporting the problem can easily go unnoticed for a while, especially
> if backport is done with people not very familiar with BPF subsystem overall.
>
> Anyways, it's easy to fix this by making sure that __BPF_FUNC_MAPPER
> macro provides explicit helper IDs. Unfortunately that would potentially
> break existing users that use UAPI-exposed __BPF_FUNC_MAPPER and are
> expected to pass macro that accepts only symbolic helper identifier
> (e.g., map_lookup_elem for bpf_map_lookup_elem() helper).
>
> As such, we need to introduce a new macro (___BPF_FUNC_MAPPER) which
> would specify both identifier and integer ID, but in such a way as to
> allow existing __BPF_FUNC_MAPPER be expressed in terms of new
> ___BPF_FUNC_MAPPER macro. And that's what this patch is doing. To avoid
> duplication and allow __BPF_FUNC_MAPPER stay *exactly* the same,
> ___BPF_FUNC_MAPPER accepts arbitrary "context" arguments, which can be
> used to pass any extra macros, arguments, and whatnot. In our case we
> use this to pass original user-provided macro that expects single
> argument and __BPF_FUNC_MAPPER is using it's own three-argument
> __BPF_FUNC_MAPPER_APPLY intermediate macro to impedance-match new and
> old "callback" macros.
>
> Once we resolve this, we use new ___BPF_FUNC_MAPPER to define enum
> bpf_func_id with explicit values. The other users of __BPF_FUNC_MAPPER
> in kernel (namely in kernel/bpf/disasm.c) are kept exactly the same both
> as demonstration that backwards compat works, but also to avoid
> unnecessary code churn.
>
> Note that new ___BPF_FUNC_MAPPER() doesn't forcefully insert comma
> between values, as that might not be appropriate in all possible cases
> where ___BPF_FUNC_MAPPER might be used by users. This doesn't reduce
> usability, as it's trivial to insert that comma inside "callback" macro.
>
> To validate all the manually specified IDs are exactly right, we used
> BTF to compare before and after values:
>
>   $ bpftool btf dump file ~/linux-build/default/vmlinux | rg bpf_func_id -A 211 > after.txt
>   $ git stash # stach UAPI changes
>   $ make -j90
>   ... re-building kernel without UAPI changes ...
>   $ bpftool btf dump file ~/linux-build/default/vmlinux | rg bpf_func_id -A 211 > before.txt
>   $ diff -u before.txt after.txt
>   --- before.txt  2022-10-05 10:48:18.119195916 -0700
>   +++ after.txt   2022-10-05 10:46:49.446615025 -0700
>   @@ -1,4 +1,4 @@
>   -[14576] ENUM 'bpf_func_id' encoding=UNSIGNED size=4 vlen=211
>   +[9560] ENUM 'bpf_func_id' encoding=UNSIGNED size=4 vlen=211
>           'BPF_FUNC_unspec' val=0
>           'BPF_FUNC_map_lookup_elem' val=1
>           'BPF_FUNC_map_update_elem' val=2
>
> As can be seen from diff above, the only thing that changed was resulting BTF
> type ID of ENUM bpf_func_id, not any of the enumerators, their names or integer
> values.
>
> The only other place that needed fixing was scripts/bpf_doc.py used to generate
> man pages and bpf_helper_defs.h header for libbpf and selftests. That script is
> tightly-coupled to exact shape of ___BPF_FUNC_MAPPER macro definition, so had
> to be trivially adapted.
>
> Cc: Quentin Monnet <quentin@isovalent.com>
> Reported-by: Andrea Terzolo <andrea.terzolo@polito.it>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/uapi/linux/bpf.h       | 432 +++++++++++++++++----------------
>  scripts/bpf_doc.py             |  19 +-
>  tools/include/uapi/linux/bpf.h | 432 +++++++++++++++++----------------
>  3 files changed, 447 insertions(+), 436 deletions(-)
>

I should have mentioned that patch #1 hasn't changed since v1 at all.
All the bpf_doc.py adjustments went into patch #2, as I wanted to keep patch #1
with as minimal amount of Python changes as possible to make it work with the
upstream kernel. Patch #2 just further improves bpf_doc.py.

[...]
