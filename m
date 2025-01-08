Return-Path: <bpf+bounces-48240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AA6A05994
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 12:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D983A6160
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 11:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0189C1F8902;
	Wed,  8 Jan 2025 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZ+S1548"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9011A072A
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736335573; cv=none; b=kcFZ0ZjPZmrP6NluSv0VGPZhHG1iP1kQPtq6ziPEXkil1KKZ0LXF3wjbRI7wBejpg4z9uTKrc+oaaTyF8SiTbYh/CkiMBtCfdTexBpreu5TXEOaFJeux/Eab/HaS+l4FWyKoYZblZXbSNAGyT0fted+pQ0lHAEdU6N1uJ0653f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736335573; c=relaxed/simple;
	bh=VCu5tzWnRPhZF/Svyps9uKufX/nDeDZRHVoFQA2gtGk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3u18ZnUNBblimTrCJ7FooEQ/UyjBfvEj4cAFIQXSXeyHuZlwVHa4plfrjYY8kmZi20FvzgnV+0LJgRmLr3CnBabAiIZePHxMBQ/05cmlEQcrIQzYXyX7IBiy55EIJtQct22q2rBEUpScORkZIhhpVtgx/EljQ+DtbgDZO8pKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZ+S1548; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso2532363a12.0
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 03:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736335570; x=1736940370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oIoMINNKZbEDqeabFeWhp7yZ8dd05pa3zSnrevpoLSI=;
        b=IZ+S1548uKq/2RDOkqQnuUH9y+Gl8GVt3IA/krB5wgbgPCojBQBV8VOY8C8nu3qlsY
         /ryNXf0Zr+0T5h/EbYlyiOyIvk4HrPOwT6GVtgZoh13xR+yFF8TVMGOX2juMiXWFprRs
         4eTmH3buS036rJowp8auGQg6DjRAOUgYbogahhjVaEUvM/oPHbSkuk2mWKFEBze4fMj6
         2f+CtaneTrlgQfykwuEK3n6PfRsengxIb9SJ7CSKhDZvUm+j6wZ49SEiZLKxIg9iYYNS
         1uXz9bUBvca5RERaPKjkE6+lCLqEMtH9Fz+Y70htut5XpbTi+gpbvUJ8aKVB+S06MRtf
         m6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736335570; x=1736940370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIoMINNKZbEDqeabFeWhp7yZ8dd05pa3zSnrevpoLSI=;
        b=s4zuwFYHUY8MhcHrpfznvVe2UOU0A6XSosu2VuRpNdIp8BjihW17A4GHbwHdi21SeZ
         qDhleCNaOP0EcCnfmp0BqCOfVM7++5BRfcAVtVgOoLVkfhPf//2bgMv/drOaWwDiISOe
         x54gb3jBoA9irIUOSx6wD9b8I/4oMEosQoJY7IHqxRnQcJDJCwjlfnumN1ajOksR5uRk
         bVroJFsWKN5lTcIjJWSbU+s1FBDItxLQAYX9Vy3xc4mMMU5Iyz4EJb1QNVjjN1b8oHUc
         c45DUUjmkr4F7+5OCT6b+Z8t8DH6oHDeunxjGlkyDw2YBZYGeM7j1d01uD1wnspDgSMk
         zyTw==
X-Gm-Message-State: AOJu0YwvDBD6R0obbpOUlBW+9UnXHJ0hJW52H2nBNXsbYQzjcRFizNtF
	i3csUMmNobktthdc8CHMDgsBp4Kn+TXBJpbMHR4w4vxWHnGUoz3U/koKUg==
X-Gm-Gg: ASbGnctWLV22BO8Wksc/G3VxxrhOnZcK8yVPjVaKbM7RrHxouqLASjK37C6E80UoHYT
	FllDzVI4CRC9yIFo6hav2iVgSkLgSAzQ28UMqng5/SOHcjHDNQGPugkkUbEBTjk82XPKhseWuYa
	1iKlq/dJiZQSPZXPu5uduD64nqLaMCmzq8c7SXOc+Xg0mrRw9JZPcIZELR+4p9Debwx8Shaisvj
	uBPj6e+QKgtlQmzGcQgr2uH3GfzaOrkGey/PQ+xMFc=
X-Google-Smtp-Source: AGHT+IGOhUEGYud7nFDpGlsA19+/TI6C4HNnBo+4hPOzwcDvpuwBh/UNYDtPSxUs8gXJcVx5ZAN15Q==
X-Received: by 2002:a05:6402:5006:b0:5d0:e877:7664 with SMTP id 4fb4d7f45d1cf-5d972e178f7mr2014909a12.19.1736335569797;
        Wed, 08 Jan 2025 03:26:09 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a41esm25116412a12.1.2025.01.08.03.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 03:26:09 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 8 Jan 2025 12:26:07 +0100
To: Pu Lehui <pulehui@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jann Horn <jannh@google.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next v2] bpf: Move out synchronize_rcu_tasks_trace
 from mutex CS
Message-ID: <Z35gz9q8z7LBNssS@krava>
References: <20250104013946.1111785-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104013946.1111785-1-pulehui@huaweicloud.com>

On Sat, Jan 04, 2025 at 01:39:46AM +0000, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Commit ef1b808e3b7c ("bpf: Fix UAF via mismatching bpf_prog/attachment
> RCU flavors") resolved a possible UAF issue in uprobes that attach
> non-sleepable bpf prog by explicitly waiting for a tasks-trace-RCU grace
> period. But, in the current implementation, synchronize_rcu_tasks_trace
> is included within the mutex critical section, which increases the
> length of the critical section and may affect performance. So let's move
> out synchronize_rcu_tasks_trace from mutex CS.

lgtm, adding peter

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
> v2: Simplify code logic. (Jiri)
> 
>  kernel/trace/bpf_trace.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 48db147c6c7d..a90880f475af 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2245,6 +2245,7 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
>  {
>  	struct bpf_prog_array *old_array;
>  	struct bpf_prog_array *new_array;
> +	struct bpf_prog *prog = NULL;
>  	int ret;
>  
>  	mutex_lock(&bpf_event_mutex);
> @@ -2265,18 +2266,22 @@ void perf_event_detach_bpf_prog(struct perf_event *event)
>  	}
>  
>  put:
> -	/*
> -	 * It could be that the bpf_prog is not sleepable (and will be freed
> -	 * via normal RCU), but is called from a point that supports sleepable
> -	 * programs and uses tasks-trace-RCU.
> -	 */
> -	synchronize_rcu_tasks_trace();
> -
> -	bpf_prog_put(event->prog);
> +	prog = event->prog;
>  	event->prog = NULL;
>  
>  unlock:
>  	mutex_unlock(&bpf_event_mutex);
> +
> +	if (prog) {
> +		/*
> +		 * It could be that the bpf_prog is not sleepable (and will be freed
> +		 * via normal RCU), but is called from a point that supports sleepable
> +		 * programs and uses tasks-trace-RCU.
> +		 */
> +		synchronize_rcu_tasks_trace();
> +
> +		bpf_prog_put(prog);
> +	}
>  }
>  
>  int perf_event_query_prog_array(struct perf_event *event, void __user *info)
> -- 
> 2.34.1
> 
> 

