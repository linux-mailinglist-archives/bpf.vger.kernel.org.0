Return-Path: <bpf+bounces-37752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B04E795A43A
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 19:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BBC1B22ACC
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 17:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06B51B3B05;
	Wed, 21 Aug 2024 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kUUIh8sV"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D484E1B2EF3
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263072; cv=none; b=lYhT5xO7hv05sM/j7qinhUbI+xZh1EHiGPbtFb5ORwrtaAR3LE25o0dzKfd7okG2/Fn0d8FXG1GRpHsxw6kK4FJLICJPFtvypxotiXiZeZXuzr3lRW+jamfztX32IMgaRPIuwcK0mnWj98Vl06UEgiUPvDvvn3mzdtapzpbaJeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263072; c=relaxed/simple;
	bh=NvR7oT3zr3C4ZD5rcoKziVSJ6A0Ygns8X6MvpZlOnng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFh7hwmM1u2zCaoe7/ZItOC454fb50U5XInKluTZuYd8Lha50cIzauOM3aVendSK1Oe6y8uxGo1WEVShhA6UJnKw3vhMXszQeu81dBSEc8BxyzZxQGQGuUc/MP9VdBz3rCHXAOLTD1ZuOfR6xpgHcFDVPVH5Z6tfqnqIQneLb10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kUUIh8sV; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dab1feb1-446d-46c7-a8b1-f0483cc149ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724263067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exaGamvClAfEMBZ3mXvHDSEbyNjLuT+5dVdNlgYhTAo=;
	b=kUUIh8sVO8fJk7PSghH29hp29QO/StTElaQhOn42ScWPsBHSt5QmWAwfcj1dmfRpxagPb6
	oTjy23t8RZhJNczETlYEAb5c/rqChrJocP+Ym7RjKMd7vJLEGWmBeAp/bQy+idd1v3QVoA
	wtRvIQMu3UF+xJZV1Gv9JR5xqqigWjI=
Date: Wed, 21 Aug 2024 10:57:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpftool: check for NULL ptr of btf in
 codegen_subskel_datasecs
Content-Language: en-GB
To: Ma Ke <make24@iscas.ac.cn>, qmo@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 delyank@fb.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240821133112.1467721-1-make24@iscas.ac.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240821133112.1467721-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/21/24 6:31 AM, Ma Ke wrote:
> bpf_object__btf() can return NULL value.  If bpf_object__btf returns null,
> do not progress through codegen_subskel_datasecs(). This avoids a null ptr
> dereference.
>
> Found by code review, complie tested only.

Do you have a real case to show null ptr reference here?
Code review and compile test are not enough. You should have
a real reproducible case before you send the patch.

For this particular case, we have check

         btf = bpf_object__btf(obj);
         if (!btf) {
                 err = -1;
                 p_err("need btf type information for %s", obj_name);
                 goto out;
         }

which ensures that btf is available before codegen for subskeleton,
so what you described won't happen in practice.
  

>
> Cc: stable@vger.kernel.org
> Fixes: 00389c58ffe9 ("bpftool: Add support for subskeletons")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>   tools/bpf/bpftool/gen.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 5a4d3240689e..7ce62f280310 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -334,6 +334,9 @@ static int codegen_subskel_datasecs(struct bpf_object *obj, const char *obj_name
>   	const char *sec_name, *var_name;
>   	__u32 var_type_id;
>   
> +	if (!btf)
> +		return -EINVAL;
> +
>   	d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
>   	if (!d)
>   		return -errno;

