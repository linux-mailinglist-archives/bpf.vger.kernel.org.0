Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C33E43E5FC
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 18:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhJ1QXm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 12:23:42 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60082
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230094AbhJ1QXm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Oct 2021 12:23:42 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 79E073F166
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 16:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635438074;
        bh=MFCXhrxMMYgeyWYGBw4pwKsi4LVWUxJzOa6T0MBMtLM=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type;
        b=QqIjgHU9gEY/MATVTHlaxL4tCstzpQ4TfFBy+UqFb85noxIVCKbBRj4qNi85de8SE
         NGHdVJzp2LszoM1r7nnzUE2oVvJyxRG+phky2LL6vfB1frJaWVBVevlJmwijguPy0z
         b4Vw4ELhSDCAEW688UYlxbKS1ciSnHt62Gt6jFz5qiCf7m6/SmnFrtfiHU2b6VUl+2
         9xyn6spUb0BiqrEUjvAktAu9W146t/6aj3wu58kGBHPQl84klK8OMOhKMMkDF6zavq
         l8GvfeKS1+wM5dOKBmQiy6cYa6Ok56oCwox+Ir2V0LAYqVqXhBoBJSfKtKv8I5LGd6
         0QVL7tsSH5saA==
Received: by mail-ed1-f69.google.com with SMTP id x13-20020a05640226cd00b003dd4720703bso6132326edd.8
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 09:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=MFCXhrxMMYgeyWYGBw4pwKsi4LVWUxJzOa6T0MBMtLM=;
        b=OL41V0R8qWei6VCdgemWIKa1iW/iVUUCTUdL79MFFtrITpPIHeylGiqWSHxw18s1s3
         OwWzKFT3ye5PsdhHqXeGr2gyQ3M9B40Bb2/QVg15KBJvEgTA7fNhBEeSxU0ROKt9eL70
         zzrwLz6TPgA0Sh+lKZLmfZGXi9VcKnCQOzpKGYQFB/qgtBL6nV6iuNbQK3jSuSNvItSN
         mCE0d9FMz8hQsDstkXsAY4V10ufXabLfOxQYa3WXj9umB3eGxCQ0JBwGbdOs0sQUMoBg
         asR3W+bjVm8tz/yIRrWCr29OxkyTUWswvjoauSBZ9D0IJbwMi+lCuBsfNs3qzAaVNxdX
         WjGw==
X-Gm-Message-State: AOAM5335ZPjGxgawosfHiaNLhG3MGgW1dRaTo91QywYpAuRp96bdeUf2
        ywRtSZ3lMvLtgIdWhizLKidA+c9gCLy63KbfzFoX2P3wEdtCJMuBSxhXTA/K9R+3ixachAOlpSz
        XPSKkCeliH6TSLXy9pLJdhj78QfBsYw==
X-Received: by 2002:a17:906:5d09:: with SMTP id g9mr6611812ejt.330.1635438074194;
        Thu, 28 Oct 2021 09:21:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWZXiaNgMwJhzGxH1D6ClXiGSkRe0zvTc1H0wlSMBtt5rCNF3SDuo4BLgw1+bVmz7g2tyP9g==
X-Received: by 2002:a17:906:5d09:: with SMTP id g9mr6611790ejt.330.1635438073995;
        Thu, 28 Oct 2021 09:21:13 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id o10sm1982444edj.79.2021.10.28.09.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:21:13 -0700 (PDT)
Date:   Thu, 28 Oct 2021 18:21:12 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: selftests: seccomp_bpf failure on 5.15
Message-ID: <YXrN+Hnl9pSOsWlA@arighi-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The following sub-tests are failing in seccomp_bpf selftest:

18:56:54 DEBUG| [stdout] # selftests: seccomp: seccomp_bpf
...
18:56:57 DEBUG| [stdout] # #  RUN           TRACE_syscall.ptrace.kill_after ...
18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:2023:kill_after:Expected entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY : PTRACE_EVENTMSG_SYSCALL_EXIT (1) == msg (0)
18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:2023:kill_after:Expected entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY : PTRACE_EVENTMSG_SYSCALL_EXIT (2) == msg (1)
18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:2023:kill_after:Expected entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY : PTRACE_EVENTMSG_SYSCALL_EXIT (1) == msg (2)
18:56:57 DEBUG| [stdout] # # kill_after: Test exited normally instead of by signal (code: 12)
18:56:57 DEBUG| [stdout] # #          FAIL  TRACE_syscall.ptrace.kill_after
...
18:56:57 DEBUG| [stdout] # #  RUN           TRACE_syscall.seccomp.kill_after ...
18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:1547:kill_after:Expected !ptrace_syscall (1) == IS_SECCOMP_EVENT(status) (0)
18:56:57 DEBUG| [stdout] # # kill_after: Test exited normally instead of by signal (code: 0)
18:56:57 DEBUG| [stdout] # #          FAIL  TRACE_syscall.seccomp.kill_after
18:56:57 DEBUG| [stdout] # not ok 80 TRACE_syscall.seccomp.kill_after
...
18:56:57 DEBUG| [stdout] # # FAILED: 85 / 87 tests passed.
18:56:57 DEBUG| [stdout] # # Totals: pass:85 fail:2 xfail:0 xpass:0 skip:0 error:0
18:56:57 DEBUG| [stdout] not ok 1 selftests: seccomp: seccomp_bpf # exit=1

I did some bisecting and found that the failures started to happen with:

 307d522f5eb8 ("signal/seccomp: Refactor seccomp signal and coredump generation")

Not sure if the test needs to be fixed after this commit, or if the
commit is actually introducing an issue. I'll investigate more, unless
someone knows already what's going on.

Thanks,
-Andrea
