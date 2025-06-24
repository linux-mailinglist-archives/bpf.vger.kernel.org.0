Return-Path: <bpf+bounces-61364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C91AE63B4
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 13:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DEFD1926BF4
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 11:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E0628E607;
	Tue, 24 Jun 2025 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOdu/NrQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E172128D8CB
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750765091; cv=none; b=A2EG6jKeveM/doXVzbbNRr3JpkSlFatYpyTi+06pXnQHmAT+xXdlrjyhjw4DMc84LANRF69ErjlPArmSgLADzhLxqL05Vu0A6T/bDa+Lj3p4NfxWoepLthC+sgL6jF43Nokp6UbpqKUgZjDzMy3k9uoljYKQcqV3soG9ipImQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750765091; c=relaxed/simple;
	bh=IDnrBQdCuj9Lhm440taiddSOle9n/7svVIqrf38XBaU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KstrG7bOXVB/4VtyXeCzIekdKuTC7nOgDCwgINkCk6A2yqWB75NqPSMjSx5yufItWWRS/KIiD/AGI6W91wJjn3C6lefZGmyd47JglvjQSY6TAXNGwe5uGgod7gok4tZhgdQdpYOOwgqYv4qx1hh0GmYbgneF1Q8s1k8Tu+EjZrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOdu/NrQ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ade5ca8bc69so63680566b.0
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 04:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750765088; x=1751369888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1LujRbBpo7XteLa5YfezYpWn6h59XWc6HzvIfLGcxK8=;
        b=fOdu/NrQMjtULEBCnPXVhAP/p5ZjhoJs6lPCCzPJyZrQhWoIZ4cGPPCFEa0EpkRSv0
         Uyv4RWkoGtmNVdM2NFDKtU0kY4k0g5juiS5IcMUqXMuXOlVCoDK/+qnrnEpx7g4YIE5V
         JCakqWJolLGbwqH5CYUe+9LOkgoAMBhwkITKSyggztWO/s8WWf94aR0rBPS751KrDwf8
         CKY6dMe/pjcGsu3i1djuVlu+PBRDMZG3KNdlqppKVtND2Sg0yKUVWZ3Nu33Mvdo0H2ee
         e8Mrf9QNMl1CeRfxexiDxct7gcD2SR1OJbIIe1iKLZFe0VCY+UlHStwbxNQPVmN474QE
         vABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750765088; x=1751369888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LujRbBpo7XteLa5YfezYpWn6h59XWc6HzvIfLGcxK8=;
        b=BKdzQzg5/4hz/qYU6Uu5Q4/KP/H6kxwNa3OF+Wo2ze3ANt3pckUoVF1CHayQNsYEav
         4hpW2XIzpDz9UX8siG8li/RYOKVR710/c0XomuTGtdXWS+n6AHS6STJ6GX6dqF3llA5j
         GLEJmoeXdQV75S/DWikFGNa0GVPRuAn9T7f71FtWrhCwU7K70sKi7nJOPgr2e7raJLHl
         SAqWnGaIfrRRpoJQBbKTYfYZ/5aMURD62VX39lZSu3ydMRWyZgkZkAB9bCRQQKzYE6Ms
         I6TJeMhQAUTSQIs1u+tKYSXq0jI/eRImtG5skmKnjQlMvoGxmn8Q9sIxzBTwT8uuPRob
         4UZg==
X-Gm-Message-State: AOJu0YzE4zF6ZWdoFChr9Wq6gP1CyQHZ9br8FCCYW2l3nTXaLsehnWhr
	WJUMGNCL077nhH9zeTdv1+vWIL12uafeTtWmlW8dah1337xf1GPPRV0mPZR7V19Cj3s=
