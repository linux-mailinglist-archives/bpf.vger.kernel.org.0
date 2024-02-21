Return-Path: <bpf+bounces-22453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C95985E5EA
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 19:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54D41F29143
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 18:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9F185626;
	Wed, 21 Feb 2024 18:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UCmndk71"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A58385628
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 18:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539941; cv=none; b=plVKxxwzewIHlXiTrCWzlApwCUI/TF5ZqgDD6s8qJ7/67XVO0OxQTs0EndGDrwjPiZ1lDGYW7zjbtNQfIRUYwMTH+1H95L7FRQKaWGtz5k9WPNunocG6ZxCo2HxBFx4pWU7Xa1A/3f+3YlCPkJDieT+qenULEHPXBBERiyZ/TfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539941; c=relaxed/simple;
	bh=9WhPaLM23w40xVQ8ApBisKTb4d+ysywDKS2NjcB2JE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLolTeau2nQYDoe3Kpx6sOObxCsPNLOa0Nunw6+uUg2mPfaUtPpAfI7sOKKu0Z21pwnwJXTkLSMajfobGJ1ElxA7w+RSFDvObbAxuYktckIpPC0zmehZClGs2kw6/qHQfpBFW9aOIaxj6CHqngxs2Tga6D2TakXHn6L1Wh59Ock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UCmndk71; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8e6e79d6-e003-446b-bc36-b6a4500f802b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708539927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6JuQ/bMzJw4D8tgHfkfECgX6UhARoXwFykwzdVIKKg=;
	b=UCmndk71nOXf15SGfEhwgDJ7Ze9SsMelGUkviTpQDqVIouuNGHW7lee7W3xJRiPZBBOfIR
	DIvTM+cgq8wdIqCeQbKzhXN5kntjLrccyLRlPOEIwjBP5Tft8Z8TvRtHBo65p9jPCK7Nue
	m91cvJr8ntksfJbls0NciBWRaZCEUhQ=
Date: Wed, 21 Feb 2024 10:25:22 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/3] bpf: Check cfi_stubs before registering a
 struct_ops type.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20240221075213.2071454-1-thinker.li@gmail.com>
 <20240221075213.2071454-3-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240221075213.2071454-3-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/20/24 11:52 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Recently, cfi_stubs were introduced. However, existing struct_ops types
> that are not in the upstream may not be aware of this, resulting in kernel
> crashes. By rejecting struct_ops types that do not provide cfi_stubs during
> registration, these crashes can be avoided.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   kernel/bpf/bpf_struct_ops.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 0d7be97a2411..c1c502caae08 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -302,6 +302,11 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>   	}
>   	sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
>   
> +	if (!st_ops->cfi_stubs) {
> +		pr_warn("struct %s has no cfi_stubs\n", st_ops->name);
> +		return -EINVAL;
> +	}
> +
>   	type_id = btf_find_by_name_kind(btf, st_ops->name,
>   					BTF_KIND_STRUCT);
>   	if (type_id < 0) {
> @@ -339,6 +344,7 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>   
>   	for_each_member(i, t, member) {
>   		const struct btf_type *func_proto;
> +		u32 moff;
>   
>   		mname = btf_name_by_offset(btf, member->name_off);
>   		if (!*mname) {
> @@ -361,6 +367,17 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
>   		if (!func_proto)
>   			continue;
>   
> +		moff = __btf_member_bit_offset(t, member) / 8;
> +		err = st_ops->check_member ?
> +			st_ops->check_member(t, member, NULL) : 0;

I don't think it is necessary to make check_member more complicated by taking
NULL prog. The struct_ops implementer then needs to handle this extra NULL
prog case.

Have you thought about Alexei's earlier suggestion in v3 to reuse the NULL
member in cfi_stubs to flag unsupported member and remove the unsupported_ops[]
from bpf_tcp_ca.c?

If the verifier can consistently reject loading unsupported bpf prog, it will
not reach the bpf_struct_ops_map_update_elem and then hits the NULL member
in cfi_stubs during map_update_elem.

Untested code:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 011d54a1dc53..c57cb0e2a8a7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20370,6 +20370,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
  	u32 btf_id, member_idx;
  	struct btf *btf;
  	const char *mname;
+	u32 moff;
  
  	if (!prog->gpl_compatible) {
  		verbose(env, "struct ops programs must have a GPL compatible license\n");
@@ -20417,11 +20418,18 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
  		return -EINVAL;
  	}
  
+	moff = __btf_member_bit_offset(t, member) / 8;
+	if (!*(void **)(st_ops->cfi_stubs + moff)) {
+		verbose(env, "attach to unsupported member %s of struct %s\n",
+			mname, st_ops->name);
+		return -ENOTSUPP;
+	}
+
  	if (st_ops->check_member) {
  		int err = st_ops->check_member(t, member, prog);
  
  		if (err) {
-			verbose(env, "attach to unsupported member %s of struct %s\n",
+			verbose(env, "cannot attach to member %s of struct %s\n",
  				mname, st_ops->name);
  			return err;
  		}
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 7f518ea5f4ac..bcb1fcd00973 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -14,10 +14,6 @@
  /* "extern" is to avoid sparse warning.  It is only used in bpf_struct_ops.c. */
  static struct bpf_struct_ops bpf_tcp_congestion_ops;
  
-static u32 unsupported_ops[] = {
-	offsetof(struct tcp_congestion_ops, get_info),
-};
-
  static const struct btf_type *tcp_sock_type;
  static u32 tcp_sock_id, sock_id;
  static const struct btf_type *tcp_congestion_ops_type;
@@ -45,18 +41,6 @@ static int bpf_tcp_ca_init(struct btf *btf)
  	return 0;
  }
  
-static bool is_unsupported(u32 member_offset)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(unsupported_ops); i++) {
-		if (member_offset == unsupported_ops[i])
-			return true;
-	}
-
-	return false;
-}
-
  static bool bpf_tcp_ca_is_valid_access(int off, int size,
  				       enum bpf_access_type type,
  				       const struct bpf_prog *prog,
@@ -248,15 +232,6 @@ static int bpf_tcp_ca_init_member(const struct btf_type *t,
  	return 0;
  }
  
-static int bpf_tcp_ca_check_member(const struct btf_type *t,
-				   const struct btf_member *member,
-				   const struct bpf_prog *prog)
-{
-	if (is_unsupported(__btf_member_bit_offset(t, member) / 8))
-		return -ENOTSUPP;
-	return 0;
-}
-
  static int bpf_tcp_ca_reg(void *kdata)
  {
  	return tcp_register_congestion_control(kdata);
@@ -350,7 +325,6 @@ static struct bpf_struct_ops bpf_tcp_congestion_ops = {
  	.reg = bpf_tcp_ca_reg,
  	.unreg = bpf_tcp_ca_unreg,
  	.update = bpf_tcp_ca_update,
-	.check_member = bpf_tcp_ca_check_member,
  	.init_member = bpf_tcp_ca_init_member,
  	.init = bpf_tcp_ca_init,
  	.validate = bpf_tcp_ca_validate,
-- 
2.34.1




> +
> +		if (!err && !*(void **)(st_ops->cfi_stubs + moff)) {
> +			pr_warn("member %s in struct %s has no cfi stub function\n",
> +				mname, st_ops->name);
> +			err = -EINVAL;
> +			goto errout;
> +		}
> +
>   		if (btf_distill_func_proto(log, btf,
>   					   func_proto, mname,
>   					   &st_ops->func_models[i])) {


