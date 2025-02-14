Return-Path: <bpf+bounces-51569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A32BA36077
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 15:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333FC1895C9C
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 14:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB85266581;
	Fri, 14 Feb 2025 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euNWxxqG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D307266F00;
	Fri, 14 Feb 2025 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543440; cv=none; b=u5gByGjqd1mOqGPiTYue8zCIaOCW1hz5v3WFqhdonqZ65/b5psPSHg2MIugcU9zxatHohw4c7YK8ZM865GTsAcOXL4a5xUjiXhLm6SesDNAUE0tAnxJ88CA7gW2Kmc1bpfq1xmA4P73QGgUvyyrMBg4WXqShFUEZtKwZwjSqJmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543440; c=relaxed/simple;
	bh=rpQDxvBO4+LJ/S2C8631GhfnfcGziYlMc+zJ5RaS7OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMbcJ11sDkdVXP2h7lW/Scz1yvhQax6FVt9FQJz7qOpNkWTmum+IEAUi+Zjx98thaYOXCFnbH225MXQ+kokaptA6hRSN2Shur82KWKxdag7LZ6poSEZHXZ/3ge+xKNBxEH0jBwDOF6qhOqY+pRPwMVThgZ6fjOSjA9FlMJ9hJag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euNWxxqG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220ecbdb4c2so24588285ad.3;
        Fri, 14 Feb 2025 06:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739543438; x=1740148238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOxiLS6FGGI7eMtjPO59prgGVeqct+2lfOrO1dnNxCg=;
        b=euNWxxqGhYIE4IXyJ1eEVikst/SVpRhVm1wBcXEOgbUgvsL51+ExteOiODXt5uAFff
         zT3Rbs7BR3R+Kn0N+xhtSWAxasHdWn/Mo4WXIO6QGhQ+W2DudISuj9EmLBhjGDGurogL
         pmwY/wrZ4H9QbMkImvYS68ELQHRNvpdELg00gbell0SY4TJnK1/6IVGBXfDH0FfoaRmD
         L4xhBgJs1HrQ90kpz4r5jcePTu5UkpWv/vCOtApnH42rB32DV+9Y02k5sCWMRfH8Q55F
         FJwCAvIJ0vCmv9wPw49kctdo7zJn4im4LMBJzRkrVg2JjshN/tks1LZ8bz00nFEIQ3a+
         bdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739543438; x=1740148238;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EOxiLS6FGGI7eMtjPO59prgGVeqct+2lfOrO1dnNxCg=;
        b=Az0vZqBBscqyO8qBaHXA/Y2CVN0YUpxgQZaLhzET3Qyy4G1DDdZ+YeKlDofYSxLHPp
         xkFE4PhhWR+/+lyRZaSvOYWXFaTJvZuNVOLzuY9jvBsuPeqNYnA44q3igAtm2seTfkJR
         u21JRJh6ewbMN3H3s1ly9mc0H7Ffdrxzdas4WiQIk8vZQ6DFLc4IlaCs6SCzhNllmd1b
         6dwSkIwo0g93CqlISVWHpWXYit9XsNyWRaGb71kDzDeQtMHuNYHDv+b0uVItx0izobC/
         78YqKrunuborlygutNwUzF0Capex/Kfm4k3X3QjyC746UqVgyUhsMHGzYBejojCIAc04
         ix6g==
X-Forwarded-Encrypted: i=1; AJvYcCXOTlqMS4ttPFstm4fHyHtR9ernAyUmzeYVE5YzQtYZdAEijUApcza00UJqtXytEAIDj8A4g0Fn6Q56I/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTcVTiq900ASBdKDmsx0GgJFIWchAWakIB4pM5JBjPtLkd09io
	lmhWBK6J6PxGED7QV4j4qymbuLjlwPMBa4J/MJ8GJzmNobaecoyI
X-Gm-Gg: ASbGncvVWsyDw+F5G6EILH8RlNJvBzVYWHIVjRxpU2MjCJECggTlkoGXunMAmE0wYrm
	hA+fMcF4/EYt0/lw+lHqUlJMvq6lmUzki6Rya3POP3jRLQDLtw63mcHseVeJC1NAzz3YIwfC1J+
	1dXnebOH5ksl1nbKCQyQG4rpwj7l2wT2JjoIYpbrPbyR3f/xYr+tMJF1aYlN7WRFtLW/f+KdNM1
	/T3F1TYPsUYHGwxU6FYXfgFHI/UZm1NdlOPzWAfnPAze9lmH53yiUYamq9Zxg3ydnb97k7I6vvQ
	7QvbeJNkVFk=
