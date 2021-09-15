Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B1340BD71
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 03:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbhIOB47 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 21:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhIOB47 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 21:56:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5543AC061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 18:55:41 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j16so1255800pfc.2
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 18:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCNIamfJ13pFS2ib6aM6umAslMmMMU2lfWxZh7v8MXo=;
        b=cesJzzfzpjJP3bcx+pPlNSuAiYm5J/sumiEkfO5NQ0BtdmayI4+f1BLFD0XqLs8V3Y
         jqoBaCSjhs77mvN/eutMrIpV+P8bS9zJ+aJ73sOH5w/9xIl+x7UYnx5xse3zHuMFn+gz
         UQdStYaiEKAFseDBvKpOCqT7WC0t0+/kyv6re0QcupiRBXAn8Zlh/oxVfC0lMZEoLf73
         8WWogcpXPcG27zhIQHZOiijsdogWxFs1D6Z1u1oBHa+4+gAXYBnIK6j3lYhqLX/0DKyS
         1bvxKJC3fhkE+2yYf9kJsPh8gvrOotOu2x1pa5+BDAUjXhVoSLAox5c428zkMU5kHC3W
         ocrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCNIamfJ13pFS2ib6aM6umAslMmMMU2lfWxZh7v8MXo=;
        b=6qHSFyHOO1I71gN7iMEYZRivyL03cYCkMChOwItUu6mJI8n6gwXzBzNFQmKuWkM+aP
         vlnn05hT/3DxLiFaWiQG9rYX8/jgJ9BckyaJNnz6ilZ8x8LV0KMwFZKot/2PO3zppNfm
         P8NRYUXTqDnwwqxg3EhgWRwAcYvQXysibdNtlT+yLhbQ0Bs8ylBmri/XGsaawVnwL2o1
         9tnswWjVF1dMQMFvm0qnTpfTV18X8E0BuD1ChXvhY89UQtoKN4VT/A4/aKbfD31JpRm4
         GNSw5qjL2ZK0tREG4xhQ4tiYPoXIXBz2wmXK9S6/WEa+UWyjB4wni3PcZPtRTJBiZM7L
         ygkQ==
X-Gm-Message-State: AOAM530yvNBKOY2Eb/gJkQlMoxE5yECum+uAkOvO8YTSjkUSgmvpjb55
        UypE6wfTFPugT5zwb1cWsDHUocME3b0cpN9p+G0=
X-Google-Smtp-Source: ABdhPJwK+PmiVIiZJ7Bnykh6Phi9is7jPh2ymJM48o/ClVS/BMEfK1xqvLGxVh3Wadme0i2dnDbd0HiHtat7k4fBnWw=
X-Received: by 2002:a62:ee16:0:b029:2fe:ffcf:775a with SMTP id
 e22-20020a62ee160000b02902feffcf775amr7805073pfi.59.1631670940774; Tue, 14
 Sep 2021 18:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210914223004.244411-1-yhs@fb.com>
In-Reply-To: <20210914223004.244411-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 14 Sep 2021 18:55:29 -0700
Message-ID: <CAADnVQ+aLj1897R76=TE5GueJVujnZT6G_Ow9mh9waAYfvGdfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/11] bpf: add support for new btf kind BTF_KIND_TAG
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 3:30 PM Yonghong Song <yhs@fb.com> wrote:
>
> LLVM14 added support for a new C attribute ([1])
>   __attribute__((btf_tag("arbitrary_str")))
> This attribute will be emitted to dwarf ([2]) and pahole
> will convert it to BTF. Or for bpf target, this
> attribute will be emitted to BTF directly ([3], [4]).
> The attribute is intended to provide additional
> information for
>   - struct/union type or struct/union member
>   - static/global variables
>   - static/global function or function parameter.
>
> This new attribute can be used to add attributes
> to kernel codes, e.g., pre- or post- conditions,
> allow/deny info, or any other info in which only
> the kernel is interested. Such attributes will
> be processed by clang frontend and emitted to
> dwarf, converting to BTF by pahole. Ultimiately
> the verifier can use these information for
> verification purpose.
>
> The new attribute can also be used for bpf
> programs, e.g., tagging with __user attributes
> for function parameters, specifying global
> function preconditions, etc. Such information
> may help verifier to detect user program
> bugs.
>
> After this series, pahole dwarf->btf converter
> will be enhanced to support new llvm tag
> for btf_tag attribute. With pahole support,
> we will then try to add a few real use case,
> e.g., __user/__rcu tagging, allow/deny list,
> some kernel function precondition, etc,
> in the kernel.
>
> In the rest of the series, Patches 1-2 had
> kernel support. Patches 3-4 added
> libbpf support. Patch 5 added bpftool
> support. Patches 6-10 added various selftests.
> Patch 11 added documentation for the new kind.
>
>   [1] https://reviews.llvm.org/D106614
>   [2] https://reviews.llvm.org/D106621
>   [3] https://reviews.llvm.org/D106622
>   [4] https://reviews.llvm.org/D109560
>
> Changelog:
>   v2 -> v3:
>     - put NR_BTF_KINDS and BTF_KIND_MAX into enum as well
>     - check component_idx earlier (check_meta stage) in kernel
>     - add more tests
>     - fix misc nits

Applied. Please send an update to selftests/bpf/README.
Since folks will be puzzled with messages:
progs/tag.c:23:20: warning: unknown attribute 'btf_tag' ignored
[-Wunknown-attributes]

Even with old clang:
./test_progs -t tag
#21 btf_tag:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

The test probably should fail with old clang ?
