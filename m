Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5830F524158
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 02:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349353AbiELAGA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 20:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349551AbiELAFz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 20:05:55 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF6B15FD6
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 17:05:53 -0700 (PDT)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nowL0-000CNy-CZ; Thu, 12 May 2022 02:05:50 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nowL0-000RR3-6e; Thu, 12 May 2022 02:05:50 +0200
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Add verifier support for dynptrs and
 implement malloc dynptrs
To:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org
References: <20220509224257.3222614-1-joannelkoong@gmail.com>
 <20220509224257.3222614-3-joannelkoong@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6c0d9917-fcb2-6a74-81d7-4f9421867d76@iogearbox.net>
Date:   Thu, 12 May 2022 02:05:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220509224257.3222614-3-joannelkoong@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26538/Wed May 11 10:06:03 2022)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/10/22 12:42 AM, Joanne Koong wrote:
[...]
> @@ -6498,6 +6523,11 @@ struct bpf_timer {
>   	__u64 :64;
>   } __attribute__((aligned(8)));
>   
> +struct bpf_dynptr {
> +	__u64 :64;
> +	__u64 :64;
> +} __attribute__((aligned(8)));
> +
>   struct bpf_sysctl {
>   	__u32	write;		/* Sysctl is being read (= 0) or written (= 1).
>   				 * Allows 1,2,4-byte read, but no write.
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 8a2398ac14c2..a4272e9239ea 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1396,6 +1396,77 @@ const struct bpf_func_proto bpf_kptr_xchg_proto = {
>   	.arg2_btf_id  = BPF_PTR_POISON,
>   };
>   
> +void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data, enum bpf_dynptr_type type,
> +		     u32 offset, u32 size)
> +{
> +	ptr->data = data;
> +	ptr->offset = offset;
> +	ptr->size = size;
> +	bpf_dynptr_set_type(ptr, type);
> +}
> +
> +void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
> +{
> +	memset(ptr, 0, sizeof(*ptr));
> +}
> +
> +BPF_CALL_3(bpf_dynptr_alloc, u32, size, u64, flags, struct bpf_dynptr_kern *, ptr)
> +{
> +	gfp_t gfp_flags = GFP_ATOMIC;

nit: should also have __GFP_NOWARN

I presume mem accounting cannot be done on this one given there is no real "ownership"
of this piece of mem?

Was planning to run some more local tests tomorrow, but from glance at selftest side
I haven't seen sanity checks like these:

bpf_dynptr_alloc(8, 0, &ptr);
data = bpf_dynptr_data(&ptr, 0, 0);
bpf_dynptr_put(&ptr);
*(__u8 *)data = 23;

How is this prevented? I think you do a ptr id check in the is_dynptr_ref_function
check on the acquire function, but with above use, would our data pointer escape, or
get invalidated via last put?

Thanks,
Daniel
