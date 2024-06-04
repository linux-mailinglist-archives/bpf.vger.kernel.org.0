Return-Path: <bpf+bounces-31300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BBD8FB0B3
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 13:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2A7FB20319
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 11:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F2E144D22;
	Tue,  4 Jun 2024 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqMCbN+m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A869DDF42
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717498977; cv=none; b=WLB4knNHCrDT/JUn6E5OlaI9mMvv0bQDpnMPHzVtB8VYppdw7MCE/3AE6OwwFhP907TcYetIdzZOZEoC/HCetuR4OLUag0xbeHXuLx93AYMORmBuLIxW1E8kMqwKS3zXHnkoq0/FBK6iGpG9L6X8c/VthlEbV/5BfY8VTKifq/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717498977; c=relaxed/simple;
	bh=Qa/c0W3L64KR05fRkd1/NXfwBRM4+Gef9JTbj07sOds=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjrmgCrvq/N8kRJpySueKyxhOJxe9cZOs6kixTFiqoKUonUau9GZXX9Vuzh5EuYwdEDv3g5S6UmgPHY13HR35mHR22KLL7XcaySNX9sI1DMzNxno6IJsxH6KpyhiaZzlQZKyuivlzHAjTy0PSwNMQT1oK3QmKdS2GuysFZN3gZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqMCbN+m; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso1131693a12.0
        for <bpf@vger.kernel.org>; Tue, 04 Jun 2024 04:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717498974; x=1718103774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aurQXsI6ZbWk77ADQU/Pa2yA0Ss70NRMZy0Zpuqm3N0=;
        b=cqMCbN+m9tSO98ghAST0KyfSg3B9CALfFa0XfbgeyhuK1XDBLRwkH0XtNljsXICSZu
         CFCR6a2LmvZTsDfDzxGxcwU+jkqvi4/dsgQnp07e2Gj+638UbtH7UMs1U12R4TymdABE
         RL0mg2MbjcydEAEVnoBxHDLwu/oAvAiUrYm9BDVR2vKcG2QTsZWw3lx80cR9zXLVGlcZ
         nIO6SDqwxZ4JwCFil7MnSTnfANvpAqq7B14PNluntgzEcCieMdtv+3nzvs0zU7z/ofN9
         rJcFJKc6B8AW5rvpns4+PD7wob1N+AinlpS3UWZCjpvMpc+nNdrsSuhlbp9Vv418Cozh
         99vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717498974; x=1718103774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aurQXsI6ZbWk77ADQU/Pa2yA0Ss70NRMZy0Zpuqm3N0=;
        b=WR2FS/JyjUh/9pISqtS1zkvsubpnfYxSPN40H4O3fX8G7oR22MmWznjxd3WTFYFAD6
         Vz0oRPi1hohQpV8WEHpXH2+KwTdFsydMKJuPqPK3FHvMX6Dy01qv8twtM7cDAr49NBXp
         GkT1K6D8XQ/KwzwzUpkJRQuOOMdWKyUq6JkUtuIzSqrR6sB0ARSkzH4pIIIgwwRFN0ii
         CmPq+ht9aKCAtwaw50iwqqsI4el6SMAINY/zJmArcJw133IOYTPhMYvVBm8iwz9XjbQ+
         WUpzvLS5gk50htgNte7ijLBxXx3bfOK2iLL5SOT5Yaj1+Ek5jjnewAyQlixVWET4o5/W
         02sA==
X-Gm-Message-State: AOJu0YwdKlcfyHLg0+AQ6wwdyPMbmd3tVnKT/MQr+gD8tDFFgHuLErQ1
	c65HESFi1DVzxRX1RCXSoVhs+YrQdBHoL/0KwBKs4J60SmJNwGIf
X-Google-Smtp-Source: AGHT+IHdAIqL4qFlptTZsQrOOGp/X1U6quxPcmxEp7AaTJYnnA6eWQ3QZlq8N1/5U6L4Dsj9R+GUDQ==
X-Received: by 2002:a50:d753:0:b0:57a:2274:850b with SMTP id 4fb4d7f45d1cf-57a363ad0d9mr6930325a12.24.1717498973740;
        Tue, 04 Jun 2024 04:02:53 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c6d4b6sm7188308a12.74.2024.06.04.04.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 04:02:53 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 4 Jun 2024 13:02:51 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com
Subject: Re: [PATCH bpf-next 2/5] libbpf: make use of BTF field iterator in
 BPF linker code
Message-ID: <Zl70W3wstHhF-6zo@krava>
References: <20240603231720.1893487-1-andrii@kernel.org>
 <20240603231720.1893487-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603231720.1893487-3-andrii@kernel.org>

On Mon, Jun 03, 2024 at 04:17:16PM -0700, Andrii Nakryiko wrote:
> Switch all BPF linker code dealing with iterating BTF type ID and string
> offset fields to new btf_field_iter facilities.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/linker.c | 60 ++++++++++++++++++++++++++----------------
>  1 file changed, 38 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 0d4be829551b..be6539e59cf6 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -957,19 +957,35 @@ static int check_btf_str_off(__u32 *str_off, void *ctx)
>  static int linker_sanity_check_btf(struct src_obj *obj)
>  {
>  	struct btf_type *t;
> -	int i, n, err = 0;
> +	int i, n, err;
>  
>  	if (!obj->btf)
>  		return 0;
>  
>  	n = btf__type_cnt(obj->btf);
>  	for (i = 1; i < n; i++) {
> +		struct btf_field_iter it;
> +		__u32 *type_id, *str_off;
> +		const char *s;
> +
>  		t = btf_type_by_id(obj->btf, i);
>  
> -		err = err ?: btf_type_visit_type_ids(t, check_btf_type_id, obj->btf);
> -		err = err ?: btf_type_visit_str_offs(t, check_btf_str_off, obj->btf);
> +		err = btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
>  		if (err)
>  			return err;
> +		while ((type_id = btf_field_iter_next(&it))) {
> +			if (*type_id >= n)
> +				return -EINVAL;
> +		}
> +
> +		err = btf_field_iter_init(&it, t, BTF_FIELD_ITER_STRS);
> +		if (err)
> +			return err;
> +		while ((str_off = btf_field_iter_next(&it))) {
> +			s = btf__str_by_offset(obj->btf, *str_off);
> +			if (!s)
> +				return -EINVAL;

nit, we could drop 's' and just do (!btf__str_by_offset(obj->btf, *str_off))


otherwise the patchset lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> +		}
>  	}
>  
>  	return 0;
> @@ -2234,26 +2250,10 @@ static int linker_fixup_btf(struct src_obj *obj)
>  	return 0;
>  }

SNIP

