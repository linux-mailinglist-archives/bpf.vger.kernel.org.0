Return-Path: <bpf+bounces-62142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D15AF5DF8
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 18:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3431C41273
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813D43596F;
	Wed,  2 Jul 2025 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ousopu3Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FB0248886;
	Wed,  2 Jul 2025 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751472186; cv=none; b=pYE8X7pa7sz+XSgmcAwEGT7ReS0qGovE+1woe1xEta+1ajhUa9iEDLe7bSKvbkR8NksHO5onPNdCUN/BTwpnxzb00vsYO21oHxXdOndVbqy0Mv4Ih3MIJxKua+OmgLtbcOEUouPXC8ynH8jv+MIP+E6asi9UcoSBFUW6F0T799M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751472186; c=relaxed/simple;
	bh=Zi8Z++KLh4kL+UMMKoA+zinKpsd+b3nC1ZGt2R1rFNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJOe1APJPBL6uUziTSGofol6LOmfpWIPMklhSuAGNv8y70uYJU8ttJ+sJ06TlZQyX/shL8tjRUwME2vIOEYDt29Shg2WMuWGRsPOF9n623NiMq9F/7hwOkx5RpzlA8fSOj7WLovgzdkSm9Ep2UgUhBsNgAP1xoLpVawjbnOtxYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ousopu3Y; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234f17910d8so69156665ad.3;
        Wed, 02 Jul 2025 09:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751472183; x=1752076983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EFEBFp97Sfl6k7pz3Xu7cvhoxL+fH0WrE6fJ29qUrd0=;
        b=Ousopu3YU1H35kbOwGHRcSwi4YA1sxqeTZHMilysuRJUILoAUiohubCZCC6lDAfcz5
         aJtEj6HXXCGlzIJ5L4AcnM8gbk9XJASFU/YS1umCChWs0SOAdaADiHf4oU+E+AUuUqtA
         4Hh1kZLVl+EI1LRSBq3D0WklFp7e33cx9CG7FoviaOSVHxDE16jTaunrGKRcxXJ7dYfn
         G61mv3qlJnBQ+eJccNVuKz7uICa5awcENYAqmMYm6/waFXeSKTDCgrrBOwQpEMijFy0z
         mX5beq0eOSVaGm809n9IkMeZHFdGVawUpYYvF2ndcmPcryicUG8Y6YsRrLsLZKRJalHm
         1m5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751472183; x=1752076983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFEBFp97Sfl6k7pz3Xu7cvhoxL+fH0WrE6fJ29qUrd0=;
        b=G3lkLUze+KjNjTDqOx1t+rekjBYrZa3EyDbOiVD+yBsfWGL9Y8kDZPqPUe7x1j5qAS
         CwoEqQ5xNMAMaxP10JgssghKLqxgv2o2Czhc9MytQdBUmhCN9FQu37cutHHvpuaoOUxu
         IIPwC1iUwjxKDXH7jM/RjQX5jvluOF+ypPXOMNP6iC+U0Fo3iY+Y16Wzhvg5JEthNWDr
         NsbJnKlaRWD8kym7yfkiNLkbZBZWo0aexkXnQwWxAZfag8AKzD1MfW8FhEOOiWnvPNgx
         VleavLdDC0YjrWnYDEjaomqIeSo1XJeP5sLbRZ7KEkrgJFTmlsRKHokpnvG3+8S60c1A
         9bQg==
X-Forwarded-Encrypted: i=1; AJvYcCUZq3kwXkRyGAasQMwF5ryyrIFareq8z6egv4TPuslT0SJXE+Dwt8cU6xA3d5Y8oILTt9c=@vger.kernel.org, AJvYcCWjghaS+oUzwn7zTCK03798EV7UxlEC0jrRlVn+yfLED2G7g7oiQ8xLAwzienPijxY0oY0Rawl+@vger.kernel.org
X-Gm-Message-State: AOJu0YwkJeOZUh2rjTL8K3z2aKRH4iHx2xxoVZO3EJdFNUVujAGZK2YI
	wevhxSuJXN6Q/6Ke/l+T2oqgFLC99GIR3yYqBQG4ntM5+adna08kuPQ=
X-Gm-Gg: ASbGncsi4qFjCVp66YPGy/gnrVSIFZzIr4y+M5p2q+TpU19Tj2oLgSAQCH5sTVekypd
	/JgBzo2gKSdW3LkFVoBgkIrOHy8Q2HkUkScA/8/ti4qDc/Zde1o1vGlsyLfmal04oql7XucfSaB
	+nbaiEXeJDB0lkUHFyrMli5UdwhPrgsmsIU6yjDnbYTO5V3LqEL5Ju6VYREfuqbVAAzqdRQR62q
	CImYjkO4CbrK22eFk2c5WFXf04dcvaj0ZuTC+dXSlYeKqjc6D6/1xlDQ0NNoVDRQdVuGbg4LEg/
	/LJUTcw++JzksF1dCNZ5SCgGEjKNsbSxU+KCDOXBMQP2dvOB5Qe54i7WVTxxRu65OBZGMyxqRj5
	h7GXrBWWF6WnB6SyhexCDGAg=
