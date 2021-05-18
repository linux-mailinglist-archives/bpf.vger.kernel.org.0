Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165753880D4
	for <lists+bpf@lfdr.de>; Tue, 18 May 2021 21:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347729AbhERTz7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 May 2021 15:55:59 -0400
Received: from www62.your-server.de ([213.133.104.62]:53646 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245553AbhERTz6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 May 2021 15:55:58 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lj5nU-0006tq-59; Tue, 18 May 2021 21:54:32 +0200
Received: from [85.7.101.30] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lj5nT-0008vg-Vh; Tue, 18 May 2021 21:54:32 +0200
Subject: Re: [PATCH v6 bpf-next 00/21] bpf: syscall program, FD array, loader
 program, light skeleton.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
Cc:     andrii@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
        kernel-team@fb.com
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4a843738-4eb1-d993-6b64-7f36144d2456@iogearbox.net>
Date:   Tue, 18 May 2021 21:54:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26174/Tue May 18 13:09:02 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/14/21 2:36 AM, Alexei Starovoitov wrote:
[...]
> This is a first step towards signed bpf programs and the third approach of that kind.
> The first approach was to bring libbpf into the kernel as a user-mode-driver.
> The second approach was to invent a new file format and let kernel execute
> that format as a sequence of syscalls that create maps and load programs.
> This third approach is using new type of bpf program instead of inventing file format.
> 1st and 2nd approaches had too many downsides comparing to this 3rd and were discarded
> after months of work.
> 
> To make it work the following new concepts are introduced:
> 1. syscall bpf program type
> A kind of bpf program that can do sys_bpf and sys_close syscalls.
> It can only execute in user context.
> 
> 2. FD array or FD index.
> Traditionally BPF instructions are patched with FDs.
> What it means that maps has to be created first and then instructions modified
> which breaks signature verification if the program is signed.
> Instead of patching each instruction with FD patch it with an index into array of FDs.
> That makes the program signature stable if it uses maps.
> 
> 3. loader program that is generated as "strace of libbpf".
> When libbpf is loading bpf_file.o it does a bunch of sys_bpf() syscalls to
> load BTF, create maps, populate maps and finally load programs.
> Instead of actually doing the syscalls generate a trace of what libbpf
> would have done and represent it as the "loader program".
> The "loader program" consists of single map and single bpf program that
> does those syscalls.
> Executing such "loader program" via bpf_prog_test_run() command will
> replay the sequence of syscalls that libbpf would have done which will result
> the same maps created and programs loaded as specified in the elf file.
> The "loader program" removes libelf and majority of libbpf dependency from
> program loading process.

More of a general question since afaik from prior discussion it didn't came up.
I think conceptually, it's rather weird to only being able to execute the loader
program which is later also supposed to do signing through the BPF_PROG_TEST_RUN
aka our _testing_ infrastructure. Given it's not mentioned in future steps, is
there anything planned before it becomes uapi and fixed part of skeleton (in
particular the libbpf bpf_load_and_run() helper officially calling into the
skel_sys_bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr))) on this regard or is the
BPF_PROG_TEST_RUN really supposed to be the /main/ interface going forward;
what's the plan on this?

> 4. light skeleton
> Instead of embedding the whole elf file into skeleton and using libbpf
> to parse it later generate a loader program and embed it into "light skeleton".
> Such skeleton can load the same set of elf files, but it doesn't need
> libbpf and libelf to do that. It only needs few sys_bpf wrappers.
> 
> Future steps:
> - support CO-RE in the kernel. This patch set is already too big,
> so that critical feature is left for the next step.
> - generate light skeleton in golang to allow such users use BTF and
> all other features provided by libbpf
> - generate light skeleton for kernel, so that bpf programs can be embeded
> in the kernel module. The UMD usage in bpf_preload will be replaced with
> such skeleton, so bpf_preload would become a standard kernel module
> without user space dependency.
> - finally do the signing of the loader program.
> 
> The patches are work in progress with few rough edges.

Thanks a lot,
Daniel
