Return-Path: <bpf+bounces-75866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E09C9AA6E
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 09:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 94631345535
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 08:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B646F2F60CA;
	Tue,  2 Dec 2025 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vjDianCS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F021F151C
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764663605; cv=none; b=YbpkrdrU4Uag6EfUIuqY9Bgs2AmZJFeZwwGIiAgrNHc1zXGUJAFc7a26Tes8UNLxO4tDP/+8cDpcUhbw+KTAKP7Hwq/lMqHeRoYirsA31hICSJEDmkJVcOY1VbXrD7Ex2jjLPBuGKI44wWol3yGaA7nd3kGEiC8E3y4VLsXyzmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764663605; c=relaxed/simple;
	bh=TOzc+YtGKrQFav1JK/XIoTdNhUL8xeVX6xX+WO3kPhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkWvEdqynF120C6+xLFdk0Ps2IHGJ10UVCe8VQ8p9PI3UDId8VjRcY+gIgXYLaZnVrqz/a3D5IjJTcUfam2DSAOSllOfVIfj8JMGHaM7vXJ4kmNtkWLSVuVoRwJsfLSuj284t1liPTiEdnv3/l7N13YVjmStKZ9eohYFgvm6O+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vjDianCS; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso8113137a12.1
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 00:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764663602; x=1765268402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DASpGnmo4fdFF5NWyyNjefmpCJ+p1mEJZQR/FEoIZeE=;
        b=vjDianCSzr/5M+bBF50NpOLUFyvOjDe8LIu0JxEGo2G9kdgw09F1whcy0K7pefkGpV
         0WEnQuwKZ/BgZcYR+cLOAy4jkS2O46HbyC1ku7CObGncfXIeFb7sGJRj4jLuq6hEdGuZ
         E6hGXUbwGabzWfgpx8/yDFNmHFv7ke9vylz/VdYlz02w7ojbRTQrfJ+KRFqDwGvncWI/
         T6xMFez87EYvkguXnpFWmwTc/Uhs/Qiw0g7StBt9K/Z6BPfPWluDjdgEVAYKHi+PBRjw
         8aJuBKBkr2R1LeCHa8POnpZ3KAD5c3St989v9xtQ6HggcYdY4IuVBQuWC53loR6c9QfF
         uM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764663602; x=1765268402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DASpGnmo4fdFF5NWyyNjefmpCJ+p1mEJZQR/FEoIZeE=;
        b=aCovfVde8MHFn8DEXfMr1hDSzN3RjWoDSVORsDMRymI+YLxVxZZGSnck8IAde7mLLF
         MTAvaeaLAL5yrZZLDJYbI5ZJmjIAfjdAzt76WTH8lLLxjNnY5xxctUfgWLCopDzX92/I
         Yi8chSLDUYqFgnDHM/BBzgMYQHAoqYY1zGjdARMqQI1aoLOVMEb2dcttb+E6lP7G1FA8
         YuWmpvt7t/0N1+a3v/F9h1vb3PYkovMZZDX8n4JLDtwqYipvziSNRlCBxLEhzcNx+Z/7
         FikeQMn8vVmXcg263+Be8nH5j6/e1HvxjkrTV+gVdwaeOfcVp2q4EqMqmx7Ol7UQozxR
         1qIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTSc4Bwmw2nc+TtasrWq+JIS7wnDE4HxbuYOmviawqQ9nRgeoe456/iZqWKwlI/q8oFR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ5ecm2GxdKDYjFSXnWixd+c8xbzQfU8xASKi2sfFCEe0e0dTe
	aFE7OSUxXF6ZJDkOwV3eI157GVvgsUld6dYdva2lYK3SCwFX9gKBCaHkh5voKdh+oA==
