Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DDD1EB3C5
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 05:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgFBDYv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jun 2020 23:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgFBDYv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 23:24:51 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A992C061A0E;
        Mon,  1 Jun 2020 20:24:50 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh7so755448plb.11;
        Mon, 01 Jun 2020 20:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xtA89vSoLXrR3EqwNK+slVMqyW44HEs7M81ih+4XU2g=;
        b=PnDsPzBnGYjvLPdvsHprobnzeI+cvN2ogP1SrZBhh1HDL01xNYE1cNxga+Dbmhj9Eu
         l0jlzKqxbMeyR7v4mciOECS1BB7MQmmjocg1/PbAobhyXyfTe3VE/unAZiQAkM5mZd9h
         SstoxEi/+Tt42L9PIzpOkRJUvPH54Um8aXO7HjEciFb4CNEQdBW72lgqrWIMYv0yq0cl
         ervR6lGqKgI8P/ju34tIr/eM3TPOmgnLI0ARERlBgoyhmosnetKjVOyCGsjsW6wdGeK9
         YSzW8bXUbTJZwe0LW77eBci5Pg/J8+UEXSOODBSjrX9ysQkRZ2Lvex4nsAmJhEbaP4e4
         Vj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xtA89vSoLXrR3EqwNK+slVMqyW44HEs7M81ih+4XU2g=;
        b=biqdxJK1bEMzRswxYGK1Mi+hG9P3pZdB/54kvMwxwbtALxQlZFqyZhPsfcfhQ4v2L5
         rdeqBj1Jvpi584HtKmmXcjyoxtILSoLejl55WJz2s9UvUygZwL39jl4d+UZiI1u6g/L6
         T6GTdfcJ76uJvAiFbBPqthkjq389vj9j6Qj6FIP8ju1jEwRZZcI7Sv4sZcoUvfmoCxU1
         fIinYt7vL8cFo3mPlRAHCTw5+wYX4o5dTBhNuR4ndAlOplcg2cnIROI/KIC1ioR41If5
         X08ynAZdBUSoxW07B0C5z9UcymAtmPfE36PSWaxuJUJUndaRXM/DaLsn5Lrziet6Jplf
         lzRg==
X-Gm-Message-State: AOAM532DmnjAuLp8iyIi7K6MPpMKXVlaJ6vjncTvE9/ZtzNVS5D69tyJ
        NzZZLpkbVIVbRAPh8UQqQtA=
X-Google-Smtp-Source: ABdhPJzwRIleqcYfI8lizUYUTrlCNzXwmY26tdj8PBzOLqs1OdEH4M86L2OX9ng7+DeCaFlHBn6Nhw==
X-Received: by 2002:a17:90a:df82:: with SMTP id p2mr2931454pjv.217.1591068289634;
        Mon, 01 Jun 2020 20:24:49 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:514a])
        by smtp.gmail.com with ESMTPSA id y22sm747420pfc.132.2020.06.01.20.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 20:24:48 -0700 (PDT)
Date:   Mon, 1 Jun 2020 20:24:46 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "zhujianwei (C)" <zhujianwei7@huawei.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>,
        Lennart Poettering <lennart@poettering.net>,
        Christian Ehrhardt <christian.ehrhardt@canonical.com>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= new seccomp mode aims to
 improve performance
Message-ID: <20200602032446.7sn2fmzsea2v2wbs@ast-mbp.dhcp.thefacebook.com>
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
 <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
 <202005290903.11E67AB0FD@keescook>
 <202005291043.A63D910A8@keescook>
 <ff10225b79a14fec9bc383e710d74b2e@huawei.com>
 <CAADnVQK2WEh980KMkXy9TNeDqKA-fDMxkojPYf=b5eJSgG=K0g@mail.gmail.com>
 <7dacac003a9949ea8163fca5125a2cae@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7dacac003a9949ea8163fca5125a2cae@huawei.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 02, 2020 at 02:42:35AM +0000, zhujianwei (C) wrote:
> >
> > This is the test result on linux 5.7.0-rc7 for aarch64.
> > And retpoline disabled default.
> > #cat /sys/devices/system/cpu/vulnerabilities/spectre_v2
> > Not affected
> >
> > bpf_jit_enable 1
> > bpf_jit_harden 0
> >
> > We run unixbench syscall benchmark on the original kernel and the new one(replace bpf_prog_run_pin_on_cpu() with immediately returning 'allow' one).
> > The unixbench syscall testcase runs 5 system calls（close/umask/dup/getpid/getuid, extra 15 syscalls needed to run it） in a loop for 10 seconds, counts the number and finally output it. We also add some more filters (each with the same rules) to evaluate the situation just like kees mentioned(case like systemd-resolve), and we find it is right: more filters, more overhead. The following is our result (./syscall 10 m):
> >
> > original:
> >         seccomp_off:                    10684939
> >         seccomp_on_1_filters:   8513805         overhead：19.8%
> >         seccomp_on_4_filters:   7105592         overhead：33.0%
> >         seccomp_on_32_filters:  2308677         overhead：78.3%
> >
> > after replacing bpf_prog_run_pin_on_cpu:
> >         seccomp_off:                    10685244
> >         seccomp_on_1_filters:   9146483         overhead：14.1%
> >         seccomp_on_4_filters:   8969886         overhead：16.0%
> >         seccomp_on_32_filters:  6454372         overhead：39.6%
> >
> > N-filter bpf overhead:
> >         1_filters:              5.7%
> >         4_filters:              17.0%
> >         32_filters:     38.7%
> >
> > // kernel code modification place
> > static noinline u32 bpf_prog_run_pin_on_cpu_allow(const struct 
> > bpf_prog *prog, const void *ctx) {
> >         return SECCOMP_RET_ALLOW;
> > }
> 
> >This is apples to oranges.
> >As explained earlier:
> >https://lore.kernel.org/netdev/20200531171915.wsxvdjeetmhpsdv2@ast-mbp.dhcp.thefacebook.com/T/#u
> >Please use __weak instead of static and redo the numbers.
> 
> 
> we have replaced ‘static’ with ‘__weak’, tested with the same way, and got almostly the same result, in our test environment(aarch64).
> 
> -static noinline u32 bpf_prog_run_pin_on_cpu_allow(const struct bpf_prog *prog, const void *ctx)
> +__weak noinline u32 bpf_prog_run_pin_on_cpu_allow(const struct bpf_prog *prog, const void *ctx)
> 
> original:
> 	seccomp_off:			10684939
> 	seccomp_on_1_filters:	8513805		overhead：19.8%
> 	seccomp_on_4_filters:	7105592		overhead：33.0%
> 	seccomp_on_32_filters:	2308677		overhead：78.3%
> 	
> after replacing bpf_prog_run_pin_on_cpu:
> 	seccomp_off:			10667195
> 	seccomp_on_1_filters:	9147454		overhead：14.2%
> 	seccomp_on_4_filters:	8927605		overhead：16.1%
> 	seccomp_on_32_filters:	6355476		overhead：40.6%

are you saying that by replacing 'static' with '__weak' it got slower?!
Something doesn't add up. Please check generated assembly.
By having such 'static noinline bpf_prog_run_pin_on_cpu' you're telling
compiler to remove most of seccomp_run_filters() code which now will
return only two possible values. Which further means that large 'switch'
statement in __seccomp_filter() is also optimized. populate_seccomp_data()
is removed. Etc, etc. That explains 14% vs 19% difference.
May be you have some debug on? Like cant_migrate() is not a nop?
Or static_branch is not supported?
The sure way is to check assembly.
