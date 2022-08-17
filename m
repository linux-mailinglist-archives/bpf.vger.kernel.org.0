Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F82759793A
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 23:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242364AbiHQVtr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 17:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242425AbiHQVtZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 17:49:25 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8DBAE216
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:49:01 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oOQuJ-0006lb-3s; Wed, 17 Aug 2022 23:48:59 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oOQuI-000RP8-Tp; Wed, 17 Aug 2022 23:48:58 +0200
Subject: Re: [PATCH bpf-next] bpf: Sync include/uapi/linux/bpf.h with
 tools/include/uapi/linux/bpf.h
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20220817010504.4072757-1-davemarchevsky@fb.com>
 <22aebc88-da67-f086-e620-dd4a16e2bc69@iogearbox.net>
Message-ID: <dbe69cc8-30d7-7cfb-9652-f0763dfd1c01@iogearbox.net>
Date:   Wed, 17 Aug 2022 23:48:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <22aebc88-da67-f086-e620-dd4a16e2bc69@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26630/Wed Aug 17 09:53:39 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/17/22 11:21 PM, Daniel Borkmann wrote:
> [ +Gustavo ]
> 
> On 8/17/22 3:05 AM, Dave Marchevsky wrote:
>> Commit 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays with
>> flexible-array members") modified bpf_lpm_trie_key struct's data member
>> in include/uapi/linux/bpf.h, but didn't make the same change in tools
>> dir's copy. Propagate it over and fix comment indentation as well.
>>
>> This is a nonfunctional change.
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> 
> Gustavo, 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays with flexible-array members")
> breaks BPF when copied from include/uapi/linux/bpf.h to tools/include/uapi/linux/bpf.h :
> 
> CI: https://github.com/kernel-patches/bpf/runs/7885234999?check_suite_focus=true
> 
>    [...]
>      CLNG-BPF [test_maps] map_ptr_kern.o
>      CLNG-BPF [test_maps] btf__core_reloc_arrays___diff_arr_val_sz.o
>      CLNG-BPF [test_maps] test_bpf_cookie.o
>    progs/map_ptr_kern.c:314:26: error: field 'trie_key' with variable sized type 'struct bpf_lpm_trie_key' not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
>            struct bpf_lpm_trie_key trie_key;
>                                    ^
>      CLNG-BPF [test_maps] btf__core_reloc_type_based___diff.o
>    1 error generated.
>    make: *** [Makefile:521: /tmp/runner/work/bpf/bpf/tools/testing/selftests/bpf/map_ptr_kern.o] Error 1
>    make: *** Waiting for unfinished jobs....
> 
> If you look at the selftest tools/testing/selftests/bpf/progs/map_ptr_kern.c +314 :
> 
>    /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
>    struct bpf_lpm_trie_key {
>          __u32   prefixlen;      /* up to 32 for AF_INET, 128 for AF_INET6 */
>          __u8    data[];         /* Arbitrary size */
>    };
> 
>    struct lpm_key {
>          struct bpf_lpm_trie_key trie_key;
>          __u32 data;
>    };
> 
> Did you try to compile the tree (or selftests) with LLVM? I doubt the UX will be nice if everyone
> now has to add -Wno-gnu-variable-sized-type-not-at-end ..

Undone here until a different workaround can be found (affects both bpf and bpf-next):

   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=3024d95a4c521c278a7504ee9e80c57c3a9750e0

Thanks,
Daniel
