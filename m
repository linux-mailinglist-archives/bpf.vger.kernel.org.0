Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7C35EC47C
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 15:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiI0NcB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 09:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbiI0Nbd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 09:31:33 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFA91B14D5
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 06:28:12 -0700 (PDT)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1odAd8-000Dun-94; Tue, 27 Sep 2022 15:28:10 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1odAd8-000U6m-0q; Tue, 27 Sep 2022 15:28:10 +0200
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: enforce C++11 mode for
 test_cpp test
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     kernel-team@fb.com,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>
References: <20220927042940.147185-1-andrii@kernel.org>
 <20220927042940.147185-2-andrii@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e4ec9070-cbbc-54be-3bc9-efe53768b7fd@iogearbox.net>
Date:   Tue, 27 Sep 2022 15:28:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220927042940.147185-2-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26671/Tue Sep 27 09:56:57 2022)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/27/22 6:29 AM, Andrii Nakryiko wrote:
> Setting -std=c++11 seems to catch more potential C++-only problems. Also
> BPF skeleton isn't rely compilable with any older standard due to the
> use of nullptr.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   tools/testing/selftests/bpf/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index e6cf21fad69f..d52069c70e49 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -570,7 +570,7 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
>   # Make sure we are able to include and link libbpf against c++.
>   $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
>   	$(call msg,CXX,,$@)
> -	$(Q)$(CXX) $(CFLAGS) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
> +	$(Q)$(CXX) $(CFLAGS) -std=c++11 $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
>   
>   # Benchmark runner
>   $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
> 

Seems CI triggers build error (https://github.com/kernel-patches/bpf/actions/runs/3133037577/jobs/5085992832) :

     [...]
     GEN-SKEL [test_progs] pyperf180.skel.h
     GEN-SKEL [test_progs] pyperf600.skel.h
     GEN-SKEL [test_progs-no_alu32] pyperf180.skel.h
     GEN-SKEL [test_progs-no_alu32] pyperf600.skel.h
     BINARY   bench
   In file included from test_cpp.cpp:9:
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/test_core_extern.skel.h:45:3: error: unknown type name '_Bool'
                   _Bool CONFIG_BOOL;
                   ^
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/test_core_extern.skel.h:46:3: error: unknown type name '_Bool'
                   _Bool CONFIG_BPF_SYSCALL;
                   ^
   2 errors generated.
   make: *** [Makefile:573: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/test_cpp] Error 1
   make: *** Waiting for unfinished jobs....
   make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
   Error: Process completed with exit code 2.

Thanks,
Daniel
