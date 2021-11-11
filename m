Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C916444D4CC
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 11:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhKKKOA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 05:14:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230021AbhKKKN7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 05:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636625469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0rA+4QDY7fcYCncOWJtOa/HujeNT5Vt9NxjUSIUPHvs=;
        b=QXVTVZPP85huloPsfDZEZ7uTJtTN6mgpd1/wdYzj8qHNiwVP5SKjIDlZT3LgRKghuYZClJ
        A55JK1Eunwz/NhQWUq237Jr6jyqF+jI7Y8x9rFL2HZnr0WbLHEuTVRLp7H4UvUxF1Mwc3B
        w1RNE77ZK2o0M1+KseOrLcEFHv+oIvg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-6dKGMigrNdCjs6huV6i0Zg-1; Thu, 11 Nov 2021 05:11:07 -0500
X-MC-Unique: 6dKGMigrNdCjs6huV6i0Zg-1
Received: by mail-wr1-f70.google.com with SMTP id b1-20020a5d6341000000b001901ddd352eso130284wrw.7
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 02:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=0rA+4QDY7fcYCncOWJtOa/HujeNT5Vt9NxjUSIUPHvs=;
        b=ngAy2wsv53kj9j1Z2utrVVMOR/mSje+lLopzeQl21UHI3zfVqibCK2AQdkh3bNc+vF
         9vWZqU045V4224KkZdo3U5rBy6hOfl0Q+v3nautPfYWvRSU0Gc3QZScwh2WmtBNzPM+O
         GCyvOr07Qv8sLTUSJhf9jNP6re/Vr+gLMrVJFKBJv1OsTb2iUov/GK/46YMvzkF6P/y8
         Og2tj1PWm6gK7TLmmbqxI+iOO7PNFtX+XOfAoo1gP+50xWBfyhw3dr/2srp0+hCqcmiz
         3Ow5XDcmyWnLFWNLbzns8p+27GNVe6e6hjbkUyId+hSDN4CI1HaYJE4YqX3g9wZTM+dk
         Wa6g==
X-Gm-Message-State: AOAM533dN1IoH4bYNWppHrTwhdxkz0SjykGX8GNKl7p+Y0iBmvD9kbZ8
        TvARQjzSuF2acwMoMM4/57VCp+ScZ2CjPvwCyHYn/tryMYc7TwZXF4HZe/wEniqh1QvFL4fPA4V
        Re3OY0j1fasYF
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr7303227wro.320.1636625466724;
        Thu, 11 Nov 2021 02:11:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOcg/IBIObd/PrNSThzuPmbYflfz+NcWv98QuuE6NH2tE/x226NzWn+mDBhgZ2vITILodW1Q==
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr7303188wro.320.1636625466497;
        Thu, 11 Nov 2021 02:11:06 -0800 (PST)
Received: from [192.168.3.132] (p4ff23ee8.dip0.t-ipconnect.de. [79.242.62.232])
        by smtp.gmail.com with ESMTPSA id t8sm2094352wmn.44.2021.11.11.02.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 02:11:06 -0800 (PST)
Message-ID: <24b685c3-f16a-9ced-fb39-bf6a0b9f994e@redhat.com>
Date:   Thu, 11 Nov 2021 11:11:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 7/7] tools/testing/selftests/bpf: make it adopt to task
 comm size change
Content-Language: en-US
To:     Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        oliver.sang@intel.com, lkp@intel.com,
        Andrii Nakryiko <andrii@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>
References: <20211108083840.4627-1-laoar.shao@gmail.com>
 <20211108083840.4627-8-laoar.shao@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211108083840.4627-8-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08.11.21 09:38, Yafang Shao wrote:
> The hard-coded 16 is used in various bpf progs. These progs get task
> comm either via bpf_get_current_comm() or prctl() or
> bpf_core_read_str(), all of which can work well even if the task comm size
> is changed.
> 
> In these BPF programs, one thing to be improved is the
> sched:sched_switch tracepoint args. As the tracepoint args are derived
> from the kernel, we'd better make it same with the kernel. So the macro
> TASK_COMM_LEN is converted to type enum, then all the BPF programs can
> get it through BTF.
> 
> The BPF program which wants to use TASK_COMM_LEN should include the header
> vmlinux.h. Regarding the test_stacktrace_map and test_tracepoint, as the
> type defined in linux/bpf.h are also defined in vmlinux.h, so we don't
> need to include linux/bpf.h again.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Michal Miroslaw <mirq-linux@rere.qmqm.pl>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>


Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

