Return-Path: <bpf+bounces-40532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8EA98990C
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 03:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C421C21210
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 01:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B307462;
	Mon, 30 Sep 2024 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVzVrz42"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0F0566A
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727661243; cv=none; b=VK+fPIUp/iUcyDtdoDwt4UMxScpKLKfaOZhzq3RILyTd8Ts26ila+iMXuThsodI8wZEqXyy7fwPjH29mAW+HVziMb8PTd9vH16neY6rytGViTSRLwlf4TW7MZQ3qTuTb135ClYk3Z72QAT+mTGuDQaxMnlRcFZi9jfHkYdYUedM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727661243; c=relaxed/simple;
	bh=ZC3tipw6SS0D8iHTc96Y2nrfPd2aYiHnWzhwTZG67QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWRONFz7X3keVbw1p8MS2HyTjjxUscT6+ppxD6haXcJj8D0VcHKtalF8fE3cW+vGTNcU9kUrSYNco7MqGSY9euAN1nuiyE4T6vkDJU2WYG3Ye+4M/jcB4cGoCZ4NP/VnsX9pSItVbQDElilJUKQOqmbzrfKT0YBE4TM5R5ea1v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVzVrz42; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db299608e7so2373361a12.1
        for <bpf@vger.kernel.org>; Sun, 29 Sep 2024 18:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727661241; x=1728266041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ILlI8xKhZqM7U7CmBhhnnrmHSc6+v4BS3Y5OQ+sLyU=;
        b=HVzVrz42hQ1k5KoIbIah6BfnQ11EcWUBrevGHWrwSfwqWGUhmOJlj0EUb5Lufs8jNu
         M3QvTZbIN9JiWs0r5e43OadOgz9a/3UNW0JiGW4h2oBEDZjzq1xpzjTM781tCv9VLn+k
         NT8mXwSKD8PzTOCo5TLrLQUbgt+3gyICsGcgmZI6NnD8ugsFCvuEUyMxFcsVAyNMPpS3
         6Z8J+4fm0oUwZUonUp3L01hh6qpY9tVSEgZ2FoCNuLaoyEIfga3PIuI1IsSjiPP4pbap
         LAh73WlNKuJi4qCnn6Fxe7Ey++OcRy5yNwawobXa3LAYEryehG5CrxycTKuZwqvxKpTU
         N56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727661241; x=1728266041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ILlI8xKhZqM7U7CmBhhnnrmHSc6+v4BS3Y5OQ+sLyU=;
        b=YBrAjWDBAnHkoBzqKyzMAgE/iwzdfgwv8ibUp6+fXwSKce4D/A6yoW82awlNcCie50
         NFcypkHaqw/ZeRRxhQonK2upvbPP/mCEGI8GFnS1uisNH8yaah6AGX8BWAvKsKlcA25J
         gimY999BZ4Kn4vi2PeXCtecjiESzCuXdg6x3pJDjZPiVO0PJ+Yf4FHVzAbdPo/1gmpi2
         Se3S0d6h3V6CWwe5df+580Jo8dq1zKImfeQbhhFkipaXOaVgxivJSF/Hu8ndLsjrY8HD
         1MzhPCWcKTRVAmru63T3dtGDqVJvq6QZsft1MqyRG/otJ/LvrnF6Fe9VADY80ScCWNn6
         s9Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVXuIvnvp4WYYTKBXmMOUI6UQy2fU7BOB35NfllJ/tOKATPAGhMLsCeX5kdHSEcaEoym44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe6huS+JgLRRU9BQcSUDr+qFExc/sY3fC/kM+qmxq+oQ63Hwuw
	GbsC4e20bYrAGb5l2ypSX9ngaSTgM6nVxIur2/jQMJga7CV6YDjX
X-Google-Smtp-Source: AGHT+IH/v3hZVZUebLEDf5cbSCxXBQM7OsbUJE7hcMQq3jnFy1QW1AI/+DQhkHjcuINtV9tOM6b6tw==
X-Received: by 2002:a17:902:e94d:b0:20b:8d7f:d13 with SMTP id d9443c01a7336-20b8d7f0f82mr18175495ad.58.1727661241254;
        Sun, 29 Sep 2024 18:54:01 -0700 (PDT)
Received: from [10.22.68.152] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e2f798sm44883325ad.183.2024.09.29.18.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 18:54:00 -0700 (PDT)
Message-ID: <378aa2d5-6359-4e89-a228-7ea47ba563c3@gmail.com>
Date: Mon, 30 Sep 2024 09:53:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Prevent extending tail callee prog
 with freplace prog
Content-Language: en-US
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, puranjay@kernel.org,
 xukuohai@huaweicloud.com, eddyz87@gmail.com, iii@linux.ibm.com,
 kernel-patches-bot@fb.com
References: <20240929132757.79826-1-leon.hwang@linux.dev>
 <20240929132757.79826-3-leon.hwang@linux.dev>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20240929132757.79826-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/9/24 21:27, Leon Hwang wrote:
> Alongside previous patch, the infinite loop issue caused by combination of
> tailcal and freplace can be prevented completely.
> 
> The previous patch can not prevent the use case that updates a prog to
> prog_array map and then extends subprog of the prog with freplace prog.
> 
> This patch fixes the case by preventing extending a prog, which has been
> updated to prog_array map, with freplace prog.
> 
> If a prog has been updated to prog_array map, it or its subprog can not
> be extended by freplace prog.
> 
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h   |  3 ++-
>  kernel/bpf/arraymap.c |  9 ++++++++-
>  kernel/bpf/syscall.c  | 11 +++++++++++
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index aac6d2f42830c..dc19ad99e2857 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1484,7 +1484,8 @@ struct bpf_prog_aux {
>  	bool exception_cb;
>  	bool exception_boundary;
>  	bool is_extended; /* true if extended by freplace program */
> -	struct mutex ext_mutex; /* mutex for is_extended */
> +	u32 prog_array_member_cnt; /* counts how many times as member of prog_array */
> +	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
>  	struct bpf_arena *arena;
>  	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
>  	const struct btf_type *attach_func_proto;
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 4a4de4f014be9..91b5bdf4dc72d 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -957,6 +957,8 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
>  
>  	mutex_lock(&prog->aux->ext_mutex);
>  	is_extended = prog->aux->is_extended;
> +	if (!is_extended)
> +		prog->aux->prog_array_member_cnt++;

prog_array_member_cnt must check U32_MAX before incrementing. Or it will
overflow u32. So it will be better like:

	mutex_lock(&prog->aux->ext_mutex);
	is_invalid = prog->aux->is_extended || prog->aux->prog_array_member_cnt
== U32_MAX;
	if (!is_invalid)
		prog->aux->prog_array_member_cnt++;
	mutex_unlock(&prog->aux->ext_mutex);
	if (is_invalid)
		goto out_put_prog;

Thanks,
Leon


