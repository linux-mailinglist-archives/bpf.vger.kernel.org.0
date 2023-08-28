Return-Path: <bpf+bounces-8868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE0B78BAD7
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 00:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D4E280ECF
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 22:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6041C15;
	Mon, 28 Aug 2023 22:12:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0231850
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 22:12:10 +0000 (UTC)
Received: from out-252.mta1.migadu.com (out-252.mta1.migadu.com [95.215.58.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37F7198
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 15:12:02 -0700 (PDT)
Message-ID: <9ca6f8c6-4296-a703-2413-a844275edb89@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693260720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oSpC+/LCsuH80M7QwPTtYsflZSkjUz865+joN1RqZx8=;
	b=c69GSPRrBxaQKxRztzAb47/n5O6tWnIa9L5yWfEk+zG5oJGOUOB2iqLFiqMqfzwT+kPzsd
	YAZdyk2P9K5+LaPWwtFFHBD4ZyitLXYn3fEnd9WHTh/WM/CqsWAjZPlELr/fJwDYCA3AAe
	JUTgtlQYYbRP2t064PzFS6PO6UIO9pI=
Date: Mon, 28 Aug 2023 15:11:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 05/14] bpf: Add support for custom exception
 callbacks
Content-Language: en-US
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, David Vernet <void@manifault.com>,
 bpf@vger.kernel.org
References: <20230809114116.3216687-1-memxor@gmail.com>
 <20230809114116.3216687-6-memxor@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230809114116.3216687-6-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/9/23 4:41 AM, Kumar Kartikeya Dwivedi wrote:
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d0f6c984272b..9d67d0633c59 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2457,6 +2457,73 @@ static int add_subprog(struct bpf_verifier_env *env, int off)
>   	return env->subprog_cnt - 1;
>   }
>   
> +static int bpf_find_exception_callback_insn_off(struct bpf_verifier_env *env)
> +{
> +	struct bpf_prog_aux *aux = env->prog->aux;
> +	struct btf *btf = aux->btf;
> +	const struct btf_type *t;
> +	const char *name;
> +	u32 main_btf_id;
> +	int ret, i, j;
> +
> +	/* Non-zero func_info_cnt implies valid btf */
> +	if (!aux->func_info_cnt)
> +		return 0;
> +	main_btf_id = aux->func_info[0].type_id;
> +
> +	t = btf_type_by_id(btf, main_btf_id);
> +	if (!t) {
> +		verbose(env, "invalid btf id for main subprog in func_info\n");
> +		return -EINVAL;
> +	}
> +
> +	name = btf_find_decl_tag_value(btf, t, -1, "exception_callback:");
> +	if (IS_ERR(name)) {
> +		ret = PTR_ERR(name);
> +		/* If there is no tag present, there is no exception callback */
> +		if (ret == -ENOENT)
> +			ret = 0;
> +		else if (ret == -EEXIST)
> +			verbose(env, "multiple exception callback tags for main subprog\n");
> +		return ret;
> +	}
> +
> +	ret = -ENOENT;
> +	for (i = 0; i < btf_nr_types(btf); i++) {
> +		t = btf_type_by_id(btf, i);
> +		if (!btf_type_is_func(t))
> +			continue;
> +		if (strcmp(name, btf_name_by_offset(btf, t->name_off)))
> +			continue;

nit. btf_find_by_name_kind() could be used here.


> +		if (btf_func_linkage(t) != BTF_FUNC_GLOBAL) {
> +			verbose(env, "exception callback '%s' must have global linkage\n", name);
> +			return -EINVAL;
> +		} > +
> +		ret = 0;
> +		for (j = 0; j < aux->func_info_cnt; j++) {
> +			if (aux->func_info[j].type_id != i)
> +				continue;
> +			ret = aux->func_info[j].insn_off;
> +			/* Further func_info and subprog checks will also happen
> +			 * later, so assume this is the right insn_off for now.
> +			 */
> +			if (!ret) {
> +				verbose(env, "invalid exception callback insn_off in func_info: 0\n");
> +				ret = -EINVAL;
> +			}
> +		}
> +		if (!ret) {
> +			verbose(env, "exception callback type id not found in func_info\n");
> +			ret = -EINVAL;
> +		}
> +		break;
> +	}
> +	if (ret == -ENOENT)
> +		verbose(env, "exception callback '%s' could not be found in BTF\n", name);
> +	return ret;
> +}


