Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788A83BF085
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 21:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhGGTwo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 15:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231378AbhGGTwo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Jul 2021 15:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625687403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h201HihVDVgG3JVcBjzt3SE6MFp+AXOCveqf1WEGeZI=;
        b=EndBMkoabhw0NsxOiIAf+NLLa/ErA6PNsCXnsuBfgm5IJcaFgbVANyN8IQ2zhPtc5otn4G
        waZvJmUaH7PxUJxW4K8o+ZnwnFgk15vyGQ9i/vbVcbChwcksW+pJ91vatIt4vsKW+VykTh
        VSdLHcbJEDxXoBIEonfDPXP1f0dGxJA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-gMKqF0JVOaeYFM_HBXx2Hg-1; Wed, 07 Jul 2021 15:50:02 -0400
X-MC-Unique: gMKqF0JVOaeYFM_HBXx2Hg-1
Received: by mail-wr1-f69.google.com with SMTP id z2-20020a5d4d020000b0290130e19b0ddbso1113144wrt.17
        for <bpf@vger.kernel.org>; Wed, 07 Jul 2021 12:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h201HihVDVgG3JVcBjzt3SE6MFp+AXOCveqf1WEGeZI=;
        b=sD/os7cQRzrJlDuvYFzkvtBA0sWL7Wab3h6C7hNgWZb6sUv/MoyvPaaSwagZltwxTN
         Iu5AbpMt0sd+HmEDBbuv55HIHYkIzEL+39q5ocjzYG68gEfF0UJ0yRkBoUuUcvbGdLYR
         4Uir4wUElu1pqlwQjQfj+swjasImnio9jTRDVcwkhoQAfHqHKdC1GjgGeIbt1QRFVl4T
         6bGlm2TP1T/k26tC1twuKQ3HIquRJOT+3/uOpLWV/Nz8V6zLWyw4JNmq3XSOhJLYr4fa
         ICSH1MQYi8OMH4eXIhRcvHes4fFWxRrD3347OEgKUDrwsFGw0Kqlmtxpi78PI7clkH/5
         Wzuw==
X-Gm-Message-State: AOAM531x2JhPpfTMwM4w7usfmgZPFlu7w/mj6RdBX1ULV0yM3p0mHDBg
        8PaVlkFRlEzkU8/EAoHeqyJQZgZbr0tMRwOZ7V/YJEumsd6ZkusFpK0nJBMEjA0ntZvJok+0bml
        VozHgaU9ARKAE
X-Received: by 2002:a05:600c:4f4d:: with SMTP id m13mr823769wmq.61.1625687400861;
        Wed, 07 Jul 2021 12:50:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6LTs2DvqAaK4ngj+fBHBL8E7uRYmTjaFCUG8EwHlDWxDI/amBX4dj0BDQuvSZlRcpceGhig==
X-Received: by 2002:a05:600c:4f4d:: with SMTP id m13mr823750wmq.61.1625687400745;
        Wed, 07 Jul 2021 12:50:00 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id q7sm18307544wmq.33.2021.07.07.12.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 12:50:00 -0700 (PDT)
Date:   Wed, 7 Jul 2021 21:49:57 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCHv2 bpf-next 0/7] bpf, x86: Add bpf_get_func_ip helper
Message-ID: <YOYFZeY4U2wl/Ru5@krava>
References: <20210707194619.151676-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707194619.151676-1-jolsa@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

ugh forgot to cc Masami.. sorry, I can resend if needed

jirka

On Wed, Jul 07, 2021 at 09:46:12PM +0200, Jiri Olsa wrote:
> hi,
> adding bpf_get_func_ip helper that returns IP address of the
> caller function for trampoline and krobe programs.
> 
> There're 2 specific implementation of the bpf_get_func_ip
> helper, one for trampoline progs and one for kprobe/kretprobe
> progs.
> 
> The trampoline helper call is replaced/inlined by verifier
> with simple move instruction. The kprobe/kretprobe is actual
> helper call that returns prepared caller address.
> 
> Also available at:
>   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   bpf/get_func_ip
> 
> v2 changes:
>   - use kprobe_running to get kprobe instead of cpu var [Masami]
>   - added support to add kprobe on function+offset
>     and test for that [Alan]
> 
> thanks,
> jirka
> 
> 
> ---
> Alan Maguire (1):
>       libbpf: allow specification of "kprobe/function+offset"
> 
> Jiri Olsa (6):
>       bpf, x86: Store caller's ip in trampoline stack
>       bpf: Enable BPF_TRAMP_F_IP_ARG for trampolines with call_get_func_ip
>       bpf: Add bpf_get_func_ip helper for tracing programs
>       bpf: Add bpf_get_func_ip helper for kprobe programs
>       selftests/bpf: Add test for bpf_get_func_ip helper
>       selftests/bpf: Add test for bpf_get_func_ip in kprobe+offset probe
> 
>  arch/x86/net/bpf_jit_comp.c                               | 19 +++++++++++++++++++
>  include/linux/bpf.h                                       |  5 +++++
>  include/linux/filter.h                                    |  3 ++-
>  include/uapi/linux/bpf.h                                  |  7 +++++++
>  kernel/bpf/trampoline.c                                   | 12 +++++++++---
>  kernel/bpf/verifier.c                                     | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  kernel/trace/bpf_trace.c                                  | 32 ++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h                            |  7 +++++++
>  tools/lib/bpf/libbpf.c                                    | 20 +++++++++++++++++---
>  tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/get_func_ip_test.c      | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  11 files changed, 270 insertions(+), 7 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
>  create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_test.c

