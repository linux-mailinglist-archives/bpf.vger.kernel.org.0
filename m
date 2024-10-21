Return-Path: <bpf+bounces-42660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFDE9A6FF6
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 18:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B386284770
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 16:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC791E3780;
	Mon, 21 Oct 2024 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiOQwChR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFBD178395
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529091; cv=none; b=gR1RX4dtBOqshOIzCfTyjwvTicciUJosWRbE+Ue1m6pPepLIK+DIr5ijpmIil/c0gXE1iCsfDUX3U7/RE5DI9b61hqVM1FbfXp9P4BI2m2jR9MdJ2hnADP0UgRAuknySXKEYCjjgviSrtqPKTTlR3Uqo2qJodGJNdCpqyvDXFr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529091; c=relaxed/simple;
	bh=IXz3mVmFmED7xr/PsH7bkKGX4FSKpDgnoJx8ER7JDCI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcTNUF3YmAyRKp9pBwkOfGzqq9YstPNqTjKR9yNIt+8pFVVkypl8qGPvwFBZyV8djFv/ATiQ8iH/3rS9T5EFiSWq555hPw5tJZdWCoe68gyKvHXNvZFgw2tHxmz4Cu6lkBMih//0PK800Uv8oNpkIejZbel5+t7WpT2Nc6tyKKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiOQwChR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9aa8895facso37218666b.2
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 09:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729529087; x=1730133887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2wiyrphxLwZzMYBeDfslwZ16bIeCeHHw1n08HoQAnSQ=;
        b=aiOQwChR1EOMbkYU9Lwm16CROfN8Rnb3bYBRjVoQnrHsIzrTjluiYUW+OlWrpd7dZx
         H6Yx9E1uzkpRb+O7mXGjZFWGj7TPiO5tpjuv4br0XN5lxZ7pKXrHTGltvfy45XMuboNf
         nVt4zA8zfYtiYCBwekWjV+7JMqvt0lzFsFyvZ+FbE1d7bEnMftQ4VpJjHFREXlYw85o5
         cU83F3n/z7xbGXUmAuIik813jvssXC72DitxKVK9OGTv27wOmOR/kCDz7tPIJ3/6iffe
         5ls6PNUoJmyZFaSeUM6N5IgesYc089JRzVjKmqLqMX2cFvMxZt0B7BypLCDmPu4I9gOp
         qfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729529087; x=1730133887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wiyrphxLwZzMYBeDfslwZ16bIeCeHHw1n08HoQAnSQ=;
        b=BklWR/+d2836kz7aR5I4ztEqPa1OxthvAMltoGH4/Sul+TYdYTp8A6pMk6MclELwXf
         eOhtzfSRBktOnytwTNuAWcFTqtWNJ+VFd6ypoYWYyyKOaLQ4/yg6LHQoj9btvfwDileC
         q0iO48IqJKpcAiDFxkummafKDXp9+suqpGGgsHbl+qgNexL3qXho2MTY8BXq9EvFkNYU
         NY9HydkfN3x43Xj89sGnfFUUF1njiYF/DLIkKCa3b19GN3lEbQ10S/qenH52BnUYAPWr
         5TejJI4U9ulPC+ijuq3z35ibJWXPWg/k7Jwt69fdAN79L/nUlJdbfgEEx1Zcy4MhWSNv
         bZPw==
X-Gm-Message-State: AOJu0YxnBNsNt1AegWw/3BV/7qTPjjN5lrG5yViipwBsPBLU9HG3Dt/r
	8Fj4VuV6jIbyz4dbrHwYDol4VeV5ylY7ldODnYWHbJe97FAj077Z
X-Google-Smtp-Source: AGHT+IF87Ts2XOcxnEYXFsMqAEY4Ww69pfSuwdJlawSMrP6drlOjRFWVqDT+DZX1njGYDdchgb0EGQ==
X-Received: by 2002:a17:906:c116:b0:a99:5d03:4687 with SMTP id a640c23a62f3a-a9a69a766bamr1275072666b.21.1729529087033;
        Mon, 21 Oct 2024 09:44:47 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a915599dasm221392766b.118.2024.10.21.09.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 09:44:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 21 Oct 2024 18:44:44 +0200
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: increase verifier log limit in
 veristat
Message-ID: <ZxaE_C_Im9-I8OSa@krava>
References: <20241021141616.95160-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021141616.95160-1-mykyta.yatsenko5@gmail.com>

On Mon, Oct 21, 2024 at 03:16:16PM +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> The current default buffer size of 16MB allocated by veristat is no
> longer sufficient to hold the verifier logs of some production BPF
> programs. To address this issue, we need to increase the verifier log
> limit.
> Commit 7a9f5c65abcc ("bpf: increase verifier log limit") has already
> increased the supported buffer size by the kernel, but veristat users
> need to explicitly pass a log size argument to use the bigger log.
> 
> This patch adds a function to detect the maximum verifier log size
> supported by the kernel and uses that by default in veristat.
> This ensures that veristat can handle larger verifier logs without
> requiring users to manually specify the log size.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 40 +++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
> index c8efd44590d9..1d0708839f4b 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -16,10 +16,12 @@
>  #include <sys/stat.h>
>  #include <bpf/libbpf.h>
>  #include <bpf/btf.h>
> +#include <bpf/bpf.h>
>  #include <libelf.h>
>  #include <gelf.h>
>  #include <float.h>
>  #include <math.h>
> +#include <linux/filter.h>
>  
>  #ifndef ARRAY_SIZE
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> @@ -1109,6 +1111,42 @@ static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, const ch
>  	return;
>  }
>  
> +static int max_verifier_log_size(void)
> +{
> +	const int big_log_size = UINT_MAX >> 2;
> +	const int small_log_size = UINT_MAX >> 8;
> +	struct bpf_insn insns[] = {
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	int ret, insn_cnt = ARRAY_SIZE(insns);
> +	char *log_buf;
> +	static int log_size;
> +
> +	if (log_size != 0)
> +		return log_size;
> +
> +	log_size = small_log_size;
> +	log_buf = malloc(big_log_size);

IIUC this would try to use 1GB by default? seems to agresive.. could we perhaps
do that gradually and double the size on each failed load attempt?

jirka


> +
> +	if (!log_buf)
> +		return log_size;
> +
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts,
> +		    .log_buf = log_buf,
> +		    .log_size = big_log_size,
> +		    .log_level = 2
> +	);
> +	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &opts);
> +	free(log_buf);
> +
> +	if (ret > 0) {
> +		log_size = big_log_size;
> +		close(ret);
> +	}
> +	return log_size;
> +}
> +
>  static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
>  {
>  	const char *base_filename = basename(strdupa(filename));
> @@ -1132,7 +1170,7 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
>  	memset(stats, 0, sizeof(*stats));
>  
>  	if (env.verbose || env.top_src_lines > 0) {
> -		buf_sz = env.log_size ? env.log_size : 16 * 1024 * 1024;
> +		buf_sz = env.log_size ? env.log_size : max_verifier_log_size();
>  		buf = malloc(buf_sz);
>  		if (!buf)
>  			return -ENOMEM;
> -- 
> 2.47.0
> 
> 

