Return-Path: <bpf+bounces-22391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264BA85D2C6
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 09:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5EF82857E4
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 08:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640793CF44;
	Wed, 21 Feb 2024 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NtQq/3C6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA753A8EF
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505142; cv=none; b=ApIb5I9MkCQMfBmBcvFEKpvdTjpQPMIScFEQXOgsxIkJRr89zOVo8iLG4LwIN16DveeabBMq8bASUOGKrBKyi9o87hpPUkzTq3iywDFZQjGmEYpLTzkFVlFsPMUiK8tKx8wF3+6znQ9hIzt576k65FP+gigf817E45/24vomIrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505142; c=relaxed/simple;
	bh=MV7cCDhFf7qoSlKGh26KdQdQQeeDgNXi5QmZqdulyTo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=NkjR2QB1OxI2tB12oOXlF+0UV4BRSrkTZz2bT6y1isrCqIibGjR+hjk6kamaF162w5ecNhimsLwbH9tcVCeIEzwF24sz4ja/VIDlJTgYLlUpJl2ShebpUXqjEPnoXQB/OQ34ah7c+HeGVPL/Zi1yZt+1BuKHxBEInEUtSbITrQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NtQq/3C6; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a36126ee41eso845953166b.2
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 00:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1708505138; x=1709109938; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=kZQ4OFhsxkDYgnz61RE7tAY18/3VcWGx+gq9WX1pJrw=;
        b=NtQq/3C6wLMRimvVMUBFuVsnz3LCYR0G3iNxhh/PW7OaevP+NarximxmQfN471VuHa
         HVMZKJ6CYvMmhmKQ22gsjbYj9mx2tJUuCkJcaCHiqLK0zD8M7WmgLYqH/ehzllq90juv
         i/lQ3/0tDQMDhSWd1T7b0LLBOr9LS15lrBLzJ+ZKI7lQ56ZeI2Br+e6hoKMyrtHCUcUr
         U+dv+UCxWxzJsK5vo8tW146Qaky01vcpVATM8Y0S/TKvPR3CWx6z29ANfGvnwBOuBJg5
         hxPa9Fqp1EPMIwhPJ7pIkTZ7Ar6TK2viNH30jdSbfTNcX/cxlO0snu5qi/WsrLhOPgAN
         LnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708505138; x=1709109938;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZQ4OFhsxkDYgnz61RE7tAY18/3VcWGx+gq9WX1pJrw=;
        b=lIBs24LxJFgYdZzNoruyxFt2Ow245C1znqvuHvfCyu52XvMMmINxqAjUF13oMOafh8
         Z2y+jRm15jA1v1bNIHM+soMfr8gHTJMBfbI4u7lPTzja2uVf7s8wTtIHBhRahQdHMRlw
         2SuiyY8CeIw/n8X7ohCxts7Nz+jSCOUR2i+Nl+KAe1UJYO/NURALi2IE/fhT7ysuSnrL
         t/pWdnoN6yYg+EQF8hw9uSJ8XyfNuPJnmjWyb/PT3cHMBT4sLIvjneO0rl+dwTQv7DY6
         yTgJVyg+jgVqTepBRGHc9icRzUD7UR1q2Q2Tos54m0HlgodVaPxndJaK5RO/FdJk0pC6
         l1Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUJYzd924OHtVe2iD7OKXi9lvjz+Zwoz3WE6x82Lqhjt6/Mlz1GttBBceAi8prIEScuiVPmlO3HtRlVPSZ+SueR0YAx
X-Gm-Message-State: AOJu0Ywxpco70qW/KDaIiAaV9exXUavd9bse2dZWKXvklXnPEvcTl050
	e9wFsGiVuhJnLXzewWM/dn6rWLnlkpLYT+AJnwn7Cc7RZ0ZiWn4KzydfXUw2VHTiIGw156f9qBQ
	gOg0=
X-Google-Smtp-Source: AGHT+IEDaGKj6QcO81XW7tgCoQbWz+vDwzVQKdeoeHwxTbJSHX/2OJ8SZ7AO4OOsy2cb+xQgBAVwUQ==
X-Received: by 2002:a17:906:81d3:b0:a3e:c9f5:fbaa with SMTP id e19-20020a17090681d300b00a3ec9f5fbaamr5107340ejx.68.1708505138617;
        Wed, 21 Feb 2024 00:45:38 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:d4])
        by smtp.gmail.com with ESMTPSA id bh5-20020a170906a0c500b00a3ea6b5e4eesm2660862ejb.19.2024.02.21.00.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 00:45:38 -0800 (PST)
References: <20240115220803.1973440-1-vadfed@meta.com>
 <20240115220803.1973440-3-vadfed@meta.com>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski
 <kuba@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Andrii
 Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Mykola
 Lysenko <mykolal@fb.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org, linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
 Victor Stewart <v@nametag.social>
Subject: Re: [PATCH bpf-next v8 3/3] selftests: bpf: crypto skcipher algo
 selftests
Date: Wed, 21 Feb 2024 09:43:46 +0100
In-reply-to: <20240115220803.1973440-3-vadfed@meta.com>
Message-ID: <87frxmmci7.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jan 15, 2024 at 02:08 PM -08, Vadim Fedorenko wrote:
> Add simple tc hook selftests to show the way to work with new crypto
> BPF API. Some tricky dynptr initialization is used to provide empty iv
> dynptr. Simple AES-ECB algo is used to demonstrate encryption and
> decryption of fixed size buffers.
>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
> new file mode 100644
> index 000000000000..70bde9640651
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
> @@ -0,0 +1,217 @@

[...]

> +static void deinit_afalg(void)
> +{
> +	if (tfmfd)
> +		close(tfmfd);
> +	if (opfd)
> +		close(opfd);
> +}

Did you mean tfmfd/opfd != -1?

[...]

