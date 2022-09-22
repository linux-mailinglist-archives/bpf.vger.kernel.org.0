Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9305E6A3D
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 20:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiIVSB5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 14:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiIVSBj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 14:01:39 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26B0DE87;
        Thu, 22 Sep 2022 11:01:34 -0700 (PDT)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1obQVj-0004Vk-0x; Thu, 22 Sep 2022 20:01:19 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1obQVi-000Ov5-9d; Thu, 22 Sep 2022 20:01:18 +0200
Subject: Re: [PATCH bpf-next v2 0/4] Add ftrace direct call for arm64
To:     Xu Kuohai <xukuohai@huaweicloud.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20220913162732.163631-1-xukuohai@huaweicloud.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f1e14934-dc54-9bf7-501a-89affdb7371e@iogearbox.net>
Date:   Thu, 22 Sep 2022 20:01:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220913162732.163631-1-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26666/Thu Sep 22 09:54:12 2022)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/13/22 6:27 PM, Xu Kuohai wrote:
> This series adds ftrace direct call for arm64, which is required to attach
> bpf trampoline to fentry.
> 
> Although there is no agreement on how to support ftrace direct call on arm64,
> no patch has been posted except the one I posted in [1], so this series
> continues the work of [1] with the addition of long jump support. Now ftrace
> direct call works regardless of the distance between the callsite and custom
> trampoline.
> 
> [1] https://lore.kernel.org/bpf/20220518131638.3401509-2-xukuohai@huawei.com/
> 
> v2:
> - Fix compile and runtime errors caused by ftrace_rec_arch_init
> 
> v1: https://lore.kernel.org/bpf/20220913063146.74750-1-xukuohai@huaweicloud.com/
> 
> Xu Kuohai (4):
>    ftrace: Allow users to disable ftrace direct call
>    arm64: ftrace: Support long jump for ftrace direct call
>    arm64: ftrace: Add ftrace direct call support
>    ftrace: Fix dead loop caused by direct call in ftrace selftest

Given there's just a tiny fraction touching BPF JIT and most are around core arm64,
it probably makes sense that this series goes via Catalin/Will through arm64 tree
instead of bpf-next if it looks good to them. Catalin/Will, thoughts (Ack + bpf-next
could work too, but I'd presume this just results in merge conflicts)?

>   arch/arm64/Kconfig                |   2 +
>   arch/arm64/Makefile               |   4 +
>   arch/arm64/include/asm/ftrace.h   |  35 ++++--
>   arch/arm64/include/asm/patching.h |   2 +
>   arch/arm64/include/asm/ptrace.h   |   6 +-
>   arch/arm64/kernel/asm-offsets.c   |   1 +
>   arch/arm64/kernel/entry-ftrace.S  |  39 ++++--
>   arch/arm64/kernel/ftrace.c        | 198 ++++++++++++++++++++++++++++--
>   arch/arm64/kernel/patching.c      |  14 +++
>   arch/arm64/net/bpf_jit_comp.c     |   4 +
>   include/linux/ftrace.h            |   2 +
>   kernel/trace/Kconfig              |   7 +-
>   kernel/trace/ftrace.c             |   9 +-
>   kernel/trace/trace_selftest.c     |   2 +
>   14 files changed, 296 insertions(+), 29 deletions(-)

Thanks,
Daniel