X-Gm-Gg: ASbGnctrUDSBHyuLynkpN8qv8ZJMMjuopzGnALh3Ya6B4X6Fr2ujk1wj6UzaCLRk1jW
	+pKnqSvxR3SdEhyrOjI8Tose1/aoox7iJxE1Qg26cbujkANRVa6k8bcNv4+Y9q9XaahCOMkJzbG
	vKJu8E87Sv75Gz52E3OYv3dQVwJdatIQMCu0Xvf3VPAQ9omJ45AeD4y6QZIax7JeuN4x/d3o7RJ
	hq1DJ64QSWKom6hA1ftgLutqQVMpqdOikSfFeNISiGMrgX9D+TwakN7zNY6LVALb+RD7SNvs43v
	25PXUWC9lh+iENpNWc5qqY/cnmdy0M/k03Tqfo5RM8MGybtcQQ==
X-Google-Smtp-Source: AGHT+IEfXMep5OzdKj6dw4yQ3x56GeLIZi4vdLOVT7UqWP+LQMVNArEoF57MHdpr0HNI5dciGVsAww==
X-Received: by 2002:a17:906:6a07:b0:ad5:5198:b2ad with SMTP id a640c23a62f3a-ae057b485f3mr1563898466b.48.1750765087785;
        Tue, 24 Jun 2025 04:38:07 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0b40c3950sm44269066b.141.2025.06.24.04.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 04:38:07 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Jun 2025 13:38:05 +0200
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 06/12] bpf: Add dump_stack() analogue to
 print to BPF stderr
Message-ID: <aFqOHariTJvjyJwX@krava>
References: <20250624031252.2966759-1-memxor@gmail.com>
 <20250624031252.2966759-7-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624031252.2966759-7-memxor@gmail.com>

On Mon, Jun 23, 2025 at 08:12:46PM -0700, Kumar Kartikeya Dwivedi wrote:

SNIP

> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index 75ceb6379368..5fb11202ab9c 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>  
>  #include <linux/bpf.h>
> +#include <linux/filter.h>
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/percpu.h>
>  #include <linux/refcount.h>
> @@ -483,3 +484,46 @@ bool bpf_prog_stream_error_limit(struct bpf_prog *prog)
>  {
>  	return atomic_fetch_add(1, &prog->aux->stream_error_cnt) >= BPF_PROG_STREAM_ERROR_CNT;
>  }
> +
> +struct dump_stack_ctx {
> +	struct bpf_stream_stage *ss;
> +	int err;
> +};
> +
> +static bool dump_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
> +{
> +	struct dump_stack_ctx *ctxp = cookie;
> +	const char *file = "", *line = "";
> +	struct bpf_prog *prog;
> +	int num, ret;
> +
> +	if (is_bpf_text_address(ip)) {
> +		rcu_read_lock();
> +		prog = bpf_prog_ksym_find(ip);
> +		rcu_read_unlock();

do you need to check prog != NULL ?

also is_bpf_text_address calls bpf_ksym_find and bpf_prog_ksym_find calls it again,
I think it'd be better just to call bpf_prog_ksym_find from here

jirka


> +		ret = bpf_prog_get_file_line(prog, ip, &file, &line, &num);
> +		if (ret < 0)
> +			goto end;
> +		ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n  %s @ %s:%d\n",
> +						    (void *)ip, line, file, num);
> +		return !ctxp->err;
> +	}
> +end:
> +	ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n", (void *)ip);
> +	return !ctxp->err;
> +}
> +
> +int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss)
> +{
> +	struct dump_stack_ctx ctx = { .ss = ss };
> +	int ret;
> +
> +	ret = bpf_stream_stage_printk(ss, "CPU: %d UID: %d PID: %d Comm: %s\n",
> +				      raw_smp_processor_id(), __kuid_val(current_real_cred()->euid),
> +				      current->pid, current->comm);
> +	ret = ret ?: bpf_stream_stage_printk(ss, "Call trace:\n");
> +	if (!ret)
> +		arch_bpf_stack_walk(dump_stack_cb, &ctx);
> +	ret = ret ?: ctx.err;
> +	return ret ?: bpf_stream_stage_printk(ss, "\n");
> +}
> -- 
> 2.47.1
> 
> 

