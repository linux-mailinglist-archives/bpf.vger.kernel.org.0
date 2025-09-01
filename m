Return-Path: <bpf+bounces-67116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3AFB3E743
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 16:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16D71A86F70
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 14:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C3E33A02E;
	Mon,  1 Sep 2025 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ME194Z2D"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A6149C41
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737066; cv=none; b=KL3YEbbhaexlHpvrr3MONZuYSgumLLLJE6wXT86KLMFcpFdoxakiROlRtPR93oCCzykQEjutRSiRrqmLpCcchIUqcVaotr+YYRexo4Z5v9XQjlZAHdRiSvj7iPqGAY2iHTzQdetggVfHsALvfqtFM0lKDnilPcaB10D07nkoVK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737066; c=relaxed/simple;
	bh=hhXNKveroyOa6SUL4OB9gSmjm3tiQ5yrhK6pTmHqayc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=doRRB8fnMzEM5j4pZx+88UCS1Ky9g0wdZ3EW39qZZWmH/9vmRG2uy/7fyoBR4RK4otCsKO0hmdRMEgIMjh7cx3fDrDkPUqW1DroV1Z04zYS4yMor6Ywd1pH+qKZmnImY5ZhssHysFlEhwlP6mkK4XHmXUU8Mu8m20b14zlCSegc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ME194Z2D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756737062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nUYaeq9idzhAgy3kGcN1jl7xeqJL2afaZsvOUDSXRMg=;
	b=ME194Z2DQlXRkjchI3durtKiP2Al30e5xTr5Uc8Kztf/mZoo3S2/06Cyb7ZkdJs7ki8LWl
	RIKTVmHkfOPQpilt5YXQ+/4EA8pkUP1XrqcrSafvcvMoup0DRGwwq1zS5D+QIlA0ExFLW7
	CKtstvq1of9CnLYm2nK4VZ6tj4ozV4M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-4yFJwg86OrqM4rSjzQVR7w-1; Mon,
 01 Sep 2025 10:30:59 -0400
X-MC-Unique: 4yFJwg86OrqM4rSjzQVR7w-1
X-Mimecast-MFC-AGG-ID: 4yFJwg86OrqM4rSjzQVR7w_1756737057
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C460C19560B2;
	Mon,  1 Sep 2025 14:30:56 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.45.224.104])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8EE3319560B4;
	Mon,  1 Sep 2025 14:30:46 +0000 (UTC)
Date: Mon, 1 Sep 2025 16:30:42 +0200
From: Philipp Rudo <prudo@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton
 <jeremy.linton@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Simon Horman
 <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Viktor Malik <vmalik@redhat.com>, Jan Hendrik Farr
 <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young
 <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 bpf@vger.kernel.org, systemd-devel@lists.freedesktop.org
Subject: Re: [PATCHv5 06/12] kexec: Integrate with the introduced bpf kfuncs
Message-ID: <20250901163042.721db92d@rotkaeppchen>
In-Reply-To: <20250819012428.6217-7-piliu@redhat.com>
References: <20250819012428.6217-1-piliu@redhat.com>
	<20250819012428.6217-7-piliu@redhat.com>
Organization: Red Hat inc.
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Pingfan,


On Tue, 19 Aug 2025 09:24:22 +0800
Pingfan Liu <piliu@redhat.com> wrote:

