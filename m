Return-Path: <bpf+bounces-60106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 657C4AD29FB
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 00:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1950C171206
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 22:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBCD2253F8;
	Mon,  9 Jun 2025 22:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQCB6bV5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAD7224895
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509714; cv=none; b=PmJm8NbYEtvskWIsROTk1ZTgCCq36ByudWRRaeDZVyklg2SERbGHwpMjvKCLZb4DvsHTyV/Nz7UEuBJ58W8Oj7RDigP1/xulJ84iGayb3XBrqP/okO2Kc9vORoOuwGDvOXzYZmSYboN/17uWCk/w3v30XuI60dNSHhS15ES9PkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509714; c=relaxed/simple;
	bh=7y1QHZcptAWjFTeKo64BaI7efX8c1Kz13Tdr6Dsveng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DttvecZ83q1ZY9D1l0m0HoLYNWnlNxlNZrFomwmvWeMugs3kK4IvG+DlojruQRsndJF/7jWBwJkadFC67Due5XdC/72/nHPzyduN3jC+f9RCc1rL5jowJovGQqctzfvGtRiYEVsIq0u3QjeM3S6sZ3UYxZM/rwFax7XaUi0U71k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQCB6bV5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso3842150a91.1
        for <bpf@vger.kernel.org>; Mon, 09 Jun 2025 15:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749509712; x=1750114512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dwggJFoXPULwUBGDxqygPjpmFZS4TMDNJaq9hySwAck=;
        b=UQCB6bV5Usbh0lGq6HA97keNmMcXNh9e9wBS84b+WOWqoBJ093iAGMsDhOd2wOAzSx
         kwM+DiKVQEdcAySdei1YTaYU3HXPkNtRHEtwvwdt+d74Nn6mOXiGpRCpo/vS5fc1t6ej
         p1KbfFJxHIQPl+qfqqOtAk+Gn/4KS8boN8kmM85SCxgp732yTcv3J/sjXVZGFYCisyyl
         hk3dsrlcIFU7AifglWelAtZrA7wym3B9EWIhZ92GOUwlJoDoHTvhVKmnEuVwm78x76VP
         SoHKz4N2MbDghYX/xuZsFyjxRDfKzS9+2uKqstudso/9zulNHvKm7a5B6WM4leGn53hE
         LZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749509712; x=1750114512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwggJFoXPULwUBGDxqygPjpmFZS4TMDNJaq9hySwAck=;
        b=SDxD+F576opflo1bwUUo9mek0hiLJoKSbQMAS0E5FKtonrASs0m8Xtnt5FCk4I+dRx
         T4Pvloy0FHUCZAsB7k/ilmex5gulnuqCONR7uFxFJYaKb35zxSGAHTvpUlXxkPGwVU7p
         itW+IY+YqKEDFFK6tFdYlpAn9dtEPdN/wIMtotP1JnEZBMQD/WD8ux1NCspGPIuCkUFv
         PaJp+19KlS6CPbq4V0OTfrulxTXqazUfuhKAwFjM+v4efVei3i8dZnkGZZihSM15gaeo
         i+10G9iKlk1/X3rrvPbF5dOi6IGUjg8CvEAA2LBTBxjxDcHPBzTisOSNjM0nGgveqNwF
         gtAg==
X-Gm-Message-State: AOJu0YxYSsEcX52vVH0RNTZyd3UDXykyDs2HL+6EQOci6y0DA+/mlmKY
	rwaBnYla1VFo5WY6Z9afFXuZ/9OYpDgHjpb/hXFwl33RhquhtRBJ4qs=
X-Gm-Gg: ASbGnctwO0D/lvchV4kgXvs42eEiEMmkrxuDkpEPtWWpG9T9W/2uPOH1x97U4Yx6jsV
	Oj4AzYKBtksYKGFTQoYldqvcIBApu6QUwwhjxcOBRvx2RF9llw8LsQrLRcvhmboRqGZ/m/YZybv
	AjZJF5V1LeoRnseYislAfBkOvTzQiWdVH+obOzgL6cPNey/lV69OVpEtZmPgtzBLqNyuX+n6hCH
	ERRcWtJj50nhqjdG6qnUUJs4j1B1OVlv0VZAPie4FkzfXzxG52H/8lfk+GQSB32hmoZTebcZCrU
	il913KMoEFGqu6vZOpn/DUw/S/EYjiAnIEXw5iI67NQG7u4aFKyVo/4/5gr85Ilkksx/59yP07W
	DZQkzj3wc+BazCXvqF7zpOM4=
