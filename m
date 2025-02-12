Return-Path: <bpf+bounces-51260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1DBA329F7
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550AC18899CF
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0571D21170B;
	Wed, 12 Feb 2025 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0Hm0RQU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174061F94D;
	Wed, 12 Feb 2025 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374007; cv=none; b=e6q7ic/braa7syzfXve2QPzlJ7BQLerPQZE6+QdYyObOmrJOSV63Y2nFVbgvozoSSY9mzXYsgg3Nudx/A+twAd1f3svaTbxiJRFHDzNtaw8mPIERzmi1KZBA0NMJGf+WOS8LLb4rrgJsqcgWtCmwJ27RYqZsNctxuwzIjU865So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374007; c=relaxed/simple;
	bh=M4e9amgPQ1W/sWhKkAPkZ0yFUw7/Xhj2SLcMw8OO2EA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lB8MEpsgbfY0023aSZCXWSnKpaH3UzakPCB4nz1KY2xG77Va3/S64F6NXXvceVm8APyL41vdz9SLh+eDSiRXIGZ0/ngPUZJDKw7Ra4gq0o+7XVTt2lNyCeyIfMxpCToMQ9/mlbDjIhTmKF7qRCUC52OmUNqcd4klrybmgXCmqp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0Hm0RQU; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c07838973eso28732885a.2;
        Wed, 12 Feb 2025 07:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739374005; x=1739978805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCLu9GAMtbQiKlN6q6l0PfI8pPaYZShBaxcFQFACjL8=;
        b=K0Hm0RQUNy39/RzdwqG8oF9D0fdnUledgriLAn6X5Ngm3arAsWibGLp6SpU47H5aHv
         eXhs+DEii19EBWWGI8NOIf8L2sScN6rpRov8AeFaUxSwTO8fPDRA2Vn4RNMMXzdy58f5
         NEQGPiFU4kwSmYfj9P8Ro+4a0/cLoE8H7TKhzGaWQ69Qc5w6hzC7RDyFQLDU2QswR1vX
         J82Ul8bP1oTOUg7DFnpn9ZicjG4lb2zpqyaSTR8hMuxd2f+gefB3x7TbLsAcn6uBTjRY
         YPGOlMAlnvDEDgjD/CDsgBUd+aN1ZnNH7j0EwhZAHvPGX5mzRmGsdnS45Too5MX4HXpq
         MAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374005; x=1739978805;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xCLu9GAMtbQiKlN6q6l0PfI8pPaYZShBaxcFQFACjL8=;
        b=u2t06PUuloU4GTQniWkTCG07LHMJxYoqEoXAdF8sKLWGrrxmGUG/JouVr8DnyGnbXQ
         +lhqw25tqi96TM4W51WauF9LxWLGl8FOE2TrW9fosvzFh+wTvE5r9RiSGjYFgL4Q6yRe
         s6jHNVCf6vCm+mSv4NmwpLXq5m9CuWcGyv3S8PCZQpTMSIus06cN/+Q7uFA6+nS29VkH
         eU+y8hNza4GJf5B6o5LoZtmjH0jRsxLUiSWAB7YDxJvhBlqLuc+SUpcmhVJyRhTFaLlI
         Q8+FLW4+iR1YmPJlULN8PwlA8nw4W9MFV2ODpdkQu+CXjyACMs8uWtAO76l4dZE/q3ku
         AeiA==
X-Forwarded-Encrypted: i=1; AJvYcCWoms1P53vQj29D6RXTMsnQPdYD+BLJk3nfGkKBTuQajdS47/Br88CxtTr80o10sD0SRdo3y6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtAbzCnYiixebMo1SOLLQTUed0YFQVebK7y0Iisk7LDvxC7UaD
	4JYDr/LYxbGheiOuETGbUAVL/1vdohFPCEupT5AnlppvS5071dGy
X-Gm-Gg: ASbGnctWhnsk/gOKQatHPsQ/9j0ez7hFANPd9PU6l6qFBw9iKcq9CLjg6w8bfWqyw2e
	br5XgtRhbVXEfgZPDNNbUfk8byU6Cb7Y4gjnEFYf1pqBZiq6a3/hiWxmFMgaXi4oL+M/9gNcONU
	kpyWOS+Nqro17dDtBxm3jdsSyux1JOP/2vYmpxLl74IRI06/hPHo2Y3Bzozou7F2gjILOUKq8Mw
	BOYDXE1qP3JZ3krXdmcxxFIwj4s/TqedtIciERKRFZ9hSnBNPxe0MHRXboq162BgtVN3cMjkgIc
	BBZr/Kd9URO5712Rjk9yeB9geCq86Eod4kVEz88t28QLrg5qY22o7se4uZtMYkE=
X-Google-Smtp-Source: AGHT+IFkU8Bz2798y0aHdxqnzqu2SZGMIiFES+HmmeNthHQ32yHFP3w9yj6QlCn0Kiq03nnP0SNizg==
X-Received: by 2002:a05:620a:2b86:b0:7b7:106a:19b7 with SMTP id af79cd13be357-7c06fc69b23mr566963785a.18.1739374004995;
        Wed, 12 Feb 2025 07:26:44 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07017dc9asm161482185a.83.2025.02.12.07.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 07:26:44 -0800 (PST)
Date: Wed, 12 Feb 2025 10:26:43 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67acbdb3be6b5_1bcd3029470@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250212061855.71154-10-kerneljasonxing@gmail.com>
References: <20250212061855.71154-1-kerneljasonxing@gmail.com>
 <20250212061855.71154-10-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v10 09/12] bpf: add BPF_SOCK_OPS_TS_ACK_OPT_CB
 callback
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> Support the ACK case for bpf timestamping.
> 
> Add a new sock_ops callback, BPF_SOCK_OPS_TS_ACK_OPT_CB. This
> callback will occur at the same timestamping point as the user
> space's SCM_TSTAMP_ACK. The BPF program can use it to get the
> same SCM_TSTAMP_ACK timestamp without modifying the user-space
> application.
> 
> This patch extends txstamp_ack to two bits: 1 stands for
> SO_TIMESTAMPING mode, 2 bpf extension.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  include/net/tcp.h              | 6 ++++--
>  include/uapi/linux/bpf.h       | 5 +++++
>  net/core/skbuff.c              | 5 ++++-
>  net/dsa/user.c                 | 2 +-
>  net/ipv4/tcp.c                 | 2 +-
>  net/socket.c                   | 2 +-
>  tools/include/uapi/linux/bpf.h | 5 +++++
>  7 files changed, 21 insertions(+), 6 deletions(-)

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 0d704bda6c41..aa080f7ccea4 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -488,7 +488,7 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
>  
>  		sock_tx_timestamp(sk, sockc, &shinfo->tx_flags);
>  		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
> -			tcb->txstamp_ack = 1;
> +			tcb->txstamp_ack = TSTAMP_ACK_SK;

Similar to the BPF code, should this by |= TSTAMP_ACK_SK?

Does not matter in practice if the BPF setter can never precede this.

