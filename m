Return-Path: <bpf+bounces-60699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14A4ADA99A
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 09:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57507168D74
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 07:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1795B20010C;
	Mon, 16 Jun 2025 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRm7G+2O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D070D1F2C45;
	Mon, 16 Jun 2025 07:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750059622; cv=none; b=j5dlBklxkhHDF5cZbCVVMNC6zGMjmfYrvbvJaK6Qi0EikoOOCFttqTFMIPxoyckxln7HArCBbbjUdLd8lT1YMsearHCb33b5Xb7HHe/76tDu4Iuppn4KL7Gd0WUPxC7XJ6L1Ad7F4FYOwnF0xipaTv+sJSTCILgjvXpCmtZ5Okk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750059622; c=relaxed/simple;
	bh=9R521yEvSoTRMuAWEVwLtelRmMlrAZtGKB1H7DGvnvc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKl6BNjVraJySZdAichQQjpbmkBCUHutb6jRVBQHOHlAddPfvAoJVQfcISdrzskiEkL4OfMihAb/l29qUpXwt6kZ9YM5ZKEW4IHowfAA5Z/sAIfD8fSCUSkfNNgM6By5V27xNtWIwx2yR+1ZysXgXkOoFG/SPPfCwrJIiwSoF64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRm7G+2O; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad88d77314bso925030266b.1;
        Mon, 16 Jun 2025 00:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750059619; x=1750664419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h/VFqzJdBv7JH//nNz8fWrMW7ma2acRIz+sTqvArf+s=;
        b=CRm7G+2Op+0XpT6VJ42d3QVh+vTH+SA0Tf8I2fJxeRehzgRquoB85MCuq6EvVUK1Ab
         QdEAxpF2vd7Al5LFj8jxwWxyo+Naz2RB+2YBi+55b78MPSvGvmHKr+vp6D6v0jo5oJ6r
         6YKMuXmixbUabKKuEnrpmVNe7i4/b4aEd8MoJ8LJ8HCGKD6U9LPALLFi632ylaZaJdVp
         XBgWMfWuMy5gauC/gR6dw6DELgkhbQjlZdJUVtTLzxsFxp5XBNoquabANZ17pvz822Gw
         L51LrG+5IuPjHa0lVntmmkxttMllZIzpQWhniKROB0AzBObDQJmCn4wsztPYDYZTghTq
         Zwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750059619; x=1750664419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/VFqzJdBv7JH//nNz8fWrMW7ma2acRIz+sTqvArf+s=;
        b=MoXORlkFKRBWFRTbg42EcbChu0KlmubcRu5IuUgL8B4/1hEKE6R0wOZYzFcw4qrQeR
         D+NOlqMWxRQLNzgsWk+aOAqtXWTgAqbwTweEnMxquqeIccYZHjl1sx5sAWpHtune+FDP
         v5WZmkF17tZXcuKimf/yv3DdAsxAP2XgvP/ew+SO8nkirdN84cVXYL3dNa+NFT6WBN0M
         wVkVk1o9ACYN/ET2obs0U8V3xUAvuOutvkitngCcMBvtbmQzKAD5LUyi6RW7vkqBarD1
         2mRZgf5AKIEEwopKgcTx0R8kgVoQ6pdzPGqH841+OivBnkM7yyOQM8aY/vnYY0oGVKdw
         cGSw==
X-Forwarded-Encrypted: i=1; AJvYcCVlugjQWHZWZcTIVx6vWsWQks1bpzhyhV1VU73uAzq/BiIRS+DLL9953xhupsT/Qbd4kHY=@vger.kernel.org, AJvYcCX/Hg5VxZIoaZvV1lrg7RcLUg6wg896Sg8QcRP9a7cv036NTziY95rAWFx7OMUbSrztU9cWOqwBLpw8pqh4lfx+Tztr@vger.kernel.org, AJvYcCXPocRbNV+pots1Hzmm/q4/uVxFdKnlxijPHSrgq7NB0nbay9Sd+NAAi8ypNbywAKfAwdze7jw0Z0wUXOap@vger.kernel.org
X-Gm-Message-State: AOJu0YxFzpQ6uhSbdbxdVqKW5fXfGW0+6+mxjlkz9/4P/jv9tE/VbVKw
	npiqe3e0xxytTn4Q8HKvdTFgZLsHfVcixlVvk3Iwu0qpQTiHlldsz6Td
X-Gm-Gg: ASbGncu04HtrVmrZCTUiGbLXAtB94QQu3q1+nnK63yhrqZrQxa5NPeFaZhM2QvvuEDG
	jdS3so5BPiC6cReOxxoLtAT4G/uQr4cKxgOvdIX+CL/YF3Hh5YLnoVoXMV58YAk3X4v1lo17djT
	kLe3a0Eb7Bb8/0EBps61eVm3R9EaLLj7L/5ULrOg8iOPUBLQwsWxyivGnT/dfRIM7b7/AnM1xZp
	EFAD69vGr1e4QrWmel8Ocbwpwl2FDX3BAwZsdvIqzttVcOiiV/TRu/r2/wKaCUXQwZBHa4nSLPL
	8grF1Zh0otqa67+K0Ifhl6aJnx+1n45O2rOJIYWGdgcCU+av