X-Google-Smtp-Source: AGHT+IEogCgd8FoNuhehrmrLcBURhOw6hs6ezKGGZkA1MsAWZwwHetkX2Dq5hYL5OBgu2e9LBxo/Zg==
X-Received: by 2002:a17:903:1510:b0:234:986c:66f9 with SMTP id d9443c01a7336-23c6e587745mr50795035ad.22.1751472183256;
        Wed, 02 Jul 2025 09:03:03 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3b8409sm139504355ad.184.2025.07.02.09.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:03:01 -0700 (PDT)
Date: Wed, 2 Jul 2025 09:03:00 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to,
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v5 2/2] selftests/bpf: add a new test to check
 the consumer update case
Message-ID: <aGVYNMZEZQV1SetF@mini-arch>
References: <20250702112815.50746-1-kerneljasonxing@gmail.com>
 <20250702112815.50746-3-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250702112815.50746-3-kerneljasonxing@gmail.com>

On 07/02, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> The subtest sends 33 packets at one time on purpose to see if xsk
> exitting __xsk_generic_xmit() updates the global consumer of tx queue
> when reaching the max loop (max_tx_budget, 32 by default). The number 33
> can avoid xskq_cons_peek_desc() updates the consumer when it's about to
> quit sending, to accurately check if the issue that the first patch
> resolves remains. The new case will not check this issue in zero copy
> mode.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v5
> Link: https://lore.kernel.org/all/20250627085745.53173-1-kerneljasonxing@gmail.com/
> 1. use the initial approach to add a new testcase
> 2. add a new flag 'check_consumer' to see if the check is needed
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 51 +++++++++++++++++++++++-
>  tools/testing/selftests/bpf/xskxceiver.h |  1 +
>  2 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 0ced4026ee44..ed12a55ecf2a 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -109,6 +109,8 @@
>  
>  #include <network_helpers.h>
>  
> +#define MAX_TX_BUDGET_DEFAULT 32
> +
>  static bool opt_verbose;
>  static bool opt_print_tests;
>  static enum test_mode opt_mode = TEST_MODE_ALL;
> @@ -1091,11 +1093,45 @@ static bool is_pkt_valid(struct pkt *pkt, void *buffer, u64 addr, u32 len)
>  	return true;
>  }
>  
> +static u32 load_value(u32 *counter)
> +{
> +	return __atomic_load_n(counter, __ATOMIC_ACQUIRE);
> +}
> +
> +static bool kick_tx_with_check(struct xsk_socket_info *xsk, int *ret)
> +{
> +	u32 max_budget = MAX_TX_BUDGET_DEFAULT;
> +	u32 cons, ready_to_send;
> +	int delta;
> +
> +	cons = load_value(xsk->tx.consumer);
> +	ready_to_send = load_value(xsk->tx.producer) - cons;
> +	*ret = sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);
> +
> +	delta = load_value(xsk->tx.consumer) - cons;
> +	/* By default, xsk should consume exact @max_budget descs at one
> +	 * send in this case where hitting the max budget limit in while
> +	 * loop is triggered in __xsk_generic_xmit(). Please make sure that
> +	 * the number of descs to be sent is larger than @max_budget, or
> +	 * else the tx.consumer will be updated in xskq_cons_peek_desc()
> +	 * in time which hides the issue we try to verify.
> +	 */
> +	if (ready_to_send > max_budget && delta != max_budget)
> +		return false;
> +
> +	return true;
> +}
> +
>  static int kick_tx(struct xsk_socket_info *xsk)
>  {
>  	int ret;
>  
> -	ret = sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);
> +	if (xsk->check_consumer) {
> +		if (!kick_tx_with_check(xsk, &ret))
> +			return TEST_FAILURE;
> +	} else {
> +		ret = sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);
> +	}
>  	if (ret >= 0)
>  		return TEST_PASS;
>  	if (errno == ENOBUFS || errno == EAGAIN || errno == EBUSY || errno == ENETDOWN) {
> @@ -2613,6 +2649,18 @@ static int testapp_adjust_tail_grow_mb(struct test_spec *test)
>  				   XSK_UMEM__LARGE_FRAME_SIZE * 2);
>  }
>  
> +static int testapp_tx_queue_consumer(struct test_spec *test)
> +{
> +	int nr_packets = MAX_TX_BUDGET_DEFAULT + 1;
> +
> +	pkt_stream_replace(test, nr_packets, MIN_PKT_SIZE);
> +	test->ifobj_tx->xsk->batch_size = nr_packets;
> +	if (!(test->mode & TEST_MODE_ZC))
> +		test->ifobj_tx->xsk->check_consumer = true;

The test looks good to me, thank you!

One question here: why not exit/return for TEST_MODE_ZC instead
of conditionally setting check_consumer?

