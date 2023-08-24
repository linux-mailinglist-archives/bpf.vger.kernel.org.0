Return-Path: <bpf+bounces-8445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA227866FB
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 07:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0234281443
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 05:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FF617F6;
	Thu, 24 Aug 2023 05:04:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F1624525
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 05:04:39 +0000 (UTC)
Received: from out-4.mta1.migadu.com (out-4.mta1.migadu.com [95.215.58.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D9C10F7
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 22:04:23 -0700 (PDT)
Message-ID: <f4933856-ce85-0611-409d-bd62240d15af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692853461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/agbODuACkE9zxzQ+mjjbiTvmzp9loDgLFfKCCVRzkg=;
	b=OETouhs+t4/dk1qJyaBpj6RVvGzwUz+fQb1O0ey7gUKKXJbfrVu4HDaqwlhtMNYaxFOTq3
	vFzZV9aZt/3VckDeT1EbC/wN5hZvcg7GXD3MEjl4qk3dypl3nrjmn6j5yibL0DRvOmvJMb
	owhICD+zapL20wvnKLZvx8fPOZbJElY=
Date: Wed, 23 Aug 2023 22:04:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] libbpf: add basic BTF sanity validation
Content-Language: en-US
To: Andrii Nakryiko <andrii@kernel.org>
Cc: kernel-team@meta.com, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
References: <20230823234426.2506685-1-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230823234426.2506685-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/23/23 4:44 PM, Andrii Nakryiko wrote:
> +/* Validate basic sanity of BTF. It's intentionally less thorough than
> + * kernel's validation and validates only properties of BTF that libbpf relies
> + * on to be correct (e.g., valid type IDs, valid string offsets, etc)
> + */
> +int btf_sanity_check(const struct btf *btf)
> +{
> +	const struct btf_type *t;
> +	__u32 i, n = btf__type_cnt(btf);
> +	int err;
> +
> +	for (i = 1; i < n; i++) {
> +		t = btf_type_by_id(btf, i);
> +		err = btf_validate_type(btf, t, i);
> +		if (err)
> +			return err;
> +	}
> +	return 0;
> +}
> +
>   static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endian);
>   
>   int btf_load_into_kernel(struct btf *btf, char *log_buf, size_t log_sz, __u32 log_level)
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 4c3967d94b6d..71a3c768d9af 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2833,6 +2833,13 @@ static int bpf_object__init_btf(struct bpf_object *obj,
>   			pr_warn("Error loading ELF section %s: %d.\n", BTF_ELF_SEC, err);
>   			goto out;
>   		}
> +		err = btf_sanity_check(obj->btf);

Should btf_sanity_check() be called in btf_parse_type_sec() instead such that 
btf__parse_elf() can also have sanity check?

