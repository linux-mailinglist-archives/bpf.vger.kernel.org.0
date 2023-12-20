Return-Path: <bpf+bounces-18363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D88908197D8
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 05:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC66B24703
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 04:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E759EC13C;
	Wed, 20 Dec 2023 04:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTuYKz9c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51201C121
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cd68a0de49so3779200a12.2
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 20:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703047070; x=1703651870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7rMaCxUZC+FD6IXjcsbTd1t1v7Y8b9f1abuBJYmOpXE=;
        b=nTuYKz9cAVfiG/jgvm/OVBwEVWJCbRtht9l//6PN6RnpeUWypeeszFf5Pt0ouQJmwj
         x3JeLFDd5ALEGH4YFMzjEsDXePNq7YlFmfWQhVfdmIzqX1UrlMgW/UGvPt+yuVY6tzxQ
         UZzgYLhfEexNHnox6j8rlErUHnnUQHAIYZfu/ihZ+nXg58FlqdzPMnHa3pCaBDzR/vUD
         91a53MIhDiU+FpxcrEXTp8VVV7vtLl/IXti5x+XmPJwe415+z/sH7m+AAIIXplLSXNq+
         AbeMai1joXnKWQPH8oKLtZKVYDJLs77BFA3+/ld1iItggUa2PkP64SB6Knv6yVYvjPPz
         SxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703047070; x=1703651870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rMaCxUZC+FD6IXjcsbTd1t1v7Y8b9f1abuBJYmOpXE=;
        b=EgrhMffQszxcBRphYyda7feHmC9qNHNY31P6XTFHoorCpPIxRDVwVxIxLhK7iTIGdm
         BZOky3/yhZBR1FOcImYW96FMzeEE3BMPkH7zFf4dm7AYkhMCStXDmvNiLhtJ7KnxnI+7
         F85BgW5GJjbaYInlflwDPc6jj6mYt7/fHHDObBhDoFDrVxFTz/hnsPaLGBeEevplEbss
         rT6EkxcW2GlCrzwh2Rh0q0QtBQszXKEDzQe7K3kRIZzIyYqDUaaEUZ/N6+7cMMlM+Mon
         w4VM3fN2uK2QGo8djIlwthV7kh8h0dRxjCJbExUFXAFQ328PT4zx28le9rQPzZz4q74J
         G5ng==
X-Gm-Message-State: AOJu0YydKFl+vsOUyuVH7jzsTHITZ/S5G7fdleqgpId7TiLLEg23hVSB
	tmv+vL8XfksJYldQ+2Zp9hI=
X-Google-Smtp-Source: AGHT+IFdjac04vOimsUMMOgNpPJayGY/UHkz7v3MWpBvn1LM3AbKS00ArlwRY16a3lsVvUKpWKCkFw==
X-Received: by 2002:a05:6a20:5491:b0:190:9280:7260 with SMTP id i17-20020a056a20549100b0019092807260mr24180999pzk.60.1703047070597;
        Tue, 19 Dec 2023 20:37:50 -0800 (PST)
Received: from MacBook-Pro-49.local ([2620:10d:c090:400::4:f510])
        by smtp.gmail.com with ESMTPSA id e9-20020a17090ab38900b0028b07d1f647sm2486799pjr.23.2023.12.19.20.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 20:37:50 -0800 (PST)
Date: Tue, 19 Dec 2023 20:37:47 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v4 3/7] bpf: Allow per unit prefill for
 non-fix-size percpu memory allocator
Message-ID: <vwypdrjhtrvqcgocemp5ptkqqbbmtrw5q4mlkc5i2k7ipbhvm5@bixqyhggoihm>
References: <20231218063031.3037929-1-yonghong.song@linux.dev>
 <20231218063047.3040611-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218063047.3040611-1-yonghong.song@linux.dev>

On Sun, Dec 17, 2023 at 10:30:47PM -0800, Yonghong Song wrote:
> @@ -2963,7 +2963,9 @@ static int __init bpf_global_ma_init(void)
>  
>  	ret = bpf_mem_alloc_init(&bpf_global_ma, 0, false);
>  	bpf_global_ma_set = !ret;
> -	return ret;
> +	ret = bpf_mem_alloc_percpu_init(&bpf_global_percpu_ma);
> +	bpf_global_percpu_ma_set = !ret;
> +	return !bpf_global_ma_set || !bpf_global_percpu_ma_set;
...
> -				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
> -					if (!bpf_global_percpu_ma_set) {
> -						mutex_lock(&bpf_percpu_ma_lock);
> -						if (!bpf_global_percpu_ma_set) {
> -							err = bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
> -							if (!err)
> -								bpf_global_percpu_ma_set = true;
> -						}
> -						mutex_unlock(&bpf_percpu_ma_lock);
> -						if (err)
> -							return err;
> -					}
> -				}
> -
>  				if (((u64)(u32)meta.arg_constant.value) != meta.arg_constant.value) {
>  					verbose(env, "local type ID argument must be in range [0, U32_MAX]\n");
>  					return -EINVAL;
> @@ -12096,6 +12079,17 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  					return -EINVAL;
>  				}
>  
> +				if (meta.func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
> +					if (!bpf_global_percpu_ma_set)
> +						return -ENOMEM;

The patch set looks great except I don't understand this part of the patch
that goes back to allocating bpf_global_percpu_ma by default.
Why allocate even small amount if no bpf prog will use it?
It seems delaying allocation until the verifier sees the need is better.
The rest of the series makes sense.

