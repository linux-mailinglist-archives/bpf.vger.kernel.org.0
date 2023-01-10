Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5D96636F3
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 02:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjAJBxB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 20:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjAJBwo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 20:52:44 -0500
Received: from out-197.mta0.migadu.com (out-197.mta0.migadu.com [91.218.175.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85B5313
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 17:52:43 -0800 (PST)
Message-ID: <28f6d8e5-f01d-d63b-a326-aa4e63b5c804@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673315562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rw/LisaZYKKwnYcVPA+AJMZRjjNx3XjlxTolWPLwXk4=;
        b=CzGUQ14oBXtDEh09x8CxYVjgp72M8UDhDxzDh1ue/imT+o5hdcVNIhFa32m4nPfOYAwp9N
        UPc/oVCVy/Bxz7Q8yKBCSdBnZjKoIiRb2vpu8QVk2uIWsdUbvA3Vue9YE8fFKb57HIc30Y
        5jdLVEH3mc7jqwjHm7ne3tCa2WhDutw=
Date:   Mon, 9 Jan 2023 17:52:37 -0800
MIME-Version: 1.0
Subject: Re: [bpf-next v4 1/2] bpf: hash map, avoid deadlock with suitable
 hash mask
Content-Language: en-US
To:     tong@infragraf.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
References: <20230105092637.35069-1-tong@infragraf.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230105092637.35069-1-tong@infragraf.org>
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

On 1/5/23 1:26 AM, tong@infragraf.org wrote:
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 5aa2b5525f79..974f104f47a0 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -152,7 +152,7 @@ static inline int htab_lock_bucket(const struct bpf_htab *htab,
>   {
>   	unsigned long flags;
>   
> -	hash = hash & HASHTAB_MAP_LOCK_MASK;
> +	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
>   
>   	preempt_disable();
>   	if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) != 1)) {
> @@ -171,7 +171,7 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
>   				      struct bucket *b, u32 hash,
>   				      unsigned long flags)
>   {
> -	hash = hash & HASHTAB_MAP_LOCK_MASK;
> +	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);

Please run checkpatch.pl.  patchwork also reports the same thing:
https://patchwork.kernel.org/project/netdevbpf/patch/20230105092637.35069-1-tong@infragraf.org/

CHECK: spaces preferred around that '-' (ctx:WxV)
#46: FILE: kernel/bpf/hashtab.c:155:
+	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
  	                                                                ^

CHECK: spaces preferred around that '-' (ctx:WxV)
#55: FILE: kernel/bpf/hashtab.c:174:
+	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);

btw, instead of doing this min_t and -1 repeatedly, ensuring n_buckets is at 
least HASHTAB_MAP_LOCK_COUNT during map_alloc should be as good?  htab having 2 
or 4 max_entries should be pretty uncommon.
