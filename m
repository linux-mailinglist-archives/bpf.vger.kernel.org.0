Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECB65A4F9E
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 16:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiH2Ou3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 10:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiH2Ou3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 10:50:29 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C86B72ED4
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 07:50:25 -0700 (PDT)
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSg5m-00010j-HI; Mon, 29 Aug 2022 16:50:22 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oSg5m-000SFR-9c; Mon, 29 Aug 2022 16:50:22 +0200
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add veristat tool for
 mass-verifying BPF object files
To:     KP Singh <kpsingh@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, kernel-team@fb.com
References: <20220826231531.1031943-1-andrii@kernel.org>
 <20220826231531.1031943-4-andrii@kernel.org>
 <CACYkzJ7dNQe58g58qUBQJ3kP86o-vvLoFw+e9_hgH-Ltb9ZAHQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a7cae4ad-be07-893f-3923-a64d7fc20cc7@iogearbox.net>
Date:   Mon, 29 Aug 2022 16:50:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACYkzJ7dNQe58g58qUBQJ3kP86o-vvLoFw+e9_hgH-Ltb9ZAHQ@mail.gmail.com>
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

On 8/28/22 1:53 AM, KP Singh wrote:
> On Sat, Aug 27, 2022 at 1:15 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>>
>> Add a small tool, veristat, that allows mass-verification of
>> a set of *libbpf-compatible* BPF ELF object files. For each such object
>> file, veristat will attempt to verify each BPF program *individually*.
>> Regardless of success or failure, it parses BPF verifier stats and
>> outputs them in human-readable table format. In the future we can also
>> add CSV and JSON output for more scriptable post-processing, if necessary.
>>
>> veristat allows to specify a set of stats that should be output and
>> ordering between multiple objects and files (e.g., so that one can
>> easily order by total instructions processed, instead of default file
>> name, prog name, verdict, total instructions order).
>>
>> This tool should be useful for validating various BPF verifier changes
>> or even validating different kernel versions for regressions.
> 
> Cool stuff!

+1, out of curiosity, did you try with different kernels to see the deltas?

> I think this would be useful for cases beyond these (i.e. for users to get
> stats about the verifier in general) and it's worth thinking if this should
> be built into bpftool?
> 
>>
>> Here's an example for some of the heaviest selftests/bpf BPF object
>> files:
>>
>>    $ sudo ./veristat -s insns,file,prog {pyperf,loop,test_verif_scale,strobemeta,test_cls_redirect,profiler}*.linked3.o
>>    File                                  Program                               Verdict  Duration, us  Total insns  Total states  Peak states
>>    ------------------------------------  ------------------------------------  -------  ------------  -----------  ------------  -----------
>>    loop3.linked3.o                       while_true                            failure        350990      1000001          9663         9663
> 
> [...]

nit: Looks like CI on gcc is bailing:

https://github.com/kernel-patches/bpf/runs/8072477251?check_suite_focus=true

[...]
     INSTALL /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/skel_internal.h
   In file included from /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/libbpf.h:20,
     INSTALL /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/libbpf_version.h
                    from veristat.c:17:
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/libbpf_common.h:13:10: fatal error: libbpf_version.h: No such file or directory
      13 | #include "libbpf_version.h"
         |          ^~~~~~~~~~~~~~~~~~
   compilation terminated.
     INSTALL /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/include/bpf/usdt.bpf.h
     HOSTCC  /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/libbpf/fixdep.o
   make: *** [Makefile:165: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/veristat.o] Error 1
   make: *** Waiting for unfinished jobs....

I wonder, to detect regressions in pruning behavior, could we add a test_progs subtest to load
selected obj files and compare before/after 'verified insns' numbers? The workflow probably
makes this a bit hard to run with a kernel before this change, but maybe it could be a starting
point where we have a checked-in file containing current numbers, and e.g. if the new change
crosses a threshold of current +10% then the test could fail?

Thanks,
Daniel