X-Google-Smtp-Source: AGHT+IFBkUt1SLA2khCw9igvFJ2dxCo2xoj5v6KfMoQSZ+ORAKFruwVNHMfnbbIVVfe8zWgJnvjP+g==
X-Received: by 2002:a17:907:d23:b0:ad8:9257:5742 with SMTP id a640c23a62f3a-adfad39cdd7mr795503566b.15.1750059618809;
        Mon, 16 Jun 2025 00:40:18 -0700 (PDT)
Received: from krava ([173.38.220.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec892e756sm612120666b.144.2025.06.16.00.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 00:40:18 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Jun 2025 09:40:15 +0200
To: Tao Chen <chen.dylane@linux.dev>
Cc: song@kernel.org, kpsingh@kernel.org, mattbobrowski@google.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add show_fdinfo for uprobe_multi
Message-ID: <aE_KX66K-8yrSPtS@krava>
References: <20250615150514.418581-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615150514.418581-1-chen.dylane@linux.dev>

On Sun, Jun 15, 2025 at 11:05:13PM +0800, Tao Chen wrote:
> Show uprobe_multi link info with fdinfo, the info as follows:
> 
> link_type:	uprobe_multi
> link_id:	9
> prog_tag:	e729f789e34a8eca
> prog_id:	58
> type:	uprobe_multi
> uprobe_cnt:	3
> pid:	0
> path:	/home/dylane/bpf/tools/testing/selftests/bpf/test_progs
> offset:	0xa69ed7
> ref_ctr_offset:	0x0
> cookie:	3
> offset:	0xa69ee2
> ref_ctr_offset:	0x0
> cookie:	1
> offset:	0xa69eed
> ref_ctr_offset:	0x0
> cookie:	2

hi,
does this need to be 'tag: value' format ? bpftool uses:

        offset             ref_ctr_offset     cookies
        0xe558             0x0                0x0
        0x2574e            0x0                0x0
        0x6c393            0x0                0x0

which might be more readable, or at least extra line after each uprobe?
also using spaces instead of tabs  to align the values might help

same for kprobe_multi, otherwise looks lgtm

thanks,
jirka


> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/trace/bpf_trace.c | 48 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> Change list:
>   v1 -> v2:
>     - replace 'func_cnt' with 'uprobe_cnt'.(Andrii)
>     - print func name is more readable and security for kprobe_multi.(Alexei)
>   v1:
>   https://lore.kernel.org/bpf/20250612115556.295103-1-chen.dylane@linux.dev
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 24b94870b50..9a8ca8a8e2b 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3157,10 +3157,58 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
>  	return err;
>  }
>  
> +#ifdef CONFIG_PROC_FS
> +static void bpf_uprobe_multi_show_fdinfo(const struct bpf_link *link,
> +					 struct seq_file *seq)
> +{
> +	struct bpf_uprobe_multi_link *umulti_link;
> +	char *p, *buf;
> +
> +	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
> +
> +	buf = kmalloc(PATH_MAX, GFP_KERNEL);
> +	if (!buf)
> +		return;
> +
> +	p = d_path(&umulti_link->path, buf, PATH_MAX);
> +	if (IS_ERR(p)) {
> +		kfree(buf);
> +		return;
> +	}
> +
> +	seq_printf(seq,
> +		   "type:\t%s\n"
> +		   "uprobe_cnt:\t%u\n"
> +		   "pid:\t%u\n"
> +		   "path:\t%s\n",
> +		   umulti_link->flags == BPF_F_UPROBE_MULTI_RETURN ?
> +					 "uretprobe_multi" : "uprobe_multi",
> +		   umulti_link->cnt,
> +		   umulti_link->task ? task_pid_nr_ns(umulti_link->task,
> +			   task_active_pid_ns(current)) : 0,
> +		   p);
> +
> +	for (int i = 0; i < umulti_link->cnt; i++) {
> +		seq_printf(seq,
> +			   "offset:\t%#llx\n"
> +			   "ref_ctr_offset:\t%#lx\n"
> +			   "cookie:\t%llu\n",
> +			   umulti_link->uprobes[i].offset,
> +			   umulti_link->uprobes[i].ref_ctr_offset,
> +			   umulti_link->uprobes[i].cookie);
> +	}
> +
> +	kfree(buf);
> +}
> +#endif
> +
>  static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
>  	.release = bpf_uprobe_multi_link_release,
>  	.dealloc_deferred = bpf_uprobe_multi_link_dealloc,
>  	.fill_link_info = bpf_uprobe_multi_link_fill_link_info,
> +#ifdef CONFIG_PROC_FS
> +	.show_fdinfo = bpf_uprobe_multi_show_fdinfo,
> +#endif
>  };
>  
>  static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> -- 
> 2.48.1
> 