> This patch does two things:
> First, register as a listener on bpf_copy_to_kernel()
> Second, in order that the hooked bpf-prog can call the sleepable kfuncs,
> bpf_handle_pefile and bpf_post_handle_pefile are marked as
> KF_SLEEPABLE.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Philipp Rudo <prudo@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: bpf@vger.kernel.org
> To: kexec@lists.infradead.org
> ---
>  kernel/kexec_pe_image.c | 67 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/kernel/kexec_pe_image.c b/kernel/kexec_pe_image.c
> index b0cf9942e68d2..f8debcde6b516 100644
> --- a/kernel/kexec_pe_image.c
> +++ b/kernel/kexec_pe_image.c
> @@ -38,6 +38,51 @@ static struct kexec_res parsed_resource[3] = {
>  	{ KEXEC_RES_CMDLINE_NAME, },
>  };
>  
> +/*
> + * @name should be one of : kernel, initrd, cmdline
> + */
> +static int bpf_kexec_carrier(const char *name, struct mem_range_result *r)
> +{
> +	struct kexec_res *res;
> +	int i;
> +
> +	if (!r || !name)
> +		return -EINVAL;
> +
> +	for (i = 0; i < 3; i++) {
> +		if (!strcmp(parsed_resource[i].name, name))
> +			break;
> +	}
> +	if (i >= 3)
> +		return -EINVAL;

Can you please replace the magic '3' by ARRAY_SIZE, just like you did
below when (un-)registering the listener.

Thanks
Philipp

> +
> +	res = &parsed_resource[i];
> +	/*
> +	 * Replace the intermediate resource generated by the previous step.
> +	 */
> +	if (!!res->r)
> +		mem_range_result_put(res->r);
> +	mem_range_result_get(r);
> +	res->r = r;
> +	return 0;
> +}
> +
> +static struct carrier_listener kexec_res_listener[3] = {
> +	{ .name = KEXEC_RES_KERNEL_NAME,
> +	  .alloc_type = 1,
> +	  .handler = bpf_kexec_carrier,
> +	},
> +	{ .name = KEXEC_RES_INITRD_NAME,
> +	  .alloc_type = 1,
> +	  .handler = bpf_kexec_carrier,
> +	},
> +	{ .name = KEXEC_RES_CMDLINE_NAME,
> +	  /* kmalloc-ed */
> +	  .alloc_type = 0,
> +	  .handler = bpf_kexec_carrier,
> +	},
> +};
> +
>  static bool pe_has_bpf_section(const char *file_buf, unsigned long pe_sz);
>  
>  static bool is_valid_pe(const char *kernel_buf, unsigned long kernel_len)
> @@ -159,6 +204,22 @@ __attribute__((used, optimize("O0"))) void bpf_post_handle_pefile(struct kexec_c
>  	dummy += 2;
>  }
>  
> +BTF_KFUNCS_START(kexec_modify_return_ids)
> +BTF_ID_FLAGS(func, bpf_handle_pefile, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_post_handle_pefile, KF_SLEEPABLE)
> +BTF_KFUNCS_END(kexec_modify_return_ids)
> +
> +static const struct btf_kfunc_id_set kexec_modify_return_set = {
> +	.owner = THIS_MODULE,
> +	.set = &kexec_modify_return_ids,
> +};
> +
> +static int __init kexec_bpf_prog_run_init(void)
> +{
> +	return register_btf_fmodret_id_set(&kexec_modify_return_set);
> +}
> +late_initcall(kexec_bpf_prog_run_init);
> +
>  /*
>   * PE file may be nested and should be unfold one by one.
>   * Query 'kernel', 'initrd', 'cmdline' in cur_phase, as they are inputs for the
> @@ -213,6 +274,9 @@ static void *pe_image_load(struct kimage *image,
>  	cmdline_start = cmdline;
>  	cmdline_sz = cmdline_len;
>  
> +	for (int i = 0; i < ARRAY_SIZE(kexec_res_listener); i++)
> +		register_carrier_listener(&kexec_res_listener[i]);
> +
>  	while (is_valid_format(linux_start, linux_sz) &&
>  	       pe_has_bpf_section(linux_start, linux_sz)) {
>  		struct kexec_context context;
> @@ -250,6 +314,9 @@ static void *pe_image_load(struct kimage *image,
>  		disarm_bpf_prog();
>  	}
>  
> +	for (int i = 0; i < ARRAY_SIZE(kexec_res_listener); i++)
> +		unregister_carrier_listener(kexec_res_listener[i].name);
> +
>  	/*
>  	 * image's kernel_buf, initrd_buf, cmdline_buf are set. Now they should
>  	 * be updated to the new content.


