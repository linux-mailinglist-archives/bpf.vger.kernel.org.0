Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621315978DA
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 23:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241317AbiHQVVv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 17:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiHQVVu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 17:21:50 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51914A5992
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:21:49 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oOQTz-0004Wo-BI; Wed, 17 Aug 2022 23:21:47 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oOQTz-0004du-40; Wed, 17 Aug 2022 23:21:47 +0200
Subject: Re: [PATCH bpf-next] bpf: Sync include/uapi/linux/bpf.h with
 tools/include/uapi/linux/bpf.h
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20220817010504.4072757-1-davemarchevsky@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <22aebc88-da67-f086-e620-dd4a16e2bc69@iogearbox.net>
Date:   Wed, 17 Aug 2022 23:21:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220817010504.4072757-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

[ +Gustavo ]

On 8/17/22 3:05 AM, Dave Marchevsky wrote:
> Commit 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays with
> flexible-array members") modified bpf_lpm_trie_key struct's data member
> in include/uapi/linux/bpf.h, but didn't make the same change in tools
> dir's copy. Propagate it over and fix comment indentation as well.
> 
> This is a nonfunctional change.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Gustavo, 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays with flexible-array members")
breaks BPF when copied from include/uapi/linux/bpf.h to tools/include/uapi/linux/bpf.h :

CI: https://github.com/kernel-patches/bpf/runs/7885234999?check_suite_focus=true

   [...]
     CLNG-BPF [test_maps] map_ptr_kern.o
     CLNG-BPF [test_maps] btf__core_reloc_arrays___diff_arr_val_sz.o
     CLNG-BPF [test_maps] test_bpf_cookie.o
   progs/map_ptr_kern.c:314:26: error: field 'trie_key' with variable sized type 'struct bpf_lpm_trie_key' not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
           struct bpf_lpm_trie_key trie_key;
                                   ^
     CLNG-BPF [test_maps] btf__core_reloc_type_based___diff.o
   1 error generated.
   make: *** [Makefile:521: /tmp/runner/work/bpf/bpf/tools/testing/selftests/bpf/map_ptr_kern.o] Error 1
   make: *** Waiting for unfinished jobs....

If you look at the selftest tools/testing/selftests/bpf/progs/map_ptr_kern.c +314 :

   /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
   struct bpf_lpm_trie_key {
         __u32   prefixlen;      /* up to 32 for AF_INET, 128 for AF_INET6 */
         __u8    data[];         /* Arbitrary size */
   };

   struct lpm_key {
         struct bpf_lpm_trie_key trie_key;
         __u32 data;
   };

Did you try to compile the tree (or selftests) with LLVM? I doubt the UX will be nice if everyone
now has to add -Wno-gnu-variable-sized-type-not-at-end ..

> ---
>   include/uapi/linux/bpf.h       | 2 +-
>   tools/include/uapi/linux/bpf.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 934a2a8beb87..0b09b5463afd 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -79,7 +79,7 @@ struct bpf_insn {
>   /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
>   struct bpf_lpm_trie_key {
>   	__u32	prefixlen;	/* up to 32 for AF_INET, 128 for AF_INET6 */
> -	__u8	data[];	/* Arbitrary size */
> +	__u8	data[];		/* Arbitrary size */
>   };
>   
>   struct bpf_cgroup_storage_key {
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 1d6085e15fc8..0b09b5463afd 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -79,7 +79,7 @@ struct bpf_insn {
>   /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
>   struct bpf_lpm_trie_key {
>   	__u32	prefixlen;	/* up to 32 for AF_INET, 128 for AF_INET6 */
> -	__u8	data[0];	/* Arbitrary size */
> +	__u8	data[];		/* Arbitrary size */
>   };
>   
>   struct bpf_cgroup_storage_key {
> 

