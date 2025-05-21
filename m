Return-Path: <bpf+bounces-58697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C37AC0045
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 01:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81711725AD
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 22:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEE523A9BD;
	Wed, 21 May 2025 22:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LWebdm15"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B27323A99D;
	Wed, 21 May 2025 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747868315; cv=none; b=ItmAZQeu/tH2evDHd6nl4q7XJq15TzBYf9qG9uxXA9exRsNhDriBUDv3GsWh5Wvpmr335E7iojNXcEJqwrp1YnoNUEQfqMP2BdDYXu6CzWH2b0ADOMhp9K/c7ohKJhNvlcxpdaOciH3ZqcU0/f9Mg5oZAVuwLTCbtQHGBBFa1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747868315; c=relaxed/simple;
	bh=oUEfpUxJVtcfBRUWircRD/3AMoAwlb/YCvFi9VbaK40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWWnaR7uH/GTOznHTkaVePtr5TvvugOGOTaK67MBzIVs6m8cokEFI+uCKrr/zG3lQ7QzpVWuHAf6/UC2gVerFiVu1d9EJycIZznXbMwVHKw+Z4FFKIAm+0zBiIuqWny0pbpCWo7F3pRvZq1CkW20+UB7QvNdo1nAKz5pHWsebRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LWebdm15; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747868314; x=1779404314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VLNQaO0joSFtaVP4xhVmyHesQI7WXFOgxK3mfwvHk0I=;
  b=LWebdm15W/QTHc6I1ZTYdYVUy50+2USCPGpqL7LnjvzMB9L+BA+ulLkU
   CRzw2EsbDG6Ie2bllLe1XW3fqbjmyvnKMCg9IYaqqgf/C9kz+E9Al27du
   QaIhd8ZXuwDFrLfO+NLXeTYsNBEZOYKGqibbEMeqocDQUmJ9bSAryGP5W
   ff8eHKiGMeR5zTUOcWp9MES4sSnOxSHLrGOTU70SW5LU0H9tAy+7nfo4l
   M/Evz/e7XPm/1buvTWIKgEJXFMORrshe5PQviyIF/EhwtYiSqE7Xksj2R
   dfwYqJr4QDCySEidqsBBSZrIwqVDjrJPpiNe2Inm3IXhIneB4smVib49/
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,304,1739836800"; 
   d="scan'208";a="494871501"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 22:58:14 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:50996]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.117:2525] with esmtp (Farcaster)
 id 17ebefff-4e5a-46fb-818f-0bdaf37eacd3; Wed, 21 May 2025 22:58:12 +0000 (UTC)
X-Farcaster-Flow-ID: 17ebefff-4e5a-46fb-818f-0bdaf37eacd3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 22:58:12 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.52.104) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 22:58:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jordan@jrife.io>
CC: <alexei.starovoitov@gmail.com>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <kuniyu@amazon.com>, <martin.lau@linux.dev>,
	<netdev@vger.kernel.org>, <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v1 bpf-next 03/10] bpf: tcp: Get rid of st_bucket_done
Date: Wed, 21 May 2025 15:57:59 -0700
Message-ID: <20250521225800.89218-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520145059.1773738-4-jordan@jrife.io>
References: <20250520145059.1773738-4-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jordan Rife <jordan@jrife.io>
Date: Tue, 20 May 2025 07:50:50 -0700
> Get rid of the st_bucket_done field to simplify TCP iterator state and
> logic. Before, st_bucket_done could be false if bpf_iter_tcp_batch
> returned a partial batch; however, with the last patch ("bpf: tcp: Make
> sure iter->batch always contains a full bucket snapshot"),
> st_bucket_done == true is equivalent to iter->cur_sk == iter->end_sk.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> ---
>  net/ipv4/tcp_ipv4.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 27022018194a..20730723a02c 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3020,7 +3020,6 @@ struct bpf_tcp_iter_state {
>  	unsigned int end_sk;
>  	unsigned int max_sk;
>  	struct sock **batch;
> -	bool st_bucket_done;
>  };
>  
>  struct bpf_iter__tcp {
> @@ -3043,8 +3042,10 @@ static int tcp_prog_seq_show(struct bpf_prog *prog, struct bpf_iter_meta *meta,
>  
>  static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
>  {
> -	while (iter->cur_sk < iter->end_sk)
> -		sock_gen_put(iter->batch[iter->cur_sk++]);
> +	unsigned int cur_sk = iter->cur_sk;
> +
> +	while (cur_sk < iter->end_sk)
> +		sock_gen_put(iter->batch[cur_sk++]);

Why is this chunk included in this patch ?

This is a bit confusing given bpf_iter_tcp_seq_next() proceeds
iter->cur_sk during sock_gen_put().

Otherwise looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

