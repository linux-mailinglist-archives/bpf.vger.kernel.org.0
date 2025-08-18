Return-Path: <bpf+bounces-65871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ABDB29E88
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 11:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130273B6C1F
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 09:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA52273D77;
	Mon, 18 Aug 2025 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/Yeo2Wr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45C30FF20;
	Mon, 18 Aug 2025 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510963; cv=none; b=Cq7Jpd9jEza26dy6cOb1Cfv7BtWm8Alki4WTUokSK2+3jUqkS7NCdGD7sqWEmRpCBQYQPXtvg+YIBPpPsZ76d0ofGqLGp99GgSSanf2ZAIaiA0kSiBOcsm2/MWe9VS97q1j6RhZKhTPG4qEV2XSIhh3ySL4mexgoBoqFnm2/4H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510963; c=relaxed/simple;
	bh=1lwTcuQs3PskiizA9ekyNKD+GSvBsWBqRnnJ951KJvk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tA3THg4SThZVUEWxmETf2IVkuaOusCThbrjljSNXXj23/GRzsV37c21ph4KzQPVgYugMT26qq/1VJtmC1cM8UBK2sPnkQ1R468VHJFCgB8XDOqG1yAZ5lQ54MokR9ExNBmusplJI1hmN5z9mP2WLeeou+rFuRxuhzEq8PPJCNjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/Yeo2Wr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b00e4a1so25714825e9.0;
        Mon, 18 Aug 2025 02:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755510960; x=1756115760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3oRQru3gew2EIPWLHHj5TTyDNuIZGAGLZO/bmpncjjo=;
        b=F/Yeo2Wr15HkUN5K35WSqYNRpEBKtA4H1XiXMviH+VWMMsWHw8TDMRFgzz08bcBr/U
         vH/gxMRn6GMkGLtBf25qi2F98t5mhKn30cm0h/m/zqSKEAk0Ks/Cr8AWKgAWxPlszKqo
         AqcXFltR/Nzfd0cxZ+6iO73+F/A3LXGv7ah5pkiwxXH+KsnEMnNgfJb2jXoVY34Z46El
         UQ8iLAe6LcK8g2KaN0j1Bz6CC9nDuDMykNwu5KadAw9MAI/QVfKvg7Id4UUlxl7s9dBL
         B43csaGdkXOPt906oNFWJJ3UOUv2x+c8B9XbQzl820T0z3D2bD7oMi5SgLjDDmvGWNhr
         K+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755510960; x=1756115760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oRQru3gew2EIPWLHHj5TTyDNuIZGAGLZO/bmpncjjo=;
        b=KXrCiCJhFySlcovwe9vEPrWHGyRI+rbl1GuZMVblQh31d6WSqXLiXa6V24H7lAcFaT
         aTrNHnhD/vALXyInZq1fsFtJ3L+9hrFkS5McQ3R8NbIhKjcNUve5/nGdoWnuJZh8Nf+b
         AMqmAtOCdYwOnDg2z66IEpy7OxpSbyngCna878aj9YYuxwjDm1cjjgwGbEfU1pUaSExT
         jbWdJ0AdaqaIqI6R5vKs2r8FND3ppAtCSiKA316rZIlWSOBuwrjlDHUvsi/dO1nAPBJ1
         9nHcDtOjEQmWlTBxiilRGriDQ8NubfGXQa2KuwAWY1YLKxREQYDvN+YdccYKySB94sZ3
         ERkw==
X-Forwarded-Encrypted: i=1; AJvYcCWjJdygD6/bR6GPvHImHO7urX8h5oFGeI5CGMhPXqxkHL03Mguir+h8z1JLxJJ3TUoblOweP/BzqECqxS/J@vger.kernel.org, AJvYcCWkZ+IeO4zq4kMoNhTekuDS/mNOm5FwkiFoV68FEY93GQCb7O7SFtWhSn8KeZ8pYUrgxRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3dviUO5F2oF8UYTTGLUDSmE+Sl7X/6Yftex7ChAiZ3KvyBvRi
	B9rgofbu7NEfiwLJ/MFyMy816wyvJfqX6f91MmR/qSh1RcHvmWpA7C/u
X-Gm-Gg: ASbGncuFkSdJsNk55JLbF50v9zM9WPL91Pv+DIDUE9DjDuthGGD4iBa+nkIb+ceFVM+
	0bApvG18LwTKdcPXuLIvW+KGAXupY1kI+Fz9MnBIP5vGQB+04lmPs+2/X5bJzvctU5S1tk6ihLq
	Wcjvy8K379gszXcNyiqJpZoJADPUFJVdCYoAsY6DG9IZTweriQCF7tn4YaDuRny6pTLkA4Z+P7S
	vKu1JIp3uAtttxT8eByF1inVYWDet36a4/5sd1T4PwsaA5Vuj3uUJOj3SEvkCEjavfHQKh+RPEY
	mUHFiSWBd6hiIOMvWFeMVbk6hnXBWPr2b5eBtv1bhW3cP92EUaOPSJf2Vbx5WnwFExbfxdXl
