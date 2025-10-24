Return-Path: <bpf+bounces-72122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2A5C0735A
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 18:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B70519A7C73
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 16:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1307733C527;
	Fri, 24 Oct 2025 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtCVu/u3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A687333F8BB
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322221; cv=none; b=hscdVEHtyDp5PsT0RXOnVw0Jd3o7SsaUQhHDTqlI4ImNEXcqgyk3u3p35nfaUaQJKAkVZlJQ3r5+aCy0kQ2vJ882Q3rZjQ6PTjpnf0LNd7gL7Ii73RLPog+Ccp4sMvagZvsrqHuByPfRFdYAfcQ42jh0OC8zVFqfiAzmbc37cLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322221; c=relaxed/simple;
	bh=6dWqOVi91xmBk2F0HFTYgZLdqNtl2VQFXkFoCPL1e+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+G6E2X35D6UJ15766nA0vkWOQYWuXVK5+LTocl5tK00uhpoXF73rv0WLqtdAkTgd42Cgh1n24mXPcDBWL0gQT1a1zk8g2bR5AgLIX4tPd/9gYlYH4aBa9NrETzDKm4mxDZB/EeyK4tjD1DUGNMsStdIWC7yTMXVcYQUatHET4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtCVu/u3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-475c9881821so15156515e9.0
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761322218; x=1761927018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9sM467EkamVU3w5oRfZ6rK28IjRzCe43kWzxWpYs7Y=;
        b=QtCVu/u3Hpnp70Ez51VOlMusoFwUZJG+PaBclJi/pGfGD2wjyaAoouUI45PGYQM4FJ
         wQQxe7SiK1nUbOgFfJ4nNLDTcaSkuKi/4/AV5lnOldfTm/Fv0UX5mf8+4QnUJ4l/lrHl
         q10i3EN0OWQ+Jo/IAgPfQFbyN/Y0+guJoaBnMvStiLom03/MwlibFsArAzBZMM3WKQsk
         +nxZ7hUjSNFYF/w3RuVyfRu3l2HntzzTSfYin0PTu17ispw7W2o3x0ML2TOfSiv/0d1T
         JoGz/zUd/sgt20FPgcdUT8H1RI/kKBNHnl5ppqj3JRys37rveRdwrEHyGOtL0FMCUDvi
         97AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322218; x=1761927018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9sM467EkamVU3w5oRfZ6rK28IjRzCe43kWzxWpYs7Y=;
        b=E51Z5FkoiR2wpGbVaBfMmfaRDr25eEPOl99lUgCMM1aSTwELxfK/IBYDZXBahLoKhd
         rIwiI7DP1yIER9gkjBpUfR0FAS1BJz74JJrm4iiBif0MzDvwew4BXnOaD4PsVZrOISVX
         OqPsphl5BFCcRWTcdg2ahV5J/qSpxla2/dzEs1tCZLQ1vBjnRR/tP8xPtcU3O3lpLBi4
         vMzqc+aEH2N5FDYBM7vBBCtxjdZDpaNV7YOVJ3mR2lcYD5j3WlVxiGNhRv1Dtyt2QxoT
         R3f/g0DcwrlsoNluIkmK1EgO9WIurQbmc98jSCXZNdAkcRJHokX8E45tFLBqLG9xNio5
         U9Ag==
X-Gm-Message-State: AOJu0Ywa+DmZweMdfxzGgLSDGuDPsZFskBLluaOqtWeP/CaA1bSMIztD
	sShXS+40wloDDqm04fumJAGYUnAZ/euLSrEIGwIX/ci2pTDFmoJfgCyk
X-Gm-Gg: ASbGncucmBwRiFnkXOm2f1jk3umUfXiM2Lm5QHc89X41AifRezUfiWHntz95m1tDdPJ
	nGnwp0ZTTqxqEbLkvROZChf6dy1MA8p/HsrygdRCYXm8j2D0EfQOBT1xrPOUYByb48zXA0CUBTv
	HmVKjk+n7B5eDDRfcNfFrxPUCb3H/73aRlxIL4ErgrJC+dBK/YVSgZZUK3iIKjAC6jj+hgfm3gS
	C+sPhhx20j3wRjGTdumhFB5F0cNotw9aDtIoZleLj1oiPsRq8PgtaQBVlRmyVDKJbuGMcPCivnA
	UCJnfA9bH4HiKsbVkDGveLeneN14aT9LX+vtTR+wsCKveAFr2cOr9ROZRvmb6qmQjdtpoiDRqzb
	uHYzsIHqyl8LbGCtbDCJowSE3Rw3/DzrkXlUwhm9AKQ/RieqUs/nfsqeKVtvGVHooMzhdb6UVNl
	HKANg5wQcLkwtZRd66jgnLw4TBzpBA9MblM70EsBDo4Gjl9q3zmgw/UwUc4A82MLIp
