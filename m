Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB195A5712
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 00:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiH2WZa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 18:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiH2WZ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 18:25:29 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4397725299
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 15:25:28 -0700 (PDT)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSnCA-000DqI-48; Tue, 30 Aug 2022 00:25:26 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSnC9-0008mj-Ml; Tue, 30 Aug 2022 00:25:25 +0200
Subject: Re: [PATCH bpf-next 0/2] bpf,ftrace: bpf dispatcher function fix
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20220826184608.141475-1-jolsa@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9099057e-124c-8f30-c29d-54be85eeebfd@iogearbox.net>
Date:   Tue, 30 Aug 2022 00:25:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220826184608.141475-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26642/Mon Aug 29 09:54:26 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/26/22 8:46 PM, Jiri Olsa wrote:
> hi,
> as discussed [1] sending fix that moves bpf dispatcher function of out
> ftrace locations together with Peter's HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
> dependency change.

Looks like the series breaks s390x builds; BPF CI link:

https://github.com/kernel-patches/bpf/runs/8079411784?check_suite_focus=true

   [...]
     CC      net/xfrm/xfrm_state.o
     CC      net/packet/af_packet.o
   {standard input}: Assembler messages:
   {standard input}:16055: Error: bad expression
   {standard input}:16056: Error: bad expression
   {standard input}:16057: Error: bad expression
   {standard input}:16058: Error: bad expression
   {standard input}:16059: Error: bad expression
     CC      drivers/s390/char/raw3270.o
     CC      net/ipv6/ip6_output.o
   [...]
     CC      net/xfrm/xfrm_output.o
     CC      net/ipv6/ip6_input.o
   {standard input}:16055: Error: invalid operands (*ABS* and *UND* sections) for `%'
   {standard input}:16056: Error: invalid operands (*ABS* and *UND* sections) for `%'
   {standard input}:16057: Error: invalid operands (*ABS* and *UND* sections) for `%'
   {standard input}:16058: Error: invalid operands (*ABS* and *UND* sections) for `%'
   {standard input}:16059: Error: invalid operands (*ABS* and *UND* sections) for `%'
   make[3]: *** [scripts/Makefile.build:249: net/core/filter.o] Error 1
   make[2]: *** [scripts/Makefile.build:465: net/core] Error 2
   make[2]: *** Waiting for unfinished jobs....
     CC      net/ipv4/tcp_fastopen.o
   [...]
     CC      lib/percpu-refcount.o
   make[1]: *** [Makefile:1855: net] Error 2
     CC      lib/rhashtable.o
   make[1]: *** Waiting for unfinished jobs....
     CC      lib/base64.o
   [...]
     AR      lib/built-in.a
     CC      kernel/kheaders.o
     AR      kernel/built-in.a
   make: *** [Makefile:353: __build_one_by_one] Error 2
   Error: Process completed with exit code 2.

> [1] https://lore.kernel.org/bpf/20220722110811.124515-1-jolsa@kernel.org/
> ---
> Jiri Olsa (1):
>        bpf: Move bpf_dispatcher function out of ftrace locations
> 
> Peter Zijlstra (Intel) (1):
>        ftrace: Add HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
> 
>   arch/x86/Kconfig                  |  1 +
>   include/asm-generic/vmlinux.lds.h | 11 ++++++++++-
>   include/linux/bpf.h               |  2 ++
>   kernel/trace/Kconfig              |  6 ++++++
>   tools/objtool/check.c             |  3 ++-
>   5 files changed, 21 insertions(+), 2 deletions(-)
> 