X-Google-Smtp-Source: AGHT+IG+4FJgOk7tgAjcYQmF5w7tpduhFcNyLI9kWl8zL+KJ9jaeTcdUSLs+BUhcG+uffVppdSawmw==
X-Received: by 2002:a05:600c:4ec9:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-45a2186486bmr79029285e9.32.1755510959424;
        Mon, 18 Aug 2025 02:55:59 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a2232de40sm123956115e9.26.2025.08.18.02.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:55:58 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 18 Aug 2025 11:55:56 +0200
To: chenyuan_fl@163.com
Cc: yonghong.song@linux.dev, olsajiri@gmail.com,
	aef2617b-ce03-4830-96a7-39df0c93aaad@kernel.org, andrii@kernel.org,
	ast@kernel.org, bpf@vger.kernel.org, chenyuan@kylinos.cn,
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, qmo@kernel.org
Subject: Re: [PATCH v6 2/2] bpftool: Add CET-aware symbol matching for x86_64
 architectures
Message-ID: <aKL4rB3x8Cd4uUvb@krava>
References: <74709a08-4536-4c5a-8140-12d8b42e97c0@linux.dev>
 <20250815025227.6204-1-chenyuan_fl@163.com>
 <20250815025227.6204-3-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815025227.6204-3-chenyuan_fl@163.com>

On Fri, Aug 15, 2025 at 03:52:27AM +0100, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> Adjust symbol matching logic to account for Control-flow Enforcement
> Technology (CET) on x86_64 systems. CET prefixes functions with
> a 4-byte 'endbr' instruction, shifting the actual hook entry point to
> symbol + 4.
> 
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
>  tools/bpf/bpftool/link.c | 50 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index a773e05d5ade..6787971d3167 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -282,11 +282,52 @@ get_addr_cookie_array(__u64 *addrs, __u64 *cookies, __u32 count)
>  	return data;
>  }
>  
> +static bool is_x86_ibt_enabled(void)
> +{
> +#if defined(__x86_64__)
> +	struct kernel_config_option options[] = {
> +		{ "CONFIG_X86_KERNEL_IBT", },
> +	};
> +	char *values[ARRAY_SIZE(options)] = { };
> +	bool ret;
> +
> +	if (read_kernel_config(options, ARRAY_SIZE(options), values, NULL))
> +		return false;
> +
> +	ret = !!values[0];
> +	free(values[0]);
> +	return ret;
> +#else
> +	return false;
> +#endif

nit, we could store the result to 'static bool enabled' in this function,
so we would not need to pass is_ibt_enabled arg below, and just call
is_x86_ibt_enabled directly, but up to you

> +}
> +
> +static bool
> +symbol_matches_target(__u64 sym_addr, __u64 target_addr, bool is_ibt_enabled)
> +{
> +	if (sym_addr == target_addr)
> +		return true;
> +
> +	/*
> +	 * On x86_64 architectures with CET (Control-flow Enforcement Technology),
> +	 * function entry points have a 4-byte 'endbr' instruction prefix.
> +	 * This causes kprobe hooks to target the address *after* 'endbr'
> +	 * (symbol address + 4), preserving the CET instruction.
> +	 * Here we check if the symbol address matches the hook target address
> +	 * minus 4, indicating a CET-enabled function entry point.
> +	 */
> +	if (is_ibt_enabled && sym_addr == target_addr - 4)
> +		return true;
> +
> +	return false;
> +}
> +
>  static void
>  show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
>  {
>  	struct addr_cookie *data;
>  	__u32 i, j = 0;
> +	bool is_ibt_enabled;
>  
>  	jsonw_bool_field(json_wtr, "retprobe",
>  			 info->kprobe_multi.flags & BPF_F_KPROBE_MULTI_RETURN);
> @@ -306,8 +347,10 @@ show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
>  	if (!dd.sym_count)
>  		goto error;
>  
> +	is_ibt_enabled = is_x86_ibt_enabled();
>  	for (i = 0; i < dd.sym_count; i++) {
> -		if (dd.sym_mapping[i].address != data[j].addr)
> +		if (!symbol_matches_target(dd.sym_mapping[i].address,
> +					   data[j].addr, is_ibt_enabled))
>  			continue;
>  		jsonw_start_object(json_wtr);
>  		jsonw_uint_field(json_wtr, "addr", dd.sym_mapping[i].address);
> @@ -719,6 +762,7 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
>  {
>  	struct addr_cookie *data;
>  	__u32 i, j = 0;
> +	bool is_ibt_enabled;
>  
>  	if (!info->kprobe_multi.count)
>  		return;
> @@ -742,9 +786,11 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
>  	if (!dd.sym_count)
>  		goto error;
>  
> +	is_ibt_enabled = is_x86_ibt_enabled();
>  	printf("\n\t%-16s %-16s %s", "addr", "cookie", "func [module]");
>  	for (i = 0; i < dd.sym_count; i++) {
> -		if (dd.sym_mapping[i].address != data[j].addr)
> +		if (!symbol_matches_target(dd.sym_mapping[i].address,
> +					   data[j].addr, is_ibt_enabled))
>  			continue;
>  		printf("\n\t%016lx %-16llx %s",
>  		       dd.sym_mapping[i].address, data[j].cookie, dd.sym_mapping[i].name);

I wonder should we display the kprobe attached address instead of symbol
address in here

otherwise the patchset lgtm

thanks,
jirka

