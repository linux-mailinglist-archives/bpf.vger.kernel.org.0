Return-Path: <bpf+bounces-49675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8513AA1BA4E
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 17:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FDB18906A2
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 16:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA5018E057;
	Fri, 24 Jan 2025 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWQpkxGw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF017DF58;
	Fri, 24 Jan 2025 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737736017; cv=none; b=rur8o6FXhSKx6bQl4pvJkON+tzrfH9jGmlrxuZNjo4kiGUX5b2Xr9Xa5P/n8ZoflIBc/9LTVhkslkJZKEyDumicC5f8CVtFAZ1vTW9srkkyzLqwHDndykpsp1b19SqjuhrDthV8exmvZsXRk+6WAn81tUUN18skKnanfB5e91aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737736017; c=relaxed/simple;
	bh=GnBQ1XgjNkDBXuucekiNBLic2FB+uOZ893CygSVdrpY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTb9YKF3p0I0UadXZA2ylUrzW6q+FjSwd94hECR83VLtZ+3M6XI7kj9XXaQFA+Ih3j7FKmgc/zY+tPWLtoNftKOxKC2gLxslHZlvh5B+wD8mM3E2uVM+y/lnua3RGUMJFoX7nKTOu6euPT6d6mfONE98kmtn4I0GVOFChJebNhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWQpkxGw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso458750966b.1;
        Fri, 24 Jan 2025 08:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737736014; x=1738340814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3W2UXPMeDX869kh+AhZ/KtSE8AjAzE+3Vor+HNVQCI4=;
        b=gWQpkxGwxgvIFVYv2AhY+Pf0jdC/Fjk6/GiAt39jFLcIUMpyXbugG6gW5tuVuY+AZV
         1npLOJ8stefp/9uia9dCWfWuVtzHHKhDgzWBtcq+O2iYWjuqB5vPhck50/IG/l405wYc
         T52MJV9v9aTRJSxiTosGRr/4AIrhhC5wbK5itoTXKBkVrSYdmmLYoyB9wUxb+SQzeWRi
         02G6TlsKgMLGvZdt7EimljccWR2mHCHcuhDgw1L+UYhaGRHUtG3fVYh7qliiUxndgQH4
         RSEkTUAv/zczRwOsOt7ns1pkLnQJJ57l/v2oTBgtWQlaguzddUZadBrI1IzYBBhckXvQ
         s/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737736014; x=1738340814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3W2UXPMeDX869kh+AhZ/KtSE8AjAzE+3Vor+HNVQCI4=;
        b=rWol5DF0g3QjXm790Kco5j8iLKo3/shFfqjqBg5X3/2OpazfDQtd3XX7BpI58bo0aY
         JwGQ4EOhz3JvUD9o+Rl2371H/oUH5074ObqdiBSj+FDgS4Pl/6d2IeSjvmkFxauV7Fam
         O/3vV8q089e7oef9MBWWKq00fB3XWIz2H2c2iwtfpjcCjiufhGhJD12WmP2Ov0z1VCFf
         d+Q2W91SlR/D+ehehiPXCA4gJDKWaMx+bVYBdCJ6lOiB+G4vGUv83d3xUrm4nE4bciBg
         QX+TO7lMO5GpqYg17l4QgSfOBoqB06wXPRrqSnUuc7fbsroSRXc2HomO3Y82jrhQuK1Y
         5gmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5cRbj0lzRamIH/QO3AaOeOgZd3fCQkkzRt+5DYeco5R8xl7j2fx8P3iwSe4KTYBLSTUs=@vger.kernel.org, AJvYcCXD/0MqgWUBGQB5wAVJEK5gmHzXKINqlZ8H2qxddx4v58+hzFrqRXgTGLCl6lqTZzQCkSnrG2fnv/5vKrID@vger.kernel.org
X-Gm-Message-State: AOJu0YwAKZzzkpsBG3VvcS3BRoii6iz0g+N3lJvZP8Q9psJhoV7cxApa
	yqfR5ownc/cbtX1NTp7TsOwsrq1Y7NKbOVRFjYNIx6AhxVgJ+SLSX00Nqg==
