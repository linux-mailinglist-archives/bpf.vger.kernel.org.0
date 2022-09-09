Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CBA5B3EB7
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 20:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiIISSJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 14:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiIISSB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 14:18:01 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC155B0289;
        Fri,  9 Sep 2022 11:17:57 -0700 (PDT)
Message-ID: <d2fd289d-a5b5-f0af-3125-417ba9d242f0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662747476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hxQnEaoROX92cThvzg5SE/OCMATF1xv047X1ewBjYn8=;
        b=m8SodHb5jeDFvbUyYV1O1Y0W46rXSYhxvBG8BB6oEwoHAP8jqiq3J3cly6azMFcDa8y/H+
        9BJ0IlatuXdUVOgKcncGTdWVnfVVf5OvL5JkfzcTkoz1FFZr936j817sHQ9ziHDexX/YkH
        Y3Rz+oCABNYQi1VXHpGSZVemq5fGU3A=
Date:   Fri, 9 Sep 2022 11:17:52 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: btf: fix truncated last_member_type_id in
 btf_struct_resolve
Content-Language: en-US
To:     Lorenz Bauer <oss@lmb.io>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20220909092107.3035-1-oss@lmb.io>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20220909092107.3035-1-oss@lmb.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/9/22 2:21 AM, Lorenz Bauer wrote:
> When trying to finish resolving a struct member, btf_struct_resolve
> saves the member type id in a u16 temporary variable. This truncates
> the 32 bit type id value if it exceeds UINT16_MAX.
> 
> As a result, structs that have members with type ids > UINT16_MAX and
> which need resolution will fail with a message like this:
> 
>      [67414] STRUCT ff_device size=120 vlen=12
>          effect_owners type_id=67434 bits_offset=960 Member exceeds struct_size
> 
> Fix this by changing the type of last_member_type_id to u32.
> 
> Fixes: eb3f595dab40 ("bpf: btf: Validate type reference")

The fix tag should be

Fixes: a0791f0df7d2 ("bpf: fix BTF limits")

> Signed-off-by: Lorenz Bauer <oss@lmb.io>
> ---
>   kernel/bpf/btf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 7e64447659f3..36fd4b509294 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3128,7 +3128,7 @@ static int btf_struct_resolve(struct btf_verifier_env *env,
>   	if (v->next_member) {
>   		const struct btf_type *last_member_type;
>   		const struct btf_member *last_member;
> -		u16 last_member_type_id;
> +		u32 last_member_type_id;

The change makes sense.

The kernel's vmlinux and module btf parsing doesn't go through this 
resolve check though.  Are you trying to __sys_bpf(BPF_BTF_LOAD) the btf 
from the vmlinux file into the kernel ?

