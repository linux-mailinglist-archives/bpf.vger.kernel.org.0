Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675E243E6AB
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 18:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJ1Q6l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 12:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJ1Q6l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Oct 2021 12:58:41 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03671C061570
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 09:56:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id m14so6540306pfc.9
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 09:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Rb6TWs/KzRCizpcXWCm00T2l0fidD3Q6hJh935Rq8o=;
        b=jP7mbgHsLR7Qwq2NNCPO2eBOSTmnAp52w2Xgs+qssWxbI5Zf9AQrWnO/lw/ORlIxns
         KugfZRtTPlRIKSoUZWY7o0ReHCwLgrFVQ1lQ/F0oyReNxdYnQn+vv3ecSjDPAnU4vWUS
         eEWn3mB4cmMni/8Z2bCvjcOoTr1zJjW/jRt/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Rb6TWs/KzRCizpcXWCm00T2l0fidD3Q6hJh935Rq8o=;
        b=7ig1Yk/Cilz8Um/iFC2hzwwWYqtrgqW0Ijr0gtYtJOnblfgnSi3vg72W9UsfvJ6qza
         v6haKJF+CbMfM4aNWFr/bbCAGB8/MUY+OpoAXRdoIMH0HJNQfFdgAiB3dJPD4r9r5KAI
         ltFp2MxU7YBIswDye+8wpkkPHtZQ8FanUpDRB147VauWdl6TJhyofnM/Soa0xrZ60+k5
         sBCDhQlOF31zA5IZtWDeneIF+812LoslQ2kjJIb2c/hJroeoXuWLCO4wM6rdkBzYh1YJ
         ut3Goqj664mI7MHN0tL9KNOJyU5olCrpEcBWHsVc3xWltedm1AxRt7MErv+j2O+764FU
         ZWmA==
X-Gm-Message-State: AOAM530Og2czQjSuX2KLNd2EdKjvujrNI6CCnqx3tOVCCQ3s+TuMWhyi
        v4oRxq0N7srYN2FsXnNPufOjsA==
X-Google-Smtp-Source: ABdhPJzrAKTQ3oQY2TuoRFynK4IDJfhLQxZHp4uyOoNvyae1N/FoJZmE84M12azNMiy9xnjVG7y7oQ==
X-Received: by 2002:a65:530d:: with SMTP id m13mr4089830pgq.128.1635440173488;
        Thu, 28 Oct 2021 09:56:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w7sm4316774pfu.147.2021.10.28.09.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:56:13 -0700 (PDT)
Date:   Thu, 28 Oct 2021 09:56:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrea Righi <andrea.righi@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: selftests: seccomp_bpf failure on 5.15
Message-ID: <202110280955.B18CB67@keescook>
References: <YXrN+Hnl9pSOsWlA@arighi-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXrN+Hnl9pSOsWlA@arighi-desktop>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 28, 2021 at 06:21:12PM +0200, Andrea Righi wrote:
> The following sub-tests are failing in seccomp_bpf selftest:
> 
> 18:56:54 DEBUG| [stdout] # selftests: seccomp: seccomp_bpf
> ...
> 18:56:57 DEBUG| [stdout] # #  RUN           TRACE_syscall.ptrace.kill_after ...
> 18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:2023:kill_after:Expected entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY : PTRACE_EVENTMSG_SYSCALL_EXIT (1) == msg (0)
> 18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:2023:kill_after:Expected entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY : PTRACE_EVENTMSG_SYSCALL_EXIT (2) == msg (1)
> 18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:2023:kill_after:Expected entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY : PTRACE_EVENTMSG_SYSCALL_EXIT (1) == msg (2)
> 18:56:57 DEBUG| [stdout] # # kill_after: Test exited normally instead of by signal (code: 12)
> 18:56:57 DEBUG| [stdout] # #          FAIL  TRACE_syscall.ptrace.kill_after
> ...
> 18:56:57 DEBUG| [stdout] # #  RUN           TRACE_syscall.seccomp.kill_after ...
> 18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:1547:kill_after:Expected !ptrace_syscall (1) == IS_SECCOMP_EVENT(status) (0)
> 18:56:57 DEBUG| [stdout] # # kill_after: Test exited normally instead of by signal (code: 0)
> 18:56:57 DEBUG| [stdout] # #          FAIL  TRACE_syscall.seccomp.kill_after
> 18:56:57 DEBUG| [stdout] # not ok 80 TRACE_syscall.seccomp.kill_after
> ...
> 18:56:57 DEBUG| [stdout] # # FAILED: 85 / 87 tests passed.
> 18:56:57 DEBUG| [stdout] # # Totals: pass:85 fail:2 xfail:0 xpass:0 skip:0 error:0
> 18:56:57 DEBUG| [stdout] not ok 1 selftests: seccomp: seccomp_bpf # exit=1
> 
> I did some bisecting and found that the failures started to happen with:
> 
>  307d522f5eb8 ("signal/seccomp: Refactor seccomp signal and coredump generation")
> 
> Not sure if the test needs to be fixed after this commit, or if the
> commit is actually introducing an issue. I'll investigate more, unless
> someone knows already what's going on.

Ah thanks for noticing; I will investigate...

-- 
Kees Cook