X-Google-Smtp-Source: AGHT+IH8QGSOZv7cHnVUpcBWIgBBNqbDhlYj4wsnFm+YgHCcmaJvBabF+OjiTLsVp3P9Qgo7m2hAtw==
X-Received: by 2002:a17:90b:55c7:b0:311:ad7f:3281 with SMTP id 98e67ed59e1d1-313472e5bcamr23268101a91.12.1749509711963;
        Mon, 09 Jun 2025 15:55:11 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23603410b9bsm59108515ad.213.2025.06.09.15.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 15:55:11 -0700 (PDT)
Date: Mon, 9 Jun 2025 15:55:10 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Fix two net related test
 failures with 64K page size
Message-ID: <aEdmTuCtAJ2D9gam@mini-arch>
References: <20250608165534.1019914-1-yonghong.song@linux.dev>
 <20250608165539.1020481-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250608165539.1020481-1-yonghong.song@linux.dev>

On 06/08, Yonghong Song wrote:
> When running BPF selftests on arm64 with a 64K page size, I encountered
> the following two test failures:
>   sockmap_basic/sockmap skb_verdict change tail:FAIL
>   tc_change_tail:FAIL
> 
> With further debugging, I identified the root cause in the following
> kernel code within __bpf_skb_change_tail():
> 
>     u32 max_len = BPF_SKB_MAX_LEN;
>     u32 min_len = __bpf_skb_min_len(skb);
>     int ret;
> 
>     if (unlikely(flags || new_len > max_len || new_len < min_len))
>         return -EINVAL;
> 
> With a 4K page size, new_len = 65535 and max_len = 16064, the function
> returns -EINVAL. However, With a 64K page size, max_len increases to
> 261824, allowing execution to proceed further in the function. This is
> because BPF_SKB_MAX_LEN scales with the page size and larger page sizes
> result in higher max_len values.
> 
> Updating the new_len parameter in both tests from 65535 to 262143 (0x3ffff)
> resolves the failures.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c | 2 +-
>  tools/testing/selftests/bpf/progs/test_tc_change_tail.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
> index 2796dd8545eb..4f7f08364c75 100644
> --- a/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
> +++ b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
> @@ -31,7 +31,7 @@ int prog_skb_verdict(struct __sk_buff *skb)
>  		change_tail_ret = bpf_skb_change_tail(skb, skb->len + 1, 0);
>  		return SK_PASS;
>  	} else if (data[0] == 'E') { /* Error */
> -		change_tail_ret = bpf_skb_change_tail(skb, 65535, 0);
> +		change_tail_ret = bpf_skb_change_tail(skb, 262143, 0);
>  		return SK_PASS;
>  	}
>  	return SK_PASS;
> diff --git a/tools/testing/selftests/bpf/progs/test_tc_change_tail.c b/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
> index 28edafe803f0..b1057fda58a0 100644
> --- a/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
> @@ -94,7 +94,7 @@ int change_tail(struct __sk_buff *skb)
>  			bpf_skb_change_tail(skb, len, 0);
>  		return TCX_PASS;
>  	} else if (payload[0] == 'E') { /* Error */
> -		change_tail_ret = bpf_skb_change_tail(skb, 65535, 0);
> +		change_tail_ret = bpf_skb_change_tail(skb, 262143, 0);
>  		return TCX_PASS;
>  	} else if (payload[0] == 'Z') { /* Zero */
>  		change_tail_ret = bpf_skb_change_tail(skb, 0, 0);

nit: this seems to be exercising BPF_SKB_MAX_LEN case. To make it easier to
spot in the future, can we do the following in both tests?

#define PAGE_SIZE 65536 /* make it work on 64K page arches */
#define BPF_SKB_MAX_LEN (PAGE_SIZE << 2)

... = bpf_skb_change_tail(skb, BPF_SKB_MAX_LEN, 0);

