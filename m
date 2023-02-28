Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEDD6A63AC
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 00:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjB1XJA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 18:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjB1XI7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 18:08:59 -0500
Received: from out-49.mta1.migadu.com (out-49.mta1.migadu.com [IPv6:2001:41d0:203:375::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF52A5D5
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 15:08:57 -0800 (PST)
Message-ID: <2552f727-57f3-0d76-c0da-f6543a93a45f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677625735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bB8qNUxwJKxVwKoeaNpLfEwQ8qBBCMC6hTvUqi5phLE=;
        b=VuE/6zKjpYtqtT6FJcGDAf0qw7X67t3r36oAogjXpJ1st9v9pPZrVOpdMVxYUwnXBjVH92
        KXqan+UDsFv6vBxGWE9lDd8WF0rl7mDv0s7cCDO67vOK8vVwTcoqXcsTc6v896k5pO9s7s
        /tUu5BxZsNTymBW+dx7aamhpkl3ftUY=
Date:   Tue, 28 Feb 2023 15:08:53 -0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 3/3] selftests/bpf: Add tests for
 bpf_sock_destroy
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        bpf@vger.kernel.org
References: <20230223215311.926899-1-aditi.ghag@isovalent.com>
 <20230223215311.926899-4-aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230223215311.926899-4-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/23/23 1:53 PM, Aditi Ghag wrote:
> The test cases for TCP and UDP iterators mirror the intended usages of the
> helper.
> 
> The destroy helpers set `ECONNABORTED` error code that we can validate in the
> test code with client sockets. But UDP sockets have an overriding error code
> from the disconnect called during abort, so the error code the validation is
> only done for TCP sockets.
> 
> The `struct sock` is redefined as vmlinux.h forward declares the struct, and the
> loader fails to load the program as it finds the BTF FWD type for the struct
> incompatible with the BTF STRUCT type.
> 
> Here are the snippets of the verifier error, and corresponding BTF output:
> 
> ```
> verifier error: extern (func ksym) ...: func_proto ... incompatible with kernel
> 
> BTF for selftest prog binary:
> 
> [104] FWD 'sock' fwd_kind=struct
> [70] PTR '(anon)' type_id=104
> [84] FUNC_PROTO '(anon)' ret_type_id=2 vlen=1
> 	'(anon)' type_id=70
> [85] FUNC 'bpf_sock_destroy' type_id=84 linkage=extern
> --
> [96] DATASEC '.ksyms' size=0 vlen=1
> 	type_id=85 offset=0 size=0 (FUNC 'bpf_sock_destroy')
> 
> BTF for selftest vmlinux:
> 
> [74923] FUNC 'bpf_sock_destroy' type_id=48965 linkage=static
> [48965] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
> 	'sk' type_id=1340
> [1340] PTR '(anon)' type_id=2363
> [2363] STRUCT 'sock' size=1280 vlen=93
> ```

> +int bpf_sock_destroy(struct sock_common *sk) __ksym;

This does not match the bpf prog's BTF dump above which has pointer [70] 
pointing to FWD 'sock' [104] as the argument. It should be at least FWD 
'sock_common' if not STRUCT 'sock_common'. I tried to change the func signature 
to 'struct sock *sk' but cannot reproduce the issue in my environment also.

Could you confirm the BTF paste and 'incompatible with kernel" error in the 
commit message do match the bpf_sock_destroy declaration? If not, can you 
re-paste the BTF output and libbpf error message that matches the 
bpf_sock_destroy signature.

