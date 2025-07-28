Return-Path: <bpf+bounces-64553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DEDB1420B
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 20:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27F718C0C10
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 18:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AD5274FEE;
	Mon, 28 Jul 2025 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhOsPQIq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299F84A11;
	Mon, 28 Jul 2025 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753727740; cv=none; b=OpQTN4B/+0+wRwLybqfchjVRDkDna7KGNmQdHZDWr35fT5ry6yNVVkx7La4xuQXoeH1B/KPgFJn8z4kJeMOWZtRK6W5wxcVPwHbkemGePGQR8V5/F7TstYJhjsa6fxyFxrCoF039ELYl+ZrZv3ePcrWZRGGEVmAnPAPSvWMd8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753727740; c=relaxed/simple;
	bh=MvMjX+N/9Bpj0G7UWl4UtsPuVtDv2i0dpYKJH2tfm7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFXbokNWXUYJ6XbIRwW5FoAG+tp3a1kgSE31rgOjSMXNUDShoDzfqzveVyBrf+RCAkw6gy21ED7W2rFFYRjRCJSC9o66YFiy4+KRxI2y/cf+AA8Uumnsh6vKM5ygFeDhcmSXLC1lPRPEtgJc6HFN1/WZzpjMA2A2UYxNdE/yDVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhOsPQIq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aec5a714ae9so686112966b.3;
        Mon, 28 Jul 2025 11:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753727736; x=1754332536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=78uPmEmg1jJUm+vcAxFvheQL2RNbyr9u5uHfG0T4KU0=;
        b=LhOsPQIqQfUAtRMm9phQO+s2ZhOOmVMoviiW/1FBcqTzRK6yNmPmG39ZZi+wyrU6rR
         YZ6cpklAl8IAeawcJARctHZY9Th/k0nvmw2sB6RGOwQ1359M16RFHwHmAu1dekeJiqVU
         Dz3KqgDbWRqY2Y0cit56jtBmBBfOjQJd3QX+0Y4zuNjG8ollKpAZ8tiGuV6aogx44CmE
         FINsFArkwGTqzv8p6RZ8vg38UzEItfyOSh9NDicly3c0VDpe03u9/xapDmXuw2qQAr98
         rsjugMxIzH2W7bRm5RHEmIw5bqpAajqToibqEhW1xqmWWYjHMwrLkc6zNnaWJC0ZgB+T
         rSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753727736; x=1754332536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78uPmEmg1jJUm+vcAxFvheQL2RNbyr9u5uHfG0T4KU0=;
        b=bGbvjAsBPKlZ/LHPdFPDTAdDxFuiq0+Q7FcGDEAFB3qUclYEbaFFtmIqn0muUp4K+7
         CdWUH6DXnl2dtRHscrMykCuLnACY0tknk2CnobavfENMHtEBF87EjO1d31UTNiHBPoxD
         QqKwLv9l+42Uy70SGWtXF+Gpzxlc/gQ8Qq+EQUfkUY+IAXRHwmi7JNmxXHd6HHPv74sy
         J9lHTTiEFXke6eukn/dhY2lMpRzwINXDfB2Ic+dNvy3thuedjJWLKiMjN3thnRwurS2H
         rKglcAhTWpYCn6FdFHn1szqZORe1wLYbmRnA5KMP7GW1URwkjd2N8Dlwa0Irw8EHlKwv
         zUYg==
