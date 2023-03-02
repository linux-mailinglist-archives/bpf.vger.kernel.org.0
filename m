Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BE06A7B9E
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 08:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCBHGf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 02:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjCBHGf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 02:06:35 -0500
Received: from out-32.mta0.migadu.com (out-32.mta0.migadu.com [IPv6:2001:41d0:1004:224b::20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AB238E99
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 23:06:33 -0800 (PST)
Message-ID: <1b5db179-7411-2f38-9ecf-344cde0848a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677740792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uteejWgZYleZ1XMtA6PRoegkXPoob6xe2BF01mtutaU=;
        b=swTPNnUkFUgl6keyyJDMfXQiwpmZ4eNtNO66qP3I2xQKEDBse8/sSH68ZjC9Qv+m7qd7+U
        NXq6kICvYW4VOm5EpxvcYdR673H97KIcYzfEMDq+ClTu8O3heMYGESHQOvqG4U/xxwrXDY
        HXNdTVNRSUXyrChz0Eg2oD0yN7qb0Pg=
Date:   Wed, 1 Mar 2023 23:06:27 -0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 3/3] selftests/bpf: Add tests for
 bpf_sock_destroy
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     kafai@fb.com, Stanislav Fomichev <sdf@google.com>,
        edumazet@google.com, bpf@vger.kernel.org
References: <20230223215311.926899-1-aditi.ghag@isovalent.com>
 <20230223215311.926899-4-aditi.ghag@isovalent.com>
 <2552f727-57f3-0d76-c0da-f6543a93a45f@linux.dev>
 <F6E6FEAD-5003-44BE-AA76-6CDAE40A0A71@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <F6E6FEAD-5003-44BE-AA76-6CDAE40A0A71@isovalent.com>
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

On 2/28/23 6:17 PM, Aditi Ghag wrote:
> 
> 
>> On Feb 28, 2023, at 3:08 PM, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 2/23/23 1:53 PM, Aditi Ghag wrote:
>>> The test cases for TCP and UDP iterators mirror the intended usages of the
>>> helper.
>>> The destroy helpers set `ECONNABORTED` error code that we can validate in the
>>> test code with client sockets. But UDP sockets have an overriding error code
>>> from the disconnect called during abort, so the error code the validation is
>>> only done for TCP sockets.
>>> The `struct sock` is redefined as vmlinux.h forward declares the struct, and the
>>> loader fails to load the program as it finds the BTF FWD type for the struct
>>> incompatible with the BTF STRUCT type.
>>> Here are the snippets of the verifier error, and corresponding BTF output:
>>> ```
>>> verifier error: extern (func ksym) ...: func_proto ... incompatible with kernel
>>> BTF for selftest prog binary:
>>> [104] FWD 'sock' fwd_kind=struct
>>> [70] PTR '(anon)' type_id=104
>>> [84] FUNC_PROTO '(anon)' ret_type_id=2 vlen=1
>>> 	'(anon)' type_id=70
>>> [85] FUNC 'bpf_sock_destroy' type_id=84 linkage=extern
>>> --
>>> [96] DATASEC '.ksyms' size=0 vlen=1
>>> 	type_id=85 offset=0 size=0 (FUNC 'bpf_sock_destroy')
>>> BTF for selftest vmlinux:
>>> [74923] FUNC 'bpf_sock_destroy' type_id=48965 linkage=static
>>> [48965] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
>>> 	'sk' type_id=1340
>>> [1340] PTR '(anon)' type_id=2363
>>> [2363] STRUCT 'sock' size=1280 vlen=93
>>> ```
>>
>>> +int bpf_sock_destroy(struct sock_common *sk) __ksym;
>>
>> This does not match the bpf prog's BTF dump above which has pointer [70] pointing to FWD 'sock' [104] as the argument. It should be at least FWD 'sock_common' if not STRUCT 'sock_common'. I tried to change the func signature to 'struct sock *sk' but cannot reproduce the issue in my environment also.
>>
>> Could you confirm the BTF paste and 'incompatible with kernel" error in the commit message do match the bpf_sock_destroy declaration? If not, can you re-paste the BTF output and libbpf error message that matches the bpf_sock_destroy signature.
> 
> I don't think you'll be able to reproduce the issue with `sock_common`, as `struct sock_common` isn't forward declared in vmlinux.h. But I find it odd that you weren't able to reproduce it with `struct sock`. Just to confirm, did you remove the minimal `struct sock` definition from the program? Per the commit description, I added that because libbpf was throwing this error -
> `libbpf: extern (func ksym) 'bpf_sock_destroy': func_proto [83] incompatible with kernel [75285]`

Yep, I changed the kfunc to 'struct sock *' and removed the define/undef dance.

> 
> Sending the BTF snippet again (full BTF - https://pastebin.com/etkFyuJk)
> 
> ```
> 85] FUNC 'bpf_sock_destroy' type_id=84 linkage=extern
> 	type_id=85 offset=0 size=0 (FUNC 'bpf_sock_destroy')
> [84] FUNC_PROTO '(anon)' ret_type_id=2 vlen=1
> 	'(anon)' type_id=70
> [70] PTR '(anon)' type_id=104
> [104] FWD 'sock' fwd_kind=struct
> ```
> 
> Compare this to the BTF snippet once I undef and define the struct in the test prog:
> 
> ```
> [87] FUNC 'bpf_sock_destroy' type_id=84 linkage=extern
> 	type_id=87 offset=0 size=0 (FUNC 'bpf_sock_destroy')
> [84] FUNC_PROTO '(anon)' ret_type_id=2 vlen=1
> 	'(anon)' type_id=85
> [85] PTR '(anon)' type_id=86
> [86] STRUCT 'sock' size=136 vlen=1
> 	'__sk_common' type_id=34 bits_offset=0
> ```
> 
> (Anyway looks like I needed to define the struct in the test prog only when bpf_sock_destory had `struct sock` as the argument.)

Right, I also think it is orthogonal to your set if the kfunc is taking 'struct 
sock_common *' anyway. [although I do feel a kernel function taking a 'struct 
sock_common *' is rather odd]

I was only asking and also trying myself because it looks pretty wrong if it can 
be reproduced and it is something that should be fixed regardless. It is pretty 
normal to have forward declaration within a bpf prog itself (not from 
vmlinux.h). From the paste, it feels like the kfunc bpf_sock_destroy btf is 
generated earlier than the 'struct sock'. Which llvm version are you using?
