Return-Path: <bpf+bounces-66058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F78B2D255
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 05:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3275B724535
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 03:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3484326F2A6;
	Wed, 20 Aug 2025 03:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1xZdn9z"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4DB26B0BE
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659376; cv=none; b=NL2+tjPaEchLHq4iltyFoK44sBmkX4ogfKgrvv57XAW+uo++3UE7de/ZfNPfixO09e166uzB5Yp6SWiQq8DaiGd22Nzc23ujihyIMxtHS2ZFdfIcL+4ZiAsA9mI5uvKssbm9DDDpS6yhjv9AnmlWtzUYSBctlj+6w1/nQYqvIpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659376; c=relaxed/simple;
	bh=XHFQ0jV9kI4IqQmZhxm8kr7P9/KKxuvLT4XuiWExA8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr2I9tAV+Q7nAnjIIzAkLjyo/r1DE0AJiX1YaRzpk70iuwUfQ3yoFrLt5K9VF8jm2kGgM9Of5CWv6iWtnt1RaQGXN+QulbuMIewMtoz00rBdv85riD+/Namwo6P7thFOqrQTc926UhCS2S2nWeN1fhA98VpZp9u4bj9CEnWXSt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1xZdn9z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755659373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wI3J5CQvGDPM9MDcFPBYlPpxyIDbUJTJvO8poXdYAMY=;
	b=h1xZdn9z7Xv+/khv9DDZEm244zekwKDuly7dKObBnE9wZccxDHqaMYx2Pgpfp47XFApfTr
	Awa+hKQIRZr+dCVj9iynxfjBVGU4kgfEbf7aQ5ntvD5/HWxfQjQN6M0d+tinf5r/J1Vrvp
	HiyOXdcgDavbuSdAO/YHoEKJQ4Pvb2A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-0NjdYgtVO9a9N3OTmI1r_A-1; Tue,
 19 Aug 2025 23:09:30 -0400
X-MC-Unique: 0NjdYgtVO9a9N3OTmI1r_A-1
X-Mimecast-MFC-AGG-ID: 0NjdYgtVO9a9N3OTmI1r_A_1755659367
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 438F518004A7;
	Wed, 20 Aug 2025 03:09:21 +0000 (UTC)
Received: from localhost (unknown [10.72.112.115])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF05C19560B0;
	Wed, 20 Aug 2025 03:09:17 +0000 (UTC)
Date: Wed, 20 Aug 2025 11:09:15 +0800
From: Pingfan Liu <piliu@redhat.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>, Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org
Subject: Re: [PATCHv5 10/12] arm64/kexec: Add PE image format support
Message-ID: <aKU8WwF77ZTixxPn@fedora>
References: <20250819012428.6217-1-piliu@redhat.com>
 <20250819012428.6217-11-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819012428.6217-11-piliu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Aug 19, 2025 at 09:24:26AM +0800, Pingfan Liu wrote:
> Now everything is ready for kexec PE image parser. Select it on arm64
> for zboot and UKI image support.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> To: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/Kconfig                     | 1 +
>  arch/arm64/include/asm/kexec.h         | 1 +
>  arch/arm64/kernel/machine_kexec_file.c | 3 +++
>  3 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e9bbfacc35a64..97d9595a5ee86 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1608,6 +1608,7 @@ config ARCH_SELECTS_KEXEC_FILE
>  	def_bool y
>  	depends on KEXEC_FILE
>  	select HAVE_IMA_KEXEC if IMA
> +	select KEXEC_PE_IMAGE

According to the kernel test robot's report, this may fail due to a dependency issue. 
I will fix it in the next version as:
        select KEXEC_PE_IMAGE if DEBUG_INFO_BTF && BPF_SYSCALL
This dependency is introduced in patch [5/12].

Cc Catalin, since I'm making changes to address this issue, I'll drop your ack 
in the next version and would appreciate if you could review it again.

Thanks,

Pingfan
>  
>  config ARCH_SUPPORTS_KEXEC_SIG
>  	def_bool y
> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 4d9cc7a76d9ca..d50796bd2f1e6 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -120,6 +120,7 @@ struct kimage_arch {
>  
>  #ifdef CONFIG_KEXEC_FILE
>  extern const struct kexec_file_ops kexec_image_ops;
> +extern const struct kexec_file_ops kexec_pe_image_ops;
>  
>  int arch_kimage_file_post_load_cleanup(struct kimage *image);
>  #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index af1ca875c52ce..7c544c385a9ab 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -24,6 +24,9 @@
>  
>  const struct kexec_file_ops * const kexec_file_loaders[] = {
>  	&kexec_image_ops,
> +#ifdef CONFIG_KEXEC_PE_IMAGE
> +	&kexec_pe_image_ops,
> +#endif
>  	NULL
>  };
>  
> -- 
> 2.49.0
> 


