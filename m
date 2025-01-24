Return-Path: <bpf+bounces-49677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4660DA1BA54
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 17:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2B23AF97B
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 16:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA3918F2C1;
	Fri, 24 Jan 2025 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L15q6XS3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B95156649;
	Fri, 24 Jan 2025 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737736053; cv=none; b=QpNeP/K8TK8xLUMxNyrlDt1FR4qhlZE0vkIJ/8X43OutBc03CSdb1GDUJmiLKpcb20AzF4ot3PB3XrQgdBRJAShMwW1UM7dakBR5t2UrwokiKzbtVg6Q6FWRhoF72YnCpz7DcfobXlyxDZV2bELe5itN+TD/gJzIjW/DBZ+jA7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737736053; c=relaxed/simple;
	bh=LpIRv6iohffeXfHRmA08yzWyUMDIwKHQxwaEVskU4tQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbhBn5L094RPno5HaAomhbLxqh0Ue2uznbspJOATnWle+uFcWWcW3k4oWQUfko1Ps0j4UyUH2IIOfK/dXBcBhsRt85wFveZ3TuvUrFRedXya00JCyb1lwW7SH9uw/jO6rF6EkCFNPrMOdjsFztms/aPeJ8uajXDCxmw4ErcWPmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L15q6XS3; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaf6b1a5f2bso682652766b.1;
        Fri, 24 Jan 2025 08:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737736050; x=1738340850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HhEu2PKaculTGfY2fGZ1shKZc9c89U80OpVk5GW0M3A=;
        b=L15q6XS34scyIWDbFHv/j1YZVBB2x64je3GLuxj/jFH5WMsXduzPjRe4iWq9KZNm4+
         AsFxXMnySeUi/M8Mb2frIuyZyBzqFB6TB9cnV8abBeXtZGmaO/ya5v2xbk7jBuNnc0CY
         yIJIGJeQ4enNkFxLFpqHoXjzEKCCmQ1NNkSVrOfn9GeNPDXvyi9UOqebQlZjg5/ZOGiZ
         duJDCfCmArWdiJlxvb4SCMMeB8NLJGGojOmoF1nmCcQd3eN2ng4ozrwuau3pwZf6K+PY
         DZZoiuOOgtykTZ/aVxPQpSpljl0P/XhJ3PKysvfW8gnd7UpbvOORbZA0gV8ZnGqhOduT
         L0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737736050; x=1738340850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhEu2PKaculTGfY2fGZ1shKZc9c89U80OpVk5GW0M3A=;
        b=GcC+rLUVBQ6OPjGk1Ll7IRoYJDVNZbeB7z13ygnBR0duzc0EIiTZewqCIwAOwMuEFQ
         l4gsZKZnTtr5+lWWmo5WiFZJUZ4sH5eRsaCJlTgKsY6S3f82USjYzBSgw44MHyea2GyA
         tyB+v3wF2csVoc4T3UMcsGuANCVawUe1Le+jsLLihFTnkyqpKvcJ2CeXojEnUAvXfD3G
         7golpizasZdbKdcBOijoRgRY/Q1e0iYNgH2/F6DK2cp0w8pK3qLo+2BpnXjFPWWjwsY+
         hgzmQ2FP93X38S5e9YAPRiOcOal1a8WOoCvTBUVCKJg9SmY83bwJRkks21h+QRfISrMt
         SMWg==
X-Forwarded-Encrypted: i=1; AJvYcCXF2Op4YVjhCashvuttlXf/1xgPbVI+M9rdVsM7Q5VdWDafzWctqrdMcR37qHluEm6rmn3eX15KdwUMTsgn@vger.kernel.org, AJvYcCXpk4+YDoaAQ7iucQVASC7/JbcxPVOVYpvSHFgJtSPY5DjWCGoFvWlkRaPu8nqLHeMhQzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ/R3UfWz1qWtszhE0yEbWMORMhFzkJ7rGLxqIhbnbGkDOHQ+x
	8q3eM1QRsX0sYJoz8meukBRcaApeZOgiGMKUTRhaUEKPhcKeDLNX
