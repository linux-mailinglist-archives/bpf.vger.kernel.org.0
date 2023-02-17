Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2646A69B407
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 21:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjBQUhI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 15:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBQUhI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 15:37:08 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C58D60A43
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 12:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=npOgItJ5NYWzMNY+MdDzmrvhz++FUDW/QzOOZSLC0kc=; b=Q75ul55bJGDSHPOQpSvwcOVK3n
        qt9Y10CvwBAEiH+Yxpe1whBrcxqDtOHSoYsetTOmBWFFdlOp4J9jyfIGySdedWOqkMOY4lMkBbOTP
        iI7HbWxCCJVkWCDc1kcHRH9Gl5N6K3bCpe1NqfO1GokVpmv+xo+vD5dijMjAOd8JvNx8puZWoFheQ
        znImt+qDQkxbwyWez9F/YIMjbl0w4eEeAOqEvudUMYiUuZQLwAzcO8MCN2OjX88WNUJ5ZEEQFjwkX
        stZWlNpc1+pzsLjBMO1sFOh10aBQyJsQZ9IXeIEhYVTPDWDgRonpum2VGZEwIzi7Rb64KGh4UiISB
        HDBONfgA==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pT7Tc-000DoR-Tw; Fri, 17 Feb 2023 21:37:04 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pT7Tc-000FYU-KM; Fri, 17 Feb 2023 21:37:04 +0100
Subject: Re: [PATCH bpf-next 0/2] Allow reads from uninit stack
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
References: <20230216183606.2483834-1-eddyz87@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <98d4936a-27de-95b3-d787-40b78654916d@iogearbox.net>
Date:   Fri, 17 Feb 2023 21:37:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230216183606.2483834-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26815/Fri Feb 17 09:41:01 2023)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/16/23 7:36 PM, Eduard Zingerman wrote:
> This patch-set modifies BPF verifier to accept programs that read from
> uninitialized stack locations, but only if executed in privileged mode.
> This provides significant verification performance gains: 30% to 70% less
> processed states for big number of test programs.
> 
> The reason for performance gains comes from treating STACK_MISC and
> STACK_INVALID as compatible, when cached state is compared to current state
> in verifier.c:stacksafe().
> 
> The change should not affect safety, because any value read from STACK_MISC
> location has full binary range (e.g. 0x00-0xff for byte-sized reads).
> 
> Details and measurements are provided in the description for the patch #1.
> 
> The change was suggested by Andrii Nakryiko, the initial patch was created
> by Alexei Starovoitov. The discussion could be found at [1].
> 
> [1] https://lore.kernel.org/bpf/CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com/

Ptal, looks like BPF CI is complaining:

https://github.com/kernel-patches/bpf/actions/runs/4205832876/jobs/7298488977

   [...]
     GEN-SKEL [test_progs] bpf_mod_race.skel.h
     GEN-SKEL [test_progs] trace_dummy_st_ops.skel.h
   libbpf: sec 'socket': corrupted program 'read_uninit_stack_fixed_off', offset 0, size 0
   Error: failed to open BPF object file: Invalid argument
     GEN-SKEL [test_progs] test_raw_tp_test_run.skel.h
   make: *** [Makefile:578: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/uninit_stack.skel.h] Error 234
   make: *** Deleting file '/tmp/work/bpf/bpf/tools/testing/selftests/bpf/uninit_stack.skel.h'
   make: *** Waiting for unfinished jobs....
   make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
   Error: Process completed with exit code 2.
