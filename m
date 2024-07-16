Return-Path: <bpf+bounces-34898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61755932129
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 09:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F16EFB21FBD
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 07:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47538288BD;
	Tue, 16 Jul 2024 07:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhCyJZhe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233814C7B;
	Tue, 16 Jul 2024 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721114830; cv=none; b=bPzR1g8VpGp3F9oBXiSqasZfQs3FLp4ea/UvsFmoeq9UPVjcyLfjA7VAsAVFjwOl9HhPv7GU96L0ReADnrBdBL4Xfvz8TFxC7tiEOGovs0ZBwrK3jqm2ZUH9TX1bq53BrMq4HyOmdpsmqFbLmMsA3FqGNxM9UGG5Op3obhBrQaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721114830; c=relaxed/simple;
	bh=CP8dzmOWewv5d8dSvCsm8Baq5ODQR/cMJSNKrU2BW5Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sb0hIiN4LxDau5s59fwixFhkj4+TcqywAPT9+ecQgQqVIxdtpok06P0IW8+mlxqK09S2i/WotWXC9WSSRYDJmzp3vH+rVHsbZD58W1BVG+o3RneZPXt/CSLTyQqYH8FFOerYC4W+l4RSpyiKo2kiKKv55Gb0nMuppk9BNU4K1nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhCyJZhe; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3678aa359b7so3718077f8f.1;
        Tue, 16 Jul 2024 00:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721114827; x=1721719627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LQOLH0v1v0tlObKdv/4aTYk8XeecQc43XZLmd4zClzM=;
        b=UhCyJZhezQLsSASa2j/YME0AMWC9VdWCaJjwvAu4lZVyIsaiycc4aZYEp75Cu/6AZ0
         Zzf/iEo7/K1g4YK2ZRJ8qsC7WBU0LwBSSmD3v/vD27wUrFgf57AJ80JPWzvkX9FcOxfM
         9QjkcdldzkmIHPYee/0/qdIKHEhb2u6c/3cVpP4EoAfcdg43SCzkwqyQsD3KHgeG1+YB
         TKTyLV3SyKJhjVLW0v2hRsl22BbZ7/KBY9/60Fygwoo0efluJevtQ2n2qfO/RLUGZn0d
         D6NYWcBv/jK3i0R+7Z/unzUUpg4P76U2cH5CQYPaHd15mpEcPkR/xg5IGhtK1wDpZsw1
         BFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721114827; x=1721719627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQOLH0v1v0tlObKdv/4aTYk8XeecQc43XZLmd4zClzM=;
        b=P4V9/08b/v035IpJ6Nr6WLOnVccM5qww2ueYJI2zImCZlczFq+CPDrtqr5HwEizf3k
         M7J90405PSIvMOBuXIFATovwJ7WqmxY/dUFbm25NElUpd2xkrH8tzPSnvXVPpkk9PLei
         FF4xSGgYFyi01JMl+bPUtAmFE9P5bnPg/nYhFTBSIVHwxmOrsYuV2n39vFv93qjXWrJQ
         e+lYrt3jR1gRXl0ZXelA0h+ZTx6gGUMBcoCnaxzGdaY2+/rw/9w0sKgVi6njiOIphF9O
         JGQwlnmEwItOf9VjnVIQhQ+WbDGlNM3duLh6yn6VYQLfAuBRHuQagMCpbUrUltEY776s
         uYZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL/RJVoAyX3lfiFygjSJrc5kCBkiIGdkPcKfYwFaryGWjrQwQw5ZLPh6pNBoJXVsXT4KShvVtw4rvZYHc4R4r15jQNXKdeGowAq7WTyYFiTA==
X-Gm-Message-State: AOJu0YxNjtcg38OXDxG9F2ChR0PTTizXBohuwN4pntLqI8SEYbcRAMO2
	7WKlTA9H4Xuv8IlkN7zK9BkwAtYCCJjlgs2NP+Yljfi2pJX5jnlM
