Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16D6277C89
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 01:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgIXX4z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 19:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgIXX4z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 19:56:55 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67EEC0613CE
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 16:56:54 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q4so819236pjh.5
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 16:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PEQHQdRyQ9xsSCdQzKyvMmoiCwe5AhDytk6haiQYAYA=;
        b=ZoSBF1dT+8ZzaoiNAlcF2KrzB+hxJVDnGMsShZQ+860GdXPO2wmj7dDRwbYZeZ6FP0
         tzTDEEpd16UQ9NlRiaEe6R1ZIMkEjYQrDuWy5groU3A3GHraaAl994ENGTGfOqf1E+be
         7Fd1TTa/XVDOW8VwnCn8keFubI4lgYN/gRBv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PEQHQdRyQ9xsSCdQzKyvMmoiCwe5AhDytk6haiQYAYA=;
        b=H6T8HOUGogo/jHPjsjAIo5x4DNztp+JvEx41S9ehGmKZU0W643zBci85PKrEftWoij
         ETjVTczWVp6K01oOxwRj99F0gf0rF58ydehLRFwe4f9lyTHuNBvF4Xq4eLRhgKSMoTt1
         D7EXsV3CjDUX9Vi6HzKvmjsnGSawznapQoEx3AdmNEChwbJpDILbpi3N0SlcQ0rcIVtG
         VaQdPan4RZdicSRb5c58P9dd4UHVLJuU9bOczn35Oa6ACNrehjCJQcci+rRLcqcURnuV
         DduelSop9WFE9vjZnEdxI1gqIQJzg0CFmxcJkehes+CZ1bzCB1KPhpnD6+PglFxznp8Y
         I5Rg==
X-Gm-Message-State: AOAM532X/Nd+Z3CY4yTkAXDvnxg+BzO9+xt01i8Wtk4JwiKTV2P2ETeK
        GQK1pq3Oofk2wGmlJKgntqdyEw==
X-Google-Smtp-Source: ABdhPJzyfryL0iIu0PMOcXe+glEbhoRCWk4I6igRlfPAIK3CdtHgMQxMMQcPAkl7466Tlrc0Ju8TcA==
X-Received: by 2002:a17:90a:db56:: with SMTP id u22mr95780pjx.85.1600991814140;
        Thu, 24 Sep 2020 16:56:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d25sm418889pgl.23.2020.09.24.16.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 16:56:53 -0700 (PDT)
Date:   Thu, 24 Sep 2020 16:56:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     containers@lists.linux-foundation.org,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v2 seccomp 6/6] seccomp/cache: Report cache data through
 /proc/pid/seccomp_cache
Message-ID: <202009241647.2239747F0@keescook>
References: <cover.1600951211.git.yifeifz2@illinois.edu>
 <b11ebe533838af7829a5e7381a7914bca27cb621.1600951211.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b11ebe533838af7829a5e7381a7914bca27cb621.1600951211.git.yifeifz2@illinois.edu>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 07:44:21AM -0500, YiFei Zhu wrote:
> From: YiFei Zhu <yifeifz2@illinois.edu>
> 
> Currently the kernel does not provide an infrastructure to translate
> architecture numbers to a human-readable name. Translating syscall
> numbers to syscall names is possible through FTRACE_SYSCALL
> infrastructure but it does not provide support for compat syscalls.
> 
> This will create a file for each PID as /proc/pid/seccomp_cache.
> The file will be empty when no seccomp filters are loaded, or be
> in the format of:
> <hex arch number> <decimal syscall number> <ALLOW | FILTER>
> where ALLOW means the cache is guaranteed to allow the syscall,
> and filter means the cache will pass the syscall to the BPF filter.
> 
> For the docker default profile on x86_64 it looks like:
> c000003e 0 ALLOW
> c000003e 1 ALLOW
> c000003e 2 ALLOW
> c000003e 3 ALLOW
> [...]
> c000003e 132 ALLOW
> c000003e 133 ALLOW
> c000003e 134 FILTER
> c000003e 135 FILTER
> c000003e 136 FILTER
> c000003e 137 ALLOW
> c000003e 138 ALLOW
> c000003e 139 FILTER
> c000003e 140 ALLOW
> c000003e 141 ALLOW
> [...]
> 
> This file is guarded by CONFIG_PROC_SECCOMP_CACHE with a default
> of N because I think certain users of seecomp might not want the
> application to know which syscalls are definitely usable.
> 
> I'm not sure if adding all the "human readable names" is worthwhile,
> considering it can be easily done in userspace.

The question of permissions is my central concern here: who should see
this? Some contained processes have been intentionally blocked from
self-introspection so even the "standard" high bar of "ptrace attach
allowed?" can't always be sufficient.

My compromise about filter visibility in the past was saying that
CAP_SYS_ADMIN was required (see seccomp_get_filter()). I'm nervous to
weaken this. (There is some work that hasn't been sent upstream yet that
is looking to expose the filter _contents_ via /proc that has been
nervous too.)

Now full contents vs "allow"/"filter" are certainly different things,
but I don't feel like I've got enough evidence to show that this
introspection would help debugging enough to justify the partially
imagined safety of not exposing it to potential attackers.

I suspect it _is_ the right thing to do (just look at my own RFC's
"debug" patch), but I'd like this to be well justified in the commit
log.

And yes, while it does hide behind a CONFIG, I'd still want it justified,
especially since distros have a tendency to just turn everything on
anyway. ;)

> +	for (arch = 0; arch < ARRAY_SIZE(syscall_arches); arch++) {
> +		for (nr = 0; nr < NR_syscalls; nr++) {
> +			bool cached = test_bit(nr, f->cache.syscall_ok[arch]);
> +			char *status = cached ? "ALLOW" : "FILTER";
> +
> +			seq_printf(m, "%08x %d %s\n", syscall_arches[arch],
> +				   nr, status
> +			);
> +		}
> +	}

But behavior-wise, yeah, I like it; I'm fine with human-readable and
full AUDIT_ARCH values. (Though, as devil's advocate again, to repeat
Jann's own words back: do we want to add this only to have a new UAPI to
support going forward?)

-- 
Kees Cook
