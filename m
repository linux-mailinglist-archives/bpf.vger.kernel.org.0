Return-Path: <bpf+bounces-13595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 155C77DB7AF
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 11:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C456F2814D3
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 10:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B9C10A39;
	Mon, 30 Oct 2023 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="SzATxA9g"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9362F379
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 10:17:33 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8EC325F
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 03:17:31 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c50906f941so61656991fa.2
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 03:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1698661049; x=1699265849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ofI5HQ1BdCPpW+OAZKu+mKF+G+LKO21NOkO2LxEoXzs=;
        b=SzATxA9grc0Ym/hWgJ3d16yj6fy6yjOW4EFZQ27jg3H2ZUSspLlAOTz67OgmhBM0T3
         /qeigQi8BZdMdaKDb6Y2DyRma/ExncZqJZpFoE6YV45S/Sk6/CEfYl7arg8YZMLZ0liA
         yoMEUqUvKWCqpBOFZ2TsDrYjRcokAp8+fklC8yJ+ATqTZF6x0ZhR8RRb9DNetmlN5Gu5
         0V8jJPEofKzdcDobbWA4a+Hjs15Or9s8vFFw9CSZ3oBdrDMYBRSa9YmdMpTz/lL0+DMC
         92EtJqBhGy6GnesQs+cHWTVTLwiqD5blaaN5iFdAzVeAgn7nPzSt2Mh8alB6ZZ46u/WK
         vd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698661049; x=1699265849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ofI5HQ1BdCPpW+OAZKu+mKF+G+LKO21NOkO2LxEoXzs=;
        b=YIrVSwZir3F9NkumdQPHam8x6KMJNMuAVCUVXgYy1jN3XJV0aItcEhj9Fm5AyTqPDu
         PAl+M1z8SfjmSU+bo8MbE6XQLhtmoEDJ/VXFinVRsnwdSlHXxm5o9c/XBlM7e4DJzHtE
         /w3UdCL3O/vLnglAsqnEMSXsWKO85utXOhatiastaWRk+ehC9R319onMoOLbOutYKzlQ
         7idu9qeHqJC5ckCA3IwRa7bEaPMZqIWEpb7N6sIqilmuimFFTn9ZKztdtSv12F/4pZtn
         qAI4FMisF4ELt0gYil0KOyAACqh8admSXL6BqIKMqp2qumrdEf7b0wKc5LSFV0QY+kC0
         EtFg==
X-Gm-Message-State: AOJu0Yzy4m3iV5tmS0JGAxOvt7HbSWDhaEtHKJWwR5zCCzKsY9+w7NIk
	6oxNrxWgsP7cy/i1kYi1zSJazA==
X-Google-Smtp-Source: AGHT+IHAy0WJNnBnDqMunKHr7C1eEeqEFr61o44z3aBx+r5ntLPC1p19W2bF7OMj3IZOmssdnMUu9g==
X-Received: by 2002:a2e:8847:0:b0:2bb:78ad:56cb with SMTP id z7-20020a2e8847000000b002bb78ad56cbmr6563800ljj.37.1698661049360;
        Mon, 30 Oct 2023 03:17:29 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:415:ab66:142e:d74b? ([2a02:8011:e80c:0:415:ab66:142e:d74b])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b003fee53feab5sm8771232wmb.10.2023.10.30.03.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 03:17:29 -0700 (PDT)
Message-ID: <b7fd4a60-d69a-4c2a-806c-7fd46013a5e9@isovalent.com>
Date: Mon, 30 Oct 2023 10:17:26 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 6/6] bpftool: Add support to display uprobe_multi
 links
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Yafang Shao <laoar.shao@gmail.com>
References: <20231025202420.390702-1-jolsa@kernel.org>
 <20231025202420.390702-7-jolsa@kernel.org>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20231025202420.390702-7-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


2023-10-25 21:25 UTC+0100 ~ Jiri Olsa
> Adding support to display details for uprobe_multi links,
> both plain:
> 
>   # bpftool link -p
>   ...
>   24: uprobe_multi  prog 126
>           uprobe.multi  path /home/jolsa/bpf/test_progs  func_cnt 3  pid 4143
>           offset             ref_ctr_offset     cookies
>           0xd1f88            0xf5d5a8           0xdead
>           0xd1f8f            0xf5d5aa           0xbeef
>           0xd1f96            0xf5d5ac           0xcafe
> 
> and json:
> 
>   # bpftool link -p | jq
>   [{
>   ...
>       },{
>           "id": 24,
>           "type": "uprobe_multi",
>           "prog_id": 126,
>           "retprobe": false,
>           "path": "/home/jolsa/bpf/test_progs",
>           "func_cnt": 3,
>           "pid": 4143,
>           "funcs": [{
>                   "offset": 860040,
>                   "ref_ctr_offset": 16111016,
>                   "cookie": 57005
>               },{
>                   "offset": 860047,
>                   "ref_ctr_offset": 16111018,
>                   "cookie": 48879
>               },{
>                   "offset": 860054,
>                   "ref_ctr_offset": 16111020,
>                   "cookie": 51966
>               }
>           ]
>       }
>   ]
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/bpf/bpftool/link.c | 102 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 100 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index a1528cde81ab..21c7e4f038c4 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c

> @@ -889,6 +952,39 @@ static int do_show_link(int fd)
>  			goto again;
>  		}
>  	}
> +	if (info.type == BPF_LINK_TYPE_UPROBE_MULTI &&
> +	    !info.uprobe_multi.offsets) {
> +		count = info.uprobe_multi.count;
> +		if (count) {
> +			offsets = calloc(count, sizeof(__u64));
> +			if (!offsets) {
> +				p_err("mem alloc failed");
> +				close(fd);
> +				return -ENOMEM;
> +			}
> +			info.uprobe_multi.offsets = ptr_to_u64(offsets);
> +			ref_ctr_offsets = calloc(count, sizeof(__u64));
> +			if (!ref_ctr_offsets) {
> +				p_err("mem alloc failed");
> +				free(offsets);
> +				close(fd);
> +				return -ENOMEM;
> +			}
> +			info.uprobe_multi.ref_ctr_offsets = ptr_to_u64(ref_ctr_offsets);
> +			cookies = calloc(count, sizeof(__u64));
> +			if (!cookies) {
> +				p_err("mem alloc failed");
> +				free(cookies);
> +				free(offsets);
> +				close(fd);
> +				return -ENOMEM;
> +			}
> +			info.uprobe_multi.cookies = ptr_to_u64(cookies);
> +			info.uprobe_multi.path = ptr_to_u64(path_buf);
> +			info.uprobe_multi.path_max = sizeof(path_buf);


It seems we're not using "info.uprobe_multi.path_max" after setting it,
although there's no harm in retrieving the value so OK.

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