X-Google-Smtp-Source: AGHT+IHpQgnDgJ6AA/MZ1Gtk7aTCSAjg3TWGYKlDAVgfr+1kdfnLPmSjp1F7wXJ6zHMjPZrn3zJ/LA==
X-Received: by 2002:a5d:5f4d:0:b0:366:e09c:56be with SMTP id ffacd0b85a97d-368273500b0mr766305f8f.6.1721114827304;
        Tue, 16 Jul 2024 00:27:07 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbf4bsm8185224f8f.73.2024.07.16.00.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 00:27:07 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 16 Jul 2024 09:27:05 +0200
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
	Krister Johansen <kjlx@templeofstupid.com>, houtao1@huawei.com
Subject: Re: [PATCH bpf-next] perf/bpf: Use prog to emit ksymbol event for
 main program
Message-ID: <ZpYgyUZi8qrB8GFX@krava>
References: <20240714065533.1112616-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240714065533.1112616-1-houtao@huaweicloud.com>

On Sun, Jul 14, 2024 at 02:55:33PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Since commit 0108a4e9f358 ("bpf: ensure main program has an extable"),
> prog->aux->func[0]->kallsyms is left as uninitialized. For bpf program
> with subprogs, the symbol for the main program is missed just as shown
> in the output of perf script below:
> 
>  ffffffff81284b69 qp_trie_lookup_elem+0xb9 ([kernel.kallsyms])
>  ffffffffc0011125 bpf_prog_a4a0eb0651e6af8b_lookup_qp_trie+0x5d (bpf...)
>  ffffffff8127bc2b bpf_for_each_array_elem+0x7b ([kernel.kallsyms])
>  ffffffffc00110a1 +0x25 ()
>  ffffffff8121a89a trace_call_bpf+0xca ([kernel.kallsyms])
> 
> Fix it by always using prog instead prog->aux->func[0] to emit ksymbol
> event for the main program. After the fix, the output of perf script
> will be correct:
> 
>  ffffffff81284b96 qp_trie_lookup_elem+0xe6 ([kernel.kallsyms])
>  ffffffffc001382d bpf_prog_a4a0eb0651e6af8b_lookup_qp_trie+0x5d (bpf...)
>  ffffffff8127bc2b bpf_for_each_array_elem+0x7b ([kernel.kallsyms])
>  ffffffffc0013779 bpf_prog_245c55ab25cfcf40_qp_trie_lookup+0x25 (bpf...)
>  ffffffff8121a89a trace_call_bpf+0xca ([kernel.kallsyms])
> 
> Fixes: 0108a4e9f358 ("bpf: ensure main program has an extable")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
> Hi,
> 
> ksymbol for bpf program had been broken twice, and I think it is better
> to add a bpf selftest for it, but I'm not so familiar with the
> perf_event_open(), for now I just post the fix patch and will post the
> selftest later.

good idea, lgtm

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
>  kernel/events/core.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f0128c5ff278..e1b7d9e61fa0 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9289,21 +9289,19 @@ static void perf_event_bpf_emit_ksymbols(struct bpf_prog *prog,
>  	bool unregister = type == PERF_BPF_EVENT_PROG_UNLOAD;
>  	int i;
>  
> -	if (prog->aux->func_cnt == 0) {
> -		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF,
> -				   (u64)(unsigned long)prog->bpf_func,
> -				   prog->jited_len, unregister,
> -				   prog->aux->ksym.name);
> -	} else {
> -		for (i = 0; i < prog->aux->func_cnt; i++) {
> -			struct bpf_prog *subprog = prog->aux->func[i];
> -
> -			perf_event_ksymbol(
> -				PERF_RECORD_KSYMBOL_TYPE_BPF,
> -				(u64)(unsigned long)subprog->bpf_func,
> -				subprog->jited_len, unregister,
> -				subprog->aux->ksym.name);
> -		}
> +	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF,
> +			   (u64)(unsigned long)prog->bpf_func,
> +			   prog->jited_len, unregister,
> +			   prog->aux->ksym.name);
> +
> +	for (i = 1; i < prog->aux->func_cnt; i++) {
> +		struct bpf_prog *subprog = prog->aux->func[i];
> +
> +		perf_event_ksymbol(
> +			PERF_RECORD_KSYMBOL_TYPE_BPF,
> +			(u64)(unsigned long)subprog->bpf_func,
> +			subprog->jited_len, unregister,
> +			subprog->aux->ksym.name);
>  	}
>  }
>  
> -- 
> 2.29.2
> 

