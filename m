Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2536A8DC4
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 01:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCCAQV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 19:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCCAQU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 19:16:20 -0500
Received: from out-25.mta1.migadu.com (out-25.mta1.migadu.com [95.215.58.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F7F19684
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 16:16:18 -0800 (PST)
Message-ID: <2eb84f6e-d316-1a72-18ae-56b9cda97f8b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677802573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kH5qidKB/AG7xc+CilUrGKJrOsdgwPHkx4KcXCO9duE=;
        b=qOgAX8M9vBWEje6QS92Tn68wwi+fJfHNerdlW0hLR2Ca80hnJ3uze75rQrD2wsPTcSWRon
        Ywb8xy3IEPFmq5c8APMkgA6XO8ooyHs8AljZHoURiZG/LtpzKNKonN+zll9Mtef5adHneO
        tLINxGRQGqlZheMjDpmFJlLKImQ8GuU=
Date:   Thu, 2 Mar 2023 16:16:08 -0800
MIME-Version: 1.0
Subject: Re: [PATCH] btf: fix resolving BTF_KIND_VAR after ARRAY, STRUCT,
 UNION, PTR
Content-Language: en-US
To:     Lorenz Bauer <lorenz.bauer@isovalent.com>
Cc:     Lorenz Bauer <lmb@isovalent.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20230302123440.1193507-1-lmb@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230302123440.1193507-1-lmb@isovalent.com>
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

On 3/2/23 4:34 AM, Lorenz Bauer wrote:
> btf_datasec_resolve contains a bug that causes the following BTF
> to fail loading:
> 
>      [1] DATASEC a size=2 vlen=2
>          type_id=4 offset=0 size=1
>          type_id=7 offset=1 size=1
>      [2] INT (anon) size=1 bits_offset=0 nr_bits=8 encoding=(none)
>      [3] PTR (anon) type_id=2
>      [4] VAR a type_id=3 linkage=0
>      [5] INT (anon) size=1 bits_offset=0 nr_bits=8 encoding=(none)
>      [6] TYPEDEF td type_id=5
>      [7] VAR b type_id=6 linkage=0
> 
> This error message is printed during btf_check_all_types:
> 
>      [1] DATASEC a size=2 vlen=2
>          type_id=7 offset=1 size=1 Invalid type
> 
> By tracing btf_*_resolve we can pinpoint the problem:
> 
>      btf_datasec_resolve(depth: 1, type_id: 1, mode: RESOLVE_TBD) = 0
>          btf_var_resolve(depth: 2, type_id: 4, mode: RESOLVE_TBD) = 0
>              btf_ptr_resolve(depth: 3, type_id: 3, mode: RESOLVE_PTR) = 0
>          btf_var_resolve(depth: 2, type_id: 4, mode: RESOLVE_PTR) = 0
>      btf_datasec_resolve(depth: 1, type_id: 1, mode: RESOLVE_PTR) = -22
> 
> The last invocation of btf_datasec_resolve should invoke btf_var_resolve
> by means of env_stack_push, instead it returns EINVAL. The reason is that
> env_stack_push is never executed for the second VAR.
> 
>      if (!env_type_is_resolve_sink(env, var_type) &&
>          !env_type_is_resolved(env, var_type_id)) {
>          env_stack_set_next_member(env, i + 1);
>          return env_stack_push(env, var_type, var_type_id);
>      }
> 
> env_type_is_resolve_sink() changes its behaviour based on resolve_mode.
> For RESOLVE_PTR, we can simplify the if condition to the following:
> 
>      (btf_type_is_modifier() || btf_type_is_ptr) && !env_type_is_resolved()
> 
> Since we're dealing with a VAR the clause evaluates to false. This is
> not sufficient to trigger the bug however. The log output and EINVAL
> are only generated if btf_type_id_size() fails.
> 
>      if (!btf_type_id_size(btf, &type_id, &type_size)) {
>          btf_verifier_log_vsi(env, v->t, vsi, "Invalid type");
>          return -EINVAL;
>      }
> 
> Most types are sized, so for example a VAR referring to an INT is not a
> problem. The bug is only triggered if a VAR points at a modifier. Since
> we skipped btf_var_resolve that modifier was also never resolved, which
> means that btf_resolved_type_id returns 0 aka VOID for the modifier.
> This in turn causes btf_type_id_size to return NULL, triggering EINVAL.
> 
> To summarise, the following conditions are necessary:
> 
> - VAR pointing at PTR, STRUCT, UNION or ARRAY
> - Followed by a VAR pointing at TYPEDEF, VOLATILE, CONST, RESTRICT or
>    TYPE_TAG
> 
> The fix is to reset resolve_mode to RESOLVE_TBD before attempting to
> resolve a VAR from a DATASEC.
> 
> Fixes: 1dc92851849c ("bpf: kernel side support for BTF Var and DataSec")
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> ---
>   kernel/bpf/btf.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index fa22ec79ac0e..91145298c238 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -4579,6 +4579,7 @@ static int btf_datasec_resolve(struct btf_verifier_env *env,
>   			return -EINVAL;
>   		}
>   
> +		env->resolve_mode = RESOLVE_TBD;

lgtm. Could it be moved out of the for loop?

Please add the test case described in the commit message to the prog_tests/btf.c.

>   		if (!env_type_is_resolve_sink(env, var_type) &&
>   		    !env_type_is_resolved(env, var_type_id)) {
>   			env_stack_set_next_member(env, i + 1);