X-Gm-Gg: ASbGncsG1KkI/ZVyE/yRE1/VVD6PP+jh2pbwGMskexR3mzUCBlVye4ro+3pD4i/dFlp
	86XxrOqrU3AZ8PGodERsabOTnVZQO4GwnzvDvL2b9ft26es9qdQ6VA04q03vqDbe66F0MTOKn0c
	TyruUirS4kE1JNPc+RHEDoJV/cobc9Sx3K4Txxa7MYp/LRgPHAepBtPL4eQ2TI7EFJBm4drfqZN
	LFarHAMF8EQKAEJm1fY4pw8qNsHpmS4s5pcMUCBUSb6QpXLoEHZEzlYeC3ZDQ91KXeF3Km4Um3D
	zgdxVi3Clvd4zA==
X-Google-Smtp-Source: AGHT+IGNfe6PGpOFOpxRemmb4gePcvtur+Bv1QGnWtGrMa2znPaJrj9nrHRxRw3bH3JcJ0htE/FU6A==
X-Received: by 2002:a17:907:da1:b0:aa6:2a17:b54c with SMTP id a640c23a62f3a-ab38b0b90cemr2675264266b.6.1737736013740;
        Fri, 24 Jan 2025 08:26:53 -0800 (PST)
Received: from krava (37-188-182-96.red.o2.cz. [37.188.182.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e12505sm154537266b.17.2025.01.24.08.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 08:26:53 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 24 Jan 2025 17:26:48 +0100
To: Tao Chen <chen.dylane@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, haoluo@google.com, qmo@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/3] libbpf: Refactor libbpf_probe_bpf_helper
Message-ID: <Z5O_SBFCWY-3yUI-@krava>
References: <20250124144411.13468-1-chen.dylane@gmail.com>
 <20250124144411.13468-2-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124144411.13468-2-chen.dylane@gmail.com>

On Fri, Jan 24, 2025 at 10:44:09PM +0800, Tao Chen wrote:
> Extract the common part as probe_func_comm, which will be used in
> both libbpf_probe_bpf_{helper, kfunc}
> 
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>  tools/lib/bpf/libbpf_probes.c | 38 ++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> index 9dfbe7750f56..b73345977b4e 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -413,22 +413,20 @@ int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void *opts)
>  	return libbpf_err(ret);
>  }
>  
> -int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
> -			    const void *opts)
> +static int probe_func_comm(enum bpf_prog_type prog_type, struct bpf_insn insn,
> +			   char *accepted_msgs, size_t msgs_size)
>  {
>  	struct bpf_insn insns[] = {
> -		BPF_EMIT_CALL((__u32)helper_id),
> +		BPF_EXIT_INSN(),
>  		BPF_EXIT_INSN(),

I'd just keep above in libbpf_probe_bpf_helper and pass insns to probe_func_comm,
seems easier

jirka

>  	};
>  	const size_t insn_cnt = ARRAY_SIZE(insns);
> -	char buf[4096];
> -	int ret;
> +	int err;
>  
> -	if (opts)
> -		return libbpf_err(-EINVAL);
> +	insns[0] = insn;
>  
>  	/* we can't successfully load all prog types to check for BPF helper
> -	 * support, so bail out with -EOPNOTSUPP error
> +	 * and kfunc support, so bail out with -EOPNOTSUPP error
>  	 */
>  	switch (prog_type) {
>  	case BPF_PROG_TYPE_TRACING:
> @@ -440,10 +438,26 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helpe
>  		break;
>  	}
>  
> -	buf[0] = '\0';
> -	ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
> -	if (ret < 0)
> -		return libbpf_err(ret);
> +	accepted_msgs[0] = '\0';
> +	err = probe_prog_load(prog_type, insns, insn_cnt, accepted_msgs, msgs_size);
> +	if (err < 0)
> +		return libbpf_err(err);
> +
> +	return 0;
> +}
> +
> +int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
> +			    const void *opts)
> +{
> +	char buf[4096];
> +	int ret;
> +
> +	if (opts)
> +		return libbpf_err(-EINVAL);
> +
> +	ret = probe_func_comm(prog_type, BPF_EMIT_CALL((__u32)helper_id), buf, sizeof(buf));
> +	if (ret)
> +		return ret;
>  
>  	/* If BPF verifier doesn't recognize BPF helper ID (enum bpf_func_id)
>  	 * at all, it will emit something like "invalid func unknown#181".
> -- 
> 2.43.0
> 

