Return-Path: <bpf+bounces-18564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1809381C140
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 23:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9B12B24D0E
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 22:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A9678E7F;
	Thu, 21 Dec 2023 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZbHpS76T"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DAA64A96
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <98e76ea6-f45e-4ed5-9976-97f540032a55@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703199443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqJZuGZlY49D1lCVtA3Bz8DTC9+SBARvmfQvvy9+1e0=;
	b=ZbHpS76TxAe535opTil4JoXzOj/E3WcaBjAOoNGEZvnLvt+7/qDtFRYro8Z2iuJGLSnJsb
	rVXYqMMiWCPyXKp83QuQ6EF8nKs0i86cbMDk4mymSAXZtR2tbbp0PHobShn8cLZxiweY0i
	r1k42C424xXlNArxXmHh9EEaQLtr9oI=
Date: Thu, 21 Dec 2023 17:57:18 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
Content-Language: en-US
To: Daniel Xu <dxu@dxuuu.xyz>, acme@kernel.org, jolsa@kernel.org,
 quentin@isovalent.com
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 bpf@vger.kernel.org
References: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/20/23 5:19 PM, Daniel Xu wrote:
> This commit teaches pahole to parse symbols in .BTF_ids section in
> vmlinux and discover exported kfuncs. Pahole then takes the list of
> kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> 
> This enables downstream users and tools to dynamically discover which
> kfuncs are available on a system by parsing vmlinux or module BTF, both
> available in /sys/kernel/btf.
> 
> Example of encoding:
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg DECL_TAG | wc -l
>         388
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg 68940
>         [68940] FUNC 'bpf_xdp_get_xfrm_state' type_id=68939 linkage=static
>         [128124] DECL_TAG 'kfunc' type_id=68940 component_idx=-1
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  btf_encoder.c | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 202 insertions(+)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index fd04008..2697214 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -34,6 +34,9 @@
>  #include <pthread.h>
>  
>  #define BTF_ENCODER_MAX_PROTO	512
> +#define BTF_IDS_SECTION		".BTF_ids"
> +#define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
> +#define BTF_KFUNC_TYPE_TAG	"kfunc"

Can this be bpf_kfunc? Elaborated on elsewhere in this reply

>  
>  /* state used to do later encoding of saved functions */
>  struct btf_encoder_state {
> @@ -1352,6 +1355,200 @@ out:
>  	return err;
>  }
>  
> +/*
> + * Parse BTF_ID symbol and return the kfunc name.
> + *
> + * Returns:
> + *	Callee-owned string containing kfunc name if successful.

nit: Caller-owned, not callee-owned

> + *	NULL if !kfunc or on error.
> + */
> +static char *get_kfunc_name(const char *sym)
> +{
> +	char *kfunc, *end;
> +
> +	if (strncmp(sym, BTF_ID_FUNC_PFX, sizeof(BTF_ID_FUNC_PFX) - 1))
> +		return NULL;
> +
> +	/* Strip prefix */
> +	kfunc = strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
> +
> +	/* Strip suffix */
> +	end = strrchr(kfunc, '_');
> +	if (!end || *(end - 1) != '_') {
> +		free(kfunc);
> +		return NULL;
> +	}
> +	*(end - 1) = '\0';
> +
> +	return kfunc;
> +}
> +
> +static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, const char *kfunc)
> +{
> +	int nr_types, type_id, err = -1;
> +	struct btf *btf = encoder->btf;
> +
> +	nr_types = btf__type_cnt(btf);
> +	for (type_id = 1; type_id < nr_types; type_id++) {
> +		const struct btf_type *type;
> +		const char *name;
> +
> +		type = btf__type_by_id(btf, type_id);
> +		if (!type) {
> +			fprintf(stderr, "%s: malformed BTF, can't resolve type for ID %d\n",
> +				__func__, type_id);
> +			goto out;
> +		}
> +
> +		if (!btf_is_func(type))
> +			continue;
> +
> +		name = btf__name_by_offset(btf, type->name_off);
> +		if (!name) {
> +			fprintf(stderr, "%s: malformed BTF, can't resolve name for ID %d\n",
> +				__func__, type_id);
> +			goto out;
> +		}
> +
> +		if (strcmp(name, kfunc))
> +		    continue;
> +
> +		err = btf__add_decl_tag(btf, BTF_KFUNC_TYPE_TAG, type_id, -1);

In an ideal world we'd just add this tag to __bpf_kfunc macro
definition, right? Then bpftool can generate fwd decls from generated
vmlinux w/o any pahole changes. But no gcc support for BTF tags, so need
to do this workaround.

With that in mind, instead of unconditionally adding BTF_KFUNC_TYPE_TAG
to funcs in btf id sets, can this code only do so if there isn't an
existing BTF_KFUNC_TYPE_TAG pointing to it? It'd require another loop
over btf types to built set of already-tagged funcs, but would
future-proof this work. Alternatively, if existing btf__dedup call after
btf_encoder__tag_kfuncs will get rid of these extraneous "tagged types"
in the scenario where one already exists, then a comment here to that
effect would be appreciated.

My nit about BTF_KFUNC_TYPE_TAG earlier was related: if we do want
__bpf_kfunc macro to add such a tag, might as well make the tag
'bpf_kfunc' so it's easier for unfamiliar folks to understand.

