Return-Path: <bpf+bounces-34904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DFF932284
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 11:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5225282D93
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 09:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68040195B35;
	Tue, 16 Jul 2024 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gNbGjPBj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7B24C74
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121149; cv=none; b=PHxi0dyKQ1vEpxtK6GfBFxfHDk3ESAOvIBBtXmDmf/zO9SZ6kCo7MJZkK22TWzvLnGrXNt2IFhaxUOBUjpjpMLjkt16+HcD0MMpOKhtO977OcywGUY2PAl7u4RkXajfOfpsEojgtjvLs+K2dBMih0z6k4nGWxpE+0ubsAeFo6xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121149; c=relaxed/simple;
	bh=bdNTsPa56H4Y3+1JvLEW+RDgfr1mI6TM0xjQ77VEyF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YSJTamYltHigTBwDOR+mhEsU3IVTlwsVdvWs9aWYCmwQFMV2vyl9ZLuE52QzJyted6oXVQz3z5Bc4xbbG+qNGXa3s8QWz0SptG5jOwiPnWpdAn287LXCiPwVgG9w7aY1txQSasokLpjKmySlyU+5iWRMroOSqC5lJMFIaXzo9WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gNbGjPBj; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58be2b8b6b2so6535948a12.3
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 02:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1721121147; x=1721725947; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FedBIMDaA1sTH5MhWwCbSI1/5+TUuGmgOcQ/Plh/m2c=;
        b=gNbGjPBj5ZasPLpOworOx5S0uqLN8u8NAZ+YZSlwE9wt7JmBOASNrvu0weRW/oqNFe
         rkQKT8q506XsQvYgsSAR/9kPhSgbezxTemjPCerTRQUhQc1CidVUbXHMflsOxHoCIucA
         JCKDIlHskm5929WlGOcomSVQ4vCtAb/d6IVVBAL0RrPPl+OvR3v2LGTQMsQLmOQ7JQHl
         BuSgfPi4HDWZvTO6cIL2IbkAx02TfWNrJH4aDOpQ/AAQUYSnfDbKDZ+pBqd71mRovUWk
         cuyGaQTaXmO9IcapV8axXIkzNwsPRrX+lEmRKXvXBiN3PriN46z7+8nsI1O1yI+ppbFB
         h6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721121147; x=1721725947;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FedBIMDaA1sTH5MhWwCbSI1/5+TUuGmgOcQ/Plh/m2c=;
        b=IvqT+TqjeY9QlQvofShe1hNIlJDUfb5d973X8p/v37bvSNAXYdO+EsD9TGIYRMBiM2
         RBlJGcrKWIBf0kL0kPwCDhJADGOsnbm1fLB6Tes4BDzlJUEkqqf/SF/qkmevXlod33gx
         gU03Cjj97siFRBug9hh9wxQoRWLJCS8SHOfwh7ecdoC68dzpIEQsDKXBBFx4+NJKAW1T
         HIYALYKvRyzkeI/8+8Nt2JwEk1Tvb5ZrqpTaRhaTThQX0mOP9ziKlLuS5Vruvjoq6RxX
         KD729vGcu4U2l8VwKK5UxgFH/Civv1aiJaVjNMunSNLHkbGOwSlAOlGh+RVN+q46uVvK
         GuLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoCYi/GQ4zHtMS9mWHeOJ0ymRGE7E3gXnFpbpCa8EnUrrltKOzXiMWuyzM4ygHLCtz/xX63CGIS4api11ndpMjMmYc
X-Gm-Message-State: AOJu0Yx14kVwvZiw/+KsMS2hc/3kyCLAC1rHxXJBCE2k8c6nXWkqqnAZ
	zAbXyZmHQ+hXsLn+cMhFqxfBQeuxgLRKdIDHj5B+VG4do9ADSkC/fSbDbcPOnRA=
X-Google-Smtp-Source: AGHT+IE2T94Ov/B806jOrh+DU4AP6OW/qY07jvLjggZjzCqLGEZhm3n4pH6Kzl1B2Fz1citJkJqpqg==
X-Received: by 2002:a17:906:488:b0:a72:5bb9:b140 with SMTP id a640c23a62f3a-a79eaa73fc1mr103715966b.54.1721121146648;
        Tue, 16 Jul 2024 02:12:26 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a390dsm283579366b.41.2024.07.16.02.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 02:12:25 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  john.fastabend@gmail.com,  kuniyu@amazon.com,  Rao.Shoaib@oracle.com,
  cong.wang@bytedance.com
Subject: Re: [PATCH bpf v4 0/4] af_unix: MSG_OOB handling fix & selftest
In-Reply-To: <20240713200218.2140950-1-mhal@rbox.co> (Michal Luczaj's message
	of "Sat, 13 Jul 2024 21:41:37 +0200")
References: <20240713200218.2140950-1-mhal@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 16 Jul 2024 11:12:24 +0200
Message-ID: <877cdl8zuv.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jul 13, 2024 at 09:41 PM +02, Michal Luczaj wrote:
> PATCH 1/4 tells BPF redirect to silently drop AF_UNIX's MSG_OOB. The rest
> is selftest-related.
>
> Michal Luczaj (4):
>   af_unix: Disable MSG_OOB handling for sockets in sockmap/sockhash
>   selftest/bpf: Support SOCK_STREAM in unix_inet_redir_to_connected()
>   selftest/bpf: Parametrize AF_UNIX redir functions to accept send()
>     flags
>   selftest/bpf: Test sockmap redirect for AF_UNIX MSG_OOB
>
>  net/unix/af_unix.c                            | 41 ++++++++-
>  net/unix/unix_bpf.c                           |  3 +
>  .../selftests/bpf/prog_tests/sockmap_listen.c | 85 +++++++++++++------
>  3 files changed, 102 insertions(+), 27 deletions(-)

Thanks for taking time to extend the tests.

Tested-by: Jakub Sitnicki <jakub@cloudflare.com>