X-Gm-Gg: ASbGncsZ9aPQ+/UhbrkheF5jkPVwvQGg79cqf5osXeH4FjjKfACHOefKi92uT3ku4cP
	frk9hpV4yACmnZ4rJJ3bbv96aodsM1UQytYd6UCFJMipsWJKR88yWtlM+Ds0Flwuv1eD6e2mE9R
	c0dx+L8rH7o2qx7SUHkZ/bvg7hvYczWG1dKVeudcFYWrpAIjO0vrYBdLfr5YZJNJ8Q7/N/ifkPK
	svMRqQHyPUvu6U03E7rksSw19Yg5tgSfz7s59Px/WtkocB3oCo/wyag8nvPHzyomRk5Zso+aWm5
	BTR7nxGU7oautQ==
X-Google-Smtp-Source: AGHT+IGnDS/v1zPb0c3TnXforaE/DngIbE2WjBmfSR7sYQZ+JDjqG57tzQnGnplULCVpRtaUqifCQw==
X-Received: by 2002:a17:907:94d5:b0:ab2:f255:59f5 with SMTP id a640c23a62f3a-ab6629d01c4mr669579766b.16.1737736048150;
        Fri, 24 Jan 2025 08:27:28 -0800 (PST)
Received: from krava (37-188-182-96.red.o2.cz. [37.188.182.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbfbcsm150134066b.153.2025.01.24.08.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 08:27:27 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 24 Jan 2025 17:27:24 +0100
To: Tao Chen <chen.dylane@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, haoluo@google.com, qmo@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Add
 libbpf_probe_bpf_kfunc API selftests
Message-ID: <Z5O_bNToXdn01f4B@krava>
References: <20250124144411.13468-1-chen.dylane@gmail.com>
 <20250124144411.13468-4-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124144411.13468-4-chen.dylane@gmail.com>

On Fri, Jan 24, 2025 at 10:44:11PM +0800, Tao Chen wrote:
> Add selftests for prog_kfunc feature probing.
>  ./test_progs -t libbpf_probe_kfuncs
>  #153     libbpf_probe_kfuncs:OK
>  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/libbpf_probes.c  | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
> index 4ed46ed58a7b..d9d69941f694 100644
> --- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
> +++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
> @@ -126,3 +126,38 @@ void test_libbpf_probe_helpers(void)
>  		ASSERT_EQ(res, d->supported, buf);
>  	}
>  }
> +
> +void test_libbpf_probe_kfuncs(void)
> +{
> +	int ret, kfunc_id;
> +	char *kfunc = "bpf_cpumask_create";
> +	struct btf *btf;
> +
> +	btf = btf__parse("/sys/kernel/btf/vmlinux", NULL);
> +	if (!ASSERT_OK_PTR(btf, "btf_parse"))
> +		return;
> +
> +	kfunc_id = btf__find_by_name_kind(btf, kfunc, BTF_KIND_FUNC);
> +	if (!ASSERT_GT(kfunc_id, 0, kfunc))
> +		goto cleanup;
> +
> +	/* prog BPF_PROG_TYPE_SYSCALL supports kfunc bpf_cpumask_create */
> +	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_SYSCALL, kfunc_id, 0, NULL);
> +	ASSERT_EQ(ret, 1, kfunc);
> +
> +	/* prog BPF_PROG_TYPE_KPROBE does not support kfunc bpf_cpumask_create */
> +	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, kfunc_id, 0, NULL);
> +	ASSERT_EQ(ret, 0, kfunc);
> +
> +	/* invalid kfunc id */
> +	ret = libbpf_probe_bpf_kfunc(BPF_PROG_TYPE_KPROBE, -1, 0, NULL);
> +	ASSERT_EQ(ret, 0, "invalid kfunc id:-1");
> +
> +	/* invalid prog type */
> +	ret = libbpf_probe_bpf_kfunc(100000, kfunc_id, 0, NULL);
> +	if (!ASSERT_LE(ret, 0, "invalid prog type:100000"))
> +		goto cleanup;

nit no need for the goto

jirka

> +
> +cleanup:
> +	btf__free(btf);
> +}
> -- 
> 2.43.0
> 

