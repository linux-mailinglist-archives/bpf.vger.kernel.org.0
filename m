Return-Path: <bpf+bounces-10832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 771197AE32E
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 03:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 8AAA71C20829
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 01:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1664B7E8;
	Tue, 26 Sep 2023 01:03:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7FA637
	for <bpf@vger.kernel.org>; Tue, 26 Sep 2023 01:03:45 +0000 (UTC)
Received: from out-198.mta1.migadu.com (out-198.mta1.migadu.com [95.215.58.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8314110E
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 18:03:42 -0700 (PDT)
Message-ID: <cc51b582-3fbd-2236-b259-fe31aeb85d38@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695690220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=17Z1az0reskaN/YATsx3DXi6gCbWoiloBN7PGdKZ14M=;
	b=AF99wFTPkB2yjOotCNr8JG8Tp4Nqa5vTjHOHcHPscRGhtRV6mNM6MpXw4SdvUe+hhGOkNC
	xPe08VDZBLDXPy2UFqWucdKQTrEVb1zdujLNZw7lK80zDtWs5LOusySyhTY9iNYtMoKSgh
	szlg/QgmtPU5keFGL5OsTb75GF6wgCM=
Date: Mon, 25 Sep 2023 18:03:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v3 06/11] bpf: validate value_type
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230920155923.151136-1-thinker.li@gmail.com>
 <20230920155923.151136-7-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230920155923.151136-7-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/20/23 8:59 AM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> A value_type should has three members; refcnt, state, and data.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   kernel/bpf/bpf_struct_ops.c | 75 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 75 insertions(+)
> 
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index ef8a1edec891..fb684d2ee99d 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -99,6 +99,79 @@ const struct bpf_prog_ops bpf_struct_ops_prog_ops = {
>   
>   static const struct btf_type *module_type;
>   
> +static bool check_value_member(struct btf *btf,
> +			       const struct btf_member *member,
> +			       int index,
> +			       const char *value_name,
> +			       const char *name, const char *type_name,
> +			       u16 kind)
> +{
> +	const char *mname, *mtname;
> +	const struct btf_type *mt;
> +	s32 mtype_id;
> +
> +	mname = btf_name_by_offset(btf, member->name_off);
> +	if (!*mname) {
> +		pr_warn("The member %d of %s should have a name\n",
> +			index, value_name);
> +		return false;
> +	}
> +	if (strcmp(mname, name)) {
> +		pr_warn("The member %d of %s should be refcnt\n",
> +			index, value_name);
> +		return false;
> +	}
> +	mtype_id = member->type;
> +	mt = btf_type_by_id(btf, mtype_id);
> +	mtname = btf_name_by_offset(btf, mt->name_off);
> +	if (!*mtname) {
> +		pr_warn("The type of the member %d of %s should have a name\n",
> +			index, value_name);
> +		return false;
> +	}
> +	if (strcmp(mtname, type_name)) {
> +		pr_warn("The type of the member %d of %s should be refcount_t\n",
> +			index, value_name);
> +		return false;
> +	}
> +	if (btf_kind(mt) != kind) {
> +		pr_warn("The type of the member %d of %s should be %d\n",
> +			index, value_name, btf_kind(mt));
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static bool is_valid_value_type(struct btf *btf, s32 value_id,
> +				const char *type_name, const char *value_name)
> +{
> +	const struct btf_member *member;
> +	const struct btf_type *vt;
> +
> +	vt = btf_type_by_id(btf, value_id);
> +	if (btf_vlen(vt) != 3) {
> +		pr_warn("The number of %s's members should be 3, but we get %d\n",
> +			value_name, btf_vlen(vt));
> +		return false;
> +	}
> +	member = btf_type_member(vt);
> +	if (!check_value_member(btf, member, 0, value_name,
> +				"refcnt", "refcount_t", BTF_KIND_TYPEDEF))
> +		return false;
> +	member++;
> +	if (!check_value_member(btf, member, 1, value_name,
> +				"state", "bpf_struct_ops_state",
> +				BTF_KIND_ENUM))
> +		return false;
> +	member++;

I wonder if giving BPF_STRUCT_OPS_COMMON_VALUE a proper struct will make the 
validation cleaner. Like,

struct bpf_struct_ops_common {
	refcount_t refcnt;
	enum bpf_struct_ops_state state;
};

wdyt?

> +	if (!check_value_member(btf, member, 2, value_name,
> +				"data", type_name, BTF_KIND_STRUCT))

Instead of checking name, I think this can directly check with the st_ops->type.

> +		return false;
> +
> +	return true;
> +}



