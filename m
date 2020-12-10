Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655C32D6253
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 17:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391207AbgLJQoz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 11:44:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391893AbgLJQos (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Dec 2020 11:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607618601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2+HLti2s/wIrYv82ti7bMHxdppCBUMBAOmSNG3h3caw=;
        b=Bb0rhAgUFVsGSw4SmrSgjhNNMeH7qpdWMRvLp6JnjDir8G4hrCVk8rKEpnyX04076PF0wT
        lyRWRnOrKqcQCeIpeXMfQ4ETrAHLjvy/PHCZ3zFpiZYJCC9zxKrYDd18A3VQdSbE5lqMj0
        1FACJSR9njLjBpM9nqfZKMJHfZo4/HQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-flDf6tVsPTutfE42m786pg-1; Thu, 10 Dec 2020 11:43:19 -0500
X-MC-Unique: flDf6tVsPTutfE42m786pg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F09D915720;
        Thu, 10 Dec 2020 16:43:17 +0000 (UTC)
Received: from krava (unknown [10.40.192.193])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1C3166A252;
        Thu, 10 Dec 2020 16:43:15 +0000 (UTC)
Date:   Thu, 10 Dec 2020 17:43:15 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Per-CPU variables in modules and pahole
Message-ID: <20201210164315.GA184880@krava>
References: <CAEf4BzZWabv_hExaANQyQ71L2JHYqXaT4hFj52w-poWoVYWKqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZWabv_hExaANQyQ71L2JHYqXaT4hFj52w-poWoVYWKqQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 09, 2020 at 12:53:44PM -0800, Andrii Nakryiko wrote:
> Hi,
> 
> I'm working on supporting per-CPU symbols in BPF/libbpf, and the
> prerequisite for that is BTF data for .data..percpu data section and
> variables inside that.
> 
> Turns out, pahole doesn't currently emit any BTF information for such
> variables in kernel modules. And the reason why is quite confusing and
> I can't figure it out myself, so was hoping someone else might be able
> to help.
> 
> To repro, you can take latest bpf-next tree and add this to
> bpf_testmod/bpf_testmod.c inside selftests/bpf:
> 
> $ git diff bpf_testmod/bpf_testmod.c
>       diff --git
> a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 2df19d73ca49..b2086b798019 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -3,6 +3,7 @@
>  #include <linux/error-injection.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> +#include <linux/percpu-defs.h>
>  #include <linux/sysfs.h>
>  #include <linux/tracepoint.h>
>  #include "bpf_testmod.h"
> @@ -10,6 +11,10 @@
>  #define CREATE_TRACE_POINTS
>  #include "bpf_testmod-events.h"
> 
> +DEFINE_PER_CPU(int, bpf_testmod_ksym_dummy1) = -1;
> +DEFINE_PER_CPU(int, bpf_testmod_ksym_percpu) = 123;
> +DEFINE_PER_CPU(int, bpf_testmod_ksym_dummy2) = -1;
> +
>  noinline ssize_t
>  bpf_testmod_test_read(struct file *file, struct kobject *kobj,
>                       struct bin_attribute *bin_attr,
> 
> 1. So the very first issue (that I'm going to ignore for now) is that
> if I just added bpf_testmod_ksym_percpu, it would get addr == 0 and
> would be ignored by the current pahole logic. So we need to fix that
> for modules. Adding dummy1 and dummy2 takes care of this for now,
> bpf_testmod_ksym_percpu has offset 4.

I removed that addr zero check in the modules changes but when
collecting functions, but it's still there in collect_percpu_var

> 
> 2. Second issue is more interesting. Somehow, when pahole iterates
> over DWARF variables, the address of bpf_testmod_ksym_percpu is
> reported as 0x10e74, not 4. Which totally confuses pahole because
> according to ELF symbols, bpf_testmod_ksym_percpu symbol has value 4.
> I tracked this down to dwarf_getlocation() returning 10e74 as number
> field in expr.

in which place do you see that address? when I put displayed
address from collect_percpu_var it shows 4

not sure this is related but looks like similar issue I had to
solve for modules functions, as described in the changelog:
(not merged yet)

    btf_encoder: Detect kernel module ftrace addresses

    ...
    There's one tricky point with kernel modules wrt Elf object,
    which we get from dwfl_module_getelf function. This function
    performs all possible relocations, including __mcount_loc
    section.

    So addrs array contains relocated values, which we need take
    into account when we compare them to functions values which
    are relative to their sections.
    ...

The 0x10e74 value could be relocated 4.. but it's me guessing,
because not sure where you see that address exactly

jirka

