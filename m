Return-Path: <bpf+bounces-56209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB87A92E6F
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 01:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DC48E433A
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 23:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECED62222DB;
	Thu, 17 Apr 2025 23:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Hb1HdVS2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3C1A7045;
	Thu, 17 Apr 2025 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744933530; cv=none; b=NeZw1SgYsE9RU4WYijXLJBkHgeku5GCnuB1V0Sgu4ZCgNzIQBv8o0Dgb0xvKXoQJ4lNsoEd4nyIEZjE+g9ZNhc64EyyeQUVWxvDaHZskqfpUMm8NxGhoWz3GjAA2pBszz50aPOuA2z5VLkzhiPBP3ARqjbS/5seHH0g1PvSvdlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744933530; c=relaxed/simple;
	bh=PCzMKnJv/m8xqpDMbRazjX5Q4lJGzT8lf4RSG1UTexI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YdNWLVDPEMGcZckvCvpYTnv0rLMV2Wjj+9SnT9zK/+ZlbFcfggR2Wva8kICIXWWtYug0HWakdHSeg3Ikx9bqauZkg74HHpBRZoJAMEv5LLB3Hvdz23ipKWcWQRWrx28wzdYWedocHPGWaErMEGn6Uts1v4zlmkSYocxfcKRbMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Hb1HdVS2; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744933529; x=1776469529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AVUgy0bGI4UEtR8bg3+HqZzgAwSJS1movKE+5Gy92JY=;
  b=Hb1HdVS2FuxPhoikFAoSju/QzkXNSP2QVB5Cyy1pxLLFf9pIOxCtgGCI
   fLrdXAJFSzjuvt5D2XddxDBgIilYyo7LCdn99KEGeqilqmjspP+2Th/7i
   UvOaZIzxV+M+BF+xhsHH0s0ZbmMCpIVuiGo90zSrihS2EtpEGjDgdzXMV
   A=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="512497739"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 23:45:22 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:50421]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.65:2525] with esmtp (Farcaster)
 id 00fa4b48-89df-4370-969f-209fed1572de; Thu, 17 Apr 2025 23:45:22 +0000 (UTC)
X-Farcaster-Flow-ID: 00fa4b48-89df-4370-969f-209fed1572de
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 23:45:21 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 23:45:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jordan@jrife.io>
CC: <aditi.ghag@isovalent.com>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
	<kuniyu@amazon.com>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/6] bpf: udp: Make sure iter->batch always contains a full bucket snapshot
Date: Thu, 17 Apr 2025 16:45:04 -0700
Message-ID: <20250417234511.39315-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416233622.1212256-3-jordan@jrife.io>
References: <20250416233622.1212256-3-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jordan Rife <jordan@jrife.io>
Date: Wed, 16 Apr 2025 16:36:17 -0700
> @@ -3454,15 +3460,26 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>  				batch_sks++;
>  			}
>  		}
> -		spin_unlock_bh(&hslot2->lock);
>  
>  		if (iter->end_sk)
>  			break;
> +next_bucket:
> +		/* Somehow the bucket was emptied or all matching sockets were
> +		 * removed while we held onto its lock. This should not happen.
> +		 */
> +		if (WARN_ON_ONCE(!resizes))
> +			/* Best effort; reset the resize budget and move on. */
> +			resizes = MAX_REALLOC_ATTEMPTS;
> +		if (lock)
> +			spin_unlock_bh(lock);
> +		lock = NULL;
>  	}
>  
>  	/* All done: no batch made. */
>  	if (!iter->end_sk)
> -		return NULL;
> +		goto done;

If we jump here when no UDP socket exists, uninitialised sk is returned.
Maybe move this condition down below the sk initialisation.


> +
> +	sk = iter->batch[0];
>  
>  	if (iter->end_sk == batch_sks) {
>  		/* Batching is done for the current bucket; return the first
> @@ -3471,16 +3488,30 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>  		iter->st_bucket_done = true;
>  		goto done;
>  	}
> -	if (!resized && !bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2,
> -						    GFP_USER)) {
> -		resized = true;
> -		/* After allocating a larger batch, retry one more time to grab
> -		 * the whole bucket.
> -		 */
> -		goto again;
> +
> +	/* Somehow the batch size still wasn't big enough even though we held
> +	 * a lock on the bucket. This should not happen.
> +	 */
> +	if (WARN_ON_ONCE(!resizes))
> +		goto done;
> +
> +	resizes--;
> +	if (resizes) {
> +		spin_unlock_bh(lock);
> +		lock = NULL;
> +	}
> +	err = bpf_iter_udp_realloc_batch(iter, batch_sks * 3 / 2,
> +					 resizes ? GFP_USER : GFP_ATOMIC);
> +	if (err) {
> +		sk = ERR_PTR(err);
> +		goto done;
>  	}
> +
> +	goto again;
>  done:
> -	return iter->batch[0];
> +	if (lock)
> +		spin_unlock_bh(lock);
> +	return sk;
>  }
>  