X-Google-Smtp-Source: AGHT+IGx8rv85FTs5lIq4F0cePK6jih8i8OMcs8bGhykDzJ2cEJSZBuNlwezoht8Z2PtStFKanY6OA==
X-Received: by 2002:a05:6000:1446:b0:427:374:d91e with SMTP id ffacd0b85a97d-4298f545550mr3187774f8f.11.1761322217744;
        Fri, 24 Oct 2025 09:10:17 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898acc63sm10145748f8f.27.2025.10.24.09.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 09:10:17 -0700 (PDT)
Message-ID: <52d838df-73ba-4bc9-bb9f-f071572d981d@gmail.com>
Date: Fri, 24 Oct 2025 17:10:16 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: Conditionally include dynptr copy kfuncs
To: Malin Jonsson <malin.jonsson@est.tech>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, Yong Gu <yong.g.gu@ericsson.com>,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20251024151436.139131-1-malin.jonsson@est.tech>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251024151436.139131-1-malin.jonsson@est.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/24/25 16:14, Malin Jonsson wrote:
> Since commit a498ee7576de ("bpf: Implement dynptr copy kfuncs"), if
> CONFIG_BPF_EVENTS is not enabled, but BPF_SYSCALL and DEBUG_INFO_BTF are,
> the build will break like so:
>
>    BTFIDS  vmlinux.unstripped
> WARN: resolve_btfids: unresolved symbol bpf_probe_read_user_str_dynptr
> WARN: resolve_btfids: unresolved symbol bpf_probe_read_user_dynptr
> WARN: resolve_btfids: unresolved symbol bpf_probe_read_kernel_str_dynptr
> WARN: resolve_btfids: unresolved symbol bpf_probe_read_kernel_dynptr
> WARN: resolve_btfids: unresolved symbol bpf_copy_from_user_task_str_dynptr
> WARN: resolve_btfids: unresolved symbol bpf_copy_from_user_task_dynptr
> WARN: resolve_btfids: unresolved symbol bpf_copy_from_user_str_dynptr
> WARN: resolve_btfids: unresolved symbol bpf_copy_from_user_dynptr
> make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
> make[2]: *** Deleting file 'vmlinux.unstripped'
> make[1]: *** [/repo/malin/upstream/linux/Makefile:1242: vmlinux] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
>
> Guard these symbols with #ifdef CONFIG_BPF_EVENTS to resolve the problem.
>
> Reported-by: Yong Gu <yong.g.gu@ericsson.com>
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Malin Jonsson <malin.jonsson@est.tech>
> ---
>   kernel/bpf/helpers.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 8eb117c52817..eb25e70e0bdc 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4345,6 +4345,7 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
>   BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>   BTF_ID_FLAGS(func, bpf_local_irq_save)
>   BTF_ID_FLAGS(func, bpf_local_irq_restore)
> +#ifdef CONFIG_BPF_EVENTS
>   BTF_ID_FLAGS(func, bpf_probe_read_user_dynptr)
>   BTF_ID_FLAGS(func, bpf_probe_read_kernel_dynptr)
>   BTF_ID_FLAGS(func, bpf_probe_read_user_str_dynptr)
> @@ -4353,6 +4354,7 @@ BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SLEEPABLE)
>   BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE)
>   BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
>   BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> +#endif
>   #ifdef CONFIG_DMA_SHARED_BUFFER
>   BTF_ID_FLAGS(func, bpf_iter_dmabuf_new, KF_ITER_NEW | KF_SLEEPABLE)
>   BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)

It would be great to include
Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
in the commit message.

Some context for reviewers:
these kfuncs are defined in bpf_trace.c file which is conditionally built:
obj-$(CONFIG_BPF_EVENTS) += bpf_trace.o
We should guard kfuncs in helpers.c as well.