X-Forwarded-Encrypted: i=1; AJvYcCU03/OfL06PeYeZA77iELaRTJos4KakX1l1m5ml3/C/lUYxqnv71KMrP1i2y3Do3RjlLTM=@vger.kernel.org, AJvYcCW6o9Cuh+GOtV8Bt7awkg1GFEMFf5ApfO6q2fiRNCuh6Lz7me+R9gBDgivnaud1BDr38rAjUEfIuPVSHw==@vger.kernel.org, AJvYcCWWWQDxRaNoelLa2Ca+AxjbFXqLaOHXURAHfF9uCgMyX7TzArbS8lxcfJo0AlmvjXEfXXExsPLU@vger.kernel.org
X-Gm-Message-State: AOJu0YwzuikDlQAhJozqNkxjptuCq+AWVW4cnpJUGs4Gq4B/9o6U2h01
	SnhSrbnnaH2tB6JWv1RBvaYadJGFqcI0V8ACmg6Ru82E5jZ56bFm5GaG
X-Gm-Gg: ASbGncumdsj6pF9dyTU+Mb9h9cTfsS3yYD7Dy1io5jcu6YSp5UzauKEMmD0ia1dqEuL
	sOb8F1gM2/bA4SqkVRe8FgYMaPBN5XC5k3HH/pk2qaF7BbLU3yZ2rqjiclYLQimayVCjHXJ14gS
	ZfLSYwoWzbP1ECNw8H/sG/RELntFhGaMNQ9qC/l+zKmpiWPfNdWMG0Q3vgpb8UKUgn09I1NVzM7
	0lJX98dvaok6ybek0ArK27cYZl0jcGTiPAs9nposZbHAsdjCJSQh4TeKdYxU0Y0llsz5rdufXh5
	VtD5fcaFOPDOJDmccb0HG8044X4aA/f9r3BDl0Rcm96DgGaQ/mtHojSkCuyBYWWfX7mEcNJ39IS
	R5fdinMPbQ2SOmegruEK3/Wpj3mwZsg8=
X-Google-Smtp-Source: AGHT+IFgxhpFnrUM7/Tj+j4V+oCATiKKeV1GCz2P0yLgvuPSqvqeNh/T3kaG38PILpE4Urdvmq1apg==
X-Received: by 2002:a17:906:4fd6:b0:ae0:d804:5bca with SMTP id a640c23a62f3a-af61ca9ed34mr1318179566b.17.1753727736013;
        Mon, 28 Jul 2025 11:35:36 -0700 (PDT)
Received: from [192.168.8.100] ([185.69.144.164])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61500addc6asm3584548a12.53.2025.07.28.11.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 11:35:35 -0700 (PDT)
Message-ID: <fc1ed731-33f8-4754-949f-2c7e3ed76c7b@gmail.com>
Date: Mon, 28 Jul 2025 19:36:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm, page_pool: introduce a new page type for page pool
 in page type
To: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
 brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20250728052742.81294-1-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250728052742.81294-1-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/28/25 06:27, Byungchul Park wrote:
> Changes from v1:
> 	1. Rebase on linux-next.

net-next is closed, looks like until August 11.

> 	2. Initialize net_iov->pp = NULL when allocating net_iov in
> 	   net_devmem_bind_dmabuf() and io_zcrx_create_area().
> 	3. Use ->pp for net_iov to identify if it's pp rather than
> 	   always consider net_iov as pp.
> 	4. Add Suggested-by: David Hildenbrand <david@redhat.com>.

Oops, looks you killed my suggested-by tag now. Since it's still
pretty much my diff spliced with David's suggestions, maybe
Co-developed-by sounds more appropriate. Even more so goes for
the second patch getting rid of __netmem_clear_lsb().

Looks fine, just one comment below.

...> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> index 100b75ab1e64..34634552cf74 100644
> --- a/io_uring/zcrx.c
> +++ b/io_uring/zcrx.c
> @@ -444,6 +444,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
>   		area->freelist[i] = i;
>   		atomic_set(&area->user_refs[i], 0);
>   		niov->type = NET_IOV_IOURING;
> +		niov->pp = NULL;

It's zero initialised, you don't need it.

And a friendly reminder, please never send patches modifying a
subsystem without CC'ing it, especially kept in another tree.
Sure, you CC'ed me, but it's easy to lose.

-- 
Pavel Begunkov


