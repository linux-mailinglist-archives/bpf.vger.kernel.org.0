Return-Path: <bpf+bounces-8973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134D378D3CF
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 10:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177D51C203B1
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 08:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2816A1C03;
	Wed, 30 Aug 2023 08:03:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45A11852;
	Wed, 30 Aug 2023 08:03:57 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42EEF4;
	Wed, 30 Aug 2023 01:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=A+GgYw2ISBnq/T2kZKPOnAgFBtUV9rTOB6eIzHCozeg=; b=IMPN6esr9IF69d0bk8BM8rwVqF
	ndW6PsH7X34zuM0nWKM0GqNiyvIVlRNcVprZPdHpFRlK//4L30T5JKeUGfar8honMjc480+sBf0dF
	Oj2BM+bz2/JUqAhXuOmWpquR1CXN8jrYC3O2gS6YV/19ygK1e/z2lk6virzVlY44w1gZrND6nz4yw
	hvwoOcNRYGMLjvpTuR1Dr48Z0q/5CqIShjBijeFiiN5vJ4ekWkSUFRiAACgdlBbjGfPka6zad8YJo
	yh0/8uH5NxmfZ47mmUv/mib5YTA3K0ZvJq6C9837C9GJbF7RtYy6qcZC/fNyzUGncLtYOYNeZb3LF
	kugGZTWQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbGB6-0005wG-5x; Wed, 30 Aug 2023 10:03:52 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbGB6-0000EE-9Q; Wed, 30 Aug 2023 10:03:52 +0200
Subject: Re: [PATCH bpf] bpf: sockmap, fix preempt_rt splat when using
 raw_spin_lock_t
To: John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, netdev@vger.kernel.org
References: <20230830053517.166611-1-john.fastabend@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d3b0b23f-4cdf-75a6-2781-a618fe65fcec@iogearbox.net>
Date: Wed, 30 Aug 2023 10:03:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230830053517.166611-1-john.fastabend@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27015/Tue Aug 29 09:39:45 2023)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/30/23 7:35 AM, John Fastabend wrote:
[...]
>   net/core/sock_map.c | 36 ++++++++++++++++++------------------
>   1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 8f07fea39d9e..cb11750b1df5 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -18,7 +18,7 @@ struct bpf_stab {
>   	struct bpf_map map;
>   	struct sock **sks;
>   	struct sk_psock_progs progs;
> -	raw_spinlock_t lock;
> +	spinlock_t lock;
>   };

Looks good to me, and I agree that it's better to take this direction rather
than converting both to raw_spinlock_t if there is no good reason for it.
Thanks for looking into it, applied!

