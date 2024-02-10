Return-Path: <bpf+bounces-21689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4887C850291
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 05:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B4F285E2B
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 04:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309AB5C9C;
	Sat, 10 Feb 2024 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1JGJI+m"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBA2D297
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 04:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707540766; cv=none; b=k5LMjsCwYaQBEu8Xyz78A9VVsAfr4aE2EaKpxHkRvQgUk+hxXyZ+vYLv/ttd3ht0wToHrfAi6vH2KX0H1ELGv39InniXJgg3oNNkvu1PpSsr0YmCfS+AG1JRqZEzwV8juy5bN3q67MgwVjPVnbl+juN/8HUlaaZo0akEJwPhoUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707540766; c=relaxed/simple;
	bh=KDvg7ahUV9WCuT4zXXUxJ3UGIhPuo0Pul577lz6ROX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFbdkd7/SyjvVSt/5QtyoVn4FVMMETGG47qCuCOgQJzoJntac71GZde8VbVUf7e7FiZ55pqytVM6l1J45OuCggxwaEPjPEvZ27DL+HyPNQinV8jBDecKitrFi6AdiRTxaZG4PaBLQuP4qdkcngoeAHadeYNtEP/EAsmyOphWUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1JGJI+m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707540764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dr2blnizYNbzYeHmXAd3S8ONSINWlTab6ZkCItA7o0c=;
	b=E1JGJI+mLJrBANBqY0vbFOAbJC6K5bhkDTHN4bHhBcDN4HVfJHsLXZsW1y8k6lyTZ1SVWt
	6+yuuxogGnPCPPj4sBk16qQWNE8vEdexDl5LmJ4TXz3sqgzMJqk6YDbTrRhykduGkwsqZP
	wYSCevLQK4m/xRzZVfV3KTtCK9mhvRI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-hwSivvsfMH-pKZX2U5rqqw-1; Fri, 09 Feb 2024 23:52:38 -0500
X-MC-Unique: hwSivvsfMH-pKZX2U5rqqw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F09D185A788;
	Sat, 10 Feb 2024 04:52:37 +0000 (UTC)
Received: from localhost (unknown [10.72.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 95DA2492BC7;
	Sat, 10 Feb 2024 04:52:36 +0000 (UTC)
Date: Sat, 10 Feb 2024 12:52:33 +0800
From: Baoquan He <bhe@redhat.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, Kexec-ml <kexec@lists.infradead.org>,
	akpm@linux-foundation.org, Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH linux-next] bpf: fix warning for crash_kexec
Message-ID: <ZccBEYcrt3ZsduWZ@MiWiFi-R3L-srv>
References: <20240209123520.778599-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209123520.778599-1-hbathini@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 02/09/24 at 06:05pm, Hari Bathini wrote:
> With [1], CONFIG_KEXEC & !CONFIG_CRASH_DUMP is supported but that led
> to the below warning:
> 
>   "WARN: resolve_btfids: unresolved symbol crash_kexec"
> 
> Fix it by using the appropriate #ifdef.
> 
> [1] https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---

Good catch, thanks for fixing it.

Acked-by: Baoquan He <bhe@redhat.com>

>  kernel/bpf/helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 4db1c658254c..e408d1115e26 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2545,7 +2545,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(generic_btf_ids)
> -#ifdef CONFIG_KEXEC_CORE
> +#ifdef CONFIG_CRASH_DUMP
>  BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
>  #endif
>  BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
> -- 
> 2.43.0
> 


