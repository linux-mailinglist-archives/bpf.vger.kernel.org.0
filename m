Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077D5614C1A
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 14:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiKANwb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 09:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiKANw2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 09:52:28 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A681409C;
        Tue,  1 Nov 2022 06:52:24 -0700 (PDT)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oprgf-000DGm-DE; Tue, 01 Nov 2022 14:52:17 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oprge-000Jkk-Tx; Tue, 01 Nov 2022 14:52:17 +0100
Subject: Re: [PATCH bpf-next v2 2/3] bpf/verifier: Use kmalloc_size_roundup()
 to match ksize() usage
To:     Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20221029024444.gonna.633-kees@kernel.org>
 <20221029025433.2533810-2-keescook@chromium.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <da0959e7-a91c-ab4c-56be-3c3cd280e592@iogearbox.net>
Date:   Tue, 1 Nov 2022 14:52:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20221029025433.2533810-2-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26706/Tue Nov  1 08:52:34 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/29/22 4:54 AM, Kees Cook wrote:
> Round up allocations with kmalloc_size_roundup() so that the verifier's
> use of ksize() is always accurate and no special handling of the memory
> is needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE. Pass the new size
> information back up to callers so they can use the space immediately,
> so array resizing to happen less frequently as well.
> 
[...]

The commit message is a bit cryptic here without further context. Is this
a bug fix or improvement? I read the latter, but it would be good to have
more context here for reviewers (maybe Link tag pointing to some discussion
or the like). Also, why is the kmalloc_size_roundup() not hidden for kmalloc
callers, isn't this a tree-wide issue?

Thanks,
Daniel

>   kernel/bpf/verifier.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index eb8c34db74c7..1c040d27b8f6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1008,9 +1008,9 @@ static void *copy_array(void *dst, const void *src, size_t n, size_t size, gfp_t
>   	if (unlikely(check_mul_overflow(n, size, &bytes)))
>   		return NULL;
>   
> -	if (ksize(dst) < bytes) {
> +	if (ksize(dst) < ksize(src)) {
>   		kfree(dst);
> -		dst = kmalloc_track_caller(bytes, flags);
> +		dst = kmalloc_track_caller(kmalloc_size_roundup(bytes), flags);
>   		if (!dst)
>   			return NULL;
>   	}
> @@ -1027,12 +1027,14 @@ static void *copy_array(void *dst, const void *src, size_t n, size_t size, gfp_t
>    */
>   static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
>   {
> +	size_t alloc_size;
>   	void *new_arr;
>   
>   	if (!new_n || old_n == new_n)
>   		goto out;
>   
> -	new_arr = krealloc_array(arr, new_n, size, GFP_KERNEL);
> +	alloc_size = kmalloc_size_roundup(size_mul(new_n, size));
> +	new_arr = krealloc(arr, alloc_size, GFP_KERNEL);
>   	if (!new_arr) {
>   		kfree(arr);
>   		return NULL;
> @@ -2504,9 +2506,11 @@ static int push_jmp_history(struct bpf_verifier_env *env,
>   {
>   	u32 cnt = cur->jmp_history_cnt;
>   	struct bpf_idx_pair *p;
> +	size_t alloc_size;
>   
>   	cnt++;
> -	p = krealloc(cur->jmp_history, cnt * sizeof(*p), GFP_USER);
> +	alloc_size = kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
> +	p = krealloc(cur->jmp_history, alloc_size, GFP_USER);
>   	if (!p)
>   		return -ENOMEM;
>   	p[cnt - 1].idx = env->insn_idx;
> 

