Return-Path: <bpf+bounces-49598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F107A1AA41
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 20:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF2018835D3
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 19:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD7A19D060;
	Thu, 23 Jan 2025 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IicBwH7q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA56715A85A;
	Thu, 23 Jan 2025 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737659927; cv=none; b=TQETJmp7F2X6RG/IeSpkCab3Yl528vaEflAJuOLATwEgHgwjYSpGRq1wRM3sH4rkrIY4srut+VhR16rWb0ICERrhNQpZP5wmbd2SPZ8Lr0EsiumucoN8ZNDFtPPcELHH5hCaZduFJFUYz8ZU5UsBQHsGQLqX1pZHm8ekm7yHVic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737659927; c=relaxed/simple;
	bh=9t9s7VyEvGSjgbBfs4CDpB2+zbR9WMZYihfUYOH2m30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3fVEu4RYjAARimEQtSvRvmySO3HZDlzfh1RFBbJG/gU699eXzjyfRF0929Wouox4wGUh7dufo1m7Kwvy/YYXa/R6rRU4AhDRtAJMGyoqeM/hQDG3LFdSEX5Tac+EGzKbLSTlgrcAGMOONOlb44NsMXKcukxvlmqQm47ndljl5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IicBwH7q; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2161eb95317so23462525ad.1;
        Thu, 23 Jan 2025 11:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737659925; x=1738264725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YBSgMWTI3dwtcBaBZxNtlTQPA/DEsWXHuT1PLaL7NBM=;
        b=IicBwH7q+9J1Dw2MKtsKd6eQLawwSei5cEFlmqnD17a0mhwu+3c7L6q/tc+Aq2LPoU
         PXjo1uUhFMmDc9vj2T/WX/SGkeCjmuyK3eL+z+qIjz0Ni4RIfKVZRq3f+uolnw2zryPE
         Im0PZZpF/kFEr/4UEZjl4BUZz5RKVEis8o9Qbte//Wr+dugmXoE7oqPvAK1Kjw4Ig4el
         +eHiwnuuhGGwGUlhVSwGpVFPPhgxLoxbM1Uct2CT85n9XBJmxue7Hpj/TtYZirrN3o3N
         O2M8La9420fKh3FnKlJruumbWYMyDS788sbukEbtmnH04XZ6K8SUoI+QY0W4yOV436tl
         8GQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737659925; x=1738264725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBSgMWTI3dwtcBaBZxNtlTQPA/DEsWXHuT1PLaL7NBM=;
        b=JBP6ERXUcILyDcXAI8d4xrKF/54WHuwDnDJEG7e7mkaJkRD+HewRnAwRnVfwi0uD1d
         vI9f8UhyXfhPIhnhuncutOzDHTBOsDSiXO6/n9Non8xpMJ09LhEq/Xeyk6SyPZ9puWHU
         UkOAo8klCfrTizG/ESaglt860BD4Kmw8gWA7VFBxVEeYo+E5LoV6ik5oB6m7plr5GV6Z
         wbL6HT+IE6wjvtviYYlh9pkK4DNtsfhgeUIEooAjfvACdtoPFnWrcs9+4gwA2SIVRDnp
         B/cu12drldsR1vtyyL5yUYwKiW4/+RJjZJRfShyy7RBRjn0+I+cZ+18A5u8w5rICAthO
         kicQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBVsNMLAdxA7+g7ZSfB9c40ptJGiqFvWSCFPHwInPFiTV2ctnkulMbmj+AwQv552pMZg1Gs6Y3@vger.kernel.org, AJvYcCWLOZCcjkgLleOzcmBznFK5nqpEdw7G6ruV9enslg4Iq6/smpyUdT8H1sjfucvZ7f5xZT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGiHh8ndW4WYPL0/BsNOiOTNtmVltoz6cx7sbqcF7zozuCgUO0
	ZbMtuEbDDLNd4ij1OPn07tXnG9lF1u2MykRyspFPncwjv6WW688=
X-Gm-Gg: ASbGncsXudkuk5mitgnSZ7N05VwnVVHrd77YSAJKKNI1r+QV8mRkDaA/PwnTeulYJ3x
	OrZpMCy7bvPJFUEvTx3n/F/8gIOhdwwUMvONTdbyAFriuTQIB+fGtvq9ahA/eP8ySsNTzchgczx
	IXkG39bYMsCmugfs97KsuJ458sS8xVBYyyGZT1wKLWtmpX46OXHQI7w8BBnSnBhIyZ8fFfoO7eE
	/gajoacoP3OmdWTdepn/xhYFiqvWPiwqoaMGjg8wzSkGqqs9tLSWqZst0r1TuhZda4B9tvAr7Gn
	LaksJoTHYwZLCgETeqk2LrP+D96LdN3JwiLuFro=
X-Google-Smtp-Source: AGHT+IEdxnpW0w99kG2D4WWsnNLJc7c90ASv1KRcuQSGfZg8MM+ra09LM2mAqt2Tdv7SIT3p8Xv+Sg==
X-Received: by 2002:a17:902:f60f:b0:215:8270:77e2 with SMTP id d9443c01a7336-21c34cb5bf8mr435672365ad.0.1737659924871;
        Thu, 23 Jan 2025 11:18:44 -0800 (PST)
Received: from localhost (c-174-160-0-128.hsd1.ca.comcast.net. [174.160.0.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea3aeasm2605125ad.64.2025.01.23.11.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:18:44 -0800 (PST)
Date: Thu, 23 Jan 2025 11:18:43 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	hawk@kernel.org, lorenzo@kernel.org, toke@redhat.com,
	bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Adjust data size to have
 ETH_HLEN
Message-ID: <Z5KWE6J8OtRVCFDR@mini-arch>
References: <20250121150643.671650-1-syoshida@redhat.com>
 <20250121150643.671650-2-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250121150643.671650-2-syoshida@redhat.com>

On 01/22, Shigeru Yoshida wrote:
> The function bpf_test_init() now returns an error if user_size
> (.data_size_in) is less than ETH_HLEN, causing the tests to
> fail. Adjust the data size to ensure it meets the requirement of
> ETH_HLEN.
> 
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  .../testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c  | 4 ++--
>  .../testing/selftests/bpf/prog_tests/xdp_devmap_attach.c  | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
> index c7f74f068e78..df27535995af 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c
> @@ -52,10 +52,10 @@ static void test_xdp_with_cpumap_helpers(void)
>  	ASSERT_EQ(info.id, val.bpf_prog.id, "Match program id to cpumap entry prog_id");
>  
>  	/* send a packet to trigger any potential bugs in there */
> -	char data[10] = {};
> +	char data[ETH_HLEN] = {};
>  	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
>  			    .data_in = &data,
> -			    .data_size_in = 10,
> +			    .data_size_in = sizeof(data),
>  			    .flags = BPF_F_TEST_XDP_LIVE_FRAMES,
>  			    .repeat = 1,
>  		);

We should still keep 10, but change the ASSERT_OK below to expect the
error instead. Looking at the comment above, the purpose of the test
is to exercise that error case.

Same for the other two cases.

