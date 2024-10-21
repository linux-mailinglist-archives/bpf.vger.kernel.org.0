Return-Path: <bpf+bounces-42589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DD89A60B2
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 11:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF4028470E
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 09:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F5A1E3DCD;
	Mon, 21 Oct 2024 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGYPKztB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886B4194AD9
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504318; cv=none; b=NBGRYwK2WRFqvbqLoEihge/D5ltD3wsF+we6mxOAosSDxxBY+M0jfk0+xfm0x6KjJum7Q8GSHeVpVa9gjBPZrP2dbCOv5vX5ocCMRJpTh0uVyLhfRdLsJQOLSctARKeIgHETutuS+6XLPytlyx2NFT9P8QpsC59YH0T3fM936Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504318; c=relaxed/simple;
	bh=LYOTXesdWAlz1nVCf1dFPhqWzaHyp5lD8qXLj8Tn++o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxlfylLEaxpLDUozXSdQOLYihtM1fNzT39QFLhWjrIod+ifhzqdMy/OMLhCUHfitrplTkntM7EUuf49q3M8bGqJXbhUco1W3bCG2HKgELgDsU5hxM0jWnMUthpt2kz9CA6Ft9Kc+zklbz1K0ukMgQt30lBK0y+E51rQVYOe7t6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGYPKztB; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539fb49c64aso5810671e87.0
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 02:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504314; x=1730109114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zhwvd6d8EPufcA2MpFYYz2Del6b4DAd1NauntSkCSco=;
        b=dGYPKztBXRSJVSjC8amvk5/iQsWauzUElYuR8swLnF/0dDj21Pry1DtLI6dvA6nUgf
         rvdARZZ1nFLUdX4N/OudriuqK6XAO2DchX8mVn0s2DzswXozSn4Gd/2Dx0tye9Ql+3rC
         UwUSPBPm72mh3nPL6xjXCxTQnyOyO1ySMuosF34bq+8tWBt6XkY9zxh7XkVfplISck/G
         gPSXfudWfIRMKYcdQZncoGsiX7ZcimkBLfywreUR5YDd0WD/b6A+bPUi3Eimq25u/Gzf
         1EWWj4NTQl7GE2THfPpphLb5h1mO1eDEQscAHNkDI3a83Cuhm4wBmT2Q1NTMkZnKYC4k
         t8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504314; x=1730109114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zhwvd6d8EPufcA2MpFYYz2Del6b4DAd1NauntSkCSco=;
        b=SqDlxKxPS+8Vbuob8Z164DC2Eu59gwYakXfwY04CqRLlR0NgGTICowH4MoXplVIGuC
         BtAWv2CVhVfLyHu0eIxDFXF2+qXyFmetzgikO8GmAtZRB8rev9rtpEXPAcW3YAuoPf7D
         SrRzQVfWNsO4PKJTXaEvnTZ+GaTKpo8P30KxD6FOSemXvboeGz3msajCJb/+q75aU8Tb
         kkt6xWnMzNJnpfrUBVX8ioSPPGNIXm2duLOgA7v13swwyVhkVZxUkREa67Y5BtQxqSO/
         0wJepzQnJpa+xVlg1Q0450KaubtDapKfT06O41zL+3XReAapFMDETMuJC6S2mtZCoIQp
         iDqw==
X-Gm-Message-State: AOJu0Yzup7mp/qJ6HRZ6wU0Zvlnpw3zSslE+u8GY99eHKuIiGP/8ai2L
	+C1zvLYmdkCpoO/+sw+vZLZZAXcpuLn8AhFa8nYGhdl3d0RiQ7yO
X-Google-Smtp-Source: AGHT+IEBvnl6jqSBoDenEFqDYkC8FwvJlVNYxeCwB8NMQnQW7s7Cl64l3wbXkcSn5Hy8jAh0J0mCbw==
X-Received: by 2002:a05:6512:3b89:b0:52c:cd77:fe03 with SMTP id 2adb3069b0e04-53a1544481emr8627411e87.14.1729504314350;
        Mon, 21 Oct 2024 02:51:54 -0700 (PDT)
Received: from krava (85-193-35-184.rib.o2.cz. [85.193.35.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912ed80fsm183743966b.46.2024.10.21.02.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:51:54 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 21 Oct 2024 11:51:52 +0200
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	John Fastabend <john.fastabend@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>, houtao1@huawei.com,
	xukuohai@huawei.com
Subject: Re: [PATCH bpf v2 5/7] bpf: Check the validity of nr_words in
 bpf_iter_bits_new()
Message-ID: <ZxYkOKC0xNBWbG95@krava>
References: <20241021014004.1647816-1-houtao@huaweicloud.com>
 <20241021014004.1647816-6-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021014004.1647816-6-houtao@huaweicloud.com>

On Mon, Oct 21, 2024 at 09:40:02AM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Check the validity of nr_words in bpf_iter_bits_new(). Without this
> check, when multiplication overflow occurs for nr_bits (e.g., when
> nr_words = 0x0400-0001, nr_bits becomes 64), stack corruption may occur
> due to bpf_probe_read_kernel_common(..., nr_bytes = 0x2000-0008).
> 
> Fix it by limiting the max value of nr_words to 512.

lgtm, nice catch .. it's actually stated in the comment,
but we did not force it

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Fixes: 4665415975b0 ("bpf: Add bits iterator")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/helpers.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 62349e206a29..c147f75e1b48 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2851,6 +2851,8 @@ struct bpf_iter_bits {
>  	__u64 __opaque[2];
>  } __aligned(8);
>  
> +#define BITS_ITER_NR_WORDS_MAX 512
> +
>  struct bpf_iter_bits_kern {
>  	union {
>  		unsigned long *bits;
> @@ -2892,6 +2894,8 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
>  
>  	if (!unsafe_ptr__ign || !nr_words)
>  		return -EINVAL;
> +	if (nr_words > BITS_ITER_NR_WORDS_MAX)
> +		return -E2BIG;
>  
>  	/* Optimization for u64 mask */
>  	if (nr_bits == 64) {
> -- 
> 2.29.2
> 