X-Gm-Gg: ASbGncsjdjcIPIbapt5m90QsA4QnopiyF+Wqsvo3VjT7ez3rWyXMkuTZG2/okkQzdAI
	miM7RIFtbpUYCoXCOR9x1FmjhUGDu5Zt5BEMO5UAVYnQBG1/3anB+WDPLpid6B2QssqmE0GMqjS
	5v20c650TtxNdBdLz4rltDgAccSKyYV6ORpVPSiuRNglL+iWWxhsQa1d/IobKn4eC5q3yZdi6U7
	lPmCT/tZJd3AcSH0iW/KzoowlMy3sqdqDgvL2Shj31I1apIKdfOqUKbl4SAZWe3hFO3l4CxKp1C
	VJ9qhW0/H4HONcJPHztz9KfjiUVawRK4vXXm6yrOQrwRW7onPSX6j7gc035WXFByWxanmP0Sh2Q
	sHECZmyFcMti7PZ4M+yfj6yeJFxNAXnTJ3DuaVe5Ihkg6tTQePmfhyfA0XImtvM5goMScEb+Moo
	beAy5CxCLEhmXeJ/ZYzkL2MoUN8dc1RvaTscX6q/S4y6A1SXv4h7Jmmv3VAw4=
X-Google-Smtp-Source: AGHT+IErW4+TU0F/icO2uVLmBudXHsczagOsW3I+rZ22702sj20Oi38AWBYXnbL8PNp5rcoIlzDHdQ==
X-Received: by 2002:a05:6402:5113:b0:640:980c:a952 with SMTP id 4fb4d7f45d1cf-645eb228d07mr27548785a12.11.1764663601511;
        Tue, 02 Dec 2025 00:20:01 -0800 (PST)
Received: from google.com (155.217.141.34.bc.googleusercontent.com. [34.141.217.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64750a6e873sm15501693a12.5.2025.12.02.00.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 00:20:01 -0800 (PST)
Date: Tue, 2 Dec 2025 08:19:57 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Shuran Liu <electronlsr@gmail.com>
Cc: song@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Zesen Liu <ftyg@live.com>, Peili Gao <gplhust955@gmail.com>,
	Haoran Ni <haoran.ni.cs@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: mark bpf_d_path() buffer as writeable
Message-ID: <aS6hLVxKoifrWlK6@google.com>
References: <20251202075441.1409-1-electronlsr@gmail.com>
 <20251202075441.1409-2-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202075441.1409-2-electronlsr@gmail.com>

On Tue, Dec 02, 2025 at 03:54:40PM +0800, Shuran Liu wrote:
> Commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
> tracking") started distinguishing read vs write accesses performed by
> helpers.
> 
> The second argument of bpf_d_path() is a pointer to a buffer that the
> helper fills with the resulting path. However, its prototype currently
> uses ARG_PTR_TO_MEM without MEM_WRITE.
> 
> Before 37cce22dbd51, helper accesses were conservatively treated as
> potential writes, so this mismatch did not cause issues. Since that
> commit, the verifier may incorrectly assume that the buffer contents
> are unchanged across the helper call and base its optimizations on this
> wrong assumption. This can lead to misbehaviour in BPF programs that
> read back the buffer, such as prefix comparisons on the returned path.
> 
> Fix this by marking the second argument of bpf_d_path() as
> ARG_PTR_TO_MEM | MEM_WRITE so that the verifier correctly models the
> write to the caller-provided buffer.
> 
> Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking")
> Co-developed-by: Zesen Liu <ftyg@live.com>
> Signed-off-by: Zesen Liu <ftyg@live.com>
> Co-developed-by: Peili Gao <gplhust955@gmail.com>
> Signed-off-by: Peili Gao <gplhust955@gmail.com>
> Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Shuran Liu <electronlsr@gmail.com>

You forgot to include my Reviewed-by trailer from the initial patch
series (https://lore.kernel.org/bpf/aS3jARS7a-gh9UCa@google.com/), so
here it is again.

Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>

> ---
>  kernel/trace/bpf_trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 4f87c16d915a..49e0bdaa7a1b 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -965,7 +965,7 @@ static const struct bpf_func_proto bpf_d_path_proto = {
>  	.ret_type	= RET_INTEGER,
>  	.arg1_type	= ARG_PTR_TO_BTF_ID,
>  	.arg1_btf_id	= &bpf_d_path_btf_ids[0],
> -	.arg2_type	= ARG_PTR_TO_MEM,
> +	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
>  	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
>  	.allowed	= bpf_d_path_allowed,
>  };
> -- 
> 2.52.0
> 

