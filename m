Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3936D65419D
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 14:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiLVNSS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 08:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbiLVNRw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 08:17:52 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5263E2B620;
        Thu, 22 Dec 2022 05:17:45 -0800 (PST)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1p8LS0-000Jl4-Ab; Thu, 22 Dec 2022 14:17:32 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1p8LRz-000LrB-Kg; Thu, 22 Dec 2022 14:17:31 +0100
Subject: Re: [PATCH bpf-next 1/2] bpf/perf: Call perf_prepare_sample() before
 bpf_prog_run()
To:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20221220220144.4016213-1-namhyung@kernel.org>
 <20221220220144.4016213-2-namhyung@kernel.org>
 <Y6RTy29ULXp8WJ/Q@hirez.programming.kicks-ass.net>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2d164a5f-2885-2a6e-581a-2673ca0b1b81@iogearbox.net>
Date:   Thu, 22 Dec 2022 14:17:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <Y6RTy29ULXp8WJ/Q@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26758/Thu Dec 22 09:27:27 2022)
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/22/22 1:55 PM, Peter Zijlstra wrote:
> On Tue, Dec 20, 2022 at 02:01:43PM -0800, Namhyung Kim wrote:
>> When the BPF program calls bpf_cast_to_kern_ctx(), it assumes the program will
>> access perf sample data directly and call perf_prepare_sample() to make sure
>> the sample data is populated.
> 
> I don't understand a word of this :/ What are you doing and why?

Yeah, above commit message is too terse and unclear. Also, not following where
this assumption comes from; bpf_cast_to_kern_ctx() can be used elsewhere, too,
not just tracing. Recent example from CI side can be found [0].

Thanks,
Daniel

   [0] bpf tree, 70a00e2f1dba ("selftests/bpf: Test bpf_skb_adjust_room on CHECKSUM_PARTIAL")