X-Google-Smtp-Source: AGHT+IFEb4cfYzbxoT6hGqENuJ5gN6TztL9sB8JHaVrDMoXFT5NWEV1KKx8OMBfHTgxEaTNCr2gOhQ==
X-Received: by 2002:a17:902:e84c:b0:215:6f9b:e447 with SMTP id d9443c01a7336-220bbb50b9dmr163742415ad.30.1739543437612;
        Fri, 14 Feb 2025 06:30:37 -0800 (PST)
Received: from [0.0.0.0] ([5.34.218.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536375fsm29527175ad.53.2025.02.14.06.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 06:30:37 -0800 (PST)
Message-ID: <282976f0-772a-44cc-9d3d-b07f42a4b2cc@gmail.com>
Date: Fri, 14 Feb 2025 22:30:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libbpf: Wrap libbpf API direct err with libbpf_err
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250214141717.26847-1-chen.dylane@gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <20250214141717.26847-1-chen.dylane@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/2/14 22:17, Tao Chen 写道:
> Just wrap the direct err with libbpf_err, keep consistency
> with other APIs.
> 
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>   tools/lib/bpf/libbpf.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 194809da5172..6f2f3072f5a2 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9145,12 +9145,12 @@ int bpf_object__gen_loader(struct bpf_object *obj, struct gen_loader_opts *opts)
>   	struct bpf_gen *gen;
>   
>   	if (!opts)
> -		return -EFAULT;
> +		return libbpf_err(-EFAULT);
>   	if (!OPTS_VALID(opts, gen_loader_opts))
> -		return -EINVAL;
> +		return libbpf_err(-EINVAL);
>   	gen = calloc(sizeof(*gen), 1);
>   	if (!gen)
> -		return -ENOMEM;
> +		return libbpf_err(-ENOMEM);
>   	gen->opts = opts;
>   	gen->swapped_endian = !is_native_endianness(obj);
>   	obj->gen_loader = gen;
> @@ -9262,13 +9262,13 @@ int bpf_program__set_insns(struct bpf_program *prog,
>   	struct bpf_insn *insns;
>   
>   	if (prog->obj->loaded)
> -		return -EBUSY;
> +		return libbpf_err(-EBUSY);
>   
>   	insns = libbpf_reallocarray(prog->insns, new_insn_cnt, sizeof(*insns));
>   	/* NULL is a valid return from reallocarray if the new count is zero */
>   	if (!insns && new_insn_cnt) {
>   		pr_warn("prog '%s': failed to realloc prog code\n", prog->name);
> -		return -ENOMEM;
> +		return libbpf_err(-ENOMEM);
>   	}
>   	memcpy(insns, new_insns, new_insn_cnt * sizeof(*insns));
>   
> @@ -9379,11 +9379,11 @@ const char *bpf_program__log_buf(const struct bpf_program *prog, size_t *log_siz
>   int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size)
>   {
>   	if (log_size && !log_buf)
> -		return -EINVAL;
> +		return libbpf_err(-EINVAL);
>   	if (prog->log_size > UINT_MAX)
> -		return -EINVAL;
> +		return libbpf_err(-EINVAL);
>   	if (prog->obj->loaded)
> -		return -EBUSY;
> +		return libbpf_err(-EBUSY);
>   
>   	prog->log_buf = log_buf;
>   	prog->log_size = log_size;
> @@ -13070,17 +13070,17 @@ int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map)
>   	int err;
>   
>   	if (!bpf_map__is_struct_ops(map))
> -		return -EINVAL;
> +		return libbpf_err(-EINVAL);
>   
>   	if (map->fd < 0) {
>   		pr_warn("map '%s': can't use BPF map without FD (was it created?)\n", map->name);
> -		return -EINVAL;
> +		return libbpf_err(-EINVAL);
>   	}
>   
>   	st_ops_link = container_of(link, struct bpf_link_struct_ops, link);
>   	/* Ensure the type of a link is correct */
>   	if (st_ops_link->map_fd < 0)
> -		return -EINVAL;
> +		return libbpf_err(-EINVAL);
>   
>   	err = bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0);
>   	/* It can be EBUSY if the map has been used to create or

Forgive my carelessness. This patch was developed based on bpf-next. You 
can ignore it. I've resent it.

-- 
Best Regards
Dylane Chen

